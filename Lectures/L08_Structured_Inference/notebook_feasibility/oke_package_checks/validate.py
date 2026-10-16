"""Author-only checks of pinned source methods against a dense Gaussian oracle.

No package installation or full Darts/nfoursid import. Exact __init__/step bodies
are compiled from the upstream source snapshot with minimal shape/output fixtures.
The candidate differs only by zeroing both gains when y is absent. The independent
oracle builds one joint Gaussian from independent initial/noise blocks and then
conditions on all actually observed measurements by a dense linear solve.
"""
from __future__ import annotations

import ast
import copy
import difflib
import hashlib
import importlib
import importlib.metadata
import json
from pathlib import Path
import sys
from typing import Optional

import numpy as np

HERE = Path(__file__).resolve().parent
TOL = 2e-12


class StateSpaceFixture:
    """Only shapes and output mapping used by the two extracted source methods."""

    def __init__(self, a, b, c, d):
        self.a, self.b, self.c, self.d = [np.asarray(x, dtype=float) for x in (a, b, c, d)]
        self.x_dim, self.y_dim, self.u_dim = self.a.shape[0], self.c.shape[0], self.b.shape[1]

    def output(self, x, u=None):
        if u is None:
            u = np.zeros((self.u_dim, 1))
        return self.c @ x + self.d @ u


class UtilsFixture:
    @staticmethod
    def validate_matrix_shape(value, shape, name):
        if value.shape != shape:
            raise ValueError(f"{name}: {value.shape} != {shape}")


def extract_class(source):
    tree = ast.parse(source)
    node = next(n for n in tree.body if isinstance(n, ast.ClassDef) and n.name == "Kalman")
    node = copy.deepcopy(node)
    node.body = [n for n in node.body if isinstance(n, ast.FunctionDef) and n.name in {"__init__", "step"}]
    assert {n.name for n in node.body} == {"__init__", "step"}
    module = ast.fix_missing_locations(ast.Module(body=[node], type_ignores=[]))
    namespace = {"np": np, "Optional": Optional, "StateSpace": StateSpaceFixture, "Utils": UtilsFixture}
    exec(compile(module, "<pinned source __init__/step only>", "exec"), namespace)
    return namespace["Kalman"]


def candidate_source(source):
    # Minimal source-preserving correction: the source already suppresses mean
    # conditioning for absent y, so suppress its covariance conditioning as well.
    for gain, anchor in [("k_filtered", "        self.p_filtereds.append(\n"),
                         ("k_pred", "        self.p_predicteds.append(\n")]:
        assert source.count(anchor) == 1
        insertion = f"        if y is None:\n            {gain} = np.zeros_like({gain})\n\n"
        source = source.replace(anchor, insertion + anchor)
    return source


def primitive_joint(model, noise, controls):
    """Construct x_t/y_t as linear maps of x_0 and independent (v_t,w_t) pairs.

    No filtering recurrences or gains appear in this oracle. The noise cross
    covariance is present in every joint primitive block, including missing times.
    """
    a, b, c, d = model.a, model.b, model.c, model.d
    nx, ny, steps = model.x_dim, model.y_dim, len(controls)
    size = nx + steps * (ny + nx)
    covariance = np.zeros((size, size))
    covariance[:nx, :nx] = np.eye(nx)  # upstream's actual initial covariance
    x_load = np.zeros((nx, size))
    x_load[:, :nx] = np.eye(nx)
    x_mean = np.zeros((nx, 1))
    xs, ys = [], []
    for t, u in enumerate(controls):
        offset = nx + t * (ny + nx)
        covariance[offset:offset+ny+nx, offset:offset+ny+nx] = noise
        xs.append((x_load.copy(), x_mean.copy()))
        y_load = c @ x_load
        y_load[:, offset:offset+ny] += np.eye(ny)
        ys.append((y_load, c @ x_mean + d @ u))
        x_load = a @ x_load
        x_load[:, offset+ny:offset+ny+nx] += np.eye(nx)
        x_mean = a @ x_mean + b @ u
    xs.append((x_load, x_mean))
    return covariance, xs, ys


def condition(target, covariance, y_maps, observations, indices):
    load, base = target
    target_cov = load @ covariance @ load.T
    if not indices:
        return base.copy(), target_cov
    observed_load = np.concatenate([y_maps[i][0] for i in indices], axis=0)
    observed_base = np.concatenate([y_maps[i][1] for i in indices], axis=0)
    actual = np.concatenate([observations[i] for i in indices], axis=0)
    observed_cov = observed_load @ covariance @ observed_load.T
    cross = load @ covariance @ observed_load.T
    mean = base + cross @ np.linalg.solve(observed_cov, actual-observed_base)
    cov = target_cov - cross @ np.linalg.solve(observed_cov, cross.T)
    return mean, (cov+cov.T)/2


