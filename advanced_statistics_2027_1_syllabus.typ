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

The primary reference is Murphy's _Probabilistic Machine Learning: Advanced Topics_ (*Book 2*); Book 1 is used selectively when it gives needed background or a more pedagogical derivation. The proposed course progression moves from exponential families and graphical models through information theory, differentiable optimization, EM, structured inference, VI and MCMC to neural networks and VAEs. Key GLM concepts are integrated into the optimization and neural-network lectures rather than assigned a separate meeting.

Each meeting includes approximately two hours of mathematical lecture and one hour of guided notebook work. Lectures and notebooks have complementary jobs: the lecture establishes mathematics, while the notebook solves a particular application and builds transferable skills.

**Software progression.** Students enter with experience in Python, NumPy, PyMC, Bambi and ArviZ. The proposed plan introduces PyTorch in L05 for automatic differentiation and optimization, develops scikit-learn and SciPy skills, and later reuses PyTorch to train neural and generative models. JAX is not required.

= Additional materials

1. Kevin P. Murphy, _Probabilistic Machine Learning: Advanced Topics_, MIT Press, 2023 (Book 2). #link("https://probml.github.io/pml-book/book2.html")[Online edition].
2. Kevin P. Murphy, _Probabilistic Machine Learning: An Introduction_, MIT Press, 2022 (Book 1). #link("https://probml.github.io/pml-book/book1.html")[Online edition].
3. Course notes, exercises, notebook solutions and project materials: #link("https://github.com/opherdonchin/ProbabilisticMachineLearning")[course repository].

Section references below indicate preparation material rather than exact class coverage. Notebook applications are current plans; candidate exercises are subject to lecture scoping, runtime validation and available class time.

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

#text(size: 8pt, weight: "semibold", fill: blue)[Instructor-selected course architecture (2026-10-11). Individual L03–L12 lecture scopes and notebook choices remain provisional until agent-led scoping and feasibility review.]

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
  [Compact DAG review; undirected factorization and potentials; partition functions; Ising/Potts interactions; local Markov properties; comparison with directed graphs; factor graphs as preparation for later message passing.],
  [
    - 4.2.1–4.2.4 Directed graphs; independence
    - 4.3.1–4.3.6 MRFs; potentials; Ising; CI
    - 4.3.7–4.3.9 Sampling; inference; learning
    - 4.5 Directed vs undirected models
    - 4.6.1 Factor graphs
  ],
  [
    - 3.6.1 Graph representation
    - 3.6.2 Graphical inference
  ],
  [Use an Ising model to restore a noisy image (candidate).],
  [Implementing local conditional probability updates from a graph in NumPy.],
)

#lecture(
  4,
  [11.11.2026],
  [Information theory: dependence, communication, and representations],
  [Entropy, cross-entropy and KL; mutual information as a measure of dependence; the data-processing inequality; a concrete source- or channel-coding problem; rate-distortion as a bridge to later generative models. Full information bottleneck is deferred to the VAE context.],
  [
    - 5.1.3–5.1.8 KL, MLE and Bayes
    - 5.2.1–5.2.4 Entropy and cross-entropy
    - 5.3.1–5.3.4 Mutual information, data processing, sufficient statistics
    - 5.4.1–5.4.2 Source coding, rate-distortion (selected)
    - 5.5 Channel coding (selected application)
    - 5.6 Information bottleneck (brief orientation)
  ],
  [
    - 6.1 Entropy and cross-entropy
    - 6.2.6 Forward/reverse KL (possible)
  ],
  [Analyze a noisy parity-check code: compute entropy and mutual information and use posterior decoding to correct errors (candidate).],
  [Finite-probability enumeration, dependence and channel information with NumPy.],
)

#lecture(
  5,
  [18.11.2026],
  [Learning probabilistic models: GLMs and optimization],
  [Build conditional exponential-family GLMs from the L02 foundation: Gaussian, Bernoulli and Poisson outcomes, canonical links, and the general likelihood gradient. Use multinomial softmax as a complete probabilistic prediction example; teach reverse-mode automatic differentiation and mini-batch stochastic gradient training to fit it. Brief MLE/MAP and log-loss evaluation connections; stochastic-distribution gradients remain for VI and VAEs.],
  [
    - 15.1–15.1.1 GLM form, links, Gaussian/Bernoulli/Poisson
    - 15.1.2 Noncanonical links (mention); 15.1.3 MLE and gradient derivation
    - 15.3.2 Multinomial logistic regression
    - 6.1–6.2 Optimization and automatic differentiation (selected)
    - 6.3.1–6.3.2 Stochastic gradient descent and minibatches
    - 14.1.2 MLE/MAP; 14.2.1 log loss (brief)
  ],
  [
    - 7.8 Matrix calculus
    - 8.1–8.2 Gradient optimization
    - 8.4.1–8.4.3 Stochastic gradient descent
    - 10.2–10.3 Logistic regression (selected)
  ],
  [Implement the three-class Iris categorical GLM: derive/compute its NLL, train with PyTorch autodiff and minibatch SGD, evaluate held-out probabilities and log loss.],
  [PyTorch tensors, computational graphs, autograd, losses, optimizers and predictive evaluation.],
)

