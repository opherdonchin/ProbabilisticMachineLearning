// Archived Lecture 1 slides displaced by the Gaussian revision.
// This reference deck is not part of the current lecture.
#import "../course.typ": *
#let lecture = (
  number: 1,
  title: [Probability and Bayesian Statistics],
  short-title: [Probability & Statistics],
  subtitle: [Archived remainder slides],
)
#show: course-theme.with(info: lecture)
#let lecture-figure-path(file) = "L01_Probability_Statistics/" + file

#title-slide()

= Archived remainder slides

= Categorical, multinomial, and softmax

== Categorical labels

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$"Cat"(y | theta) = product_(c=1)^C theta_c^(I(y = c))$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$y in {1, dots, C}$], [$"one label"$]),
      schema-arrow,
      schema-node([$theta in Delta^(C-1)$], [#stack(spacing: 0.12em, [$0 <= theta_c <= 1$], [$sum_c theta_c = 1$])]),
    )
  ],
)

#speaker-note[
  The categorical distribution is the multiclass extension of Bernoulli. The
  simplex constraints, rather than any fitting method, are the important new
  object on this slide.
]

== One-hot encoding

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$y = 2$], [$"class index"$]),
      schema-arrow,
      schema-node([$bold(y) = (0, 1, 0)^T$], [$"one-hot vector"$]),
    )
    #v(0.9em)
    #align(center)[$"Cat"(y | theta) = product_(c=1)^C theta_c^(y_c)$]
  ],
)

#speaker-note[
  One-hot notation lets the categorical probability be written as a product
  with a single active class. It is convenient for vector-valued models.
]

== Multinomial counts

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #grid(
      columns: (1fr, 0.18fr, 1.4fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$N = (N_1, dots, N_C)$], [$sum_c N_c = N$]),
      schema-arrow,
      schema-node([$"Mult"(N | N, theta)$], [$binom(N, N_1, dots, N_C) product_(c=1)^C theta_c^(N_c)$]),
    )
    #source-note[Course schematic; Book 1 §2.5]
  ],
)

#speaker-note[
  The categorical model describes one label. The multinomial describes the
  counts after repeated categorical draws. Counts are the natural summary of
  repeated categorical outcomes.
]

== Softmax

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1.3fr, 0.2fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([$a in RR^C$], [$"logits"$]),
      schema-arrow,
      uncover("2-")[
        #schema-node([$"softmax"(a)_c = frac(exp(a_c), sum_(c') exp(a_(c')))$], [$"normalization"$], fill: palette.paper)
      ],
      uncover("2-")[#schema-arrow],
      uncover("3-")[#schema-node([$theta in Delta^(C-1)$], [$"class probabilities"$])],
    )
  ],
)

#speaker-note[
  Softmax is a map from arbitrary real-valued scores to a point on the
  probability simplex. Do not derive cross-entropy or optimization here.
]

== Multiclass logistic notation

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(y | x; theta) = "Cat"(y | "softmax"(W x + b))$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.18fr, 1fr, 0.18fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([$x$], [$"features"$]),
      schema-arrow,
      schema-node([$W x + b$], [$"scores"$], fill: palette.paper),
      schema-arrow,
      schema-node([$p(y | x; theta)$], [$"categorical output"$]),
    )
  ],
)

#speaker-note[
  Treat this as notation preparation. The slide connects features, a linear
  score vector, softmax, and a categorical distribution without teaching the
  fitting algorithm.
]

== Summary: Categorical, multinomial, and softmax

#content-block(
  key-points: [
    - Categorical: one multiclass label
    - One-hot vectors encode class membership
    - Multinomial: counts from repeated categorical draws
    - Softmax maps logits to the probability simplex
    - $p(y | x; theta) = "Cat"(y | "softmax"(W x + b))$
  ],
)

#speaker-note[
  The categorical family gives the probability language for the classification
  problems introduced earlier: a single label, a one-hot representation,
  repeated counts, and normalized logits are different views of multiclass
  outcomes.
]

#section-metadata(
  short-title: [Empirical distribution],
  subtitle: [Observed data as a distribution of point masses],
)

= Dirac delta and empirical distribution

