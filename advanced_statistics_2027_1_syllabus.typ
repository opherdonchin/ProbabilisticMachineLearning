#let navy = rgb("#173A5E")
#let blue = rgb("#2F6690")
#let pale-blue = rgb("#EEF4F8")
#let pale-gray = rgb("#F5F6F7")
#let rule = rgb("#D8DEE4")
#let muted = rgb("#59636E")

#set page(
  paper: "a4",
  margin: (x: 23mm, top: 19mm, bottom: 20mm),
  numbering: "1",
)
#set text(font: "Libertinus Serif", size: 10pt, lang: "en", fill: black)
#set par(justify: true, leading: 0.62em, spacing: 0.72em)
#set list(indent: 1.25em, body-indent: 0.55em, spacing: 0.32em)
#set enum(indent: 1.25em, body-indent: 0.55em, spacing: 0.32em)
#set heading(numbering: none)

#show heading.where(level: 1): it => block(
  above: 1.25em,
  below: 0.48em,
  breakable: false,
)[
  #text(font: "Noto Sans", size: 14pt, weight: "bold", fill: navy)[#it.body]
]

#show heading.where(level: 2): it => block(
  above: 0.95em,
  below: 0.26em,
  breakable: false,
)[
  #text(font: "Noto Sans", size: 10.7pt, weight: "bold", fill: navy)[#it.body]
]

#let label(body) = text(font: "Noto Sans", size: 8.7pt, weight: "bold", fill: muted, body)

