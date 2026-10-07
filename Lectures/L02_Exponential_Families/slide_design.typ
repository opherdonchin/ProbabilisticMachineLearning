// Lecture 2 design specification — Section 1
// First pass intentionally written against the design language we want.
// design.typ is implemented after this section-level pseudo-design exists.

#import "../design.typ": *

#set document(
  title: "Lecture 2 — slide design",
  author: "Opher Donchin",
)

= Section 1 — Exponential families give familiar distributions a common form

#slide-design(
  title: [Different distributions can share the same algebraic structure],
  teaching-move: [
    Motivate exponential-family coordinates by placing two familiar distributions
    beside a single shared algebraic skeleton.
  ],
  layout: layout-grid(
    columns: 2,
    cells: (
      layout-cell("bernoulli"),
      layout-cell("gaussian"),
      layout-cell("shared", colspan: 2),
      layout-cell("takeaway", colspan: 2),
    ),
    dominant: "shared",
  ),
  cards: (
    card(
      label: "bernoulli",
      title: [Bernoulli],
    )[
      $ "Ber"(x | mu) = mu^x (1 - mu)^(1-x), quad x in {0,1} $
    ],
    card(
      label: "gaussian",
      title: [Gaussian],
    )[
      $ cal(N)(x | mu, Sigma)
        = 1 / sqrt((2 pi)^d det Sigma)
          exp(-1/2 (x-mu)^T Sigma^(-1) (x-mu)) $
    ],
    schema-card(
      label: "shared",
      caption: [One coordinate system can expose the same kinds of pieces in both families.],
    )[
      $ p(x | eta) = h(x) exp(eta^T T(x) - A(eta)) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      - The representation is useful when it separates *what the data contribute*
        from *how the distribution is parameterized*.
      - We will first make those pieces explicit, then recover them in Bernoulli.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("bernoulli", "gaussian"),
    then: (
      reveal-step(("shared",), purpose: [Expose the common algebraic target.]),
      reveal-step(("takeaway",), purpose: [State why the change of coordinates is useful.]),
    ),
  ),
)

#slide-design(
  title: [Exponential families separate data statistics from natural parameters],
  teaching-move: [
    State the general form and establish the distinct roles of
    $h(x)$, $T(x)$, $eta$, and $A(eta)$ before specializing it.
  ],
  layout: layout-grid(
    columns: 2,
    cells: (
      layout-cell("formula", colspan: 2),
      layout-cell("h"),
      layout-cell("T"),
      layout-cell("eta"),
      layout-cell("A"),
      layout-cell("takeaway", colspan: 2),
    ),
    dominant: "formula",
  ),
  cards: (
    card(label: "formula", title: [Exponential-family form])[
      $ p(x | eta)
        = 1 / Z(eta) h(x) exp(eta^T T(x))
        = h(x) exp(eta^T T(x) - A(eta)) $
            $ A(eta) = log Z(eta) $
    ],
    bordered-card(label: "h", title: [$h(x)$ — base measure])[
      Fixed part of the density that may depend on $x$ but not on $eta$.
    ],
    bordered-card(label: "T", title: [$T(x)$ — sufficient statistics])[
      The data are represented through the vector $T(x)$.
    ],
    bordered-card(label: "eta", title: [$eta$ — natural parameters])[
      Coordinates for the distribution that pair linearly with $T(x)$.
    ],
    bordered-card(label: "A", title: [$A(eta)$ — log-partition function])[
      The parameter-dependent normalizer that makes the density integrate or sum to one.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      - The central interaction is the linear pairing $eta^T T(x)$.
      - The same four roles will recur even when the familiar parameterization changes.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("formula",),
    then: (
      reveal-step(("h", "T"), purpose: [Identify the data-side pieces.]),
      reveal-step(("eta", "A"), purpose: [Identify the parameter-side pieces.]),
      reveal-step(("takeaway",), purpose: [Name the reusable structure.]),
    ),
  ),
)

