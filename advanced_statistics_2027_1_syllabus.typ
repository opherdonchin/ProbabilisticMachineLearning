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

The topic descriptions explain what each meeting will accomplish. Book references are provided afterward for preparation; they do not promise every subsection. The instructor selected the simpler L03 image algorithm and L04 coding example. Other detailed choices await instructor review. An independent revision review checked the readable wording, preserved mathematics and lighter L04 choice; see #link("Lectures/course_architecture_scope/STATUS.md")[review records]. Future notebooks have not been written or run. They must be tested locally, in Google Colab and within the student hour before release.

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

#text(size: 8pt, weight: "semibold", fill: blue)[The 13-meeting order is agreed. Detailed teaching choices remain proposals except the selected L03/L04 choices. L01/L02 material is unchanged. Future notebook code and timing have not been tested.]

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
  [Graphical models: local calculations in a large model],
  [Use graphs to describe which variables interact. Build and normalize a small black-and-white pixel model; calculate the probability of one pixel given its neighbors. Improve a noisy image one pixel at a time, and show why this can stop short of the best whole image.],
  [
    - 4.2.1 / 4.2.4 Directed graphs: review only
    - 4.3.1–4.3.2.1 Pixel model and normalization
    - 4.3.6.1 / selected 4.3.8 Conditional independence and image model
    - 4.6.1.1 Factor-graph representation
  ],
  [
    - Selected 3.6.1–3.6.2 Directed-graph review
  ],
  [Calculate a pixel update, check it by listing every configuration of a tiny image, and use a supplied program to repeat updates on a larger image.],
  [Turn a probability model into a local calculation and check it against an exact small example.],
)

#lecture(
  4,
  [11.11.2026],
  [Information theory: what survives a noisy message?],
  [Measure uncertainty and shared information. Explain why processing cannot create information about the original source. Add one parity bit—a bit that checks whether two message bits differ—and calculate what a noisy transmission tells us. Distinguish detecting an error from guaranteeing its correction.],
  [
    - 5.1.3 / 5.1.6; 5.2.1 / 5.2.4 Information and uncertainty
    - 5.3.1–5.3.4 Shared information and processing
    - 5.4.1 Code-length bounds: statement only
    - 5.5 Noisy-channel example: three-bit parity model
  ],
  [
    - Selected 6.1 / 6.2.1–6.2.2 / 6.3 Uncertainty and shared information
  ],
  [List the eight possible received three-bit strings. Calculate message probabilities, information and best-guess error; explain ambiguous results. Reference a stronger five-bit code without implementing it.],
  [Build and check a small probability table, and distinguish useful information from a guaranteed correct decision.],
)

#lecture(
  5,
  [18.11.2026],
  [Learning models: regression, derivatives and parameter updates],
  [Compare models for numerical, yes/no and count outcomes: generalized linear models. Derive a common likelihood derivative, then apply it to three-class prediction. Explain automatic differentiation by following one complete calculation backward. Fit parameters using small batches of observations.],
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
  [Fit probabilities for all three Iris species in PyTorch. Compare a hand-calculated derivative with the software result, update parameters repeatedly and evaluate new observations.],
  [Check automatic derivatives and carry out a simple fit/evaluation loop in PyTorch.],
)

#lecture(
  6,
  [25.11.2026],
  [Learning with missing data: expectation-maximization],
  [Alternate between estimating missing quantities under the current model and updating the model: expectation-maximization (EM). Keep uncertainty about missing values when learning a Gaussian mean and covariance. Explain the probability bound used to justify the updates and the conditions for improvement.],
  [
    - Selected 6.5.1 / 6.5.3 Probability bound and EM
    - 6.5.4 Gaussian missing-data updates
    - 3.11 When the missing-data mechanism can be ignored
    - 28.2.1 Group-assignment probabilities: brief example
  ],
  [
    - Selected 3.5 / 8.7 Grouped observations and EM explanation
  ],
  [Complete the expected values and second moments needed to fit a Gaussian to incomplete measurements. Use a supplied update loop and inspect likelihood and reconstruction.],
  [Use uncertainty about missing values in a parameter update rather than merely fill blanks with best guesses.],
)

#lecture(
  7,
  [02.12.2026],
  [Posterior approximation: compare a grid with a Gaussian shortcut],
  [Use a one-parameter logistic model to compare a posterior computed on a fine grid with a Gaussian fitted near its peak: the Laplace approximation. Check the grid’s range and spacing, and compare posterior summaries and predictions. Explain why the most likely parameter depends on how we express it.],
  [
    - 7.1–7.3 What posterior questions require: short introduction
    - Selected 7.4.1–7.4.3 Most likely parameter, grid and Gaussian shortcut
    - Selected 7.5 Checking approximation quality
    - Selected 15.3.5–15.3.6 One-parameter logistic example
  ],
  [],
  [Construct a numerical posterior reference, change its range and spacing, then compare the Gaussian shortcut and predictions. Solver and plotting helpers are supplied.],
  [Check a numerical reference and assess the consequences of an approximation.],
)

