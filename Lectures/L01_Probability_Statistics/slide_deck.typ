// Lecture 1 — Probabilistic Machine Learning
#import "../course.typ": *

#let lecture = (
  number: 1,
  title: [Probability and Bayesian Statistics],
  short-title: [Probability & Statistics],
  subtitle: [From Bayesian statistics to probabilistic machine learning],
)

#show: course-theme.with(info: lecture)

#title-slide()

// These are lecture-local structural conveniences only.
// They intentionally carry no independent visual theme.
#let twocol(left, right) = grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  align: top,
  left, right,
)

#let triad(a, b, c) = grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 0.8em,
  align: top,
  a, b, c,
)

#section-slide(
  title: [A familiar modeling language],
  short-title: [Probabilistic modelling],
  subtitle: [Probablistic models update based on data],
)

== The Beta-Binomial model

#content-block(
  layout: "top",
  object-width: 82%,

  object: [
    #align(center)[
      #twocol[
        *Observed*\
        the coin tosses $y_1, dots, y_N$
      ][
        *Unknown*\
        the coin bias $theta$
      ]

      #uncover("2-")[
        $theta tilde "Beta"(alpha, beta)$
        \
        $y_i | theta tilde "Bernoulli"(theta), quad i = 1, dots, N$
      ]
    ]
  ],
  key-points: [
    - A statistical model has data and unknown parameters
    #uncover("2-")[
      - How could observed data ($y$) could have been generated.
      - What does it tell us about the parameters ($theta$)
    ]
  ],
)

#speaker-note[
  The first step in reactivating the undergraduate course is to remind them of the language of models.
]

== Models are built out of distributions

#content-block(
  layout: "side-left",
  object-width: 60%,
  object: [
    #grid(
      columns: (28%, 1fr),
      column-gutter: 1.2em,
      row-gutter: 0.25em,
      align: center + horizon,

      [
        #align(center)[
          #text(size: 0.68em)[
            $theta tilde "Beta"(alpha, beta)$
          ]
        ]
      ],
      [
        #course-figure(
          path("figures/coin_model__beta_distribution.svg"),
          source: "figures/coin_model__beta_distribution.svg",
          width: 100%,
          height: 4cm,
        )
      ],
      [
        #uncover("2-")[
          #align(center)[
            #stack(
              spacing: 0.2em,
              text(size: 0.68em)[$y_i | theta tilde "Bernoulli"(theta)$],
              text(size: 0.68em, fill: palette.muted)[$i = 1, dots, N$],
            )
          ]
        ]
      ],
      [
        #uncover("2-")[
          #course-figure(
            path("figures/coin_model__bernoulli_likelihood.svg"),
            source: "figures/coin_model__bernoulli_likelihood.svg",
            width: 100%,
            height: 4cm,
          )
        ]
      ],
    )
  ],
  key-points: [
    #text(size: 0.82em)[
      - Beta for continuous variables on $[0,1]$.
      #uncover("2-")[
        - Bernoulli four the number of counts in a yes/no process.
      ]
      #uncover("3-")[
        - Distributions are parameterized families
      ]
    ]
  ],
)

#speaker-note[
  Reactivate distributions are parameterized families and start remembering a few that they know.
]

== Models can be drawn as graphs