def as_list(value):
    return np.asarray(value).tolist()


def check_case(name, model, noise, observations, controls, original_class, corrected_class):
    assert np.linalg.eigvalsh(noise).min() > -1e-13
    covariance, x_maps, y_maps = primitive_joint(model, noise, controls)
    original = original_class(model, noise)
    corrected = corrected_class(model, noise)
    observed = []
    rows = []
    errors = {"original": 0., "corrected": 0.}
    output_errors = {"original": 0., "corrected": 0.}
    for t, (value, u) in enumerate(zip(observations, controls)):
        prior_mean, prior_cov = condition(x_maps[t], covariance, y_maps, observations, observed)
        output_mean, output_cov = condition(y_maps[t], covariance, y_maps, observations, observed)
        if value is not None:
            observed.append(t)
        filtered_mean, filtered_cov = condition(x_maps[t], covariance, y_maps, observations, observed)
        next_mean, next_cov = condition(x_maps[t+1], covariance, y_maps, observations, observed)
        row = {"t": t, "observed": value is not None, "y": None if value is None else as_list(value),
               "u": as_list(u), "oracle_prior_mean": as_list(prior_mean),
               "oracle_prior_covariance": as_list(prior_cov),
               "oracle_filtered_mean": as_list(filtered_mean), "oracle_filtered_covariance": as_list(filtered_cov),
               "oracle_next_mean": as_list(next_mean), "oracle_next_covariance": as_list(next_cov)}
        for label, runner in [("original", original), ("corrected", corrected)]:
            runner.step(value, u)
            measured = [runner.x_filtereds[-1], runner.p_filtereds[-1],
                        runner.x_predicteds[-1], runner.p_predicteds[-1]]
            reference = [filtered_mean, filtered_cov, next_mean, next_cov]
            err = max(float(np.max(abs(x-y))) for x, y in zip(measured, reference))
            errors[label] = max(errors[label], err)
            row[label] = {"filtered_mean": as_list(measured[0]), "filtered_covariance": as_list(measured[1]),
                          "next_mean": as_list(measured[2]), "next_covariance": as_list(measured[3]),
                          "max_abs_error": err}
            if label == "corrected":
                assert np.linalg.eigvalsh(measured[1]).min() > -TOL
                assert np.linalg.eigvalsh(measured[3]).min() > -TOL
            if value is None:
                # Exact expression used by Darts for a missing-time marginal,
                # without calling Darts or generating empirical samples.
                mean = runner.y_filtereds[-1]
                cov = model.c @ runner.p_filtereds[-1] @ model.c.T + runner.r
                out_err = max(float(np.max(abs(mean-output_mean))), float(np.max(abs(cov-output_cov))))
                output_errors[label] = max(output_errors[label], out_err)
                row[label]["darts_expression_output_mean"] = as_list(mean)
                row[label]["darts_expression_output_covariance"] = as_list(cov)
                row[label]["output_moment_error"] = out_err
                row["oracle_output_mean"] = as_list(output_mean)
                row["oracle_output_covariance"] = as_list(output_cov)
        rows.append(row)
    assert errors["corrected"] < TOL, (name, errors)
    assert output_errors["corrected"] < TOL, (name, output_errors)
    if all(y is not None for y in observations):
        assert errors["original"] < TOL
        for attr in ["x_filtereds", "p_filtereds", "x_predicteds", "p_predicteds"]:
            assert np.array_equal(np.array(getattr(original, attr)), np.array(getattr(corrected, attr)))
    else:
        assert errors["original"] > 1e-3, (name, errors)
    return {"case": name, "A": as_list(model.a), "B": as_list(model.b), "C": as_list(model.c), "D": as_list(model.d),
            "noise_covariance_v_then_w": as_list(noise), "max_state_moment_error": errors,
            "max_missing_output_moment_error": output_errors,
            "observed_branch_bitwise_preserved": all(y is not None for y in observations), "steps": rows}


