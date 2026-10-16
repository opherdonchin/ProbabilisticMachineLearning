// Exploratory realization of provisional Design D1; not live production.
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

// Actual63 is included as the immediate predecessor: it establishes p(z|y)
// and its mean, but not squared-error optimality.
== Inference often combines conditioning and summarizing

#content-block(
  object: [
    #grid(
      columns: (1fr, auto, 1.35fr, auto, 1.25fr),
      column-gutter: 0.45em,
      row-gutter: sp("s"),
      align: center + horizon,
      [#align(center)[#stack(spacing: sp("xs"), [*Observed*], [$y$])]],
      [$arrow.r$],
      [#align(center)[#stack(spacing: sp("xs"), [*Condition*], [$p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y))$])]],
      [$arrow.r$],
      [#align(center)[#stack(spacing: sp("xs"), [*Summarize*], [$hat(z)=E[z | y]=mu_(z|y)$])]],
    )
    #v(0.65em)
    #align(center)[$E[z | y]=integral z p(z | y) dif z$]
  ],
  key-points: [
    - Conditioning preserves the whole posterior distribution and its uncertainty
    - Summarizing extracts a quantity from that posterior; for a Gaussian the mean is $mu_(z|y)$
  ],
)

// Variant A: named supporting objects feed the intact expansion.
== Choose a reconstruction by its conditional squared-error risk

#content-block(
  object: [
    #twocol(
      columns: cols("equal"),
      gutter: sp("m"),
      align: top,
    )[
      #bordered-card(title: [Squared-error risk])[
        #align(center)[Observed $y$; $z,a in RR^d$]
        #v(sp("xs"))
        #align(center)[$L(a,z)=norm(z-a)^2$]
        #align(center)[$R(a|y)=E[L(a,z)|y]$]
      ]
    ][
      #uncover("2-")[
        #bordered-card(title: [Centered error])[
          #align(center)[$m=E[z|y], quad r=z-m$]
          #align(center)[$z-a=r+(m-a)$]
        ]
      ]
    ]
    #uncover("3-")[
      #v(sp("m"))
      #align(center)[#text(size: fs("m"), weight: "semibold")[Squared-error expansion]]
      #align(center)[#text(size: 1.15em)[$norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2$]]
    ]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- Choose $a$ to minimize conditional expected squared error $R(a|y)$.],
      uncover("2-")[- Given $y$, offset $m-a$ is fixed; uncertainty remains in $r$.],
    )
  ],
)

// The decomposition argument is shared so the contrast stays on setup and
// decision composition, rather than varying every slide in the sequence.
== Centering separates residual uncertainty from estimation error

#content-block(
  object: [
    #recall-card(
      label: [Conditional expansion],
      from: [Previous slide: pointwise squared-error expansion],
      size: fs("s"),
    )[$norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2$]
    #v(sp("s"))
    #align(center)[#text(size: fs("m"), weight: "semibold")[Take $E[dot|y]$; $m-a$ is fixed]]
    #v(sp("s"))
    #twocol(
      columns: cols("equal"),
      gutter: sp("l"),
      align: top,
    )[
      #stack(
        spacing: sp("s"),
        align(center)[#text(size: fs("m"), weight: "semibold")[Cross-term]],
        align(center)[$E[r|y]=E[z|y]-m=0$],
        align(center)[$E[r^T (m-a)|y]=E[r|y]^T (m-a)=0$],
      )
    ][
      #stack(
        spacing: sp("s"),
        align(center)[#text(size: fs("m"), weight: "semibold")[Residual energy]],
        align(center)[$V=op("Cov")[z|y]$],
        align(center)[$E[norm(r)^2|y]=sum_(j=1)^d E[r_j^2|y]=op("tr") V$],
      )
    ]
    #uncover("2-")[
      #v(sp("s"))
      #align(center)[#text(size: 1.15em)[$R(a|y)=op("tr") V+norm(m-a)^2$]]
    ]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      only("1")[- Centering removes the average cross-term with the fixed offset.],
      only("2")[- Risk is residual uncertainty plus squared distance from the posterior mean.],
    )
  ],
)

== The posterior mean minimizes squared-error risk

#content-block(
  object: [
    #recall-card(
      label: [Conditional squared-error risk],
      from: [Previous slide: residual uncertainty plus squared distance from the mean],
      size: fs("s"),
    )[$R(a|y)=op("tr") V+norm(m-a)^2$]
    #v(sp("m"))
    #twocol(
      columns: (1.7fr, 1fr),
      gutter: sp("m"),
      align: top,
    )[
      #bordered-card(title: [Minimizing action])[
        #align(center)[$norm(m-a)^2>=0 quad "equality iff" quad a=m$]
        #v(sp("s"))
        #align(center)[#text(size: 1.1em)[$a^*(y)=m=E[z|y]$]]
        #align(center)[$min_a R(a|y)=op("tr") V$]
      ]
    ][
      #bordered-card(title: [Conditional Gaussian])[
        #align(center)[$a^*(y)=mu_(z|y)$]
        #align(center)[$min_a R(a|y)=op("tr") Sigma_(z|y)$]
      ]
    ]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- The conditional mean minimizes model expected squared error.],
      [- The posterior covariance describes uncertainty that remains after the mean action is chosen.],
    )
  ],
)