#stack(
  spacing: 0.7em,
  content-block(
    layout: "side-left",
    object-width: 55%,

    object: [
      #twocol[
        #text(size: 1em)[
          $theta tilde "Beta"(alpha, beta)$
          \
          $y_i | theta tilde "Bernoulli"(theta)$
        ]
      ][
        #align(center + horizon)[
          #course-diagram(
            spacing: (4.2em, 3em),
            node-stroke: 1.2pt + palette.dark,
            node-fill: palette.paper,
            edge-stroke: 1.4pt + palette.accent,
            mark-scale: 70%,

            graph-node(
              (0, 0),
              name: <hyperparameters>,
              stroke: none,
              fill: none,
            )[
              #stack(
                spacing: 0.3em,
                text(size: 1.2em)[$alpha, beta$],
              )
            ],

            graph-node(
              (0, 1),
              name: <theta-node>,
              shape: circle,
              width: 2em,
              height: 2em,
            )[$theta$],

            graph-node(
              (0, 2),
              name: <data-node>,
              shape: circle,
              width: 2em,
              height: 2em,
              fill: palette.accent.lighten(78%),
            )[$y_i$],

            graph-edge(<hyperparameters>, <theta-node>, "-|>"),
            graph-edge(<theta-node>, <data-node>, "-|>"),

            graph-node(
              (0.1, 1.5),
              stroke: none,
              fill: none,
            )[$i$],
          )
        ]
      ]
    ],

    key-points: [
      - Nodes represent quantities.
        - Shading marks observed data.
      #uncover("2-")[
        - Arrows encode conditional dependence.
          - We will not use Kruschke diagrams
      ]
    ],
  ),

  pause,

  note([
    Using conditional independence to factor problems into smaller, more tractable ones is a central shift with big, complex data.
  ]),
)

#speaker-note[
  Introduce graphical-model notation through the familiar Beta-Binomial model. Emphasize the new types of graphs that are familiar from the previous course but not the heart of it.
]

== Bayes updates a distribution, not just an estimate

#course-figure(
  path("figures/coin_model__prior_likelihood_posterior.svg"),
  source: "figures/coin_model__prior_likelihood_posterior.svg",
  caption: [Bayesian updating for the familiar coin model],
  width: 82%,
  height: 9cm,
)

#text(size: 0.8em)[
  With a Beta prior and Binomial likelihood, the posterior is again Beta.
  The old course used this example to make prior, likelihood, posterior,
  and uncertainty concrete.
]

#speaker-note[
  Remind them that with a uniform Beta(1,1) prior and 7 heads in 10 tosses,
  the posterior is Beta(8,4). Do not derive conjugacy again unless the room needs it.
]

== Evidence accumulates

#course-figure(
  path("figures/coin_model__sequential_updating.svg"),
  source: "figures/coin_model__sequential_updating.svg",
  caption: [Evidence accumulates under different priors],
  width: 96%,
  height: 7cm,
)

#key-points[
  Bayesian learning means carrying uncertainty forward as new evidence arrives.
  Different priors can matter strongly at first and less as evidence accumulates.
]

#speaker-note[
  This deliberately echoes the sequential-updating sequence from the undergraduate
  Models lecture: three priors, then repeated updates. The goal is recognition.
]

== The posterior was never the whole story

From the posterior we can ask about *future data*:

#align(center)[
  $p(tilde(y) | D) = integral p(tilde(y) | theta) p(theta | D) d theta$
]

#course-figure(
  path("figures/coin_model__posterior_predictive.svg"),
  source: "figures/coin_model__posterior_predictive.svg",
  caption: [Posterior uncertainty induces a predictive distribution],
  width: 84%,
  height: 5.5cm,
)

#key-points[
  Inference asks what we know about unknown quantities.
  Prediction asks what the model says will happen next.
]

#speaker-note[
  This is the first genuine pivot. In the undergraduate course the posterior was
  often the focal object. In probabilistic ML, it is frequently an intermediate
  object used to construct a predictive or generative distribution.
]

== And exact calculation was a luxury

For the coin model, many quantities can be calculated analytically.

But we already learned another route:

#align(center)[
  $bb(E)_(theta | D)[f(theta)] approx 1 / S sum_(s=1)^S f(theta^(s))$
]

#course-figure(
  path("figures/coin_model__sampling_monte_carlo.svg"),
  source: "figures/coin_model__sampling_monte_carlo.svg",
  caption: [Posterior samples approximate expectations and integrals],
  width: 80%,
  height: 4.7cm,
)

#note[
  When models become high-dimensional, exact posteriors and exact predictive
  integrals are usually unavailable. Computational inference stops being an
  implementation detail and becomes a central part of the course.
]

== So what actually changes?

