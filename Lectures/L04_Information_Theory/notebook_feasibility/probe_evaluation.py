"""Author-only feasibility for the selected L04 endpoint; no student notebook.

Forecast construction is supplied infrastructure. Fixed choices precede test
evaluation, and the finite MI law is constructed, not estimated from Iris.
"""
import hashlib
import json
import platform
from pathlib import Path

import numpy as np
import scipy
import sklearn
from scipy.special import logsumexp, xlogy
from sklearn.datasets import load_iris
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split


def log_probabilities(logits):
    return logits - logsumexp(logits, axis=1, keepdims=True)


def scores(log_p, labels):
    p = np.exp(log_p)
    assert p.shape == (len(labels), 3)
    assert np.isfinite(log_p).all() and np.allclose(p.sum(1), 1)
    predicted = p.argmax(1)
    losses = -log_p[np.arange(len(labels)), labels]
    # Score in log space: exp(log_p) can underflow or lose relative precision
    # in the subnormal range, even when the finite logit-space loss is accurate.
    return dict(accuracy=float((predicted == labels).mean()),
                mean_nll_nats=float(losses.mean()),
                mean_nll_bits=float(losses.mean() / np.log(2)))


def reliability(log_p, labels):
    p = np.exp(log_p)
    confidence = p.max(1)
    correct = p.argmax(1) == labels
    # Fixed bins; no fitted calibration map and no tuning by observed correctness.
    edges = np.linspace(0, 1, 6)
    indices = np.minimum(np.searchsorted(edges, confidence, side="right") - 1, 4)
    bins = []
    for i in range(5):
        selected = indices == i
        bins.append(dict(lower=float(edges[i]), upper=float(edges[i + 1]),
                         count=int(selected.sum()),
                         mean_confidence=float(confidence[selected].mean()) if selected.any() else None,
                         observed_correctness=float(correct[selected].mean()) if selected.any() else None))
    assert sum(b["count"] for b in bins) == len(labels)
    return bins


def mutual_information(joint):
    assert np.isfinite(joint).all() and (joint >= 0).all() and np.isclose(joint.sum(), 1)
    product = joint.sum(1, keepdims=True) @ joint.sum(0, keepdims=True)
    support = joint > 0
    return float(np.sum(joint[support] * np.log2(joint[support] / product[support])))


def main():
    data = load_iris()
    raw, labels = data.data[:, 2:4], data.target
    tr, te = train_test_split(np.arange(len(labels)), test_size=.3,
                             random_state=2027, stratify=labels)
    center, scale = raw[tr].mean(0), raw[tr].std(0)
    xtr, xte = (raw[tr] - center) / scale, (raw[te] - center) / scale
    # Teacher preparation only; this training API is not a new student requirement.
    model = LogisticRegression(C=1., max_iter=500, random_state=2027).fit(xtr, labels[tr])
    assert np.array_equal(model.classes_, np.arange(3))
    logits = model.decision_function(xte)
    base = log_probabilities(logits)
    assert np.allclose(np.exp(base), model.predict_proba(xte))
    forecasts = {"prepared_softmax": base,
                 "supplied_lower_confidence": log_probabilities(.25 * logits),
                 "supplied_higher_confidence": log_probabilities(4. * logits)}
    reference_labels = base.argmax(1)
    assert all(np.array_equal(lp.argmax(1), reference_labels) for lp in forecasts.values())
    freq = np.bincount(labels[tr], minlength=3) / len(tr)
    baseline = np.tile(np.log(freq), (len(te), 1))
    forecasts["training_frequency_baseline"] = baseline

    # One explicit common law for Y, original discrete R and processed Z.
    p_y_given_r = np.array([[.8, .1, .1, .4], [.1, .8, .1, .3], [.1, .1, .8, .3]])
    p_yr = p_y_given_r / 4
    kernel = np.array([[1., 0.], [1., 0.], [0., 1.], [0., 1.]])
    joint = p_yr[:, :, None] * kernel[None, :, :]
    p_yz = joint.sum(1)
    original, processed = mutual_information(p_yr), mutual_information(p_yz)
    entropy_y = float(-np.sum(xlogy(p_yr.sum(1), p_yr.sum(1))) / np.log(2))
    assert 0 <= processed <= original <= entropy_y
    assert np.isclose(mutual_information(p_yz[:, ::-1]), processed)
    assert np.isclose(mutual_information(p_yr.sum(1, keepdims=True)), 0)
    # Correctly conditional-independent processing, including zero-kernel cases.
    assert np.allclose(joint, joint.sum(2)[:, :, None] * kernel[None, :, :])

    extreme_log_p = log_probabilities(np.array([[0., -1000., -1.]]))
    extreme_score = scores(extreme_log_p, np.array([1]))
    assert np.exp(extreme_log_p[0, 1]) == 0
    assert np.isclose(extreme_score["mean_nll_nats"], 1000. + np.log1p(np.exp(-1.)))
    subnormal_log_p = log_probabilities(np.array([[0., -744., -1.]]))
    subnormal_score = scores(subnormal_log_p, np.array([1]))
    assert 0 < np.exp(subnormal_log_p[0, 1]) < np.finfo(float).tiny
    assert np.isclose(subnormal_score["mean_nll_nats"], 744. + np.log1p(np.exp(-1.)))

    result = dict(status="author-only feasibility; no student-time or Colab validation",
                  versions=dict(python=platform.python_version(), numpy=np.__version__,
                                scipy=scipy.__version__, sklearn=sklearn.__version__),
                  split_seed=2027, train_n=len(tr), test_n=len(te),
                  train_ids_sha256=hashlib.sha256(tr.tobytes()).hexdigest(),
                  test_ids_sha256=hashlib.sha256(te.tobytes()).hexdigest(),
                  raw_feature_sha256=hashlib.sha256(raw.tobytes()).hexdigest(),
                  training_center=center.tolist(), training_scale=scale.tolist(),
                  classes=data.target_names.tolist(), features=data.feature_names[2:4],
                  diagnostic_logit_multipliers=[.25, 4.],
                  forecast_scores={name: scores(lp, labels[te]) for name, lp in forecasts.items()},
                  same_label_confidence_diagnostics_checked=True,
                  numerical_diagnostic=dict(
                      finite_logit_underflow_nll_nats=extreme_score["mean_nll_nats"],
                      exponentiated_target_probability=0.,
                      finite_subnormal_nll_nats=subnormal_score["mean_nll_nats"],
                      interpretation="finite logit-space loss; floating-point zero is not structural zero"),
                  top_label_reliability={name: reliability(lp, labels[te]) for name, lp in forecasts.items()},
                  finite_information=dict(provenance="course-constructed law, not Iris population estimate",
                                          p_y_r=p_yr.tolist(), kernel_z_given_r=kernel.tolist(),
                                          label_entropy_bits=entropy_y, I_y_r_bits=original, I_y_z_bits=processed))
    Path(__file__).with_name("results.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(dict(scores=result["forecast_scores"], I_y_r_bits=original, I_y_z_bits=processed)))


if __name__ == "__main__":
    main()
