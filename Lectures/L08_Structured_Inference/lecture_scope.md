# L08 — Exact sequence inference: forward and backward information

**Status:** provisional five-part Lecture Scope; independent feasibility preview and cross-course reconciliation pending, no self-approval. **Stage/mode:** Lecture Scope / BUILD. **Builder:** `/root/build_l05`, 2026-10-11, branch `scope-l03-l12-course-architecture`. **Inputs:** Wave A checkpoint `791e71b`; [architecture contract v2](../course_architecture_scope/architecture_audit.md), blob `12ae5e1608eb2d74c6c70ba857eb5a75ff2114c1`; L06 scope `326267281c6b6775ac9a33d7ed4f022a859fc49b`, L07 scope `f12fba8de7339675d09a771c5f956c8ed93649d8`. The [work order](../course_architecture_scope/WORK_ORDER.md) authorizes autonomous provisional choices; the coordinator owns approval and human questions. This builder owns only this scope, not sections, slides, notebooks or shared records.

## Starting boundary, sources and route choice

Actual protected L01 source and `InClass/Solutions/lecture1_missing_data.ipynb` establish Gaussian conditioning/LGS, inference with known parameters and numerical cross-checks. The delivered ledger boundaries remain B2 §2.3.2/B1 §3.3. L02's agreed, undelivered `section_design.md` supplies categorical probabilities and learned **observed-state** Markov transitions through B2 §2.6.3. Its malformed development-state text adds no authority. Artifacts inspected during this builder's L05 work remain protected.

Reviewed Wave A supplies factor graphs/local-versus-global inference (L03), finite normalized enumeration (L04) and likelihood learning (L05). The new L06 scope establishes latent posterior expectations and EM, primarily for missing Gaussians; it does not teach HMM algorithms. L07 distinguishes normalization, marginalization, prediction and MAP, then deeply develops Laplace. L08 exploits chain structure to perform **exact finite-state inference**, rather than assuming every hidden-variable posterior needs approximation. Future scopes are not delivered coverage; missing L02/L03 prerequisites require backpressure.

**Direct source inspection:** Murphy B2 December 10, 2025 edition, `/tmp/pml-book2.txt`: §9.1; §9.2.1, joint Eq. 9.1 and casino emissions Eqs. 9.2–9.3; §9.2.2 Eqs. 9.5–9.8; §§9.2.3/9.2.3.1 Eqs. 9.9–9.19; §9.2.3.4 normalization; §9.2.5 complexity; §9.2.6/Eqs. 9.39–9.42 path MAP, selective printed pp. 401–409. §9.2.3.3 pair marginals inspected to delimit exclusions. §9.5.1, p. 428, supports a compact elimination interpretation, not its student-network worked example. §8.1.2, pp. 361–362, and §§8.2.2.1–8.2.2.3, pp. 365–367, support Bayesian predict/update and the compact Kalman comparison. B1 adds no required coverage; its Gaussian/Markov background is already available through prior lectures.

**Inspected computational reference:** [casino_hmm.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/casino_hmm.ipynb), local pyprobml checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA256 `975e90d6d095eed5e087121acd9094f57a176e270d76c6ebdbfcf6d312a18ed1`. Its ten cells construct/simulate a known categorical HMM and call Dynamax smoothing/MAP helpers; imports include JAX, Optax, Dynamax, Graphviz and probml-utils. This is application/model provenance, **not an exposed or validated NumPy worked solution**. No reference notebook was executed.

The Oke PS2 questions and `lacity.org-website-traffic.csv` were located and inspected under the instructor's `spring-2026/PS2/PS2-Questions` directory. Problem 3 names `PS2-Kalman-filter-forecasting`, daily device-category sessions, state-dimension comparisons and N4SID/system identification; the named solved notebook remains unverified. This forecasting task is larger than applying a known Kalman filter and requires data aggregation/model-fitting choices. The existing syllabi/notebook audit prefer that candidate; contract v2 provisionally selects HMM instead. The practical-outcome change remains a visible human question below, not a claim that the Kalman application has been preserved.

