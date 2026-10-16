"""L06 conditional feasibility probe, never an approved student notebook.

Exact, unregularized Gaussian EM; closed-form Gaussian conditionals and M-step.
Train latent truth is excluded from initialization/fitting/standardization.
Results assess specified finite runs, not a global convergence theorem.
"""
import json
import hashlib
import platform
import time
from pathlib import Path

import numpy as np
import scipy
import sklearn
from scipy.stats import multivariate_normal, skew, kurtosis
from sklearn.datasets import load_diabetes


def groups(mask):
    patterns, inverse = np.unique(mask, axis=0, return_inverse=True)
    return [(np.flatnonzero(inverse == k), np.flatnonzero(pattern),
             np.flatnonzero(~pattern)) for k, pattern in enumerate(patterns)]


def moments(visible, mu, covariance, include_covariance=True):
    n, d = visible.shape
    expected = visible.copy()
    sum_uncertainty = np.zeros((d, d))
    for rows, obs, missing in groups(np.isfinite(visible)):
        if not len(missing):
            continue
        assert len(obs), "Fully missing rows must be excluded explicitly."
        cross = covariance[np.ix_(missing, obs)]
        coefficient = np.linalg.solve(covariance[np.ix_(obs, obs)], cross.T).T
        a = mu[missing] + (visible[np.ix_(rows, obs)] - mu[obs]) @ coefficient.T
        expected[np.ix_(rows, missing)] = a
        V = covariance[np.ix_(missing, missing)] - coefficient @ cross.T
        assert np.linalg.eigvalsh(V).min() > 0
        if include_covariance:
            sum_uncertainty[np.ix_(missing, missing)] += len(rows) * V
    return expected, expected.T @ expected + sum_uncertainty


def likelihood(visible, mu, covariance):
    total = 0.0
    for rows, obs, _ in groups(np.isfinite(visible)):
        total += np.sum(multivariate_normal.logpdf(
            visible[np.ix_(rows, obs)], mean=mu[obs], cov=covariance[np.ix_(obs, obs)]
        ))
    return float(total)


def fit(visible, max_steps=80, covariance_term=True):
    n, d = visible.shape
    mu = np.nanmean(visible, axis=0)
    covariance = np.diag(np.nanvar(visible, axis=0))
    trace = [likelihood(visible, mu, covariance)]
    eigenvalues = [np.linalg.eigvalsh(covariance).min()]
    for _ in range(max_steps):
        expected, second = moments(visible, mu, covariance, covariance_term)
        mu = expected.mean(axis=0)
        covariance = second / n - np.outer(mu, mu)
        # Round-off symmetrization only: no ridge, eigenvalue clipping or altered M-step.
        covariance = (covariance + covariance.T) / 2
        eigenvalues.append(np.linalg.eigvalsh(covariance).min())
        assert eigenvalues[-1] > 0
        trace.append(likelihood(visible, mu, covariance))
        if abs(trace[-1] - trace[-2]) / n < 1e-7:
            break
    if covariance_term:
        assert min(np.diff(trace)) >= -1e-8
    return mu, covariance, {
        "iterations": len(trace) - 1,
        "observed_train_ll_trace_every_5_steps": [
            {"step": i, "ll": v} for i, v in enumerate(trace)
            if i % 5 == 0 or i == len(trace) - 1],
        "min_ll_increment": float(min(np.diff(trace))),
        "decreasing_steps_tolerance_1e8": int((np.diff(trace) < -1e-8).sum()),
        "min_covariance_eigenvalue_across_run": float(min(eigenvalues)),
        "final_covariance_eigenvalues": np.linalg.eigvalsh(covariance).tolist(),
        "stopped_by_tolerance": len(trace) - 1 < max_steps,
    }


def apply_mask(values, rng):
    mask = rng.random(values.shape) >= 0.3
    keep = mask.any(axis=1)
    truth = values[keep]
    mask = mask[keep]
    visible = np.where(mask, truth, np.nan)
    return truth, visible, mask, int((~keep).sum())


