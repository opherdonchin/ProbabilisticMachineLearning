// Extracted course-context package for actual slides 63 and 66 and the proposed two-slide candidate.
#import "../../../../../course.typ": *

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

#context {
  // Preserve the established course footer context without a divider slide.
  state("pml-section-number", 0).update(7)
  state("pml-section-short-title", []).update([Linear Gaussian systems])
  state("pml-section-subtitle", none).update([Inference from noisy linear measurements])
}


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



== Choose a reconstruction by its conditional squared-error risk

#content-block(
  object: [
    #stack(
      spacing: sp("m"),
      text(size: fs("m"), weight: "semibold")[Observed $y$; choose $a in RR^d$ to reconstruct unknown $z in RR^d$],
      text(size: fs("m"), weight: "semibold")[Squared-error criterion],
      align(center)[$L(a,z)=norm(z-a)^2, quad R(a|y)=E[L(a,z)|y]$],
      uncover("2-")[
        #stack(
          spacing: sp("s"),
          text(size: fs("m"), weight: "semibold")[Center at the conditional mean],
          align(center)[$m=E[z|y], quad r=z-m, quad z-a=r+(m-a)$],
        )
      ],
      uncover("3-")[
        #align(center)[$norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2$]
      ],
    )
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- Choose $a$ to minimize conditional expected squared error $R(a|y)$.],
      uncover("2-")[- Given $y$, offset $m-a$ is fixed; uncertainty remains in $r$.],
    )
  ],
)


== Centering separates residual uncertainty from estimation error

#content-block(
  object: [
    #stack(
      spacing: sp("m"),
      recall-card(
        label: [Average the centered expansion],
        from: [Previous slide: pointwise squared-error expansion],
        size: fs("s"),
      )[$norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2$],
      text(size: fs("m"), weight: "semibold")[Take $E[dot|y]$; $m-a$ is fixed],
      grid(
        columns: cols("equal"),
        gutter: sp("l"),
        align: top,
        stack(
          spacing: sp("s"),
          align(center)[$E[r|y]=E[z|y]-m=0$],
          align(center)[$E[r^T (m-a)|y]=E[r|y]^T (m-a)=0$],
        ),
        stack(
          spacing: sp("s"),
          align(center)[$V=op("Cov")[z|y]$],
          align(center)[$E[norm(r)^2|y]=sum_(j=1)^d E[r_j^2|y]=op("tr") V$],
        ),
      ),
      block(height: 2.2cm)[
        #uncover("2-")[
          #align(center + horizon)[
            #stack(
              spacing: sp("xs"),
              text(size: fs("m"), weight: "semibold")[Conditional squared-error risk],
              align(center)[#text(size: 1.1em)[$R(a|y)=op("tr") V+norm(m-a)^2$]],
            )
          ]
        ]
      ],
    )
  ],
  key-points: [
    block(height: 1.1cm)[
      #uncover("2-")[- Risk is residual uncertainty plus squared distance from the posterior mean.]
    ]
  ],
)


== The posterior mean removes the avoidable squared error

#content-block(
  object: [
    #stack(
      spacing: sp("m"),
      recall-card(
        label: [Conditional squared-error risk],
        from: [Previous slide: residual uncertainty plus squared distance from the mean],
        size: fs("s"),
      )[$R(a|y)=op("tr") V+norm(m-a)^2$],
      text(size: fs("m"), weight: "semibold")[Choose $a$ to minimize $R(a|y)$],
      align(center)[$norm(m-a)^2>=0 quad "equality iff" quad a=m$],
      align(center)[$a^*(y)=m=E[z|y]$],
          align(center)[$min_a R(a|y)=op("tr") V$],
      block(height: 2.2cm)[
        #uncover("2-")[
          #align(center)[
            $"For the conditional Gaussian:" quad a^*(y)=mu_(z|y)$\
            $min_a R(a|y)=op("tr") Sigma_(z|y)$
          ]
        ]
      ],
    )
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- The conditional mean minimizes model expected squared error.],
      block(height: 1.2cm)[
        #uncover("2-")[- The posterior covariance describes uncertainty that remains after the mean action is chosen.]
      ]
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

