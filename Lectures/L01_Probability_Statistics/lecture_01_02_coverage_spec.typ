#set document(
  title: "Advanced Statistics 2027-1 — Lecture 1 continuation and Lecture 2 coverage specification",
  author: "Opher Donchin / ChatGPT draft",
)
#set page(margin: 1.75cm)
#set text(size: 10.5pt)
#set heading(numbering: "1.1")
#set math.equation(numbering: "(1)")
#set figure(numbering: "1")

#let figplaceholder(title, detail) = rect(
  width: 100%,
  height: 4.0cm,
  stroke: rgb("b8b8b8"),
  radius: 4pt,
  inset: 10pt,
)[
  #align(center + horizon)[
    #block(width: 90%)[
      #strong(title)
      #parbreak()
      #text(size: 9pt, fill: rgb("555555"))[#detail]
    ]
  ]
]

#let coverage(title, source, use, include, skip, density) = block(
  inset: 8pt,
  radius: 4pt,
  stroke: rgb("d0d0d0"),
  fill: rgb("fbfbfb"),
)[
  #strong(title)
  #parbreak()
  #strong[Source coverage:] #source
  #parbreak()
  #strong[Use in lecture:] #use
  #parbreak()
  #strong[Equations / figures to include:] #include
  #parbreak()
  #strong[Skip or reserve:] #skip
  #parbreak()
  #strong[Slide-density target:] #density
]

= Purpose and design decision

This document converts the proposed continuation of Lecture 1 into a detailed implementation specification, and separates the material that would overload Lecture 1 into a new Lecture 2. It is written as a planning document for extending `slide_deck.typ`, not as a finished slide deck.

The main structural decision is:

- Lecture 1 continues after the current `= Classes of machine learning problems` heading and ends with linear Gaussian systems.
- Lecture 2 covers likelihood, MLE, ERM, regularization/MAP, exponential families, sufficient statistics, and moment matching.

This split keeps Lecture 1 mathematically coherent: task taxonomy, moments, categorical/softmax, covariance, multivariate Gaussian conditioning, then linear Gaussian systems. Lecture 2 then becomes the likelihood-and-exponential-family infrastructure lecture.

== Source assumptions

The Lecture 1 reading packet assigns Book 1 Chapter 1; Book 1 sections 2.1--2.6, 3.1--3.3, 3.6, 4.1--4.3, and 4.5--4.7; and Book 2 Chapter 1 plus sections 2.3--2.4 and selected statistics sections. The specification below treats those assigned sections as the source universe, but explicitly uses only parts of many of them.

The associated undergraduate Bayesian statistics material already covered core Bayesian vocabulary, conditional probability, Bayes' rule, likelihood, the Beta--Binomial example, conjugacy, posterior prediction, PyMC, MCMC, hierarchical models, linear models, GLMs, model comparison, and Bayesian workflow. Therefore, Lecture 1 should reactivate those ideas only where needed.

== Slide-pattern constraint

The existing deck pattern is concept-first, with a modest equation load per slide. A typical live slide should contain one conceptual move and at most one or two central equations. Long derivations belong in speaker notes, handouts, or reserve slides.

#pagebreak()

= Lecture 1 — continuation after `Classes of machine learning problems`

== Lecture 1 high-level arc

Lecture 1 should move from a map of ML problem classes to the probability objects needed to make probabilistic ML precise.

1. Classes of machine-learning problems.
2. Moments and conditional moments.
3. Categorical, multinomial, and softmax.
4. Dirac delta and empirical distribution.
5. Covariance, correlation, and dependence.
6. Multivariate Gaussian and conditioning.
7. Linear Gaussian systems.

The endpoint is not MLE or the exponential family. The endpoint is the first reusable inference machine: Gaussian conditioning in a linear Gaussian model.

== L1.1 Classes of machine-learning problems

#coverage(
  [L1.1 Classes of machine-learning problems],
  [Book 1 §1.2.2 is used only for classification/regression contrast. Book 1 §1.2.3 is used only for train/test generalization. Book 1 §§1.3--1.4 are used only as a taxonomy of unsupervised learning and reinforcement learning. Book 1 §1.5 is used only for dataset examples. Book 2 Chapter 1 is used only for framing probabilistic ML.],
  [Orientation, not method development. The lecture should not teach decision trees, neural networks, self-supervised learning methods, reinforcement learning, or dataset engineering here.],
  [Use @eq:l1-supervised-data, @eq:l1-classification-output, @eq:l1-regression-output, @eq:l1-train-loss, @eq:l1-test-loss, @eq:l1-unsupervised-data, @eq:l1-unsupervised-density, @eq:l1-latent-model, and @eq:l1-policy. Use @fig:l1-task-taxonomy, @fig:l1-classification-regression, @fig:l1-latent-structure, and @fig:l1-datasets-gallery.],
  [Skip the detailed Iris decision-tree rule from Book 1 Eq. 1.1 as live content; it has already served its purpose earlier in the deck. Skip detailed ERM derivation from Book 1 Eqs. 1.2--1.6 until Lecture 2. Skip logistic regression equations from Book 1 Eqs. 1.8--1.15 until later. Skip polynomial regression and detailed overfitting figures.],
  [6--8 slides. One taxonomy slide, one classification/regression slide, one generalization slide, one unsupervised slide, one latent-structure slide, one RL/out-of-scope slide, one dataset-gallery slide.]
)

Suggested equations for this section:

$
D = { (x_n, y_n) : n = 1, dots, N }
$ <eq:l1-supervised-data>

