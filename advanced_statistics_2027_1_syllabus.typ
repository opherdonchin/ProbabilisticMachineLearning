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
  breakable: true,
  above: 0.32em,
  below: 0.9em,
)[
  #grid(
    columns: (1fr, auto),
    gutter: 8pt,
    align: (left, right),
    [#text(font: "Noto Sans", size: 10.8pt, weight: "bold", fill: navy)[Lecture #number]],
    [#text(font: "Noto Sans", size: 8.8pt, fill: muted)[#date]],
  )
  #text(font: "Noto Sans", size: 10.2pt, weight: "semibold", fill: blue)[#title]
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

The primary reference is Murphy's _Probabilistic Machine Learning: Advanced Topics_ (*Book 2*); Book 1 is used selectively when it gives needed background or a more pedagogical derivation. The reviewed proposal progression moves from exponential families and graphical models through information theory, differentiable optimization, EM, structured inference, VI and MCMC to neural networks and VAEs. L05 develops the unified GLM family; L11 reuses it through nonlinear conditional prediction.

Each meeting includes approximately two hours of mathematical lecture and one hour of guided notebook work. Lectures and notebooks have complementary jobs: the lecture establishes mathematics, while the notebook solves a particular application and builds transferable skills.

*Software progression.* Students enter with experience in Python, NumPy, PyMC, Bambi and ArviZ. The proposed plan introduces PyTorch in L05 for automatic differentiation and optimization, uses NumPy/SciPy for numerical checks, and later reuses PyTorch to train neural and generative models. JAX is not required.

= Additional materials

1. Kevin P. Murphy, _Probabilistic Machine Learning: Advanced Topics_, MIT Press, 2023 (Book 2). #link("https://probml.github.io/pml-book/book2.html")[Online edition].
2. Kevin P. Murphy, _Probabilistic Machine Learning: An Introduction_, MIT Press, 2022 (Book 1). #link("https://probml.github.io/pml-book/book1.html")[Online edition].
3. Course notes, exercises, notebook solutions and project materials: #link("https://github.com/opherdonchin/ProbabilisticMachineLearning")[course repository].

Section references below name selected preparation and support, not every subsection. L03–L12 scopes have separate independent feasibility reviews and are agent-approved / instructor-pending. This is a branch proposal, not a student release. Notebook adaptations are unimplemented/unrun; clean local uv and hosted Colab validation plus student timing are required before publication. See #link("Lectures/course_architecture_scope/STATUS.md")[scope and review registry].

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

#text(size: 8pt, weight: "semibold", fill: blue)[Architecture accepted 2026-10-11; L03–L12 agent-reviewed proposal, instructor pending. L01 delivered provenance and L02 agreed contracts are protected. All future labs remain runtime-unvalidated.]

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
  [Graphical models],
  [DAG entailment recall; positive MRF potentials and global normalization; a tiny Ising partition function; separator/local CI; posterior local conditionals and coordinate MAP limitations; factor-graph incidence.],
  [
    - 4.2.1 / 4.2.4 DAG recall (selected)
    - 4.3.1–4.3.2.1 MRF / Ising normalization
    - 4.3.6.1 CI; selected 4.3.8 restoration model
    - 4.6.1.1 Factor graphs
  ],
  [
    - 3.6.1–3.6.2 Directed-graph recall only
  ],
  [Check a local Ising conditional against enumeration, then restore a noisy course image with a supplied coordinate-update driver. Label the result a coordinate-stable candidate, not exact MAP or posterior marginals.],
  [NumPy factor-to-conditional computation and exact tiny-model checks.],
)

#lecture(
  4,
  [11.11.2026],
  [Information theory: dependence and communication],
  [Finite entropy, cross-entropy and KL; mutual-information identity; DPI proof sketch and bounded sufficiency recall; stated source-code length bounds; one five-bit noisy code with single-error correction, posterior ties and channel-use accounting.],
  [
    - 5.1.3 / 5.1.6; 5.2.1 / 5.2.4 Finite quantities (selected)
    - 5.3.1–5.3.4 MI / DPI / bounded sufficiency
    - 5.4.1 Source-length bounds (state)
    - 5.5 Channel decoding (course adaptation)
  ],
  [
    - Selected 6.1 / 6.2.1–6.2.2 / 6.3 Finite MI and DPI support
  ],
  [Enumerate a four-message, five-bit channel; compute MI and exact Bayes block error; expose ties and compare noise curves with channel-use cost.],
  [Normalized finite-probability tables, information and decision computations in NumPy.],
)