def evaluate(truth, visible, mu, covariance):
    means, _ = moments(visible, mu, covariance)
    missing = ~np.isfinite(visible)
    variances = np.zeros(visible.shape)
    for rows, obs, miss in groups(np.isfinite(visible)):
        if len(miss):
            cross = covariance[np.ix_(miss, obs)]
            V = covariance[np.ix_(miss, miss)] - cross @ np.linalg.solve(
                covariance[np.ix_(obs, obs)], cross.T)
            variances[np.ix_(rows, miss)] = np.diag(V)
    residual = means[missing] - truth[missing]
    return {
        "test_reconstruction_mse": float(((means[missing] - truth[missing]) ** 2).mean()),
        "observed_test_mean_ll": likelihood(visible, mu, covariance) / len(visible),
        "marginal_missing_95pct_interval_coverage": float((
            np.abs(residual) <= 1.959963984540054 * np.sqrt(variances[missing])).mean()),
        "mean_missing_conditional_variance": float(variances[missing].mean()),
    }


def experiment(kind, seed):
    started = time.perf_counter()
    rng = np.random.default_rng(seed)
    true_parameters = None
    if kind == "synthetic_gaussian":
        A = np.array([[1, 0, 0, 0], [.8, .6, 0, 0], [.7, .2, .6, 0], [.4, .3, .5, .6]])
        covariance = A @ A.T + .15 * np.eye(4)
        scales = np.sqrt(np.diag(covariance))
        covariance = covariance / np.outer(scales, scales)
        mu = np.array([.3, -.5, .7, .1])
        raw = rng.multivariate_normal(mu, covariance, size=600)
        true_parameters = (mu, covariance)
        description = {"features": ["constructed_measurement_1", "constructed_measurement_2",
                                    "constructed_measurement_3", "constructed_measurement_4"],
                       "true_mu": mu.tolist(), "true_covariance": covariance.tolist(),
                       "source": "course-constructed Gaussian measurement surrogate"}
    else:
        data = load_diabetes(scaled=False)
        selected = [2, 3, 4, 5]
        raw = data.data[:, selected]
        raw = raw[rng.permutation(len(raw))]
        description = {"features": [data.feature_names[i] for i in selected],
                       "source": "sklearn bundled diabetes raw physiological measurements",
                       "target_used": False}
    n_train = int(2 * len(raw) / 3)
    description["raw_measurement_sha256"] = hashlib.sha256(raw.tobytes()).hexdigest()
    train_truth, train, mask, excluded_train = apply_mask(raw[:n_train], rng)
    test_truth, test, test_mask, excluded_test = apply_mask(raw[n_train:], rng)
    if kind != "synthetic_gaussian":
        # Center/scale use only observed TRAIN values, never artificially hidden truth.
        center, scale = np.nanmean(train, axis=0), np.nanstd(train, axis=0)
        train, test = (train - center) / scale, (test - center) / scale
        train_truth, test_truth = (train_truth - center) / scale, (test_truth - center) / scale
        description.update({"observed_train_center": center.tolist(),
                            "observed_train_scale": scale.tolist(),
                            "train_marginal_skew": skew(train, axis=0, nan_policy="omit").tolist(),
                            "train_marginal_excess_kurtosis": kurtosis(train, axis=0, nan_policy="omit").tolist()})
    complete = train[mask.all(axis=1)]
    complete_mu = complete.mean(axis=0)
    complete_cov = np.cov(complete, rowvar=False, bias=True)
    column_mu = np.nanmean(train, axis=0)
    filled = np.where(mask, train, column_mu)
    filled_mu, filled_cov = filled.mean(axis=0), np.cov(filled, rowvar=False, bias=True)
    mu, covariance, diagnostics = fit(train)
    wrong_mu, wrong_cov, wrong_diagnostics = fit(train, covariance_term=False)
    methods = {
        "exact_EM": {**evaluate(test_truth, test, mu, covariance),
                     "observed_train_ll": likelihood(train, mu, covariance), **diagnostics},
        "complete_case_fit_conditional_prediction": {**evaluate(test_truth, test, complete_mu, complete_cov),
                     "observed_train_ll": likelihood(train, complete_mu, complete_cov)},
        "ordinary_mean_imputed_fit_conditional_prediction": {**evaluate(test_truth, test, filled_mu, filled_cov),
                     "observed_train_ll": likelihood(train, filled_mu, filled_cov)},
        "mean_only_iterative_diagnostic": {**evaluate(test_truth, test, wrong_mu, wrong_cov),
                     "observed_train_ll": likelihood(train, wrong_mu, wrong_cov), **wrong_diagnostics},
        "ordinary_column_mean_imputation": {"test_reconstruction_mse": float(
            ((np.broadcast_to(column_mu, test.shape)[~test_mask] - test_truth[~test_mask]) ** 2).mean())},
    }
    if true_parameters:
        oracle_mu, oracle_cov = true_parameters
        methods["oracle_known_parameters_diagnostic"] = evaluate(test_truth, test, oracle_mu, oracle_cov)
        methods["exact_EM"]["covariance_frobenius_error_vs_truth"] = float(np.linalg.norm(covariance - oracle_cov))
    return {
        "kind": kind, "seed": seed, "description": description,
        "train_rows": len(train), "test_rows": len(test), "complete_train_rows": len(complete),
        "complete_train_centered_rank": int(np.linalg.matrix_rank(complete - complete_mu)),
        "fully_missing_train_rows_excluded": excluded_train,
        "fully_missing_test_rows_excluded": excluded_test,
        "train_pairwise_coobservation_counts": (mask.astype(int).T @ mask.astype(int)).tolist(),
        "test_hidden_entries": int((~test_mask).sum()), "methods": methods,
        "train_observation_mask_sha256": hashlib.sha256(mask.tobytes()).hexdigest(),
        "test_observation_mask_sha256": hashlib.sha256(test_mask.tobytes()).hexdigest(),
        "elapsed_seconds": time.perf_counter() - started,
    }