== Point mass

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$lim_(sigma -> 0) cal(N)(y | mu, sigma^2) = delta(y - mu)$]
    #v(1em)
    #grid(
      columns: (1fr, 0.22fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$cal(N)(y | mu, sigma^2)$], [$sigma^2 " tends to " 0$]),
      schema-arrow,
      schema-node([$delta(y - mu)$], [$"all mass at " mu$]),
    )
  ],
)

#speaker-note[
  Use the narrow-Gaussian limit as an intuition for a point mass. The purpose
  is the empirical distribution, not distribution-theoretic details.
]

== Empirical distribution

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p_D (y) = frac(1, N) sum_(n=1)^N delta(y - y_n)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$y_1, dots, y_N$], [$"observations"$]),
      schema-arrow,
      schema-node([$p_D$], [$1/N, 1/N, dots, 1/N$]),
    )
    #source-note[Course schematic; empirical-distribution definition in the coverage specification]
  ],
)

#speaker-note[
  The empirical distribution makes the observed dataset into a distribution:
  equal mass at each observed value. It represents the sample without adding
  smoothing or a parametric assumption.
]

== Summary: Empirical distribution

#content-block(
  key-points: [
    - $delta(y - mu)$: a point mass at $mu$
    - $p_D (y) = 1/N sum_n delta(y-y_n)$
    - The empirical distribution records observations without smoothing
  ],
)

#speaker-note[
  This short section closes by identifying the empirical distribution as a
  distributional representation of observed data, with equal point masses and
  no smoothing.
]

#section-metadata(
  short-title: [Covariance],
  subtitle: [Joint variation as geometry],
)

= Covariance, correlation, and dependence

== Covariance

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (1.1fr, 0.95fr),
      gutter: 1.0em,
      align: center + horizon,
      [
        #course-figure(
          lecture-figure-path("figures/book1_fig1_3_iris_pairplot.png"),
          source: "Murphy (2025), Book 1, Fig. 1.3; generated by iris_plot.ipynb",
          width: 100%,
          height: 6.4cm,
          show-source: false,
        )
      ],
      [
        #stack(
          spacing: 0.85em,
          align(center)[$"Cov"[X,Y] = E[(X-E[X])(Y-E[Y])]$],
          uncover("2-")[
            #grid(
              columns: (1fr, 1fr, 1fr),
              gutter: 0.35em,
              schema-node([$> 0$], [$+$]),
              schema-node([$= 0$], [$0$], fill: palette.paper),
              schema-node([$< 0$], [$-$]),
            )
          ]
        )
      ],
    )
    #figure-source("Murphy (2025), Book 1, Fig. 1.3; generated by iris_plot.ipynb")
  ],
)

#speaker-note[
  Covariance records co-variation around the means. The three symbolic panels
  show how the sign of covariance describes the orientation of joint variation.
]

== Covariance matrix

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$"Cov"[bold(x)] = E[(bold(x)-E[bold(x)])(bold(x)-E[bold(x)])^T] = Sigma$]
    #v(0.9em)
    #align(center)[$E[bold(x) bold(x)^T] = Sigma + mu mu^T$]
    #v(0.8em)
    #align(center)[$Sigma = mat(sigma_1^2, "Cov"[X_1,X_2]; "Cov"[X_2,X_1], sigma_2^2)$]
  ],
)

#speaker-note[
  The covariance matrix gathers every variance and covariance in one object.
  The second-moment identity mirrors the scalar identity introduced earlier.
]

== Affine transformations

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #grid(
      columns: (1fr, 0.22fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$bold(x)$], [$"random vector"$]),
      schema-arrow,
      schema-node([$A bold(x) + b$], [$"affine map"$], fill: palette.paper),
    )
    #v(0.95em)
    #align(center)[$"Cov"[A bold(x) + b] = A "Cov"[bold(x)] A^T$]
  ],
)

#speaker-note[
  Linear transformations rotate and scale covariance geometry; adding a
  constant changes the mean but not covariance. This is essential for the
  linear Gaussian system at the end of the lecture.
]

== Correlation

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$rho = "corr"[X,Y] = frac("Cov"[X,Y], sqrt(V[X] V[Y]))$]
    #v(0.9em)
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.65em,
      schema-node([$rho approx 1$], [$"aligned variation"$]),
      schema-node([$rho approx 0$], [$"no linear association"$], fill: palette.paper),
      schema-node([$rho approx -1$], [$"opposed variation"$]),
    )
  ],
)

