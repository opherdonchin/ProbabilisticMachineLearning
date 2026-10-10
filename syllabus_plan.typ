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

This is a working curriculum map for *Probabilistic Machine Learning: Advanced Topics*. It is intended to guide lecture scoping and later transfer into the formal syllabus, not to freeze the detailed content of later lectures.

The course is organized around four recurring ideas:

- a machine-learning task can be expressed through a joint probability model and a query;
- the structure of the joint distribution and the required integral / expectation / decision determine the computational problem;
- practical methods trade simplifying structural assumptions, approximation, and brute-force computation;
- students should leave with a useful collection of modern tools, including both classical probabilistic methods and network-based models.

*Book 2 is the primary curricular spine.* Book 1 is supplementary rather than co-equal: a Book 1 section is retained only when it supplies necessary background, offers a more pedagogical development, gives a useful worked example, or provides an alternative treatment that may materially improve the lecture.

#note[*Status:* L1 delivered; L2 has an agreed scope; L3--L12 are tentative; L13 is reserved for project presentations / synthesis. Book sections are preparation and support ranges, not a promise to teach every subsection. Book 1 references remain provisional; coverage is not a final reading assignment. Notebook applications with multiple candidates remain provisional, and none of the outside implementations has been runtime-validated for this course.]

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
  [*Graphical models* \
  #note[Tentative]],
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
  [*Ising image restoration (preferred).* Recover a corrupted binary image using local Ising interactions and conditional probabilities; analyze smoothness versus fidelity. #link("https://github.com/probml/pyprobml/blob/master/notebooks/book2/04/ising_image_denoise_demo.ipynb")[Murphy’s worked denoising code]. *Skill:* Implement local graphical-model computations with NumPy; compare recovered images. *Caveat:* Reference uses Gibbs and mean-field updates introduced formally later; scaffold the conditional rule. *Alternative:* ALARM CPT fitting if L3 scope changes.],

  [4],
  [*Information theory: dependence, communication, and representations* \
  #note[Tentative; alternative progression under review]],
  [Entropy and cross-entropy; KL as a measure of discrepancy; mutual information as KL between joint and independent marginals; conditional information and data processing; operational coding example; brief rate-distortion connection to later VAEs.],
  [
    - 5.1.3–5.1.8 KL; relation to MLE and Bayes
    - 5.2.1–5.2.4 Entropy and cross-entropy
    - 5.3.1–5.3.4 Mutual information; data processing; sufficient statistics
    - 5.4.1–5.4.2 Source coding and rate-distortion (selected)
    - 5.5 Channel coding (selected concrete example)
    - 5.6 Information bottleneck (orientation only; return L12)
  ],
  [
    - 6.1 Entropy and cross-entropy
    - 6.2.6 Forward vs reverse KL (possible)
  ],
  [*Noisy-channel decoding and information.* Enumerate a simple parity-check code and noisy channel; calculate entropy/mutual information and posterior decoding performance as noise changes. Reference: #link("https://github.com/probml/pyprobml/blob/master/notebooks/book2/05/error_correcting_code_demo.ipynb")[Murphy's worked channel-coding example]. *Skill:* finite probability tables, conditional probabilities and information quantities with NumPy. *Alternative:* source-coding / code-length comparison. *Choice and runtime remain unvalidated.*],

  [5],
  [*Optimization of probabilistic models* \
  #note[Tentative; alternative progression under review]],
  [Negative log likelihood and cross-entropy as objectives; categorical/softmax GLM as a concrete model; gradients and reverse-mode automatic differentiation; mini-batch stochastic optimization; PyTorch computational graphs, loss and training loops; light MAP/regularization bridge.],
  [
    - 6.1–6.2 Differentiable optimization and autodiff
    - 6.3.1–6.3.3 SGD and finite-sum objectives
    - 15.1.1–15.1.3 GLM form and likelihood estimation (selected)
    - 15.3.2 Multinomial logistic regression
  ],
  [
    - 7.8 Matrix calculus
    - 8.1–8.2 Gradient methods
    - 8.4.1–8.4.3 SGD
    - 10.2–10.3 Logistic-regression learning (selected)
  ],
  [*Three-class Iris softmax regression in PyTorch.* Fit a categorical likelihood using tensor operations, autodiff and a visible optimization loop; inspect probabilities, loss and held-out error. Reference: #link("https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb")[Batra's worked softmax notebook]. *Skill:* PyTorch tensors, gradients and training. *Boundary:* save the full three-species fit for the lab; defer stochastic-distribution gradient estimators to VI and VAEs.],

  [6],
  [*Latent-variable learning and EM* \
  #note[Tentative]],
  [Mixture models; latent assignments; complete vs observed likelihood; EM as alternating inference and optimization; expected sufficient statistics; relation to exponential-family moment matching.],
  [
    - 6.5.1–6.5.6 Bound optimization; EM
    - 28.2 Mixture models
  ],
  [
    - 3.5 Gaussian and Bernoulli mixtures
    - 8.7.1–8.7.3 Bound optimization; EM for GMMs
  ],
  [*Two strong application candidates:* (A) *EM for missing Gaussian measurements*: estimate unknown mean/covariance from incomplete records using conditional first and second moments; #link("https://github.com/probml/pyprobml/blob/master/notebooks/book2/opt/gauss_imputation_em_demo.ipynb")[Murphy’s worked code]. (B) *MRI tissue segmentation with GMM-EM*: infer latent classes of voxels from intensity; #link("https://github.com/huytrnq/ExpectationMaximization/blob/main/Exp_MutilModals.ipynb")[worked MRI notebook]. *Skills:* implement E/M steps with NumPy/SciPy and check against an independent package fit. *Decision:* choose application when scoping L5.],

  [7],
  [*Inference as computation* \
  #note[Tentative]],
  [Posterior, marginal, predictive and expected-value queries as sums / integrals; exact vs approximate inference; MAP; grid and Laplace approximation; variational inference, MCMC and SMC as contrasting strategies; how structural assumptions and computational budget determine the method.],
  [
    - 7.1–7.2 Inference queries; latent patterns
    - 7.3 Exact inference
    - 7.4.1–7.4.7 Approximate inference
    - 7.5 Evaluating inference
  ],
  [],
  [*One-dimensional Bayesian logistic posterior (retain).* Simulate binary responses; obtain a grid-reference posterior and compare MAP and Laplace approximations and moments. #link("https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/")[Berkeley Stat 238 worked solution, §1]. *Skill:* construct a numerical gold standard with SciPy to validate approximation.],

  [8],
  [*Exact inference in structured sequence models* \
  #note[Tentative]],
  [Dynamic programming / message passing; hidden Markov models; forward-backward and Viterbi as exact summation / maximization over exponentially many latent-state sequences; Gaussian filtering as the continuous analogue; selected Kalman filtering if scope permits.],
  [
    - 8.1–8.2 Gaussian filtering; Kalman smoothing
    - 9.1–9.2 Message passing; HMM inference
  ],
  [],
  [*Kalman prediction on a time series (preferred, subject to review).* Model daily website traffic with a linear Gaussian state-space model and compare fitted forecasts. Reference: Oke CEE 790A PS2 questions and instructor solution notebook (in the supplied problem-set archive). *Skill:* express and evaluate sequential filtering in NumPy; no JAX or Dynamax. *Alternative:* implement an HMM inference task in NumPy if lecture scope centers on discrete message passing.],

  [9],
  [*Variational inference and amortized inference* \
  #note[Tentative]],
  [Variational approximation as optimization; ELBO; mean-field structure; coordinate ascent; black-box / stochastic VI; reparameterization; amortized inference as learning a map from observations to approximate posteriors.],
  [
    - 10.1 Variational objectives; amortization
    - 10.2 Gradient-based VI
    - 10.3 Coordinate-ascent VI
    - 10.4 Structured variational posteriors
  ],
  [],
  [*Variational posterior for terrain-ruggedness/GDP regression.* Compare VI against a sampling reference, focusing on approximation assumptions and posterior predictions. #link("https://github.com/probml/pyprobml/blob/master/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb")[Murphy’s Pyro worked example]. *Skill:* optimize and diagnose a variational approximation using familiar PyMC or PyTorch; Pyro is optional, not a required new framework. *Adaptation:* reference is Pyro and needs pruning.],

  [10],
  [*Monte Carlo and MCMC* \
  #note[Tentative]],
  [Monte Carlo approximation of integrals; proposal-based sampling; Metropolis-Hastings; Gibbs sampling; Hamiltonian Monte Carlo; diagnostics and the relation between sampling cost, posterior geometry and effective information.],
  [
    - 11.1–11.2 Monte Carlo integration
    - 11.4–11.5 Rejection; importance sampling
    - 12.1–12.3 Metropolis-Hastings; Gibbs
    - 12.5 Hamiltonian Monte Carlo
  ],
  [],
  [*Explore a multimodal Gaussian-mixture target with MCMC.* Implement/tune Metropolis proposals, examine transitions between modes, compare estimates of an expectation and their Monte Carlo error. #link("https://github.com/probml/pyprobml/blob/master/notebooks/book2/12/mcmc_gmm_demo.ipynb")[Murphy’s worked sampler comparison]. *Skill:* reason about sampler mechanics, not just run NUTS or inspect R-hat; builds beyond the undergraduate PyMC/Bambi/ArviZ experience.],

  [11],
  [*Neural networks as probabilistic conditional models* \
  #note[Tentative]],
  [MLPs as nonlinear probabilistic conditional models; architecture, depth and regularization; reuse of L05 autodiff/SGD; selected priors/penalties and calibration/proper scoring as extensions of the earlier GLM example.],
  [
    - 16.1–16.2 Neural-network building blocks
    - 16.3 MLPs; selected other architectures
    - 14.2 Predictive scoring and calibration (selected)
    - 15.2.4–15.2.7 Regression priors and penalties (selected)
  ],
  [
    - 11.3–11.4 Ridge and lasso as optimization / prior choices (selected)
    - 13.2 MLPs; nonlinearities
    - 13.3 Backpropagation
    - 13.4 Network training
    - 13.5.1–13.5.4 Early stopping; weight decay; dropout
    - 13.5.6 SGD regularization
  ],
  [*Heteroskedastic nonlinear regression with a neural network.* Fit a model with separate conditional mean and variance outputs, then inspect changing predictive uncertainty. #link("https://github.com/probml/pyprobml/blob/master/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb")[Murphy’s worked TFP notebook]. *Skill:* generalize L5 PyTorch knowledge to nn.Module, nonlinear layers and probabilistic neural output. *Adaptation:* port reference’s TensorFlow code to PyTorch.],

  [12],
  [*Variational autoencoders: neural latent-variable models* \
  #note[Tentative final substantive topic]],
  [Latent-variable generative model; encoder/decoder and amortized variational posterior; ELBO and reparameterization; reconstruction versus KL, rate-distortion and mutual-information perspectives; β-VAE and posterior collapse. Information bottleneck/InfoVAE are selected extensions, not mandatory additional derivations.],
  [
    - 21.1–21.2 VAE model; ELBO; inference network
    - 21.3.1–21.3.2 β-VAE and InfoVAE (selected)
    - 21.4 Posterior collapse
    - 5.4.2, 5.6 Rate-distortion / information bottleneck (selected return)
  ],
  [],
  [*Variational autoencoder.* Primary candidate: fit a β-VAE to metropolitan mobility/urban-form indicators; interpret latent dimensions (Oke PS4 worked notebook in supplied archive). Fallback: #link("https://github.com/probml/pyprobml/blob/master/notebooks/misc/vae_mnist_pytorch.ipynb")[Murphy’s MNIST PyTorch VAE]. *Skills:* encoder/decoder, reparameterization, reconstruction + KL loss, latent traversals. *Decision:* mobility data prep and student runtime must be checked.],

  [13],
  [*Project presentations and course synthesis*],
  [Student project presentations connecting probabilistic assumptions, computation, prediction, evaluation, uncertainty and scientific interpretation. No additional substantive lecture topic is committed at this stage.],
  [],
  [],
  [No notebook — project presentations and synthesis.],
)

= Deferred-material watchlist

The plan is intended to avoid an invisible backlog. Material below the moving Book 2 boundary should normally be classified as either *skipped/background* or *deferred to a specific later use*.

#table(
  columns: (57mm, 52mm, 1fr),
  inset: 4pt,
  stroke: 0.45pt + rule,
  table.header(
    hdr[Deferred material],
    hdr[Likely return point],
    hdr[Reason],
  ),

  [Selected Book 2 Ch. 3: hierarchical priors / model checking / empirical Bayes],
  [L9--L11 as applications require],
  [Substantively useful, but not needed as an early stand-alone statistics block given student background.],

  [Book 1 Ch. 7 EVD / SVD material],
  [Only if a later dimensionality-reduction / factor-model topic requires it],
  [Treat basic linear algebra as prerequisite; backfill spectral machinery only when it earns its place.],

  [Book 2 §2.5 transformations of random variables],
  [L9 / L12 or a later flow / reparameterization topic if needed],
  [Important for change-of-variables models, but not an early prerequisite for the present route.],

  [Book 2 §4.4 CRFs and advanced MRF material],
  [Later model-specific use, if any],
  [L3 now prioritizes core MRF factorization and Ising models; detailed CRFs and specialized MRF machinery are optional.],

  [Book 2 §2.7 non-KL divergences and IPMs],
  [Modern generative / two-sample methods if needed],
  [KL is core in L04; MMD / broader divergence families should return only when an application needs them.],

  [Book 2 §§6.3.4–6.4 and 6.6–6.9 advanced optimization],
  [Score-function/reparameterization estimators in L9/L12; other topics uncommitted],
  [Natural gradients, Bayesian optimization, derivative-free optimization, optimal transport and submodularity are not prerequisites for the course's current core trajectory.],

  [Book 2 Ch. 13 sequential Monte Carlo],
  [No committed lecture],
  [A legitimate inference method, but VI + MCMC + exact message passing may provide enough methodological diversity for this course.],

  [Book 2 Ch. 14 predictive-model overview],
  [Selected §14.2 in L11; broader treatment only if time permits],
  [Proper scoring, calibration and conformal prediction are valuable, but no extra lecture slot is committed now.],

  [Book 2 Chs. 17--19],
  [Open / future decision],
  [Bayesian neural networks, Gaussian processes and distribution shift are valuable possible extensions; the current plan preserves the VAE slot and leaves later adjustment possible.],
)