#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  align: left + top,

  [*The grammar carries over*], [*The pressure changes*],

  [Joint and conditional distributions], [High-dimensional models],

  [Prior, likelihood, posterior], [Many latent quantities],

  [Prediction from a generative model], [Intractable sums and integrals],

  [Sampling as approximation], [Multiple approximation strategies],
)

#key-points[
  The course is not replacing Bayesian statistics.
  It is taking the same probabilistic grammar into problems where
  prediction, representation, and computation become central.
]

== The coin model as a map for today

#align(center)[
  $"model" arrow.r "posterior" quad arrow.r "prediction" arrow.r "approximation" arrow.r "structure"$
]

#text(size: 0.8em)[
  We will keep reusing this pattern with richer distributions,
  multivariate variables, latent structure, and models whose required
  integrals cannot be solved exactly.
]

#speaker-note[
  From here move into the rest of Lecture 1:
  model grammar -> transformations -> exponential families -> multivariate Gaussian
  -> typical sets -> comparing distributions.
]


== What carries over, what changes


#grid(
  columns: (1fr, 1fr),
  gutter: 1.2em,
  row-gutter: 0.5em,
  align: left + top,

  [*What carries over*], [*What changes*],

  [Probability and Bayesian reasoning], [Scale],

  [Familiar statistical notation], [More compact notation],

  [Statistical modeling], [Prediction, generation, and discovery],
)

#speaker-note[
  This reworked version assumes the students' undergraduate Bayesian-first statistics course as real prior knowledge. Do not spend 45 minutes reteaching probability rules. Use the opening section to reactivate and diagnose.
]

== The first lecture has one job

By the end of today, students should be able to read a compact model statement and say:

#align(center)[$
  "What is observed?" quad "What is unknown?" quad "What is predicted?"
$]

#key-points[Probability is the language. Modeling is the grammar. Machine learning changes the scale and the task.]

== What I will assume from the undergraduate course

#twocol[
  *Seen before*
  - Probability distributions
  - Bayes' rule and updating
  - Likelihood / prior / posterior
  - PyMC and posterior samples
  - Posterior predictive checks
][
  *Also seen before*
  - Hierarchical / partial-pooling models
  - Normal and linear models
  - ANOVA as regression structure
  - Bayesian model comparison
  - Reproducible workflow
]

#note[*Diagnostic checkpoint:* If these words feel completely unfamiliar, today's notebook tells us where review is needed.]

== Distribution families: review, not a live catalogue

You have seen the idea of distributions. This course needs fluent recognition, not memorized formula tables.

#twocol[
  *Self-study target*
  - Bernoulli / categorical
  - Binomial / multinomial
  - Poisson / negative binomial
  - Gaussian / Student / Laplace
][
  *When we use them*
  - likelihoods for data types
  - priors over parameters
  - predictive distributions
  - latent-state models
]

#key-points[A short self-study notebook or screencast will review distribution families as modeling building blocks. Lecture time is reserved for the structures we repeatedly manipulate.]

#speaker-note[
  Do not teach the catalogue now. Tell them explicitly that the catalogue is important but belongs in self-study. The purpose is to prevent anxiety: distributions are review material; the lecture is about how distributions become models.
]

== What is new in this course

#triad[
  *Scale*\
  high-dimensional variables, large models, many latent quantities
][
  *Structure*\
  graphical models, factorisations, conditional independence
][
  *Tasks*\
  prediction, generation, discovery, representation
]

#key-points[Advanced probabilistic ML is not a new statistics course; it is Bayesian/statistical modeling under new computational and modeling pressures.]

== The course arc

#align(center)[
  fundamentals $arrow.r$ inference $arrow.r$ prediction $arrow.r$ generation $arrow.r$ discovery
]

#v(1em)

#twocol[
  *Today*\
  re-establish the common model language
][
  *Next time*\
  graphical models + information theory
]

#note[Today's lecture should make the next lecture feel inevitable rather than disconnected.]

#section-slide(
  title: [The grammar of probabilistic models],
  short-title: [Model grammar],
  subtitle: [Observed quantities, unknown quantities, predictions, and factorization],
)

