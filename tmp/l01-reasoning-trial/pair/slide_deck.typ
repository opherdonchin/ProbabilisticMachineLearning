// Bounded four-slide authoring test for the squared-loss insertion.
#import "../../../Lectures/course.typ": *

#let lecture = (
  number: 1,
  title: [Probability and Bayesian Statistics],
  short-title: [Probability & Statistics],
  subtitle: [From Bayesian statistics to probabilistic machine learning],
)

#show: course-theme.with(info: lecture)
#show: touying-set-config.with(config-common(handout: true))

#let lecture-figure-path(file) = "L01_Probability_Statistics/" + file

#section-metadata(
  short-title: [Linear Gaussian systems],
  subtitle: [Inference from noisy linear measurements],
)

= Linear Gaussian systems

== Inference often combines conditioning and summarizing

#content-block(
  object: [
    #schema-card(
      from: [Murphy, Book 2 §2.3.2.2–2.3.2.3],
    )[
      #grid(
        columns: (1fr, auto, 1.35fr, auto, 1.25fr),
        column-gutter: 0.45em,
        row-gutter: sp("s"),
        align: center + horizon,
        [#align(center)[#stack(spacing: sp("xs"), [*Observed*], [$y$])]],
        [$arrow.r$],
        [#align(center)[#stack(spacing: sp("xs"), [*Condition*], [$p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y))$])]],
        uncover("2-")[$arrow.r$],
        uncover("2-")[#align(center)[#stack(spacing: sp("xs"), [*Summarize*], [$hat(z)=E[z | y]=mu_(z|y)$])]],
      )
    ]
    #uncover("2-")[
      #v(0.65em)
      #card[
        #align(center)[#text(size: fs("l"))[$E[z | y]=integral z p(z | y) dif z$]]
      ]
    ]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- Conditioning preserves the whole posterior distribution and its uncertainty],
      uncover("2-")[- Summarizing extracts a quantity from that posterior; for a Gaussian the mean is $mu_(z|y)$],
    )
  ],
)




== A point estimate needs a loss function

#content-block(
  object: [
    #grid(
      columns: (1fr, 1fr),
      column-gutter: sp("m"),
      row-gutter: sp("s"),
      align: top,
      [
        #recall-card(
          from: [Actual slide 63, final state],
          label: [Posterior and mean summary],
        )[
          #stack(
            spacing: sp("xs"),
            [$p(z|y)=cal(N)(z|mu_(z|y),Sigma_(z|y))$],
            [$hat(z)=E[z|y]=mu_(z|y)$],
          )
        ]
      ],
      [
        #card[
          #stack(
            spacing: sp("xs"),
            text(size: fs("m"), weight: "semibold")[Squared-loss criterion],
            [$a in RR^d " fixed after observing " y$],
            [$E[norm(z)^2|y]<infinity$],
            [$L(a,z)=norm(z-a)^2$],
            [$R(a|y)=E[L(a,z)|y]$],
          )
        ]
      ],
      grid.cell(colspan: 2)[
        #uncover("2-")[
          #card[
            #stack(
              spacing: sp("xs"),
              text(size: fs("m"), weight: "semibold")[Conditional moments and centered residual],
              [$m=E[z|y], quad V=op("Cov")[z|y], quad r=z-m$],
              [Earlier Gaussian: $m=mu_(z|y)$, $V=Sigma_(z|y)$.],
            )
          ]
        ]
      ],
      grid.cell(colspan: 2)[
        #step(3)[
          #card[
            #stack(
              spacing: sp("s"),
              text(size: fs("m"), weight: "semibold")[Center at the conditional mean],
              align(center)[$z-a=r+(m-a)$],
              align(center)[$norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2$],
            )
          ]
        ]
      ],
    )
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- Choosing a reconstruction $a$ requires a criterion: $R(a|y)$ averages its squared error under the posterior.],
      uncover("3-")[- Centering separates residual error from action displacement; the cross-term is still present.],
    )
  ],
)


== The conditional mean minimizes squared-error risk

