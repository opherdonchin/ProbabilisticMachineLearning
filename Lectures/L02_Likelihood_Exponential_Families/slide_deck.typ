// Lecture 2 — Likelihood and exponential-family statistics
#import "../course.typ": *

#let lecture = (
  number: 2,
  title: [Likelihood and Exponential-Family Statistics],
  short-title: [Likelihood & Exponential Families],
  subtitle: [From probabilistic models to fitting objectives and moment matching],
)

#show: course-theme.with(info: lecture)

#title-slide()

// `schema-node`, `schema-arrow`, and `source-note` are shared course
// components (see course.typ); they are imported via `*` above.

#section-metadata(
  short-title: [Likelihood objectives],
  subtitle: [Posterior notation, likelihood, and negative log likelihood],
)

= From posterior thinking to likelihood objectives

== Posterior and likelihood

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(theta | D) prop p(D | theta) p(theta)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.18fr, 1fr, 0.18fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([$D$], [$"observed data"$]),
      schema-arrow,
      schema-node([$p(D | theta)$], [$"likelihood"$], fill: palette.paper),
      schema-arrow,
      schema-node([$theta$], [$"parameter"$]),
    )
    #source-note[Course schematic; Book 1 §§4.1–4.2]
  ],
)

#speaker-note[
  Begin from familiar posterior notation. For a fixed dataset, the likelihood
  is the factor that scores parameter values by how well they explain the
  observations. This lecture studies fitting objectives built from that factor.
]

== Conditional log likelihood

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$ell(theta) = log p(D | theta) = sum_(n=1)^N log p(y_n | x_n, theta)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.18fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$p(D | theta) = product_n p(y_n | x_n, theta)$], [$"product"$]),
      schema-arrow,
      schema-node([$ell(theta)$], [$"sum"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  Conditional independence makes the likelihood a product over training
  examples. Taking logs turns the product into a sum, which gives the standard
  supervised log-likelihood objective.
]

== From likelihood to loss

#content-block(
  layout: "top",
  object-width: 98%,
  object: [
    #grid(
      columns: (1fr, 0.16fr, 1fr, 0.16fr, 1fr, 0.16fr, 1fr),
      gutter: 0.25em,
      align: center + horizon,
      schema-node([$p(D | theta)$], [$"probability"$]),
      schema-arrow,
      schema-node([$log p(D | theta)$], [$"log likelihood"$], fill: palette.paper),
      schema-arrow,
      schema-node([$- log p(D | theta)$], [$"NLL"$]),
      schema-arrow,
      schema-node([$hat(theta) = "arg min"_theta "NLL"(theta)$], [$"fit"$], fill: palette.paper),
    )
    #v(0.85em)
    #align(center)[$hat(theta)_"mle" = "arg max"_theta sum_(n=1)^N log p(y_n | x_n, theta)$]
  ],
)

#speaker-note[
  These are equivalent perspectives on the same model fit. The negative sign
  changes maximization into minimization, so probabilistic modeling can use the
  optimization language of losses.
]

== Empirical distribution bridge

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$D_"KL"(p_D || p_theta) = "const" + "NLL"(theta)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$p_D$], [$"observed point masses"$]),
      schema-arrow,
      schema-node([$p_theta$], [$"model distribution"$], fill: palette.paper),
    )
    #source-note[Course schematic; empirical-distribution bridge specified for Lecture 2]
  ],
)

#speaker-note[
  State the conclusion without deriving KL divergence. Maximum likelihood can
  be read as fitting the model distribution to the empirical distribution.
]

== Summary: Likelihood objectives

#content-block(
  key-points: [
    - $p(D | theta)$: likelihood
    - $ell(theta) = log p(D | theta)$: log likelihood
    - $"NLL"(theta) = - log p(D | theta)$
    - MLE: maximize log likelihood or minimize NLL
    - $D_"KL"(p_D || p_theta) = "const" + "NLL"(theta)$
  ],
)

#speaker-note[
  The likelihood objective is the bridge from the probabilistic models of
  Lecture 1 to the fitting procedures studied in this lecture.
]

#section-metadata(
  short-title: [MLE examples],
  subtitle: [Observed summaries as parameter estimates],
)

= MLE examples and sufficient statistics

== Bernoulli MLE

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 0.18fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$N_1, N_0$], [$"successes, failures"$]),
      schema-arrow,
      schema-node([$hat(theta)_"mle" = frac(N_1, N_0 + N_1)$], [$"success proportion"$], fill: palette.paper),
    )
    #v(0.95em)
    #align(center)[$"NLL"(theta) = -[N_1 log theta + N_0 log(1-theta)]$]
  ],
)

