// Lecture 1 — Probabilistic Machine Learning
#import "../../../Lectures/course.typ": *

#let lecture = (
  number: 1,
  title: [Probability and Bayesian Statistics],
  short-title: [Probability & Statistics],
  subtitle: [From Bayesian statistics to probabilistic machine learning],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

== Affine maps carry Gaussian means and covariances

#stack(
  spacing: 0.9em,
  content-block(
    layout: "top",
    object-width: 100%,
    object: [
      #twocol(
        columns: cols("right"),
        gutter: sp("l"),
        align: top,
      )[
        #card[
          #text(size: fs("m"))[
            $ x in RR^d, quad y=A x+b in RR^m $

            $ A in RR^(m times d), quad b in RR^m quad ("deterministic") $

            $ E[x]=mu, quad "Cov"[x]=Sigma $

            $ E[sum_(i=1)^d x_i^2] < infinity $
          ]
        ]
      ][
        #bordered-card(title: [Moment proof])[
          #text(size: fs("m"))[
            #stack(
              spacing: sp("s"),
              [$ mu_y = E[y] = A E[x]+b = A mu+b $],
              step(2)[
                $ y-mu_y = A x+b-(A mu+b) = A(x-mu) $
              ],
              step(3)[
                $ Sigma_y &= E[(y-mu_y)(y-mu_y)^T] \
                  &= E[A(x-mu)(x-mu)^T A^T] \
                  &= A E[(x-mu)(x-mu)^T] A^T \
                  &= A Sigma A^T $
              ],
            )
          ]
        ]
      ]
    ],
  ),
  uncover("4-")[
    #content-block(key-points: [
      #stack(
        spacing: sp("s"),
        [- Translation shifts the Gaussian cloud's mean without changing its covariance.],
        [- $A$ linearly maps its center and spread; affine closure keeps the transformed cloud Gaussian.],
      )
    ])
  ],
)
