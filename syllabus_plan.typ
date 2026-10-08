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

#note[*Status:* L1 delivered; L2 has an agreed scope; L3--L12 are tentative; L13 is reserved for project presentations / synthesis. Book sections are preparation and support ranges, not a promise to teach every subsection. Book 1 references remain provisional; coverage is not a final reading assignment. Notebook links identify existing worked references to inspect, not code already validated or adopted for this course.]

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
    hdr[Concrete notebook problem and solved reference],
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
  [Joint factorization; conditional independence; Bayes nets; chains, forks and colliders; d-separation / Markov properties; plate notation; graphical models as representations of structural assumptions; selected comparison with undirected models.],
  [
    - 4.1 Graphical-model introduction
    - 4.2.1–4.2.4 Bayes nets; independence
    - 4.2.5–4.2.8 Sampling, inference, learning, plates
    - 4.3.1 Undirected factorization
    - 4.5 Directed vs undirected models
  ],
  [
    - 3.6.1 Graph representation
    - 3.6.2 Graphical inference
  ],
  [*Sprinkler Bayesian network.* Build Cloudy–Rain–Sprinkler–Wet–Slippery, recover the joint factorization, test d-separation, and calculate how evidence of wet grass changes beliefs about rain. Reference: #link("https://github.com/probml/pyprobml/blob/master/notebooks/book1/03/sprinkler_pgm.ipynb")[Murphy’s sprinkler_pgm notebook].],

  [4],
  [*Information, objectives, and optimization* \
  #note[Tentative]],
  [Entropy and cross-entropy; KL divergence and asymmetry; likelihood as KL minimization; forward vs reverse KL; gradients, Jacobians and Hessians as needed; computation graphs / autodiff; first-order methods and stochastic gradient descent. Mutual information is included only if it fits without weakening the mathematical depth.],
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
  [*Iris binary logistic regression from its NLL.* Derive the gradient, check it with PyTorch autodiff, train by minibatch SGD, and compare with scikit-learn and full-batch optimization. Reference: #link("https://github.com/probml/pyprobml/blob/master/notebooks/book1/10/logreg_pytorch.ipynb")[Murphy’s worked PyTorch notebook].],

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
  [*Two-component GMM for Old Faithful eruptions.* Fit Gaussian-mixture weights, means, and covariances by explicit E/M updates; inspect the responsibility assignments and fitted clusters. Reference: #link("https://github.com/kitteltom/old-faithful-EM/blob/main/EM_gaussian_mixture.ipynb")[Old Faithful EM worked notebook].],

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
  [*One-dimensional Bayesian logistic posterior.* Simulate binary observations, evaluate the exact posterior on a grid, calculate the MAP/Laplace approximation, and compare approximate posterior density and moments. Reference: #link("https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/")[Berkeley Stat 238 worked solution (§1)].],

  [7],
  [*Exact inference in structured sequence models* \
  #note[Tentative]],
  [Dynamic programming / message passing; hidden Markov models; forward-backward and Viterbi as exact summation / maximization over exponentially many latent-state sequences; Gaussian filtering as the continuous analogue; selected Kalman filtering if scope permits.],
  [
    - 8.1–8.2 Gaussian filtering; Kalman smoothing
    - 9.1–9.2 Message passing; HMM inference
  ],
  [],
  [*The occasionally dishonest casino HMM.* Generate loaded/fair dice rolls, estimate hidden states by filtering and smoothing, and compare with the Viterbi path. Reference: #link("https://probml.github.io/dynamax/notebooks/hmm/casino_hmm_inference.html")[Dynamax worked inference notebook].],

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
  [*Terrain ruggedness and log-GDP regression.* Use the African/non-African interaction regression to compare full/diagonal Gaussian VI with HMC, including coefficient posteriors and posterior predictions. Reference: #link("https://github.com/probml/pyprobml/blob/master/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb")[Murphy’s Pyro SVI-vs-HMC notebook].],

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
  [*Eight Schools: centered vs noncentered HMC.* Fit the same hierarchical treatment-effect model twice and use divergences and posterior summaries to diagnose the centered parameterization. Reference: #link("https://www.pymc.io/projects/examples/en/latest/diagnostics_and_criticism/Diagnosing_biased_Inference_with_Divergences.html")[PyMC’s solved Eight Schools diagnostic].],

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
  [*Handwritten-digit logistic regression with L1/L2 regularization.* Classify digits 0–4 against 5–9; vary regularization strength and compare L1, L2 and elastic-net coefficient sparsity and test scores. Reference: #link("https://scikit-learn.org/stable/auto_examples/linear_model/plot_logistic_l1_l2_sparsity.html")[scikit-learn's L1/L2 worked example].],

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
  [*Fashion-MNIST MLP classifier.* Train and evaluate a multilayer perceptron with softmax/logit output and cross-entropy loss; inspect test classifications. Reference: #link("https://docs.pytorch.org/tutorials/beginner/basics/quickstart_tutorial.html")[PyTorch Fashion-MNIST worked tutorial].],

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
  [*Convolutional VAE on MNIST.* Fit a VAE encoder and decoder with reconstruction-plus-KL loss; inspect digit reconstructions, generated samples and a two-dimensional latent embedding. Reference: #link("https://github.com/probml/pyprobml/blob/master/notebooks/misc/vae_mnist_pytorch.ipynb")[Murphy’s MNIST VAE PyTorch notebook].],

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

  [Book 2 §§4.3--4.4 detailed MRF / CRF material],
  [Later model-specific use, if any],
  [Do not create graphical-model debt merely because these sections follow Bayes nets numerically.],

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