#speaker-note[
  Correlation rescales covariance into a unitless measure. Keep causation out
  of the live narrative; a causal warning can remain a reserve discussion.
]

== Summary: Covariance and dependence

#content-block(
  key-points: [
    - Covariance: joint variation around the means
    - $Sigma$: covariance matrix
    - $E[bold(x)bold(x)^T] = Sigma + mu mu^T$
    - $"Cov"[A bold(x)+b] = A Sigma A^T$
    - Correlation rescales covariance
  ],
)

#speaker-note[
  This section turns dependence into an object that can be transformed and
  conditioned. Covariance records joint variation, affine maps transform it,
  and correlation expresses the same dependence on a unit-free scale.
]

#section-metadata(
  short-title: [Multivariate Gaussian],
  subtitle: [Geometry, marginalization, and conditioning],
)

= Multivariate Gaussian and conditioning

== Gaussian geometry

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$cal(N)(y | mu, Sigma) = frac(1, (2 pi)^(D/2) |Sigma|^(1/2)) exp(-frac(1,2)(y-mu)^T Sigma^(-1)(y-mu))$]
    #v(0.8em)
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 0.6em,
      schema-node([$Sigma = sigma^2 I$], [$"spherical"$]),
      uncover("2-")[
        #schema-node([$Sigma = "diag"(sigma_1^2, sigma_2^2)$], [$"axis-aligned"$], fill: palette.paper)
      ],
      uncover("3-")[#schema-node([$Sigma_12 != 0$], [$"tilted"$])],
    )
  ],
)

#speaker-note[
  Read the density through geometry. The mean locates the cloud; the covariance
  determines its scale, axes, and dependence. Do not derive its normalizer.
]

== Mahalanobis distance

#content-block(
  layout: "top",
  object-width: 88%,
  object: [
    #align(center)[$Delta^2 = (y - mu)^T Sigma^(-1)(y - mu)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$y - mu$], [$"displacement"$]),
      schema-arrow,
      schema-node([$Sigma^(-1)$], [$"geometry-aware scaling"$]),
    )
  ],
)

#speaker-note[
  The inverse covariance measures distance in units adapted to the Gaussian's
  own geometry. Equal Mahalanobis distance means equal-density contours.
]

== Typical set

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$bold(x) tilde cal(N)(bold(0), I_D), quad R^2 = norm(bold(x))^2 = sum_(i=1)^D x_i^2$]
    #v(0.85em)
    #grid(
      columns: (1fr, 0.25fr, 1fr),
      gutter: 0.45em,
      align: center + horizon,
      schema-node([$E[R^2] = D$], [$"radius squared"$]),
      align(center + horizon)[#text(size: 1.2em, fill: palette.accent)[$,$]],
      schema-node([$"sd"(R^2) / E[R^2] = sqrt(2/D)$], [$"relative width"$]),
    )
  ],
)

#speaker-note[
  In high dimensions, probability mass concentrates in a shell away from the
  mode. The equation quantifies why the relative shell thickness shrinks.
]

== Gaussian blocks and marginals

#content-block(
  layout: "top",
  object-width: 90%,
  object: [
    #align(center)[$y = mat(y_1; y_2), quad mu = mat(mu_1; mu_2), quad Sigma = mat(Sigma_11, Sigma_12; Sigma_21, Sigma_22)$]
    #v(0.9em)
    #grid(
      columns: (1fr, 1fr),
      gutter: 1.0em,
      schema-node([$p(y_1) = cal(N)(y_1 | mu_1, Sigma_11)$], [$"first marginal"$]),
      schema-node([$p(y_2) = cal(N)(y_2 | mu_2, Sigma_22)$], [$"second marginal"$], fill: palette.paper),
    )
  ],
)

#speaker-note[
  Partition the random vector, mean, and covariance consistently. Gaussian
  marginalization is simple in this representation: retain the relevant mean
  and covariance block.
]

== Gaussian conditioning

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$p(y_1 | y_2) = cal(N)(y_1 | mu_(1|2), Sigma_(1|2))$]
    #uncover("2-")[
      #v(0.75em)
      #align(center)[$mu_(1|2) = mu_1 + Sigma_12 Sigma_22^(-1)(y_2 - mu_2)$]
    ]
    #uncover("3-")[
      #v(0.45em)
      #align(center)[$Sigma_(1|2) = Sigma_11 - Sigma_12 Sigma_22^(-1) Sigma_21$]
    ]
  ],
)

