# Validating the Oke package covariance repair

**Stage/mode:** worked-solution author validation, 2026-10-16, bounded follow-up
to [the source/package review](../../reconciliation/oke_package_review.md) at
`6e85c6c`. Branch `validate/l08-package-repair-20261016`; sole artifact directory
is this `oke_package_checks/` tree. This is an author check by the same specialist,
not an independent pedagogical review or an implemented course notebook.

**Outcome:** the released nfoursid 1.0.2 missing-observation covariance defect is
reproduced. A four-line candidate correction passes eight exact-Gaussian checks,
including repeated missing observations, observed updates, nonzero learned-style
process/measurement cross-covariance, matrix states/observations and controls.
Maximum state-moment discrepancy is `6.67e−16`; maximum missing-time output-moment
discrepancy is `4.45e−16` (assertion tolerance `2e−12`). Observed-only trajectories
are bitwise unchanged by the candidate. This validates the extracted methods and
candidate algebra; pandas, Darts and nfoursid are absent, so it does **not** claim
a full package import, Darts integration, Oke notebook run, learner-time pass or
hosted Colab check.

## Exact sources, correction and reproduction

[The manifest](source_manifest.json) records upstream commit URLs, complete-file
SHA256 values, license snapshots and release-wheel checks. The pinned
[nfoursid source](upstream/nfoursid_kalman.py) is byte-identical to `kalman.py` in
the official **1.0.2** wheel; pinned Darts filter/forecaster modules are
byte-identical to the official **0.48.0** wheel. Wheels were inspected in memory,
not installed. The source snapshot is raw checking evidence, not an edited
installed package or a replacement teaching library. Upstream line 58's original
trailing whitespace and the unified patch's blank context markers are intentionally
preserved; they account for the whitespace-check notices on those raw artifacts.
Authored Python/JSON/prose has no whitespace-check finding.

[validate.py](validate.py) extracts the exact upstream `Kalman.__init__` and
`Kalman.step` bodies by Python AST. It executes those bodies with NumPy and small
fixtures providing only the validated shapes and `Cx+Du` output mapping that
those methods require. The fixture's mapping agrees with the pinned
[StateSpace source](upstream/nfoursid_state_space.py:153); its optional output
noise is zero in these checks. Pandas, plotting and the rest of the package are
neither stub-imported nor represented as having run.

The [candidate patch](missing_observation.patch) adds only these two guards to
the source: when `y is None`, replace `k_filtered` and `k_pred` by zero matrices.
The source already skips the mean innovation when the observation is absent;
these guards also suppress covariance conditioning on that absent observation.
There are four inserted nonblank lines. Original observed-update code, model
matrices and all noise blocks are preserved. This simple candidate retains the
source's pseudoinverse calculation even for missing observations; no speed claim
or larger refactor is implied.

Reproduce offline with the existing repository-prepared Python environment:

```bash
/tmp/pml-l04-l12-reconciliation/.venv/bin/python \
  Lectures/L08_Structured_Inference/notebook_feasibility/oke_package_checks/validate.py
```

The script verifies every stored source hash, regenerates the candidate diff and
writes [results.json](results.json). [run.log](run.log) preserves the actual
validation output. No dependency installation, source download or package import
is needed to rerun the numerical checks. Direct missing-package import attempts
are recorded separately in the result.

## An independent Gaussian oracle, not a second filter

The oracle uses the source's initial state mean zero and covariance identity.
For each diagnostic, it forms one vector containing the initial state and every
noise pair `(v_t,w_t)`. Pairs at different times are independent; each pair has
its complete specified covariance. Every state and measurement is constructed
as a linear map of that vector, including deterministic controls. The oracle
then conditions this **joint Gaussian** directly on all measurements actually
observed by the relevant time, using a dense linear solve. It contains no Kalman
gain or filtering recurrence.

At each step, source and corrected methods are compared with oracle means and
covariances for both the current filtered state and the next predicted state.
At missing times, the Darts output expression `C P_filtered C^T+R` and output
mean are compared with the independent conditional observation moments. Candidate
covariances are also checked for positive semidefiniteness. Actual parameters,
observations, controls, per-step matrices and errors are preserved in the JSON.
No random draws, fitted dataset, parameter search or Monte Carlo tolerance enter
these checks.

| Diagnostic | Original maximum state-moment error | Candidate error |
|---|---:|---:|
| Scalar, one missing observation | `.5` | `0` |
| Scalar, six successive missing observations | `5.38198` | `0` |
| Scalar, observed only | `6.67e−16` | `6.67e−16` |
| Scalar, observed/missing/observed | `1.88462` | `4.45e−16` |
| Scalar, correlated noise, observed only | `4.45e−16` | `4.45e−16` |
| Scalar, correlated noise, mixed observations | `.636103` | `3.34e−16` |
| Two-dimensional states/observations, correlated noise and controls, mixed | `.325176` | `2.23e−16` |
| Same matrix model, observed only | `2.78e−16` | `2.78e−16` |

In the scalar one-missing case `A=C=1`, `P^-=1`, `Q=R=1`, `S=0`, the actual
extracted source returns filtered covariance `.5`, next-state covariance `1.5`
and output variance `1.5`. Direct Gaussian marginalization requires `1`, `2` and
`2`, respectively. The candidate returns those exact values. Six missing steps
make the original error accumulate rather than resolve. In all observed-only
cases, original and candidate stored state/covariance arrays are bitwise equal;
the difference arises specifically from missing-observation conditioning.