$
y in {1, dots, C}
$ <eq:l1-classification-output>

$
y in RR
$ <eq:l1-regression-output>

$
L(theta; D_("train")) = frac(1, |D_("train")|) sum_((x,y) in D_("train")) ell(y, f(x; theta))
$ <eq:l1-train-loss>

$
L(theta; D_("test")) = frac(1, |D_("test")|) sum_((x,y) in D_("test")) ell(y, f(x; theta))
$ <eq:l1-test-loss>

$
D = { x_n : n = 1, dots, N }
$ <eq:l1-unsupervised-data>

$
p(x)
$ <eq:l1-unsupervised-density>

$
z_n tilde p(z), quad x_n | z_n tilde p(x | z_n, theta)
$ <eq:l1-latent-model>

$
a = pi(x)
$ <eq:l1-policy>

Suggested figures:

#figure(
  figplaceholder(
    [Task taxonomy map],
    [A compact visual map: supervised prediction, unsupervised discovery, self-supervised pretext tasks, and reinforcement-learning action. This should be a landscape slide rather than a detailed methods slide.]
  ),
  caption: [Task taxonomy map for Lecture 1.]
) <fig:l1-task-taxonomy>

#figure(
  figplaceholder(
    [Classification versus regression outputs],
    [Side-by-side miniature: Iris-style class labels versus real-valued regression target. Use the same visual density as the existing Iris slides.]
  ),
  caption: [Classification and regression as two supervised-output types.]
) <fig:l1-classification-regression>

#figure(
  figplaceholder(
    [Latent structure behind observations],
    [Minimal graph or schematic: latent variable z produces observed x. Use this to prepare mixtures, PCA, factor models, VAEs, and clustering.]
  ),
  caption: [Latent-variable view of unsupervised discovery.]
) <fig:l1-latent-structure>

#figure(
  figplaceholder(
    [Datasets gallery],
    [Small labeled thumbnails or schematic icons: Iris, MNIST/Fashion-MNIST, CIFAR/ImageNet, and text/IMDB. This is a recognition slide, not a content slide.]
  ),
  caption: [Dataset landmarks to recognize, not to analyze in detail.]
) <fig:l1-datasets-gallery>

== L1.2 Moments, conditional moments, and why summaries are not enough

#coverage(
  [L1.2 Moments and conditional moments],
  [Book 1 §2.2.5 is used selectively. Use expectation, variance, total expectation, and total variance. The previous undergraduate course covered means and variances, but not necessarily under the terminology of moments and conditional moments.],
  [Teach the terminology because it will reappear in Gaussian conditioning, hierarchical models, mixtures, posterior prediction, and exponential-family moment matching.],
  [Use @eq:l1-expectation-cont, @eq:l1-expectation-disc, @eq:l1-expectation-linear-affine, @eq:l1-expectation-linear-sum, @eq:l1-variance, @eq:l1-variance-alt, @eq:l1-second-moment, @eq:l1-total-expectation, and @eq:l1-total-variance. Use @fig:l1-conditional-moment and @fig:l1-summary-hide-structure.],
  [Skip derivations of total expectation and total variance. Skip product-moment identities except where needed later. Skip mode/skewness/kurtosis review except in reserve, since the undergraduate material already covered distribution descriptors.],
  [5--6 slides. The core live material is expectation, variance, conditional expectation, total variance, and the warning that summaries can hide structure.]
)

Suggested equations:

$
E[X] = integral x p(x) dif x
$ <eq:l1-expectation-cont>

$
E[X] = sum_x x p(x)
$ <eq:l1-expectation-disc>

$
E[a X + b] = a E[X] + b
$ <eq:l1-expectation-linear-affine>

$
E[sum_i X_i] = sum_i E[X_i]
$ <eq:l1-expectation-linear-sum>

$
V[X] = E[(X - mu)^2]
$ <eq:l1-variance>

$
V[X] = E[X^2] - mu^2
$ <eq:l1-variance-alt>

$
E[X^2] = sigma^2 + mu^2
$ <eq:l1-second-moment>

$
E[X] = E_Y[E[X | Y]]
$ <eq:l1-total-expectation>

$
V[X] = E_Y[V[X | Y]] + V_Y[E[X | Y]]
$ <eq:l1-total-variance>

Suggested figures:

#figure(
  figplaceholder(
    [Conditional moment intuition],
    [Show a marginal distribution decomposed into conditional distributions by group or latent cause. The slide should make @eq:l1-total-expectation and @eq:l1-total-variance visual.]
  ),
  caption: [Conditional moments decompose marginal summaries.]
) <fig:l1-conditional-moment>

#figure(
  figplaceholder(
    [Same summaries, different structures],
    [Anscombe-style or Datasaurus-style visual showing that mean/variance/correlation can be identical while structure differs.]
  ),
  caption: [Summary statistics can hide structure.]
) <fig:l1-summary-hide-structure>

== L1.3 Categorical, multinomial, and softmax

#coverage(
  [L1.3 Categorical, multinomial, and softmax],
  [Book 1 §2.5 is used carefully. Cover categorical and multinomial distributions, one-hot encoding, and softmax. Use multiclass logistic regression only as notation preparation, not as a fitted model.],
  [This is essential background. The students may know Bernoulli/Binomial, but multiclass labels and softmax were weakly covered or absent.],
  [Use @eq:l1-categorical-label, @eq:l1-simplex-constraints, @eq:l1-categorical-onehot, @eq:l1-multinomial, @eq:l1-softmax, and @eq:l1-multiclass-logistic. Use @fig:l1-simplex-softmax.],
  [Skip softmax temperature, log-sum-exp numerical stabilization, cross-entropy derivation, and detailed logistic-regression fitting. These belong in Lecture 2 or the later logistic-regression lecture.],
  [5 slides. One each for categorical labels, one-hot encoding, multinomial counts, softmax, and multiclass-logistic notation.]
)