#speaker-note[
  Conditioning shifts the conditional mean according to the observed deviation
  and subtracts the uncertainty explained by the observation. The result stays
  Gaussian, which makes this a reusable inference operation.
]

== Bivariate conditional

#content-block(
  layout: "top",
  object-width: 94%,
  object: [
    #align(center)[$p(y_1 | y_2) = cal(N)(y_1 | mu_1 + rho frac(sigma_1, sigma_2)(y_2-mu_2), sigma_1^2 (1-rho^2))$]
    #v(0.85em)
    #grid(
      columns: (1fr, 0.18fr, 1fr, 0.18fr, 1fr),
      gutter: 0.3em,
      schema-node([$y_2 - mu_2$], [$"observation"$]),
      schema-arrow,
      schema-node([$rho sigma_1/sigma_2$], [$"mean shift"$], fill: palette.paper),
      schema-arrow,
      schema-node([$sigma_1^2 (1-rho^2)$], [$"remaining variance"$]),
    )
  ],
)

#speaker-note[
  The bivariate special case makes the general block formula visible. If the
  variables are uncorrelated, the observed value does not shift the conditional
  mean and does not reduce its variance.
]

== Conditioning as an inference machine

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 0.18fr, 1fr, 0.18fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([$p(y_1, y_2)$], [$"joint Gaussian"$]),
      schema-arrow,
      schema-node([$y_2$], [$"observed"$], fill: palette.paper),
      schema-arrow,
      schema-node([$p(y_1 | y_2)$], [$"Gaussian posterior"$]),
    )
    #v(0.8em)
    #align(center)[$Sigma_(1|2) <= Sigma_11$]
  ],
)

#speaker-note[
  This slide names the reusable pattern. We start with a joint model, observe
  one part, and infer the other. The posterior covariance cannot exceed the
  marginal covariance in the positive-semidefinite ordering.
]

== Summary: Multivariate Gaussian and conditioning

#content-block(
  key-points: [
    - $mu$: location; $Sigma$: scale, orientation, and dependence
    - Mahalanobis distance follows covariance geometry
    - High-dimensional Gaussian mass concentrates in a shell
    - Marginals retain covariance blocks
    - Conditionals are Gaussian with shifted mean and reduced covariance
  ],
)

#speaker-note[
  The section's endpoint is the Gaussian conditioning rule: marginals retain
  covariance blocks, while conditioning shifts the mean and reduces remaining
  uncertainty according to the observed variables.
]

#section-metadata(
  short-title: [Missing values],
  subtitle: [Inference about hidden entries by conditioning],
)

= Missing values as Gaussian conditioning

== Visible and hidden entries

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 0.18fr, 1fr, 0.18fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([$y = (y_v, y_h)$], [$"vector"$]),
      schema-arrow,
      schema-node([$y_v$], [$"visible"$], fill: palette.paper),
      schema-arrow,
      schema-node([$p(y_h | y_v, theta)$], [$"hidden entries"$]),
    )
    #v(0.85em)
    #align(center)[$p(y_h | y_v, theta)$]
  ],
)

#speaker-note[
  Missing-value imputation is simply inference about the hidden partition of a
  vector conditional on the visible partition. Avoid missingness mechanisms and
  full imputation workflows here.
]

== Summary: Missing values as conditioning

#content-block(
  key-points: [
    - Partition a vector into visible entries $y_v$ and hidden entries $y_h$
    - Infer hidden entries with $p(y_h | y_v, theta)$
    - Gaussian conditioning supplies this distribution analytically
  ],
)

#speaker-note[
  This brief section concludes that missing-value inference is Gaussian
  conditioning on hidden entries. The visible/hidden partition states the
  problem cleanly, and the conditional distribution supplies the imputation
  target.
]

#section-metadata(
  short-title: [LGS],
  subtitle: [Latent state, observation, and Gaussian posterior],
)

= Linear Gaussian systems

== Linear Gaussian model

