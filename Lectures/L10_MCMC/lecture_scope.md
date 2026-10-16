# L10 — Sampling from a distribution: a correct algorithm can still give a poor estimate

**Instructor revision — 2026-10-15:** The notebook direction is now geometry-led
method selection with cumulative comparison: L07 Laplace against a checked
numerical reference; L09 revisit Laplace before an appropriate VI family; L10
revisit that family before MCMC. Dataset continuity is optional. Examples,
families and samplers remain unselected pending computational investigation.
The [joint accepted direction and bounded research](../course_architecture_scope/reconciliation/notebook_geometry/decision_and_tasks.md)
owns the shared decision and qualifications. The notebook/example commitments
below are baseline proposals requiring reconciliation where they conflict with
this direction; this notice does not approve the whole scope or change live
mathematical depth. Existing review evidence remains tied to its original target.

**Status:** Rewritten for an instructor familiar with the course through L03–L04. The [course register](../course_architecture_scope/STATUS.md) records the exact current review and instructor-decision status. Lecture times are estimates; future notebooks have not been implemented or run.

Suppose a probability distribution has two separated peaks. A sampler may spend thousands of steps around one peak and miss the other. Its average can then look stable while being wrong. This lecture explains both why a sampling algorithm targets the right distribution and why that fact alone does not make a short run reliable.

**Monte Carlo** means estimating a probability or expectation from random draws. **Markov chain Monte Carlo (MCMC)** produces draws by repeatedly moving from the current value to a proposed new value; successive draws depend on one another. The main algorithm is **Metropolis–Hastings (MH)**, which corrects proposed moves with an acceptance probability. We study one deliberately simple two-peak distribution whose true mean and region probabilities are known.

**What earlier lectures supply:** L01's Gaussian work and notebook introduced posterior summaries, NumPy and exact-versus-sampled comparisons. L02's agreed plan teaches observed-state transition probabilities, but stops before the mathematical question of a chain's long-run distribution. That is new here. L03 distinguishes drawing from a conditional distribution from selecting its most probable value. L07 supplies checked probability queries. L09 is useful context, not a prerequisite for the MH derivation. Familiarity with software samplers such as PyMC/NUTS does not supply their correctness proofs. An HMM's transition model from L08 is also not automatically a sampler for the HMM posterior. Protected delivered coverage remains B2 §2.3.2/B1 §3.3.

**Choice and cost:** Teach the full proposal correction and finite-run error reasoning, then have students implement one small NumPy sampler. Starting instead with conditional-coordinate sampling would reconnect to L03's image task but obscure the general proposal correction. Starting with gradient-driven Hamiltonian sampling would add a trajectory integrator and another correctness argument; those would displace the basic reasoning. Starting with rejection or weighted independent proposals adds another estimator module. Keep each of these as a bounded comparison, without a second implementation or new software ecosystem.

<details>
<summary>Source verification and original build record for later authors</summary>

The material below records exactly which sources were inspected. B1 and B2 mean Murphy's first and second books. Section and equation numbers identify source passages; they do not require familiarity with the surrounding chapters. These notes are for checking the later teaching material, rather than for understanding this proposal.

**Stage/mode:** Lecture Scope / BUILD. **Builder:** `/root/build_l04`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; checkpoint `9b62b6c`. **Upstream:** [architecture contract v3](../course_architecture_scope/architecture_audit.md), blob `54064183398bd643a895c5e38a023f793dc2d9d6`. [WORK_ORDER](../course_architecture_scope/WORK_ORDER.md) authorizes autonomous provisional choices; consequential questions return to the coordinator. Only this scope is owned here: no sections, slides, figures, notebook implementation or shared-file changes.

**Direct sources:** B2 December 10, 2025 edition, `/tmp/pml-book2.txt`: §§11.1–11.2.2 (MC, pp. 483–485), §11.4 basic rejection, §§11.5.1–11.5.2 selected importance contrast; §§2.6.4.1/2.6.4.3–2.6.4.4 (stationarity/conditions/balance); §§12.1–12.2.3.2, Algorithm 12.1 and Theorem 12.2.1 (MH, pp. 499–503); §§12.3.1–12.3.2 (Gibbs); selected §§12.5.3–12.5.4.1 (HMC recognition); §§12.6.1–12.6.3 (mixing/dependent variance, pp. 524–531). B1 April 18, 2025 edition §§2.8.7/4.6.8.4 support sample-based approximation recognition; B2 remains primary. These are selective passages, not full chapter coverage.

