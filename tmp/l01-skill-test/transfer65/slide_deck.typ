// Isolated production trial for the approved slide 65 design.
#import "../../../Lectures/course.typ": *

#let lecture = (
  number: 1,
  title: [Probability and Bayesian Statistics],
  short-title: [Probability & Statistics],
  subtitle: [From Bayesian statistics to probabilistic machine learning],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

== The conditional mean minimizes squared-error risk

#slide(repeat: 4, self => [
  // Nested reveal regions are explicit because they live inside a repeated
  // slide body. All steps are cumulative and use plain appearance.
  #let uncover = utils.uncover.with(self: self)

  #stack(
    spacing: sp("l"),
    content-block(
      object-width: 96%,
    object: [
      #stack(
        spacing: sp("xs"),

        recall-card(
          label: [Context],
          from: [Prior slide: conditional risk and centered norm expansion],
          size: fs("s"),
        )[
          #stack(
            spacing: sp("xxs"),
            [$ m=E[z|y], quad C="Cov"[z|y], quad r=z-m, quad a in RR^d, quad E[||z||^2|y]<infinity $],
            [$ R(a|y) &= E[||z-a||^2|y] \
              &= E[||r||^2|y]+2 E[r^T (m-a)|y]+||m-a||^2 $],
          )
        ],

        // The two proof identities are adjacent and unboxed, so they read as
        // one derivation rather than as separate explanatory panels.
        text(size: fs("m"))[
          $ E[r|y]=E[z|y]-m=0 quad arrow.r quad E[r^T (m-a)|y]=E[r|y]^T (m-a)=0 $

        ],

        uncover("2-")[
          #text(size: fs("m"))[
            $ E[||r||^2|y]=sum_(j=1)^d E[r_j^2|y]=sum_(j=1)^d C_(j j)="tr" C $
          ]
        ],

        uncover("3-")[
          #text(size: fs("l"))[
            #stack(
              spacing: sp("xs"),
              [$ R(a|y)="tr" C+||a-m||^2 $],
              [$ arg min_(a in RR^d) R(a|y)={m}, quad min_(a in RR^d) R(a|y)="tr" C $],
            )
          ]
        ],

        uncover("4-")[
          #text(size: fs("m"))[
            $ p(z|y)=cal(N)(z|mu_(z|y),Sigma_(z|y)), quad m=mu_(z|y), quad C=Sigma_(z|y), quad hat(z)=mu_(z|y) $
          ]
        ],
      )
    ],
    ),
    uncover("4-")[
      #bordered-card[
        #text(size: fs("m"))[
          #stack(
            spacing: sp("xxs"),
            [- The conditional mean uniquely minimizes squared-error risk; Gaussianity is unnecessary.],
            [- The minimum risk is the covariance trace; displacement from the mean adds squared distance.],
          )
        ]
      ]
    ],
  )
])