#content-block(
  layout: "top",
  object-width: 92%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1fr),
      gutter: 0.4em,
      align: center + horizon,
      schema-node([$z tilde cal(N)(mu_z, Sigma_z)$], [$"latent state"$]),
      uncover("2-")[#schema-arrow],
      uncover("2-")[
        #schema-node([$y | z tilde cal(N)(W z+b, Sigma_y)$], [$"observation"$], fill: palette.paper)
      ],
    )
    #v(0.9em)
    #align(center)[$p(z,y) = p(z)p(y|z)$]
  ],
)

#speaker-note[
  This is the first complete inference machine. A Gaussian prior over the
  state and a linear Gaussian observation model together imply a joint
  Gaussian distribution.
]

== Joint Gaussian form

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$mu = mat(mu_z; W mu_z + b)$]
    #v(0.55em)
    #align(center)[$Sigma = mat(Sigma_z, Sigma_z W^T; W Sigma_z, Sigma_y + W Sigma_z W^T)$]
    #v(0.85em)
    #align(center)[$mat(z; y) tilde cal(N)(mu, Sigma)$]
  ],
)

#speaker-note[
  Show how the prior covariance propagates through the linear map and combines
  with observation noise. Do not derive the block covariance on the slide.
]

== Posterior state

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #align(center)[$p(z | y) = cal(N)(z | mu_(z|y), Sigma_(z|y))$]
    #uncover("2-")[
      #v(0.65em)
      #align(center)[$Lambda_(z|y) = Sigma_z^(-1) + W^T Sigma_y^(-1) W$]
    ]
    #uncover("3-")[
      #v(0.35em)
      #align(center)[$Sigma_(z|y) = Lambda_(z|y)^(-1)$]
    ]
    #uncover("4-")[
      #v(0.35em)
      #align(center)[$mu_(z|y) = Sigma_(z|y)(W^T Sigma_y^(-1)(y-b) + Sigma_z^(-1) mu_z)$]
    ]
  ],
)

#speaker-note[
  The posterior is Gaussian because this is just Gaussian conditioning. The
  precision form makes the update look like added information from prior and
  observation.
]

== Sensor fusion

#content-block(
  layout: "top",
  object-width: 96%,
  object: [
    #grid(
      columns: (1fr, 0.2fr, 1fr, 0.2fr, 1fr),
      gutter: 0.3em,
      align: center + horizon,
      schema-node([Prior], [$cal(N)(z | mu_z, Sigma_z)$]),
      align(center + horizon)[#text(size: 1.1em, fill: palette.accent)[$times$]],
      schema-node([Measurement], [$cal(N)(y | W z+b, Sigma_y)$], fill: palette.paper),
      align(center + horizon)[#text(size: 1.1em, fill: palette.accent)[$prop$]],
      schema-node([Posterior], [$cal(N)(z | mu_(z|y), Sigma_(z|y))$]),
    )
    #v(0.8em)
    #align(center)[$Sigma_(z|y)^(-1) = Sigma_z^(-1) + W^T Sigma_y^(-1) W$]
  ],
)

#speaker-note[
  This is sensor fusion in probabilistic form. Reliable measurements contribute
  more precision and shrink the posterior uncertainty more strongly.
]

== Summary: Linear Gaussian systems

#content-block(
  key-points: [
    - Prior: $p(z) = cal(N)(z | mu_z, Sigma_z)$
    - Observation: $p(y | z) = cal(N)(y | W z+b, Sigma_y)$
    - Joint model: $p(z,y) = p(z)p(y|z)$
    - Posterior: $p(z|y)$ is Gaussian
    - Precision adds information from the prior and observation
  ],
)

#speaker-note[
  This is the final worked architecture for Lecture 1. It assembles task
  notation, moments, covariance, Gaussian geometry, and conditioning.
]

== Lecture 1 summary

#content-block(
  key-points: [
    - ML tasks specify observed quantities, unknown quantities, and required outputs
    - Moments and conditional moments describe probabilistic summaries
    - Categorical, multinomial, and softmax distributions describe labels
    - Covariance gives multivariate geometry
    - Gaussian marginalization and conditioning are reusable inference machinery
    - Linear Gaussian systems provide the first complete inference machine
  ],
)

#speaker-note[
  End by naming the linear Gaussian system as a composition of familiar pieces.
  The lecture has moved from learning tasks and data to probability objects and
  conditioning, ending with a complete inference machine.
]