#content-block(
  object: [
    #stack(
      spacing: sp("s"),
      recall-card(
        label: [Pointwise expansion],
        from: [This pair's slide 64, final state],
      )[
        #stack(
          spacing: sp("xs"),
          [$m=E[z|y], quad V=op("Cov")[z|y], quad r=z-m$],
          [$norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2$],
        )
      ],
      step(2)[
        #card[
          #stack(
            spacing: sp("xs"),
            text(size: fs("m"), weight: "semibold")[Take conditional expectation],
            [$R(a|y)=E[norm(r)^2|y]+2E[r^T (m-a)|y]+norm(m-a)^2$],
            [Linearity; $m$ and $a$ are fixed at the observed $y$.],
          )
        ]
      ],
      uncover("3-")[
        #grid(
          columns: (1fr, 1fr),
          column-gutter: sp("m"),
          align: top,
          [
            #card[
              #stack(
                spacing: sp("xs"),
                text(size: fs("m"), weight: "semibold")[Cross-term: centering cancels it],
                [$E[r|y]=E[z|y]-m=0$],
                [$E[r^T (m-a)|y]=E[r|y]^T (m-a)=0$],
              )
            ]
          ],
          [
            #card[
              #stack(
                spacing: sp("xs"),
                text(size: fs("m"), weight: "semibold")[Residual energy: sum of variances],
                [$ E[norm(r)^2|y] &= sum_(j=1)^d E[r_j^2|y] \
                  &= sum_(j=1)^d V_(j j)=op("tr") V $],
                [Centered $r$: $V=E[r r^T|y]$.],
              )
            ]
          ],
        )
      ],
      uncover("4-")[
        #card[
          #stack(
            spacing: sp("xs"),
            text(size: fs("m"), weight: "semibold")[Substitute the two moment evaluations],
            align(center)[#text(size: fs("l"))[$R(a|y)=E[norm(z-a)^2|y]=op("tr") V+norm(m-a)^2$]],
          )
        ]
      ],
      uncover("5-")[
        #grid(
          columns: (1.35fr, 1fr),
          column-gutter: sp("m"),
          align: top,
          [
            #card[
              #stack(
                spacing: sp("xs"),
                text(size: fs("m"), weight: "semibold")[Minimize the squared-distance term],
                [$norm(m-a)^2>=0 quad "with equality iff" quad a=m$],
                [$a^*(y)=m, quad min_(a in RR^d) R(a|y)=op("tr") V$],
              )
            ]
          ],
          [
            #card[
              #stack(
                spacing: sp("xs"),
                text(size: fs("m"), weight: "semibold")[For the earlier Gaussian],
                align(center)[$a^*(y)=m=hat(z)=mu_(z|y)$],
              )
            ]
          ],
        )
      ],
    )
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      uncover("4-")[- The covariance trace is the remaining model expected squared error; displacement from the mean adds squared distance.],
      uncover("5-")[- The mean uniquely minimizes squared loss with finite conditional second moments; Gaussianity is unnecessary.],
    )
  ],
)

== Sensor fusion combines measurements according to their uncertainty

#content-block(
  object: [
    #twocol(
      columns: cols("left"),
      gutter: sp("l"),
      align: top,
    )[
      #bordered-card(title: [Two noisy measurements of one state])[
        #text(size: fs("m"))[
          $z tilde cal(N)(mu_z,Sigma_z)$
          $x | z tilde cal(N)(z,Sigma_x), quad y | z tilde cal(N)(z,Sigma_y)$
        ]
      ]
    ][
      #bordered-card(title: [Same two operations])[
        #text(size: fs("m"))[
          $p(z | x,y) quad arrow.r quad E[z | x,y]$
        ]
      ]
    ]
    #uncover("2-")[
      #v(sp("s"))
      #schema-card(
        from: [Course schematic after Murphy, Book 2 §2.3.2.3, Fig. 2.10; `sensor_fusion_figure.ipynb`],
      )[
        #course-image(
          lecture-figure-path("generated/sensor_fusion_schematic.svg"),
          width: 100%,
          height: 5.2cm,
        )
      ]
    ]
  ],
  key-points: [
    #stack(
      spacing: 0.3em,
      uncover("2-")[- Equal uncertainty puts the posterior mean between the measurements],
      uncover("3-")[- A more precise sensor pulls the posterior mean closer to its measurement],
      uncover("4-")[- With anisotropic uncertainty, the weighting can differ by direction],
    )
  ],
)