#lecture(
  6,
  [25.11.2026],
  [Latent-variable learning and EM],
  [Mixture models; latent assignments; complete vs observed likelihood; EM as alternating inference and optimization; expected sufficient statistics; relation to exponential-family moment matching.],
  [
    - 6.5.1–6.5.6 Bound optimization; EM
    - 28.2 Mixture models
  ],
  [
    - 3.5 Gaussian and Bernoulli mixtures
    - 8.7.1–8.7.3 Bound optimization; EM for GMMs
  ],
  [Learn with EM from missing Gaussian data or segment MRI tissue (two candidates).],
  [Writing explicit E/M iterations and verifying against existing fitters.],
)

#lecture(
  7,
  [02.12.2026],
  [Inference as computation],
  [Posterior, marginal, predictive and expected-value queries as sums / integrals; exact vs approximate inference; MAP; grid and Laplace approximation; variational inference, MCMC and SMC as contrasting strategies; how structural assumptions and computational budget determine the method.],
  [
    - 7.1–7.2 Inference queries; latent patterns
    - 7.3 Exact inference
    - 7.4.1–7.4.7 Approximate inference
    - 7.5 Evaluating inference
  ],
  [],
  [Compare a grid posterior for Bayesian logistic regression against MAP and Laplace.],
  [Numerical integration, optimization and approximation checks using SciPy.],
)

#lecture(
  8,
  [09.12.2026],
  [Exact inference in structured sequence models],
  [Dynamic programming / message passing; hidden Markov models; forward-backward and Viterbi as exact summation / maximization over exponentially many latent-state sequences; Gaussian filtering as the continuous analogue; selected Kalman filtering if scope permits.],
  [
    - 8.1–8.2 Gaussian filtering; Kalman smoothing
    - 9.1–9.2 Message passing; HMM inference
  ],
  [],
  [Forecast a time series with a Kalman filter (candidate, Oke PS2).],
  [Representing and testing structured state-space inference without JAX.],
)

#lecture(
  9,
  [16.12.2026],
  [Variational inference and amortized inference],
  [Variational approximation as optimization; ELBO; mean-field structure; coordinate ascent; black-box / stochastic VI; reparameterization; amortized inference as learning a map from observations to approximate posteriors.],
  [
    - 10.1 Variational objectives; amortization
    - 10.2 Gradient-based VI
    - 10.3 Coordinate-ascent VI
    - 10.4 Structured variational posteriors
  ],
  [],
  [Compare a variational regression posterior against an MCMC reference.],
  [Specifying and diagnosing variational approximation with PyMC or PyTorch.],
)

#lecture(
  10,
  [23.12.2026],
  [Monte Carlo and MCMC],
  [Monte Carlo approximation of integrals; proposal-based sampling; Metropolis-Hastings; Gibbs sampling; Hamiltonian Monte Carlo; diagnostics and the relation between sampling cost, posterior geometry and effective information.],
  [
    - 11.1–11.2 Monte Carlo integration
    - 11.4–11.5 Rejection; importance sampling
    - 12.1–12.3 Metropolis-Hastings; Gibbs
    - 12.5 Hamiltonian Monte Carlo
  ],
  [],
  [Evaluate Metropolis proposals on a multimodal mixture target.],
  [Implementing Markov transition proposals and measuring sampling efficiency.],
)

#lecture(
  11,
  [30.12.2026],
  [Neural networks as probabilistic conditional models],
  [From the L05 linear GLM predictor to nonlinear probabilistic networks: MLPs, training, and heteroskedastic predictive distributions; revisit weight decay as a Gaussian-prior analogue. Calibration is an optional brief evaluation extension rather than a second large topic.],
  [
    - 16.1–16.2 Neural-network building blocks
    - 16.3 MLPs; selected architectures
    - 14.2.1–14.2.2 Scoring/calibration (optional brief diagnostic)
    - 15.2.2 / 15.2.6 Gaussian prior and lasso (brief connection)
  ],
  [
    - 11.3–11.4 Ridge/lasso (optional brief prior connection)
    - 13.2 MLPs; nonlinearities
    - 13.3 Backpropagation
    - 13.4 Network training
    - 13.5.1–13.5.4 Early stopping; weight decay; dropout
    - 13.5.6 SGD regularization
  ],
  [Fit a neural model that predicts both conditional mean and variance.],
  [PyTorch nn.Module, nonlinear layers and probability-distribution outputs.],
)

#lecture(
  12,
  [06.01.2027],
  [Variational autoencoders: neural latent-variable models],
  [Latent-variable generative model; encoder/decoder networks; amortized posterior; ELBO and reparameterization; reconstruction/KL as rate-distortion; β-VAE and posterior collapse. Connect to mutual information from L04 without requiring full supervised IB/InfoVAE derivations.],
  [
    - 21.1–21.2 VAE model; ELBO; inference network
    - 21.3.1 β-VAE (core); 21.3.2 InfoVAE (optional mention)
    - 21.4 Posterior collapse
    - 5.4.2 Rate-distortion (selected return); 5.6 IB (comparison only)
  ],
  [],
  [Train a VAE for mobility variables (Oke PS4) or MNIST.],
  [PyTorch encoder/decoder networks, reparameterization and ELBO diagnostics.],
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