#lecture(
  5,
  [18.11.2026],
  [Learning probabilistic models: GLMs and optimization],
  [Conditional exponential-family GLMs: Gaussian, Bernoulli and Poisson supports/links; one dispersion-correct canonical NLL gradient; a distinct vector softmax application; one complete reverse-mode graph and minibatch SGD. First PyTorch practice.],
  [
    - 15.1 / 15.1.1 / 15.1.3 GLM family and canonical gradient
    - 15.1.2 Noncanonical-link contrast only
    - 15.3.2 Multinomial softmax
    - 6.2 (selected); 6.3.1–6.3.2 Reverse AD and finite-sum SGD
  ],
  [
    - Selected 7.8.2 / 7.8.5 Matrix derivatives
    - Selected 8.2 / 8.4.1 / 8.4.3 Gradient and minibatch support
  ],
  [Fit all three Iris species with an affine softmax model; check manual versus autograd batch gradients, run visible SGD and evaluate held-out probabilities/log loss.],
  [PyTorch tensors, checked gradients and one optimization/evaluation loop.],
)

#lecture(
  6,
  [25.11.2026],
  [Latent-variable learning and EM],
  [Observed versus complete likelihood; generic ELBO/KL identity, tightness and exact-EM monotonicity; Gaussian conditional first and second moments; learning unknown mean/covariance; ignorability/SPD assumptions. Mixture responsibilities as a short bridge.],
  [
    - 6.5.1 / 6.5.3 Bound optimization and EM (selected)
    - 6.5.4 Gaussian missing-data EM
    - 3.11 Ignorability (bounded statement)
    - 28.2.1 Mixture responsibility recognition only
  ],
  [
    - 3.5 / selected 8.7 EM and mixture exposition; no second full GMM fit
  ],
  [Complete expected Gaussian sufficient statistics, aggregate an E/M update and use a supplied driver to inspect observed likelihood and missing-entry reconstruction.],
  [Turn posterior uncertainty into expected statistics and check an alternating objective.],
)

#lecture(
  7,
  [02.12.2026],
  [Inference as computation: grid and Laplace],
  [Queries and posterior summaries; parameterization-sensitive MAP; scalar Taylor/Laplace normalizer and positive curvature; proper-prior logistic application; grid domain/resolution checks and predictive comparison. Later algorithms recognized, not derived.],
  [
    - 7.1–7.3 Query framing (compact)
    - 7.4.1–7.4.3 MAP / grid / scalar Laplace (selected)
    - 7.5 Approximation checks (selected)
    - 15.3.5–15.3.6 Scalar logistic application only
  ],
  [],
  [Build a domain/resolution-challenged grid reference for a fixed eight-observation logistic posterior; compare Laplace, posterior moments and prediction.],
  [Stable numerical integration, local curvature and approximation-error checks with NumPy/SciPy.],
)

#lecture(
  8,
  [09.12.2026],
  [Exact inference in structured sequence models],
  [HMM factorization; derived forward/backward recursions, scaling and evidence; filtered/smoothed marginals; dense complexity and path-MAP versus marginal-mode distinction. Kalman filtering is a compact L01 application, not a second full algorithm/lab.],
  [
    - 9.2.1–9.2.5 HMM inference / scaling / complexity
    - 9.2.6 Path-versus-marginal decision distinction only
    - 8.1.2 / 8.2.2 Kalman application (selected)
  ],
  [],
  [Implement scaled HMM recursions and marginals with supplied simulation/plots; compare tiny enumeration and include a supplied asymmetric-transition assertion.],
  [Dynamic programming, probability scaling and exact sequence-inference tests in NumPy.],
)

