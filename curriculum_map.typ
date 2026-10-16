#set page(
  paper: "a4",
  flipped: false,
  margin: (x: 15mm, y: 13mm),
)
#set text(font: "Libertinus Serif", size: 11pt)
#set par(leading: 1em, spacing: 0.8em)

#let navy = rgb("#173A5E")
#let blue = rgb("#2F6690")
#let pale-blue = rgb("#EEF4F8")
#let rule = rgb("#D8DEE4")
#let muted = rgb("#59636E")

#show heading.where(level: 1): it => block(above: 1.1em, below: 1em)[
  #text(size: 16pt, weight: "bold", fill: navy)[#it.body]
]
#show heading.where(level: 2): it => block(above: 1.1em, below: 0.8em)[
  #text(size: 11.3pt, weight: "bold", fill: blue)[#it.body]
]

#let hdr(body) = table.cell(fill: navy, inset: 5pt)[
  #text(weight: "bold", fill: white)[#body]
]
#let note(body) = text(size: 7.3pt, fill: muted, body)

#let concept-card(title, body, tint: pale-blue) = rect(
  width: 100%,
  inset: 9pt,
  radius: 5pt,
  fill: tint,
  stroke: 0.65pt + rule,
)[
  #align(center)[
    #text(weight: "bold", fill: navy)[#title]
    #v(3pt)
    #text(size: 8.5pt, fill: black)[#body]
  ]
]

= Curriculum map

#text(size: 9pt, fill: muted)[Advanced Statistics 2027-1 · Proposed material allocation and problem-solving activities]

The #link("course_architecture.typ")[course architecture] defines the course's educational purpose and intellectual progression. This map allocates *proposed* lecture material, Murphy sections, problem-solving activities, and relevant worked references. It records proposals and known prior decisions, not actual teaching or automatic approval of new notebooks. Approved #link("Lectures/README.md")[lecture scopes] own detailed commitments. The parallel #link("curriculum_map_actual.typ")[actual curriculum map] uses the same lecture structure and records what was substantively taught and attempted after each meeting. Drafted decks and notebook solutions are preparation, not evidence of actual teaching.

Because no lecture has yet been given, every entry remains prospective in the classroom sense. The L01 deck and solved notebook are prepared artifacts, not evidence of student practice; notebook feasibility, data access, runtimes and remaining decisions need separate validation. Murphy Book 2 is primary; Book 1 supplies selected scaffolding. Section references are author-preparation and scope candidates, not promises to teach every subsection.

#set page(flipped: true)

= Proposed lecture and problem-solving practice map

The thirteen-meeting allocation is a *revisable course proposal*, not a teaching record or replacement for approved scopes. L01 is prepared but untaught; L02 has an agreed design; L03 has an earlier agreed scope. On 2026-10-14 the instructor selected Iris evaluation for L04, retaining live parity; its full revised scope remains provisional. Other proposed alternatives do not amend prior decisions. Check scopes and review records before implementation.

Each row connects an identifiable learning problem, a mathematical exemplar, and *bounded hands-on competence*. One notebook should generally provide meaningful use and evaluation of a method on data; when the chosen derivation needs a tiny exactly checkable example, supplied code or reference results can keep that diagnostic alongside the application. L07, L09 and L10 particularly benefit from revisiting a shared Bayesian prediction problem so that students compare methods, not just benchmark unrelated algorithms. Practical datasets, scaffolding, runtime and the one-hour limit still require separate feasibility checks.

