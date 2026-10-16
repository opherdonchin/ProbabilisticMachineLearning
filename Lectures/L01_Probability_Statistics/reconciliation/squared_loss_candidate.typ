// Extracted course-context package for actual slides 63 and 66 and the proposed two-slide candidate.
#import "../../course.typ": *

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



== A point estimate needs a loss function

#content-block(
  object: [
    #stack(
      spacing: sp("m"),
      recall-card(
        from: [Inference often combines conditioning and summarizing],
        size: fs("m"),
      )[$hat(z)=E[z|y]=mu_(z|y)$],
      [Observed $y$; unknown $z in RR^d$; $a in RR^d$ fixed at this $y$.],
      text(size: fs("s"), weight: "semibold")[Squared-loss criterion],
      [Assume $E[norm(z)^2|y]<infinity$],
      align(center)[$L(a,z)=norm(z-a)^2, quad R(a|y)=E[L(a,z)|y]$],
      uncover("2-")[
        #stack(
          spacing: sp("xs"),
          text(size: fs("s"), weight: "semibold")[Center at $m$],
          [$m=E[z|y], quad V=op("Cov")[z|y], quad r=z-m$],
          [Earlier Gaussian: $m=mu_(z|y)$, $V=Sigma_(z|y)$.],
        )
      ],
      uncover("3-")[
        #stack(
          spacing: sp("xs"),
          align(center)[$z-a=r+(m-a)$],
          align(center)[$norm(z-a)^2=norm(r)^2+2r^T dot (m-a)+norm(m-a)^2$],
        )
        #source-note[Murphy, Book 1 §5.1.5.1; vector decomposition: course elaboration]
      ],
    )
  ],
  key-points: [
    #stack(
      spacing: sp("xs"),
      [- We choose $a$ to reconstruct $z$ by minimizing posterior expected squared error $R(a|y)$.],
      uncover("3-")[- Centering writes the error as random residual $r$ plus the fixed offset $m-a$.],
    )
  ],
)


== The conditional mean uniquely minimizes squared-error risk

#content-block(
  object: [
    #stack(
      spacing: sp("xs"),
      recall-card(
        from: [Previous slide: $m$, $V$, and the pointwise squared-error expansion],
        size: fs("s"),
      )[
        #stack(
          spacing: sp("xxs"),
          [$m=E[z|y], quad V=op("Cov")[z|y], quad r=z-m$],
          [$norm(z-a)^2=norm(r)^2+2r^T dot (m-a)+norm(m-a)^2$],
        )
      ],
      uncover("2-")[
        #stack(
          spacing: sp("xs"),
          text(size: fs("s"))[Take conditional expectation; $a,m$ are fixed at this $y$.],
          align(center)[$R(a|y)=E[norm(r)^2|y]+2E[r^T dot (m-a)|y]+norm(m-a)^2$],
        )
      ],
      grid(
        columns: (1fr, 1.2fr), gutter: sp("m"), align: top,
        [#uncover("3-")[
          #stack(
            spacing: sp("xs"),
            text(size: fs("s"), weight: "semibold")[Centering cancels the cross-term],
            [$E[r|y]=E[z|y]-m=0$],
            align(center)[$E[r^T dot (m-a)|y]$],
            align(center)[$=E[r|y]^T dot (m-a)=0$],
            text(size: fs("s"), weight: "semibold")[Residual energy; $V=E[r r^T|y]$],
            align(center)[$E[norm(r)^2|y]=sum_(j=1)^d E[r_j^2|y]$],
            align(center)[$=sum_(j=1)^d V_(j j)=op("tr") V$],
          )
        ]],
        [
          #uncover("4-")[
            #stack(
              spacing: sp("xs"),
              align(center)[#text(size: 1.08em)[$R(a|y)=op("tr") V+norm(m-a)^2$]],
              text(size: fs("s"))[Substitute the two moments.],
            )
          ]
          #uncover("5-")[
            #stack(
              spacing: sp("xs"),
              align(center)[$norm(m-a)^2>=0 quad "with equality iff" quad a=m$],
              align(center)[$a^*(y)=m=E[z|y], quad min_a R(a|y)=op("tr") V$],
              align(center)[$"Earlier Gaussian:" quad a^*(y)=m=hat(z)=mu_(z|y)$],
              align(center)[$min_a R(a|y)=op("tr") Sigma_(z|y)$],
            )
          ]
        ],
      ),
    )
  ],
  key-points: [
    #stack(
      spacing: sp("xs"),
      uncover("4-")[- Risk is residual uncertainty plus the squared distance of the chosen action from the mean.],
      uncover("5-")[- This is model expected loss; finite conditional second moments suffice without Gaussianity.],
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
