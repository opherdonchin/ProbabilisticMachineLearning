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

This course builds *working competence with probabilistic machine-learning methods*. Students learn to recognize a meaningful learning problem, formulate it probabilistically, select and use an appropriate computational approach, evaluate its predictions or inferences, and explain what the method does and does not justify. Mathematical derivations provide the shared reasoning that makes a repertoire of algorithms transferable rather than a catalogue of recipes. The goal is not abstract coherence alone, and not operating algorithms without understanding their assumptions. The full rationale and evolving practice plan are in #link("course_architecture.pdf")[the course architecture] (#link("course_architecture.typ")[source]).

The primary reference is Murphy's _Probabilistic Machine Learning: Advanced Topics_ (*Book 2*); Book 1 supplies selected background and scaffolding. The proposed progression builds a toolkit for probabilistic modeling and evaluating performance; parameter fitting from complete and incomplete data; posterior approximation and exact structured inference; two lectures on learned neural representations for images and sequences; and latent generation. L07 and L09 compare inference on the accepted Challenger thermal-distress posterior. L07 retains a bounded supplied-sampler encounter; the dedicated MCMC lecture and its algorithm derivations are deliberately omitted.

Each meeting includes approximately two hours of mathematical lecture and one hour of guided notebook work. Lectures develop the ideas, derivations, use conditions and comparisons. Notebooks supply *bounded practical use* on recognizable datasets: run or complete a method, inspect outputs, compare an informative baseline, and diagnose task-relevant errors. Small exact examples remain valuable as diagnostics but need not substitute for substantive machine-learning experience. Revised future notebook details remain subject to feasibility review.

*Software progression.* Students enter with experience in Python, NumPy, PyMC, Bambi and ArviZ. The proposal uses NumPy/SciPy for probability, numerical checks and introductory inference, and introduces PyTorch in L05 for automatic differentiation and subsequent neural or variational fitting. JAX is not required.

= Additional materials

1. Kevin P. Murphy, _Probabilistic Machine Learning: Advanced Topics_, MIT Press, 2023 (Book 2). #link("https://probml.github.io/pml-book/book2.html")[Online edition].
2. Kevin P. Murphy, _Probabilistic Machine Learning: An Introduction_, MIT Press, 2022 (Book 1). #link("https://probml.github.io/pml-book/book1.html")[Online edition].
3. Course notes, exercises, notebook solutions and project materials: #link("https://github.com/opherdonchin/ProbabilisticMachineLearning")[course repository].

The schedule is a *revisable proposal* for lectures and notebooks. L01 has prepared materials but has not yet been taught. Earlier L02/L03 decisions and the current L04 decision are documented in the #link("Lectures/course_architecture_scope/STATUS.md")[review register]. On 2026-10-14 the instructor selected Iris probability evaluation for L04, retaining the live parity example; the detailed scope and one-hour workload remain under review. The two-lecture neural revision is accepted at architecture level; detailed scopes and notebook execution remain under review. Data packaging, runtime checks and a student pilot are still required before notebook release. Previous independent reviews apply only to the versions they reviewed.

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

#text(size: 8pt, weight: "semibold", fill: blue)[Proposed 13-meeting sequence. No class has yet been taught. New notebook examples are not implemented or approved; check earlier scope decisions and separately validate data, runtime and student workload.]

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
  [Evaluate prepared Iris probability forecasts using held-out mean log score and accuracy, against a supplied class-frequency baseline. Interpret supplied reliability and bounded information/representation examples. No classifier training or population mutual-information estimation is required. The live three-bit parity example provides an exactly checkable information/error contrast.],
  [Choose and interpret probabilistic performance measures on real predictions, distinguishing scoring, prediction error and information retained.],
)

#lecture(
  5,
  [18.11.2026],
  [Generalized linear models, automatic differentiation and SGD],
  [Start from the familiar Bayesian regression likelihood and parameter prior; explain why Gaussian observations are unsuitable for binary responses and counts, without implying that the hierarchical model fails. Generalize the observation family using Gaussian/Bernoulli/Poisson GLMs and links. Contrast full posterior inference with MLE/MAP point fitting; derive the canonical NLL and vector softmax gradients, then reverse-mode autodiff and minibatch SGD.],
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
  [Recall Bayesian latent-variable hierarchies and joint posterior inference, then distinguish point estimation by marginal likelihood from inference over all unknowns. Show why unknown latent values complicate direct fitting, and derive the ELBO/KL identity, exact E-step tightness and EM monotonicity. Apply Gaussian conditional first/second moments to unknown mean/covariance with missing data; briefly interpret mixture responsibilities and assumptions.],
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
  [Inference overview and Laplace approximation],
  [Posterior queries, local Gaussian approximation, checked numerical reference and sample-average error. Derive scalar Laplace and iid estimator variance; interpret dependent-sampler diagnostics under their conditions. Replace grid/coordinate detail to fund the comparison.],
  [
    - 7.1–7.3 Inference questions and method choice
    - Selected 7.4.1–7.4.3 Mode, numerical reference and Laplace
    - 11.2–11.2.2 Sample averages and iid error; selected 12.6.3 diagnostics: interpretation
  ],
  [],
  [Use the 23-flight Challenger thermal-distress logistic posterior, with standardized temperature and proper Gaussian prior. Compare point and Laplace predictions with a supplied posterior sampler and checked two-dimensional reference. Work posterior-predictive averages and query-specific numerical error. Fitting, reference and diagnostics helpers supplied; no sampler construction or claim of exact MCMC output.],
  [Choose and check posterior answers; distinguish proxy error, posterior spread and finite sampling error.],
)