| Alternative | Endpoint and tradeoff | Provisional choice |
|---|---|---|
| **HMM forward/backward, compact Kalman analogy** | B2 §9.2; implement exact messages and test them against enumeration. New dynamic-programming skill; minimal data/software burden. | **Selected.** Deep discrete reasoning and reusable numerical checks fit one lecture/lab; L01 supports a short continuous comparison. |
| Kalman filtering and real forecasting | B2 §8.2.2; Oke PS2 candidate. Strong application continuity, but preprocessing/system identification and uncertain solved-source access add burden. | Keep as a consequential alternative; selecting it requires reallocating HMM depth/lab, not adding a second implementation. |
| General graph elimination/tree message passing | B2 §§9.3/9.5–9.6; multiple graph queries and ordering effects. | Broad exact-inference endpoint but weaker sequence application and too many graph-specific steps. Retain only chain elimination interpretation. |

## 1. Intellectual arc

These are **macro-level responsibilities, not section contracts**. Section Design can split/combine them within the scope/depth/time constraints. Connections begin receiving segments; every resulting section ends with a retrospective summary. Notebook instructions are a separate lecture-level handoff. All required mathematics is Live; no recording prerequisite.

### A chain factorization turns exponentially many paths into reusable subproblems — 15 minutes

**Transition in:** L07 separated marginal sums from optimization; L02 learned transitions when states were observed. Now states are hidden, but parameters are known and the chain's conditional independence is available.

**Purpose/sources:** B2 §§9.1/9.2.1 and selective §9.5.1; identify exactly which sums the graph can simplify.

**Core:** initial probabilities, row-stochastic transition matrix and state-dependent emissions; joint HMM factorization. Distinguish filtering, smoothing, evidence and path MAP. Write the evidence sum over `K^T` paths, then use distributivity to group prefixes by their ending state. Interpret the resulting partial sum as a message carrying eliminated variables' information. Recall L03 factor scopes; no general elimination-order algorithm or second graph example.

**Retrospective summary:** an HMM's joint is a product of local factors; exact inference sums over hidden paths, and paths ending in the same state share a reusable prefix calculation.

### Forward messages filter the state and compute sequence probability — 27 minutes

**Transition in:** grouped prefixes retain only the current state as their interface to the remaining chain. Derive how the next transition and observation update that interface.

**Purpose/sources:** B2 §9.2.2 and §9.2.3.4; derive rather than merely name the forward algorithm.

**Core:** derive raw forward joint messages from the factorization, then normalized predict/update probabilities. Work the tiny model in Part 4 through its three steps. Each normalization `c_t` is the next observation's predictive probability; their product is evidence and their log sum is log evidence. Explicit initialization uses the initial distribution, not a transition from an invented time-zero state. Online filtering uses no future observations. Known-parameter inference is not HMM training or EM.

**Retrospective summary:** the forward recurrence sums previous-state alternatives before incorporating local evidence; normalized messages are filtered state probabilities, and saved predictive normalizers recover the sequence likelihood.

### Backward messages bring future evidence into each marginal — 27 minutes

**Transition in:** filtering answers an online question; an offline observation sequence also contains evidence after the time being inferred.

**Purpose/sources:** B2 §§9.2.3/9.2.3.1; derive the future-likelihood recurrence and its combination with filtering.

**Core:** derive `β_t(i)=p(y_{t+1:T}|z_t=i)` using a sum over the next state and the HMM independences. Set terminal message one. Combine forward and backward information into the smoothed marginal, explaining why observation `y_t` is included exactly once. Work backward values and one smoothing calculation on the same tiny oracle. A backward likelihood is not a probability distribution over current states. State the consistently scaled backward form using saved `c_{t+1}`; its product with the filtered vector yields normalized smoothing probabilities. No second smoother, two-slice derivation, EM update or sampling pass.

**Retrospective summary:** backward messages summarize future observations as state-dependent likelihoods; combining them with filtered beliefs gives the exact full-data marginal at each time.

### Exact marginals, path decisions and numerical stability are different obligations — 17 minutes

