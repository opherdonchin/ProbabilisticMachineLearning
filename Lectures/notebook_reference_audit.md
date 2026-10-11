# What the proposed notebooks ask students to do

This record separates the central student task from the programs the authors must supply. A 60-minute lab is not a promise that students build a complete inference or training system from scratch. All future course adaptations are still unwritten/unrun; inspecting a reference notebook does not test the proposed student task.

L01's [Gaussian missing-data solution](../InClass/Solutions/lecture1_missing_data.ipynb) is established material and was not changed or re-executed here. L02's agreed [character-bigram reference](https://github.com/karpathy/nn-zero-to-hero/blob/master/lectures/makemore/makemore_part1_bigrams.ipynb) counts neighboring characters, normalizes transition probabilities, scores strings and generates names. It stops before neural modeling and is not recorded as delivered by this project.

## The single main task in each later meeting

### L03 — Graphical models: local calculations in a large model

Calculate a pixel update, check it by listing every configuration of a tiny image, and use a supplied program to repeat updates on a larger image.

**Skill practised:** Turn a probability model into a local calculation and check it against an exact small example.

**Authors supply:** the image and neighbor handling, repeated-update program, plots and exact tiny-image comparison. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** The instructor agreed to this simpler method. It differs from Murphy’s algorithm and does not promise the best possible image or posterior uncertainty. [Detailed scope](L03_Graphical_Models/lecture_scope.md).

### L04 — Information theory: what survives a noisy message?

List the eight possible received three-bit strings. Calculate message probabilities, information and best-guess error; explain ambiguous results. Reference a stronger five-bit code without implementing it.

**Skill practised:** Build and check a small probability table, and distinguish useful information from a guaranteed correct decision.

**Authors supply:** bit arrays, probability-table layout, safe handling of zero probabilities and noise-curve plots. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** The instructor chose the lighter example. One changed bit is detected but cannot always be located or corrected. The stronger code is reference material. [Detailed scope](L04_Information_Theory/lecture_scope.md).

### L05 — Learning models: regression, derivatives and parameter updates

Fit probabilities for all three Iris species in PyTorch. Compare a hand-calculated derivative with the software result, update parameters repeatedly and evaluate new observations.

**Skill practised:** Check automatic derivatives and carry out a simple fit/evaluation loop in PyTorch.

**Authors supply:** data split/scaling, target indexing, plots and a simple training-loop framework. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** First PyTorch use makes this meeting tight. Data preparation and plotting are supplied; the lecture does not teach a large software framework. [Detailed scope](L05_GLM_Optimization/lecture_scope.md).

### L06 — Learning with missing data: expectation-maximization

Complete the expected values and second moments needed to fit a Gaussian to incomplete measurements. Use a supplied update loop and inspect likelihood and reconstruction.

**Skill practised:** Use uncertainty about missing values in a parameter update rather than merely fill blanks with best guesses.

**Authors supply:** incomplete data, masks, matrix checks, repeated-update program and likelihood calculation. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** This replaces the candidate MRI tissue-classification lab. Class-assignment probabilities are explained briefly; a second mixture-model fit is not required. [Detailed scope](L06_EM/lecture_scope.md).

### L07 — Posterior approximation: compare a grid with a Gaussian shortcut

Construct a numerical posterior reference, change its range and spacing, then compare the Gaussian shortcut and predictions. Solver and plotting helpers are supplied.

**Skill practised:** Check a numerical reference and assess the consequences of an approximation.

**Authors supply:** solver wrapper, grid framework and plotting. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** The small example is chosen for checkability. A finite grid is also an approximation, not an automatically exact answer. [Detailed scope](L07_Inference/lecture_scope.md).

### L08 — Sequences: infer hidden states using repeated calculations

Implement the central hidden-state calculations in NumPy. Check a short sequence by listing its histories, including a test where transition directions matter. Simulation and plots are supplied.

**Skill practised:** Reuse partial calculations to avoid listing an exponentially large set of hidden histories.

**Authors supply:** simulation, a short-sequence exact comparison, direction-sensitive transition test and plots. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** The main lab is discrete hidden-state inference. The previously preferred continuous Kalman forecasting lab is not included. [Detailed scope](L08_Structured_Inference/lecture_scope.md).

### L09 — Approximate a posterior by fitting a simpler distribution

Fit an independent-coordinate Gaussian to a regression posterior with a known exact answer. Compare fitting error, the limitations of the chosen distribution and predictive uncertainty.

**Skill practised:** Compute derivatives through random draws and check an approximation against a known answer.

**Authors supply:** exact posterior/best-restricted comparisons, parameter-update program and plots. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** Uses controlled data and known noise. The real economic-data example and sampling comparison are replaced; no new Pyro software is required. [Detailed scope](L09_Variational_Inference/lecture_scope.md).

### L10 — Sampling: correct transitions and unreliable short runs

Complete a NumPy accept/reject sampler. Compare proposal sizes and starting points on a distribution with two separated peaks; check the mean and the probability of a value greater than zero against known values.

**Skill practised:** Check a sampling rule and diagnose inadequate exploration before trusting an estimate.

**Authors supply:** target log probability, run-comparison program and diagnostic helpers. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** Helper diagnostics are supplied. Gibbs updates are explained briefly. Hamiltonian Monte Carlo uses derivatives for directed moves but is not fully derived or implemented. [Detailed scope](L10_MCMC/lecture_scope.md).

### L11 — Neural prediction: learn a mean and a noise level

Fit one small nonlinear Gaussian model and compare it with a supplied fixed-noise model on new observations. Inspect predicted noise and intervals.

**Skill practised:** Build a probability prediction with a neural network and interpret its uncertainty correctly.

**Authors supply:** comparison model, training program, prepared fallback and plotting. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** Intervals describe observation noise conditional on fitted weights. They do not include a Bayesian posterior over weights. One CPU fit and prepared fallback still need testing. [Detailed scope](L11_Neural_Prediction/lecture_scope.md).

### L12 — Variational autoencoders: learn a compact hidden description

Complete a small mobility-data model and one joint training run. Use prepared comparison runs to study reconstruction and hidden descriptions under different penalty strengths.

**Skill practised:** Combine two networks in one probability model and check how its likelihood and penalty are scaled.

**Authors supply:** data transformation, small network definitions, training program and prepared comparison fits. These helpers/checkpoints are requirements for future authoring, not existing validated course files.

**Choice or limitation:** Uses 19 measurements and four hidden coordinates. Data access, prepared comparisons and CPU runtime remain untested. Patterns are descriptive, not identified causal factors. [Detailed scope](L12_VAE/lecture_scope.md).

## Software and the student hour

Students reuse NumPy, plotting and their probability background. SciPy solver wrappers are supplied rather than becoming another algorithm lesson. PyTorch is introduced in L05 and refreshed in L09/L11/L12 within the same hour. Reference code using Pyro, JAX, Dynamax or TensorFlow Probability does not make those libraries course requirements.

Each task includes orientation, the central calculation, interpretation and debugging. Extra training runs, data preparation and general-purpose solver construction cannot be silently added. If a real student trial overruns, revise the owning scope rather than assume the class will type faster.

## Correctness checks for the authors

These are implementation responsibilities, not choices for the instructor to approve. They retain the exact distinctions found by the specialist reviews, with the problem explained before the technical convention.

### L03

Use the stated Gaussian noise variance consistently. Update one pixel at a time, retain ties without worsening the score and show the tiny case where no single-pixel improvement remains although a better whole image exists. Murphy’s sampling code is a reference, not the selected course algorithm.

### L04

The required table has four messages and eight received strings. One flipped bit violates parity but can leave several equally plausible originals. Do not promise guaranteed correction. Check table sums, zeros and ties, and state that three transmitted bits cost more than two uncoded bits. The five-bit result is a stronger reference, not another required implementation.

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