#lecture(
  8,
  [09.12.2026],
  [Sequences: infer hidden states using repeated calculations],
  [Infer whether a fair or loaded die produced each observation: a hidden Markov model. Derive repeated forward/backward calculations using earlier and later observations, prevent numerical underflow and distinguish the best whole history from the most likely state at each time. Briefly apply Gaussian conditioning to Kalman filtering.],
  [
    - 9.2.1–9.2.5 Hidden-state calculations and scaling
    - 9.2.6 Whole history versus separate state decisions
    - Selected 8.1.2 / 8.2.2 Gaussian filtering: short application
  ],
  [],
  [Implement the central hidden-state calculations in NumPy. Check a short sequence by listing its histories, including a test where transition directions matter. Simulation and plots are supplied.],
  [Reuse partial calculations to avoid listing an exponentially large set of hidden histories.],
)

#lecture(
  9,
  [16.12.2026],
  [Approximate a posterior by fitting a simpler distribution],
  [Fit a simpler probability distribution to a posterior: variational inference. Show what an independent-coordinate Gaussian loses when the posterior has correlations. Derive how to differentiate a random-sample calculation and briefly apply coordinate-by-coordinate updates. Reuse L06’s probability bound.],
  [
    - 10.1.1–10.1.2 Fitting a restricted distribution
    - 6.3.3 / 6.3.5; 10.2.1.1 Derivatives through Gaussian draws
    - 6.3.4 Another gradient estimator: statement only
    - 10.3.1 Coordinate updates; 10.1.5 learned inference: introduction only
  ],
  [],
  [Fit an independent-coordinate Gaussian to a regression posterior with a known exact answer. Compare fitting error, the limitations of the chosen distribution and predictive uncertainty.],
  [Compute derivatives through random draws and check an approximation against a known answer.],
)

#lecture(
  10,
  [23.12.2026],
  [Sampling: correct transitions and unreliable short runs],
  [Estimate expectations by averaging samples. Introduce a chain whose next sample depends on the previous one, then derive the Metropolis–Hastings accept/reject rule. Explain why preserving the target distribution is different from exploring it quickly, and why error depends on the quantity being estimated.],
  [
    - 11.2–11.2.2 Averages and sampling error
    - 2.6.4; 12.2.1–12.2.2 Invariant distribution and acceptance rule
    - 12.3.1–12.3.2 Conditional-coordinate sampling: brief derivation
    - Selected 12.6.3 Dependent-sample error; 12.5.3 Hamiltonian mechanics only
  ],
  [],
  [Complete a NumPy accept/reject sampler. Compare proposal sizes and starting points on a distribution with two separated peaks; check the mean and the probability of a value greater than zero against known values.],
  [Check a sampling rule and diagnose inadequate exploration before trusting an estimate.],
)

#lecture(
  11,
  [30.12.2026],
  [Neural prediction: learn a mean and a noise level],
  [Replace a linear prediction rule by a small neural network. Predict both a mean and positive standard deviation, derive the Gaussian likelihood calculation and reuse automatic differentiation. Distinguish variation in observations from uncertainty about fitted weights. Explain a Gaussian-prior connection to shrinking weights.],
  [
    - Selected 16.2.1–16.2.2 / 16.3.1 Small feedforward networks
    - 15.2.2.1 Gaussian prior and weight shrinkage
    - 14.2.1 Evaluating predicted probabilities
  ],
  [
    - 13.2.4.4 Noise that depends on input
    - 13.5.2 Weight shrinkage; 13.5.1 stopping training: brief mention
  ],
  [Fit one small nonlinear Gaussian model and compare it with a supplied fixed-noise model on new observations. Inspect predicted noise and intervals.],
  [Build a probability prediction with a neural network and interpret its uncertainty correctly.],
)

#lecture(
  12,
  [06.01.2027],
  [Variational autoencoders: learn a compact hidden description],
  [Learn one network that describes observations with hidden coordinates and another that predicts observations from them: a variational autoencoder. Reuse the probability bound, sample derivatives and neural likelihoods. Study the reconstruction/penalty tradeoff and why a penalty value alone does not measure useful information or reveal unique causes.],
  [
    - Selected 21.1–21.2 Model, inference network and training objective
    - 21.3.1 Changing the penalty weight
    - Selected 5.4.2 Reconstruction/information tradeoff
    - Selected 21.4 When the model ignores hidden coordinates
  ],
  [],
  [Complete a small mobility-data model and one joint training run. Use prepared comparison runs to study reconstruction and hidden descriptions under different penalty strengths.],
  [Combine two networks in one probability model and check how its likelihood and penalty are scaled.],
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

