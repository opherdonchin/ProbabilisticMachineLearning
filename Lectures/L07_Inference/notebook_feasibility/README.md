# Author-only inference feasibility probes

These scripts investigate conditional course choices; they are neither approved
worked-solution handoffs nor student notebooks. Run top-to-bottom in the isolated
locked uv environment from the reconciliation worktree:

```bash
.venv/bin/python Lectures/L07_Inference/notebook_feasibility/classifier_probe.py
.venv/bin/python Lectures/L07_Inference/notebook_feasibility/reference_bounds.py
.venv/bin/python Lectures/L09_Variational_Inference/notebook_feasibility/pathwise_probe.py
.venv/bin/python Lectures/L10_MCMC/notebook_feasibility/mh_probe.py
.venv/bin/python Lectures/L08_Structured_Inference/notebook_feasibility/sequence_probe.py
```

The first command writes the checked reference used by the next two. L09/L10
import the same fixed model so feature, split, prior and queries cannot drift.
NumPy/SciPy/scikit-learn/PyTorch are provided by the locked course environment;
no package was installed into system Python or added to dependency declarations.
Results include fixed seeds and numerical outputs. Optimizer/chain/message
timings exclude imports and reflect one local machine, not student work time.

Optional empirical conditional alternative (requires a read-only local source):

```bash
.venv/bin/python Lectures/L08_Structured_Inference/notebook_feasibility/traffic_probe.py '/absolute/path/lacity.org-website-traffic.csv'
```

The expected source SHA256 is
`eb65714213b7364a79f9caa2accfa257e180a106cc9201862abf96908ffdf880`.
The instructor copy is under the Oke spring-2026 PS2 question directory. No raw
CSV or student submissions are copied. Standard-library streaming avoids a
pandas dependency (an initial pandas import failed in clean uv and was repaired).
Scalar failure and post hoc seasonal exploration are both retained. The named
Oke solved forecasting notebook and Darts/N4SID run remain unverified.

Question ownership, mathematical assumptions, prerequisites and exact blocked
production work are in each lecture's `scope_investigation.md`. JSON results are
identifiable raw pilot evidence, not approval or a substitute for those records.
No Colab run, lecture rehearsal, student completion trial or publication pass is
claimed. Only affected endpoint/production choices await instructor decisions;
independent correctness/source research may continue.

The added [reference-bound check](reference_bounds.md) uses global Hessian bounds
and a gradient-residual correction to bound target mass outside each grid box.
At radius10 its analytic Gaussian-envelope tail bound is about`.000524` for
bounded sigmoid queries, with a separate conservative Mills formula about
`.000550`. It does not certify trapezoidal mesh error, unbounded log loss or the
displayed coefficient moments. Numeric evaluation is float64 rather than
interval/directed-rounding arithmetic. This adds no teaching commitment.
