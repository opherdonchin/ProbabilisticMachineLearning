"""Teacher-only geometry extension of the already checked binary-Iris target.

No refitting, data/feature/split search, new model, VI, MCMC or notebook. Run with
the locked course interpreter; writes only next to this file. Existing results
supply the fitted Gaussian and task-query errors. New integration evaluates
geometry, using separate box/mesh and smooth polar-ellipse checks.
"""
import hashlib
import importlib.util
import json
import platform
import sys
import time
from pathlib import Path

import numpy as np
import scipy
import sklearn
from scipy.special import expit, logsumexp
from scipy.stats import chi2

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
BASE = HERE.parent / "notebook_feasibility"
sys.dont_write_bytecode = True
spec = importlib.util.spec_from_file_location("frozen_l07", BASE / "classifier_probe.py")
old = importlib.util.module_from_spec(spec)
spec.loader.exec_module(old)


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def geometry(X, y, m, C, radius, step):
    """Trapezoid integration; chunk target evaluation to bound scratch memory."""
    axis = np.linspace(-radius, radius, round(2 * radius / step) + 1)
    a, b = np.meshgrid(axis, axis, indexing="ij")
    w = np.column_stack([a.ravel(), b.ravel()])
    logu = np.concatenate([-old.nll(v, X, y) for v in np.array_split(w, 128)])
    edge = np.ones(len(axis)); edge[[0, -1]] = .5
    volume = step**2 * np.outer(edge, edge).ravel()
    logZ = logsumexp(logu + np.log(volume))
    logp = logu - logZ
    mass = np.exp(logp) * volume
    H = np.linalg.inv(C)
    z = w - m
    logq = -np.log(2 * np.pi) - .5 * np.linalg.slogdet(C)[1] - .5 * np.sum((z @ H) * z, axis=1)
    mean = mass @ w
    centered = w - mean
    cov = centered.T @ (mass[:, None] * centered)
    sd = np.sqrt(np.diag(cov))
    skew = mass @ (centered / sd)**3
    excess = mass @ (centered / sd)**4 - 3
    # q mean and covariance define the whitening coordinates, not fitted moments.
    L = np.linalg.cholesky(C)
    white = np.linalg.solve(L, z.T).T
    result = dict(radius=radius, step=step, nodes=len(w), log_normalizer=float(logZ),
        mean=mean.tolist(), covariance=cov.tolist(), marginal_skewness=skew.tolist(),
        marginal_excess_kurtosis=excess.tolist(),
        laplace_whitened_mean=(mass @ white).tolist(),
        laplace_whitened_second_moment=(white.T @ (mass[:, None] * white)).tolist(),
        kl_p_q_box=float(mass @ (logp-logq)),
        half_L1_on_box=float(.5 * np.sum(abs(np.exp(logp)-np.exp(logq)) * volume)),
        gaussian_mass_on_box=float(np.sum(np.exp(logq)*volume)),
        stored_array_bytes=sum(v.nbytes for v in [axis, a, b, w, logu, volume, logp, mass, H, z, logq, centered, white]))
    return result


def ellipse_probability(X, y, m, C, logZ, coverage, nr, na):
    """Integrate p inside q's probability ellipse in q-whitened polar coordinates.

    For a 2D Gaussian, squared Mahalanobis radius is chi-square(2). Integrating
    a smooth density over this explicit disk avoids grid-indicator mesh error.
    """
    R = np.sqrt(chi2.ppf(coverage, 2))
    nodes, weights = np.polynomial.legendre.leggauss(nr)
    r = (nodes+1)*R/2; dr = weights*R/2
    theta = np.arange(na) * 2*np.pi/na
    white = (r[:, None, None] * np.stack([np.cos(theta), np.sin(theta)], axis=1)[None]).reshape(-1, 2)
    L = np.linalg.cholesky(C)
    w = m + white @ L.T
    p = np.exp(-old.nll(w, X, y)-logZ).reshape(nr, na)
    return float(np.sum(p * (dr*r)[:, None]) * 2*np.pi/na * np.linalg.det(L))