Suggested equations:

$
"Cat"(y | theta) = product_(c=1)^C theta_c^(I(y = c))
$ <eq:l1-categorical-label>

$
0 <= theta_c <= 1, quad sum_(c=1)^C theta_c = 1
$ <eq:l1-simplex-constraints>

$
"Cat"(y | theta) = product_(c=1)^C theta_c^(y_c)
$ <eq:l1-categorical-onehot>

$
"Mult"(y | N, theta) = binom(N, N_1, dots, N_C) product_(c=1)^C theta_c^(N_c)
$ <eq:l1-multinomial>

$
"softmax"(a)_c = frac(exp(a_c), sum_(c'=1)^C exp(a_(c')))
$ <eq:l1-softmax>

$
p(y | x; theta) = "Cat"(y | "softmax"(W x + b))
$ <eq:l1-multiclass-logistic>

Suggested figure:

#figure(
  figplaceholder(
    [Softmax maps logits to the probability simplex],
    [Use three classes if possible. Show arbitrary scores/logits on the left and a point in the simplex on the right.]
  ),
  caption: [Softmax turns unconstrained scores into class probabilities.]
) <fig:l1-simplex-softmax>

== L1.4 Dirac delta and empirical distribution

#coverage(
  [L1.4 Dirac delta and empirical distribution],
  [Book 1 §2.6.5 is used only for the Dirac delta concept. Book 1 Eq. 4.10 or equivalent empirical-distribution material is used to update the earlier empirical-distribution definition.],
  [Define the empirical distribution here because the Dirac delta makes the definition precise. This also prepares Lecture 2, where MLE can be described as fitting a model to the empirical distribution.],
  [Use @eq:l1-delta-limit and @eq:l1-empirical-distribution. Use @fig:l1-empirical-distribution.],
  [Skip distribution-theoretic details of the delta function. Skip KL divergence and MLE justification until Lecture 2.],
  [2--3 slides. One for delta as point mass, one for empirical distribution, one optional bridge to MLE.]
)

Suggested equations:

$
lim_(sigma -> 0) cal(N)(y | mu, sigma^2) = delta(y - mu)
$ <eq:l1-delta-limit>

$
p_D(y) = frac(1, N) sum_(n=1)^N delta(y - y_n)
$ <eq:l1-empirical-distribution>

Suggested figure:

#figure(
  figplaceholder(
    [Empirical distribution as point masses],
    [Show a small dataset as equal-height spikes, optionally next to a smooth model density. Use this figure again in Lecture 2 if desired.]
  ),
  caption: [The empirical distribution places equal mass on the observed data.]
) <fig:l1-empirical-distribution>

== L1.5 Covariance, correlation, and dependence

#coverage(
  [L1.5 Covariance, correlation, and dependence],
  [Book 1 §§3.1.1--3.1.3 are used directly. Book 1 §§3.1.4--3.1.5, correlation and causation, are reserve only unless time permits.],
  [This section is required before the multivariate Gaussian. The live target is covariance as geometry, not a broad causality lecture.],
  [Use @eq:l1-covariance, @eq:l1-covariance-matrix, @eq:l1-second-moment-matrix, @eq:l1-affine-covariance, and @eq:l1-correlation. Use @fig:l1-covariance-geometry and optionally @fig:l1-correlation-causation-reserve.],
  [Skip full correlation matrix formula if slide time is tight. Skip Simpson's paradox and spurious-correlation examples unless used as reserve slides. Skip mutual information preview.],
  [4--5 live slides plus 1 reserve slide.]
)

Suggested equations:

$
"Cov"[X, Y] = E[(X - E[X])(Y - E[Y])] = E[X Y] - E[X] E[Y]
$ <eq:l1-covariance>

$
"Cov"[x] = E[(x - E[x])(x - E[x])^T] = Sigma
$ <eq:l1-covariance-matrix>

$
E[x x^T] = Sigma + mu mu^T
$ <eq:l1-second-moment-matrix>

$
"Cov"[A x + b] = A "Cov"[x] A^T
$ <eq:l1-affine-covariance>

$
rho = "corr"[X, Y] = frac("Cov"[X, Y], sqrt(V[X] V[Y]))
$ <eq:l1-correlation>

Suggested figures:

#figure(
  figplaceholder(
    [Covariance as geometry],
    [Show positive, negative, and zero covariance clouds. If possible, include ellipses so the next MVN section feels continuous.]
  ),
  caption: [Covariance controls joint variation and geometry.]
) <fig:l1-covariance-geometry>

#figure(
  figplaceholder(
    [Reserve: correlation is not causation],
    [One compact causal-graph style visual: X <- Z -> Y, or Simpson's paradox as a single visual. Do not let this interrupt the Gaussian arc unless time permits.]
  ),
  caption: [Reserve slide: correlation and causation.]
) <fig:l1-correlation-causation-reserve>

== L1.6 Multivariate Gaussian, carefully