== Three recurring model objects

#triad[
  *Observed data*\
  $D$, $x$, $y$\
  #text(size: 0.8em)[what we measured]
][
  *Unknown quantities*\
  $theta$, $z$\
  #text(size: 0.8em)[parameters and latent variables]
][
  *Future quantities*\
  $tilde(y)$, $tilde(x)$\
  #text(size: 0.8em)[what we want to predict or generate]
]

#key-points[Most confusion in probabilistic ML is confusion about which object a distribution is over.]

== A model is a joint distribution plus a question

#align(center)[$
  p(D, theta, z, tilde(y))
$]

Different questions extract different conditionals:

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  [*Question*], [*Typical conditional*],
  [inference], [$p(theta, z | D)$],
  [prediction], [$p(tilde(y) | D)$],
  [latent discovery], [$p(z | x, D)$],
  [generation], [$p(tilde(x) | D)$ or $p(tilde(x) | c, D)$],
)

== Factorisation is where assumptions live

The same joint distribution can be written as products of simpler terms.

#align(center)[$
  p(D, theta) = p(D | theta) p(theta)
$]

#align(center)[$
  p(x, z) = p(x | z) p(z)
$]

#align(center)[$
  p(y, x, theta) = p(y | x, theta) p(x) p(theta)
$]

#key-points[Model structure is not decoration; it is the set of independence and generative assumptions.]

== Do not mix up these distributions

#table(
  columns: (auto, 1fr, 1fr),
  inset: 8pt,
  [*Expression*], [*Distribution over*], [*Role*],
  [$p(y | theta)$], [data $y$], [sampling / observation model],
  [$p(D | theta)$], [viewed as a function of $theta$], [likelihood],
  [$p(theta)$], [parameter $theta$], [prior],
  [$p(theta | D)$], [parameter $theta$], [posterior],
  [$p(tilde(y) | D)$], [future data], [posterior predictive],
)

#note[*Common trap:* A likelihood is not a probability distribution over $theta$ until it is multiplied by a prior and normalized.]

#section-slide(
  title: [Fast reactivation: probability and Bayes],
  short-title: [Probability & Bayes],
  subtitle: [Only the probability machinery we will use repeatedly],
)

== Probability calculus in one slide

#twocol[
  *Rules we use constantly*
  - product rule
  - sum / marginalisation rule
  - conditioning
  - Bayes' rule
][
  #align(center)[$p(a,b)=p(a|b)p(b)$]
  #align(center)[$p(a)=sum_b p(a,b)$]
  #align(center)[$p(a|b)=frac(p(a,b), p(b))$]
]

#key-points[Nearly every derivation in the course is product-rule plus sum-rule plus normalization.]

== Transforming variables: the equation we will need

If $y = g(x)$ is invertible, probability mass is preserved but density changes:

#align(center)[$
  p_y(y) = p_x(g^(-1)(y)) abs(frac(d g^(-1)(y), d y))
$]

In multiple dimensions:

#align(center)[$
  p_y(bold(y)) = p_x(g^(-1)(bold(y))) abs(det frac(partial g^(-1)(bold(y)), partial bold(y)))
$]

#key-points[Changing coordinates changes densities through the Jacobian. This is the root of reparameterization tricks and normalizing flows.]

== Bayes' rule as workflow

#align(center)[$
  p(theta | D) = frac(p(D | theta) p(theta), p(D))
$]

#align(center)[$
  p(D) = integral p(D | theta) p(theta) d theta
$]

#triad[
  prior\
  #text(size: 0.8em)[what values were plausible?]
][
  likelihood\
  #text(size: 0.8em)[which values explain the data?]
][
  posterior\
  #text(size: 0.8em)[what remains plausible?]
]

== Posterior prediction is the payoff

#align(center)[$
  p(tilde(y) | D) = integral p(tilde(y) | theta) p(theta | D) d theta
$]

#key-points[Prediction averages over uncertainty. It is not just plugging in one best parameter.]

#note[This is the bridge from Bayesian statistics to machine learning: learn from data, then predict, generate, or infer hidden structure.]

