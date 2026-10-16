"""Conditional L05 feasibility probe, not a student notebook or approved handoff.

Run in a clean process; no downloads, file mutation outside the JSON result,
or environment installation. All preprocessing is fitted on the train split.
"""
import json
import hashlib
import platform
import time
from pathlib import Path

import numpy as np
import sklearn
import torch
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split

torch.set_num_threads(1)
torch.use_deterministic_algorithms(True)


def score(log_probabilities, labels):
    probabilities = np.exp(log_probabilities)
    assert probabilities.shape == (len(labels), 3)
    assert np.isfinite(log_probabilities).all()
    assert np.allclose(probabilities.sum(axis=1), 1)
    return {
        "mean_nll_nats": float(-log_probabilities[np.arange(len(labels)), labels].mean()),
        "classification_error": float((probabilities.argmax(axis=1) != labels).mean()),
    }


def experiment(seed, batch_size=32, steps=800, learning_rate=0.15):
    started = time.perf_counter()
    torch.manual_seed(seed)
    iris = load_iris()
    raw = iris.data[:, 2:4]
    train_ids, test_ids = train_test_split(
        np.arange(len(raw)), test_size=0.3, stratify=iris.target, random_state=seed
    )
    center = raw[train_ids].mean(axis=0)
    scale = raw[train_ids].std(axis=0, ddof=0)
    X = torch.tensor((raw[train_ids] - center) / scale, dtype=torch.float32)
    y = torch.tensor(iris.target[train_ids], dtype=torch.long)
    Xt = torch.tensor((raw[test_ids] - center) / scale, dtype=torch.float32)
    yt = iris.target[test_ids]
    W = torch.zeros((3, 2), requires_grad=True)
    b = torch.zeros(3, requires_grad=True)
    optimizer = torch.optim.SGD([W, b], lr=learning_rate)
    criterion = torch.nn.CrossEntropyLoss()

    # Nonzero parameters and float64 give a meaningful analytic/AD comparison.
    Xc = X[:7].double()
    yc = y[:7]
    Wc = (0.2 * torch.randn(3, 2, dtype=torch.float64)).requires_grad_()
    bc = (0.2 * torch.randn(3, dtype=torch.float64)).requires_grad_()
    logits = Xc @ Wc.T + bc
    loss = criterion(logits, yc)
    loss.backward()
    P = torch.softmax(logits.detach(), dim=1)
    T = torch.nn.functional.one_hot(yc, num_classes=3).double()
    manual_W = (P - T).T @ Xc / len(yc)
    manual_b = (P - T).mean(dim=0)
    gradient_error = max((Wc.grad - manual_W).abs().max().item(),
                         (bc.grad - manual_b).abs().max().item())
    assert gradient_error < 1e-12
    # Repeating backward on a fresh graph without clearing accumulates gradients.
    criterion(Xc @ Wc.T + bc, yc).backward()
    accumulation_error = (Wc.grad - 2 * manual_W).abs().max().item()
    assert accumulation_error < 1e-12
    shift_error = (criterion(logits.detach() + 123.0, yc) - loss.detach()).abs().item()
    assert shift_error < 1e-12

    trace = []
    for step in range(steps):
        if batch_size == len(X):
            indices = torch.arange(len(X))
        else:
            # Fresh independent uniform draws: the lecture's exact unbiased regime.
            indices = torch.randint(len(X), (batch_size,))
        optimizer.zero_grad()
        logits = X[indices] @ W.T + b
        loss = criterion(logits, y[indices])
        loss.backward()
        optimizer.step()
        if step % 100 == 0 or step == steps - 1:
            with torch.no_grad():
                trace.append({"step": step + 1,
                              "full_train_nll": criterion(X @ W.T + b, y).item()})
    with torch.no_grad():
        log_probabilities = torch.log_softmax(Xt @ W.T + b, dim=1).numpy()
        train_log_probabilities = torch.log_softmax(X @ W.T + b, dim=1).numpy()
    probabilities = np.exp(log_probabilities)
    frequencies = np.bincount(y.numpy(), minlength=3) / len(y)
    baseline_log_probabilities = np.tile(np.log(frequencies), (len(yt), 1))
    assert np.isfinite(probabilities).all()
    return {
        "seed": seed, "batch_size": batch_size, "steps": steps, "learning_rate": learning_rate,
        "features": iris.feature_names[2:4], "train_n": len(train_ids), "test_n": len(test_ids),
        "raw_feature_sha256": hashlib.sha256(raw.tobytes()).hexdigest(),
        "train_ids_sha256": hashlib.sha256(train_ids.tobytes()).hexdigest(),
        "test_ids_sha256": hashlib.sha256(test_ids.tobytes()).hexdigest(),
        "train_center": center.tolist(), "train_scale": scale.tolist(),
        "train_class_counts": np.bincount(y.numpy(), minlength=3).tolist(),
        "test_class_counts": np.bincount(yt, minlength=3).tolist(),
        "shapes": {"X": list(X.shape), "W": list(W.shape), "b": list(b.shape),
                   "logits": [batch_size, 3], "probabilities": list(probabilities.shape),
                   "integer_targets": list(y.shape)},
        "manual_autograd_max_abs_error_float64": gradient_error,
        "uncleared_gradient_doubling_max_abs_error": accumulation_error,
        "common_logit_shift_loss_error": shift_error,
        "train": score(train_log_probabilities, y.numpy()), "test": score(log_probabilities, yt),
        "frequency_baseline_test": score(baseline_log_probabilities, yt), "train_trace": trace,
        "elapsed_seconds": time.perf_counter() - started,
    }


extreme_log_p = torch.log_softmax(torch.tensor([[0., -1000., -1.]]), dim=1).numpy()
extreme_score = score(extreme_log_p, np.array([1]))
assert np.exp(extreme_log_p[0, 1]) == 0
assert np.isclose(extreme_score["mean_nll_nats"], 1000. + np.log1p(np.exp(-1.)), atol=1e-4, rtol=0)

result = {
    "purpose": "isolated feasibility evidence; no learner timing or hosted Colab validation",
    "versions": {"python": platform.python_version(), "torch": torch.__version__,
                 "numpy": np.__version__, "sklearn": sklearn.__version__},
    "cpu_threads": 1,
    "numerical_diagnostic": {
        "finite_logit_underflow_nll_nats": extreme_score["mean_nll_nats"],
        "exponentiated_target_probability": 0.,
        "interpretation": "finite logit-space loss; floating-point zero is not structural zero",
    },
    "required_route": [experiment(seed) for seed in (2027, 5, 17)],
    "conditional_supplied_full_batch_comparison": experiment(2027, batch_size=105),
    "large_learning_rate_diagnostic": experiment(2027, steps=800, learning_rate=10.0),
}
Path(__file__).with_name("results.json").write_text(json.dumps(result, indent=2) + "\n")
print(json.dumps({"runs": len(result["required_route"]), "test_scores":
                  [run["test"] for run in result["required_route"]]}, indent=2))
