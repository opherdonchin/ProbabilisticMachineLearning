# Course architecture audit — cross-course contract v3

Status: Waves A/B reconciled allocation for Wave C scope builders, 2026-10-11. Base architecture main b78a7650bb09ae851e412089d98525f7b71275d9; execution starts at 906ce71dd9c8e29f3dede51ec809442a885354c9. Only coordinator edits this file.

## Protected course boundary and common budget

L01 delivered deck, Gaussian-imputation notebook InClass/Solutions/lecture1_missing_data.ipynb and ledger are protected. L02 agreed section_design.md is protected: exponential family, log partition moments, moment matching, maximum entropy, Gamma application, categorical counts and Markov-chain learning. L02 is not delivered. Its development_state.md has repeated malformed text and stale branch metadata: do not propagate it or repair it in this batch. No L03–L12 delivery artifacts exist.

Each new lecture: 100–120 minutes live INCLUDING reserve (aim 95–105 minutes substantive work plus 10–15 minutes reserve), separate scaffolded 60-minute lab. Count mathematical novelty, not equations repeated. State timing confidence, tightness and first cut. Recording candidates remain live; no required recordings are introduced. No section partition, slides or notebook implementation. Every macrosegment ends retrospectively; transitions begin receiving segments. Five parts per scope; clear depths and explicit omission/deferment. Sources inspected directly; course-constructed examples labeled. Agent approval only after separate Section Design feasibility review and global reconciliation; instructor pending.

## Primary ownership and named exclusions

| Source | Primary destination and depth constraint | Exclusions / later reuse |
|---|---|---|
| B2 Ch4 DAG factorization/CI, MRF potentials/Z/Ising/local CI, factor graphs | L03 substantive undirected mathematics; compact DAG recall with correct collider/faithfulness distinctions | CRF learning, graph structure learning, SCM/do calculus, relational/circuit models omitted; inference algorithms L08/L09/L10 |
| B2 Ch5 entropy/KL/MI/DPI and channel coding | L04 MI identity, DPI proof sketch, finite parity-channel enumeration | Lossless coding bounds stated; no full coding theorems, multivariate/variational MI, bits back, algorithmic information; rate-distortion L12; IB optional comparison only |
| B2 15.1, 15.3.2; 6.2, 6.3.1–2 | L05 canonical GLM family and ONE common gradient; vector softmax applied separately; ONE reverse AD graph; SGD | Hessian/IRLS, full Bayesian GLM, sparse prior taxonomy omitted; 15.2 Gaussian weight decay L11; stochastic distribution gradients L09 |
| B2 6.5.1, 6.5.3–4; 28.2; B1 3.5,8.7 | L06 EM bound identity/monotonicity; one worked primary model | Prefer Gaussian missing-data lab to repay L01; GMM illustration compact, MRI alternate; general MM/robust regression/EM extensions omitted; ELBO generic VI reuse L09 |
| B2 Ch7 | L07 query taxonomy compact; Laplace from Taylor and one scalar logistic grid benchmark | VI/MCMC/SMC only recognized; no methods duplicated; no broad challenging-posterior tour |
| B2 Ch8–9 | L08 one exact sequence method deep, other compact connection | Provisional preference HMM forward/backward core and scaffolded HMM lab; Kalman as L01 reuse stated/worked compactly; avoid two implementations; EKF/UKF/RTS, loopy BP, JTA omitted; VE concept compact |
| B2 Ch10; 6.3.3–5 | L09 generic VI identity REUSE L06; Gaussian pathwise estimator primary derivation; small mean-field CAVI illustration | Score-function stated as contrast; no full CAVI/VBEM derivation catalog, natural gradients/flows/IWAE/EP/wake-sleep; amortization recognized here, operational L12; exact Gaussian reference lab preferred to pre-L10 HMC dependency |
| B2 Ch11–12 | L10 MC variance, MH detailed balance, Gibbs as MH, multimodal proposal/mixing lab | Importance sampling narrow contrast, rejection briefly; HMC mechanics stated leveraging undergraduate tool use, no full derivation; advanced MCMC/tempering omitted |
| B2 Ch13; 6.6–9 | Deliberately omitted substantive teaching | SMC mention L07; Bayesian/DFO/transport/submodular optimization not deferred debt |
| B2 Ch15 remainder | 15.1 and softmax L05; Gaussian prior/weight decay L11 | Sparse priors, hierarchical GLM inference, robust/multitask/ordinal models omitted; L07 scalar logistic inference specific reuse |
| B2 Ch16; B1 selected Ch13 | L11 MLP nonlinear conditional model and heteroskedastic Gaussian NLL, reuse L05 AD/SGD | No architecture zoo; CNN/RNN/transformers, dropout theory, full calibration/model selection omitted; autoencoder context L12 |
| B2 Ch21; 5.4.2 | L12 VAE ELBO specialization, Gaussian KL, beta-rate-distortion, collapse; reuse L09 pathwise math | MNIST small CPU/checkpoint lab provisional default; mobility alternative only if inspectable; IB/InfoVAE optional mentions, IWAE/VQ/hierarchical/discrete VAE omitted |

