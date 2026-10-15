# L09 scope investigation — objective, family and stochastic fitting

**Current application decision, 2026-10-15:** Challenger thermal distress selected
for L09 by the instructor; [owning accepted record](reconciliation/challenger_contract.md).
Reviewed evidence is notebook_geometry/REPORT.md at `f64fb54` and independent
review `dcf2a81`. This supersedes the application-unselected status in the older
joint/classifier evidence below, not its numerical findings. Student/supplied
family allocation and complete Scope remain provisional.

**Current decision, 2026-10-15:** The old shared-classifier selection is replaced
by the instructor's [geometry-led cumulative direction](../course_architecture_scope/reconciliation/notebook_geometry/decision_and_tasks.md),
recorded in the three owning scopes. Existing probes below remain valid evidence
for their exact configurations, not selected notebook examples. Dataset/family
selection awaits the new bounded research. L09's old Gaussian-only comparison
question is deferred for reformulation after family selection; no diagonal or
Gaussian restriction is newly approved.

**Stage/mode:** Lecture Scope / feasibility-review with author-only probes, investigator `/root/investigate_l07_l10`, 2026-10-14; worktree `/tmp/pml-l04-l12-reconciliation`, starting commit `5e4c86e`. Current scope blob `89ee9f324fd0384972ff1ef52c446d6b146367d6`. **Verdict: feasible-with-risks.** [Current scope](lecture_scope.md) remains unchanged. This file owns only the open question below; the shared model choice is owned by [L07-SHARED-CLASSIFIER](../L07_Inference/scope_investigation.md#l07-shared-classifier--awaiting-decision-owner-l07-scope-affects-l07l09l10).

## Actual stochastic evidence

The [pathwise probe](notebook_feasibility/pathwise_probe.py) imports the frozen L07 likelihood, dataset, prior and query arrays. It runs actual fresh-noise, 64-draw stochastic pathwise Adam optimization for 4,000 updates, seeds 10/20/30, for diagonal and full-covariance Gaussian families. Full-covariance training is an author comparison, not a promised second student optimizer. Transparent NumPy Adam independently checks the finite sampled objective against PyTorch autograd. Three further actual PyTorch float64 diagonal runs use the differentiable transform/objective, backward and Adam updates with identical fresh noise/settings; predictive results agree with manual training to `1.2e−16`. These bounded drivers establish technical training feasibility, not a finalized student notebook.

For a global weight posterior `q=N(m,LLᵀ)` with positive Cholesky diagonal and prior `N(0,4I)`, minimized negative ELBO is

$$J(m,L)=E_\epsilon\left[\sum_i\{\log(1+e^{x_i^T(m+L\epsilon)})-y_ix_i^T(m+L\epsilon)\}\right]+\tfrac12\left[\frac{\|m\|^2+\|L\|_F^2}{4}-2+2\log4-2\sum_j\log L_{jj}\right].$$

Average over coefficient-noise draws, sum over all 60 observations, and add one prior KL. Averaging likelihood over data while keeping unscaled KL would fit a different posterior. The direct entropy/scale derivative is included: for diagonal `L=diag(s)`, `s=e^ρ`, the KL scale derivative is `s²/4−1`. Fixed 11-draw noise finite differences agree with analytic gradients within `9.5e−10`; PyTorch autograd agrees within `1.8e−15`. This checks the actual sampled loss, not equality to its population expectation.

[Raw results](notebook_feasibility/pathwise_results.json) distinguish noisy fitting from deterministic author monitoring. A 32×32 Gauss–Hermite objective with independent BFGS diagnostic optimum measures optimizer gaps; it is not the stochastic training route or a proof of global convergence. Diagonal stochastic objective gaps are `.000639,.001084,.002207`; full-family gaps `.001994,.001351,.002039`. Each manual classifier optimization is approximately `.4` seconds locally, actual PyTorch runs about `1.24` seconds (imports excluded). Maximum fixed-query probability errors range `.00258–.00478` for diagonal runs and `.00191–.00355` for full-family runs. The diagnostic optima have maximum errors `.001248` diagonal and `.000310` full; Laplace error is `.014776`. Comparing diagonal VI with full Laplace confounds family and criterion; the supplied full-Gaussian comparison isolates criterion at a fixed family. These small errors and one dataset are not a generic ranking of methods.

The independent exact target `S=[[.5,.4],[.4,.5]]` remains. Best reverse-KL diagonal covariance is `D=.18I`, since `D_jj=1/(S⁻¹)_jj`; minimum KL is `.510826` nats. Variance of the coefficient sum is `1.8` exact versus `.36` diagonal; difference variance is `.2` exact versus `.36` diagonal. Actual stochastic fits on this separate target and analytic optimizer gaps are recorded in the same results. Family error can thus make one linear query too narrow and another too broad; no generic “VI always underestimates uncertainty” claim is supported.

**Validity regime:** differentiable sample transform and dominated derivatives permit differentiating the expectation; the Gaussian-prior logistic objective has bounded logistic likelihood gradients and finite Gaussian moments. Restricted q can fit useful queries without recovering the whole posterior. **Payoff:** gradients require no normalizing constant; diagonal q uses `O(d)` covariance parameters, full q `O(d²)`, with no exponential grid. Repeated queries reuse fitted q. **Error:** family restriction, stochastic unfinished optimization, and approximate integration of a downstream prediction are distinct; a noisy loss trace alone cannot separate them.

## Dependency and knowledge audit

**Assume familiar:** probability/Bayes/expectations, basic NumPy; prior PyMC sampler use does not establish VI implementation skill. **Previously encountered—scaffold:** multivariate Gaussian shapes, L01 linear solves and covariance, prospective L05 Torch backward/updates after three intervening meetings, L06's established bound identity if taught as planned. **New:** optimization parameters versus random weights, coefficient-draw/data axes, pathwise scale connection, correct analytic KL, and optimizer versus family error. Preserve the planned ten-minute refresh. NumPy `@` familiarity does not establish Torch broadcasting or Cholesky parameter manipulation; author full-covariance infrastructure should be supplied.

Live: apply L06 ELBO, work Gaussian reverse-KL geometry, derive total pathwise gradient with direct term, state/bounded work CAVI. Students would assemble one sampled transform/objective, check one fixed-noise gradient and diagnose supplied results. L12 needs this derivative and scale/KL convention; it does not require full covariance, CAVI solver, GDP application or HMC before L10. Existing 112-minute live/60-minute lab budget remains unmeasured. The optional six-minute numerical CAVI sweep is a possible donor, not automatically removed. A shared classifier plus diagnostic must replace current work rather than append two full exercises.

## Open instructor-owned question

### L09-GAUSSIAN-COMPARISON — awaiting decision; owner L09 Scope

**Question:** If the shared classifier is selected, include supplied full-Gaussian VI alongside full-Gaussian Laplace before interpreting diagonal restriction?

**Options:** (A) supplied same-family results plus one student diagonal VI fit; (B) diagonal VI versus full Laplace only, explicitly limiting attribution and relying on the exact Gaussian diagnostic for family effects. **Recommendation:** A. It separates local-curvature fitting from reverse-KL fitting without a second student implementation. B reduces comparison time/software burden but must not attribute every difference to the criterion.

**Evidence:** frozen full/diagonal stochastic probes, fixed-noise derivative checks and exact Gaussian diagnostic above. Full VI differs from Laplace on this non-Gaussian posterior despite both returning full Gaussians. Drawing samples from q is not the distinction; the mathematical fitting objectives are.

**Exactly awaiting:** selection of required comparison output/treatment in L09 scope and its resulting final worked-solution/Section Design handoff. Shared endpoint production separately awaits L07-SHARED-CLASSIFIER. **Independent work completed:** both conditional comparison alternatives, actual stochastic fitting and family/optimizer diagnostic. **Safe remaining work:** independently review objective/gradient/scaling code and pilot supplied-output interpretation workload; no approval inferred.

## Source/review provenance and gates

Rechecked Book 2 *Advanced Topics*, December 10, 2025, §§10.2.1.1 **Gaussian with diagonal covariance (mean field)** and 10.2.1.2 **Gaussian with full covariance**, pp.447–449, and §6.3.5.2 **Total derivative**, pp.276–277. The printed p.448 plus-KL sign and missing constant in Eqs.10.49–10.50 remain flagged; probe uses the corrected objective above. For family geometry read §10.1.2 **Form of the variational posterior**, pp.440–442; CAVI §10.3.1 pp.455–457 is a bounded alternative, not a new solver promise.

Recovered `dd4f2c5` target scope blob `dd7665143dbbcd5af443e6ca54c1a6a4baa9f3fa` and post-review `34049949b4962cd83adcc01cdf016ddfc789733f` record faithful selective source arc, no mandatory repair. They were read, not independently repeated, and never approved this classifier task. Existing [original review](../course_architecture_scope/reviews/L09_review.md) explicitly resolves HMC handoff to recognition, not full theory; do not revive that resolved wording issue as a new prerequisite debt. GDP/noise-estimation preference remains an empirical breadth alternative, superseded only after a recorded instructor choice, not by this probe.

All new scripts passed clean top-to-bottom isolated uv execution, including the actual Torch training path. No finalized student notebook, student-time pilot, section rehearsal or hosted Colab run is claimed. No scope/skill/map was edited. Acceptance remains instructor-owned in lecture_scope.md.