#speaker-note[
  The Bernoulli likelihood depends on the whole sequence only through the two
  counts. The MLE is the observed success proportion, a first sufficient-
  statistic example.
]

== Categorical MLE

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$"NLL"(theta) = -sum_k N_k log theta_k$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$N = (N_1, dots, N_K)$], [$sum_k N_k = N$]),
      schema-arrow,
      schema-node([$hat(theta)_k = frac(N_k, N)$], [$"class proportions"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  The categorical MLE is the vector of observed class proportions. It shares
  the same counts-to-probabilities form as Bernoulli, now on a simplex.
]

== Gaussian MLE

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.1em,
      schema-node([$hat(mu)_"mle" = frac(1,N) sum_(n=1)^N y_n$], [$"sample mean"$]),
      schema-node([$hat(sigma)^2_"mle" = frac(1,N) sum_(n=1)^N (y_n-hat(mu)_"mle")^2$], [$"sample variance"$], fill: palette.paper),
    )
    #source-note[Course schematic; Book 1 §§4.2.3–4.2.7]
  ],
)

#speaker-note[
  Gaussian MLE returns familiar sample summaries. Mention only that the MLE
  variance uses a denominator of N, reserving unbiased-estimator theory.
]

== Multivariate Gaussian MLE

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$hat(mu)_"mle" = bar(y)$]
    #v(0.65em)
    #align(center)[$hat(Sigma)_"mle" = frac(1,N) sum_(n=1)^N (y_n-bar(y))(y_n-bar(y))^T$]
    #v(0.85em)
    #align(center)[$("mean", "covariance")$]
  ],
)

#speaker-note[
  Connect Lecture 1's covariance object to its estimation from data. The mean
  and covariance are the empirical summaries that parameterize a Gaussian fit.
]

== Gaussian linear regression

#content-block(
  layout: "top",
  object-width: 95%,
  object: [
    #align(center)[$y_n | x_n, w tilde cal(N)(w^T x_n, sigma^2)$]
    #v(0.65em)
    #align(center)[$hat(w)_"mle" = "arg min"_w sum_(n=1)^N (y_n-w^T x_n)^2$]
    #v(0.45em)
    #align(center)[$hat(w) = (X^T X)^(-1) X^T y$]
  ],
)

#speaker-note[
  A Gaussian observation model turns MLE into least squares. The closed-form
  solution is a landmark, not an invitation to derive matrix calculus here.
]

== Summary: MLE examples

#content-block(
  key-points: [
    - Bernoulli MLE: observed success proportion
    - Categorical MLE: observed class proportions
    - Gaussian MLE: sample mean and variance
    - Multivariate Gaussian MLE: sample mean and covariance
    - Gaussian linear regression MLE: least squares
  ],
)

#speaker-note[
  The examples prepare the central idea that MLE can compress data to a small
  set of relevant summaries. Exponential families will formalize that pattern.
]

#section-metadata(
  short-title: [ERM],
  subtitle: [Arbitrary losses and classification surrogates],
)

= Empirical risk minimization and surrogate losses

== Empirical risk minimization

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$L(theta) = frac(1,N) sum_(n=1)^N ell(y_n, theta; x_n)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$ell(y_n, theta; x_n)$], [$"per-example loss"$]),
      schema-arrow,
      schema-node([$L(theta)$], [$"empirical average"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  ERM has the same average-over-examples shape as NLL, but accepts a general
  loss. This is the correct formal return to the performance idea in Lecture 1.
]

== Zero-one loss

#content-block(
  layout: "top",
  object-width: 88%,
  object: [
    #align(center)[$ell_"01"(y, hat(y)) = I(y != hat(y))$]
    #v(0.9em)
    #grid(
      columns: (1fr, 1fr),
      gutter: 1em,
      schema-node([$y = hat(y)$], [$ell_"01" = 0$]),
      schema-node([$y != hat(y)$], [$ell_"01" = 1$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  Zero-one loss measures classification error directly. Its discrete shape
  motivates smooth surrogate losses when the classifier is fit by optimization.
]

== Surrogate losses

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.7em,
      schema-node([Zero-one], [$I(tilde(y) eta < 0)$]),
      schema-node([Log loss], [$ell_"ll"(tilde(y), eta) = log(1+exp(-tilde(y) eta))$], fill: palette.paper),
      schema-node([Hinge], [$ell_"hinge"(tilde(y), eta) = "max"(0,1-tilde(y) eta)$]),
    )
    #v(0.75em)
    #align(center)[$"margin" = tilde(y) eta$]
  ],
)