// Variant B: repeated operation spine; same content and treatment.
== Choose a reconstruction by its conditional squared-error risk

#content-block(
  object: [
    #align(center)[#text(size: fs("m"), weight: "semibold")[Observed $y$; reconstruct $z in RR^d$ with $a in RR^d$]]
    #v(sp("s"))
    #align(center)[#text(size: fs("m"), weight: "semibold")[Squared-error criterion]]
    #align(center)[$L(a,z)=norm(z-a)^2, quad R(a|y)=E[L(a,z)|y]$]
    #v(sp("s"))
    #uncover("2-")[
      #align(center)[#text(size: fs("m"), weight: "semibold")[Center: $m=E[z|y]$, $r=z-m$]]
      #align(center)[#text(size: 1.05em)[$z-a=r+(m-a)$]]
    ]
    #uncover("3-")[
      #v(sp("s"))
      #align(center)[#text(size: fs("m"), weight: "semibold")[Square the centered error]]
      #align(center)[#text(size: 1.15em)[$norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2$]]
    ]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- Choose $a$ to minimize conditional expected squared error $R(a|y)$.],
      uncover("2-")[- Given $y$, offset $m-a$ is fixed; uncertainty remains in $r$.],
    )
  ],
)

// Shared decomposition move repeated so each comparison is a complete
// setup → decomposition → decision sequence.
== Centering separates residual uncertainty from estimation error

#content-block(
  object: [
    #recall-card(
      label: [Conditional expansion],
      from: [Previous slide: pointwise squared-error expansion],
      size: fs("s"),
    )[$norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2$]
    #v(sp("s"))
    #align(center)[#text(size: fs("m"), weight: "semibold")[Take $E[dot|y]$; $m-a$ is fixed]]
    #v(sp("s"))
    #twocol(
      columns: cols("equal"),
      gutter: sp("l"),
      align: top,
    )[
      #stack(
        spacing: sp("s"),
        align(center)[#text(size: fs("m"), weight: "semibold")[Cross-term]],
        align(center)[$E[r|y]=E[z|y]-m=0$],
        align(center)[$E[r^T (m-a)|y]=E[r|y]^T (m-a)=0$],
      )
    ][
      #stack(
        spacing: sp("s"),
        align(center)[#text(size: fs("m"), weight: "semibold")[Residual energy]],
        align(center)[$V=op("Cov")[z|y]$],
        align(center)[$E[norm(r)^2|y]=sum_(j=1)^d E[r_j^2|y]=op("tr") V$],
      )
    ]
    #uncover("2-")[
      #v(sp("s"))
      #align(center)[#text(size: 1.15em)[$R(a|y)=op("tr") V+norm(m-a)^2$]]
    ]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      only("1")[- Centering removes the average cross-term with the fixed offset.],
      only("2")[- Risk is residual uncertainty plus squared distance from the posterior mean.],
    )
  ],
)

// Variant B decision: term labels remain aligned to the intact identity.
== The posterior mean minimizes squared-error risk

#content-block(
  object: [
    #align(center)[#text(size: 1.05em)[$R(a|y)=underbrace(op("tr") V, "independent of a")+underbrace(norm(m-a)^2, "nonnegative; zero iff" quad a=m)$]]
    #align(center)[#text(size: fs("s"), weight: "semibold")[Consequences at the minimizing action]]
    #twocol(
      columns: cols("equal"),
      gutter: sp("m"),
      align: top,
    )[
      #stack(
        spacing: sp("xs"),
        align(center)[#text(size: fs("s"), weight: "semibold")[Minimum risk]],
        align(center)[$min_a R(a|y)=op("tr") V$],
      )
    ][
      #stack(
        spacing: sp("xs"),
        align(center)[#text(size: fs("s"), weight: "semibold")[Optimal action]],
        align(center)[$a^*(y)=m=E[z|y]$],
      )
    ]
    #v(sp("xs"))
    #align(center)[#text(size: fs("xs"), fill: palette.muted, weight: "medium")[For the conditional Gaussian]]
    #twocol(
      columns: cols("equal"),
      gutter: sp("s"),
      align: center + horizon,
    )[
      #align(center)[$min_a R(a|y)=op("tr") Sigma_(z|y)$]
    ][
      #align(center)[$a^*(y)=mu_(z|y)$]
    ]
  ],
  key-points: [
    #stack(
      spacing: sp("s"),
      [- The conditional mean minimizes model expected squared error.],
      [- The posterior covariance describes uncertainty that remains after the mean action is chosen.],
    )
  ],
)