def main():
    manifest = json.loads((HERE/"source_manifest.json").read_text())
    for entry in manifest["sources"]:
        assert hashlib.sha256((HERE/entry["file"]).read_bytes()).hexdigest() == entry["sha256"]
    source = (HERE/"upstream/nfoursid_kalman.py").read_text()
    corrected_source = candidate_source(source)
    (HERE/"missing_observation.patch").write_text("".join(difflib.unified_diff(
        source.splitlines(True), corrected_source.splitlines(True),
        fromfile="nfoursid1.0.2/kalman.py", tofile="candidate/kalman.py")))
    original_class, corrected_class = extract_class(source), extract_class(corrected_source)
    scalar = StateSpaceFixture([[1.]], np.zeros((1, 0)), [[1.]], np.zeros((1, 0)))
    def scalar_values(v):
        return [None if x is None else np.array([[x]], dtype=float) for x in v]
    def no_controls(n):
        return [np.zeros((0, 1)) for _ in range(n)]
    cases = []
    for name, covariance, values in [
        ("scalar_single_missing", [[1., 0.], [0., 1.]], [None]),
        ("scalar_repeated_missing", [[1., 0.], [0., 1.]], [None]*6),
        ("scalar_observed_only", [[1., 0.], [0., 1.]], [.7, -.2, 1.3, .1, -.4]),
        ("scalar_observed_and_missing", [[1., 0.], [0., 1.]], [.7, None, None, -.2, None, .4]),
        ("scalar_correlated_observed_only", [[.7, .4], [.4, .3]], [.8, -.3, .4, 1.2]),
        ("scalar_correlated_mixed", [[.7, .4], [.4, .3]], [.8, None, -.3, None, None, .4]),
    ]:
        ys = scalar_values(values)
        cases.append(check_case(name, scalar, np.array(covariance), ys, no_controls(len(ys)), original_class, corrected_class))
    matrix = StateSpaceFixture([[.8, .25], [-.1, .7]], [[.2], [-.1]], [[1., -.4], [.2, .8]], [[.1], [-.05]])
    r = np.array([[.6, .1], [.1, .5]])
    q = np.array([[.25, .03], [.03, .2]])
    s = np.array([[.1, -.02], [.04, .08]])
    full_noise = np.block([[r, s.T], [s, q]])
    controls = [np.array([[u]]) for u in [.2, -.1, .0, .3, -.2, .1]]
    values = [np.array([[.8], [-.2]]), None, np.array([[-.35], [.5]]), None, None, np.array([[1.1], [.2]])]
    cases.append(check_case("matrix_correlated_mixed_with_controls", matrix, full_noise, values, controls, original_class, corrected_class))
    observed_values = [np.array([[x], [-.3*x]]) for x in [.8, -.35, .2, -.1, .4, 1.1]]
    cases.append(check_case("matrix_correlated_observed_only", matrix, full_noise, observed_values, controls, original_class, corrected_class))
    # Deliberate counterfactual: dropping learned S must NOT match the correlated
    # target, even though observed updates themselves use the familiar gain.
    joint_cov, x_maps, y_maps = primitive_joint(matrix, full_noise, controls)
    diagonal_noise = np.block([[r, np.zeros_like(s.T)], [np.zeros_like(s), q]])
    dropped = corrected_class(matrix, diagonal_noise)
    observed = []
    dropped_errors = []
    for t, (y, u) in enumerate(zip(observed_values, controls)):
        observed.append(t)
        dropped.step(y, u)
        expected_mean, expected_cov = condition(x_maps[t+1], joint_cov, y_maps, observed_values, observed)
        dropped_errors.append({"t": t, "next_mean_error": float(np.max(abs(dropped.x_predicteds[-1]-expected_mean))),
                               "next_covariance_error": float(np.max(abs(dropped.p_predicteds[-1]-expected_cov)))})
    assert max(r["next_mean_error"] for r in dropped_errors) > .01
    imports = {}
    for name in ["pandas", "darts", "nfoursid"]:
        try:
            importlib.import_module(name)
            imports[name] = "available"
        except ModuleNotFoundError as exc:
            imports[name] = repr(exc)
    summary = {"status": "PASS: bounded extracted-method checks, not full package execution",
               "python": sys.executable, "python_version": sys.version, "numpy_version": np.__version__,
               "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
               "tolerance": TOL, "case_count": len(cases),
               "max_corrected_state_moment_error": max(c["max_state_moment_error"]["corrected"] for c in cases),
               "max_corrected_missing_output_error": max(c["max_missing_output_moment_error"]["corrected"] for c in cases),
               "imports": imports, "full_package_execution": False, "environment_modified": False,
               "patch_extra_nonblank_lines": 4, "source_manifest": manifest,
               "cases": cases, "dropping_cross_covariance_counterfactual": dropped_errors}
    (HERE/"results.json").write_text(json.dumps(summary, indent=2)+"\n")
    print(json.dumps({k:summary[k] for k in ["status", "case_count", "max_corrected_state_moment_error",
                                             "max_corrected_missing_output_error", "imports"]}, indent=2))
    print("scalar missing original/corrected:", cases[0]["steps"][0]["original"], cases[0]["steps"][0]["corrected"])
    print("drop-S max next mean error:", max(r["next_mean_error"] for r in dropped_errors))


if __name__ == "__main__":
    main()