#speaker-note[
  The margin combines a signed label with a scalar score. Log and hinge losses
  replace a discontinuous error with objectives that expose useful gradients.
]

== Summary: ERM and surrogate losses

#content-block(
  key-points: [
    - ERM minimizes an average loss
    - Zero-one loss measures classification error
    - Log loss connects ERM to probabilistic classification
    - Hinge and log losses are optimization-friendly surrogates
  ],
)

#speaker-note[
  ERM generalizes maximum likelihood by changing the per-example loss. The next
  section adds a second term to control which fitted parameters are preferred.
]

#section-metadata(
  short-title: [Regularization and MAP],
  subtitle: [Penalties, priors, and controlled model complexity],
)

= Regularization and MAP

== Regularized objective

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$L(theta; lambda) = frac(1,N) sum_(n=1)^N ell(y_n, theta; x_n) + lambda C(theta)$]
    #v(0.85em)
    #grid(
      columns: (1fr, 0.22fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$frac(1,N) sum_n ell_n$], [$"data fit"$]),
      align(center + horizon)[#text(size: 1.2em, fill: palette.accent)[$+$]],
      schema-node([$lambda C(theta)$], [$"complexity penalty"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  Regularization augments the empirical objective with a preference over
  parameters. The strength lambda determines how heavily that preference pulls
  against the fit to observed examples.
]

== MAP as regularized likelihood

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$hat(theta)_"map" = "arg max"_theta (log p(D | theta) + log p(theta))$]
    #v(0.8em)
    #align(center)[$L(theta) = -[log p(D | theta) + log p(theta)]$]
    #v(0.85em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$-log p(D | theta)$], [$"NLL"$]),
      align(center + horizon)[#text(size: 1.2em, fill: palette.accent)[$+$]],
      schema-node([$-log p(theta)$], [$"prior penalty"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  MAP is a regularized likelihood objective with a Bayesian interpretation.
  The negative log prior plays the role of a parameter penalty.
]

== Beta-Bernoulli MAP

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$hat(theta)_"map" = frac(N_1+a-1, N_1+N_0+a+b-2)$]
    #v(0.85em)
    #grid(
      columns: (1fr, 0.18fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$N_1, N_0$], [$"data counts"$]),
      align(center + horizon)[#text(size: 1.2em, fill: palette.accent)[$+$]],
      schema-node([$a-1, b-1$], [$"prior pseudo-counts"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  This familiar update makes the prior contribution visible as pseudo-counts.
  It is a compact example rather than a repetition of the full conjugacy proof.
]

== Weight decay

#content-block(
  layout: "top",
  object-width: 88%,
  object: [
    #align(center)[$C(w) = norm(w)_2^2$]
    #v(0.85em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$w$], [$"parameters"$]),
      schema-arrow,
      schema-node([$norm(w)_2^2$], [$"quadratic penalty"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  Weight decay is the standard L2 penalty. Under a Gaussian prior over weights,
  it is also the negative log prior term in a MAP objective.
]

== Summary: Regularization and MAP

#content-block(
  key-points: [
    - Regularization adds $lambda C(theta)$ to empirical loss
    - MAP maximizes $log p(D|theta) + log p(theta)$
    - Negative log priors become penalties
    - Beta-Bernoulli MAP adds prior pseudo-counts
    - L2 weight decay corresponds to a Gaussian prior
  ],
)

#speaker-note[
  The same design idea has two descriptions: optimization calls it a penalty;
  Bayesian modeling calls it a prior. Both select among parameters that fit the
  observed data.
]

#section-metadata(
  short-title: [Exponential families],
  subtitle: [A common algebraic form for familiar distributions],
)

= Exponential-family common form

== Common form

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(x | eta) = h(x) exp(eta^T T(x) - A(eta))$]
    #v(0.85em)
    #grid(
      columns: (1fr, 1fr, 1fr, 1fr),
      gutter: 0.55em,
      schema-node([$h(x)$], [$"base measure"$]),
      schema-node([$T(x)$], [$"sufficient statistics"$], fill: palette.paper),
      schema-node([$eta$], [$"natural parameter"$]),
      schema-node([$A(eta)$], [$"log partition"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  The exponential-family form factors a distribution into a base measure,
  sufficient statistics, natural parameters, and a normalizer. It is the
  conceptual center of Lecture 2.
]

== Bernoulli in natural coordinates

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(x | eta) = exp(x eta - log(1+exp(eta)))$]
    #v(0.8em)
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.7em,
      schema-node([$eta = log frac(mu, 1-mu)$], [$"natural parameter"$]),
      schema-node([$A(eta) = log(1+exp(eta))$], [$"log partition"$], fill: palette.paper),
      schema-node([$mu = sigma(eta)$], [$"mean"$]),
    )
  ],
)