#coverage(
  [L1.6 Multivariate Gaussian and conditioning],
  [Book 1 §3.2 is used directly. Book 2 §2.3 is used as supplemental framing, especially for Gaussian shells and the conditioning presentation.],
  [This is the mathematical center of Lecture 1. The goal is not to derive the multivariate Gaussian, but to make its geometry, marginalization, and conditioning usable.],
  [Use @eq:l1-mvn-density, @eq:l1-mahalanobis, @eq:l1-r2, @eq:l1-r2-expectation, @eq:l1-gaussian-block-y, @eq:l1-gaussian-block-mu, @eq:l1-gaussian-block-sigma, @eq:l1-gaussian-marginal-1, @eq:l1-gaussian-marginal-2, @eq:l1-gaussian-conditional, @eq:l1-gaussian-conditional-mean, @eq:l1-gaussian-conditional-cov, and @eq:l1-bivariate-conditional. Use @fig:l1-mvn-geometries, @fig:l1-gaussian-shell, and @fig:l1-gaussian-conditioning.],
  [Skip derivation of the MVN normalization constant, eigenvalue derivation of contours, Schur-complement derivation, canonical/information form, and full missing-data derivations.],
  [8--9 slides. This section deserves the bulk of the remaining Lecture 1 time.]
)

Suggested equations:

$
cal(N)(y | mu, Sigma) = frac(1, (2 pi)^(D / 2) |Sigma|^(1 / 2)) exp(-frac(1, 2) (y - mu)^T Sigma^(-1) (y - mu))
$ <eq:l1-mvn-density>

$
Delta^2 = (y - mu)^T Sigma^(-1) (y - mu)
$ <eq:l1-mahalanobis>

$
R^2 = norm(x)^2 = sum_(i=1)^D x_i^2
$ <eq:l1-r2>

$
E[R^2] = D
$ <eq:l1-r2-expectation>

$
y = mat(y_1; y_2)
$ <eq:l1-gaussian-block-y>

$
mu = mat(mu_1; mu_2)
$ <eq:l1-gaussian-block-mu>

$
Sigma = mat(Sigma_11, Sigma_12; Sigma_21, Sigma_22)
$ <eq:l1-gaussian-block-sigma>

$
p(y_1) = cal(N)(y_1 | mu_1, Sigma_11)
$ <eq:l1-gaussian-marginal-1>

$
p(y_2) = cal(N)(y_2 | mu_2, Sigma_22)
$ <eq:l1-gaussian-marginal-2>

$
p(y_1 | y_2) = cal(N)(y_1 | mu_(1|2), Sigma_(1|2))
$ <eq:l1-gaussian-conditional>

$
mu_(1|2) = mu_1 + Sigma_12 Sigma_22^(-1) (y_2 - mu_2)
$ <eq:l1-gaussian-conditional-mean>

$
Sigma_(1|2) = Sigma_11 - Sigma_12 Sigma_22^(-1) Sigma_21
$ <eq:l1-gaussian-conditional-cov>

$
p(y_1 | y_2) = cal(N)(y_1 | mu_1 + rho frac(sigma_1, sigma_2) (y_2 - mu_2), sigma_1^2 (1 - rho^2))
$ <eq:l1-bivariate-conditional>

Suggested figures:

#figure(
  figplaceholder(
    [Multivariate Gaussian geometries],
    [Three panels: spherical, diagonal, and full covariance. Emphasize scale, orientation, and dependence.]
  ),
  caption: [Different covariance structures imply different Gaussian geometries.]
) <fig:l1-mvn-geometries>

#figure(
  figplaceholder(
    [Gaussian shell / typical set],
    [Show that in high dimensions, mass concentrates away from the mode. Keep this visual and brief.]
  ),
  caption: [High-dimensional Gaussian mass concentrates in a shell.]
) <fig:l1-gaussian-shell>

#figure(
  figplaceholder(
    [Gaussian conditioning],
    [A 2D Gaussian cloud with a vertical slice at observed y_2. Show conditional mean and reduced conditional variance.]
  ),
  caption: [Conditioning a joint Gaussian gives a Gaussian conditional distribution.]
) <fig:l1-gaussian-conditioning>

== L1.7 Missing values as Gaussian conditioning

#coverage(
  [L1.7 Missing values as Gaussian conditioning],
  [Book 1 §3.2 is used only to extend the block-conditioning formula to visible and hidden parts of a vector. This is a conceptual bridge, not a missing-data lecture.],
  [Use this as one short bridge slide after Gaussian conditioning. It prepares missing-data models, factor models, and imputation without opening those topics.],
  [Use @eq:l1-hidden-visible-conditional and @fig:l1-gaussian-imputation.],
  [Skip missingness mechanisms, MAR/MNAR, data augmentation details, and full posterior imputation workflow.],
  [1 slide, perhaps 2 if students need notation.]
)

Suggested equation:

$
p(y_h | y_v, theta)
$ <eq:l1-hidden-visible-conditional>

Suggested figure:

#figure(
  figplaceholder(
    [Visible and hidden entries],
    [A vector with observed cells and missing cells. A Gaussian model fills in the hidden cells by conditioning on visible cells.]
  ),
  caption: [Gaussian imputation as conditioning on observed entries.]
) <fig:l1-gaussian-imputation>

== L1.8 Linear Gaussian systems