## Why the learned cross-covariance must remain

NFourSID's fitted model need not have independent process and measurement noise.
In the package convention,

$$
 x_{t+1}=Ax_t+Bu_t+w_t,\qquad y_t=Cx_t+Du_t+v_t,
 \qquad \operatorname{Cov}\begin{pmatrix}v_t\\w_t\end{pmatrix}
 =\begin{pmatrix}R&S^T\\S&Q\end{pmatrix}.
$$

Let `m_t^-` and `P_t^-` describe the state conditional on earlier observations.
Assume Gaussian noise pairs independent across time and from the past. Before
observing `y_t`, the covariance of the joint vector `(x_(t+1),y_t)` is

$$
 \begin{pmatrix}
 AP_t^-A^T+Q & AP_t^-C^T+S\\
 CP_t^-A^T+S^T & CP_t^-C^T+R
 \end{pmatrix}.
$$

This is the L01 joint-Gaussian conditioning bridge. With
`V_t=CP_t^-C^T+R` nonsingular and
`e_t=y_t−Cm_t^-−Du_t`, conditioning the next state gives

$$
 m_{t+1}^-=Am_t^-+Bu_t+(AP_t^-C^T+S)V_t^{-1}e_t,
$$

$$
 P_{t+1}^-=AP_t^-A^T+Q
 -(AP_t^-C^T+S)V_t^{-1}(AP_t^-C^T+S)^T.
$$

The current-state filtered gain is still `P_t^- C^T V_t^(-1)` because `x_t`
is independent of the current noise pair before its observation. The extra `S`
term belongs to the **next-state** conditional prediction: the current
measurement also informs the correlated process noise leading to that next
state. For `S=0` this reduces to the familiar independent-noise
condition-then-predict calculation. If `y_t` is absent, there is no conditioning;
retain the current prior and propagate `AP_t^-A^T+Q`, preserving all learned
parameters. The code uses pseudoinverses; these particular oracle cases have
nonsingular measurement-conditioning covariances.

A controlled counterfactual on the same correlated matrix diagnostic sets only
`S` to zero in the candidate while retaining `A,B,C,D,Q,R`. It then disagrees
with the original joint Gaussian by up to **`.114128` in next-state mean** and
**`.084210` in covariance**. This demonstrates why dropping the learned
cross-covariance to simplify the explanation would change the model. The repair
itself keeps `S` intact and matches the complete oracle. These small constructed
Gaussian diagnostics establish computation, not a new course dataset or an
empirically selected forecasting model.

## Keeping the existing package-backed Oke workflow

Oke's original starter/solution and the existing handoff retain their identities
and remain unedited. The practical sequence can remain **fit with the package →
forecast with prepared calls → check forecasts**. Students need not recreate the
package internals, N4SID or this validation harness.

A later prepared integration can keep the complete fitted `A,B,C,D` and joint
noise covariance, then provide a corrected nfoursid-compatible filter through
Darts' documented `kf` hook. An injected filter is copied by Darts; `.fit()` is
still called to register the series even when that injected model is already
specified. The adapter can be prepared by the author around the source workflow,
with the fitting role and Gaussian calculations exposed at the agreed depth.
Alternatively, a vetted upstream version can supply the corrected missing branch.
Neither route requires a hand-specified seasonal model or dropping N4SID fitting.
No adapter was installed or validated against actual Darts here; compatibility,
copying of the complete learned covariance and output schema remain integration
checks, not settled claims.

The retained Darts sampling code draws separately from each time's output
Gaussian marginal. Thus an empirical 5%/median/95% band is a **pointwise forecast
summary**. Matching state/output moments does not turn those sample columns into
joint temporal trajectories, and it does not account for uncertainty over fitted
model parameters. After real integration, verify moments and marginal quantiles;
use a fixed seed if sampling is retained and distinguish its finite-sample noise
from model/rank differences. Forecasts also need the previously identified
quantile-API, scoring and date repairs. No smoother objective is introduced.

## Validation boundary and next owner

The run used Python **3.12.13**, NumPy **2.0.2** from the existing isolated uv
course environment. Direct attempts to import pandas, Darts and nfoursid each
raised `ModuleNotFoundError`, recorded verbatim. No package or lock file changed;
no original Oke source, installed package, other repository artifact, full Scope,
student notebook, section or slide was written. The exact snapshots and licenses
are preserved solely to make this author check auditable.

**Completed:** released-source identity check, exact extracted-method defect
reproduction, minimal candidate, independent Gaussian oracle, repeated-missing and
observed-update checks, nonzero-`S` bridge, retained-output-moment checks and raw
results. **Still required for a publishable worked solution:** an authorized
package/runtime integration, corrected source-notebook interfaces/scores/dates,
clean top-to-bottom local and hosted Colab runs, empirical forecasting evaluation
and a bounded learner-workload check. This validation supplies no final dataset,
package pin, mathematical depth or timing approval. All correctness and integration
repairs remain author-owned; consequential depth/extent changes return to the
coordinator only when the concrete worked solution exposes a teaching tradeoff.
