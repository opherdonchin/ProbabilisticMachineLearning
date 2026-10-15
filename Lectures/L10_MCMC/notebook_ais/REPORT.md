# L10 bounded AIS feasibility pilot

**Result: technically coherent and useful with an explicit limitation.** AIS can extend the supplied L09 Gaussian proposal and teach how an invariant Markov move can help importance weighting without requiring equilibrium at every temperature. On the frozen two-dimensional Challenger problem, direct importance sampling is empirically more accurate at the tested density budgets. Do not promise an AIS advantage on that application. One transparent Gaussian mechanism diagnostic does show a benefit from HMC moves when the initial proposal misses target mass; it is an algorithm check, not practical familiarity with a second learning problem.

This is worked-solution-authoring / bounded feasibility-build evidence, 2026-10-15, branch `investigate/l10-ais-pilot-20261015`, base `13b209b`. The instructor has selected AIS as the one-hour notebook direction. Dataset, kernel, student workload, full Scope and publication are unapproved. Only `Lectures/L10_MCMC/notebook_ais/` was written. No fitting search, environment change, new student notebook, live slide, Scope or map change occurred. This is author evidence requiring later review, not an independent feasibility review or a measured learner trial.

## Learning target and fixed problem

The recognizable task remains the L09 prediction of any thermal distress on a flight, conditional on temperature and the historical data. The computational goals are (1) correct a supplied approximate posterior by weighted independent trajectories, and (2) measure task-query error against computation rather than equating weight ESS with accuracy. AIS and HMC are different objects: AIS defines a weighted path estimator; MH or HMC supplies its invariant intermediate transition.