== Model checking: compare data to replicated data

A fitted model implies new datasets:

#align(center)[$
  p(tilde(D) | D) = integral p(tilde(D) | theta) p(theta | D) d theta
$]

Choose a statistic or visual summary $T( dot )$ and compare:

#align(center)[$
  T(D) quad "vs." quad T(tilde(D))
$]

#key-points[Model comparison asks which model is better. Model checking asks whether the model is good enough to trust.]

== Point estimates are not the model

#twocol[
  *Point summaries*
  - MLE
  - MAP
  - posterior mean
  - posterior median
][
  *Full inferential object*
  #align(center)[$p(theta | D)$]
  #align(center)[$p(tilde(y) | D)$]
]

#key-points[We will often optimize point objectives, but the probabilistic target is still a distribution.]

#section-slide(
  title: [Anchor example: the coin model, compressed],
  short-title: [Coin model],
  subtitle: [The full probabilistic workflow in one deliberately simple model],
)

== Coin model: data and parameter

Let $y_n in {0,1}$, where 1 means heads.

#align(center)[$
  y_n | theta tilde "Ber"(theta)
$]

#align(center)[$
  D = {y_1, dots, y_N}, quad theta = P(y_n = 1)
$]

#key-points[$D$ is observed. $theta$ is unknown. The model connects them.]

== Likelihood: from observations to counts

Assuming conditionally independent trials:

#align(center)[$
  p(D | theta) = product_(n=1)^N theta^(y_n) (1-theta)^(1-y_n)
$]

Let $N_1=sum_n y_n$ and $N_0=N-N_1$.

#align(center)[$
  p(D | theta) prop theta^(N_1) (1-theta)^(N_0)
$]

#key-points[The sequence has been compressed to sufficient statistics for this model.]

== Beta prior and Beta posterior

#align(center)[$
  theta tilde "Beta"(alpha, beta)
$]

#align(center)[$
  p(theta) prop theta^(alpha-1) (1-theta)^(beta-1)
$]

Combine prior and likelihood:

#align(center)[$
  theta | D tilde "Beta"(alpha + N_1, beta + N_0)
$]

#key-points[Conjugacy here is closure under updating: posterior has the same family as the prior.]

== Predicting the next toss

#align(center)[$
  P(tilde(y)=1 | D) = integral theta p(theta | D) d theta
$]

#align(center)[$
  P(tilde(y)=1 | D) = frac(alpha + N_1, alpha + beta + N)
$]

#key-points[The predictive probability is the posterior mean of the coin bias, not necessarily the MLE.]

== Why keep this elementary example?

The coin model contains the whole course in miniature:

#triad[
  *model*\
  $p(D | theta) p(theta)$
][
  *inference*\
  $p(theta | D)$
][
  *prediction*\
  $p(tilde(y) | D)$
]

#note[Later models change the variables and the algorithms, not the basic grammar.]

#section-slide(
  title: [Exponential families: the reusable structure],
  short-title: [Exponential families],
  subtitle: [A common algebraic skeleton behind many probabilistic models],
)

== The common form

Many distributions we use can be written as:

#align(center)[$
  p(x | eta) = h(x) exp(eta^T T(x) - A(eta))
$]

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  [$T(x)$], [sufficient statistics: what the data contributes],
  [$eta$], [natural parameters: the coordinates in which updates often simplify],
  [$A(eta)$], [log-partition function: the normalization term],
  [$h(x)$], [base measure: what is left over],
)

#key-points[The exponential family explains why many apparently different models have the same algebraic skeleton.]

== Bernoulli as an exponential-family model

Start with:

#align(center)[$
  p(y | theta) = theta^y (1-theta)^(1-y)
$]

Rewrite:

#align(center)[$
  p(y | eta) = exp(y eta - log(1 + exp(eta)))
$]

where:

#align(center)[$
  eta = log frac(theta, 1-theta), quad T(y)=y, quad A(eta)=log(1+exp(eta))
$]

#key-points[The log-odds is the natural parameter of the Bernoulli. This is why logistic models are so central.]

