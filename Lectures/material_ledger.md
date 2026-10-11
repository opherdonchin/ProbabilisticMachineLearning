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
| [L03](L03_Graphical_Models/lecture_scope.md) | Use graphs to describe which variables interact. Build and normalize a small black-and-white pixel model; calculate the probability of one pixel given its neighbors. Improve a noisy image one pixel at a time, and show why this can stop short of the best whole image. | Calculate a pixel update, check it by listing every configuration of a tiny image, and use a supplied program to repeat updates on a larger image. |
| [L04](L04_Information_Theory/lecture_scope.md) | Measure uncertainty and shared information. Explain why processing cannot create information about the original source. Add one parity bit—a bit that checks whether two message bits differ—and calculate what a noisy transmission tells us. Distinguish detecting an error from guaranteeing its correction. | List the eight possible received three-bit strings. Calculate message probabilities, information and best-guess error; explain ambiguous results. Reference a stronger five-bit code without implementing it. |
| [L05](L05_GLM_Optimization/lecture_scope.md) | Compare models for numerical, yes/no and count outcomes: generalized linear models. Derive a common likelihood derivative, then apply it to three-class prediction. Explain automatic differentiation by following one complete calculation backward. Fit parameters using small batches of observations. | Fit probabilities for all three Iris species in PyTorch. Compare a hand-calculated derivative with the software result, update parameters repeatedly and evaluate new observations. |
| [L06](L06_EM/lecture_scope.md) | Alternate between estimating missing quantities under the current model and updating the model: expectation-maximization (EM). Keep uncertainty about missing values when learning a Gaussian mean and covariance. Explain the probability bound used to justify the updates and the conditions for improvement. | Complete the expected values and second moments needed to fit a Gaussian to incomplete measurements. Use a supplied update loop and inspect likelihood and reconstruction. |
| [L07](L07_Inference/lecture_scope.md) | Use a one-parameter logistic model to compare a posterior computed on a fine grid with a Gaussian fitted near its peak: the Laplace approximation. Check the grid’s range and spacing, and compare posterior summaries and predictions. Explain why the most likely parameter depends on how we express it. | Construct a numerical posterior reference, change its range and spacing, then compare the Gaussian shortcut and predictions. Solver and plotting helpers are supplied. |
| [L08](L08_Structured_Inference/lecture_scope.md) | Infer whether a fair or loaded die produced each observation: a hidden Markov model. Derive repeated forward/backward calculations using earlier and later observations, prevent numerical underflow and distinguish the best whole history from the most likely state at each time. Briefly apply Gaussian conditioning to Kalman filtering. | Implement the central hidden-state calculations in NumPy. Check a short sequence by listing its histories, including a test where transition directions matter. Simulation and plots are supplied. |
| [L09](L09_Variational_Inference/lecture_scope.md) | Fit a simpler probability distribution to a posterior: variational inference. Show what an independent-coordinate Gaussian loses when the posterior has correlations. Derive how to differentiate a random-sample calculation and briefly apply coordinate-by-coordinate updates. Reuse L06’s probability bound. | Fit an independent-coordinate Gaussian to a regression posterior with a known exact answer. Compare fitting error, the limitations of the chosen distribution and predictive uncertainty. |
| [L10](L10_MCMC/lecture_scope.md) | Estimate expectations by averaging samples. Introduce a chain whose next sample depends on the previous one, then derive the Metropolis–Hastings accept/reject rule. Explain why preserving the target distribution is different from exploring it quickly, and why error depends on the quantity being estimated. | Complete a NumPy accept/reject sampler. Compare proposal sizes and starting points on a distribution with two separated peaks; check the mean and the probability of a value greater than zero against known values. |
| [L11](L11_Neural_Prediction/lecture_scope.md) | Replace a linear prediction rule by a small neural network. Predict both a mean and positive standard deviation, derive the Gaussian likelihood calculation and reuse automatic differentiation. Distinguish variation in observations from uncertainty about fitted weights. Explain a Gaussian-prior connection to shrinking weights. | Fit one small nonlinear Gaussian model and compare it with a supplied fixed-noise model on new observations. Inspect predicted noise and intervals. |
| [L12](L12_VAE/lecture_scope.md) | Learn one network that describes observations with hidden coordinates and another that predicts observations from them: a variational autoencoder. Reuse the probability bound, sample derivatives and neural likelihoods. Study the reconstruction/penalty tradeoff and why a penalty value alone does not measure useful information or reveal unique causes. | Complete a small mobility-data model and one joint training run. Use prepared comparison runs to study reconstruction and hidden descriptions under different penalty strengths. |

## Where ideas return

L06 first explains the probability bound used for missing-data learning. L09 uses that result to fit an approximate posterior; L12 uses it to train two networks together. L04 introduces shared information; L12 asks whether hidden coordinates actually carry information about observations. L05 introduces derivative software and parameter updates, which L09/L11/L12 reuse. Those later uses do not require teaching the original proof again.

Important omitted capabilities include general graph solvers, particle tracking, complex regression extensions, full advanced sampler theory, Bayesian neural-network uncertainty and alternative generative models. Their names and exact book references are author lookup details in the course map, not presumed instructor knowledge. No omission advances a delivered book boundary or creates an unapproved recording assignment. Delivery entries must be updated only after actual teaching.
