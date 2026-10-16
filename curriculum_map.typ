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

Each row connects an identifiable learning problem, a mathematical exemplar, and *bounded hands-on competence*. One notebook should generally provide meaningful use and evaluation of a method on data; when the chosen derivation needs a tiny exactly checkable example, supplied code or reference results can keep that diagnostic alongside the application. L07 and L09 benefit from revisiting the accepted Challenger posterior so that students compare methods, not just benchmark unrelated algorithms. Practical datasets, scaffolding, runtime and the one-hour limit still require separate feasibility checks.

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
  [*Character bigram prediction and generation.* Count transitions in baby names, fit and inspect a categorical transition matrix, compute string log scores under the fitted model and generate examples. Held-out comparison with an independent-character baseline and diagnosis of failed or implausible outputs are optional extensions. *Competence:* Fit, inspect, score and generate with a simple distributional model. #link("https://github.com/karpathy/nn-zero-to-hero/blob/master/lectures/makemore/makemore_part1_bigrams.ipynb")[Reference notebook].],

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
  [*Inference overview and Laplace approximation* \
  #note[Revisable implementation contract]],
  [Posterior queries, local Gaussian approximation, checked numerical reference and sample-average error. Derive scalar Laplace and iid estimator variance; interpret dependent-sampler diagnostics under their conditions. Replace grid/coordinate detail to fund the comparison.],
  [
    - 7.1–7.3 Inference questions and method choice
    - Selected 7.4.1–7.4.3 Mode, numerical reference and Laplace
    - 11.2–11.2.2 Sample averages and iid error; selected 12.6.3 diagnostics: interpretation
  ],
  [],
  [Use the 23-flight Challenger thermal-distress logistic posterior, with standardized temperature and proper Gaussian prior. Compare point and Laplace predictions with a supplied posterior sampler and checked two-dimensional reference. Work posterior-predictive averages and query-specific numerical error. Fitting, reference and diagnostics helpers supplied; no sampler construction or claim of exact MCMC output.],

  [8],
  [*Exact inference in structured sequence models* \
  #note[Revisable implementation contract]],
  [Scaled categorical-HMM filtering, smoothing and evidence; joint path MAP versus marginal decisions; dense O(T K²) message cost. Compact Gaussian filtering comparison.],
  [
    - 9.2.1–9.2.6 HMM messages, scaling and path queries
    - Selected 8.1.2 / 8.2.2 Gaussian filtering
  ],
  [],
  [Extend categorical-message logic to real Gaussian time series using the existing Oke PS2 Kalman package notebook. Scaffold conditional means/covariances, model fitting and predictive checks around package calls. Exact data/model depth remains to be frozen; current source and missing-observation repairs are checked in the lecture-local package-feasibility report, not a claim of full hosted execution.],

  [9],
  [*Variational and amortized inference* \
  #note[Revisable implementation contract]],
  [ELBO/reverse KL, Gaussian family restriction, total pathwise gradients and optimizer error. Introduce the shared evidence-to-variational-parameters map; retain CAVI recognition while replacing its numerical sweep.],
  [
    - 10.1.1–10.1.2 Variational criterion
    - 6.3.3 / 6.3.5; 10.2.1.1 Pathwise gradients
    - 10.3.1 Coordinate rule; 10.1.5 amortization
  ],
  [],
  [Fit a Gaussian variational approximation to the accepted Challenger thermal-distress posterior; compare specified predictive queries with Laplace, supplied sampling output and a checked reference. Use the known correlated Gaussian to separate family and optimization error. Diagonal student family versus supplied full-family comparison remains a detailed pedagogical choice. No MCMC-theory handoff to L10.],

  [10],
  [*Deep Neural Networks I: learned representations and images* \
  #note[Revisable implementation contract]],
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

  [11],
  [*Deep Neural Networks II: representing sequence context* \
  #note[Revisable implementation contract]],
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
  [Particle methods for changing hidden states], [Exact sequence calculations in L08; bounded sampling use in L07], [No method for tracking a complex changing state with a cloud of weighted samples (Book 2 Ch. 13).],
  [MRI classification and continuous forecasting], [Real missing-data fitting and package-backed Gaussian sequence extension selected], [Dataset packaging, Gaussian sequence fitting and forecast evaluation remain bounded by one-hour feasibility.],
  [More complex regression and prediction checks], [Common models in L05 and learned image/sequence representations in L10–L11], [No full sparse/hierarchical regression, calibration or guaranteed prediction-interval course.],
  [Larger inference toolkits], [One checked method per main lab], [No general-purpose graph solver or broad variational-family catalogue. General MH/Gibbs/HMC/AIS algorithm competence is deliberately sacrificed for the two neural lectures.],
  [Bayesian neural networks and Gaussian processes], [Fitted image/sequence networks and amortized inference maps], [No separate treatment of uncertainty about network weights or Gaussian-process prediction.],
  [Other generative models], [A variational autoencoder in L12], [No flow, diffusion or adversarial model teaching. These are different ways to learn data distributions and need their own time.],
  [A complete algorithm catalogue], [One working exemplar per lecture, with recurring dataset comparisons where they clarify choices], [Less survey breadth; more ability to explain, execute and diagnose selected techniques.],
  [Every method on a different isolated toy problem], [The Challenger posterior in L07/L09 plus small transparent diagnostics], [Less variety in those notebooks, but a more meaningful comparison of posterior approximations and sampling at fixed task and performance.],
)