#lecture(
  9,
  [16.12.2026],
  [Variational inference: restricted posteriors and stochastic gradients],
  [Restricted-q optimization and reverse-KL Gaussian geometry; one total pathwise-gradient derivation with regularity/direct terms; bounded CAVI same-target application; amortization recognition. Generic bound reused from L06.],
  [
    - 10.1.1–10.1.2 Restricted objective / family
    - 6.3.3 / 6.3.5; 10.2.1.1 Gaussian pathwise gradient
    - 6.3.4 Score-function contrast (state)
    - 10.3.1 CAVI application; 10.1.5 amortization (recognize)
  ],
  [],
  [Optimize one diagonal Gaussian for controlled known-noise regression; compare exact and analytic best-diagonal posteriors and query-specific predictive variances.],
  [Differentiate through a latent sample transform and separate optimizer error from family error in PyTorch.],
)

#lecture(
  10,
  [23.12.2026],
  [Monte Carlo and MCMC],
  [IID estimator variance; stationarity and detailed balance; full Hastings ratio and rejected states; bounded Gibbs cancellation; stationary dependent error and query-specific mixing/ESS limits. HMC mechanics recognized only.],
  [
    - 11.2–11.2.2 MC integration / variance
    - 2.6.4; 12.2.1–12.2.2 Stationarity / MH
    - 12.3.1–12.3.2 Gibbs (bounded)
    - 12.6.3 Dependent error (selected); 12.5.3 HMC recognition
  ],
  [],
  [Complete a NumPy MH kernel and compare proposal scales/dispersed starts on a fixed multimodal mixture; assess mean and mode-mass queries against exact references.],
  [Sampler transition correctness, finite exploration and function-specific numerical uncertainty.],
)

#lecture(
  11,
  [30.12.2026],
  [Neural networks as probabilistic conditional models],
  [MLP nonlinearity and mean/positive-SD heads; heteroskedastic Gaussian NLL and loss derivatives; shared AD/SGD reuse; conditional noise versus posterior weight uncertainty; correctly scaled Gaussian-prior/L2 connection.],
  [
    - 16.2.1–16.2.2 / 16.3.1 MLPs (selected)
    - 15.2.2.1 Gaussian-prior connection only
    - 14.2.1 Log-score application only
  ],
  [
    - 13.2.4.4 Heteroskedastic example
    - 13.5.2 Weight decay; 13.5.1 early-stopping recognition
  ],
  [Fit one shallow heteroskedastic PyTorch model and compare held-out NLL/MSE and conditional intervals with a supplied nonlinear fixed-scale baseline and known generating law.],
  [Neural probability heads, matching batch shapes and honest conditional-uncertainty interpretation.],
)

#lecture(
  12,
  [06.01.2027],
  [Variational autoencoders: neural latent-variable models],
  [Generative model and amortized posterior roles; joint encoder/decoder objective; prior results applied to correctly normalized reconstruction/KL and gradients; beta tradeoff; rate equals MI plus aggregate-posterior KL; collapse and nonidentifiability limits.],
  [
    - 21.1–21.2 VAE model / amortization / objective (selected)
    - 21.3.1 Beta-VAE
    - 5.4.2 Rate–distortion / rate decomposition (selected)
    - 21.4 Collapse diagnostics (selected)
  ],
  [],
  [Complete a compact mobility VAE objective and bounded joint update run; compare freshly normalized beta summaries and descriptive latent patterns using supplied fits when needed.],
  [Encoder/likelihood-decoder integration, event-axis loss scaling and information-rate diagnostics in PyTorch.],
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

