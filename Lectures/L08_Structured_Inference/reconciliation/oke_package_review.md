# Oke forecasting notebook: source and package feasibility review

**Stage/mode:** worked-solution source/package feasibility review, 2026-10-16.
**Target:** accepted existing-notebook-first handoff at `0c9ae3c`; review branch
`review/l08-oke-package-20261016`, worktree
`/tmp/pml-l08-oke-package-review-20261016`. Sole write: this report. The same
specialist previously recorded the handoff; this is an author technical check,
not an independent review of its own pedagogical choices.

**Verdict: feasible-with-risks for the accepted approach; not ready as a validated
worked solution.** Keep Oke's fitted-model forecasting workflow and explain/check
the mathematics around its prepared calls. Reimplementation by students is not
required. Three substantive author tasks precede reuse: match the walkthrough to
the package's correlated-noise model; repair/validate missing-observation forecast
covariances; and modernize the quantile/scoring/date interfaces. The available
locked environment cannot import the source's required packages, so no clean
notebook execution or hosted Colab check is claimed. These are author-owned
correctness/runtime repairs, not reasons to replace the chosen approach or ask
the instructor to approve incorrect mathematics.

## Target and source identity

The intended demonstration transfers categorical predict/condition messages to
Gaussian time-series inference, then uses a fitted model to produce and evaluate
forecasts. Observed quantities are daily website sessions and timestamps/device
labels. Latent states and their conditional covariance are computed under an
estimated model. State dimension is externally selected; dynamics and residual
noise covariance are fitted. Predictive sampling approximates marginal quantiles;
it is not Bayesian integration over fitted-model uncertainty.

The local reference root is
`/home/opher/OneDrive/CurrentSemester/Teaching/Advanced Bayesian Statistics/Oke Advanced Probability Course/spring-2026/`.
No student submissions were read and no external person was contacted.

| Source relative to that root | Identity and inspected content |
|---|---|
| `PS2/PS2-kalman-forecasting.ipynb` | 13 cells; SHA256 `8d1b9d23e1caefff7e53bfd134879b3e56da871b01da728067bc6fd3949e0dd2`; all source cells and relevant stored text inspected. |
| `PS2/PS2-kalman-forecasting-solution.ipynb` | 33 cells; SHA256 `44e877e75bdc2b04a2ad5d067785d38e8f7942d80731b46ca1770404f05fb79c`; all source cells and relevant stored text inspected. |
| `PS2/PS2-Questions/CEE790A-PS2.tex` | SHA256 `838540ec8b1ff0d0718b34820046dfb69bfb1de44f74d3bfcb1be0f27c13da2e`; Problem 3, lines 301–310, assigns device forecasting, dimension comparison and a late-2018 spike. |
| `Lectures/M2-Inference-Algorithms/M2a-Gaussian-Filtering-and-Smoothing/M2a-Gaussian-Filtering-Smoothing.tex` | SHA256 `c6c7a3c68b2e177a406f34cf493b2880b7411fc6eac75a2db49a55c7b56785bd`; general Bayes filtering, Gaussian predict/update and observation prediction. RTS is only an outlook bullet, lines 518–527. |

The notebooks are directly under `PS2/`, not its Questions/Solutions subfolders.
The earlier source-absence inference has already been corrected in the owning
handoff; this review does not overwrite the original raw investigation. The
notebooks' metadata says Python 3.11.8; saved execution counts are nonmonotonic
and no dependency versions are pinned there. Saved outputs are not current
clean-run evidence.

## What fit actually estimates, and the mathematics to expose

