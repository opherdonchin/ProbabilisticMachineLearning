# Course Material Ledger

This file is the canonical coverage ledger for the course.

## Conventions

### Disposition
- `Covered` — substantively taught or practiced.
- `Deferred` — encountered in the current forward path but deliberately left for later.
- `Skipped` — deliberately omitted from the course rather than postponed.
- `Unreached` — beyond the current curriculum boundary.

### Coverage method
Used only when `Disposition = Covered`.
- `Lecture`
- `Notebook`
- `Recording`

Each item has one primary coverage point. Other encounters can be noted briefly in `Comment` (for example, `Reviewed L03` or `Briefly mentioned L01`).

A mention is not coverage.

### Curriculum boundary
Each lecture records a curriculum boundary for each book. The boundary is the furthest point reached by the main progression through that book. Isolated review, examples, or forward references beyond the boundary do not move it.

---

# Lecture 1

## Curriculum boundaries after L01

- **Book 1:** through §3.3, *Linear Gaussian systems*
- **Book 2:** through §2.3.2, *Linear Gaussian systems*

## Book 1

| Section | Material | Disposition | Method | First point | Comment |
|---|---|---|---|---|---|
| §1.1 | What is machine learning? | Covered | Lecture | L01 | |
| §1.2, §1.2.1 | Supervised learning; classification | Covered | Lecture | L01 | Iris/classification framing |
| §1.3 | Unsupervised learning | Covered | Lecture | L01 | Brief taxonomy |
| §1.3.3 | Self-supervised learning | Covered | Lecture | L01 | Brief taxonomy |
| §1.4 | Reinforcement learning | Covered | Lecture | L01 | Brief taxonomy |
| §§1.5.1–1.5.2 | Common image and text datasets | Covered | Lecture | L01 | Examples |
| §2.3 | Bayes' rule | Covered | Lecture | L01 | Review |
| §2.4.1 | Bernoulli and binomial: definition | Covered | Lecture | L01 | Review |
| §2.7.4 | Beta distribution | Covered | Lecture | L01 | Review |
| §3.1.1 | Covariance | Covered | Lecture | L01 | |
| §3.1.2 | Correlation | Covered | Lecture | L01 | |
| §3.1.3 | Uncorrelated does not imply independent | Covered | Lecture | L01 | Brief |
| §§3.1.4–3.1.5 | Correlation/causation; Simpson's paradox | Deferred | — | L01 | |
| §3.2.1 | Multivariate Gaussian: definition | Covered | Lecture | L01 | |
| §3.2.2 | Mahalanobis distance | Covered | Lecture | L01 | |
| §§3.2.3–3.2.4 | MVN marginals/conditionals; 2d conditioning | Covered | Lecture | L01 | Applied again in notebook |
| §3.2.5 | Imputing missing values | Covered | Notebook | L01 | Main notebook application |
| §§3.3.1–3.3.4 | Linear Gaussian systems: Bayes rule, derivation, scalar/vector inference | Covered | Lecture | L01 | Reapplied in notebook |
| §3.3.5 | Sensor fusion | Unreached | — | — | |
| §3.4 | Exponential family | Unreached | — | — | |
| §§4.3–4.3.1 | ERM; minimizing misclassification rate | Covered | Lecture | L01 | Brief; isolated forward reference |
| §§4.6.1–4.6.2 | Conjugate priors; Beta-binomial | Covered | Lecture | L01 | Review; isolated forward reference |

## Book 2

| Section | Material | Disposition | Method | First point | Comment |
|---|---|---|---|---|---|
| §§2.1.5–2.1.6 | Conditional probability; Bayes' rule | Covered | Lecture | L01 | Review |
| §2.2.1.1 | Bernoulli and binomial distributions | Covered | Lecture | L01 | Review |
| §2.2.4.1 | Beta distribution | Covered | Lecture | L01 | Review |
| §2.3.1.1 | Multivariate normal: definition | Covered | Lecture | L01 | |
| §2.3.1.2 | Gaussian shells | Deferred | — | L01 | Removed from revised L01 |
| §2.3.1.3 | MVN marginals and conditionals | Covered | Lecture | L01 | Applied again in notebook |
| §2.3.1.4 | Information/canonical form | Covered | Lecture | L01 | |
| §2.3.1.5 | Derivation: moment form | Covered | Lecture | L01 | Alternative residual-independence route |
| §2.3.1.6 | Derivation: information form | Deferred | — | L01 | |
| §2.3.2.1 | Linear Gaussian joint distribution | Covered | Lecture | L01 | Applied again in notebook |
| §2.3.2.2 | Posterior distribution / Bayes rule for Gaussians | Covered | Lecture | L01 | Applied again in notebook |
| §2.3.2.3 | Sensor fusion with known measurement noise | Unreached | — | — | |
| §2.3.3 | General calculus for linear Gaussian systems | Deferred | — | L01 | Gaussian-potential calculus |
| §2.4 | Exponential family | Unreached | — | — | |
| §3.2.1 | Tossing coins | Covered | Lecture | L01 | Beta-binomial review; isolated forward reference |
| §§3.4–3.4.1 | Conjugate priors; binomial model | Covered | Lecture | L01 | Review; isolated forward reference |

