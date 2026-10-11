# Course architecture audit — cross-course contract v1

Status: provisional allocation for scope builders, 2026-10-11. Base architecture main b78a7650bb09ae851e412089d98525f7b71275d9; execution starts at 906ce71dd9c8e29f3dede51ec809442a885354c9. Only coordinator edits this file.

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