def main():
    start = time.perf_counter()
    frozen = json.loads((BASE / "classifier_results.json").read_text())
    X, y, Xt, yt, Q, metadata = old.model()
    assert metadata == frozen["metadata"]
    m = np.array(frozen["laplace"]["mean"])
    C = np.array(frozen["laplace"]["covariance"])
    grids = []
    for radius, step in [(8., .04), (10., .04), (10., .02)]:
        before = time.perf_counter()
        value = geometry(X, y, m, C, radius, step)
        value["seconds"] = time.perf_counter()-before
        grids.append(value)
    ellipses = []
    for coverage in [.5, .9, .95, .99]:
        vals = [ellipse_probability(X, y, m, C, grids[-1]["log_normalizer"], coverage, nr, na)
                for nr, na in [(32, 64), (64, 128)]]
        ellipses.append(dict(gaussian_nominal=coverage, reference=vals[-1],
            refinement_change=abs(vals[1]-vals[0]), error=vals[-1]-coverage))
    # New-query cost after storing q. Linear logits are exactly Gaussian under q,
    # reducing each sigmoid prediction to ONE-dimensional Hermite quadrature.
    query_z = np.linspace(-2., 2., 100)
    query_X = np.column_stack([np.ones(100), query_z])
    nodes, weights = np.polynomial.hermite.hermgauss(32)
    def predict():
        mu = query_X @ m
        var = np.sum((query_X @ C)*query_X, axis=1)
        return expit(mu[:, None]+np.sqrt(2*var[:, None])*nodes) @ (weights/np.sqrt(np.pi))
    timing=[]
    for _ in range(7):
        before = time.perf_counter(); pred = predict(); timing.append(time.perf_counter()-before)
    projected = lambda query: float(expit(query @ m+np.sqrt(2*(query @ C @ query))*nodes) @ (weights/np.sqrt(np.pi)))
    projection_error = max(abs(projected(q)-v) for q, v in zip(np.vstack([Q, Xt]), frozen["laplace"]["predictions"]))
    prior_precision = np.eye(2)/4
    at_mode = expit(X @ m)
    H = prior_precision+X.T@(at_mode[:,None]*(1-at_mode[:,None])*X)
    mean_error_sd = ((m-np.array(grids[-1]["mean"]))/np.sqrt(np.diag(grids[-1]["covariance"]))).tolist()
    sd_relative_error = (np.sqrt(np.diag(C)/np.diag(grids[-1]["covariance"]))-1).tolist()
    inputs = ["AGENTS.md", "course_architecture.typ", "curriculum_map.typ", "curriculum_map_actual.typ",
        "Lectures/L07_Inference/lecture_scope.md", "Lectures/L07_Inference/scope_investigation.md",
        "Lectures/L01_Probability_Statistics/slide_deck.typ",
        "Lectures/L05_GLM_Optimization/lecture_scope.md",
        "Lectures/course_architecture_scope/reconciliation/notebook_geometry/decision_and_tasks.md",
        "Lectures/course_architecture_scope/reviews/L07_review.md",
        "Lectures/course_architecture_scope/reconciliation/reviews/inference_probe_validation.md",
        "Lectures/L07_Inference/notebook_feasibility/classifier_probe.py",
        "Lectures/L07_Inference/notebook_feasibility/classifier_results.json",
        "Lectures/L07_Inference/notebook_feasibility/reference_bounds.md",
        "Lectures/L07_Inference/notebook_feasibility/reference_bounds_results.json",
        ".agents/skills/lecture-scope/SKILL.md", ".agents/skills/worked-solution-authoring/SKILL.md",
        ".agents/skills/shared/backpressure.md",
        ".agents/skills/lecture-scope/references/timing-calibration.md",
        ".agents/skills/teaching-notebook-authoring/references/student-knowledge.md"]
    results = dict(status="teacher-only author check; not independently reviewed/student timed/Colab run",
        base_commit="e8a0f6c", metadata=metadata, versions=dict(python=platform.python_version(),
        numpy=np.__version__, scipy=scipy.__version__, sklearn=sklearn.__version__),
        input_sha256={name:sha(ROOT/name) for name in inputs}, script_sha256=sha(Path(__file__)),
        geometry_grids=grids, ellipse_masses=ellipses,
        mode_hessian_eigenvalues=np.linalg.eigvalsh(H).tolist(), mean_error_in_reference_sd=mean_error_sd,
        laplace_sd_relative_error=sd_relative_error,
        reused_task_evidence=dict(max_prediction_error=frozen["laplace"]["max_prediction_error"],
            holdout_log_loss=frozen["holdout_log_loss"], source="classifier_results.json; not rerun"),
        repeated_query=dict(query_count=100, z_range=[-2,2], gaussian_parameters_bytes=m.nbytes+C.nbytes,
            projected_GH_nodes_per_query=32, median_seconds=float(np.median(timing)),
            all_seconds=timing, projection_vs_old_2d_GH_max_change=projection_error),
        seconds=time.perf_counter()-start)
    assert abs(grids[-1]["log_normalizer"]-grids[-2]["log_normalizer"]) < 1e-9
    assert projection_error < 1e-10
    assert max(v["refinement_change"] for v in ellipses) < 1e-9
    (HERE/"geometry_results.json").write_text(json.dumps(results, indent=2, allow_nan=False)+"\n")
    print(json.dumps(results, indent=2, allow_nan=False))


if __name__ == "__main__":
    main()
