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

This plan explains the proposed teaching sequence without assuming familiarity with later book chapters. The instructor agreed to the 13-meeting order, the simpler image algorithm in L03 and the lighter coding example in L04. Other detailed choices remain proposals. Each row describes the problem, classroom content and student task before giving reading references. See #link("Lectures/course_architecture_scope/questions_and_hesitations.md")[teaching choices] and #link("Lectures/course_architecture_scope/architecture_audit.md")[course explanation].
The course is organized around four recurring ideas:

- a machine-learning task can be expressed through a joint probability model and a query;
- the structure of the joint distribution and the required integral / expectation / decision determine the computational problem;
- practical methods trade simplifying structural assumptions, approximation, and brute-force computation;
- students should leave with a useful collection of modern tools, including both classical probabilistic methods and network-based models.

*Book 2 is the primary curricular spine.* Book 1 is supplementary rather than co-equal: a Book 1 section is retained only when it supplies necessary background, offers a more pedagogical development, gives a useful worked example, or provides an alternative treatment that may materially improve the lecture.

#note[*Status:* L01 material is recorded as delivered; L02 is agreed. L03–L12 are proposed scopes with independent review records. The instructor selected two simpler choices; later choices still await review. Future notebook implementations and student timings have not been tested.]

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
  [*Graphical models: local calculations in a large model* \
  #note[Proposed teaching scope]],
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
  [Calculate a pixel update, check it by listing every configuration of a tiny image, and use a supplied program to repeat updates on a larger image. *Skill:* Turn a probability model into a local calculation and check it against an exact small example. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/04/ising_image_denoise_demo.ipynb")[Inspected source]. *Limit:* The instructor agreed to this simpler method. It differs from Murphy’s algorithm and does not promise the best possible image or posterior uncertainty. All course adaptations remain unrun.],

  [4],
  [*Information theory: what survives a noisy message?* \
  #note[Proposed teaching scope]],
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
  [List the eight possible received three-bit strings. Calculate message probabilities, information and best-guess error; explain ambiguous results. Reference a stronger five-bit code without implementing it. *Skill:* Build and check a small probability table, and distinguish useful information from a guaranteed correct decision. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/05/error_correcting_code_demo.ipynb")[Inspected source]. *Limit:* The instructor chose the lighter example. One changed bit is detected but cannot always be located or corrected. The stronger code is reference material. All course adaptations remain unrun.],

  [5],
  [*Learning models: regression, derivatives and parameter updates* \
  #note[Proposed teaching scope]],
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
  [Fit probabilities for all three Iris species in PyTorch. Compare a hand-calculated derivative with the software result, update parameters repeatedly and evaluate new observations. *Skill:* Check automatic derivatives and carry out a simple fit/evaluation loop in PyTorch. #link("https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb")[Inspected source]. *Limit:* First PyTorch use makes this meeting tight. Data preparation and plotting are supplied; the lecture does not teach a large software framework. All course adaptations remain unrun.],

  [6],
  [*Learning with missing data: expectation-maximization* \
  #note[Proposed teaching scope]],
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
  [Complete the expected values and second moments needed to fit a Gaussian to incomplete measurements. Use a supplied update loop and inspect likelihood and reconstruction. *Skill:* Use uncertainty about missing values in a parameter update rather than merely fill blanks with best guesses. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/opt/gauss_imputation_em_demo.ipynb")[Inspected source]. *Limit:* This replaces the candidate MRI tissue-classification lab. Class-assignment probabilities are explained briefly; a second mixture-model fit is not required. All course adaptations remain unrun.],

  [7],
  [*Posterior approximation: compare a grid with a Gaussian shortcut* \
  #note[Proposed teaching scope]],
  [Use a one-parameter logistic model to compare a posterior computed on a fine grid with a Gaussian fitted near its peak: the Laplace approximation. Check the grid’s range and spacing, and compare posterior summaries and predictions. Explain why the most likely parameter depends on how we express it.],
  [
    - 7.1–7.3 What posterior questions require: short introduction
    - Selected 7.4.1–7.4.3 Most likely parameter, grid and Gaussian shortcut
    - Selected 7.5 Checking approximation quality
    - Selected 15.3.5–15.3.6 One-parameter logistic example
  ],
  [],
  [Construct a numerical posterior reference, change its range and spacing, then compare the Gaussian shortcut and predictions. Solver and plotting helpers are supplied. *Skill:* Check a numerical reference and assess the consequences of an approximation. #link("https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/")[Inspected source]. *Limit:* The small example is chosen for checkability. A finite grid is also an approximation, not an automatically exact answer. All course adaptations remain unrun.],

  [8],
  [*Sequences: infer hidden states using repeated calculations* \
  #note[Proposed teaching scope]],
  [Infer whether a fair or loaded die produced each observation: a hidden Markov model. Derive repeated forward/backward calculations using earlier and later observations, prevent numerical underflow and distinguish the best whole history from the most likely state at each time. Briefly apply Gaussian conditioning to Kalman filtering.],
  [
    - 9.2.1–9.2.5 Hidden-state calculations and scaling
    - 9.2.6 Whole history versus separate state decisions
    - Selected 8.1.2 / 8.2.2 Gaussian filtering: short application
  ],
  [],
  [Implement the central hidden-state calculations in NumPy. Check a short sequence by listing its histories, including a test where transition directions matter. Simulation and plots are supplied. *Skill:* Reuse partial calculations to avoid listing an exponentially large set of hidden histories. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/casino_hmm.ipynb")[Inspected source]. *Limit:* The main lab is discrete hidden-state inference. The previously preferred continuous Kalman forecasting lab is not included. All course adaptations remain unrun.],

  [9],
  [*Approximate a posterior by fitting a simpler distribution* \
  #note[Proposed teaching scope]],
  [Fit a simpler probability distribution to a posterior: variational inference. Show what an independent-coordinate Gaussian loses when the posterior has correlations. Derive how to differentiate a random-sample calculation and briefly apply coordinate-by-coordinate updates. Reuse L06’s probability bound.],
  [
    - 10.1.1–10.1.2 Fitting a restricted distribution
    - 6.3.3 / 6.3.5; 10.2.1.1 Derivatives through Gaussian draws
    - 6.3.4 Another gradient estimator: statement only
    - 10.3.1 Coordinate updates; 10.1.5 learned inference: introduction only
  ],
  [],
  [Fit an independent-coordinate Gaussian to a regression posterior with a known exact answer. Compare fitting error, the limitations of the chosen distribution and predictive uncertainty. *Skill:* Compute derivatives through random draws and check an approximation against a known answer. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb")[Inspected source]. *Limit:* Uses controlled data and known noise. The real economic-data example and sampling comparison are replaced; no new Pyro software is required. All course adaptations remain unrun.],

  [10],
  [*Sampling: correct transitions and unreliable short runs* \
  #note[Proposed teaching scope]],
  [Estimate expectations by averaging samples. Introduce a chain whose next sample depends on the previous one, then derive the Metropolis–Hastings accept/reject rule. Explain why preserving the target distribution is different from exploring it quickly, and why error depends on the quantity being estimated.],
  [
    - 11.2–11.2.2 Averages and sampling error
    - 2.6.4; 12.2.1–12.2.2 Invariant distribution and acceptance rule
    - 12.3.1–12.3.2 Conditional-coordinate sampling: brief derivation
    - Selected 12.6.3 Dependent-sample error; 12.5.3 Hamiltonian mechanics only
  ],
  [],
  [Complete a NumPy accept/reject sampler. Compare proposal sizes and starting points on a distribution with two separated peaks; check the mean and the probability of a value greater than zero against known values. *Skill:* Check a sampling rule and diagnose inadequate exploration before trusting an estimate. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb")[Inspected source]. *Limit:* Helper diagnostics are supplied. Gibbs updates are explained briefly. Hamiltonian Monte Carlo uses derivatives for directed moves but is not fully derived or implemented. All course adaptations remain unrun.],

  [11],
  [*Neural prediction: learn a mean and a noise level* \
  #note[Proposed teaching scope]],
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
  [Fit one small nonlinear Gaussian model and compare it with a supplied fixed-noise model on new observations. Inspect predicted noise and intervals. *Skill:* Build a probability prediction with a neural network and interpret its uncertainty correctly. #link("https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb")[Inspected source]. *Limit:* Intervals describe observation noise conditional on fitted weights. They do not include a Bayesian posterior over weights. One CPU fit and prepared fallback still need testing. All course adaptations remain unrun.],

  [12],
  [*Variational autoencoders: learn a compact hidden description* \
  #note[Proposed teaching scope]],
  [Learn one network that describes observations with hidden coordinates and another that predicts observations from them: a variational autoencoder. Reuse the probability bound, sample derivatives and neural likelihoods. Study the reconstruction/penalty tradeoff and why a penalty value alone does not measure useful information or reveal unique causes.],
  [
    - Selected 21.1–21.2 Model, inference network and training objective
    - 21.3.1 Changing the penalty weight
    - Selected 5.4.2 Reconstruction/information tradeoff
    - Selected 21.4 When the model ignores hidden coordinates
  ],
  [],
  [Complete a small mobility-data model and one joint training run. Use prepared comparison runs to study reconstruction and hidden descriptions under different penalty strengths. *Skill:* Combine two networks in one probability model and check how its likelihood and penalty are scaled. #link("Lectures/course_architecture_scope/source_inspection.md")[Instructor mobility source]. *Limit:* Uses 19 measurements and four hidden coordinates. Data access, prepared comparisons and CPU runtime remain untested. Patterns are descriptive, not identified causal factors. All course adaptations remain unrun.],

  [13],
  [*Project presentations and course synthesis*],
  [Student project presentations connecting probabilistic assumptions, computation, prediction, evaluation, uncertainty and scientific interpretation. No additional substantive lecture topic is committed at this stage.],
  [],
  [],
  [No notebook — project presentations and synthesis.],
)

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