#let lecture(number, date, title, topics, book2, book1, notebook, skill) = block(
  breakable: false,
  above: 0.32em,
  below: 0.9em,
)[
  #block(breakable: false)[
  #grid(
    columns: (1fr, auto),
    gutter: 8pt,
    align: (left, right),
    [#text(font: "Noto Sans", size: 10.8pt, weight: "bold", fill: navy)[Lecture #number]],
    [#text(font: "Noto Sans", size: 8.8pt, fill: muted)[#date]],
  )
  #text(font: "Noto Sans", size: 10.2pt, weight: "semibold", fill: blue)[#title]
  ]
  #v(3pt)
  #grid(
    columns: (24mm, 1fr),
    column-gutter: 5pt,
    row-gutter: 3pt,
    align: (left, left),
    [#label[Topics]], [#topics],
    [#label[Book 2]], [#book2],
    [#label[Book 1]], [#book1],
    [#label[Notebook]], [#notebook],
    [#label[Skills]], [#skill],
  )
]

#align(center)[
  #text(font: "Noto Sans", size: 21pt, weight: "bold", fill: navy)[Advanced Statistics 2027-1]

  #v(3pt)
  #text(font: "Noto Sans", size: 13pt, weight: "medium", fill: blue)[Probabilistic Machine Learning]

  #v(6pt)
  #text(size: 9.5pt, fill: muted)[Course number: TBD]
]

#v(1.1em)

#grid(
  columns: (30mm, 1fr),
  column-gutter: 7pt,
  row-gutter: 3pt,
  [#label[Lecturer]], [Opher Donchin],
  [#label[Tutorials]], [None],
  [#label[Communication]], [By e-mail],
  [#label[Office hours]], [By appointment],
)

= Syllabus

This course develops modern machine learning through probabilistic models and the computations needed to use them. We describe a task by a joint probability distribution and a query: a posterior, marginal, predictive distribution, integral, expectation, or decision. The structure of a distribution and the required computation motivate exact algorithms, simplifying assumptions, or approximate inference. Students learn how those mathematical choices produce useful predictive, generative and scientific models.

The primary reference is Murphy's _Probabilistic Machine Learning: Advanced Topics_ (*Book 2*); Book 1 is used selectively when it gives needed background or a more pedagogical derivation. The proposed progression starts with ways to describe probability models and measure information. It then studies fitting models, learning from missing data, calculating or approximating posteriors, and estimating quantities by sampling. The final lectures use small neural networks for prediction and for describing observations with hidden coordinates.

Each meeting includes approximately two hours of mathematical lecture and one hour of guided notebook work. Lectures and notebooks have complementary jobs: the lecture establishes mathematics, while the notebook solves a particular application and builds transferable skills.

*Software progression.* Students enter with experience in Python, NumPy, PyMC, Bambi and ArviZ. The proposed plan introduces PyTorch in L05 for automatic differentiation and optimization, uses NumPy/SciPy for numerical checks, and later reuses PyTorch to train neural and generative models. JAX is not required.

= Additional materials

1. Kevin P. Murphy, _Probabilistic Machine Learning: Advanced Topics_, MIT Press, 2023 (Book 2). #link("https://probml.github.io/pml-book/book2.html")[Online edition].
2. Kevin P. Murphy, _Probabilistic Machine Learning: An Introduction_, MIT Press, 2022 (Book 1). #link("https://probml.github.io/pml-book/book1.html")[Online edition].
3. Course notes, exercises, notebook solutions and project materials: #link("https://github.com/opherdonchin/ProbabilisticMachineLearning")[course repository].

The descriptions specify the mathematical work and its computational application. Book references identify selected preparation, not every subsection; focused reading guidance for the teaching choices is in #link("Lectures/course_architecture_scope/questions_and_hesitations.md")[questions and hesitations]. L03 restores the existing instructor-agreed graphical-model scope and notebook boundary. The instructor selected the simpler image algorithm and lighter L04 coding example. Other detailed choices await instructor review. An independent revision review checked the readable wording, preserved mathematics and lighter L04 choice; see #link("Lectures/course_architecture_scope/STATUS.md")[review records]. Future notebooks have not been written or run. They must be tested locally, in Google Colab and within the student hour before release.

= Prerequisites

There are no formal prerequisites. The expected preparation is a mathematical probability course, basic linear algebra, Python programming and a Bayesian-first undergraduate statistics course (such as 367-1-4361 Statistical Computation and Analysis). Students should have encountered basic regression, DAGs, hierarchical Bayesian models, and posterior inference/diagnostics with PyMC, Bambi and ArviZ; the course extends rather than reteaches them. Students without equivalent preparation should consult the instructor.

= Course requirements and grading

The course grade is based on four components:

#table(
  columns: (1fr, 34mm),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rule,
  align: (left, center),
  table.header(
    table.cell(fill: navy)[#text(font: "Noto Sans", weight: "bold", fill: white)[Component]],
    table.cell(fill: navy)[#text(font: "Noto Sans", weight: "bold", fill: white)[Contribution]],
  ),
  table.cell(fill: white)[AI-based tutoring], table.cell(fill: white)[10%],
  table.cell(fill: pale-blue)[Notebook submission], table.cell(fill: pale-blue)[10%],
  table.cell(fill: white)[Project presentation], table.cell(fill: white)[30%],
  table.cell(fill: pale-blue)[Final exam], table.cell(fill: pale-blue)[50%],
)


= Schedule

#text(size: 8pt, weight: "semibold", fill: blue)[The 13-meeting order is agreed. L03’s agreed scope is restored; L04’s lighter example is selected. Other detailed teaching choices remain proposals. L01/L02 material is unchanged. Future notebook code and timing have not been tested.]

#lecture(
  1,
  [21.10.2026],
  [Probabilistic ML and Gaussian systems],
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
  [Gaussian inference to impute missing measurements.],
  [Multivariate NumPy linear algebra and cross-checking posterior computations.],
)

#lecture(
  2,
  [28.10.2026],
  [Exponential families and learning from sufficient statistics],
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
  [Estimate a character-bigram model and generate names.],
  [Probability estimation and numerical scoring with NumPy/SciPy.],
)

#lecture(
  3,
  [04.11.2026],
  [Graphical models: factorization and conditional independence],
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
  [Construct an Ising prior and Gaussian observation likelihood; derive the joint, posterior and single-site conditional. Implement or complete sequential local maximization (ICM) in a NumPy scaffold; compare with a pixelwise baseline and examine initialization or local-optimum limitations.],
  [Build a probabilistic restoration model from local factors, derive its posterior update, and distinguish local maximization from a global optimum or posterior marginal inference.],
)

#lecture(
  4,
  [11.11.2026],
  [Information theory: mutual information, processing and noisy coding],
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
  [Construct the four-message/eight-observation noisy-channel table. Compute mutual information and optimal whole-message Bayes error, including ties and zero-support cases. Compare resource use; reference stronger single-error correction separately.],
  [Calculate information and decision risk from one finite joint distribution without conflating information gain, code rate and guaranteed error correction.],
)

#lecture(
  5,
  [18.11.2026],
  [Generalized linear models, automatic differentiation and SGD],
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
  [Fit the three-class Iris softmax model in PyTorch; compare the manual mean-batch gradient with autograd at identical parameters, run visible SGD updates and evaluate held-out log loss/probabilities. Data preparation and program scaffolding are supplied.],
  [Connect a likelihood derivative with reverse-mode automatic differentiation and a checked stochastic parameter-update/evaluation loop.],
)

#lecture(
  6,
  [25.11.2026],
  [Latent-variable learning and expectation-maximization],
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
  [Assemble expected Gaussian sufficient statistics, including conditional covariance, and perform an E/M update inside a supplied iteration driver. Check observed likelihood and missing-entry reconstruction; no second full mixture fit.],
  [Use conditional uncertainty in sufficient-statistic estimation and distinguish an exact EM improvement guarantee from arbitrary approximate hidden-value updates.],
)

#lecture(
  7,
  [02.12.2026],
  [Bayesian computation: grid reference and Laplace approximation],
  [Posterior queries and parameterization-dependent MAP; derive scalar Laplace curvature and normalizer under positive-curvature conditions. Apply to proper-prior logistic regression, check quadrature domain and resolution, and compare posterior moments and predictive integrals.],
  [
    - 7.1–7.3 What posterior questions require: short introduction
    - Selected 7.4.1–7.4.3 Most likely parameter, grid and Gaussian shortcut
    - Selected 7.5 Checking approximation quality
    - Selected 15.3.5–15.3.6 One-parameter logistic example
  ],
  [],
  [Build a stable quadrature reference for the fixed eight-observation logistic posterior, challenge domain and mesh separately, and assess Laplace error in moments and prediction. Solver/plot helpers are supplied.],
  [Validate the numerical reference as well as the posterior approximation, and separate local curvature matching from global integral/prediction accuracy.],
)