**Transition in:** both passes now produce distributions. Examine what happens when they are turned into decisions or evaluated over longer sequences.

**Purpose/sources:** B2 §§9.2.3.4/9.2.5/9.2.6; consolidate the algorithm's query and computational contract.

**Core:** use the tiny model to show pointwise marginal modes differ from joint path MAP. State Viterbi's max-product recurrence and need for backpointers, with no deep derivation or student implementation. Define marginal MAP for a selected block as optimizing after summing the other states; sum and max cannot generally be exchanged. Account for dense `O(TK²)` work and `O(TK)` stored beliefs, compared with path enumeration. Explain underflow, saved scaling and the log-sum-exp alternative; reuse L05's stability idea. Positive evidence is required: a zero normalizer signals an impossible observation sequence, not permission to divide by zero. No claim that scaling cures every zero/overflow issue.

**Retrospective summary:** exact marginal inference sums paths; a most probable complete path maximizes them and answers a different question. Dynamic programming avoids exponential enumeration, while correct scaling preserves probabilities and sequence evidence.

### Kalman filtering is the Gaussian predict/update instance — 14 minutes

**Transition in:** the discrete filter predicts a state distribution and then conditions on a measurement. L01 already established those two operations for Gaussians.

**Purpose/sources:** B2 §8.1.2 and §§8.2.2.1–8.2.2.3; recognize the same filtering architecture with Gaussian belief parameters.

**Core:** state a linear-Gaussian state-space model with known parameters and independent Gaussian process/measurement noise, omitting controls and biases. Apply L01 marginalization and conditioning to the mean/covariance predict/update formulas; work one scalar update. Explain process-noise uncertainty growth, innovation and gain. State the one-step observation predictive Normal and corresponding evidence factor. No new matrix conditioning proof, full filter implementation, learning of dynamics/noise, real-data forecasting pipeline or Kalman smoother.

**Retrospective summary:** linear-Gaussian dynamics preserve Gaussian beliefs; prediction propagates their moments and measurement conditioning corrects them by the innovation weighted by uncertainty. This filter is exact under the stated model assumptions.

**Extent:** `15+27+27+17+14=100` substantive minutes plus **12 reserve =112 minutes**, including transitions/questions/slippage; separate lab 60. **Tight but plausible, unmeasured, medium-low timing confidence.** Forward and backward/smoothing are the two deep novel derivational chains. Kalman is application of L01, not a third deep derivation. L01's 61 content slides/70 rendered pages and its 29-slide Gaussian span are comparative anchors, not a rate; no measured timings validate this plan.

Provisional novelty calibration: `K=5`, `P≈8–10` substantive page-equivalents, `E_new≈10–12`, `E_carry≈16–22`, `E_deriv≈8–11`, `V≈5–6`. New families are HMM factorization, query distinctions, forward/scaled messages and evidence, backward/smoothing, max-product recognition, complexity and Gaussian sequential prediction. Repeated Bayes/conditioning and messages are carried support. Prototype extent is roughly **21–25 content-slide equivalents**, not a slide target or timing validation; indexed recurrences and state tables can be substantially slower than its coefficients imply.

**First cut:** remove optional Viterbi recurrence mechanics/backpointer illustration while retaining the path-versus-marginal distinction and checked counterexample (about 3–4 minutes); shorten the Kalman matrix catalogue to state the result and work the scalar update (about 3 minutes). Preserve forward/backward derivations, correct evidence scaling and uncertainty interpretation. If further relief is needed, escalate a Scope-level change rather than silently removing Kalman or declaring a full second method taught by a formula table. Recheck actual mathematical steps at Section Design and through a recurrence/example rehearsal.

## 2. Mathematical spine

States `z_t∈{0,…,K−1}`, observations `y_t`; `π_j=p(z_1=j)`, `A_ij=p(z_t=j|z_{t−1}=i)`, `λ_t(j)=p(y_t|z_t=j)`. Belief vectors are columns: prediction is `Aᵀf_{t−1}`. Use `f` for normalized forward beliefs and `a` for raw joints; B2 uses `α` and `α′` respectively. Natural logs/nats for evidence.

