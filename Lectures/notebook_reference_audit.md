# What the proposed notebooks ask students to do

**Historical implementation/reference audit (2026-10-13):** The references and mathematical checks below belong to the previous notebook proposals. The new [course architecture](../course_architecture.typ) emphasizes practical ML applications and proposes a different L04 notebook and a shared L07/L09/L10 classifier exercise. New notebooks are not built or validated; consult the current architecture and do not treat the old per-lecture checks as implementation evidence for the newer exercises.


This record separates the central student task from the programs the authors must supply. A 60-minute lab is not a promise that students build a complete inference or training system from scratch. All future course adaptations are still unwritten/unrun; inspecting a reference notebook does not test the proposed student task.

L01's [Gaussian missing-data solution](../InClass/Solutions/lecture1_missing_data.ipynb) is established material and was not changed or re-executed here. L02's agreed [character-bigram reference](https://github.com/karpathy/nn-zero-to-hero/blob/master/lectures/makemore/makemore_part1_bigrams.ipynb) counts neighboring characters, normalizes transition probabilities, scores strings and generates names. It stops before neural modeling and is not recorded as delivered by this project.

## The single main task in each later meeting

### L03 — Graphical models: student model construction and local inference

Construct an Ising prior and Gaussian observation likelihood; derive the joint, posterior and single-site conditional. Implement or complete sequential local maximization (ICM) in a NumPy scaffold; compare with a pixelwise baseline and examine initialization or local-optimum limitations.

**Skill practised:** Build a probabilistic restoration model from local factors, derive its posterior update, and distinguish local maximization from a global optimum or posterior marginal inference.

**Authors supply:** image/data preparation, plotting, stable notation, small implementation interfaces and verification aids. Preserve the students’ model construction and posterior/conditional derivations as new notebook work; the lecture must not pre-solve them. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** The existing agreed scope requires this simpler method as notebook work. It differs from Murphy’s sampling/mean-field algorithms and does not promise a global optimum or posterior uncertainty. Completing both the mathematical model and algorithm in one hour remains demanding and untested. [Detailed scope](L03_Graphical_Models/lecture_scope.md).

### L04 — Information theory: mutual information, processing and noisy coding

Extend the lecture's 2-message-bit + parity code to `c5(m1,m2)=(m1,m2,m1,m2,m1 XOR m2)`; prove minimum distance 3; implement/check MAP decoding and use a supplied 4×32 channel enumeration to compare MI, Bayes error and rate with the three-bit and uncoded baselines.

**Skill practised:** Construct a correcting code and use a finite probability model to compare guaranteed single-error correction, average noisy-channel error, mutual information and transmission cost.

**Authors supply:** 32 received-word enumeration, vectorized probability/axis helpers, lecture-code and uncoded benchmark outputs, log-zero/tie-safe utilities, plots and noise sweep; students retain codeword-distance analysis and decoder implementation. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** The instructor chose the **lighter three-bit code for the lecture and stronger five-bit code for the notebook**. The former detects but cannot guarantee recovery; the latter corrects up to one error at higher transmission cost. One-hour workload remains untested. [Detailed scope](L04_Information_Theory/lecture_scope.md).

### L05 — Generalized linear models, automatic differentiation and SGD

Fit the three-class Iris softmax model in PyTorch; compare the manual mean-batch gradient with autograd at identical parameters, run visible SGD updates and evaluate held-out log loss/probabilities. Data preparation and program scaffolding are supplied.

**Skill practised:** Connect a likelihood derivative with reverse-mode automatic differentiation and a checked stochastic parameter-update/evaluation loop.

**Authors supply:** data split/scaling, target indexing, plots and a simple training-loop framework. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** First PyTorch use makes this meeting tight. Data preparation and plotting are supplied; the lecture does not teach a large software framework. [Detailed scope](L05_GLM_Optimization/lecture_scope.md).

### L06 — Latent-variable learning and expectation-maximization

Assemble expected Gaussian sufficient statistics, including conditional covariance, and perform an E/M update inside a supplied iteration driver. Check observed likelihood and missing-entry reconstruction; no second full mixture fit.

**Skill practised:** Use conditional uncertainty in sufficient-statistic estimation and distinguish an exact EM improvement guarantee from arbitrary approximate hidden-value updates.

**Authors supply:** incomplete data, masks, matrix checks, repeated-update program and likelihood calculation. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** This replaces the candidate MRI tissue-classification lab. Class-assignment probabilities are explained briefly; a second mixture-model fit is not required. [Detailed scope](L06_EM/lecture_scope.md).

### L07 — Bayesian computation: grid reference and Laplace approximation

Build a stable quadrature reference for the fixed eight-observation logistic posterior, challenge domain and mesh separately, and assess Laplace error in moments and prediction. Solver/plot helpers are supplied.

**Skill practised:** Validate the numerical reference as well as the posterior approximation, and separate local curvature matching from global integral/prediction accuracy.

**Authors supply:** solver wrapper, grid framework and plotting. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** The small example is chosen for checkability. A finite grid is also an approximation, not an automatically exact answer. [Detailed scope](L07_Inference/lecture_scope.md).

### L08 — Exact inference in structured sequence models

Implement scaled HMM likelihood messages and marginals in NumPy. Check tiny-sequence enumeration and an asymmetric-transition case to expose orientation errors. Simulation, reference and plotting code are supplied.

**Skill practised:** Use sum-product dynamic programming to obtain exact sequence probabilities and marginals while controlling numerical scaling.

**Authors supply:** simulation, a short-sequence exact comparison, direction-sensitive transition test and plots. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** The main lab is discrete hidden-state inference. The previously preferred continuous Kalman forecasting lab is not included. [Detailed scope](L08_Structured_Inference/lecture_scope.md).

### L09 — Variational inference: posterior geometry and pathwise gradients

Fit a diagonal Gaussian to controlled known-noise regression using reparameterized PyTorch gradients. Compare exact posterior and analytic best-diagonal solution; use fixed-noise, matched-estimator gradient checks and query-specific predictive variances.

**Skill practised:** Separate optimization error from variational-family error, and differentiate a parameter-dependent expectation with correct full-data likelihood/prior scaling.

**Authors supply:** exact posterior/best-restricted comparisons, parameter-update program and plots. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** Uses controlled data and known noise. The real economic-data example and sampling comparison are replaced; no new Pyro software is required. [Detailed scope](L09_Variational_Inference/lecture_scope.md).

### L10 — Monte Carlo and MCMC: invariance, mixing and estimator error

Implement the NumPy MH kernel on a fixed bimodal target. Compare proposal scales and dispersed starts; assess the mean and probability above zero against exact references. Supplied diagnostics flag stuck chains and query-dependent error.

**Skill practised:** Check transition validity separately from finite exploration and quantify uncertainty for a specified Monte Carlo query.

**Authors supply:** target log probability, run-comparison program and diagnostic helpers. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** Helper diagnostics are supplied. Gibbs updates are explained briefly. Hamiltonian Monte Carlo uses derivatives for directed moves but is not fully derived or implemented. [Detailed scope](L10_MCMC/lecture_scope.md).

### L11 — Neural conditional models: heteroskedastic likelihood and regularization

Fit one shallow PyTorch mean/scale network and compare held-out NLL, MSE and conditional intervals with a supplied fixed-scale nonlinear baseline and known data law. Match splits/shapes and estimate baseline noise using training data.

**Skill practised:** Implement and interpret a neural conditional likelihood, preserving standard-deviation/variance distinctions and the limits of fixed-weight predictive intervals.

**Authors supply:** comparison model, training program, prepared fallback and plotting. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** Intervals describe observation noise conditional on fitted weights. They do not include a Bayesian posterior over weights. One CPU fit and prepared fallback still need testing. [Detailed scope](L11_Neural_Prediction/lecture_scope.md).

### L12 — Variational autoencoders: amortized inference and rate–distortion

Complete the compact mobility VAE loss and one bounded joint fit. Use fresh, consistently normalized supplied beta comparisons; evaluate expected-q reconstruction NLL and average prior KL, keeping encoder-mean visualizations separate.

**Skill practised:** Integrate amortized variational inference with a neural likelihood and assess a defined distortion/rate tradeoff without treating rate as mutual information or latent patterns as identified causes.

**Authors supply:** data transformation, small network definitions, training program and prepared comparison fits. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** Uses 19 measurements and four hidden coordinates. Data access, prepared comparisons and CPU runtime remain untested. Patterns are descriptive, not identified causal factors. [Detailed scope](L12_VAE/lecture_scope.md).

## Software and the student hour

Students reuse NumPy, plotting and their probability background. SciPy solver wrappers are supplied rather than becoming another algorithm lesson. PyTorch is introduced in L05 and refreshed in L09/L11/L12 within the same hour. Reference code using Pyro, JAX, Dynamax or TensorFlow Probability does not make those libraries course requirements.

Each task includes orientation, the central calculation, interpretation and debugging. Extra training runs, data preparation and general-purpose solver construction cannot be silently added. If a real student trial overruns, revise the owning scope rather than assume the class will type faster.

## Correctness checks for the authors

These are implementation responsibilities, not choices for the instructor to approve. They retain the exact distinctions found by the specialist reviews, with the problem explained before the technical convention.

### L03

Validate the instructor solution before decomposing the exercise. Use Gaussian noise variance consistently. Update one pixel at a time and retain ties without worsening the score. Supply verification aids and at least one interpretable limitation, such as initialization sensitivity or a local optimum; an exact tiny-model comparison is a possible aid, not an additional required student task. Murphy’s sampling code is a reference, not the selected course algorithm.

### L04

The lecture uses a four-message/eight-received-word three-bit model: it detects a single flip without guaranteed correction. The student notebook uses the **course-constructed five-bit code** with four messages/32 received words (vectorized 4×32 joint table, not hand enumeration). Verify pairwise minimum distance 3, single-flip decoding, marginal/joint normalization, posterior ties and impossible observations. At α=0.2, five-bit optimal message error ≈0.22176 versus 0.36 for the lecture's three-bit code; MI ≈1.12343 bits/message. Five transmitted bits reduce the rate to 2/5. These are untested notebook targets, not a guaranteed one-hour completion.

### L05

Use all three classes and fit scaling using training data only. Compare hand/software derivatives at identical parameters using the same average-over-observations convention. Compute class likelihoods from stable logits rather than taking logs of rounded probabilities.

### L06

For covariance learning, the expected product of missing values includes their conditional covariance. Check that the data contain enough jointly observed entries for the proposed fit and that covariance matrices are positive definite. If numerical repairs/clipping are needed, they cannot simply inherit the proof that exact EM increases observed likelihood.

### L07

Widen the grid and refine its spacing separately. A density at a grid point is not probability mass; integration needs the spacing weight. Check the normalizing constant, tails and predictions. A fine-looking graph alone does not certify the grid reference.

### L08

Keep the row/column transition convention consistent. The symmetric example will not expose an accidental matrix transpose; supply an asymmetric-transition enumeration test too. Scaling prevents underflow, but does not repair true impossible observations. The best whole history need not equal the separate most likely states.

### L09

The Bayesian likelihood is summed over observations and the prior discrepancy is counted once. If using mean likelihood instead, divide that penalty by the number of observations too. Average random draws on a separate dimension. Gradient checks must use identical random draws and the actual sampled-likelihood-minus-analytic-prior-penalty estimator; a different estimator can have a different finite-sample derivative.

### L10

A rejected proposal leaves the current sample in the chain; retain that repeated value. Test the general correction for asymmetric proposals. A chain stuck at one value does not imply reliable zero estimation error. Exploration and error estimates depend on the particular question, such as a mean or the probability of the other peak.

### L11

A standard deviation is the square root of a variance. Keep prediction and target arrays shaped consistently (B×1) to avoid unintended broadcasting. Differentiate through the actual positive-scale transformation, including its floor. Use the same split/transforms for the comparison model, estimate its noise on training data and do not use test data to choose a run/checkpoint. Label intervals as observation noise conditional on fitted weights.

### L12

Sum each observation’s reconstruction terms over its 19 features and its Gaussian penalty terms over four latent coordinates, then average observations. Use fixed decoder variance tau²=0.5. The source separately averages both dimensions: its beta=4 is equivalent to coefficient 19 after converting to these course sums, not course beta=4. Train fresh comparison fits under the course convention. Held-out distortion is expected event-summed Gaussian negative log likelihood over draws from the inferred hidden distribution, with identical variance/constants; weight batch averages by observation count. Decoding the mean hidden coordinate is a separate visualization, not that expectation. Ensure derivatives pass through encoder log variance and both networks. Small penalties or pooled matching do not automatically prove that useful information or meaningful independent factors have been learned.

## References and release checks

The [source record](course_architecture_scope/source_inspection.md) identifies the inspected notebooks and their exact versions. Most require substantial trimming or a different implementation. The [teaching-choice report](course_architecture_scope/questions_and_hesitations.md) explains why controlled examples replace MRI, forecasting and economic-data applications. Mobility data were located, but permission and portable distribution still need checking.

Before release, authors must first build and validate a worked solution, then create a solved teaching notebook and generate the student version from it. Run from a fresh kernel in the repository's locked uv environment and on a fresh hosted Google Colab runtime. Check plots, paths, dependencies and the time needed for students. No future course notebook was executed during this proposal or readability revision.

## Author lookup: worked references

- L03: [https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/04/ising_image_denoise_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/04/ising_image_denoise_demo.ipynb).
- L04: [https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/05/error_correcting_code_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/05/error_correcting_code_demo.ipynb).
- L05: [https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb](https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb).
- L06: [https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/opt/gauss_imputation_em_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/opt/gauss_imputation_em_demo.ipynb).
- L07: [https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/](https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/).
- L08: [https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/casino_hmm.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/casino_hmm.ipynb).
- L09: [https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb).
- L10: [https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb).
- L11: [https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb).
- L12: Instructor Oke PS4 notebook and CSV, exact identifiers in the source record.