#coverage(
  [L1.8 Linear Gaussian systems],
  [Book 1 §3.3 is used directly. Book 2 §2.3.2 is used as supplemental intuition, especially if sensor fusion is used as the example.],
  [This is the natural stopping point for Lecture 1. It uses Gaussian priors, Gaussian likelihoods, covariance transformations, and Gaussian conditioning.],
  [Use @eq:l1-lgs-prior, @eq:l1-lgs-likelihood, @eq:l1-lgs-joint-factor, @eq:l1-lgs-joint-mean, @eq:l1-lgs-joint-cov, @eq:l1-lgs-posterior, @eq:l1-lgs-post-precision, @eq:l1-lgs-post-cov, and @eq:l1-lgs-post-mean. Use @fig:l1-linear-gaussian-system and @fig:l1-sensor-fusion.],
  [Skip completing-the-square derivations, Kalman filtering, and general information-form derivations.],
  [5 slides: model, joint Gaussian, posterior by Gaussian conditioning, sensor-fusion interpretation, Lecture 1 summary.]
)

Suggested equations:

$
p(z) = cal(N)(z | mu_z, Sigma_z)
$ <eq:l1-lgs-prior>

$
p(y | z) = cal(N)(y | W z + b, Sigma_y)
$ <eq:l1-lgs-likelihood>

$
p(z, y) = p(z) p(y | z)
$ <eq:l1-lgs-joint-factor>

$
mu = mat(mu_z; W mu_z + b)
$ <eq:l1-lgs-joint-mean>

$
Sigma = mat(Sigma_z, Sigma_z W^T; W Sigma_z, Sigma_y + W Sigma_z W^T)
$ <eq:l1-lgs-joint-cov>

$
p(z | y) = cal(N)(z | mu_(z|y), Sigma_(z|y))
$ <eq:l1-lgs-posterior>

$
Lambda_(z|y) = Sigma_z^(-1) + W^T Sigma_y^(-1) W
$ <eq:l1-lgs-post-precision>

$
Sigma_(z|y) = Lambda_(z|y)^(-1)
$ <eq:l1-lgs-post-cov>

$
mu_(z|y) = Sigma_(z|y) (W^T Sigma_y^(-1) (y - b) + Sigma_z^(-1) mu_z)
$ <eq:l1-lgs-post-mean>

Suggested figures:

#figure(
  figplaceholder(
    [Linear Gaussian system graph],
    [A minimal graph: latent state z to observation y, with W, b, Sigma_y as observation-model parameters.]
  ),
  caption: [A linear Gaussian system as a probabilistic graphical model.]
) <fig:l1-linear-gaussian-system>

#figure(
  figplaceholder(
    [Sensor fusion interpretation],
    [Prior ellipse, likelihood/measurement band, posterior ellipse. The more reliable measurement should visibly pull and shrink the posterior.]
  ),
  caption: [Bayesian updating in a linear Gaussian system as sensor fusion.]
) <fig:l1-sensor-fusion>

== L1.9 Lecture 1 summary slide

The summary slide should reference the arc rather than introduce new mathematics:

- ML tasks specify what is observed, unknown, and required.
- Moments and conditional moments describe probabilistic summaries.
- Categorical/multinomial distributions and softmax are the language of labels.
- Covariance gives geometry.
- Gaussian marginalization and conditioning are reusable inference machinery.
- Linear Gaussian systems are the first full example of that machinery.

#pagebreak()

= Lecture 2 — likelihood and exponential-family statistics

== Lecture 2 high-level arc

Lecture 2 collects material deliberately excluded from Lecture 1.

1. From posterior thinking to likelihood objectives.
2. MLE examples and sufficient statistics.
3. ERM and surrogate losses.
4. Regularization and MAP.
5. Exponential-family common form.
6. Log partition function and moments.
7. Sufficient statistics and moment matching.
8. Conjugacy extensions as reserve / bridge.

The endpoint is: exponential-family MLE is moment matching, and sufficient statistics explain what information the data contribute to the likelihood.

== L2.1 From Bayesian posterior to likelihood objective

#coverage(
  [L2.1 From Bayesian posterior to likelihood objective],
  [Book 1 §§4.1--4.2.2 are used directly. Book 1 §4.6 is used only for MAP/Bayesian contrast when needed. The empirical distribution from Book 1 Eq. 4.10 is reused from Lecture 1.],
  [This section turns probabilistic modeling into optimization language. It should connect to Bayes without reteaching Bayes.],
  [Use @eq:l2-fitting-objective, @eq:l2-conditional-loglik, @eq:l2-mle-supervised, @eq:l2-nll, @eq:l2-mle-unsupervised, @eq:l2-map, and @eq:l2-kl-empirical. Use @fig:l2-likelihood-loss-bridge.],
  [Skip long KL derivation; include the conclusion only. Skip asymptotic theory. Skip Fisher information until reserve or a later inference lecture.],
  [5--6 slides.]
)

Suggested equations:

$
hat(theta) = arg min_theta L(theta)
$ <eq:l2-fitting-objective>

$
ell(theta) = log p(D | theta) = sum_(n=1)^N log p(y_n | x_n, theta)
$ <eq:l2-conditional-loglik>

$
hat(theta)_("mle") = arg max_theta sum_(n=1)^N log p(y_n | x_n, theta)
$ <eq:l2-mle-supervised>

$
"NLL"(theta) = - sum_(n=1)^N log p(y_n | x_n, theta)
$ <eq:l2-nll>

$
hat(theta)_("mle") = arg min_theta -sum_(n=1)^N log p(y_n | theta)
$ <eq:l2-mle-unsupervised>

$
hat(theta)_("map") = arg max_theta (log p(D | theta) + log p(theta))
$ <eq:l2-map>