| Object/result | Depth, delivery and role |
|---|---|
| `p(z,y)=π_{z_1}∏_{t=2}^T A_{z_{t−1},z_t}∏_{t=1}^T λ_t(z_t)`; `p(y)=Σ_z p(z,y)` | **State + Work**, Live; factorization/finite sums carried, hidden-path structure new. Parameters known. |
| `a_1(j)=π_jλ_1(j)`; `a_t(j)=λ_t(j)Σ_i A_ij a_{t−1}(i)` | **Derive + Work**, Live; grouped prefix sums and evidence `Σ_j a_T(j)`. |
| `u_1=π⊙λ_1`, `c_1=Σu_1`, `f_1=u_1/c_1`; for `t≥2`, `u_t=λ_t⊙(Aᵀf_{t−1})`, `c_t=Σu_t`, `f_t=u_t/c_t` | **Derive + Work**, Live. `f_t=p(z_t|y_{1:t})`, `c_t=p(y_t|y_{1:t−1})`; evidence `∏c_t`, log evidence `Σlog c_t`. |
| `β_T(i)=1`; `β_t(i)=Σ_j A_ijλ_{t+1}(j)β_{t+1}(j)` | **Derive + Work**, Live; future likelihood, not normalized state probabilities. |
| `γ_t(j)=p(z_t=j|y_{1:T})=normalize(f_t(j)β_t(j))` | **Derive + Work**, Live; use independence of past/future given `z_t`, no duplicated `λ_t`. |
| `b_T=1`; `b_t(i)=Σ_j A_ijλ_{t+1}(j)b_{t+1}(j)/c_{t+1}`; `γ_t=f_t⊙b_t` | **State + Explain + Apply**, Live/Notebook. `b_t=β_t/∏_{s=t+1}^T c_s`, so products sum to one in exact arithmetic; explicit final normalization can absorb rounding. Independently normalized backward messages require renormalizing the product. |
| Log-forward update: `v_t(j)=logλ_t(j)+LSE_i(logA_ij+log f_{t−1}(i))`; `log c_t=LSE_j v_t(j)`; `log f_t=v_t−log c_t` | **State + Explain**, Live short alternative, L05 LSE carried. Initialize with `logπ+logλ_1`; structural zeros use `−∞`. Core lab uses scaled probabilities, not a second log-domain implementation. |
| `argmax_z p(z,y)` versus `argmax_j γ_t(j)`; block marginal MAP `argmax_{z_Q}Σ_{z_{−Q}}p(z,y)` | **Work** tiny counterexample; block definition **State**, Live. Pointwise modes minimize expected per-time 0–1 error, path MAP minimizes whole-path 0–1 error. |
| Viterbi `δ_1=π⊙λ_1`, `δ_t(j)=λ_t(j)max_i[A_ijδ_{t−1}(i)]`, backpointers | **State/Explain briefly**, Live optional mechanics; no second deep derivation/implementation. Summation-based inference remains protected. |
| Dense forward/backward `O(TK²)` time; stored `O(TK)` beliefs, `O(K)` streaming filter work memory excluding model | **Explain** by recurrence dimensions, Live. Enumeration has `K^T` paths; arbitrary graph orderings can create larger factors. No treewidth proof/sparse/FFT/parallel algorithms. |
| LGSSM `z_t=Fz_{t−1}+ε_t`, `ε_t~N(0,Q)`; `y_t=Hz_t+ν_t`, `ν_t~N(0,R)` | **State + Motivate**, Live; independent noises and initial Gaussian, known parameters. |
| `m⁻=Fm`, `P⁻=FPFᵀ+Q`; `S=HP⁻Hᵀ+R`, `G=P⁻HᵀS⁻¹`; `m⁺=m⁻+G(y−Hm⁻)`, `P⁺=P⁻−GSGᵀ`; observation predictive `N(Hm⁻,S)` | **Apply + scalar Work**, Live compact; L01 conditioning carried, dynamics prediction new. Use a solve for gain in production; assume required nonsingular innovation covariance. No new derivation or numerical filter code. |

