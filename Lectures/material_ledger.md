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

## Reviewed future allocation — agent-approved / instructor-pending (2026-10-11)

Architecture accepted in PR #8; detailed scope proposal independently reviewed. This section is future planning only. Every undelivered item remains **Unreached** in actual accounting; no planned Deep/Bridge/Notebook row is promoted to Covered. L02 remains agreed, not delivered. The delivered L01 tables and curriculum boundaries above are unchanged.

| Future owner | Selected source / actual depth | Notebook-owned extension / named limit |
|---|---|---|
| [L03](L03_Graphical_Models/lecture_scope.md) | 4.2.1 / 4.2.4 DAG recall (selected); 4.3.1–4.3.2.1 MRF / Ising normalization; 4.3.6.1 CI; selected 4.3.8 restoration model; 4.6.1.1 Factor graphs | Check a local Ising conditional against enumeration, then restore a noisy course image with a supplied coordinate-update driver. Label the result a coordinate-stable candidate, not exact MAP or posterior marginals. |
| [L04](L04_Information_Theory/lecture_scope.md) | 5.1.3 / 5.1.6; 5.2.1 / 5.2.4 Finite quantities (selected); 5.3.1–5.3.4 MI / DPI / bounded sufficiency; 5.4.1 Source-length bounds (state); 5.5 Channel decoding (course adaptation) | Enumerate a four-message, five-bit channel; compute MI and exact Bayes block error; expose ties and compare noise curves with channel-use cost. |
| [L05](L05_GLM_Optimization/lecture_scope.md) | 15.1 / 15.1.1 / 15.1.3 GLM family and canonical gradient; 15.1.2 Noncanonical-link contrast only; 15.3.2 Multinomial softmax; 6.2 (selected); 6.3.1–6.3.2 Reverse AD and finite-sum SGD | Fit all three Iris species with an affine softmax model; check manual versus autograd batch gradients, run visible SGD and evaluate held-out probabilities/log loss. |
| [L06](L06_EM/lecture_scope.md) | 6.5.1 / 6.5.3 Bound optimization and EM (selected); 6.5.4 Gaussian missing-data EM; 3.11 Ignorability (bounded statement); 28.2.1 Mixture responsibility recognition only | Complete expected Gaussian sufficient statistics, aggregate an E/M update and use a supplied driver to inspect observed likelihood and missing-entry reconstruction. |
| [L07](L07_Inference/lecture_scope.md) | 7.1–7.3 Query framing (compact); 7.4.1–7.4.3 MAP / grid / scalar Laplace (selected); 7.5 Approximation checks (selected); 15.3.5–15.3.6 Scalar logistic application only | Build a domain/resolution-challenged grid reference for a fixed eight-observation logistic posterior; compare Laplace, posterior moments and prediction. |
| [L08](L08_Structured_Inference/lecture_scope.md) | 9.2.1–9.2.5 HMM inference / scaling / complexity; 9.2.6 Path-versus-marginal decision distinction only; 8.1.2 / 8.2.2 Kalman application (selected) | Implement scaled HMM recursions and marginals with supplied simulation/plots; compare tiny enumeration and include a supplied asymmetric-transition assertion. |
| [L09](L09_Variational_Inference/lecture_scope.md) | 10.1.1–10.1.2 Restricted objective / family; 6.3.3 / 6.3.5; 10.2.1.1 Gaussian pathwise gradient; 6.3.4 Score-function contrast (state); 10.3.1 CAVI application; 10.1.5 amortization (recognize) | Optimize one diagonal Gaussian for controlled known-noise regression; compare exact and analytic best-diagonal posteriors and query-specific predictive variances. |
| [L10](L10_MCMC/lecture_scope.md) | 11.2–11.2.2 MC integration / variance; 2.6.4; 12.2.1–12.2.2 Stationarity / MH; 12.3.1–12.3.2 Gibbs (bounded); 12.6.3 Dependent error (selected); 12.5.3 HMC recognition | Complete a NumPy MH kernel and compare proposal scales/dispersed starts on a fixed multimodal mixture; assess mean and mode-mass queries against exact references. |
| [L11](L11_Neural_Prediction/lecture_scope.md) | 16.2.1–16.2.2 / 16.3.1 MLPs (selected); 15.2.2.1 Gaussian-prior connection only; 14.2.1 Log-score application only | Fit one shallow heteroskedastic PyTorch model and compare held-out NLL/MSE and conditional intervals with a supplied nonlinear fixed-scale baseline and known generating law. |
| [L12](L12_VAE/lecture_scope.md) | 21.1–21.2 VAE model / amortization / objective (selected); 21.3.1 Beta-VAE; 5.4.2 Rate–distortion / rate decomposition (selected); 21.4 Collapse diagnostics (selected) | Complete a compact mobility VAE objective and bounded joint update run; compare freshly normalized beta summaries and descriptive latent patterns using supplied fits when needed. |

**Named exclusions:** Ch13 SMC; 6.4/6.6–9 optimization fields; specialized CRF/MRF fitting; general nonchain exact/loopy methods; full VI/CAVI/VBEM/EP/flow catalogue; full HMC/advanced MCMC; sparse/hierarchical GLM inference; broad calibration/conformal; architecture/BNN/GP/shift/generative-model surveys and VAE extensions. Mentions and optional comparisons are not coverage.

**Bounded later returns:** generic ELBO primary L06, restricted-q/pathwise L09, VAE application L12; information primary L04, rate–MI decomposition L12; stationary Markov theory selected§2.6.4 L10. Gaussian conditioning/log-partition/AD are reused, not derived in every lecture. Prior deferred entries above preserve historical decisions; future exclusion here does not pretend they were taught.

**Book 1:** selective source support only, as each scope records. No numerical chapter boundary is advanced merely by a support/example reference.

**Evidence and authority:** [registry](course_architecture_scope/STATUS.md), [source-to-lecture audit](course_architecture_scope/architecture_audit.md), [raw reviews](course_architecture_scope/reviews/), [human choices](course_architecture_scope/questions_and_hesitations.md). Delivery updates require actual substantive lecture/notebook/recording coverage; no new required recording or tested notebook is claimed.