# Local exact second-moment check promised by current scope.
small = np.array([[-1., -1.], [0., 1.], [2., np.nan]])
small_mu = np.zeros(2)
small_cov = np.array([[1., .5], [.5, 1.]])
small_means, small_second = moments(small, small_mu, small_cov)
new_mu = small_means.mean(axis=0)
new_cov = small_second / 3 - np.outer(new_mu, new_mu)
assert np.allclose(new_cov, [[14 / 9, 8 / 9], [8 / 9, 41 / 36]])

# Structural nonidentification: no row observes both coordinates.
disconnected = np.array([[-1., np.nan], [1., np.nan], [np.nan, -1.], [np.nan, 1.]])
flat_values = [likelihood(disconnected, np.zeros(2), np.array([[1., rho], [rho, 1.]]))
               for rho in (-.9, 0., .9)]
assert max(flat_values) - min(flat_values) < 1e-12
result = {
    "purpose": "conditional feasibility only; no hosted Colab or learner timing validation",
    "versions": {"python": platform.python_version(), "numpy": np.__version__,
                 "scipy": scipy.__version__, "sklearn": sklearn.__version__},
    "tiny_iteration": {"means": small_means.tolist(), "updated_mu": new_mu.tolist(),
                       "updated_covariance": new_cov.tolist(),
                       "old_ll": likelihood(small, small_mu, small_cov),
                       "new_ll": likelihood(small, new_mu, new_cov)},
    "disconnected_pattern_counterexample": {"correlations": [-.9, 0., .9], "observed_ll": flat_values},
    "runs": [experiment(kind, seed) for kind in ("synthetic_gaussian", "diabetes_measurements")
             for seed in (2027, 5, 17)],
}
Path(__file__).with_name("results.json").write_text(json.dumps(result, indent=2) + "\n")
print(json.dumps({"runs": [{"kind": r["kind"], "seed": r["seed"],
                            "EM_test_mse": r["methods"]["exact_EM"]["test_reconstruction_mse"],
                            "EM_min_ll_increment": r["methods"]["exact_EM"]["min_ll_increment"]}
                           for r in result["runs"]]}, indent=2))