#speaker-note[
  Bernoulli makes each piece concrete. Log odds are the natural parameter, and
  the logistic sigmoid transforms that parameter back to the mean probability.
]

== Categorical natural parameters

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$eta in RR^C$], [$"natural scores"$]),
      schema-arrow,
      schema-node([$mu = "softmax"(eta)$], [$"simplex mean"$], fill: palette.paper),
    )
    #v(0.85em)
    #align(center)[$p(y | eta) = "Cat"(y | "softmax"(eta))$]
  ],
)

#speaker-note[
  This reconnects the categorical and softmax material from Lecture 1 to
  natural parameters. The logits are now the natural coordinates of a model.
]

== Gaussian sufficient statistics

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$T(x) = [x, x x^T]$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$x$], [$"first moment"$]),
      align(center + horizon)[#text(size: 1.2em, fill: palette.accent)[$,$]],
      schema-node([$x x^T$], [$"second moment"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  A Gaussian's sufficient statistics are its first and second moments. The
  familiar sample mean and covariance MLEs now appear as one family pattern.
]

== Exponential-family map

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #table(
      columns: (1fr, 1fr, 1fr),
      align: center + horizon,
      inset: (x: 8pt, y: 7pt),
      table.header([*Distribution*], [*$T(x)$*], [*Mean map*]),
      [Bernoulli], [$x$], [$sigma(eta)$],
      [Categorical], [$bold(e)_y$], [$"softmax"(eta)$],
      [Gaussian], [$[x, x x^T]$], [$[mu, Sigma + mu mu^T]$],
    )
    #source-note[Course table; exponential-family examples specified for Lecture 2]
  ],
)

#speaker-note[
  This comparison makes the shared structure visible across three familiar
  distributions. Read across rows rather than adding more distribution families.
]

== Summary: Exponential-family common form

#content-block(
  key-points: [
    - $p(x|eta) = h(x) exp(eta^T T(x) - A(eta))$
    - $T(x)$: sufficient statistics
    - $eta$: natural parameters
    - $A(eta)$: log partition function
    - Bernoulli, categorical, and Gaussian share this form
  ],
)

#speaker-note[
  The next section shows why the log partition function is a source of moments,
  not merely a normalizing term.
]

#section-metadata(
  short-title: [Log partition],
  subtitle: [Means and covariance from derivatives],
)

= Log partition function and moments

== The normalizer

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$A(eta) = log Z(eta)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$Z(eta)$], [$"normalizer"$]),
      schema-arrow,
      schema-node([$A(eta)$], [$"log partition"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  Introduce the partition function only as the term that normalizes the
  exponential-family distribution. The payoff arrives in its derivatives.
]

== Derivatives generate moments

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.1em,
      schema-node([$nabla_eta A(eta) = E[T(x)]$], [$"mean sufficient statistic"$]),
      schema-node([$nabla_eta^2 A(eta) = "Cov"[T(x)]$], [$"covariance"$], fill: palette.paper),
    )
    #v(0.85em)
    #align(center)[$A(eta) quad arrow.r quad "mean" quad ";" quad "curvature"$]
  ],
)

#speaker-note[
  The gradient of the log partition function gives model moments and its
  Hessian gives their covariance. State the identities rather than deriving them.
]

