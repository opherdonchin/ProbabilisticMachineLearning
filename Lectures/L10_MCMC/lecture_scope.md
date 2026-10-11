# L10 — Monte Carlo and MCMC: correct transitions, useful estimates

**Status:** Reviewed five-part scope proposal; [current agent approval and exact reviews](../course_architecture_scope/STATUS.md) are maintained by the coordinator. Instructor acceptance pending; timing and notebook implementation remain unvalidated. **Stage/mode:** Lecture Scope / BUILD. **Builder:** `/root/build_l04`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; checkpoint `9b62b6c`. **Upstream:** [architecture contract v3](../course_architecture_scope/architecture_audit.md), blob `54064183398bd643a895c5e38a023f793dc2d9d6`. [WORK_ORDER](../course_architecture_scope/WORK_ORDER.md) authorizes autonomous provisional choices; consequential questions return to the coordinator. Only this scope is owned here: no sections, slides, figures, notebook implementation or shared-file changes.

## Starting boundary, source evidence and route choice

Protected actual L01 deck/imputation notebook establish Gaussian conditioning, posterior summaries, NumPy operations and exact-versus-sampled comparison. Undergraduate PyMC/NUTS experience supplies tool familiarity, not an MCMC proof. Delivered ledger boundaries remain B2 §2.3.2/B1 §3.3. Protected agreed L02 `section_design.md` teaches observed-state Markov transition counts through §2.6.3, **stopping before stationarity**; its malformed development-state file adds no authority. Invariant distributions, balance and convergence conditions are new L10 obligations.

Inspected reviewed L03–L08 handoffs supply local full conditionals versus deterministic ICM (L03), normalized finite enumeration/KL (L04), gradients/AD (L05), latent expectations/EM (L06), queries/Laplace and checked grid references (L07), and exact HMM posterior messages (L08). An HMM's latent transition model is not automatically a sampler targeting its posterior. L09 is concurrently scoped: its planned VI/pathwise-gradient work is context, not a hidden prerequisite for MH. L10 can enter from probability, conditional expectations and L02 transition kernels alone; no stationarity theorem or sampler correctness is attributed to earlier lectures.

**Direct sources:** B2 December 10, 2025 edition, `/tmp/pml-book2.txt`: §§11.1–11.2.2 (MC, pp. 483–485), §11.4 basic rejection, §§11.5.1–11.5.2 selected importance contrast; §§2.6.4.1/2.6.4.3–2.6.4.4 (stationarity/conditions/balance); §§12.1–12.2.3.2, Algorithm 12.1 and Theorem 12.2.1 (MH, pp. 499–503); §§12.3.1–12.3.2 (Gibbs); selected §§12.5.3–12.5.4.1 (HMC recognition); §§12.6.1–12.6.3 (mixing/dependent variance, pp. 524–531). B1 April 18, 2025 edition §§2.8.7/4.6.8.4 support sample-based approximation recognition; B2 remains primary. These are selective passages, not full chapter coverage.