#lecture(
  8,
  [09.12.2026],
  [Exact inference in structured sequence models],
  [Derive scaled HMM forward/backward recursions, evidence and filtered/smoothed marginals; establish dense computational cost and distinguish joint path MAP from marginal modes. Give a compact Kalman-filter application of L01 Gaussian conditioning, without a second full sequence implementation.],
  [
    - 9.2.1–9.2.5 Hidden-state calculations and scaling
    - 9.2.6 Whole history versus separate state decisions
    - Selected 8.1.2 / 8.2.2 Gaussian filtering: short application
  ],
  [],
  [Implement scaled HMM likelihood messages and marginals in NumPy. Check tiny-sequence enumeration and an asymmetric-transition case to expose orientation errors. Simulation, reference and plotting code are supplied.],
  [Use sum-product dynamic programming to obtain exact sequence probabilities and marginals while controlling numerical scaling.],
)

#lecture(
  9,
  [16.12.2026],
  [Variational inference: posterior geometry and pathwise gradients],
  [Reuse L06 ELBO identity; optimize restricted reverse KL and work the correlated-Gaussian diagonal optimum. Derive the total pathwise gradient including direct parameter terms and regularity conditions; apply bounded coordinate-ascent VI and recognize amortization.],
  [
    - 10.1.1–10.1.2 Fitting a restricted distribution
    - 6.3.3 / 6.3.5; 10.2.1.1 Derivatives through Gaussian draws
    - 6.3.4 Another gradient estimator: statement only
    - 10.3.1 Coordinate updates; 10.1.5 learned inference: introduction only
  ],
  [],
  [Fit a diagonal Gaussian to controlled known-noise regression using reparameterized PyTorch gradients. Compare exact posterior and analytic best-diagonal solution; use fixed-noise, matched-estimator gradient checks and query-specific predictive variances.],
  [Separate optimization error from variational-family error, and differentiate a parameter-dependent expectation with correct full-data likelihood/prior scaling.],
)