#lecture(
  8,
  [09.12.2026],
  [Exact inference in structured sequence models],
  [Scaled categorical-HMM filtering, smoothing and evidence; joint path MAP versus marginal decisions; dense O(T K²) message cost. Compact Gaussian filtering comparison.],
  [
    - 9.2.1–9.2.6 HMM messages, scaling and path queries
    - Selected 8.1.2 / 8.2.2 Gaussian filtering
  ],
  [],
  [Extend categorical-message logic to real Gaussian time series using the existing Oke PS2 Kalman package notebook. Scaffold conditional means/covariances, model fitting and predictive checks around package calls. Exact data/model depth remains to be frozen; current source and missing-observation repairs are checked in the lecture-local package-feasibility report, not a claim of full hosted execution.],
  [Transfer exact conditional-inference logic across categorical and Gaussian sequences.],
)

#lecture(
  9,
  [16.12.2026],
  [Variational and amortized inference],
  [ELBO/reverse KL, Gaussian family restriction, total pathwise gradients and optimizer error. Introduce the shared evidence-to-variational-parameters map; retain CAVI recognition while replacing its numerical sweep.],
  [
    - 10.1.1–10.1.2 Variational criterion
    - 6.3.3 / 6.3.5; 10.2.1.1 Pathwise gradients
    - 10.3.1 Coordinate rule; 10.1.5 amortization
  ],
  [],
  [Fit a Gaussian variational approximation to the accepted Challenger thermal-distress posterior; compare specified predictive queries with Laplace, supplied sampling output and a checked reference. Use the known correlated Gaussian to separate family and optimization error. Diagonal student family versus supplied full-family comparison remains a detailed pedagogical choice. No MCMC-theory handoff to L10.],
  [Fit and diagnose a variational posterior and explain amortized repeated-query computation.],
)

#lecture(
  10,
  [23.12.2026],
  [Deep Neural Networks I: learned representations and images],
  [GLM to learned nonlinear composition; categorical probability output; shared local filters, equivariance and receptive fields; one residual-gradient argument. Reuse AD/SGD rather than reteach a full optimizer.],
  [
    - 16.1 Two probabilistic roles
    - 16.2.1–16.2.5 Linear, nonlinear, convolutional, residual and normalization blocks
    - 16.3.1–16.3.2 MLP and CNN composition
  ],
  [
    - 13.1–13.2.5 Learned features and depth
    - Selected 13.3–13.5 Training support; 14.2.1 convolution
  ],
  [Source-adapted PyTorch LeNet on Fashion-MNIST: connect a local filter calculation to package output, inspect shapes/sharing, run bounded updates and evaluate held-out log score and errors against a supplied dense baseline. Supply preparation, training driver and checkpoint; no architecture search. Source, data and workload evidence: Lectures/deep_networks_revision/notebook_source_feasibility.md. One hour, integrated mathematical/technical/interpretive steps.],
  [Explain, fit and evaluate a learned compositional image representation.],
)

#lecture(
  11,
  [30.12.2026],
  [Deep Neural Networks II: representing sequence context],
  [Autoregressive likelihood, shared recurrent state and bounded unrolled derivative; Jacobian products; worked causal attention and positional information; context/cost tradeoffs and model versus inference-network roles.],
  [
    - 16.2.7–16.2.8 Attention and recurrence
    - 16.3.4–16.3.5 RNN and transformer composition
  ],
  [
    - 15.2.1 / 15.2.4–15.2.6 RNN and training
    - Selected 15.4–15.5 Attention, positions and transformers
  ],
  [Source-adapted PyTorch character RNN on Time Machine text. Compare held-out token log score with a smoothed Markov baseline, trace hidden-state updates and resets, then contrast teacher-forced scoring with categorical generation. Supply corpus splits, driver and checkpoint; no second transformer training. Attention receives mathematical live treatment rather than another full notebook.],
  [Model sequence context and choose a computational architecture under explicit dependency/cost assumptions.],
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
  [Fit or complete a small mobility-measurement VAE, compare prior generation with reconstruction, inspect latent descriptions and evaluate two controlled reconstruction/rate tradeoffs.],
  [Use and critique a latent generative model for reconstruction, generation and descriptive representations without overinterpreting hidden factors.],
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

