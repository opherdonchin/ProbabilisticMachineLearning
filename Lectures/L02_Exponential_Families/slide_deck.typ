// Lecture 2 — Probabilistic Machine Learning
// Current production pass implements Section 1 only.

#import "../course.typ": *

#let lecture = (
  number: 2,
  title: [Exponential Families],
  short-title: [Exponential Families],
  subtitle: [Common coordinates for probability models],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

#title-slide()

#section-metadata(
  short-title: [Common exponential-family form],
  subtitle: [Separate data statistics, natural parameters, and normalization],
)

= Exponential families give familiar distributions a common form

== Different distributions can share the same algebraic structure

#content-block(
  object: [
    #stack(
      spacing: sp("m"),

      twocol(
        gutter: sp("l"),
        align: center + horizon,
      )[
        #bordered-card(title: [Bernoulli])[
          #align(center)[
            #text(size: fs("l"))[
              $ "Ber"(x | mu) = mu^x (1 - mu)^(1-x), quad x in {0,1} $
            ]
          ]
        ]
      ][
        #bordered-card(title: [Gaussian])[
          #align(center)[
            #text(size: fs("s"))[
              $ cal(N)(x | mu, Sigma)
                = 1 / sqrt((2 pi)^d det Sigma)
                  exp(-1/2 (x-mu)^T Sigma^(-1) (x-mu)) $
            ]
          ]
        ]
      ],

      uncover("2-")[
        #schema-card(
          caption: [One coordinate system can expose the same kinds of pieces in both families.],
        )[
          #align(center)[
            #text(size: 1.15em)[
              $ p(x | eta) = h(x) exp(eta^T T(x) - A(eta)) $
            ]
          ]
        ]
      ],
    )
  ],
  key-points: [
    #uncover("3-")[
      #stack(
        spacing: sp("xs"),
        [
          - The representation is useful when it separates *what the data contribute*
            from *how the distribution is parameterized*.
        ],
        [
          - We will first make those pieces explicit, then recover them in Bernoulli.
        ],
      )
    ]
  ],
)


== Exponential families separate data statistics from natural parameters

#content-block(
  object: [
    #stack(
      spacing: sp("m"),

      #card[
        #align(center)[
          #stack(
            spacing: sp("xs"),
            text(size: 1.12em)[
              $ p(x | eta)
                = 1 / Z(eta) h(x) exp(eta^T T(x))
                = h(x) exp(eta^T T(x) - A(eta)) $
            ],
            text(size: fs("l"))[
              $ A(eta) = log Z(eta) $
            ],
          )
        ]
      ],

      #grid(
        columns: cols("equal"),
        gutter: sp("s"),
        row-gutter: sp("s"),
        align: top,

        uncover("2-")[
          #bordered-card(title: [$h(x)$ — base measure])[
            #text(size: fs("m"))[
              Fixed part of the density that may depend on $x$ but not on $eta$.
            ]
          ]
        ],
        uncover("2-")[
          #bordered-card(title: [$T(x)$ — sufficient statistics])[
            #text(size: fs("m"))[
              The data are represented through the vector $T(x)$.
            ]
          ]
        ],
        uncover("3-")[
          #bordered-card(title: [$eta$ — natural parameters])[
            #text(size: fs("m"))[
              Coordinates for the distribution that pair linearly with $T(x)$.
            ]
          ]
        ],
        uncover("3-")[
          #bordered-card(title: [$A(eta)$ — log-partition function])[
            #text(size: fs("m"))[
              The parameter-dependent normalizer that makes the density integrate
              or sum to one.
            ]
          ]
        ],
      )
    )
  ],
  key-points: [
    #uncover("4-")[
      #stack(
        spacing: sp("xs"),
        [- The central interaction is the linear pairing $eta^T T(x)$.],
        [- The same four roles recur even when the familiar parameterization changes.],
      )
    ]
  ],
)


== Bernoulli already has the exponential-family form

#content-block(
  object: [
    #stack(
      spacing: sp("m"),

      #card[
        #align(center)[
          #stack(
            spacing: sp("s"),
            text(size: fs("xl"))[
              $ "Ber"(x | mu) = mu^x (1-mu)^(1-x) $
            ],
            uncover("2-")[
              #text(size: fs("xl"))[
                $ = exp(x log mu + (1-x) log(1-mu)) $
              ]
            ],
            uncover("3-")[
              #text(size: fs("xl"))[
                $ = exp(x log(mu/(1-mu)) + log(1-mu)) $
              ]
            ],
          )
        ]
      ],

      #uncover("3-")[
        #bordered-card(title: [Match terms to the general form])[
          #align(center)[
            #stack(
              spacing: sp("xs"),
              text(size: fs("l"))[
                $ T(x) = x, quad
                  eta = log(mu/(1-mu)), quad
                  h(x) = 1 $
              ],
              text(size: fs("l"))[
                $ A(eta) = -log(1-mu) = log(1 + e^eta) $
              ],
            )
          ]
        ]
      ],
    )
  ],
  key-points: [
    #uncover("4-")[
      The exponential-family representation is obtained by regrouping the same
      Bernoulli probability; no new probability model has been introduced.
    ]
  ],
)


== Bernoulli log odds are its natural parameter

#content-block(
  object: [
    #twocol(
      columns: cols("equal"),
      gutter: sp("l"),
      align: top,
    )[
      #recall-card(
        from: [Previous slide: Bernoulli exponential-family mapping],
        label: [Probability and natural coordinates],
        size: fs("l"),
      )[
        #align(center)[
          #stack(
            spacing: sp("s"),
            [$ eta = log(mu/(1-mu)) $],
            [$ mu = sigma(eta) = 1 / (1 + e^(-eta)) $],
            [$ mu in (0,1) quad arrow.l.r quad eta in RR $],
          )
        ]
      ]
    ][
      #uncover("2-")[
        #bordered-card(title: [Normalization in natural coordinates])[
          #align(center)[
            #stack(
              spacing: sp("m"),
              text(size: fs("xl"))[$ A(eta) = log(1 + e^eta) $],
              text(size: fs("xl"))[$ p(x | eta) = exp(x eta - A(eta)) $],
            )
          ]
        ]
      ]
    ]
  ],
  key-points: [
    #uncover("3-")[
      #stack(
        spacing: sp("xs"),
        [
          - $eta$ is the *log odds*: a constrained probability becomes an
            unconstrained real coordinate.
        ],
        [
          - $A(eta)$ supplies exactly the normalization required in that
            coordinate system.
        ],
      )
    ]
  ],
)


== One representation exposes the same ingredients across families

#content-block(
  object: [
    #section-summary-visual[
      #stack(
        spacing: sp("m"),
        align(center)[
          #text(size: 1.08em)[
            $ p(x | eta) = h(x) exp(eta^T T(x) - A(eta)) $
          ]
        ],
        grid(
          columns: (auto, 1fr),
          column-gutter: 1.2em,
          row-gutter: sp("xs"),
          align: left + horizon,
          [*$h(x)$*], [$1$],
          [*$T(x)$*], [$x$],
          [*$eta$*], [$log(mu/(1-mu))$],
          [*$A(eta)$*], [$log(1+e^eta)$],
        ),
      )
    ]

    #v(sp("s"))

    #section-summary-takeaways[
      #stack(
        spacing: sp("xs"),
        [
          - Exponential-family form separates base measure, sufficient statistics,
            natural parameters, and normalization.
        ],
        [- For Bernoulli, the natural parameter is the log odds.],
        [- The Gaussian will provide a richer test of the same representation.],
      )
    ]
  ],
)