#set text(size: 8pt)
#set par(leading: 0.55em, spacing: 0.6em)

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
    hdr[Student problem, method use, evaluation and references],
  ),

  [1],
  [*Probabilistic ML and Gaussian systems* \
  #note[Prepared, not taught]],
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
  [*Gaussian measurement imputation (authored, not yet taught).* Condition a multivariate Gaussian on observed measurements, infer missing values and their uncertainty. Reference: #link("https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/lecture-3-prep/InClass/Solutions/lecture1_missing_data.ipynb")[Existing L1 solved notebook].],

  [2],
  [*Exponential families and learning from sufficient statistics* \
  #note[Earlier agreed design]],
  [Exponential-family likelihoods, sufficient statistics and moment matching; infer and evaluate a categorical transition model. Describe data type, probability law and the consequences of the Markov assumption.],
  [
    - 2.2.1.2 Categorical distribution
    - 2.4.1–2.4.2 Exponential-family form; examples
    - 2.4.3–2.4.4 Log partition; moments
    - 2.4.5 MLE; moment matching
    - 2.4.7 Maximum entropy
    - 2.6.1–2.6.3 Markov chains; language models
  ],
  [],
  [*Character bigram prediction and generation.* Count transitions in baby names, fit a categorical transition matrix, compute held-out name log scores and generate plausible examples. Compare with an independent-character baseline and examine a failed or implausible output. *Competence:* Fit, score, generate and critique a simple distributional model. #link("https://github.com/karpathy/nn-zero-to-hero/blob/master/lectures/makemore/makemore_part1_bigrams.ipynb")[Reference notebook].],

  [3],
  [*Graphical models: factorization and conditional independence* \
  #note[Earlier agreed scope; proposed revision]],
  [Joint modeling of many dependent variables: DAG factorization, conditional independence, Markov blankets, undirected potentials and the Ising model. Use structural assumptions to derive a practical reconstruction calculation, while distinguishing it from exact marginal inference.],
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
  [*Probabilistic image restoration.* Construct a locally coupled Ising prior and noisy-image likelihood; derive a site conditional and implement a scaffolded local reconstruction update. Compare with independent pixel restoration, assess visible errors and diagnose local optima. *Competence:* Recognize when local factors help construct and use a structured model, without confusing local MAP updates with posterior marginal probabilities. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/04/ising_image_denoise_demo.ipynb")[Reference notebook].],

  [4],
  [*Information theory: distributional comparison and information preservation* \
  #note[Iris endpoint selected]],
  [Proper probabilistic scoring, entropy, cross-entropy, KL divergence, mutual information and data processing. Judge predictive distributions and representations in terms of the task's performance, not accuracy alone. A small noisy-code construction illustrates information versus error and rate.],
  [
    - 5.1.3 / 5.1.6; 5.2.1 / 5.2.4 Information and uncertainty
    - 5.3.1–5.3.4 Shared information and processing
    - 5.4.1 Code-length bounds: statement only
    - 5.5 Noisy-channel example: three-bit parity model
  ],
  [
    - Selected 6.1 / 6.2.1–6.2.2 / 6.3 Uncertainty and shared information
  ],
  [*Evaluate prepared Iris forecasts.* Compare held-out accuracy and mean log loss with a supplied class-frequency baseline; interpret supplied reliability and bounded information examples. No training or population-MI estimation. *Competence:* Distinguish a correct label from a good probability forecast. *Selected 2026-10-14:* replaces five-bit student construction; three-bit parity stays live. #link("Lectures/L04_Information_Theory/lecture_scope.md")[Detailed scope] and one-hour feasibility remain provisional.],

  [5],
  [*Generalized linear models, automatic differentiation and SGD* \
  #note[Revisable proposal]],
  [Gaussian, Bernoulli, Poisson and categorical conditional prediction; GLM links, canonical gradients and convexity when applicable. MLE/MAP point fitting via autodiff and mini-batch SGD. Use predictive probabilities and held-out scores to judge fitted classifiers.],
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
  [*Iris probabilistic classification.* Fit a three-class softmax model with prepared PyTorch scaffolding. Check one manually derived gradient against autograd, train from a supplied baseline, inspect confusion and predicted probabilities, and compare held-out log score with a simple alternative. *Competence:* Set up, fit, interpret and diagnose a probabilistic classifier, rather than merely verify backpropagation. #link("https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb")[Reference notebook]. *Limit:* First encounter with PyTorch; supply data splits and helpers.],

  [6],
  [*Latent-variable learning and expectation-maximization* \
  #note[Revisable proposal]],
  [Latent-variable joint likelihood and observed-data marginal likelihood; ELBO/KL identity, exact EM conditional expectations and monotonic improvement. Use conditional second moments for missing-data Gaussian parameter fitting; recognize mixture responsibilities and missingness assumptions.],
  [
    - Selected 6.5.1 / 6.5.3 Probability bound and EM
    - 6.5.4 Gaussian missing-data updates
    - 3.11 When the missing-data mechanism can be ignored
    - 28.2.1 Group-assignment probabilities: brief example
  ],
  [
    - Selected 3.5 / 8.7 Grouped observations and EM explanation
  ],
  [*Fit a population model with incomplete measurements.* Work with a prepared multivariate measurement dataset with controlled missingness. Assemble expected sufficient statistics, including conditional covariance, and run EM in a supplied driver. Compare against a complete-case or mean-imputation baseline; assess observed-data log likelihood and held-out reconstruction separately. *Competence:* Fit, evaluate and diagnose an incomplete-data model and recognize when EM is or is not an appropriate tool. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/opt/gauss_imputation_em_demo.ipynb")[Reference notebook].],

  [7],
  [*Bayesian computation: grid reference and Laplace approximation* \
  #note[Revisable proposal]],
  [Bayesian logistic-regression predictions and parameter uncertainty; MAP versus posterior queries; Laplace mode/Hessian construction, conditions for local Gaussian validity, computational scaling, and query-specific error.],
  [
    - 7.1–7.3 What posterior questions require: short introduction
    - Selected 7.4.1–7.4.3 Most likely parameter, grid and Gaussian shortcut
    - Selected 7.5 Checking approximation quality
    - Selected 15.3.5–15.3.6 One-parameter logistic example
  ],
  [],
  [*Bayesian binary classification, first inference route.* Use a prepared, overlapping two-class subset of the Iris task, with few parameters, to compare point predictions with posterior-averaged predictions from a Laplace Gaussian. A one-parameter restriction and checked numerical grid provide an exactness *diagnostic*, not the practical motivation. Inspect uncertainty and when local curvature is misleading. *Competence:* Construct and use a Laplace posterior proxy and evaluate the downstream prediction. #link("https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/")[Reference for numerical check]. *Feasibility:* Supply fitting and Hessian helpers; do not require two complete independent fits.],

  [8],
  [*Exact inference in structured sequence models* \
  #note[Revisable proposal]],
  [HMM filtering, smoothing, evidence and path MAP as different answers to a hidden-state problem. Forward–backward factorization and exact dynamic programming; scaling, computational cost, and brief linear-Gaussian Kalman comparison.],
  [
    - 9.2.1–9.2.5 Hidden-state calculations and scaling
    - 9.2.6 Whole history versus separate state decisions
    - Selected 8.1.2 / 8.2.2 Gaussian filtering: short application
  ],
  [],
  [*Infer hidden behavioral or instrument states from a noisy sequence.* Use a prepared labeled-context sequence and a small HMM: compute filtered/smoothed probabilities, identify uncertain transitions and compare a state-by-state prediction with path MAP or a naive baseline. Check a tiny enumerated sequence for correctness. *Competence:* Use exact message passing and interpret probabilistic state inference instead of merely producing a sequence of hard labels. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/casino_hmm.ipynb")[Casino HMM diagnostic reference]. *Feasibility:* Prepare the sequence and model parameters; no full state-space-model fitting required.],

  [9],
  [*Variational inference: posterior geometry and pathwise gradients* \
  #note[Revisable proposal]],
  [Variational distributional optimization via reverse KL/ELBO, approximation-family and optimizer error, pathwise gradients, and mean-field limitations. Contrast the fitted Gaussian with Laplace on the same kind of posterior query.],
  [
    - 10.1.1–10.1.2 Fitting a restricted distribution
    - 6.3.3 / 6.3.5; 10.2.1.1 Derivatives through Gaussian draws
    - 6.3.4 Another gradient estimator: statement only
    - 10.3.1 Coordinate updates; 10.1.5 learned inference: introduction only
  ],
  [],
  [*Bayesian binary classification, second inference route.* With prepared likelihood and optimizer code, fit a diagonal-Gaussian variational posterior for the overlapping binary Iris model used in L07; compare task-relevant predictions and uncertainty with Laplace and a supplied reference. A correlated Gaussian with known answer isolates mean-field family error from optimization error. *Competence:* Fit and diagnose a variational posterior and decide whether lost dependence matters for the prediction. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb")[Reference VI implementation]. *Feasibility:* Limit student code to the defining objective, parameters, and interpretive comparisons.],

  [10],
  [*Monte Carlo and MCMC: invariance, mixing and estimator error* \
  #note[Revisable proposal]],
  [Monte Carlo estimators for posterior queries; MCMC target invariance versus mixing, Metropolis–Hastings correction, Gibbs full-conditionals, finite-run error and query-dependent effective sample size.],
  [
    - 11.2–11.2.2 Averages and sampling error
    - 2.6.4; 12.2.1–12.2.2 Invariant distribution and acceptance rule
    - 12.3.1–12.3.2 Conditional-coordinate sampling: brief derivation
    - Selected 12.6.3 Dependent-sample error; 12.5.3 Hamiltonian mechanics only
  ],
  [],
  [*Bayesian inference by sampling, third route.* With an MH driver and precomputed L07/L09 comparisons, estimate posterior expectations and predictive probabilities for the same small binary-classification model; examine run-to-run variability and query-specific error. A supplied bimodal target is a stress test for mixing and mode exploration. *Competence:* Run and diagnose MCMC estimates rather than equate stationarity with successful finite computation. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb")[Bimodal diagnostics reference]. *Feasibility:* Supply proposal, plotting and diagnostics so one hour is enough.],

  [11],
  [*Neural conditional models: heteroskedastic likelihood and regularization* \
  #note[Revisable proposal]],
  [Nonlinear differentiable conditional models with learned mean and positive scale, heteroskedastic Gaussian log score, SGD/AD reuse, regularized point fitting and differences between conditional noise and weight uncertainty.],
  [
    - Selected 16.2.1–16.2.2 / 16.3.1 Small feedforward networks
    - 15.2.2.1 Gaussian prior and weight shrinkage
    - 14.2.1 Evaluating predicted probabilities
  ],
  [
    - 13.2.4.4 Noise that depends on input
    - 13.5.2 Weight shrinkage; 13.5.1 stopping training: brief mention
  ],
  [*Conditional probability beyond a GLM.* Train a small mean/scale neural model on a prepared nonlinear dataset and evaluate against fixed-scale and simpler-function baselines. Compare held-out log score, mean error, and regional interval behavior, not just training loss. *Competence:* Assess whether a flexible predictive distribution earns its complexity and distinguish observation variability from parameter uncertainty. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb")[Reference].],

  [12],
  [*Variational autoencoders: amortized inference and rate–distortion* \
  #note[Revisable proposal]],
  [High-dimensional latent generative model and per-case approximate posterior; shared amortized encoder, neural decoder, ELBO and pathwise training, reconstruction/rate tradeoff, posterior collapse and representation identifiability.],
  [
    - Selected 21.1–21.2 Model, inference network and training objective
    - 21.3.1 Changing the penalty weight
    - Selected 5.4.2 Reconstruction/information tradeoff
    - Selected 21.4 When the model ignores hidden coordinates
  ],
  [],
  [*Generate and represent mobility measurements.* Fit or complete a compact VAE on supplied 19-feature observations. Inspect separate reconstructions and *prior-generated* cases, compare tradeoffs across supplied settings, and look at latent descriptions without claiming causal recovery. *Competence:* Use and critically evaluate a generative latent model, including whether the encoder and codes are useful. #link("Lectures/course_architecture_scope/source_inspection.md")[Mobility-data provenance]. *Feasibility:* Require verified data access, prepared fit baselines, and a CPU/runtime pilot before fixing the exercise.],

  [13],
  [*Project presentations and course synthesis*],
  [Student project presentations connecting probabilistic assumptions, computation, prediction, evaluation, uncertainty and scientific interpretation. No additional substantive lecture topic is committed at this stage.],
  [],
  [],
  [No notebook — project presentations and synthesis.],
)

#set page(flipped: false)
#set text(size: 11pt)
#set par(leading: 1em, spacing: 0.8em)

= Selection, omissions, and what students actually gain

This course develops a usable and intellectually connected repertoire, not an exhaustive survey of Murphy. The choices below trade some topical breadth for repeated *method use*, *comparison of output with a task-specific criterion*, and *diagnosis of failure*. They are current design hypotheses rather than completed student trials. The #link("Lectures/course_architecture_scope/architecture_audit.md")[architecture audit] records evidence and feasibility concerns; the current semester's lecture scopes and notebook drivers must be reconciled before declaring new assignments final.

#set text(size: 8.5pt)
#set par(leading: 0.65em, spacing: 0.7em)

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
  [A complete algorithm catalogue], [One working exemplar per lecture, with recurring dataset comparisons where they clarify choices], [Less survey breadth; more ability to explain, execute and diagnose selected techniques.],
  [Every method on a different isolated toy problem], [A shared Bayesian classifier in L07/L09/L10 plus small transparent diagnostics], [Less variety in those notebooks, but a more meaningful comparison of posterior approximations and sampling at fixed task and performance.],
)
