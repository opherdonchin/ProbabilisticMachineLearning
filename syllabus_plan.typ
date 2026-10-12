#set page(
  paper: "a4",
  flipped: true,
  margin: 10mm,
)

#set text(
  font: "Libertinus Serif",
  size: 8pt,
)

#set par(
  leading: 0.55em,
  spacing: 0.6em,
)

#let navy = rgb("#173A5E")
#let rule = rgb("#D8DEE4")
#let muted = rgb("#59636E")

#show heading.where(level: 1): it => block(
  above: 0.7em,
  below: 0.4em,
)[
  #text(size: 15pt, weight: "bold", fill: navy)[#it.body]
]

#let hdr(body) = table.cell(fill: navy, inset: 5pt)[
  #text(weight: "bold", fill: white)[#body]
]

#let note(body) = text(size: 7.3pt, fill: muted)[#body]

= Syllabus plan

This plan specifies the mathematical sequence and notebook applications. It assumes probability and Bayesian background, while explaining later methods and providing selected reading references. The instructor agreed to the 13-meeting order, the existing L03 scope and its simpler notebook image algorithm and the lighter coding example in L04. Other detailed choices remain proposals. Each row identifies the mathematical objects, treatment and student task. The linked teaching-choice report supplies decision-relevant equations and focused instructor readings. See #link("Lectures/course_architecture_scope/questions_and_hesitations.md")[teaching choices] and #link("Lectures/course_architecture_scope/architecture_audit.md")[course explanation].
The course is organized around four recurring ideas:

- a machine-learning task can be expressed through a joint probability model and a query;
- the structure of the joint distribution and the required integral / expectation / decision determine the computational problem;
- practical methods trade simplifying structural assumptions, approximation, and brute-force computation;
- students should leave with a useful collection of modern tools, including both classical probabilistic methods and network-based models.

*Book 2 is the primary curricular spine.* Book 1 is supplementary rather than co-equal: a Book 1 section is retained only when it supplies necessary background, offers a more pedagogical development, gives a useful worked example, or provides an alternative treatment that may materially improve the lecture.

#note[*Status:* L01 material is recorded as delivered; L02 is agreed. L03 restores the instructor-agreed scope from its authoring branch. L04–L12 remain proposals with review evidence; L04’s lighter example is selected. Later choices still await review. Future notebook implementations and student timings have not been tested.]

#v(0.5em)

