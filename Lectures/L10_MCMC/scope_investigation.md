# L10 scope investigation — finite query estimates and exploration

**Stage/mode:** Lecture Scope / feasibility-review and author-only computational probes, investigator `/root/investigate_l07_l10`, 2026-10-14; worktree `/tmp/pml-l04-l12-reconciliation`, starting commit `5e4c86e`. Scope target blob `9ce5a70b8ac1e1506820134b1a01d06b976c072f`. **Verdict: feasible-with-risks.** [Current scope](lecture_scope.md) remains unchanged. Shared practical task decision is owned by [L07-SHARED-CLASSIFIER](../L07_Inference/scope_investigation.md#l07-shared-classifier--awaiting-decision-owner-l07-scope-affects-l07l09l10); its question/options are not duplicated here.

## New finite-run evidence

The [actual MH probe](notebook_feasibility/mh_probe.py) imports exactly the L07 model/data/prior/queries. For unnormalized target u and proposal density q, general MH acceptance is

$$a(w,w')=\min\{1,u(w')q(w\mid w')/[u(w)q(w'\mid w)]\}.$$

The unknown target normalizer cancels. Symmetric Gaussian random walks use Laplace covariance as a supplied preconditioner; the scale and starts vary without changing the target. Twelve actual runs use scales `.3,1,3`, four dispersed starts/seeds,15,000 transitions with3,000 discarded for comparison. **Every rejected stay remains in the chain**. Discard is a setting, not a stationarity proof. An independent two-state asymmetric check gives target `(1/3,2/3)`, correct transition `[[.75,.25],[.125,.875]]` and zero invariance error; omitting proposal correction gives the wrong uniform transition and positive target-invariance error.

[Results](notebook_feasibility/mh_results.json) retain individual starts, seeds, acceptance, repeat fractions, query means, exact-reference errors, batch MCSE and ACF ESS. At scale `.3`, acceptance is about85% but slope ESS is only182–230 out of12,000 retained draws; slope errors are as large as`.0366`. Scale1 gives about56% acceptance, slope ESS1,091–1,191 and slope errors up to`.0164`. Scale3 gives about17% acceptance and similar slope ESS around950–1,113. Thus neither high nor low acceptance alone ranks finite-query accuracy. Numerical values are one fixed pilot, not a proposal-scale rule or generic threshold.

The sampled objects are estimates of `E_p[w_j]` and `E_p[σ(x^Tw)]`, not a fitted posterior proxy. Posterior variance of weights/outcomes differs from MCSE of an estimated expectation. Multiple chains produce different finite estimates of the same query. L07's checked quadrature serves as a numerical reference, while Laplace/VI give different approximate distributional objects. At two dimensions the quadrature reference is cheaper; repeated runs here teach sampler diagnosis, not necessity for tiny Iris.

The independent mixture `π=.3N(−4,1)+.7N(4,1)` is retained as exploration stress. Twelve actual5,000-transition runs (1,000 discarded), starts±4, seeds17/29, proposals SD`.2,2.5,20`, produce zero sign crossings for all four narrow-proposal runs,37–46 for SD2.5 and180–192 for SD20. The small-scale sign indicator is constant: its MCSE/ESS are returned as **null/unassessed**, not zero error or infinite precision. Within-region movement cannot repair the missed region. The exact mean1.6 and positive-region probability `.3Φ(−4)+.7Φ(4)` support distinct query errors. The Gaussian-prior logistic target is strictly log-concave; its good behavior cannot replace this failure witness.

For stationary finite-variance query values `g(W_n)`,

$$\operatorname{Var}(\bar g_N)=\frac{\sigma_g^2}{N}\left[1+2\sum_{k=1}^{N-1}(1-k/N)\rho_g(k)\right].$$

MCSE/ESS in this probe are conditional estimates using nonoverlapping batches/a heuristic positive adjacent odd-lag-pair cutoff (lags1+2,3+4,…), not a proof that the chain reached all important regions. This is not canonical Geyer IPS and constrains the estimated correlation multiplier to at least1, so it cannot represent antithetic ESS greater than N. An asymptotic normal error interval requires more than invariance (e.g. appropriate ergodicity/moments and covariance summability). Initialization and unexplored-mode bias are distinct from stationary variance. Reported ESS is query-specific and its truncation is approximate; it is not the full ArviZ multi-chain rank-normalized diagnostic. No R-hat/divergence library coverage is added silently.