$
D_("KL")(p_D || p_theta) = "const" + "NLL"(theta)
$ <eq:l2-kl-empirical>

Suggested figure:

#figure(
  figplaceholder(
    [Likelihood-to-loss bridge],
    [Show probability model p(D|theta), log likelihood, negative log likelihood, and optimization objective as the same object viewed from different directions.]
  ),
  caption: [Maximum likelihood converts probabilistic modeling into loss minimization.]
) <fig:l2-likelihood-loss-bridge>

== L2.2 MLE examples and sufficient statistics

#coverage(
  [L2.2 MLE examples and sufficient statistics],
  [Book 1 §§4.2.3--4.2.7 are used selectively. Use Bernoulli, categorical, Gaussian, multivariate Gaussian, and linear regression examples.],
  [The point is not algebraic drill. The point is that MLE often compresses data into sufficient statistics and familiar sample summaries.],
  [Use @eq:l2-bernoulli-nll, @eq:l2-bernoulli-mle, @eq:l2-categorical-nll, @eq:l2-categorical-mle, @eq:l2-gaussian-mle-mean, @eq:l2-gaussian-mle-var, @eq:l2-mvn-mle-mean, @eq:l2-mvn-mle-cov, @eq:l2-linear-regression-gaussian, @eq:l2-linear-regression-ls, and @eq:l2-linear-regression-closed. Use @fig:l2-bernoulli-mle and @fig:l2-gaussian-mle.],
  [Skip Lagrange multiplier derivations in live slides. Skip unbiased-estimator theory beyond one sentence that the MLE variance uses 1/N rather than 1/(N-1). Skip matrix calculus derivation of the regression solution.],
  [6--7 slides.]
)

Suggested equations:

$
"NLL"(theta) = - [N_1 log theta + N_0 log(1 - theta)]
$ <eq:l2-bernoulli-nll>

$
hat(theta)_("mle") = frac(N_1, N_0 + N_1)
$ <eq:l2-bernoulli-mle>

$
"NLL"(theta) = - sum_k N_k log theta_k
$ <eq:l2-categorical-nll>

$
hat(theta)_k = frac(N_k, N)
$ <eq:l2-categorical-mle>

$
hat(mu)_("mle") = frac(1, N) sum_(n=1)^N y_n
$ <eq:l2-gaussian-mle-mean>

$
hat(sigma)^2_("mle") = frac(1, N) sum_(n=1)^N (y_n - hat(mu)_("mle"))^2
$ <eq:l2-gaussian-mle-var>

$
hat(mu)_("mle") = bar(y)
$ <eq:l2-mvn-mle-mean>

$
hat(Sigma)_("mle") = frac(1, N) sum_(n=1)^N (y_n - bar(y))(y_n - bar(y))^T
$ <eq:l2-mvn-mle-cov>

$
y_n | x_n, w tilde cal(N)(w^T x_n, sigma^2)
$ <eq:l2-linear-regression-gaussian>

$
hat(w)_("mle") = arg min_w sum_(n=1)^N (y_n - w^T x_n)^2
$ <eq:l2-linear-regression-ls>

$
hat(w) = (X^T X)^(-1) X^T y
$ <eq:l2-linear-regression-closed>

Suggested figures:

#figure(
  figplaceholder(
    [Bernoulli likelihood and MLE],
    [Plot Bernoulli/binomial likelihood over theta for a few counts, with the MLE marked.]
  ),
  caption: [Bernoulli MLE is the observed success proportion.]
) <fig:l2-bernoulli-mle>

#figure(
  figplaceholder(
    [Gaussian MLE and least squares],
    [Show 1D Gaussian data or regression residuals with the fitted mean/line and squared residuals.]
  ),
  caption: [Gaussian MLE recovers familiar averages and least-squares fits.]
) <fig:l2-gaussian-mle>

== L2.3 ERM and surrogate losses

#coverage(
  [L2.3 ERM and surrogate losses],
  [Book 1 §4.3 is used selectively. This also revisits Book 1 §1.2.1.4, but now as formal loss minimization rather than as part of the ML taxonomy.],
  [This section generalizes MLE to arbitrary losses and explains why differentiable surrogate losses are used for classification.],
  [Use @eq:l2-erm, @eq:l2-zero-one-loss, @eq:l2-log-loss-binary, and @eq:l2-hinge-loss. Use @fig:l2-surrogate-losses.],
  [Skip NP-hardness details and optimization algorithms. Skip EMA if present in the assigned section unless needed later.],
  [3--4 slides.]
)

Suggested equations:

$
L(theta) = frac(1, N) sum_(n=1)^N ell(y_n, theta; x_n)
$ <eq:l2-erm>

$
ell_("01")(y, hat(y)) = I(y != hat(y))
$ <eq:l2-zero-one-loss>

$
ell_("ll")(tilde(y), eta) = log(1 + exp(-tilde(y) eta))
$ <eq:l2-log-loss-binary>

$
ell_("hinge")(tilde(y), eta) = max(0, 1 - tilde(y) eta)
$ <eq:l2-hinge-loss>

Suggested figure:

#figure(
  figplaceholder(
    [Surrogate losses],
    [Plot zero-one, logistic/log loss, and hinge loss as functions of margin. Keep labels minimal.]
  ),
  caption: [Surrogate losses replace discrete classification error with smoother objectives.]
) <fig:l2-surrogate-losses>

== L2.4 Regularization and MAP