== Data enter through sufficient statistics

For independent observations:

#align(center)[$
  p(D | eta) = product_n h(y_n) exp(eta^T T(y_n) - A(eta))
$]

#align(center)[$
  p(D | eta) prop exp(eta^T sum_n T(y_n) - N A(eta))
$]

#key-points[The full dataset often enters the likelihood through $sum_n T(y_n)$. That is the deeper version of "heads and tails are enough" in the coin model.]

== Why the log-partition function matters

The normalization term is not bookkeeping. Its derivatives encode moments:

#align(center)[$
  bb(E)_eta [T(X)] = nabla_eta A(eta)
$]

#align(center)[$
  "Cov"_eta(T(X)) = nabla_eta^2 A(eta)
$]

#key-points[The same object that normalizes the distribution also gives means, variances, and local curvature. This is the bridge to Fisher information and optimization geometry.]

== Why this matters for probabilistic ML

Exponential-family structure reappears in:

#twocol[
  - generalized linear models
  - conjugate priors
  - variational inference
  - message passing
][
  - natural-gradient ideas
  - Fisher information
  - Gaussian approximations
  - maximum-entropy models
]

#note[The point is not to memorize the taxonomy. The point is to recognize when a model has algebra we can exploit.]

#section-slide(
  title: [From scalar uncertainty to multivariate structure],
  short-title: [Multivariate Gaussian],
  subtitle: [Dependence, geometry, conditioning, and high-dimensional probability],
)

== Why the multivariate Gaussian matters

Many later models reduce locally, approximately, or exactly to Gaussian algebra:

#twocol[
  - Gaussian processes
  - Kalman filters
  - Laplace approximations
  - variational approximations
][
  - Bayesian linear models
  - factor models
  - state-space models
  - neural-network uncertainty approximations
]

#key-points[The multivariate Gaussian is not just another distribution; it is a computational workhorse.]

== Multivariate Gaussian: object and geometry

#align(center)[$
  bold(x) tilde cal(N)(bold(mu), Sigma)
$]

#align(center)[$
  p(bold(x)) prop |Sigma|^(-1/2)
  exp(-frac(1, 2)(bold(x)-bold(mu))^T Sigma^(-1)(bold(x)-bold(mu)))
$]

#key-points[$bold(mu)$ locates the cloud; $Sigma$ sets its size, orientation, and dependence structure.]

== Covariance is geometry

#twocol[
  *Diagonal covariance*
  #align(center)[$Sigma = "diag"(sigma_1^2, dots, sigma_D^2)$]
  #text(size: 0.8em)[axis-aligned uncertainty]
][
  *Full covariance*
  #align(center)[$Sigma_(i j) = "Cov"(X_i, X_j)$]
  #text(size: 0.8em)[tilted / coupled uncertainty]
]

#key-points[Correlations are geometric constraints on plausible joint variation.]

== Typical sets: high-dimensional Gaussians are not near the mode

For $bold(x) ~ cal(N)(bold(0), I_D)$:

#align(center)[$
  R^2 = norm(bold(x))^2 = sum_(i=1)^D x_i^2 tilde chi^2_D
$]

#align(center)[$
  bb(E)[R^2] = D, quad "Var"(R^2) = 2D, quad frac("sd"(R^2), bb(E)[R^2]) = sqrt(frac(2, D)) arrow.r 0
$]

#key-points[In high dimensions, most probability mass is in a thin shell. The mode can be a terrible guide to typical samples.]

#speaker-note[
  They have seen the idea of typical sets before; this slide supplies the Murphy-style quantification. Emphasize that density and probability mass diverge in high dimension because volume matters.
]

== Marginalization: ignore variables properly

Partition:

#align(center)[$
  bold(x) = mat(bold(x)_1; bold(x)_2), quad
  Sigma = mat(Sigma_11, Sigma_12; Sigma_21, Sigma_22)
$]

For a joint Gaussian:

#align(center)[$
  p(bold(x)_1) = cal(N)(bold(x)_1 | bold(mu)_1, Sigma_11)