== Bernoulli derivatives

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$A(eta) = log(1+exp(eta))$]
    #v(0.75em)
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.1em,
      schema-node([$A'(eta) = sigma(eta)$], [$"mean"$]),
      schema-node([$A''(eta) = sigma(eta)(1-sigma(eta))$], [$"variance"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  Bernoulli gives an immediate one-dimensional check of the general identities:
  the sigmoid is the mean and its derivative is the Bernoulli variance.
]

== Summary: Log partition function

#content-block(
  key-points: [
    - $A(eta) = log Z(eta)$
    - $nabla_eta A(eta) = E[T(x)]$
    - $nabla_eta^2 A(eta) = "Cov"[T(x)]$
    - Log-partition derivatives generate moments and curvature
  ],
)

#speaker-note[
  The log partition function turns the exponential-family algebra into a
  direct link between natural parameters and expected sufficient statistics.
]

#section-metadata(
  short-title: [Moment matching],
  subtitle: [Sufficient statistics as the data's contribution to MLE],
)

= Sufficient statistics and MLE in exponential families

== Data enter through summed statistics

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(D | eta) prop exp(eta^T T(D) - N A(eta))$]
    #v(0.8em)
    #align(center)[$T(D) = sum_(n=1)^N T(x_n)$]
    #v(0.85em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$x_1, dots, x_N$], [$"data"$]),
      schema-arrow,
      schema-node([$T(D)$], [$"summed statistics"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  This is the central data-compression statement. The likelihood depends on
  observations through a sum of sufficient statistics, plus the count N.
]

== Exponential-family score

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #align(center)[$nabla_eta log p(D | eta) = T(D) - N E[T(x)]$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.22fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$T(D)$], [$"empirical total"$]),
      align(center + horizon)[#text(size: 1.2em, fill: palette.accent)[$-$]],
      schema-node([$N E[T(x)]$], [$"model total"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  The score is the gap between what the data contribute and what the model
  expects. An interior MLE sets this gap to zero.
]

== Moment matching

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$E[T(x)] = frac(1,N) sum_(n=1)^N T(x_n)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.22fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$frac(1,N) T(D)$], [$"empirical moments"$]),
      align(center + horizon)[#text(size: 1.2em, fill: palette.accent)[$=$]],
      schema-node([$E_eta[T(x)]$], [$"model moments"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  This is the payoff: exponential-family MLE chooses natural parameters so the
  model moments match empirical sufficient-statistic averages.
]

== Bernoulli and categorical moment matching

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.1em,
      schema-node([Bernoulli], [$mu = frac(1,N) sum_(n=1)^N I(x_n=1)$]),
      schema-node([Categorical], [$mu_k = frac(N_k, N)$], fill: palette.paper),
    )
    #source-note[Course schematic; Book 2 §2.4.5]
  ],
)

#speaker-note[
  These two examples return to the MLEs from earlier in the lecture. Their
  observed proportions are empirical moments matched by the fitted model.
]

== Summary: Sufficient statistics and moment matching

#content-block(
  key-points: [
    - $T(D) = sum_n T(x_n)$
    - Exponential-family likelihood depends on the data through $T(D)$
    - The score compares empirical and model sufficient statistics
    - MLE matches model moments to empirical moments
    - Bernoulli and categorical MLEs are moment matching
  ],
)

#speaker-note[
  This resolves the lecture's central arc. Likelihood optimization, sufficient
  statistics, log partitions, and moment matching are one connected structure.
]

#section-metadata(
  short-title: [Conjugacy],
  subtitle: [Reserve extension from Beta-Binomial to Dirichlet-Multinomial],
)

= Conjugacy extensions

== Dirichlet-Multinomial update

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (1fr, 0.16fr, 1fr, 0.16fr, 1fr),
      gutter: 0.28em,
      align: center + horizon,
      schema-node([$theta tilde "Dir"(alpha)$], [$"prior"$]),
      align(center + horizon)[#text(size: 1.1em, fill: palette.accent)[$times$]],
      schema-node([$N | theta tilde "Mult"(N, theta)$], [$"counts"$], fill: palette.paper),
      align(center + horizon)[#text(size: 1.1em, fill: palette.accent)[$prop$]],
      schema-node([$theta | D tilde "Dir"(alpha + N)$], [$"posterior"$]),
    )
  ],
)

#speaker-note[
  Use only if time permits. This is the multiclass analogue of the familiar
  Beta-Binomial update, written to connect categorical counts to the simplex.
]

== Summary: Conjugacy bridge

#content-block(
  key-points: [
    - $theta tilde "Dir"(alpha)$
    - $N | theta tilde "Mult"(N, theta)$
    - $theta | D tilde "Dir"(alpha + N)$
    - Dirichlet-Multinomial generalizes Beta-Binomial updating
  ],
)

#speaker-note[
  Keep this bridge available as reserve. It reinforces that counts recur as
  sufficient statistics in both likelihood and Bayesian updating.
]

== Lecture 2 summary

#content-block(
  key-points: [
    - MLE: optimize log likelihood or minimize negative log likelihood
    - ERM: replace log loss with an arbitrary loss
    - Regularization and MAP: data fit plus parameter preference
    - Exponential families: one form for Bernoulli, categorical, and Gaussian models
    - Log partition derivatives generate moments
    - Exponential-family MLE matches empirical and model moments
    - Sufficient statistics state what the data contribute to the likelihood
  ],
)

#speaker-note[
  Finish with the unifying view. Students should leave able to move between a
  model, its likelihood, the optimization objective, its sufficient statistics,
  and the moment-matching interpretation of an exponential-family MLE.
]