Do not inherit source shorthand that balance establishes ergodicity, that every correlated chain inflates variance, or that initial samples become exactly stationary after a specified burn-in. Balance establishes invariance; convergence/mixing require separate conditions, negative correlations can reduce estimator variance, and a finite discard is not a convergence certificate. For continuous-state applicability/LLN, inspected [Geyer notes, printed pp. 57–58](https://www.stat.umn.edu/geyer/f05/8931/n1995.pdf) support the stated full-dimensional MH/Harris-recurrence result; [Geyer's CLT notes](https://www.stat.umn.edu/geyer/8054/notes/geometric.html) distinguish LLN from additional CLT conditions. Measure-theoretic proofs are omitted.

| Alternative | Endpoint and tradeoff | Provisional choice |
|---|---|---|
| **MH validity → multimodal proposal comparison** | B2 §§11.2, 12.2, selected 12.6; implement one kernel and challenge finite-run estimates against exact mixture references | **Selected.** Substantial correctness plus computation, beyond routine NUTS diagnostics; bounded NumPy lab. |
| Gibbs-first graphical inference | B2 §12.3, L03 Ising conditionals; second image-restoration lab | Strong continuity, but duplicates L03 application and can obscure general proposal correction. Keep one bounded Gibbs-as-MH illustration. |
| HMC-first geometry | B2 §12.5 with gradients from L05; implement leapfrog and compare samplers | Valuable, but a second algorithm/proof and runtime burden would displace balance and estimator-error reasoning. HMC remains compact recognition. |
| Importance/rejection-first MC | B2 §§11.4–11.5; weighted-particle/reference lab | Clarifies independent proposals but creates another estimator module and weaker Markov-chain endpoint. Retain narrow conceptual contrasts only. |

No new ecosystem or required recording. The proposed target/scale choices below are course-constructed, with inspected source as method precedent.

## 1. Intellectual arc

These are provisional **macrosegments, not finalized sections**. Connections begin receiving segments; each resulting section ends retrospectively. The notebook handoff is separate. All required mathematics is Live.

### Independent averages quantify numerical error — about 16 minutes

**Transition in:** L07 computed expectations on a checked grid, and L09 will approximate a distribution parametrically. Sampling offers another way to compute expectations if target draws are available.

**Purpose/source:** B2 §§11.2–11.2.2: distinguish a target's spread from error in a computed expectation.

**Core:** define the IID sample-average estimator; derive unbiasedness and `Var(hatμ)=Var_p(g)/N` by independence. State LLN for integrable `g` and the finite-variance CLT, `√N(hatμ−μ) ⇒ N(0,σ_g²)`. Interpret numerical SE and square-root sample-cost scaling. Work the mixture mean/indicator reference below. The nominal rate has no explicit dimension term, but target variance and obtaining draws may be difficult in high dimensions. Briefly contrast rejection's independent accepted draws with importance weighting; self-normalized weights generally give a biased finite-sample ratio. No second algorithm/lab or variance-reduction catalogue.

**Retrospective summary:** an IID average estimates an expectation with numerical error determined by the variance of the chosen function and sample count; posterior uncertainty and Monte Carlo SE are different quantities.

### A target invariant under transitions need not be reached rapidly — about 22 minutes

**Transition in:** IID target samples may be unavailable. Build dependent transitions preserving the target, first separating the properties that this claim needs.

**Purpose/source:** B2 §2.6.4 and §12.6.1: establish previously untaught stationarity and balance before using them to justify MH.

**Core:** use row-stochastic `T`, `πT=π`, and detailed balance `π_iT_ij=π_jT_ji`; prove balance implies invariance by summation. State finite-state irreducibility/aperiodicity conditions for a unique limiting distribution. Irreducible finite chains have a unique invariant distribution even when periodic; aperiodicity supplies convergence of time marginals. Work the exact two-state family below: slow crossing despite correct invariance, reducibility at zero and periodicity at one. State the continuous-state extension at necessary depth: full-dimensional irreducible MH has Harris recurrence; with a proper invariant probability, integrable averages obey an LLN, and aperiodicity supports convergence of marginals. These results do not bound a practical mixing time or automatically supply a CLT.

**Retrospective summary:** balance can certify a stationary target, while communication between states, absence of periodicity and mixing rate are distinct questions. Invariance alone does not certify a finite-run estimate.

### Metropolis–Hastings corrects proposal bias — about 30 minutes

**Transition in:** design transitions that satisfy the target balance equation while evaluating its density only up to normalization.

**Purpose/source:** B2 §§12.2.1–12.2.3.2: derive the general acceptance rule and its validity argument.

**Core:** specify proposal, accept/reject and retained current state after rejection. Derive `a=min(1,u(x')q(x|x')/[u(x)q(x'|x)])`; the unknown target normalizer cancels. Prove off-diagonal detailed balance through the symmetric minimum of the two proposal fluxes, with rejection completing the stay probability. Work the asymmetric two-state correction and symmetric Gaussian random walk. Coverage/reachability concerns accepted transitions, not just naming a proposal. For the positive Gaussian mixture and positive Gaussian random walk, full support establishes irreducibility; rejections supply self-transition. State the preceding continuous-state result for this full-dimensional MH setting, without a general recurrence proof. Moves to lower target density are possible; deleting repeats or accepting only improving moves changes the kernel.

**Retrospective summary:** the Hastings ratio corrects both target and proposal fluxes; accepted moves plus rejected stays form a target-invariant kernel. Symmetry removes the proposal ratio only in the symmetric case.

### Full-conditionals give Gibbs updates with acceptance one — about 12 minutes

**Transition in:** a graphical model sometimes supplies a proposal automatically: sample one coordinate from its full conditional.

**Purpose/source:** B2 §§12.3.1–12.3.2: connect MH to L03 conditional mathematics without authoring another sampler.

**Core:** substitute the coordinate full conditional into the MH ratio and work its cancellation to one. Compare the two-spin update below with ICM's deterministic maximization. Each coordinate kernel preserves the joint; their composition preserves it. A systematic sweep need not be reversible even though each coordinate kernel is, whereas random-scan mixtures of reversible coordinate kernels are reversible. Acceptance one is not independent sampling or a rapid-mixing guarantee. No GMM latent-label Gibbs implementation or blocked/collapsed algorithm.

**Retrospective summary:** Gibbs uses full conditionals as proposals, so coordinate acceptance is one, but the resulting dependent chain still requires reachability and adequate exploration.

### Dependent-chain error and proposal geometry determine usefulness — about 18 minutes

**Transition in:** correctness leaves open how much numerical information a finite chain supplies. Evaluate the function being averaged, not acceptance alone.

**Purpose/source:** B2 §§12.6.1–12.6.3 and compact §12.5: connect covariance, mode exploration and familiar gradient-based sampling.

**Core:** derive the stationary finite-run variance from summed covariances; state asymptotic autocorrelation time/ESS under summability and appropriate CLT conditions. ESS is function-specific; a chain confined to one mode can produce deceptively reassuring local diagnostics. Interpret repeated states, dispersed starts, region occupancy and exact-reference errors. A fixed warm-up discard or thin trace is no guarantee. HMC is a five-minute **State/recognize** bridge: Gaussian momentum, gradient-driven reversible volume-preserving numerical trajectory, MH energy correction and momentum refresh; identify NUTS as adaptive trajectory selection without deriving it. Use consistent mass convention `p~N(0,M)`, kinetic energy `½pᵀM⁻¹p`. No leapfrog equations/proof or claim that HMC automatically crosses separated modes.

**Retrospective summary:** dependent samples carry query-specific numerical information; theoretical invariance, acceptance and local ESS must be distinguished from finite-run exploration and estimation accuracy. Proposal geometry affects efficiency without changing the target.

### Extent and first cut

**98 minutes substantive + 12 reserve = 110 minutes**, separate 60-minute lab. Reserve includes questions, transitions and slippage. No recording candidate is used to balance the budget. **Tight; timing unmeasured, confidence medium-low**, principally because chain conditions precede two correctness calculations and error interpretation.

Against L01's 61-content-slide/70-page anchor and 29-slide Gaussian mathematical span, estimate `K=5`, `P≈10–13` substantive source-page equivalents, `E_new≈13–16`, `E_carry≈12–20`, `E_deriv≈9–12`, `V≈6–8`. New retained families include IID variance, invariance/balance, limiting-distribution conditions, MH correction/kernel, Gibbs cancellation, covariance-based variance and ESS. The provisional model gives roughly **24–30 content-slide-equivalents**, a relative warning signal, not a slide commitment or validated time. Mathematical novelty and proof prerequisites outweigh raw equation appearances.

**First cut:** remove optional numerical IID sample-size planning, extra proposal-family recognition and detailed NUTS/context discussion, about 5–7 minutes, preserving HMC's short mechanics statement. Retain the asymmetric correction, stationarity counterexample and dependent-error distinction. If more relief is needed, escalate a depth/time change to Scope rather than presume L02 already taught stationarity. Recount novelty at downstream design and rehearse the balance/MH argument.

## 2. Mathematical spine

Use `π=u/Z` for the target, `q` for proposal, `T` for the actual accepted/rejected transition kernel and `g` for the query. This separates proposals from sampler transitions and posterior variance from estimator variance.

| Object/result | Depth, purpose and delivery |
|---|---|
| `hatμ=N⁻¹Σg(X_n)`, IID unbiasedness, `Var(hatμ)=σ_g²/N` | **Derive**, Live; estimator's numerical uncertainty. LLN/CLT and `SE≈s_g/√N` **State + Interpret** with integrability/finite variance. |
| Importance `E_q[gπ/q]`, self-normalized weights; rejection envelope | Importance identity **State + Explain**, rejection **Mention**, Live narrow contrasts; no implementation/proof or second estimator module. |
| `πT=π`; detailed balance | Definitions **Motivate/State**, balance ⇒ invariance **Prove** by summation, Live. Not a proof of mixing. |
| Irreducibility, aperiodicity, proper target; continuous Harris/LLN statement | **State + Motivate** with exact finite example; continuous result **State**, Live. Recurrence/CLT proofs omitted. |
| General MH acceptance, cancellation of `Z`, rejection stay | **Derive + Work**, Live; include asymmetric proposal. Actual transition, not proposal alone, preserves target. |
| `π(x)q(x'|x)a(x,x')=min{π(x)q(x'|x),π(x')q(x|x')}` | **Prove** MH detailed balance, Live; diagonal stays handled explicitly. |
| Gibbs conditional proposal ratio equals one | **Work/Derive bounded cancellation**, Live; coordinate/sweep invariance and reversibility distinction **State**. |
| Stationary `Var(hatμ)=σ_g²/N[1+2Σ_{k=1}^{N−1}(1−k/N)ρ_g(k)]` | **Derive briefly** from covariance-pair grouping, Live. Equality assumes stationarity and finite variance. |
| `τ_g=1+2Σ_{k≥1}ρ_g(k)`, `N_eff,g≈N/τ_g`, asymptotic variance `σ_g²τ_g/N` | **State + Interpret**, Live, with absolute autocovariance summability; a CLT requires additional conditions. One sufficient example is geometric ergodicity (distributional convergence controlled at a geometric rate) and `E_π|g|^(2+δ)<∞` for some `δ>0`, **State only**. Negative correlations can give `N_eff>N`. Supplied estimates **Notebook**, unreliable if exploration fails. |
| Mixture moments and `P(X>0)` | **Work**, Live; exact references support both mean and mode-region estimation. |
| HMC augmented energy and accept `min(1,exp(−ΔH))` | **State/recognize**, Live; no Hamiltonian/leapfrog correctness derivation. |

No optimal-acceptance constant is a rule for this finite multimodal problem. ESS/MCSE does not measure posterior uncertainty or certify convergence; correlated averages do not inherit the IID SE formula.

## 3. Notebook handoff — one multimodal proposal-comparison lab

**Inspected anchor:** [pyprobml `mcmc_gmm_demo.ipynb`](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb), local checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA256 `22212380c2b54b9326454efe65a47853eb90e5150928f29e2ab4c8467e1f42e4`. Source uses weights `(0.3,0.7)`, means `(-20,20)`, SDs `(10,10)`, 1,000 iterations and random-walk SDs `1,8,500`, then latent-label Gibbs/ACF. It imports JAX/TFP, probml-utils, statsmodels and seaborn, with helper KDE/3D plots and installation/TeX settings. Figures/stored outputs are unverified. The NumPy port remains unimplemented/unrun; source scale 8 is not declared universally optimal.

**Entry:** lecture supplies the general/symmetric MH rule, rejected-state retention, log-density ratios, exact target references and function-specific dependent error. NumPy/RNG use is familiar; sampler-driver, stable mixture log-density, plotting and uncertainty-estimation infrastructure are scaffolded. Use NumPy/Matplotlib; no NUTS/PyMC API, JAX, TFP or new diagnostic package.

**Required new work:** complete one random-walk MH accept/reject kernel; check it locally; compare the same fixed mixture with proposal SDs `0.2,2.5,20`. Supplied harness runs two dispersed starts `−4,+4` at equal iteration budgets, provisionally 5,000 transitions each with the first 1,000 omitted for comparison, not certified stationarity. Record acceptance, repeated states, sign-region crossings, mean/variance and positive-region occupancy. Compare `g(x)=x` and `g(x)=1{x>0}`; supplied batch/ACF summaries must be flagged unreliable when global exploration fails. A constant indicator in a stuck chain means missing information, not zero MCSE. Repeatability/seeds and exact-reference errors matter more than selecting a winner from one trace.

**60-minute envelope:** 8 minutes target/reference/software orientation; 12 kernel completion and correctness checks; 10 given-harness runs/traces; 10 query estimates and supplied uncertainty summaries; 12 proposal/start comparisons and interpretation; 8 debugging reserve. Given exact IID mixture draws can supply a short baseline, not another student sampler. No Gibbs/HMC implementation, runtime benchmark contest or extensive tuning search. If debugging overruns, cut optional extra seeds/IID overlay before compromising rejected-state retention or the dispersed-start/region checks.

**Endpoint:** distinguish a mathematically valid kernel from a useful finite estimator, and diagnose proposal effects using known mixture truth. Clean uv/hosted Colab execution and student workload/pilot remain downstream obligations. No scale ranking, transition count or runtime is guaranteed by source inspection.

## 4. Concrete examples and exact commitments

**Mixture endpoint — Work Live/Notebook, course-constructed:** `π(x)=0.3N(x|−4,1)+0.7N(x|4,1)`; variances are 1. Exact `E[X]=8/5`, `E[X²]=17`, `Var(X)=361/25=14.44`. With standard-normal CDF `Φ`, `P(X>0)=0.3Φ(−4)+0.7Φ(4)≈0.6999873315`. This region probability differs from the latent component weight 0.7; labels and sign regions are not identical. IID mean SE is `3.8/√N`. The mixture is deliberately directly samplable so exact references are available; MH is used to study transitions, not asserted necessary here. The target is positive/proper and Gaussian proposals have full support.

**Slow stationary chain — Work Live, course-constructed:** `T_ε=[[1−ε,ε],[ε,1−ε]]`, invariant uniform `π=(1/2,1/2)`. For `0<ε<1`, it is irreducible/aperiodic; for `ε=10⁻⁴`, expected first crossing is 10,000 steps. Starting left, no crossing in 5,000 steps has probability `(1−ε)^5000≈0.6065155`; `P(X_5000=left)=[1+(1−2ε)^5000]/2≈0.6839213`. Take the symmetric `T_ε` as proposal to a uniform target: every proposal is accepted, yet exploration is slow. At `ε=0`, invariance survives but irreducibility fails; at `ε=1`, a unique uniform invariant distribution exists but time marginals oscillate. No generic eigenvalue/mixing-bound proof is added.

**Asymmetric correction — Work Live, course-constructed:** target masses `(1/3,2/3)` and proposal rows `[(3/4,1/4),(1/2,1/2)]`. Correct acceptances are `a(0,1)=1`, `a(1,0)=1/4`, giving transition probabilities `T_01=1/4`, `T_10=1/8` and equal flux `1/12`. Omitting the proposal ratio gives equal off-diagonal transitions and a wrong uniform invariant target. Rational arithmetic verified these numbers and the preceding exact mixture/two-state commitments; this is a builder mathematical check, not an independent review or notebook run.

**Gibbs conditional — bounded Work Live, course-constructed from L03:** positive two-spin joint on `{−1,+1}²`, `π(x1,x2)∝exp(Jx1x2)`, `J=(log3)/2`. Matching states each have mass `3/8`, opposite states `1/8`; a coordinate conditional matches its neighbor with probability `3/4`. Gibbs samples that conditional (including the less likely alternative); ICM maximizes it. No image or latent-mixture Gibbs lab.

Selected semantic groups: estimator spread/SE, two-state flux/mixing, proposal-correction table, conditional Gibbs versus ICM, and mixture traces/region/query comparison, roughly six to eight groups. B2 Figs. 12.1/12.17 provide inspected context, not promised outcomes or exact reproductions. No figures or layouts are authored.

## 5. Lecture contract

**Start:** rigorous probability, expectations and L02 transition kernels; reviewed L03 conditionals and L07 query/reference discipline. Undergraduate sampler use is background, not proof. **Question:** how can a chain target the correct distribution yet yield unreliable finite estimates? **Lecture endpoint:** derive IID estimator variance and MH balance, justify bounded Gibbs updates and distinguish invariance, convergence, exploration and dependent estimator error. **Lab endpoint:** one checked NumPy MH kernel and multimodal proposal/start/query comparison. **No required recording.**

Supported outcomes: compute IID numerical SE; explain balance versus mixing; derive the full Hastings correction; retain rejection repeats; recognize Gibbs/HMC roles; assess finite mean/region estimates using exact references and dependent-error caveats.

| Allocation | Commitment / proposed future bookkeeping |
|---|---|
| **Core/Live deep** | B2 §§11.2–11.2.2, selected §2.6.4, §§12.2.1–12.2.2, selected §12.6.3; MH/MC correctness and dependent variance. |
| **Short bridge** | §11.4/§§11.5.1–11.5.2 narrow contrasts; §12.2.3.2 random walk; §§12.3.1–12.3.2 bounded Gibbs; §12.6.1/12.6.2 interpretation; HMC mechanics §12.5.3/NUTS name §12.5.4.1 only. |
| **Notebook owned** | Stable MH mechanics, repeated states, fixed-scale/dispersed-start mixture comparison, exact-reference query errors and supplied uncertainty diagnostics. |
| **Optional** | Extra seeds/IID overlay, numerical sample-size planning and expanded NUTS context; none silently required. |
| **Omitted deliberately** | Inverse-CDF/Box–Muller derivations, importance/rejection modules, AIS/variance-reduction catalogue, Gibbs model zoo/blocked/collapsed derivations, slice/auxiliary samplers, full HMC/leapfrog proof, optimal-scaling theory, SGLD, RJMCMC, tempering, transport, funnel/reparameterization theory, spectral/conductance proofs and R-hat implementation tutorial. SMC remains substantively omitted under the course contract. |

No omitted method becomes debt to L11/L12. Formal syllabus/ledger should reflect bounded HMC and Gibbs depths rather than complete Chapters 11–12; new stationarity backfill is planned L10 coverage, not a revision to L02. Delivered L01 boundaries remain protected.

**Questions/risks to coordinator:** **medium, Scope-owned:** confirm the controlled ±4/unit-variance mixture instead of source ±20/SD10; stronger separation emphasizes missed regions, but finite seed/scale behavior must be piloted. **Medium, downstream-owned:** diagnostics/MCSE can overstate confidence when a mode is missed; scaffold query-specific checks and exact-reference comparisons, and label failures rather than forcing successful mixing. **Low, Scope-owned:** HMC is deliberately recognition only; a full leapfrog/geometry lecture would require replacing content or changing the architecture, not adding an unbudgeted second lab.

**Next owner:** Instructor oversight of this reviewed proposal. Subsequent Section Design requires human acceptance; its execution backpressure returns to the nearest owning stage. Review and approval provenance are in the registry. No rehearsal, notebook runtime or hosted Colab validation is implied.
