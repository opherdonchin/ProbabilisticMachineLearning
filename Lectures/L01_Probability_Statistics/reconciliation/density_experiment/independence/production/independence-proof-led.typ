#import "../../../../../course.typ": *

#let lecture = (
  number: 1,
  title: [Probability and Bayesian Statistics],
  short-title: [Probability & Statistics],
  subtitle: [From Bayesian statistics to probabilistic machine learning],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

#title-slide()

#section-metadata(
  short-title: [Marginals and conditionals],
  subtitle: [Ignore coordinates or use observations to update uncertainty],
)

= Marginals and conditionals of a Gaussian

== Marginalization keeps the matching blocks

#content-block(
    object: [
      #twocol[
        #align(center)[
          #stack(
            spacing: 0.85em,
            [$bold(x) tilde cal(N)(mu,Sigma)$],
            [$ p(x_1) &= integral p(x_1,x_2) dif x_2 \
                &= cal(N)(x_1 | mu_1,Sigma_11) $],
            uncover("4-")[
              $p(x_2)=cal(N)(x_2 | mu_2,Sigma_22)$
            ],
          )
        ]
      ][
        #uncover("2-")[
          #bordered-card(title: [Marginal proof])[
            #stack(
              spacing: sp("s"),
              [Select $x_1$: $P=mat(I,0,delim: "["), quad x_1=P bold(x)$],
              [By the affine rule: \
                $x_1 tilde cal(N)(P mu,P Sigma P^T)$],
              uncover("3-")[
                $P mu=mu_1$
              ],
              uncover("3-")[
                $ P Sigma P^T &= mat(I,0,delim: "[") mat(Sigma_11,Sigma_12,delim: "[") mat(I;0,delim: "[") \
                  & uncover("4-", = Sigma_11) $
              ],
            )
          ]
        ]
      ]
      #source-note[Murphy, Book 2 §2.3.1.3, Eqs. 2.76–2.77; affine rule: Book 1 §3.1.1, Eq. 3.5]
    ],
    key-points: [
      #stack(
        spacing: sp("s"),
        [- Marginalizing $x_2$ integrates over all its possible values],
        uncover("4-")[
          - Cross-covariance affects conditioning, not the marginal of $x_1$
        ],
      )
    ],
  )

== Conditioning shifts the mean by an observed deviation

#slide(repeat: 4, self => [
  #let uncover = utils.uncover.with(self: self)

#content-block(
  object: [
    #bordered-card(title: [Residual proof of the conditional mean])[
      #text(size: fs("l"))[
        #stack(
          spacing: sp("s"),
          [$B=Sigma_12 Sigma_22^(-1), quad r=x_1-mu_1-B(x_2-mu_2)$],
          uncover("2-")[$E[r]=0$],
          uncover("2-")[$"Cov"[r,x_2]=Sigma_12-B Sigma_22=0$],
          uncover("3-")[Affine closure: $(r,x_2)$ is jointly Gaussian],
          uncover("3-")[Zero cross-covariance gives $r "independent of" x_2$],
          uncover("4-")[$E[r | x_2]=E[r]=0$],
          uncover("4-")[$E[x_1 | x_2]=mu_1+B(x_2-mu_2)=mu_(1|2)$],
        )
      ]
    ]
    #source-note[Murphy, Book 2 §2.3.1.3, Eq. 2.78; course residual proof uses affine Gaussian closure]
  ],
  key-points: [
    - The observed deviation $x_2-mu_2$ shifts the mean through $B=Sigma_12 Sigma_22^(-1)$.
  ],
)
])


== Conditioning removes explained covariance

#content-block(
    object: [
      #twocol[
        #align(center)[
          #stack(
            spacing: sp("xl"),
            [$Sigma_(1|2)=Sigma_11-Sigma_12 Sigma_22^(-1) Sigma_21$],
            uncover("4-")[
              $Sigma_(2|1)=Sigma_22-Sigma_21 Sigma_11^(-1) Sigma_12$
            ],
          )
        ]
      ][
        #uncover("2-")[
          #bordered-card(title: [Covariance proof])[
            #text(size: fs("l"))[
              #stack(
                spacing:0.9em,
                [$B=Sigma_12 Sigma_22^(-1)$],
                [$r=x_1-mu_(1|2)$],
                [From the mean proof: $r$ and $x_2$ are independent],
                uncover("3-")[
                  #stack(
                    spacing: sp("l"),
                  [Given $x_2$, the mean $mu_(1|2)$ is constant],
                  [$Sigma_(1|2)="Cov"[x_1 | x_2]="Cov"[r]$],

                  )
                ],
                uncover("3-")[
                  $Sigma_11=B Sigma_22 B^T+"Cov"[r]$
                ],
                uncover("4-")[
                  $ Sigma_(1|2) &= Sigma_11-B Sigma_22 B^T \
                    &= Sigma_11-Sigma_12 Sigma_22^(-1) Sigma_21 $
                ],
              )
            ]
          ]
        ]
      ]
      #source-note[Murphy, Book 2 §2.3.1.3, Eqs. 2.78–2.79; proof reuses the independent residual]
    ],
    key-points: [
      #stack(
        spacing: sp("s"),
        [- Conditioning cannot increase variance in any direction],
        uncover("4-")[
          - In a Gaussian, this covariance depends on which variables are observed, not their values
        ],
      )
    ],
  )