$]

#key-points[Gaussian marginalization is easy in moment form: keep the relevant block.]

== Conditioning: use observations to update expectations

#align(center)[$
  p(bold(x)_1 | bold(x)_2) = cal(N)(bold(x)_1 | bold(mu)_(1|2), Sigma_(1|2))
$]

#align(center)[$
  bold(mu)_(1|2) = bold(mu)_1 + Sigma_12 Sigma_22^(-1) (bold(x)_2 - bold(mu)_2)
$]

#align(center)[$
  Sigma_(1|2) = Sigma_11 - Sigma_12 Sigma_22^(-1) Sigma_21
$]

#key-points[Conditioning shifts the mean and removes uncertainty explained by the observed variables.]

== Precision form: why inverse covariance appears everywhere

Define:

#align(center)[$
  Lambda = Sigma^(-1), quad eta = Sigma^(-1) bold(mu)
$]

Then the Gaussian can be written as:

#align(center)[$
  p(bold(x)) prop exp(eta^T bold(x) - frac(1, 2) bold(x)^T Lambda bold(x))
$]

#key-points[Precision form makes many updates additive and connects naturally to exponential-family notation.]

#section-slide(
  title: [Comparing distributions: the ML pressure point],
  short-title: [Comparing distributions],
  subtitle: [Why divergences become training and approximation objectives],
)

== Divergences: when the object being compared is a distribution

A divergence measures mismatch between distributions, not merely between point estimates.

#align(center)[$
  D_"KL"(q || p) = bb(E)_(q(x)) [log frac(q(x), p(x))]
$]

#twocol[
  *Statistics framing*\
  estimate parameters, quantify uncertainty, check model adequacy
][
  *ML framing*\
  learn predictive distributions, compare approximations, optimize scalable objectives
]

#key-points[When the target is a predictive or posterior distribution, training and evaluation naturally become distribution-comparison problems.]

== Two places divergences will appear

#twocol[
  *Prediction*\
  fit $p_theta(y|x)$ so the predictive distribution assigns high probability to held-out data.

  #align(center)[$- log p_theta(y | x)$]
][
  *Approximate inference*\
  choose an approximation $q(theta)$ close to the posterior $p(theta | D)$.

  #align(center)[$D_"KL"(q(theta) || p(theta | D))$]
]

#note[We will not catalogue divergences today. We will use this idea when we reach information theory and variational inference.]

#section-slide(
  title: [Looking forward: probability as ML infrastructure],
  short-title: [Looking forward],
  subtitle: [Prediction, generation, discovery, and computational inference],
)

== Prediction, generation, discovery

#triad[
  *Prediction*\
  $p(y | x, D)$\
  #text(size: 0.8em)[labels, regressions, decisions]
][
  *Generation*\
  $p(x | D)$ or $p(x | c, D)$\
  #text(size: 0.8em)[new plausible data]
][
  *Discovery*\
  $p(z | x, D)$\
  #text(size: 0.8em)[hidden structure]
]

#key-points[The same grammar supports all three tasks; what changes is the conditional we care about.]

== Latent variables change the target

#align(center)[$
  p(z, x) = p(z) p(x | z)
$]

After observing $x$:

#align(center)[$
  p(z | x) = frac(p(x | z) p(z), p(x))
$]

#note[This is the logic behind mixture models, factor models, VAEs, state-space models, and representation learning.]

== Why inference algorithms dominate the course

Often the quantity we want is easy to write and hard to compute:

#align(center)[$
  p(theta, z | D) = frac(p(D, theta, z), integral sum_z p(D, theta, z) d theta)
$]

#key-points[The model gives the target distribution; inference algorithms are how we approximate it.]

== Notebook bridge for today

The first notebook should do five things:

1. Recreate the beta-binomial update.
2. Plot prior, likelihood, posterior, and posterior predictive samples.
3. Show how posterior samples approximate integrals.
4. Quantify the typical-set effect for a high-dimensional Gaussian.
5. Introduce a small multivariate Gaussian conditioning example.

