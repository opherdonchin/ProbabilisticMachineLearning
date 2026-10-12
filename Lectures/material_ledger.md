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

## Proposed future teaching — not delivered material

The tables above are the actual L01 record and remain unchanged. The following table is a plan. “Future” does not mean students have learned it: undelivered material remains Unreached in the ledger. L02 is agreed but not recorded as delivered. The instructor selected the simpler L03/L04 activities; later choices remain proposals. [Review versions](course_architecture_scope/STATUS.md) and the [detailed book map](course_architecture_scope/architecture_audit.md) are kept separately.

| Lecture | What students would learn | Notebook activity |
|---|---|---|
| [L03](L03_Graphical_Models/lecture_scope.md) | Directed-graph independence recall; positive Markov random fields and Ising normalization; derive a local conditional by factor cancellation and the Gaussian-noise posterior score. Use iterated conditional modes (sequential coordinate maximization), with a counterexample to global MAP optimality. Represent factor incidence explicitly. | Derive and implement the local field/conditional; verify normalization by exact enumeration on four pixels, then apply a supplied sequential image-update driver. Compare score improvement with reconstruction quality. |
| [L04](L04_Information_Theory/lecture_scope.md) | Finite entropy, cross-entropy and KL divergence; derive mutual information and sketch the data-processing inequality with its conditional-independence premise. State source-length bounds. Work three-bit parity detection and posterior decoding, distinguishing information, Bayes message risk and a coding guarantee. | Construct the four-message/eight-observation noisy-channel table. Compute mutual information and optimal whole-message Bayes error, including ties and zero-support cases. Compare resource use; reference stronger single-error correction separately. |
| [L05](L05_GLM_Optimization/lecture_scope.md) | Conditional exponential-family models: Gaussian, Bernoulli and Poisson supports, mean/link and dispersion. Derive one canonical NLL gradient, work the distinct vector softmax gradient, trace reverse-mode differentiation through a shared computational graph, and explain finite-sum minibatch stochastic gradient descent. | Fit the three-class Iris softmax model in PyTorch; compare the manual mean-batch gradient with autograd at identical parameters, run visible SGD updates and evaluate held-out log loss/probabilities. Data preparation and program scaffolding are supplied. |
| [L06](L06_EM/lecture_scope.md) | Derive the ELBO/KL identity, exact E-step tightness and EM likelihood monotonicity under its assumptions. Apply Gaussian conditional first and second moments to unknown mean/covariance with missing data. State ignorability and positive-definiteness conditions; illustrate mixture responsibilities briefly. | Assemble expected Gaussian sufficient statistics, including conditional covariance, and perform an E/M update inside a supplied iteration driver. Check observed likelihood and missing-entry reconstruction; no second full mixture fit. |
| [L07](L07_Inference/lecture_scope.md) | Posterior queries and parameterization-dependent MAP; derive scalar Laplace curvature and normalizer under positive-curvature conditions. Apply to proper-prior logistic regression, check quadrature domain and resolution, and compare posterior moments and predictive integrals. | Build a stable quadrature reference for the fixed eight-observation logistic posterior, challenge domain and mesh separately, and assess Laplace error in moments and prediction. Solver/plot helpers are supplied. |
| [L08](L08_Structured_Inference/lecture_scope.md) | Derive scaled HMM forward/backward recursions, evidence and filtered/smoothed marginals; establish dense computational cost and distinguish joint path MAP from marginal modes. Give a compact Kalman-filter application of L01 Gaussian conditioning, without a second full sequence implementation. | Implement scaled HMM likelihood messages and marginals in NumPy. Check tiny-sequence enumeration and an asymmetric-transition case to expose orientation errors. Simulation, reference and plotting code are supplied. |
| [L09](L09_Variational_Inference/lecture_scope.md) | Reuse L06 ELBO identity; optimize restricted reverse KL and work the correlated-Gaussian diagonal optimum. Derive the total pathwise gradient including direct parameter terms and regularity conditions; apply bounded coordinate-ascent VI and recognize amortization. | Fit a diagonal Gaussian to controlled known-noise regression using reparameterized PyTorch gradients. Compare exact posterior and analytic best-diagonal solution; use fixed-noise, matched-estimator gradient checks and query-specific predictive variances. |
| [L10](L10_MCMC/lecture_scope.md) | Derive IID estimator variance, stationarity/detailed balance and the general Metropolis–Hastings ratio, retaining rejected states. Explain Gibbs cancellation briefly and dependent-sample error under its conditions. Distinguish invariant transitions, finite-run mixing and function-specific effective sample size; recognize HMC mechanics only. | Implement the NumPy MH kernel on a fixed bimodal target. Compare proposal scales and dispersed starts; assess the mean and probability above zero against exact references. Supplied diagnostics flag stuck chains and query-dependent error. |
| [L11](L11_Neural_Prediction/lecture_scope.md) | Nonlinear feedforward mean/positive-scale model; derive heteroskedastic Gaussian NLL and output derivatives, reusing AD/SGD. Distinguish conditional observation noise from posterior weight uncertainty via total variance. Work the Gaussian-prior/L2 coefficient under mean-loss normalization. | Fit one shallow PyTorch mean/scale network and compare held-out NLL, MSE and conditional intervals with a supplied fixed-scale nonlinear baseline and known data law. Match splits/shapes and estimate baseline noise using training data. |
| [L12](L12_VAE/lecture_scope.md) | Generative model versus amortized posterior; joint encoder/decoder objective with event-summed Gaussian NLL and diagonal KL, then observation averaging. Reuse ELBO/pathwise/neural results. Derive rate as mutual information plus aggregate-posterior mismatch; interpret beta, collapse and nonidentifiability. | Complete the compact mobility VAE loss and one bounded joint fit. Use fresh, consistently normalized supplied beta comparisons; evaluate expected-q reconstruction NLL and average prior KL, keeping encoder-mean visualizations separate. |

## Where ideas return

L06 first explains the probability bound used for missing-data learning. L09 uses that result to fit an approximate posterior; L12 uses it to train two networks together. L04 introduces shared information; L12 asks whether hidden coordinates actually carry information about observations. L05 introduces derivative software and parameter updates, which L09/L11/L12 reuse. Those later uses do not require teaching the original proof again.

Important omitted capabilities include general graph solvers, particle tracking, complex regression extensions, full advanced sampler theory, Bayesian neural-network uncertainty and alternative generative models. Their names and exact book references are author lookup details in the course map, not presumed instructor knowledge. No omission advances a delivered book boundary or creates an unapproved recording assignment. Delivery entries must be updated only after actual teaching.