## 3. Notebook handoff — a 60-minute checked HMM inference lab

**Interface:** B2 §§9.2.1–9.2.3.4 and the casino reference's known-parameter model. Students bring NumPy, categorical/Markov probabilities and both derived recurrences. PyTorch from L05 is available but unnecessary; no Dynamax/JAX/Graphviz setup. No required recording.

**Endpoint:** implement scaled forward and backward passes plus smoothed marginals in supplied NumPy scaffolding; compare evidence and every time marginal with exhaustive enumeration on the tiny model; apply the checked inference to a supplied longer casino sequence and interpret filtering versus smoothing. No fitting parameters, Viterbi implementation or Kalman lab.

Instructor supplies arrays/configuration, simulator or fixed observations, tiny enumerator, plotting and shape/assertion harness. Larger application uses the inspected reference's `π=(.5,.5)`, `A=((.95,.05),(.10,.90))`, fair emissions `1/6` each and loaded emissions `(.1,.1,.1,.1,.1,.5)`. No source realization or empirical fraction is promised. A single fixed sequence of roughly 100–200 steps is sufficient; runtime/output must be piloted later.

Budget: **8 min** model/shape interpretation, **15 min** scaled forward/evidence, **14 min** backward/smoothing, **10 min** oracle and normalization checks, **8 min** supplied long-sequence plot and evidence-use interpretation, **5 min reserve = 60**. Required checks include matching enumeration, `Σγ_t=1`, terminal smoothing=filtering, unchanged earlier filtering when future evidence is appended, and an impossible-observation response to a supplied all-zero evidence vector. Larger plots reveal computational behavior; smoothing need not improve every realized classification or lower every realized uncertainty.

First lab cut is an optional transition-persistence sensitivity rerun, excluded from this core budget. If debugging dominates, shorten the supplied larger-plot interpretation while preserving a complete checked algorithm. A second log-domain implementation, parameter training and benchmarking are omitted. The reference hides recurrences in a new stack; **course NumPy worked implementation is not yet authored or validated**. Later authoring must check correctness, 60-minute student workload, clean local uv execution and hosted Colab before publication.

## 4. Concrete examples and provenance

**Required tiny oracle — Work, Live/Notebook, course-constructed:** `K=2,T=3`, `π=(1/2,1/2)`, `A=((4/5,1/5),(1/5,4/5))`, emissions `B=((7/10,3/10),(3/10,7/10))` for observation symbols 0/1, observed sequence `(0,0,1)`. All factors are positive/normalized. Exhaustive rational arithmetic over eight paths verifies these joint weights:

| Path | 000 | 001 | 010 | 011 | 100 | 101 | 110 | 111 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|
| `p(z,y)` | .04704 | .02744 | .00126 | .01176 | .00504 | .00294 | .00216 | .02016 |

Evidence is `589/5000=.1178`; normalizers are `(.5,.548,589/1370)`, whose product matches enumeration. Filtered beliefs are `(.7,.3)`, `(217/274,57/274)`, `(555/1178,623/1178)`. Smoothed beliefs are `(875/1178,303/1178)`, `(.7,.3)`, `(555/1178,623/1178)`. For example, scaled backward at time 2 is `(137/155,137/95)`; multiplying by the time 2 filtered vector yields `(.7,.3)`. Joint path MAP is uniquely `000`, while pointwise marginal modes are `001`. This demonstrates summation/decision distinctions without deriving another algorithm. Values were checked by separate enumeration and recurrence arithmetic in a builder scratch calculation, not by executing a student notebook.

**Casino interpretation — Brief Live, Apply Notebook:** fair/loaded die emissions follow B2 §§9.2.1.1 and the inspected reference. The supplied course sequence/model harness is an adaptation, not Murphy's exact Fig. 9.3 realization. Hidden truth supports interpretation, not proof of posterior correctness. One filtering/smoothing visual group is selected.