## Source access and provenance

Local Murphy B2 online edition December 10, 2025: /home/opher/OneDrive/CurrentSemester/Teaching/Advanced Bayesian Statistics/Oke Advanced Probability Course/book2-1.pdf; extracted /tmp/pml-book2.txt. Local B1: /home/opher/OneDrive/CurrentSemester/Teaching/Advanced Bayesian Statistics/Books/book1.pdf; extracted /tmp/pml-book1.txt. These scratch paths are execution aids, not repository dependencies. Read actual passages and verify subsection labels (B2 9.2 is HMM, 8.2.2 Kalman, 6.5.4 missing MVN). Legitimate reference notebooks available locally under /home/opher/Repositories/pyprobml/notebooks. Inspect source, not just titles. Do not read student submissions in Oke folders. Record notebook source hashes/commit, package differences and what remains unrun. No runtime validation claims.

## Reconciliation gates

Wave A L03–L05 establishes representations, information and trainable conditional models. Wave B L06–L08 consumes these without repeating them. Wave C L09–L12 synthesizes inference, stochastic computation and neural models. At each wave reconcile dependencies, budgets and sources before next wave; contracts can change through scoped builder revisions. Whole-course independent adversarial review follows all ten scopes.

## Wave A reconciliation — coordinator disposition

L03 blob f4dab507f90618362c2e04c1c3791c8139f7de56 / independent /root/review_l03: feasible-with-risks. L04 blob242ee28d251d583004daa25379b6a0f8cb44d622 / independent /root/review_l03: feasible-with-risks. L05 blob736943b90f24826e29955115896929742f2961f5 / independent /root/review_l05: feasible-with-risks. No blocking findings; raw reports preserved. These scopes meet the per-lecture agent gate, instructor pending; whole-course adversarial gate remains open and may invalidate affected approvals.

- L03 local conditional and deterministic ICM are model/optimization mathematics, not premature Gibbs or VI. Exact square oracle protects the local/global distinction. Optional GMRF comparison is first cut. No Potts, CRF or MRF-learning promise survives into formal outputs.
- L04 selects a course-constructed 2→5, minimum-distance-three parity code, preserving error correction; actual source XOR is optional contrast. MI/DPI is substantial; source-code bounds are stated, rate-distortion is L12-owned. Conditional MI is proof support and sufficiency only a bounded recall (finite candidate-parameter framing when concrete; no parameter entropy calculation).
- L05 owns one general scalar canonical gradient, a separate short vector softmax specialization, one full fan-out reverse graph and minibatch SGD. Family comparison is protected. Lab owns first PyTorch mechanics with given data/indices/plotting. Optional MAP/probit/repeated applications are first cuts; no new prerequisite is allocated to L02.
- Live totals including reserve:112/110/115 minutes; each lab60. All unmeasured, tight, within envelope. Advisory pacing and lab-scaffolding risks accepted provisionally and routed to downstream implementation; no source or runtime validation overstated.

### Additional Wave B/C input decisions