#coverage(
  [L2.4 Regularization and MAP],
  [Book 1 §4.5 is used selectively. Book 1 §4.6.2 may be referenced for the Beta--Bernoulli MAP example, but the conjugacy derivation belongs to the prior course / reserve.],
  [This section connects overfitting, penalties, and priors. It should make MAP feel like regularized likelihood rather than a separate topic.],
  [Use @eq:l2-regularized-erm, @eq:l2-map-loss, @eq:l2-beta-bernoulli-map, and @eq:l2-weight-decay. Use @fig:l2-regularization.],
  [Skip inverse-Wishart shrinkage derivations. Skip cross-validation details except to say lambda is usually chosen using validation/CV. Skip early stopping.],
  [4--5 slides.]
)

Suggested equations:

$
L(theta; lambda) = frac(1, N) sum_(n=1)^N ell(y_n, theta; x_n) + lambda C(theta)
$ <eq:l2-regularized-erm>

$
L(theta) = - [log p(D | theta) + log p(theta)]
$ <eq:l2-map-loss>

$
hat(theta)_("map") = frac(N_1 + a - 1, N_1 + N_0 + a + b - 2)
$ <eq:l2-beta-bernoulli-map>

$
C(w) = norm(w)_2^2
$ <eq:l2-weight-decay>

Suggested figure:

#figure(
  figplaceholder(
    [Regularization as prior information],
    [Show overfit/high-variance estimate pulled toward a prior-preferred region or simpler function.]
  ),
  caption: [Regularization penalizes complexity; MAP interprets the penalty as a prior.]
) <fig:l2-regularization>

== L2.5 Exponential-family common form

#coverage(
  [L2.5 Exponential-family common form],
  [Book 2 §§2.4.1--2.4.2 are used directly. Book 1 distribution examples are used only as familiar cases.],
  [This is the conceptual center of Lecture 2. Present the common form and three examples: Bernoulli, categorical, Gaussian.],
  [Use @eq:l2-exp-family, @eq:l2-bernoulli-natural, @eq:l2-bernoulli-logpartition, @eq:l2-bernoulli-mean, @eq:l2-categorical-softmax, and @eq:l2-gaussian-suffstats. Use @fig:l2-exp-family-map.],
  [Skip curved exponential families, minimal versus overcomplete parameterizations except as a note, non-examples, and maximum-entropy derivation.],
  [5--6 slides.]
)

Suggested equations:

$
p(x | eta) = h(x) exp(eta^T T(x) - A(eta))
$ <eq:l2-exp-family>

$
eta = log frac(mu, 1 - mu)
$ <eq:l2-bernoulli-natural>

$
A(eta) = log(1 + exp(eta))
$ <eq:l2-bernoulli-logpartition>

$
mu = sigma(eta)
$ <eq:l2-bernoulli-mean>

$
mu = "softmax"(eta)
$ <eq:l2-categorical-softmax>

$
T(x) = [x, x x^T]
$ <eq:l2-gaussian-suffstats>

Suggested figure:

#figure(
  figplaceholder(
    [Exponential-family map],
    [A compact table or map showing Bernoulli, categorical, Gaussian, Poisson if desired, all as instances of @eq:l2-exp-family.]
  ),
  caption: [Many familiar distributions share the exponential-family form.]
) <fig:l2-exp-family-map>

== L2.6 Log partition function and moments

#coverage(
  [L2.6 Log partition function and moments],
  [Book 2 §2.4.3 is used directly.],
  [This section explains why the log partition function is not just a normalizing nuisance: its derivatives generate moments.],
  [Use @eq:l2-logpartition, @eq:l2-grad-logpartition, @eq:l2-hessian-logpartition, @eq:l2-bernoulli-grad, and @eq:l2-bernoulli-hessian. Use @fig:l2-logpartition-derivatives.],
  [Skip full derivations, convex conjugates, Bregman divergence, and Fisher information unless used as reserve.],
  [4--5 slides.]
)

Suggested equations:

$
A(eta) = log Z(eta)
$ <eq:l2-logpartition>

$
nabla_eta A(eta) = E[T(x)]
$ <eq:l2-grad-logpartition>

$
nabla_eta^2 A(eta) = "Cov"[T(x)]
$ <eq:l2-hessian-logpartition>

$
A'(eta) = sigma(eta)
$ <eq:l2-bernoulli-grad>

$
A''(eta) = sigma(eta)(1 - sigma(eta))
$ <eq:l2-bernoulli-hessian>

Suggested figure:

#figure(
  figplaceholder(
    [Derivatives of log partition function],
    [Show A(eta), its slope as a mean, and its curvature as variance/covariance. Use Bernoulli as the simple example.]
  ),
  caption: [The log partition function generates moments.]
) <fig:l2-logpartition-derivatives>

== L2.7 Sufficient statistics and MLE in exponential families

#coverage(
  [L2.7 Sufficient statistics and moment matching],
  [Book 2 §2.4.5 is used directly. Earlier Book 1 MLE examples are reinterpreted through this lens.],
  [This is the payoff. Show that data enter through summed sufficient statistics and that exponential-family MLE matches model moments to empirical moments.],
  [Use @eq:l2-ef-data-likelihood, @eq:l2-summed-suffstats, @eq:l2-ef-score, @eq:l2-moment-matching, @eq:l2-bernoulli-moment-matching, and @eq:l2-categorical-moment-matching. Use @fig:l2-moment-matching.],
  [Skip proof of the Fisher-Neyman factorization theorem. Skip asymptotic normality of MLE. Skip maximum entropy.],
  [5 slides.]
)