#table(
  columns: (8mm, 31mm, 55mm, 46mm, 42mm, 71mm),
  inset: 4pt,
  stroke: 0.45pt + rule,
  align: (left, left, left, left, left, left),

  table.header(
    hdr[No.],
    hdr[Lecture],
    hdr[Topics covered],
    hdr[Book 2 — primary],
    hdr[Book 1 — supplemental],
    hdr[Notebook problem, worked reference and skill],
  ),

  [1],
  [*Probabilistic ML and Gaussian systems* \
  #note[Delivered]],
  [Machine-learning task framing; probabilistic models; Bayes review; covariance and correlation; multivariate Gaussians; conditioning; missing-data inference; linear Gaussian systems.],
  [
    - 2.1.5–2.1.6 Conditional probability; Bayes
    - 2.2.1.1 Bernoulli and binomial
    - 2.2.4.1 Beta distribution
    - 2.3.1.1 Gaussian joint distribution
    - 2.3.1.3–2.3.1.5 Gaussian conditionals; information form
    - 2.3.2.1–2.3.2.2 Linear-Gaussian systems
    - 3.2.1 Coin-flipping Bayes
    - 3.4–3.4.1 Conjugate priors; binomial
  ],
  [
    - 1.1–1.5 ML tasks and datasets
    - 2.3 Bayes’ rule
    - 2.4.1 Bernoulli; binomial
    - 2.7.4 Beta distribution
    - 3.1.1–3.1.3 Covariance; correlation
    - 3.2.1–3.3.4 Multivariate and linear Gaussians
    - 4.3–4.3.1 Empirical risk
    - 4.6.1–4.6.2 Beta-binomial Bayes
  ],
  [*Gaussian measurement imputation (already delivered).* Condition a multivariate Gaussian on observed measurements, infer missing values and their uncertainty. Reference: #link("https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/lecture-3-prep/InClass/Solutions/lecture1_missing_data.ipynb")[Existing L1 solved notebook].],

  [2],
  [*Exponential families and learning from sufficient statistics* \
  #note[Agreed scope]],
  [Exponential-family representation; Gaussian canonical form; derivatives of the log-partition function; natural and mean parameters; MLE as moment matching; maximum entropy; Gamma fit; categorical counts; Markov-chain learning.],
  [
    - 2.2.1.2 Categorical distribution
    - 2.4.1–2.4.2 Exponential-family form; examples
    - 2.4.3–2.4.4 Log partition; moments
    - 2.4.5 MLE; moment matching
    - 2.4.7 Maximum entropy
    - 2.6.1–2.6.3 Markov chains; language models
  ],
  [],
  [*Baby-name character bigram model.* Count character transitions in the names corpus, normalize the transition matrix, compute sequence NLL and generate new names. Reference: #link("https://github.com/karpathy/nn-zero-to-hero/blob/master/lectures/makemore/makemore_part1_bigrams.ipynb")[Karpathy’s solved bigram notebook].],

  [3],
  [*Graphical models: factorization and conditional independence* \
  #note[Agreed scope restored]],
  [Derive DAG factorization from the probability chain rule and independence assumptions; work the student network and parameter economy. Develop d-separation and directed Markov blankets. Define undirected potentials and global normalization, compare separation and independence expressivity, and interpret the binary Ising model. Image posterior and algorithm derivations belong to the notebook.],
  [
    - 4.2.1–4.2.2 DAG factorization; student network
    - 4.2.4 / selected 4.2.8 Independence; plates
    - 4.3.1–4.3.2.1 / 4.3.6.1 Undirected models; Ising; separation
    - 4.5.1 Directed/undirected independence comparison
    - 4.3.8 Image restoration: notebook
  ],
  [
    - Optional 3.6.1–3.6.2 Graphical-model orientation
  ],
  [Construct an Ising prior and Gaussian observation likelihood; derive the joint, posterior and single-site conditional. Implement or complete sequential local maximization (ICM) in a NumPy scaffold; compare with a pixelwise baseline and examine initialization or local-optimum limitations. *Skill:* Build a probabilistic restoration model from local factors, derive its posterior update, and distinguish local maximization from a global optimum or posterior marginal inference. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/04/ising_image_denoise_demo.ipynb")[Inspected source]. *Limit:* The instructor agreed to this simpler method. It differs from Murphy’s algorithm and does not promise the best possible image or posterior uncertainty. All course adaptations remain unrun.],

  [4],
  [*Information theory: mutual information, processing and noisy coding* \
  #note[Proposed teaching scope]],
  [Finite entropy, cross-entropy and KL divergence; derive mutual information and sketch the data-processing inequality with its conditional-independence premise. State source-length bounds. Work three-bit parity detection and posterior decoding, distinguishing information, Bayes message risk and a coding guarantee.],
  [
    - 5.1.3 / 5.1.6; 5.2.1 / 5.2.4 Information and uncertainty
    - 5.3.1–5.3.4 Shared information and processing
    - 5.4.1 Code-length bounds: statement only
    - 5.5 Noisy-channel example: three-bit parity model
  ],
  [
    - Selected 6.1 / 6.2.1–6.2.2 / 6.3 Uncertainty and shared information
  ],
  [Extend the lecture's three-bit parity detector to a five-bit correcting code for the same two-bit message. Check minimum Hamming distance three and decode any single-bit flip; use supplied 4×32 channel enumeration to compute mutual information and optimal message error and compare against the three-bit and uncoded benchmarks, accounting for rate. *Skill:* Calculate information and decision risk from one finite joint distribution without conflating information gain, code rate and guaranteed error correction. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/05/error_correcting_code_demo.ipynb")[Inspected source]. *Limit:* The lecture uses the lighter detection-only code; the notebook develops the stronger correcting code. Guarantee applies only to at most one flipped bit; all notebook adaptations and one-hour timing remain untested. All course adaptations remain unrun.],

  [5],
  [*Generalized linear models, automatic differentiation and SGD* \
  #note[Proposed teaching scope]],
  [Conditional exponential-family models: Gaussian, Bernoulli and Poisson supports, mean/link and dispersion. Derive one canonical NLL gradient, work the distinct vector softmax gradient, trace reverse-mode differentiation through a shared computational graph, and explain finite-sum minibatch stochastic gradient descent.],
  [
    - 15.1 / 15.1.1 / 15.1.3 Common model structure and derivative
    - 15.1.2 Brief alternative-link comparison
    - 15.3.2 Three-class probabilities
    - Selected 6.2; 6.3.1–6.3.2 Automatic differentiation and batch updates
  ],
  [
    - Selected 7.8.2 / 7.8.5 Matrix derivatives
    - Selected 8.2 / 8.4.1 / 8.4.3 Gradient and batch-update support
  ],
  [Fit the three-class Iris softmax model in PyTorch; compare the manual mean-batch gradient with autograd at identical parameters, run visible SGD updates and evaluate held-out log loss/probabilities. Data preparation and program scaffolding are supplied. *Skill:* Connect a likelihood derivative with reverse-mode automatic differentiation and a checked stochastic parameter-update/evaluation loop. #link("https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb")[Inspected source]. *Limit:* First PyTorch use makes this meeting tight. Data preparation and plotting are supplied; the lecture does not teach a large software framework. All course adaptations remain unrun.],

  [6],
  [*Latent-variable learning and expectation-maximization* \
  #note[Proposed teaching scope]],
  [Derive the ELBO/KL identity, exact E-step tightness and EM likelihood monotonicity under its assumptions. Apply Gaussian conditional first and second moments to unknown mean/covariance with missing data. State ignorability and positive-definiteness conditions; illustrate mixture responsibilities briefly.],
  [
    - Selected 6.5.1 / 6.5.3 Probability bound and EM
    - 6.5.4 Gaussian missing-data updates
    - 3.11 When the missing-data mechanism can be ignored
    - 28.2.1 Group-assignment probabilities: brief example
  ],
  [
    - Selected 3.5 / 8.7 Grouped observations and EM explanation
  ],
  [Assemble expected Gaussian sufficient statistics, including conditional covariance, and perform an E/M update inside a supplied iteration driver. Check observed likelihood and missing-entry reconstruction; no second full mixture fit. *Skill:* Use conditional uncertainty in sufficient-statistic estimation and distinguish an exact EM improvement guarantee from arbitrary approximate hidden-value updates. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/opt/gauss_imputation_em_demo.ipynb")[Inspected source]. *Limit:* This replaces the candidate MRI tissue-classification lab. Class-assignment probabilities are explained briefly; a second mixture-model fit is not required. All course adaptations remain unrun.],

  [7],
  [*Bayesian computation: grid reference and Laplace approximation* \
  #note[Proposed teaching scope]],
  [Posterior queries and parameterization-dependent MAP; derive scalar Laplace curvature and normalizer under positive-curvature conditions. Apply to proper-prior logistic regression, check quadrature domain and resolution, and compare posterior moments and predictive integrals.],
  [
    - 7.1–7.3 What posterior questions require: short introduction
    - Selected 7.4.1–7.4.3 Most likely parameter, grid and Gaussian shortcut
    - Selected 7.5 Checking approximation quality
    - Selected 15.3.5–15.3.6 One-parameter logistic example
  ],
  [],
  [Build a stable quadrature reference for the fixed eight-observation logistic posterior, challenge domain and mesh separately, and assess Laplace error in moments and prediction. Solver/plot helpers are supplied. *Skill:* Validate the numerical reference as well as the posterior approximation, and separate local curvature matching from global integral/prediction accuracy. #link("https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/")[Inspected source]. *Limit:* The small example is chosen for checkability. A finite grid is also an approximation, not an automatically exact answer. All course adaptations remain unrun.],

  [8],
  [*Exact inference in structured sequence models* \
  #note[Proposed teaching scope]],
  [Derive scaled HMM forward/backward recursions, evidence and filtered/smoothed marginals; establish dense computational cost and distinguish joint path MAP from marginal modes. Give a compact Kalman-filter application of L01 Gaussian conditioning, without a second full sequence implementation.],
  [
    - 9.2.1–9.2.5 Hidden-state calculations and scaling
    - 9.2.6 Whole history versus separate state decisions
    - Selected 8.1.2 / 8.2.2 Gaussian filtering: short application
  ],
  [],
  [Implement scaled HMM likelihood messages and marginals in NumPy. Check tiny-sequence enumeration and an asymmetric-transition case to expose orientation errors. Simulation, reference and plotting code are supplied. *Skill:* Use sum-product dynamic programming to obtain exact sequence probabilities and marginals while controlling numerical scaling. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/casino_hmm.ipynb")[Inspected source]. *Limit:* The main lab is discrete hidden-state inference. The previously preferred continuous Kalman forecasting lab is not included. All course adaptations remain unrun.],

  [9],
  [*Variational inference: posterior geometry and pathwise gradients* \
  #note[Proposed teaching scope]],
  [Reuse L06 ELBO identity; optimize restricted reverse KL and work the correlated-Gaussian diagonal optimum. Derive the total pathwise gradient including direct parameter terms and regularity conditions; apply bounded coordinate-ascent VI and recognize amortization.],
  [
    - 10.1.1–10.1.2 Fitting a restricted distribution
    - 6.3.3 / 6.3.5; 10.2.1.1 Derivatives through Gaussian draws
    - 6.3.4 Another gradient estimator: statement only
    - 10.3.1 Coordinate updates; 10.1.5 learned inference: introduction only
  ],
  [],
  [Fit a diagonal Gaussian to controlled known-noise regression using reparameterized PyTorch gradients. Compare exact posterior and analytic best-diagonal solution; use fixed-noise, matched-estimator gradient checks and query-specific predictive variances. *Skill:* Separate optimization error from variational-family error, and differentiate a parameter-dependent expectation with correct full-data likelihood/prior scaling. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb")[Inspected source]. *Limit:* Uses controlled data and known noise. The real economic-data example and sampling comparison are replaced; no new Pyro software is required. All course adaptations remain unrun.],

  [10],
  [*Monte Carlo and MCMC: invariance, mixing and estimator error* \
  #note[Proposed teaching scope]],
  [Derive IID estimator variance, stationarity/detailed balance and the general Metropolis–Hastings ratio, retaining rejected states. Explain Gibbs cancellation briefly and dependent-sample error under its conditions. Distinguish invariant transitions, finite-run mixing and function-specific effective sample size; recognize HMC mechanics only.],
  [
    - 11.2–11.2.2 Averages and sampling error
    - 2.6.4; 12.2.1–12.2.2 Invariant distribution and acceptance rule
    - 12.3.1–12.3.2 Conditional-coordinate sampling: brief derivation
    - Selected 12.6.3 Dependent-sample error; 12.5.3 Hamiltonian mechanics only
  ],
  [],
  [Implement the NumPy MH kernel on a fixed bimodal target. Compare proposal scales and dispersed starts; assess the mean and probability above zero against exact references. Supplied diagnostics flag stuck chains and query-dependent error. *Skill:* Check transition validity separately from finite exploration and quantify uncertainty for a specified Monte Carlo query. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb")[Inspected source]. *Limit:* Helper diagnostics are supplied. Gibbs updates are explained briefly. Hamiltonian Monte Carlo uses derivatives for directed moves but is not fully derived or implemented. All course adaptations remain unrun.],

  [11],
  [*Neural conditional models: heteroskedastic likelihood and regularization* \
  #note[Proposed teaching scope]],
  [Nonlinear feedforward mean/positive-scale model; derive heteroskedastic Gaussian NLL and output derivatives, reusing AD/SGD. Distinguish conditional observation noise from posterior weight uncertainty via total variance. Work the Gaussian-prior/L2 coefficient under mean-loss normalization.],
  [
    - Selected 16.2.1–16.2.2 / 16.3.1 Small feedforward networks
    - 15.2.2.1 Gaussian prior and weight shrinkage
    - 14.2.1 Evaluating predicted probabilities
  ],
  [
    - 13.2.4.4 Noise that depends on input
    - 13.5.2 Weight shrinkage; 13.5.1 stopping training: brief mention
  ],
  [Fit one shallow PyTorch mean/scale network and compare held-out NLL, MSE and conditional intervals with a supplied fixed-scale nonlinear baseline and known data law. Match splits/shapes and estimate baseline noise using training data. *Skill:* Implement and interpret a neural conditional likelihood, preserving standard-deviation/variance distinctions and the limits of fixed-weight predictive intervals. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb")[Inspected source]. *Limit:* Intervals describe observation noise conditional on fitted weights. They do not include a Bayesian posterior over weights. One CPU fit and prepared fallback still need testing. All course adaptations remain unrun.],

  [12],
  [*Variational autoencoders: amortized inference and rate–distortion* \
  #note[Proposed teaching scope]],
  [Generative model versus amortized posterior; joint encoder/decoder objective with event-summed Gaussian NLL and diagonal KL, then observation averaging. Reuse ELBO/pathwise/neural results. Derive rate as mutual information plus aggregate-posterior mismatch; interpret beta, collapse and nonidentifiability.],
  [
    - Selected 21.1–21.2 Model, inference network and training objective
    - 21.3.1 Changing the penalty weight
    - Selected 5.4.2 Reconstruction/information tradeoff
    - Selected 21.4 When the model ignores hidden coordinates
  ],
  [],
  [Complete the compact mobility VAE loss and one bounded joint fit. Use fresh, consistently normalized supplied beta comparisons; evaluate expected-q reconstruction NLL and average prior KL, keeping encoder-mean visualizations separate. *Skill:* Integrate amortized variational inference with a neural likelihood and assess a defined distortion/rate tradeoff without treating rate as mutual information or latent patterns as identified causes. #link("Lectures/course_architecture_scope/source_inspection.md")[Instructor mobility source]. *Limit:* Uses 19 measurements and four hidden coordinates. Data access, prepared comparisons and CPU runtime remain untested. Patterns are descriptive, not identified causal factors. All course adaptations remain unrun.],

  [13],
  [*Project presentations and course synthesis*],
  [Student project presentations connecting probabilistic assumptions, computation, prediction, evaluation, uncertainty and scientific interpretation. No additional substantive lecture topic is committed at this stage.],
  [],
  [],
  [No notebook — project presentations and synthesis.],
)

#pagebreak()

= What the course leaves out

The course has room for selected methods, not every book chapter. These are practical losses, not topics secretly assigned to the final project meeting. The #link("Lectures/course_architecture_scope/architecture_audit.md")[course explanation] gives the full source map.

#table(
  columns: (65mm, 51mm, 1fr), inset: 4pt, stroke: 0.45pt + rule,
  table.header(hdr[Other possible topic], hdr[Choice in this plan], hdr[What we give up]),
  [More advanced optimization], [Basic derivatives and small-batch updates are sufficient here], [No separate study of curved-geometry updates, expensive black-box search, transport or subset selection.],
  [Particle methods for changing hidden states], [Exact sequence calculations in L08 and sampling theory in L10], [No method for tracking a complex changing state with a cloud of weighted samples (Book 2 Ch. 13).],
  [MRI classification and continuous forecasting], [Missing-data fitting and discrete hidden-state lab selected], [Less biomedical and forecasting practice. Either application can replace its corresponding lab after review.],
  [More complex regression and prediction checks], [Common models in L05 and one neural probability model in L11], [No full sparse/hierarchical regression, calibration or guaranteed prediction-interval course.],
  [Larger inference toolkits], [One checked method per main lab], [No general-purpose graph solver, broad variational-family catalogue or full Hamiltonian sampler derivation.],
  [Bayesian neural networks and Gaussian processes], [Small fitted networks only], [No separate treatment of uncertainty about network weights or Gaussian-process prediction.],
  [Other generative models], [A variational autoencoder in L12], [No flow, diffusion or adversarial model teaching. These are different ways to learn data distributions and need their own time.],
)
