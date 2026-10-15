// Exploratory transfer of a provisional relation-first judgment to actual59.
// Actual58 is copied as predecessor context; all actual59 mathematics remains.
#import "../../../../course.typ": *

#let lecture = (
  number: 1,
  title: [Probability and Bayesian Statistics],
  short-title: [Probability & Statistics],
  subtitle: [From Bayesian statistics to probabilistic machine learning],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: false))

#section-metadata(
  short-title: [Linear Gaussian systems],
  subtitle: [Inference from noisy linear measurements],
)

#context {
  state("pml-section-number", 0).update(7)
  state("pml-section-short-title", []).update([Linear Gaussian systems])
  state("pml-section-subtitle", none).update([Inference from noisy linear measurements])
}

== A linear Gaussian model defines a joint Gaussian

#content-block(
  object: [
    #twocol(
      columns: cols("right"),
      gutter: 0.9em,
      align: top,
    )[
      #bordered-card(title: [Linear Gaussian model])[
        #text(size: fs("m"))[
          #stack(
            spacing: 0.42em,
            [$z tilde cal(N)(mu_z,Sigma_z)$],
            [$y=W z+b+epsilon$],
            [$epsilon tilde cal(N)(0,Omega)$],
            [#text(size: fs("l"), fill: palette.muted)[$epsilon$ is independent of $z$]],
          )
        ]
      ]
    ][
      #bordered-card(title: [Affine Gaussian rules])[
        #text(size: fs("m"))[
          #stack(
            spacing: 0.42em,
            [$u=A x+c$],
            [$E[u]=A E[x]+c$],
            [$"Cov"[u]=A "Cov"[x] A^T$],
          )
        ]
      ]
    ]
    #uncover("2-")[
      #v(0.15em)
      #bordered-card(title: [Joint Gaussian])[
        #text(size: fs("m"))[
          #stack(
            spacing: 0.42em,
            [$mat(z;y) tilde cal(N)(mat(mu_z;mu_y), mat(Sigma_(z z),Sigma_(z y);Sigma_(y z),Sigma_(y y)))$],
            [$mu_y=W mu_z+b, quad Sigma_(z z)=Sigma_z$],
            [$Sigma_(z y)=Sigma_z W^T=Sigma_(y z)^T$],
            [$Sigma_(y y)=W Sigma_z W^T+Omega$],
          )
        ]
      ]
    ]
    #source-note[Murphy, Book 2 §2.3.2.1, Eq. 2.120]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- The model plus affine-Gaussian rules determine the full joint distribution],
      uncover("2-")[- Once $p(z,y)$ is known, the Gaussian marginal and conditioning rules apply directly],
    )
  ],
)

== Bayes' rule for Gaussians

#content-block(
  object: [
    #twocol(
      columns: (1.2fr, 1fr),
      gutter: sp("m"),
      align: top,
    )[
      #stack(
        spacing: sp("m"),
        bordered-card(title: [Model-specific joint blocks])[
          #stack(
            spacing: sp("xs"),
            [$mat(z;y) tilde cal(N)(mat(mu_z;mu_y),mat(Sigma_(z z),Sigma_(z y);Sigma_(y z),Sigma_(y y)))$],
            [$mu_y=W mu_z+b, quad Sigma_(z z)=Sigma_z$],
            [$Sigma_(z y)=Sigma_z W^T=Sigma_(y z)^T$],
            [$Sigma_(y y)=W Sigma_z W^T+Omega$],
          )
        ],
        bordered-card(title: [Gaussian conditioning rule])[
          #stack(
            spacing: sp("s"),
            [$mu_(1|2)=mu_1+Sigma_12 Sigma_22^(-1)(x_2-mu_2)$],
            [$Sigma_(1|2)=Sigma_11-Sigma_12 Sigma_22^(-1)Sigma_21$],
          )
        ],
      )
    ][
      #bordered-card(title: [Apply: $x_1=z$, $x_2=y$])[
        #stack(
          spacing: sp("m"),
          [$p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y))$],
          uncover("2-")[$mu_(z|y)=mu_z+Sigma_(z y) Sigma_(y y)^(-1)(y-mu_y)$],
          uncover("3-")[$Sigma_(z|y)=Sigma_(z z)-Sigma_(z y) Sigma_(y y)^(-1)Sigma_(y z)$],
        )
      ]
    ]
    #source-note[Murphy, Book 2 §2.3.2.2, Eq. 2.121]
  ],
  key-points: [
    #stack(
      spacing: sp("xs"),
      [- Apply the Gaussian conditioning rule to the joint blocks],
      uncover("2-")[- The mean responds to observed minus predicted measurement],
      uncover("3-")[- The covariance subtracts the uncertainty explained by the measurement],
    )
  ],
)