Do not inherit source shorthand that balance establishes ergodicity, that every correlated chain inflates variance, or that initial samples become exactly stationary after a specified burn-in. Balance establishes invariance; convergence/mixing require separate conditions, negative correlations can reduce estimator variance, and a finite discard is not a convergence certificate. For continuous-state applicability/LLN, inspected [Geyer notes, printed pp. 57–58](https://www.stat.umn.edu/geyer/f05/8931/n1995.pdf) support the stated full-dimensional MH/Harris-recurrence result; [Geyer's CLT notes](https://www.stat.umn.edu/geyer/8054/notes/geometric.html) distinguish LLN from additional CLT conditions. Measure-theoretic proofs are omitted.

**Inspected anchor:** [pyprobml `mcmc_gmm_demo.ipynb`](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb), local checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA256 `22212380c2b54b9326454efe65a47853eb90e5150928f29e2ab4c8467e1f42e4`. Source uses weights `(0.3,0.7)`, means `(-20,20)`, SDs `(10,10)`, 1,000 iterations and random-walk SDs `1,8,500`, then latent-label Gibbs/ACF. It imports JAX/TFP, probml-utils, statsmodels and seaborn, with helper KDE/3D plots and installation/TeX settings. Figures/stored outputs are unverified. The NumPy port remains unimplemented/unrun; source scale 8 is not declared universally optimal.

</details>

## 1. Intellectual arc — what the lecture explains, in order

These are the lecture's main jobs, rather than final section boundaries. Later section design can split or combine them without changing the promised mathematics, outcomes or time. Explain necessary connections at the start of the receiving section. End every section with a summary of what it has taught. Notebook instructions remain a separate item. All required material is taught live; no recording is a prerequisite.

### A. Separate distribution spread from error in its computed average — 16 minutes

First suppose independent draws from the target are available. For a quantity g(X), average its values across N draws. Derive that this estimate is unbiased and that its variance is the target variance of g divided by N. State the large-sample results: the **law of large numbers (LLN)** gives convergence of an integrable average; the **central limit theorem (CLT)** gives an approximately Normal error under the stated finite-variance conditions.

The **standard error (SE)** describes numerical uncertainty in the estimated expectation. It is different from the spread of the target distribution itself. Work the mixture mean and positive-region probability in Part 4. Improving SE by a factor of two ordinarily requires four times as many independent draws. There is no explicit dimension term in this formula, but high dimension can make useful draws hard to obtain and can change the quantity's variance.

Briefly recognize rejection sampling, which accepts independent proposals under an envelope, and importance sampling, which weights proposals from another distribution. Normalizing random importance weights produces a ratio that is generally biased at finite sample size. Do not add their proofs, implementations or a catalogue of variance-reduction methods.

**End summary:** Independent averages have quantifiable numerical error. That error depends on the quantity being averaged and is not the target's own uncertainty.

### B. Explain what it means for transitions to preserve a distribution — 22 minutes

When independent target draws are unavailable, construct a chain of dependent moves. A distribution is **stationary** or **invariant** if one further transition leaves it unchanged. **Detailed balance** says probability flow from i to j equals flow from j to i. Prove that this equality implies invariance by adding the flows.

Use the exact two-state example in Part 4 to distinguish correctness from speed. Very small switching probabilities preserve the correct distribution but give painfully slow exploration. Zero switching traps the chain; deterministic alternation creates periodic oscillation.

Define **irreducibility** as the ability to reach all relevant regions and **aperiodicity** as absence of forced repeating time cycles. For finite states, irreducibility gives a unique invariant distribution even if periodic; aperiodicity also gives convergence of the distribution at each time. State the continuous-state result at the required depth: a full-dimensional irreducible MH chain has the recurrence property called **Harris recurrence**; with a proper invariant probability, integrable averages satisfy an LLN, and aperiodicity supports convergence of time marginals. Do not prove the measure-theoretic result or infer a practical exploration time or CLT from it.

**End summary:** Balance proves preservation of the target. Reachability, time-cycle behavior and speed of exploration are separate conditions.

### C. Correct proposed moves with an acceptance probability — 30 minutes

A proposal rule q may favor some moves over their reverses. Derive the general MH acceptance ratio from the target density and both proposal directions. The unknown target normalizing constant cancels. A rejected move must retain the current state as another draw; deleting repetitions changes the algorithm.

Prove that accepted off-diagonal probability flows match, using the smaller of the two proposed flows. Rejections complete the probability of staying. Work the asymmetric two-state proposal in Part 4: omitting its proposal ratio produces the wrong distribution. Then specialize to a symmetric Gaussian random walk, where the proposal ratio cancels.

Reachability concerns the actual accepted transitions. For this positive, proper Gaussian mixture and Gaussian random-walk proposals, full support permits reaching every region; rejections also allow staying. Apply the stated continuous-state result without a recurrence proof. The algorithm sometimes accepts lower-density moves: always choosing improvements would be an optimization procedure with a different transition rule.

**End summary:** The full Hastings correction balances target and proposal flows. Accepted moves and rejected stays together preserve the target; symmetry removes the proposal ratio only when it actually holds.

### D. Recognize conditional-coordinate sampling — 12 minutes

A **Gibbs update** draws one coordinate from its full conditional distribution given the others. Substitute that proposal into the MH ratio and show its acceptance is one. Compare the two-spin example with L03's deterministic coordinate maximization: Gibbs can draw the less likely option, while maximization always picks the better one.

Each coordinate update preserves the joint distribution, so a sequence of such updates does too. A systematic sweep need not satisfy detailed balance even though its individual coordinate steps do; random mixtures of reversible coordinate updates are reversible. Acceptance one does not mean independent draws or rapid exploration.

**End summary:** Full conditionals remove the acceptance rejection, but the resulting chain remains dependent and still needs adequate exploration.

### E. Judge dependent draws and recognize gradient-guided sampling — 18 minutes

Draws from a chain repeat information. Derive the variance of a stationary finite-run average by grouping covariance terms between times. State the long-run correlation sum and **effective sample size (ESS)**: the approximate number of independent draws carrying the same information for the chosen g. These need the stated covariance/CLT assumptions. Negative correlations can make ESS exceed the draw count.

The mean and an indicator of being in the right-hand region can have different errors and ESS. A chain stuck in one peak can yield reassuring local summaries. Check dispersed starts, region crossings and exact-reference errors, alongside acceptance and repeated states. Neither a fixed initial discard nor saving only every few draws establishes convergence. A constant indicator in a stuck chain is missing information, not zero estimation error.

Use about five minutes to recognize **Hamiltonian Monte Carlo (HMC)**. Add Gaussian momentum; follow a gradient-driven, reversible, volume-preserving numerical trajectory; correct numerical energy error with MH; refresh momentum. Use `p~N(0,M)` and kinetic energy `½pᵀM⁻¹p` consistently. Name **NUTS**, the No-U-Turn Sampler, as adaptive trajectory selection. Do not derive leapfrog equations, prove the trajectory method or claim automatic travel between separated peaks.

**End summary:** The information in dependent draws depends on the question. Target preservation, acceptance and local summaries do not certify exploration or accurate finite-run estimates; proposal geometry affects efficiency.

### Time estimate and what to shorten first

The estimate is **98 substantive plus 12 reserve =110 live minutes**, with a separate 60-minute lab. It is tight and unmeasured, with medium-low confidence. Introducing chain conditions before correctness proofs and error interpretation may be slow.

First remove optional numerical sample-size planning, extra proposal-family recognition and expanded NUTS discussion, saving about 5–7 minutes while preserving the short HMC mechanics statement. Keep the asymmetric correction, stationarity counterexample and dependent-error distinction. Do not assume L02 already supplied the new chain theory or move it to an unapproved recording.

For later authors, `K=5`, `P≈10–13`, `E_new≈13–16`, `E_carry≈12–20`, `E_deriv≈9–12`, `V≈6–8` count major parts, substantive pages, new equation families, repeated support, intermediate algebra and visual groups. The rough model predicts 24–30 content-slide equivalents; this is not a target or validated duration. L01's 61-content-slide/70-page anchor and 29-slide Gaussian span are only comparisons. Rehearse the balance/MH argument and recount real teaching steps during section design.

## 2. Mathematical spine — the results students will use

Use `π=u/Z` for the target probability density: u is its unnormalized density and Z the constant making it integrate to one. q proposes a move; T is the actual transition including acceptance and rejection. g is the quantity we want to average. These are different objects.

`ρ_g(k)` is the correlation between g values k steps apart in a stationary chain. `τ_g` is their long-run correlation multiplier; `N_eff,g` is the associated effective sample size. The CLT statement needs stronger conditions than invariance or an LLN. One sufficient example in the table is geometric ergodicity, meaning a geometric bound on convergence of time distributions, plus a slightly stronger-than-second moment condition. These technical conditions are stated, not proved.

The formulas distinguish target variance from the variance of its estimated average. ACF means autocorrelation function; MCSE means Monte Carlo standard error. R-hat, mentioned among omissions, compares variation within and between chains; students are not taught to implement it. HMC's augmented energy includes potential energy from the target and kinetic energy from the added momentum.

In the table, **Derive** means work through the calculation; **Work** means carry out an example; **State** means give the result without proving it; **Apply** means use a result established earlier. These depths are unchanged by the wording revision.

| Object/result | Depth, purpose and delivery |
|---|---|
| `hatμ=N⁻¹Σg(X_n)`, IID unbiasedness, `Var(hatμ)=σ_g²/N` | **Derive**, Live; estimator's numerical uncertainty. LLN/CLT and `SE≈s_g/√N` **State + Interpret** with integrability/finite variance. |
| Importance `E_q[gπ/q]`, self-normalized weights; rejection envelope | Importance identity **State + Explain**, rejection **Mention**, Live narrow contrasts; no implementation/proof or second estimator module. |
| `πT=π`; detailed balance | Definitions **Motivate/State**, balance ⇒ invariance **Prove** by summation, Live. Not a proof of mixing. |
| Irreducibility, aperiodicity, proper target; continuous Harris/LLN statement | **State + Motivate** with exact finite example; continuous result **State**, Live. Recurrence/CLT proofs omitted. |
| General MH acceptance, cancellation of `Z`, rejection stay | **Derive + Work**, Live; include asymmetric proposal. Actual transition, not proposal alone, preserves target. |
| `π(x)q(x'\|x)a(x,x')=min{π(x)q(x'\|x),π(x')q(x\|x')}` | **Prove** MH detailed balance, Live; diagonal stays handled explicitly. |
| Gibbs conditional proposal ratio equals one | **Work/Derive bounded cancellation**, Live; coordinate/sweep invariance and reversibility distinction **State**. |
| Stationary `Var(hatμ)=σ_g²/N[1+2Σ_{k=1}^{N−1}(1−k/N)ρ_g(k)]` | **Derive briefly** from covariance-pair grouping, Live. Equality assumes stationarity and finite variance. |
| `τ_g=1+2Σ_{k≥1}ρ_g(k)`, `N_eff,g≈N/τ_g`, asymptotic variance `σ_g²τ_g/N` | **State + Interpret**, Live, with absolute autocovariance summability; a CLT requires additional conditions. One sufficient example is geometric ergodicity (distributional convergence controlled at a geometric rate) and `E_π\|g\|^(2+δ)<∞` for some `δ>0`, **State only**. Negative correlations can give `N_eff>N`. Supplied estimates **Notebook**, unreliable if exploration fails. |
| Mixture moments and `P(X>0)` | **Work**, Live; exact references support both mean and mode-region estimation. |
| HMC augmented energy and accept `min(1,exp(−ΔH))` | **State/recognize**, Live; no Hamiltonian/leapfrog correctness derivation. |

No optimal-acceptance constant is a rule for this finite multimodal problem. ESS/MCSE does not measure posterior uncertainty or certify convergence; correlated averages do not inherit the IID SE formula.

## 3. Notebook handoff — what students do and what is supplied

**Student endpoint:** Complete one random-walk MH update and use it to show the difference between a mathematically valid sampler and a reliable short-run estimate. The target is the fixed mixture `0.3N(−4,1)+0.7N(4,1)`, where 1 denotes variance. Exact references are available because we deliberately choose a directly samplable model; MH is a teaching tool here, not necessary for this distribution.

**Supplied:** stable mixture log-density, random-number/driver infrastructure, exact references, plotting, and batch/autocorrelation uncertainty summaries. Use NumPy/Matplotlib, without JAX, TensorFlow Probability, PyMC/NUTS or a new diagnostics library. **Students complete:** one accept/reject kernel, local correctness checks, and interpretation of proposal/start/query comparisons. The lecture supplies the full ratio, rejected-state retention and log-density calculations.

Compare Gaussian proposal standard deviations `0.2,2.5,20`. The supplied harness runs starts at `−4` and `+4` with equal provisional budgets of 5,000 transitions, omitting the first 1,000 for comparison. That discard does not certify stationarity. Record acceptance, repeats, region crossings, mean/variance and positive-region occupancy. Compare `g(x)=x` with `g(x)=1{x>0}`. Mark supplied uncertainty estimates unreliable when global exploration fails; a stuck sign indicator does not have established zero MCSE. Seeds and exact-reference errors matter more than one apparent winning trace. There is no universal target acceptance percentage for this finite two-peak comparison.

The 60-minute budget is: 8 minutes target/reference/software orientation; 12 completing/checking the kernel; 10 running the given harness and viewing traces; 10 query estimates and supplied uncertainty summaries; 12 proposal/start interpretation; 8 debugging reserve. Given independent mixture draws can offer a brief baseline, but not another student sampler.

No Gibbs or HMC implementation, benchmark contest or extensive tuning search is required. If debugging takes longer, cut extra seeds or an independent-draw overlay first. Preserve rejected repeats, dispersed starts and region checks.

The inspected source instead uses mixture means `−20,+20`, standard deviations 10, 1,000 iterations, proposal standard deviations `1,8,500`, and additional latent-label Gibbs/plots. It is method precedent, not a result guaranteeing a preferred scale. Its JAX/TFP/probml-utils/statsmodels/seaborn stack and installation/TeX settings are not course requirements. The linked source is `notebooks/book2/12/mcmc_gmm_demo.ipynb` at pyprobml commit `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA256 `22212380c2b54b9326454efe65a47853eb90e5150928f29e2ab4c8467e1f42e4`; figures and outputs have not been verified. The course NumPy port remains unimplemented and unrun. Workload, clean uv and hosted Colab checks remain necessary later.

## 4. Concrete examples and their sources

Each example tests a different claim: the mixture supplies exact average and region answers; the two-state chain shows slow exploration despite correct stationarity; an asymmetric proposal shows why the full correction is necessary; and a two-spin conditional illustrates Gibbs versus deterministic maximization. A “kernel” below means the rule giving the next-state distribution. Flux means probability flow between states. ICM refers to L03's deterministic coordinate update; it is not a sampler.

**Mixture endpoint — Work Live/Notebook, course-constructed:** `π(x)=0.3N(x|−4,1)+0.7N(x|4,1)`; variances are 1. Exact `E[X]=8/5`, `E[X²]=17`, `Var(X)=361/25=14.44`. With standard-normal CDF `Φ`, `P(X>0)=0.3Φ(−4)+0.7Φ(4)≈0.6999873315`. This region probability differs from the latent component weight 0.7; labels and sign regions are not identical. IID mean SE is `3.8/√N`. The mixture is deliberately directly samplable so exact references are available; MH is used to study transitions, not asserted necessary here. The target is positive/proper and Gaussian proposals have full support.

**Slow stationary chain — Work Live, course-constructed:** `T_ε=[[1−ε,ε],[ε,1−ε]]`, invariant uniform `π=(1/2,1/2)`. For `0<ε<1`, it is irreducible/aperiodic; for `ε=10⁻⁴`, expected first crossing is 10,000 steps. Starting left, no crossing in 5,000 steps has probability `(1−ε)^5000≈0.6065155`; `P(X_5000=left)=[1+(1−2ε)^5000]/2≈0.6839213`. Take the symmetric `T_ε` as proposal to a uniform target: every proposal is accepted, yet exploration is slow. At `ε=0`, invariance survives but irreducibility fails; at `ε=1`, a unique uniform invariant distribution exists but time marginals oscillate. No generic eigenvalue/mixing-bound proof is added.

**Asymmetric correction — Work Live, course-constructed:** target masses `(1/3,2/3)` and proposal rows `[(3/4,1/4),(1/2,1/2)]`. Correct acceptances are `a(0,1)=1`, `a(1,0)=1/4`, giving transition probabilities `T_01=1/4`, `T_10=1/8` and equal flux `1/12`. Omitting the proposal ratio gives equal off-diagonal transitions and a wrong uniform invariant target. Rational arithmetic verified these numbers and the preceding exact mixture/two-state commitments; this is a builder mathematical check, not an independent review or notebook run.

**Gibbs conditional — bounded Work Live, course-constructed from L03:** positive two-spin joint on `{−1,+1}²`, `π(x1,x2)∝exp(Jx1x2)`, `J=(log3)/2`. Matching states each have mass `3/8`, opposite states `1/8`; a coordinate conditional matches its neighbor with probability `3/4`. Gibbs samples that conditional (including the less likely alternative); ICM maximizes it. No image or latent-mixture Gibbs lab.

Selected semantic groups: estimator spread/SE, two-state flux/mixing, proposal-correction table, conditional Gibbs versus ICM, and mixture traces/region/query comparison, roughly six to eight groups. B2 Figs. 12.1/12.17 provide inspected context, not promised outcomes or exact reproductions. No figures or layouts are authored.

## 5. Lecture contract — what this proposal commits to

**Starting knowledge:** Probability, expectations and L02 transition probabilities; L03 conditional distributions and L07's distinction among probability queries. Prior software use is background, not a mathematical proof.

**Main question:** How can a chain have the correct target and still give an unreliable finite estimate? **Lecture endpoint:** derive independent-average variance and MH balance, show why a conditional-coordinate update is valid, and distinguish target preservation, long-run convergence, exploration speed and numerical error. **Notebook endpoint:** one checked NumPy MH kernel and a controlled two-peak proposal/start/query comparison. The estimate is 110 live minutes plus 60 lab minutes, without a required recording.

Supported outcomes are computing independent-sample standard error; explaining balance versus exploration; deriving the full proposal correction; retaining rejected repeats; recognizing Gibbs/HMC roles; and assessing mean/region estimates against exact references. Core sources are selected B2 §§11.2–11.2.2, §2.6.4, §§12.2.1–12.2.2 and §12.6.3. Gibbs and HMC are deliberately narrower comparisons rather than full chapter promises.

**What is left out, and the lost capability:** Students do not learn a catalogue of ways to generate or reweight independent draws, nor a second sampler implementation. They cannot derive leapfrog/HMC correctness, solve optimal proposal scaling, handle changing model dimension, or implement gradient-noise, tempering or transport samplers. They do not prove abstract mixing-rate bounds or implement a full multi-chain diagnostic framework. **Sequential Monte Carlo (SMC)**, which tracks weighted particles as evidence arrives, remains omitted. These methods are not assigned to L11/L12 or hidden recordings.

**Choices and risks:** The course's ±4/unit-variance mixture is more sharply separated than the source's ±20/SD10 model. This emphasizes missed regions, but actual seed/scale behavior needs piloting. Exact-reference and query-specific checks are necessary because a missing peak can defeat reassuring error summaries. Full HMC geometry would require replacing other content or revising the course architecture; the short recognition item cannot promise that capability.

**Record updates:** Reflect bounded Gibbs/HMC treatment and selective Chapters 11–12 coverage. The new stationarity material is planned L10 work, not retroactive L02 coverage. Keep delivered L01 history unchanged.

<details>
<summary>Exact source allocation for checking the syllabus and material ledger</summary>

This table preserves the reviewed source boundaries. The plain-language explanation above states what the omissions mean for students. A method named as omitted is not promised elsewhere unless a receiving lecture is explicitly named.

| Allocation | Commitment / proposed future bookkeeping |
|---|---|
| **Core/Live deep** | B2 §§11.2–11.2.2, selected §2.6.4, §§12.2.1–12.2.2, selected §12.6.3; MH/MC correctness and dependent variance. |
| **Short bridge** | §11.4/§§11.5.1–11.5.2 narrow contrasts; §12.2.3.2 random walk; §§12.3.1–12.3.2 bounded Gibbs; §12.6.1/12.6.2 interpretation; HMC mechanics §12.5.3/NUTS name §12.5.4.1 only. |
| **Notebook owned** | Stable MH mechanics, repeated states, fixed-scale/dispersed-start mixture comparison, exact-reference query errors and supplied uncertainty diagnostics. |
| **Optional** | Extra seeds/IID overlay, numerical sample-size planning and expanded NUTS context; none silently required. |
| **Omitted deliberately** | Inverse-CDF/Box–Muller derivations, importance/rejection modules, AIS/variance-reduction catalogue, Gibbs model zoo/blocked/collapsed derivations, slice/auxiliary samplers, full HMC/leapfrog proof, optimal-scaling theory, SGLD, RJMCMC, tempering, transport, funnel/reparameterization theory, spectral/conductance proofs and R-hat implementation tutorial. SMC remains substantively omitted under the course contract. |

</details>

**Next owner:** The instructor reviews the proposal's choices and explanations. Detailed section design follows acceptance. If later writing or rehearsal cannot meet the stated commitments, return the affected choice to Lecture Scope. The [registry](../course_architecture_scope/STATUS.md) holds review evidence. This document does not establish notebook runtime, Colab readiness or measured teaching time.
