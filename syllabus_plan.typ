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
  [*Information, objectives, and optimization* \
  #note[Tentative]],
  [Entropy, KL and cross-entropy as objectives; derivatives and stochastic optimization; PyTorch tensor/autograd fundamentals; categorical likelihood and multinomial softmax as a concrete optimization application.],
  [
    - 5.1.3–5.1.8 KL divergence; MLE; Bayes
    - 5.2.4 Cross-entropy; perplexity
    - 6.1–6.2 Optimization; autodiff
    - 6.3.1–6.3.3 Stochastic gradient optimization
  ],
  [
    - 6.1.1–6.1.5 Entropy; cross-entropy
    - 6.2.6 Forward vs reverse KL
    - 7.8 Matrix calculus
    - 8.1–8.2 Optimization; gradient descent
    - 8.3.1 Newton’s method
    - 8.4.1–8.4.3 Stochastic gradient descent
  ],
  [*Three-class Iris softmax regression.* Fit all three species using a linear classifier with multinomial negative log likelihood; examine probabilities and errors. #link("https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb")[Batra’s solved PyTorch notebook]. *Skills:* tensor shapes, autograd, loss functions, optimizer loop; verify fit against scikit-learn. *Boundary:* Lecture teaches gradient objectives, not the completed Iris solution.],

  [5],
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

  [6],
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

  [7],
  [*Exact inference in structured sequence models* \
  #note[Tentative]],
  [Dynamic programming / message passing; hidden Markov models; forward-backward and Viterbi as exact summation / maximization over exponentially many latent-state sequences; Gaussian filtering as the continuous analogue; selected Kalman filtering if scope permits.],
  [
    - 8.1–8.2 Gaussian filtering; Kalman smoothing
    - 9.1–9.2 Message passing; HMM inference
  ],
  [],
  [*Kalman prediction on a time series (preferred, subject to review).* Model daily website traffic with a linear Gaussian state-space model and compare fitted forecasts. Reference: Oke CEE 790A PS2 questions and instructor solution notebook (in the supplied problem-set archive). *Skill:* express and evaluate sequential filtering in NumPy; no JAX or Dynamax. *Alternative:* implement an HMM inference task in NumPy if lecture scope centers on discrete message passing.],

  [8],
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

  [9],
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

  [10],
  [*Classical probabilistic prediction: GLMs and regularization* \
  #note[Tentative]],
  [Binary and multinomial logistic regression; linear / generalized linear models; MLE / MAP; ridge and lasso as structural assumptions / priors; calibration and posterior predictive uncertainty where appropriate. Generative-vs-discriminative classification is included only if it earns space.],
  [
    - 14.2 Predictive scoring; calibration
    - 15.1 GLM form; links; estimation
    - 15.2 Linear regression; priors
    - 15.3 Logistic regression; uncertainty
  ],
  [
    - 9.1–9.4 LDA; naive Bayes; classifier types
    - 10.2–10.3 Logistic regression
    - 11.3–11.4 Ridge; lasso
  ],
  [*Regularized digit classification.* Classify digits 0–4 versus 5–9, compare L1/L2 coefficient structure and accuracy against held-out labels. #link("https://scikit-learn.org/stable/auto_examples/linear_model/plot_logistic_l1_l2_sparsity.html")[scikit-learn’s worked example]. *Skill:* estimator/pipeline interface, train/test separation, regularization and evaluation. *Alternative:* Oke’s solved Poisson-regression problem if GLMs are prioritized.],

  [11],
  [*Neural networks as probabilistic conditional models* \
  #note[Tentative]],
  [MLPs; nonlinear function approximation; activations and depth; backpropagation / reverse-mode autodiff; optimization and initialization; regularization; softmax / cross-entropy viewed as a probabilistic conditional model rather than a separate conceptual framework.],
  [
    - 16.1–16.2 Neural-network building blocks
    - 16.3 MLPs; CNNs; autoencoders; sequences
  ],
  [
    - 13.2 MLPs; nonlinearities
    - 13.3 Backpropagation
    - 13.4 Network training
    - 13.5.1–13.5.4 Early stopping; weight decay; dropout
    - 13.5.6 SGD regularization
  ],
  [*Heteroskedastic nonlinear regression with a neural network.* Fit a model with separate conditional mean and variance outputs, then inspect changing predictive uncertainty. #link("https://github.com/probml/pyprobml/blob/master/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb")[Murphy’s worked TFP notebook]. *Skill:* generalize L4 PyTorch knowledge to nn.Module, nonlinear layers and probabilistic neural output. *Adaptation:* port reference’s TensorFlow code to PyTorch.],

  [12],
  [*Variational autoencoders: neural latent-variable models* \
  #note[Tentative final substantive topic]],
  [Latent-variable generative model; encoder / decoder networks; amortized variational posterior; ELBO; reparameterization; reconstruction and KL terms; posterior collapse as a failure mode; VAE as a synthesis of graphical models, information objectives, optimization, VI and neural networks.],
  [
    - 21.1–21.2 VAE model; ELBO; inference network
    - 21.3 VAE variants
    - 21.4 Posterior collapse
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
  [L8--L10 as applications require],
  [Substantively useful, but not needed as an early stand-alone statistics block given student background.],

  [Book 1 Ch. 7 EVD / SVD material],
  [Only if a later dimensionality-reduction / factor-model topic requires it],
  [Treat basic linear algebra as prerequisite; backfill spectral machinery only when it earns its place.],

  [Book 2 §2.5 transformations of random variables],
  [L8 / L12 or a later flow / reparameterization topic if needed],
  [Important for change-of-variables models, but not an early prerequisite for the present route.],

  [Book 2 §4.4 CRFs and advanced MRF material],
  [Later model-specific use, if any],
  [L3 now prioritizes core MRF factorization and Ising models; detailed CRFs and specialized MRF machinery are optional.],

  [Book 2 §2.7 non-KL divergences and IPMs],
  [Modern generative / two-sample methods if needed],
  [KL is core early; MMD / broader divergence families should return only when an application needs them.],

  [Book 2 Ch. 13 sequential Monte Carlo],
  [No committed lecture],
  [A legitimate inference method, but VI + MCMC + exact message passing may provide enough methodological diversity for this course.],

  [Book 2 Ch. 14 predictive-model overview],
  [Selective use in L10; broader treatment only if time permits],
  [Proper scoring, calibration and conformal prediction are valuable, but no extra lecture slot is committed now.],

  [Book 2 Chs. 17--19],
  [Open / future decision],
  [Bayesian neural networks, Gaussian processes and distribution shift are valuable possible extensions; the current plan preserves the VAE slot and leaves later adjustment possible.],
)