#note[*Diagnostic checkpoint:* This tells us whether Lecture 2 can assume notation fluency or needs more scaffolding.]

== Diagnostic questions before next time

Students should be able to answer:

- Is this expression over data, parameters, latent variables, or predictions?
- Which factorization assumptions are being made?
- What is being conditioned on?
- What integral, sum, or Jacobian term is hard?
- What approximation might be needed?
- How would we check whether replicated data look like observed data?

#key-points[These questions will work for almost every model in the course.]

== Summary

- We are building on a Bayesian-first undergraduate course, not repeating it.
- Bayes' rule is now a modeling grammar for ML tasks.
- Posterior predictive inference is the bridge to prediction.
- Multivariate Gaussian algebra is a central tool for dependence and conditioning.
- The next step is graphical structure and information-theoretic objectives.

#align(center)[[Next: graphical models + information theory]]

#section-slide(
  title: [Reserve / expansion slides],
  short-title: [Reserve],
  subtitle: [Material to use only if the room needs additional reactivation],
)

== Reserve: probability space

#align(center)[$
  (Omega, cal(F), P), quad P: cal(F) -> [0,1]
$]

#triad[
  *$Omega$*\
  sample space
][
  *$cal(F)$*\
  event space
][
  *$P$*\
  probability measure
]

#key-points[Useful only if students are shaky on the mathematical foundation.]

== Reserve: random variables and densities

#twocol[
  *Discrete*\
  #align(center)[$p_X(a) = P(X = a)$]
][
  *Continuous*\
  #align(center)[$P(a <= X <= b) = integral_a^b p_X(x) d x$]
]

#note[*Common trap:* A density value is not a probability.]

== Reserve: common scalar distributions

#table(
  columns: (auto, 1fr),
  inset: 8pt,
  [*Distribution*], [*When it appears*],
  [Bernoulli], [one binary outcome],
  [Binomial], [count of successes],
  [Categorical], [one class among $K$],
  [Multinomial], [count vector across classes],
  [Poisson], [counts per unit exposure],
  [Gaussian], [continuous measurement/noise/approximation],
)

== Reserve: credible intervals

#align(center)[$
  P(a <= theta <= b | D) = 0.95
$]

#twocol[
  *Central interval*\
  equal tail probability
][
  *HDI*\
  shortest high-density region
]

#key-points[The probability statement is about $theta$ conditional on the observed data and the model.]

== Reserve: Dirichlet-multinomial

#align(center)[$
  bold(theta) tilde "Dir"(bold(alpha))
$]

#align(center)[$
  bold(theta) | D tilde "Dir"(bold(alpha) + bold(N))
$]

#key-points[This is the categorical/multinomial analogue of beta-binomial updating.]

== Reserve: Gaussian conjugacy in one line

Known variance, unknown mean:

#align(center)[$
  y_n | mu tilde cal(N)(mu, sigma^2), quad mu tilde cal(N)(m_0, v_0)
$]

#align(center)[$
  mu | D tilde cal(N)(m_N, v_N)
$]

#key-points[Precision form makes the posterior update look like adding evidence.]

== Reserve: Markov property

#align(center)[$
  p(x_(1:T)) = p(x_1) product_(t=2)^T p(x_t | x_(t-1))
$]

#key-points[A Markov chain is a structured joint distribution over a sequence.]

== Reserve: transition matrix propagation

#align(center)[$
  pi_(t+1) = pi_t A, quad pi_(t+n) = pi_t A^n
$]

#align(center)[$
  pi = pi A
$]

#key-points[Stationarity is a fixed point of repeated probabilistic transition.]

== Revision notes

- Basic probability is now reserve material, not the live spine.
- The live spine is: model grammar $arrow.r$ Bayes/prediction $arrow.r$ multivariate Gaussian $arrow.r$ ML tasks.
- Add notebook-generated plots after choosing the first coding example.
- Consider moving precision-form slide to reserve if the class looks rusty.
- Keep Markov chains for Lecture 2 unless needed as a sequence-model teaser.