## Competence, prerequisites and practical limits

**Assume familiar:** entry Bayesian sampling, posterior chains and basic trace/ESS ideas, NumPy and expectation. **Previously encountered—scaffold:** coefficient-draw shapes and L07's query/reference discipline, transition rows from L02; prior conceptual HMC/NUTS use does not establish correctness proofs. **New:** full Hastings ratio, proposal-versus-actual-transition distinction, rejected-stay retention in an implemented kernel, stationarity versus exploration, and query-dependent sampling variance/MCSE assumptions. Supply stable log density, driver, plots and diagnostics; the student completes one checked accept/reject update and interprets comparisons. Do not require implementing a diagnostics library or additional Gibbs/HMC sampler.

Live treatment remains derive IID variance/full MH correction, prove balance⇒invariance, bounded conditional-Gibbs cancellation, derive stationary covariance-pair variance and state long-run conditions. Recognition-only HMC is the current contract. L05/AD are not mathematical prerequisites for MH; L09 is comparison context. L12 requires pathwise VI, not HMC theory. The110 live/60 lab envelopes remain tight and unmeasured. If shared classifier becomes primary, bimodal stress should be supplied bounded interpretation, replacing some current student experimentation rather than appending a second full implementation.

**Validity regime:** correct target/proposal support and MH ratio establish target preservation; usable finite expectations require exploration plus applicable moment/ergodic assumptions. **Payoff:** no normalizing constant, exponential grid or fitted q is needed; cost scales with transitions, likelihood evaluations and mixing. Dependence/exploration can eliminate that advantage. **Task-relevant error:** finite query variance, initialization bias and region exclusion can coexist with formally valid target invariance.

## Open instructor-owned question

### L10-HMC-DEPTH

**Status/owner:** awaiting decision, L10 Scope; this preserves the prior recorded teaching alternative rather than reopening the already corrected L09 handoff. **Question:** retain MH implementation/finite-error diagnosis and recognition-only HMC, or replace substantial current content with algorithm-level HMC construction?

**Options:** (A) keep current MH/diagnostic depth with HMC mechanics recognition; (B) replace part of balance/Gibbs/error treatment and lab with momentum/leapfrog/HMC derivation and use. **Recommendation:** A for this course endpoint. Entry students already used HMC conceptually; a new algorithm construction would need explicit time/depth tradeoffs, and does not automatically solve separated-mode mixing. No extra HMC implementation is necessary for L09/L12.

**Evidence:** new finite MH/multimodal runs, current scope contract, [original independent L10 review](../course_architecture_scope/reviews/L10_review.md) and recovered source post-review at `dd4f2c5`, target blob `884a24c67187557546c74d0e3935f08fc67edd93`, report blob `b2e9cd5aa63324490cd2c9cdaab0936c1b79cdf0`. That source reviewer found a faithful selective arc and no mandatory HMC repair. This is recoverable evidence, not instructor approval.

**Exactly awaiting:** final acceptance of HMC depth/covered-deferred commitments before related section design/production; substantive HMC replacement, if chosen, would require new feasibility review. **Independent completed:** MH kernel checks,12 fixed-model chains,12 exploration-stress runs and diagnostics. Shared notebook endpoint changes separately await L07-SHARED-CLASSIFIER. **Safe remaining:** independent numerical/code review and conditional workload assessment of current diagnostics; no need to halt later lecture work.

## Source route and gates

Rechecked Book2 *Advanced Topics*, December10,2025, §12.6.3 **Effective sample size**, pp.529–531. Read §§12.2.1–12.2.2 **Basic idea / Why MH works**, pp.500–502, for target preservation; §12.6.1 **Mixing rates of Markov chains** for exploration. The source's unconditional claim that correlations increase average variance is too strong when correlations are negative; retain the scope's conditions. For the competing depth inspect §12.5.2.3 **Leapfrog integrator** and §12.5.3 **The HMC algorithm**, pp.518–520. Keep `momentum~N(0,M)`, kinetic energy `½pᵀM⁻¹p` consistent; prior raw review records book mass/inverse-mass inconsistency.

All new probes passed isolated locked-uv execution. Reported per-chain timings exclude package imports. No arbitrary-target sampler robustness, universal ESS accuracy, student notebook/time validation, rehearsal or hosted Colab pass is claimed. No scope, map, shared skill or L01 artifact was changed. Acceptance belongs in lecture_scope.md.