All 23 flights, seven binary positives, use the **erosion-or-blowby** response, not erosion-only. Data SHA256 `7f38e97b501414fe1c08dfef29432065f0114ed997f5099ce28036086ef1c236`. The supplied UCI data/documentation retain the L09 attribution to David Draper (1993), DOI [10.24432/C5PW2T](https://doi.org/10.24432/C5PW2T), CC BY 4.0; no new metadata claim was fetched here. Fixed model:

$$
x(T)=(1,(T-c)/h),\quad c=69.56521739130434,\quad h=6.901959941907628,\quad w\sim N(0,4I_2),
$$

$$
y_i\mid w\sim\operatorname{Bernoulli}(\sigma(x(T_i)^Tw)),\qquad
r(T)=E_{p(w\mid D)}[\sigma(x(T)^Tw)].
$$

Pressure is omitted by construction. Standardization and prior are not changed. Use the five frozen temperatures 31, 53, 60, 70 and 81°F; 31°F is outside the observed 53–81°F range. Thermal distress is not catastrophic failure, and the exercise supplies no operational launch loss or evidence of calibration. No holdout evaluation is claimed.

`frozen_inputs.json` copies the exact diagnostic **full-family** VI fit and existing reference from `f64fb54` at `/tmp/pml-l09-geometry-20261015`. It includes source-file hashes, diagonal fit only as provenance, and reference qualifications. No optimizer is rerun. The inherited full q has mean approximately `(-1.0724,-1.6358)` and covariance eigenvalues `.2603,.4650`; exact entries are in that file. It is the L09 **supplied full-family comparator**, not a reuse of the student's proposed diagonal implementation. The reconciled L09 handoff at `39dd5dc` makes that distinction explicit.

The numerical reference is the prior audit's radius14/step.02 grid. Its predictions are `.98310503,.88951368,.73134175,.24954835,.04386730`. Existing mesh refinements, tail-envelope evaluation and independent review `dcf2a81` support those bounded queries without providing interval certification of arbitrary moments or tails. This pilot copies the reference rather than rerunning a high-dimensional-looking grid exercise.

## Route, validity and implementation

The target supplied to the algorithm is

$$
f(w)=\exp\left[\sum_i\{y_i x_i^Tw-\log(1+\exp(x_i^Tw))\}-\|w\|^2/8\right].
$$

It omits the constant of the `N(0,4I₂)` prior, matching L09's reference `log∫f=-9.797261242957145`. To interpret an estimated normalizer as marginal likelihood, subtract `log(8π)` from its log first. The posterior-query ratio is unaffected by that constant. The script works in `w=m+Lz`, carrying `log|L|` in the transformed target, with the normalized standard Gaussian base q in z coordinates. This gives a fixed coordinate system for both MH and HMC; no data/prior is redefined.

[source_check.md](source_check.md) gives exact verified Murphy readings, printed source errors and the corrected forward indexing. With `f_β=q^(1−β)f^β`, each step adds

$$
\log W\mathrel{+}=(\beta_t-\beta_{t-1})[\log f(X_{t-1})-\log q(X_{t-1})]
$$

**before** the transition preserving `π_{β_t}`. The last transition is omitted. Return

$$
\widehat Z=N^{-1}\sum_i W_i,\qquad
\widehat r(T)=\frac{\sum_i W_i\sigma(x(T)^Tw_i)}{\sum_i W_i}.
$$

The first estimator is unbiased under the stated exact-base/invariant-kernel/support/integrability assumptions; the posterior expectation is a finite-sample biased ratio. Invariance is a property of a transition and its target law, not a statement that its current input is equilibrated. Independent AIS trajectories may still produce unstable weights. Larger bridge counts do not guarantee smaller error per unit computation.

There is a consequential tail qualification even on this easy application. In original w coordinates, the logistic log likelihood has at most linear tail order, whereas `log f=-||w||²/8+O(||w||)`. For inherited Gaussian covariance C,

$$
\log[f(w)^2/q(w)]
=w^T(\tfrac12C^{-1}-\tfrac14 I)w+O(\|w\|).
$$

Both eigenvalues of C are below2. The quadratic term is positive definite, so **direct IS weights have infinite second moment** although their mean exists and q covers the target support. The bounded prediction estimator remains consistent under first-moment conditions, but a usual finite-weight-variance CLT/error-bar argument is unavailable. Our 24-replicate RMSEs describe this finite seeded experiment; they do not establish a finite weight/normalizer variance or rule out rare disastrous weights. A bounded self-normalized prediction still has finite variance at each fixed sample count. No analogous finite-variance guarantee for the AIS kernels is asserted. We did not silently inflate/replace q to eliminate this finding.

## Fixed run and numerical evidence

[ais_pilot.py](ais_pilot.py) runs top to bottom using NumPy/SciPy in the existing uv environment; no packages are installed. The run was predeclared as budgets 4096 and 32768, bridge counts 8 and 32, 24 seeds 2100–2123, one symmetric Gaussian random-walk MH move per intermediate temperature (scale .9), or one HMC move (step .3, four leapfrog steps). No tuning search followed. Direct IS uses the same q and task queries. No resampling or adaptation occurs. One Gaussian diagnostic uses only the larger budget.

The budget counts individual target-density evaluations. HMC also evaluates a gradient at each such point; those counts and wall time are reported separately. This is a comparison of work vectors, not a claim that a gradient is free or all method costs are identical. Proposal draws, q arithmetic, query evaluation and fitting cost are not included in the density-call budget; fitting is common inherited input, and wall time includes the implemented run/query work. Vectorized short timings depend strongly on this machine/batching and do not measure scaling or learner time.

At approximately 32768 target-value calls, with the fixed full q:

| Method | Trajectories | Gradient calls | RMSE of r(60°F) | Relative normalizer RMSE | Median weight ESS / N |
|---|---:|---:|---:|---:|---:|
| Direct IS | 32768 | 0 | .00130 | .00289 | .892 |
| AIS, MH, 8 stages | 4096 | 0 | .00293 | .00490 | .949 |
| AIS, MH, 32 stages | 1024 | 0 | .00581 | .00380 | .985 |
| AIS, HMC, 8 stages | 1129 | 32741 | .00452 | .00348 | .989 |
| AIS, HMC, 32 stages | 262 | 32750 | .01015 | .00414 | .997 |

The same qualitative query ordering appears at the smaller budget. AIS improves weight uniformity, but trades independent trajectories for intermediate work; a larger ESS **fraction** does not compensate for fewer trajectories. At 60°F, the supplied full-VI probability `.73299355` differs from the reference by `.00165180`. Direct IS at32768 calls modestly reduces empirical RMSE below that fixed proxy error; most tested AIS settings do not. At4096 direct IS RMSE is `.00320`, larger than that proxy discrepancy. Correction is asymptotic, not guaranteed at each budget or query. Detailed seed errors, bias/SD/RMSE, acceptance, exact call counts and timings remain in [results.json](results.json) and [execution.txt](execution.txt); no adverse run was discarded.

The one course-constructed mechanism diagnostic has `q=N(0,I₂)` and unnormalized `f(w)=exp(-((w₀−3)²+4w₁²)/2)`. Analytically `Z=π`, `E_p[w₀]=3`, `E_p[(w₀−3)²]=1`. At the larger budget, direct IS gives empirical mean-query RMSE `.264` and relative-normalizer RMSE `.174`; HMC-AIS 8 gives `.0787/.0964`, HMC-AIS 32 `.0711/.0567`. Its MH alternatives are weaker (`.295/.242` and`.194/.221`). This shows how intermediate motion can help a deficient base; it does not establish an AIS/HMC guarantee or a high-dimensional learning example. Even here 24 replicates are limited: direct IS has analytic normalizer relative SD `.6114` at N = 32768, larger than the observed replicate spread. The exact second moment is `exp(9)/(sqrt(.25)sqrt(1.75))`; rare weights make short empirical comparisons optimistic.

Meaningful algorithm checks passed: full target gradient versus central differences maximum error `2.16e−10`; momentum-flipped leapfrog involution error `2.22e−16`; no-move schedule telescopes to direct IS within `3.56e−15`; equal-base/target constant-weight identity is exact to displayed precision. The analytic Gaussian references check both normalizer and two independent query types. These are correctness evidence, not a convergence certificate. Murphy's printed move-before-weight instruction is separately refuted by an analytic one-step Gaussian example in the source record.

## Provisional handoff and workload discussion

**Reference implementation:** `ais_pilot.py`; entry points `run`, the explicit logweight loop, supplied `mh_move`/`hmc_move`, and `Problem.target`. Starting information is the fixed data/prior/query plus supplied full q and bounded numerical reference. The solution sequence reads those objects, implements logweight accumulation and self-normalization, runs one short fixed experiment, and compares actual query error/cost. New computational operations are logsumexp stabilization, an array of independent particles, and supplied invariant transition calls. Students do not fit q again, construct HMC, derive a numerical reference, or choose a dataset.

| Proposed work | Minutes | Student contribution / supplied support |
|---|---:|---|
| Recover L09 task, query and supplied q | 7 | Interpret frozen values; full fit/reference/data loading supplied |
| Direct IS and baseline error | 9 | Complete logratio and self-normalized query estimate |
| AIS bridge and one correct ordering | 16 | Complete β increments/logweight loop; both invariant kernels supplied |
| Execute fixed comparison | 10 | One configuration; replicate grid/results scaffold supplied |
| Query error versus work; Gaussian mechanism | 10 | Compare given full evidence and the single supplied diagnostic |
| Consolidate validity and limits | 5 | Distinguish Z versus ratio, invariance versus equilibration |
| Reserve | 3 | Technical/questions margin |
| **Total** | **60** | **Provisional, unmeasured** |

This is a workload proposal, not solved-Q&A or student-notebook production. It retains one AIS implementation target. Simultaneous student MH/HMC implementation would be a substantial extra algorithm exercise and is not funded. If the lecture has not prepared the bridge/weight/invariance distinction, 16 minutes is precarious; further reduction of student mathematics requires Scope backpressure, not an unannounced authoring shortcut.

Useful controlled manipulations are **identity moves**, which telescope exactly to ordinary IS, and the two supplied bridge lengths, which reveal the cost/particle tradeoff. The Gaussian mechanism is explicitly constructed and supplied. No new sensitivity sweep, new dataset, NUTS implementation, importance-resampling sampler, independent HMC-chain diagnostic exercise, model selection or heldout-risk interpretation is included.

**Decision returned to the coordinator:** the AIS direction is computationally feasible with supplied transitions, but Challenger is an honest example of an already useful q rather than a compelling AIS payoff case. The smallest faithful continuation retains Challenger, uses the single supplied analytic mechanism check, and teaches conditional benefit. If the required endpoint is a demonstrated practical AIS accuracy-per-cost improvement on ML data, the target/application contract must be reopened before production; this pilot does not select a replacement dataset. The diagonal-student/full-supplied L09 continuity remains an owning Scope decision.

Only local script execution was checked. No learner run, solved-Q&A notebook, locked notebook execution check, hosted Google Colab runtime, publication, or whole lecture feasibility approval is claimed. Final notebook work must pass the repository's local uv and fresh hosted Colab checks after the teaching contract is approved. Source corrections and finite-variance qualifications must survive that handoff.