#lecture(
  10,
  [23.12.2026],
  [Monte Carlo and MCMC: invariance, mixing and estimator error],
  [Derive IID estimator variance, stationarity/detailed balance and the general Metropolis–Hastings ratio, retaining rejected states. Explain Gibbs cancellation briefly and dependent-sample error under its conditions. Distinguish invariant transitions, finite-run mixing and function-specific effective sample size; recognize HMC mechanics only.],
  [
    - 11.2–11.2.2 Averages and sampling error
    - 2.6.4; 12.2.1–12.2.2 Invariant distribution and acceptance rule
    - 12.3.1–12.3.2 Conditional-coordinate sampling: brief derivation
    - Selected 12.6.3 Dependent-sample error; 12.5.3 Hamiltonian mechanics only
  ],
  [],
  [Implement the NumPy MH kernel on a fixed bimodal target. Compare proposal scales and dispersed starts; assess the mean and probability above zero against exact references. Supplied diagnostics flag stuck chains and query-dependent error.],
  [Check transition validity separately from finite exploration and quantify uncertainty for a specified Monte Carlo query.],
)

#lecture(
  11,
  [30.12.2026],
  [Neural conditional models: heteroskedastic likelihood and regularization],
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
  [Fit one shallow PyTorch mean/scale network and compare held-out NLL, MSE and conditional intervals with a supplied fixed-scale nonlinear baseline and known data law. Match splits/shapes and estimate baseline noise using training data.],
  [Implement and interpret a neural conditional likelihood, preserving standard-deviation/variance distinctions and the limits of fixed-weight predictive intervals.],
)

#lecture(
  12,
  [06.01.2027],
  [Variational autoencoders: amortized inference and rate–distortion],
  [Generative model versus amortized posterior; joint encoder/decoder objective with event-summed Gaussian NLL and diagonal KL, then observation averaging. Reuse ELBO/pathwise/neural results. Derive rate as mutual information plus aggregate-posterior mismatch; interpret beta, collapse and nonidentifiability.],
  [
    - Selected 21.1–21.2 Model, inference network and training objective
    - 21.3.1 Changing the penalty weight
    - Selected 5.4.2 Reconstruction/information tradeoff
    - Selected 21.4 When the model ignores hidden coordinates
  ],
  [],
  [Complete the compact mobility VAE loss and one bounded joint fit. Use fresh, consistently normalized supplied beta comparisons; evaluate expected-q reconstruction NLL and average prior KL, keeping encoder-mean visualizations separate.],
  [Integrate amortized variational inference with a neural likelihood and assess a defined distortion/rate tradeoff without treating rate as mutual information or latent patterns as identified causes.],
)

#lecture(
  13,
  [13.01.2027],
  [Project presentations and course synthesis],
  [Student project presentations connecting probabilistic assumptions, computation, prediction, evaluation, uncertainty and scientific interpretation. No additional substantive lecture topic is committed at this stage.],
  [],
  [],
  [Student project presentations.],
  [Scientific presentation and computational reproducibility.],
)