**Scalar Kalman update — Work briefly, Live, course-constructed:** previous belief `N(0,1)`, `F=H=1`, `Q=1`, `R=2`, new observation 2. Prediction gives mean 0/variance 2; observation variance 4, gain 1/2; posterior mean 1/variance 1. This applies L01's uncertainty-weighted conditioning and shows process noise increasing prediction uncertainty. No second dataset or implementation.

Approximately 5–6 selected semantic groups cover chain factors, prefix reuse, message tables, filtering/smoothing, path-versus-marginal decisions and Gaussian predict/update. Available B2 Figs. 9.1–9.5 provide context; no exact asset reproduction, figure generation or slide layout is committed.

## 5. Lecture contract

**Starting assumptions:** L01 Gaussian conditioning, agreed L02 categorical/Markov probabilities, L03 factorization and L07 query distinctions; Python/NumPy. L06 supplies context; HMM parameter training is neither assumed nor taught.

**Central question:** how does chain structure make exact posterior sequence inference tractable? **Lecture endpoint:** derive/work forward and backward messages, recover correctly normalized marginals/evidence, distinguish pointwise decisions from path MAP, account for complexity and recognize Gaussian filtering as the same predict/update architecture. **Lab endpoint:** one checked NumPy HMM inference implementation and filtering/smoothing interpretation. **No required recording.** 112-minute inclusive live estimate plus 60-minute lab; unvalidated timings.

Supported outcomes: specify the known-parameter HMM joint; derive the two recurrences and explain message meanings; check scaling/evidence against enumeration; distinguish sum/marginal/max queries; apply one scalar Kalman update under stated assumptions. No mastery of general graph inference or forecasting/system identification is claimed.

| Allocation | Commitment |
|---|---|
| Core/Live deep | B2 §§9.2.1–9.2.3.1, normalization §9.2.3.4, complexity §9.2.5; one exact oracle. |
| Short bridge | §9.1 dynamic-programming framing; §9.5.1 chain elimination interpretation; §9.2.6 path-MAP recognition; §8.1.2 / selected §8.2.2 predict/update application. |
| Notebook owned | NumPy recurrence implementation, scaling/likelihood checks, tiny enumeration comparison and supplied casino interpretation. |
| Optional | Viterbi recurrence mechanics/backpointers; persistence sensitivity outside core lab. |
| Deferred to named owners | Approximate posterior algorithms L09/L10; their Ising/model examples reuse L03. HMM EM has no assigned full derivation; L06 supplies only its general principle. |
| Deliberately omitted | HMM EM/Baum–Welch, two-slice derivation, alternate smoothing/sampling passes, tree/JTA/loopy BP, general ordering/treewidth algorithms, FFT/parallel message algorithms, Kalman smoothing/RTS/EKF/UKF, system identification and real-data forecasting lab. These are not blanket Chapter 8–9 coverage or hidden recording debts. |

**Coordinator-owned bookkeeping:** replace the current preferred Kalman notebook promise and broad Kalman-smoothing/Viterbi-depth wording with these selective future allocations after agent approval; preserve delivered ledger history. B2 advances to selected Chapter 9 chain inference; Chapter 8 is isolated Gaussian application, not full coverage. B1 contributes no new required reading.

**Questions/risks:** (1) **Scope/advisory, consequential human question:** HMM default loses the previously preferred practical website-traffic forecasting outcome. It gains transparent exact inference and avoids an unverified solved source/system-identification burden; retaining forecasting requires choosing Kalman as primary and reducing HMM commitments. Do not claim both outcomes in formal artifacts. (2) **Scope/advisory:** normalized/raw/backward likelihood notation is cognitively demanding; use one consistent convention and retain the oracle. First-cut mechanics above provide 6–7 minutes relief. (3) **Notebook/downstream:** pilot the supplied NumPy scaffold; package-free source adaptation is not yet a tested worked solution. These limitations are bounded, not grounds for self-approval.

**Next owner:** coordinator dispatches an independent Section Design feasibility preview of this full scope, especially indexed recurrences, scaling, query distinctions and 60-minute implementation burden. Review must not construct sections/slides. Builder stops editing on handoff; preview is not timing validation or instructor approval.