#slide-design(
  title: [Bernoulli already has the exponential-family form],
  teaching-move: [
    Work from the ordinary Bernoulli probability to the minimal
    exponential-family representation so that $T(x)=x$ and the log-odds
    natural parameter emerge from familiar algebra.
  ],
  layout: layout-stack(
    items: ("derivation", "mapping"),
    key-points: "takeaway",
    dominant: "derivation",
  ),
  cards: (
    card(label: "derivation", title: [Start from the familiar Bernoulli model])[
      $ "Ber"(x | mu)
        = mu^x (1-mu)^(1-x) $
            $ = exp(x log mu + (1-x) log(1-mu)) $
            $ = exp(x log(mu/(1-mu)) + log(1-mu)) $
    ],
    bordered-card(label: "mapping", title: [Match terms to the general form])[
      $ T(x) = x, quad
        eta = log(mu/(1-mu)), quad
        h(x) = 1 $
            $ A(eta) = -log(1-mu) = log(1 + e^eta) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      The exponential-family representation is obtained by regrouping the same
      Bernoulli probability; no new probability model has been introduced.
    ],
  ),
  reveal: design-reveal[
    Inside `derivation`, reveal the three displayed algebra lines cumulatively:
    ordinary Bernoulli probability → exponential rewrite → collect the coefficient
    of $x$. Keep earlier lines visible. Then reveal `mapping`, followed by
    `takeaway`. The mapping should not appear before the coefficient of $x$ is
    visible.
  ],
)

#slide-design(
  title: [Bernoulli log odds are its natural parameter],
  teaching-move: [
    Interpret the Bernoulli natural coordinate and the log-partition function so
    that the new parameterization feels meaningful rather than arbitrary.
  ],
  layout: layout-side(
    left: "coordinates",
    right: "normalizer",
    key-points: "takeaway",
    dominant: "coordinates",
  ),
  cards: (
    recall-card(
      label: "coordinates",
      from: [Previous slide: Bernoulli exponential-family mapping],
      title: [Probability and natural coordinates],
    )[
      $ eta = log(mu/(1-mu)) $
            $ mu = sigma(eta) = 1 / (1 + e^(-eta)) $
            $ mu in (0,1) quad longleftrightarrow quad eta in RR $
    ],
    bordered-card(label: "normalizer", title: [Normalization in natural coordinates])[
      $ A(eta) = log(1 + e^eta) $
            $ p(x | eta) = exp(x eta - A(eta)) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      - $eta$ is the *log odds*: a constrained probability becomes an unconstrained real coordinate.
      - $A(eta)$ supplies exactly the normalization required in that coordinate system.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("coordinates",),
    then: (
      reveal-step(("normalizer",), purpose: [Show what the normalizer becomes in natural coordinates.]),
      reveal-step(("takeaway",), purpose: [Interpret the coordinate change.]),
    ),
  ),
)

#slide-design(
  title: [One representation exposes the same ingredients across families],
  teaching-move: [
    Consolidate the four pieces of exponential-family structure and retain the
    Bernoulli mapping as the first worked example before moving to the Gaussian.
  ],
  layout: layout-summary(
    visual: "summary-visual",
    takeaways: "summary-takeaways",
  ),
  cards: (
    section-summary-visual(label: "summary-visual")[
      $ p(x | eta) = h(x) exp(eta^T T(x) - A(eta)) $
            #summary-map(
        ([$h(x)$], [$1$]),
        ([$T(x)$], [$x$]),
        ([$eta$], [$log(mu/(1-mu))$]),
        ([$A(eta)$], [$log(1+e^eta)$]),
      )
    ],
    section-summary-takeaways(label: "summary-takeaways")[
      - Exponential-family form separates base measure, sufficient statistics,
        natural parameters, and normalization.
      - For Bernoulli, the natural parameter is the log odds.
      - The Gaussian will provide a richer test of the same representation.
    ],
  ),
  key-points: (),
  reveal: reveal-static(("summary-visual", "summary-takeaways")),
)