The starter's cell 7 and solution's cell 16 construct a Darts
`KalmanForecaster`, call `.fit(series=series)`, then `.predict(h,num_samples=100)`.
With no supplied filter or covariates, Darts delegates fitting to NFourSID.
Its [fit implementation](https://github.com/unit8co/darts/blob/8485efe592b33f95e2db500378e1d1b35b8defc1/darts/models/filtering/kalman_filter.py#L127)
uses subspace identification and asks for rank `dim_x`. The
[NFourSID implementation](https://github.com/spmvg/nfoursid/blob/26266031afd34aea1b1af23b8593d60aeb8a770e/src/nfoursid/nfoursid.py#L132)
identifies state-space matrices by least squares on a subspace state estimate and
forms a residual covariance with off-diagonal blocks. It is not a posterior over
those matrices, nor a guarantee of a global likelihood optimum or correct model.

Using package notation, and omitting absent controls, its working model is

$$
 x_{t+1}=A x_t+w_t,\qquad y_t=Cx_t+v_t,\qquad
 \operatorname{Cov}\begin{pmatrix}v_t\\w_t\end{pmatrix}
 =\begin{pmatrix}R&S^T\\S&Q\end{pmatrix}.
$$

Here `S=Cov(w_t,v_t)`. It need not be zero: the fit estimates it, and the
[nfoursid Kalman implementation](https://github.com/spmvg/nfoursid/blob/3a5e75e3840c5b643e47d5cdc9435af879ebb578/src/nfoursid/kalman.py#L62)
retains it in the next-state gain. Assume the Gaussian working law, independent
noise pairs across time and independence of the current pair from the past.
For a prior state mean `m_t^-` and covariance `P_t^-`, set

$$
 V_t=CP_t^-C^T+R,\qquad e_t=y_t-Cm_t^-.
$$

L01 conditioning on the current observation gives

$$
 m_t^+=m_t^-+P_t^-C^TV_t^{-1}e_t,\qquad
 P_t^+=P_t^--P_t^-C^TV_t^{-1}CP_t^-.
$$

But the next-state prediction after seeing that observation is

$$
 m_{t+1}^-=Am_t^-+(AP_t^-C^T+S)V_t^{-1}e_t,
$$

$$
 P_{t+1}^-=AP_t^-A^T+Q
 -(AP_t^-C^T+S)V_t^{-1}(AP_t^-C^T+S)^T.
$$

These follow by conditioning the joint Gaussian of `(x_(t+1),y_t)`, whose
cross-covariance is `AP_t^-C^T+S`. These displayed inverses assume nonsingular
`V_t`; the source uses pseudoinverses. Numerical conditioning, covariance
symmetry/positive semidefiniteness and any degenerate directions belong in the
author checks. The independent-noise predict-after-condition
formulas in the provisional handoff are the `S=0` special case. They must not be
claimed to reproduce a general fitted package model unchanged. The smallest
source-preserving repair is to show the noise block and this conditional-Gaussian
bridge, explaining `S` at the required role depth. No student N4SID derivation or
new sampler is necessary. A package/model adapter is an author implementation
option if a simpler representation is later justified, not a reason to discard
fitting by default.

State dimension is the fitted realization's rank, not the observed series width,
a count of physical causes or an interpretable set of weekday states. The
notebooks fit each device separately. Larger rank changes fitting capacity and
cost; it need not improve validation error. A state-space realization can be
transformed by an invertible change of coordinates without changing observations,
so individual fitted coordinates need not have a unique domain interpretation.
Darts' code uses `num_block_rows=max(10,dim_x)` despite nearby prose saying a
maximum of ten; the dimension sweep also changes subspace-fitting matrices. Do
not use that prose to promise fixed fitting cost for ranks 50–500.

## Forecast output semantics and a blocking covariance defect

The [forecaster source](https://github.com/unit8co/darts/blob/4b0b72fa03580ec39f7beee35b40912485a1bb54/darts/models/forecasting/kalman_forecaster.py#L175)
appends `h` missing future observations, filters the combined historical/future
series, and returns its last `h` outputs. Thus the source's first-2019-quarter
forecast is made at one origin. It does not update on each observed validation
day. There is no backward smoother. Returned values describe output-space
quantities, not latent state vectors; draws include measurement-noise covariance.

**Author-owned, blocking before presenting forecast bands as correct:** in the
inspected released nfoursid 1.0.2 `Kalman.step`, the mean update is skipped when
an observation is absent, but the covariance subtraction is still performed.
See pinned `kalman.py` lines 107–135. Darts deliberately sends absent observations
for every forecast step and subsequently samples using
`C P_filtered C^T+R` (pinned Darts filter lines 235–253). The code therefore
conditions covariance on an observation that was never received.

A direct scalar counterexample requires no fitted dataset or execution. Take
`A=C=1`, `P_t^-=1`, `Q=R=1`, `S=0`, and no observation at time `t`:

| Quantity | Correct missing-observation law | Inspected source algebra |
|---|---:|---:|
| Current state covariance | `1` | `1−1/2=1/2` |
| Next prior state covariance | `1+1=2` | `1+1−1/2=3/2` |
| Current output predictive variance | `1+1=2` | `1/2+1=3/2` |

Without an observation, there is no conditioning event. The correct branch keeps
`m_t^+=m_t^-`, `P_t^+=P_t^-` and propagates
`m_(t+1)^-=A m_t^-`, `P_(t+1)^-=A P_t^- A^T+Q` (plus supplied controls if any).
This counterexample establishes a source-level defect at the recorded version;
it is not a claim that the whole package was imported or the notebook executed.
The released wheel's module is byte-identical to the inspected pinned source.

**Smallest practical repair:** retain the existing fitting and forecasting
workflow, but use an author-prepared corrected missing-observation branch or a
vetted version/adapter that preserves those missing-step moments. Verify it
against joint-Gaussian conditioning on a tiny supplied model, including nonzero
`S`, and against prediction-only covariance propagation over several future
steps. Supply this prepared correction; students need not rebuild the package.
Do not silently drop uncertainty evaluation or call an unchanged defective branch
validated. Point forecasts can remain useful evidence while variance claims wait
for this repair; no new application or smoother is needed.

The [Darts filter sampling loop](https://github.com/unit8co/darts/blob/8485efe592b33f95e2db500378e1d1b35b8defc1/darts/models/filtering/kalman_filter.py#L227)
draws separately from each time's Gaussian marginal. The sample index does not
constitute a coherent joint time-series trajectory. The source's pointwise
quantile bands are the compatible use; joint excursion probabilities or temporal
path dependence cannot be inferred from these sample columns. One hundred draws
also make 5%/95% empirical quantiles noisy. Prepared fixed seeds and a check against
analytic Gaussian marginal quantiles can expose sampling error without requiring
Monte Carlo implementation by students. None of these bands integrates over the
uncertainty of the fitted state-space matrices.

## Source-preserving repair specification and checks

All cell indices below are zero-based. Repairs are author responsibilities;
none changes the accepted authoring approach or requires instructor permission
for mathematical correctness.

| Evidence | Smallest repair | Verification needed before reuse |
|---|---|---|
| Starter cell 10 sends forecast median before observations to MAPE. | Pass observed `Sessions` as `y_true`, prediction as `y_pred`. | Hand-check a small asymmetric percentage-error example. Reversed MAE in solution cells 16/21 is numerically harmless because MAE is symmetric. |
| Starter 11 / solution 24 loop over `.05,.5,.95` but omit pinball `alpha`. | Set `alpha=q`; preserve the source's quantile forecast comparison. | Check the asymmetric residual penalty at one tail quantile; API default `.5` is not a tail score. |
| Every forecast helper uses removed `quantile_df`. Current Darts 0.48.0 has `quantile(q).to_dataframe()` with different names. | A prepared extraction/rename helper yielding the source's consistent quantile columns, or a deliberately vetted compatible version. | Assert time/device/quantile column schema before scores/plots. Current `quantile` components use suffixes such as `_q0.050`, not the old `_0.05`. |
| Source uses 100 draws without a fixed seed and scores sample medians. | Supply a reproducible package seed; compare sample quantiles with conditional Gaussian values after covariance repair. | Separate sampling fluctuation from rank/model differences; do not interpret one noisy ordering as a universal dimension result. |
| Solution cells 17/22 sweep six ranks; 21 refits all devices for each desktop score. | Retain the dimension comparison; cache/reuse prepared fits or summaries where repeated work is redundant. Exact retained extent remains open. | Measure actual fit time and memory in the selected runtime; inspect numerical rank/stability and independent evaluation after validation-based selection. No runtime estimate is supplied by this review. |
| Question 3(e) says late 2018; solution 27 uses training before 2017-11-01 and validation to 2018-01-31; 29 reuses `h=90`. | Reconcile intended event/date against the actual plot/question, then derive the horizon from that chosen validation window. | Ensure pre-event data only enter fitting and every forecast timestamp has the intended scored observation. This review selects no replacement event. |
| Starter 3 / solution 3 append two zero tablet rows; series creation fills missing dates with zero; plot renaming uses slices. | Explicitly check missing-date semantics, duplicate dates, device ordering and merge keys; use a safe prepared copy/rename for plots. | Unique date/device keys; no unexplained missing-as-zero conversion; correctly matched device labels. Original zero-fill policy is a modeling/preparation assumption, not an inference identity. |

The metric signatures were checked against official
[MAPE](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.mean_absolute_percentage_error.html)
and [pinball-loss](https://scikit-learn.org/stable/modules/generated/sklearn.metrics.mean_pinball_loss.html)
APIs. The current [Darts quantile source](https://github.com/unit8co/darts/blob/05192e9b9e7ed5d0bcabc27543424bd2776b3ce4/darts/timeseries.py#L4829)
computes quantiles over the sample axis; this confirms their marginal meaning.

## Compact source → mathematics → call → check map

This is a technical handoff map, not a student-question sequence or full Scope.
Its role is to make the existing calculations explainable with supplied code.

| Source cells | Mathematics/reasoning and depth | Existing prepared calculation | Meaningful check/output |
|---|---|---|---|
| Starter 3/6; solution 3/14 | **Work/interpret:** observation units, date/device index and zero/missing distinction. | Aggregate daily sessions and construct Darts series. | Aligned, unique daily observations; three correctly labeled device series. |
| Starter 4; solution 9/12–13 | **Work:** forecast-origin information set and ninety-step horizon. | Existing time split and horizon. | Future observations remain outside fitting and forecast updates. |
| Starter 7; solution 16 | **State/interpret:** N4SID's role, fitted rank and full residual covariance; no subspace proof. **Apply/work:** joint-Gaussian conditioning with the `S` cross-block at an agreed bounded depth. | Existing `.fit()` and prepared internal-model inspection. | Correct model-to-equation correspondence; state uncertainty distinct from fitting uncertainty. |
| Same forecasting cells | **Apply/work:** repeated prediction without future observation conditioning. | Existing `.predict()` through a corrected/vetted missing branch. | Conditional output means/covariances agree with a tiny analytic check; horizon propagation makes sense. |
| Solution 17/21–23 | **Work/interpret:** capacity, computation and validation error; no general ranking theorem. | Existing dimension comparison, with reusable prepared fits. | Validation curve and actual fitting cost; do not spend independent test data choosing rank. |
| Starter 10–12; solution 24–25 | **Apply/work:** point error, quantile loss and marginal forecast intervals. | Corrected extraction/scoring/plotting. | Analytic-versus-sampled marginal quantiles, units, interval failures and baseline meaning. |
| Solution 27–32, if retained | **Interpret/work:** limits of pre-event forecasting and horizon choice. | Source's existing pre-spike helper after date repair. | Genuine held-future comparison, without demanding prediction of an unmodeled event. |

Expected useful outputs remain the source's three-device plots, ninety-day
forecast summaries, dimension/validation comparison and optional corrected
pre-event illustration. Their actual values/performance are not reproduced here.
The scalar and seasonal prototype from the earlier investigator is neither the
new source model nor a replacement assignment. No backward objective is added.

## Runtime evidence and exact package record

Read-only checks on the repository Linux uv environment and the already prepared
isolated `/tmp/pml-l04-l12-reconciliation/.venv` both located Python 3.12.13.
The latter's installed distributions match the relevant locked entries:
NumPy 2.0.2, SciPy 1.16.3, scikit-learn 1.9.1, Torch 2.14.0+cpu,
Matplotlib 3.10.0. The lock has no `pandas`, `darts`/`u8darts` or `nfoursid`
entry. Direct import attempts in that isolated environment returned:

```text
pandas ModuleNotFoundError("No module named 'pandas'")
darts ModuleNotFoundError("No module named 'darts'")
nfoursid ModuleNotFoundError("No module named 'nfoursid'")
```

Thus even the source's first pandas import cannot pass. No source notebook was
executed, no dependency installed and no environment/lock/source file changed.
Wheel contents were inspected in memory as source, not installed or imported.
A later authorized environment update must follow the repository's direct-dependency,
lock, local clean-run and hosted-Colab policy; this review does not perform it or
infer Colab compatibility from Python-version compatibility.

On 2026-10-16 PyPI reported Darts **0.48.0** and nfoursid **1.0.2**. Darts' wheel
requires Python >=3.11, nfoursid >=1.0.0, pandas >=2.2.0 and NumPy >=1.26.0;
these metadata constraints do not establish a validated course dependency set.
The former `u8darts` project reports 0.41.0; do not confuse that name/version with
the inspected current `darts` distribution. No version is selected for the course.

| Inspected distribution/source | Exact identity |
|---|---|
| [Darts 0.48.0 wheel](https://files.pythonhosted.org/packages/a4/a6/4b10449add8d3bde8ebc3bdf96da6357b7a4177df26b7ff74ca3c816ee23/darts-0.48.0-py3-none-any.whl) | SHA256 `27dd67793987c5e5092a462cd99784ff149b9acbb4ff68430e7d2c8cffb6a000` |
| [nfoursid 1.0.2 wheel](https://files.pythonhosted.org/packages/8d/36/fae16163620cbf04de0e50f67d946782ff4964e65276852dceea8a3c655a/nfoursid-1.0.2-py3-none-any.whl) | SHA256 `2b51f319346a65bd2a66554d9bfd7846feb9ad359fad678566dfa3f124eace70` |
| Darts `kalman_filter.py` | SHA256 `fb2004c021d947d8fffb9ce11b09b9417412b1a48e0c1b4d6f6f1ae081a4b154`; byte-identical to last-file-change commit `8485efe592b33f95e2db500378e1d1b35b8defc1` |
| Darts `kalman_forecaster.py` | SHA256 `c4a7ddc778317b94620802a48cc9a2598ba45a2d8d07d391dd0d352162f2e4a8`; byte-identical to `4b0b72fa03580ec39f7beee35b40912485a1bb54` |
| Darts `timeseries.py` | SHA256 `3f2b5669bb1d2fbe4d35be34bab88373546a59f4976088ba9bc35e06f7d1abce`; inspected repository head `05192e9b9e7ed5d0bcabc27543424bd2776b3ce4` |
| nfoursid `kalman.py` | SHA256 `f3ae6d2f597a682313159c202575b3b5f0e5341eff816f719d1948e70ff4bfec`; byte-identical to `3a5e75e3840c5b643e47d5cdc9435af879ebb578` |
| nfoursid `nfoursid.py` | SHA256 `a3e32e6d08c4ca7ea7d247111841b3e5bbd44f0b4daf05686615ab892f309565`; byte-identical to `26266031afd34aea1b1af23b8593d60aeb8a770e` |

The line references above use the pinned Python files, not generated-document
line numbering. Primary API explanations also inspected:
[Darts forecaster](https://unit8co.github.io/darts/_modules/darts/models/forecasting/kalman_forecaster.html),
[Darts filtering](https://unit8co.github.io/darts/_modules/darts/models/filtering/kalman_filter.html),
[nfoursid Kalman](https://nfoursid.readthedocs.io/en/latest/source/kalman.html),
[nfoursid identification](https://nfoursid.readthedocs.io/en/latest/source/nfoursid.html).

## Handoff and remaining ownership

The accepted package-backed walkthrough remains viable. Worked-solution
implementation owns the correlated-noise correspondence, corrected forecasting
covariance, API/scoring/data/date repairs, seeded checks, dependency resolution
and clean local/hosted execution. These can be prepared without student package
reimplementation. Runtime and measured learner extent remain unvalidated.

Lecture Scope retains the consequential choices: mathematical treatment depth of
the correlated-noise bridge and filtering versus forecast interpretation, exact
retained dimension-comparison extent, final application/performance exercise,
and any later proposed smoother. Return those choices through the coordinator
when concrete worked evidence makes a time/endpoint tradeoff necessary. Do not
ask the instructor to arbitrate formula or API correctness. No new dataset/model,
full Scope, student Q&A, source notebook edit, required smoother, dependency
change, merge or publishing is part of this review.