Suggested equations:

$
p(D | eta) prop exp(eta^T T(D) - N A(eta))
$ <eq:l2-ef-data-likelihood>

$
T(D) = sum_(n=1)^N T(x_n)
$ <eq:l2-summed-suffstats>

$
nabla_eta log p(D | eta) = T(D) - N E[T(x)]
$ <eq:l2-ef-score>

$
E[T(x)] = frac(1, N) sum_(n=1)^N T(x_n)
$ <eq:l2-moment-matching>

$
mu = frac(1, N) sum_(n=1)^N I(x_n = 1)
$ <eq:l2-bernoulli-moment-matching>

$
mu_k = frac(N_k, N)
$ <eq:l2-categorical-moment-matching>

Suggested figure:

#figure(
  figplaceholder(
    [Moment matching],
    [Left: empirical sufficient statistics. Right: model moments. Show MLE as choosing eta so they match.]
  ),
  caption: [Exponential-family MLE matches empirical sufficient statistics to model moments.]
) <fig:l2-moment-matching>

== L2.8 Conjugacy extensions as reserve / bridge

#coverage(
  [L2.8 Conjugacy extensions],
  [Book 1 §4.6 and Book 2 §2.4 are used only for a reserve bridge. The undergraduate course already covered Beta--Binomial conjugacy, so this should be brief.],
  [Use this only if time permits or as reserve slides. The useful new point is Dirichlet--Multinomial as the multiclass version of Beta--Binomial.],
  [Use @eq:l2-dirichlet-prior, @eq:l2-multinomial-likelihood, and @eq:l2-dirichlet-posterior. Use @fig:l2-dirichlet-multinomial.],
  [Skip full conjugate-prior derivation and Gaussian-Gaussian conjugacy derivation unless needed as a handout.],
  [Reserve: 2--3 slides.]
)

Suggested equations:

$
theta tilde "Dir"(alpha)
$ <eq:l2-dirichlet-prior>

$
N | theta tilde "Mult"(N, theta)
$ <eq:l2-multinomial-likelihood>

$
theta | D tilde "Dir"(alpha + N)
$ <eq:l2-dirichlet-posterior>

Suggested figure:

#figure(
  figplaceholder(
    [Dirichlet--Multinomial update],
    [Three-class simplex visual: prior concentration plus observed class counts gives posterior concentration.]
  ),
  caption: [Dirichlet--Multinomial conjugacy generalizes Beta--Binomial updating.]
) <fig:l2-dirichlet-multinomial>

== Lecture 2 summary slide

The Lecture 2 summary should state:

- MLE is optimization of log likelihood, or minimization of negative log likelihood.
- ERM generalizes MLE by replacing log loss with arbitrary loss.
- Regularization is needed because empirical objectives can overfit.
- MAP is regularized likelihood with a Bayesian interpretation.
- Exponential families give a common form for Bernoulli, categorical, Gaussian, and many GLMs.
- The log partition function generates moments.
- Exponential-family MLE is moment matching.
- Sufficient statistics explain what the data contribute to the likelihood.

#pagebreak()

= Condensed equation inventory

This inventory is included to make sure every suggested equation has a referenceable equation number in this document. In the slide deck, do not show all of these. Use the section specifications above to decide which equations are live, reserve, or omitted.

== Lecture 1 equation groups

- ML task notation: @eq:l1-supervised-data--@eq:l1-policy.
- Moments: @eq:l1-expectation-cont--@eq:l1-total-variance.
- Categorical and softmax: @eq:l1-categorical-label--@eq:l1-multiclass-logistic.
- Empirical distribution: @eq:l1-delta-limit and @eq:l1-empirical-distribution.
- Covariance and correlation: @eq:l1-covariance--@eq:l1-correlation.
- Multivariate Gaussian: @eq:l1-mvn-density--@eq:l1-bivariate-conditional.
- Linear Gaussian systems: @eq:l1-lgs-prior--@eq:l1-lgs-post-mean.

== Lecture 2 equation groups

- Likelihood objective: @eq:l2-fitting-objective--@eq:l2-kl-empirical.
- MLE examples: @eq:l2-bernoulli-nll--@eq:l2-linear-regression-closed.
- ERM and surrogate losses: @eq:l2-erm--@eq:l2-hinge-loss.
- Regularization and MAP: @eq:l2-regularized-erm--@eq:l2-weight-decay.
- Exponential families: @eq:l2-exp-family--@eq:l2-gaussian-suffstats.
- Log partition and moments: @eq:l2-logpartition--@eq:l2-bernoulli-hessian.
- Sufficient statistics and moment matching: @eq:l2-ef-data-likelihood--@eq:l2-categorical-moment-matching.
- Reserve conjugacy bridge: @eq:l2-dirichlet-prior--@eq:l2-dirichlet-posterior.

= Implementation notes for `slide_deck.typ`

- Keep Lecture 1's current material through Iris and empirical-risk orientation, then prune the material after `= Classes of machine learning problems` so that only the task taxonomy remains live.
- Move the existing exponential-family section to Lecture 2.
- Move the existing divergence/KL pressure-point section to Lecture 2 or later, using only @eq:l2-kl-empirical as the light bridge from empirical distribution to NLL.
- Keep Gaussian geometry, marginalization, conditioning, and linear Gaussian systems in Lecture 1.
- Put correlation/causation, detailed datasets, detailed RL, log-sum-exp, full MLE derivations, and conjugacy derivations into reserve or handouts.