L06 should deeply work missing-Gaussian EM (expected second moments and ignorability explicitly), keeping any GMM illustration short rather than deriving two complete M-steps. L07 owns one Laplace approximation, not a survey of later algorithms. L08 HMM forward/backward is the preferred exact core and lab; Kalman compactly applies L01 conditioning, no second implementation. A named Oke Kalman notebook is unverified despite questions/data being located; record the practical loss as a human question.

L09 should use a known-noise Gaussian regression or controlled correlated-Normal exact reference to avoid requiring HMC before L10; real GDP data may be retained only if the simplified model/data burden fits. L12 mobility materials have now been directly located and inspected (source_inspection.md); compact PyTorch tabular VAE is a defensible preferred route, with explicit per-observation reconstruction/KL normalization and no guaranteed identifiability/causality claim. MNIST is a fallback rather than an automatic default; final choice belongs to its builder and independent review. Data redistribution and all runtimes remain later publication gates.

## Wave B reconciliation — coordinator disposition

L06 blob326267281c6b6775ac9a33d7ed4f022a859fc49b reviewed by /root/review_l05; L07 blobf12fba8de7339675d09a771c5f956c8ed93649d8 reviewed by /root/review_l05; L08 blobb7a2de325c364bcde8230c33aaba2a5cd6b8596a reviewed by /root/review_l03. All verdicts feasible-with-risks, no unresolved blockers; raw reports preserved. Per-lecture agent gates pass, instructor/global audit pending.

- L06 owns the generic bound/KL identity, tightness, Q-versus-bound distinction and exact-EM monotonicity. Missing-Gaussian first/second moments are the one deep model; the GMM responsibility bridge is recognition only, numerical comparison optional. No full MRI/GMM fit is promised.
- L07 owns scalar Laplace normalization and curvature, using a fixed eight-observation logistic case and domain/resolution-challenged grid reference. It does not implement later VI/MCMC. Model-specific scalar Hessian here does not turn omitted general Newton/IRLS into a prior L05 obligation.
- L08 owns scaled HMM forward/backward, smoothing and exact path/marginal distinctions; Kalman is a14-minute application of L01 conditioning with no second implementation. Viterbi mechanics optional; its general maximization distinction can be recognized. Supplied notebook harness must include an asymmetric-transition check because the selected symmetric eight-path oracle cannot detect transposition mistakes. This is a downstream test obligation, not another live example.
- Live totals including reserve112/110/112 minutes; each lab60. Source proof/algorithm mismatches were corrected, not inherited. Optional mixture, Beta/determinant and Viterbi additions are first cuts. No workload or Colab pass is claimed.

### Wave C load budget and handoff

L09 reuses generic F/KL from L06 rather than rederiving it. Make restricted-q optimization and one Gaussian pathwise gradient genuinely substantive; CAVI is a bounded worked/recognized contrast, not a second long general derivation. Correct Gaussian KL sign/constant explicitly (original PDF p448 checked). Exact known-noise regression/correlated-Normal reference avoids pre-L10 HMC; any real-data variant must not add a new Pyro stack or unbudgeted preprocessing. Amortization recognized, networks/encoder implementation L12.

L10 owns IID MC variance and dependent-chain estimator interpretation, MH detailed balance and stationarity assumptions, Gibbs-as-MH recognition/work. Multimodal proposal comparison is the one lab; HMC mechanics compactly contextualize familiar undergraduate NUTS rather than deriving a second algorithm.

L11 owns MLP nonlinear conditional prediction and heteroskedastic Normal likelihood/positive scale; reuse L05 AD/SGD. Weight decay is Gaussian-prior connection, not sparse-prior/BNN/calibration survey. L12 owns VAE objective specialization, Gaussian KL, encoder/decoder joint training and rate-distortion rate>=MI decomposition; reuse L09 pathwise gradient and L11 network code. β does not guarantee identified/disentangled scientific factors.

All Wave C labs must include software refresh and interpretation in the60-minute envelope. Scope outputs remain proposed implementations, not validated notebooks; no recording-dependent hidden prerequisites.
