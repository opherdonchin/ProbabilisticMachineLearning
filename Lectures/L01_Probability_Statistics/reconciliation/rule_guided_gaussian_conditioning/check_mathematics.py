"""Finite numerical checks supplement the general proof/source audit.

Run from the repository root with the existing uv environment. No notebook,
dependency or canonical artifact is changed. These checks are not a proof of
the general identities or evidence of instructional effectiveness.
"""

import hashlib
import json
from pathlib import Path

import numpy as np
from scipy.stats import multivariate_normal


HERE = Path(__file__).resolve().parent
rng = np.random.default_rng(713)
cases = []
for d1, d2 in [(1, 1), (2, 3), (3, 2), (4, 4)]:
    d = d1 + d2
    a = rng.normal(size=(d, d))
    sigma = a @ a.T + np.eye(d)
    h = sigma[d1:, d1:]
    b = np.linalg.solve(h, sigma[:d1, d1:].T).T
    s = sigma[:d1, :d1] - b @ sigma[d1:, :d1]
    t = np.block([[np.eye(d1), -b], [np.zeros((d2, d1)), np.eye(d2)]])
    ti = np.block([[np.eye(d1), b], [np.zeros((d2, d1)), np.eye(d2)]])
    diagonal = np.block([[s, np.zeros((d1, d2))],
                         [np.zeros((d2, d1)), h]])
    inverse = t.T @ np.linalg.inv(diagonal) @ t
    y = rng.normal(size=d)
    u = y[d1:]
    r = y[:d1] - b @ u
    joint_q = y @ np.linalg.solve(sigma, y)
    separated_q = r @ np.linalg.solve(s, r) + u @ np.linalg.solve(h, u)
    logdet_error = abs(np.linalg.slogdet(sigma)[1]
                       - np.linalg.slogdet(s)[1] - np.linalg.slogdet(h)[1])
    logpdf_joint = multivariate_normal.logpdf(y, mean=np.zeros(d), cov=sigma)
    logpdf_factors = (
        multivariate_normal.logpdf(y[:d1], mean=b @ u, cov=s)
        + multivariate_normal.logpdf(u, mean=np.zeros(d2), cov=h)
    )
    errors = {
        "T_inverse_both_orders": max(np.max(abs(t @ ti - np.eye(d))),
                                     np.max(abs(ti @ t - np.eye(d)))),
        "row_and_column_elimination": np.max(abs(t @ sigma @ t.T - diagonal)),
        "inverse_congruence": np.max(abs(inverse - np.linalg.inv(sigma))),
        "quadratic_separation": abs(joint_q - separated_q),
        "log_determinant_factorization": logdet_error,
        "fully_normalized_density_factorization": abs(logpdf_joint - logpdf_factors),
    }
    positive = {"Sigma": float(np.linalg.eigvalsh(sigma).min()),
                "Sigma22": float(np.linalg.eigvalsh(h).min()),
                "S": float(np.linalg.eigvalsh(s).min())}
    assert all(e < 1e-10 for e in errors.values()), errors
    assert all(v > 0 for v in positive.values()), positive
    cases.append({"dimensions": [d1, d2],
                  "absolute_errors": {k: float(v) for k, v in errors.items()},
                  "minimum_eigenvalues": positive})

source = HERE / "candidate/slide_deck.typ"
result = {"method": "Deterministic floating-point specializations, not a general proof",
          "numpy": np.__version__, "all_checks_pass": True,
          "candidate_source_sha256": hashlib.sha256(source.read_bytes()).hexdigest()
          if source.exists() else None,
          "cases": cases}
(HERE / "mathematics_checks.json").write_text(json.dumps(result, indent=2) + "\n")
print(json.dumps({"all_checks_pass": True,
                  "maximum_absolute_error": max(max(c["absolute_errors"].values()) for c in cases)}))
