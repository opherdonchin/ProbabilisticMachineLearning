# L07 scope investigation — fixed-query Bayesian computation

**Stage/mode:** Lecture Scope / feasibility-review with authorized author-only computational probes. Investigator `/root/investigate_l07_l10`, 2026-10-14. Worktree `/tmp/pml-l04-l12-reconciliation`, branch `assess-l04-l12-reconciliation-20261014`, starting commit `5e4c86e`. Current scope target blob `43c403d65e58e1b852517dd7b2785de1f84933e8`. **Verdict: feasible-with-risks.** This file owns the open investigation questions below; acceptance must later be recorded in [lecture_scope.md](lecture_scope.md). No scope or prior instructor choice has been replaced.

## New evidence and its practical meaning

The [reproducible classifier probe](notebook_feasibility/classifier_probe.py) fixes one global two-parameter posterior across L07/L09/L10. Iris versicolor/virginica, sepal length and intercept, stratified 60/40 split with seed 14, training-only standardization, labels 0/1, prior `N(0,4I)`, and five standardized query inputs `−2,−1,0,1,2` are frozen. Raw training/test row IDs, data hash and transformations are in [results](notebook_feasibility/classifier_results.json). This course-constructed restriction is not Murphy's scalar example and is not an approved replacement exercise.

For design rows `x_i`, weights `w=(intercept,slope)`, and sigmoid `σ`, the task is binary probability prediction:

$$p(w\mid D)\propto N(w;0,4I)\prod_{i=1}^{60}\operatorname{Ber}(y_i;\sigma(x_i^Tw)),\qquad r(x)=E_p[\sigma(x^Tw)].$$

The training set supplies experience, the held-out log score evaluates forecasts on new cases, and reference error `|r_method−r_reference|` evaluates computation for this fixed model. These performance criteria are different. Point predictions have slightly better held-out log loss on this split (`.577904`) than checked integration (`.578677`) or Laplace (`.578455`); this does not establish superiority of ignoring uncertainty. The one-feature classifier deliberately overlaps and is not a competitive Iris benchmark. No split, feature or setting was searched to make posterior integration win.

The MAP is approximately `(.05680,1.37129)`; local covariance is `[[.09021,.01409],[.01409,.15276]]`. Laplace's maximum prediction discrepancy across the five queries and 40 test cases is `.014776`. Trapezoidal two-dimensional integration changes by less than `4e−15` in predictions when widening `[-8,8]^2` to `[-10,10]^2` at spacing `.08`, and independently refining spacing to `.04`. These are checked numerical references, not a proof of exact integration or a universal tail bound. Gaussian expectations use Gauss–Hermite quadrature, independently compared at 24/32 nodes per coordinate. The full probe takes about one second locally, but student completion time remains unmeasured.

The proper prior gives

$$\nabla^2[-\log p(D,w)]=\tfrac14I+X^T\operatorname{diag}(p_i(1-p_i))X\succ0.$$

The posterior therefore has one finite mode; it can be skewed or correlated but cannot supply separated-mode exploration evidence. L09 retains its exact correlated-Gaussian diagnostic and L10 its independent bimodal target. Posterior spread of `σ(x^Tw)` is parameter-related uncertainty; Bernoulli outcome variance `r(1−r)` and uncertainty in an estimated Monte Carlo average are different objects.

**Validity regime:** smooth interior mode with positive-definite curvature supports constructing the Gaussian; useful global-query accuracy must be checked separately. **Computational payoff:** a fitted Gaussian amortizes repeated integrals, but dense Hessian storage/factorization scales as `O(d²)/O(d³)`. At `d=2`, checked quadrature is affordable and the exercise demonstrates diagnosis rather than computational necessity. **Task-relevant error:** local fitting may shift posterior-averaged probabilities and miss skew/tails even when held-out classification looks unchanged.

## Prerequisites and knowledge burden

The cumulative [knowledge file](../../.agents/skills/teaching-notebook-authoring/references/student-knowledge.md) establishes entry familiarity, not actual delivery: the actual map remains empty. **Assume familiar:** Bayesian conditioning, likelihood/prior distinction, expectations, basic NumPy/indexing and matrix multiplication. **Previously encountered—scaffold:** Gaussian covariance/precision, multivariate shapes and the meaning of posterior draws; L05's proposed GLM probability fitting is a prospective dependency. **New:** MAP Hessian construction, Laplace density versus query integration, weighted-grid normalization/truncation/refinement, and training-only transformations unless established by accepted L05 materials. Supply fitting/Hessian/quadrature scaffolding rather than require three new numerical APIs. Derive the scalar Taylor construction live, state multidimensional extension, work/use the bounded classifier and read errors.

L07's query/object vocabulary helps L08–L10, but the Laplace algorithm itself is not prerequisite to exact HMM messages or MH correctness. L09 needs L05 AD/SGD and L06's ELBO identity; L12 needs the pathwise derivative, correct scale and KL conventions, not L07's solver. Existing 110 live/60 lab envelopes remain tight unmeasured proposals. The recovered source repair already uses the optional Beta and determinant illustrations as timing donors; they cannot fund another expansion.