## Lecture 1 delivery notes

- Primary notebook coverage: Book 1 §3.2.5, with repeated application of Gaussian conditioning and linear-Gaussian-system equations from the lecture.
- No separate L01 recording is currently recorded as a primary coverage point.

---

## Provisional future-allocation map — NOT coverage (review branch, 2026-10-10)

This table accompanies the [L04–L10 comparison](l04_l10_curriculum_comparison.md) and the provisional [syllabus plan](../syllabus_plan.typ). It **does not** change any actual disposition or curriculum boundary above. Only material actually taught or assigned is later marked `Covered` with a single primary coverage point. All rows here remain **Unreached** for coverage-accounting purposes until a lecture scope and delivery are confirmed. The **actual competing alternative** is the unchanged main-branch syllabus: combined information/optimization L04, EM L05, general inference L06, structured inference L07, VI L08, MCMC L09, and GLMs L10. This ledger's future-allocation map only represents proposed route B, not a decision against the baseline.

| Murphy Book 2 material | Proposed destination under route A | Limitation / dependency |
|---|---|---|
| §§5.1–5.2 KL, entropy, cross-entropy | L04, lecture | Focus on interpretation plus operational coding consequence; not every KL property or derivation |
| §5.3 Mutual information, data processing, sufficiency | L04, lecture / L04 notebook | Basic quantities and constraints; §5.3.5 multivariate MI, §5.3.6 variational bounds not promised |
| §§5.4–5.5 Source/channel coding | L04, **choose one substantive coding application** | Channel parity decoding preferred; a brief source-coding comparison is possible but not a second full notebook |
| §5.6 Information bottleneck; §5.4.2 rate-distortion | Return as selected mathematical connection in L12 VAE | Distinguish classical supervised IB from VAE compression/rate-distortion; full IB derivation not committed |
| §§6.1–6.2 Differentiation and autodiff | L05, lecture; PyTorch in notebook | Reuse in VI (L09), neural modeling (L11), VAE (L12) |
| §§6.3.1–6.3.3 Stochastic optimization | L05 lecture / notebook | Parameter-learning loop with a categorical likelihood |
| §§6.3.4–6.3.7 Stochastic-distribution gradient estimators | L09 VI or L12 VAE, as needed | REINFORCE, reparameterization, Gumbel softmax not blanket L05 requirements |
| §6.4 Natural gradients | Uncommitted, possible L09 extension | Not a prerequisite for core VI if not chosen |
| §6.5 EM and bound optimization; §28.2 mixtures | L06 | Choose between missing Gaussian data and MRI GMM example; preserve one-hour lab constraint |
| §§6.6–6.9 Bayesian optimization / DFO / transport / submodularity | Not committed | Distinct important fields, not core prerequisites; do not mark as covered or silently deferred to an invented meeting |
| Ch. 7 Inference overview | L07 | Laplace/grid Bayesian logistic notebook |
| Chs. 8–9 Gaussian filtering / message passing | L08 | Kalman vs HMM notebook still undecided |
| Ch. 10 Variational inference | L09 | Includes selected stochastic gradient estimators if needed |
| Chs. 11–12 Monte Carlo / MCMC | L10 | Multimodal proposal-comparison lab rather than routine undergraduate diagnostics |
| §§15.1, 15.3 GLM/logistic form and likelihood | L05, as a substantial optimization example | No full standalone GLM family lecture in route A |
| §15.2 regularization/priors; §14.2 calibration/scoring | Selected L11 with neural predictive models | Squeezing risk: must be checked at L11 scope; old L10 digit notebook not automatically retained |
| Ch. 16 Neural networks | L11 | PyTorch already introduced in L05 |
| Ch. 21 VAEs, selected §§21.3–21.4 | L12 | Rate-distortion/MI interpretation integrated selectively; time budget must be checked |

**Delivery bookkeeping reminder:** L02 is only agreed scope, not recorded as delivered here. L03 and future lectures have no delivered coverage entries. If the alternative GLM-centered sequence is selected, update this map *after* instructor approval and revise the tentative syllabus documents consistently.