## Open instructor-owned questions

### L07-SHARED-CLASSIFIER — awaiting decision; owner L07 Scope, affects L07/L09/L10

**Question:** Should the shared Bayesian classifier become the main practical notebook encounter, with each existing exact/failure diagnostic retained as a short supplied comparison?

**Options:** (A) shared classifier plus bounded scalar/correlated-Gaussian/bimodal diagnostics; (B) retain the existing isolated labs and inspect supplied classifier results only; (C) shared Gaussian regression with exact references. **Recommendation:** A, contingent on a one-hour workload pilot. It provides a fixed learning task against which Gaussian proxies and sampling estimates can be compared. B preserves more implementation/diagnostic depth but less transferable fixed-task comparison. C supplies strongest exact checks, but full Gaussian VI and Laplace coincide on a Gaussian posterior, hiding their different fitting criteria.

**Evidence:** the frozen probe above, [L09 actual stochastic results](../L09_Variational_Inference/notebook_feasibility/pathwise_results.json), [L10 finite-run results](../L10_MCMC/notebook_feasibility/mh_results.json), and [earlier independent assessment](../course_architecture_scope/reconciliation/reviews/L07_L10_assessment.md). Approximation and holdout-score differences are small; this positive-regime example must not be advertised as a dramatic practical improvement or cover every failure mode. This file is the single owning question record; L09/L10 link to it.

**Exactly awaiting:** changing the three authoritative notebook endpoints/model commitments; building their final worked solutions/Q&A/student notebooks; final Section Design decisions that depend on the new practical emphasis. **Independent work completed:** model/reference, actual stochastic VI, same-family diagnostic comparison, actual MH and stress target checks. **Safe remaining work:** independent code/source audit, conditional workload analysis and runtime probes with labels unchanged; correctness repairs do not require instructor approval. None of these confer approval or publication readiness.

### L07-SOURCE-OPENING — awaiting decision; owner L07 Scope

**Question:** Reuse the independently reviewed `dd4f2c5` opening repair that broadens the inference overview while preserving the Laplace spine?

**Options:** (A) selectively reuse the reviewed global/local unknowns, query and representation comparisons; (B) keep current narrower opening. **Recommendation:** A: it makes L08 exact messages, L09 distribution fitting and L10 expectation estimation intelligibly different mathematical outputs. The proposed eight minutes are funded by omitting optional Beta and determinant illustrations; these add no new algorithm or lab.

**Evidence:** recovered scope blob `696469ed003bfcad7d3c1083c927f6cbce3fba19`, source post-review `968c9eee07c3379d81d5cc91c29ffd6458f1abb2`, Section preview `39f85816e83d4c3f7e13cfc7e76dd15a310f8013`, all at commit `dd4f2c5053f29590845ae42a6331d245d773218c`. Exact paths are `Lectures/L07_Inference/lecture_scope.md` and `Lectures/course_architecture_scope/source_arc_agent_reviews/L07_post.md` / `L07_section.md`; recover with `git show`. Raw reviews were read, not rerun here; final acceptance was pending. Eight-minute funding is optimistic, not measured.

**Exactly awaiting:** scope opening/depth/time-donor update and affected downstream section introduction. **Independent work unaffected:** all fixed-model probes and assessment of later lectures. No whole commit import is proposed.

## Checking record and remaining gates

Read AGENTS, lecture-scope, worked-solution, backpressure, timing and student-knowledge instructions; architecture/maps; current L07–L10 scopes/source-arc reports; original independent reviews; recovered `dd4f2c5` post/Section reviews. Book 2 *Advanced Topics*, December 10, 2025, directly rechecked from local extraction: §§7.4.2 **Grid approximation**, 7.4.3 **Laplace (quadratic) approximation**, pp.350–352; §7.4.4 **Variational inference** distinguishes fitting a distribution from local curvature. Use §§7.1–7.3 pp.345–348 for overview and §15.3.5/15.3.6 pp.613–615 for logistic posterior/prediction. Local PDF source SHA256 is retained in the linked earlier raw evidence (`54d6…fdbaf`).

Probes ran top-to-bottom as scripts in the isolated locked uv environment; no dependency/lock changes. No student notebook, instructor approval, lecture rehearsal, student-time trial or hosted Colab run exists. Student-ready notebook validation remains a later gate. This report is independent of other new lecture investigations, but its own mathematical/code checks are author checks, not a new independent Section Design preview.

**Additional scope-neutral reference check:** [tail-envelope derivation and tests](notebook_feasibility/reference_bounds.md) use the global logistic Hessian brackets, a normalizer lower bound and explicit numerical-anchor gradient correction. The radius10 analytic tail bound is about`.000524` for bounded sigmoid expectations (`.000550` via a conservative Mills formula); radius8 is much weaker, about`.032`. This strengthens truncation checking while leaving trapezoidal discretization unproved. Separate first-moment bounds are too loose to certify coefficient mean digits. Ordinary float64 evaluation is not interval-certified. No new lecture task, scope commitment or instructor choice follows.
