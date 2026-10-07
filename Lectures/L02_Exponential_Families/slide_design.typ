// Lecture 2 design specification — Section 1
// First pass intentionally written against the design language we want.
// design.typ is implemented after this section-level pseudo-design exists.

#import "../design.typ": *

#set document(
  title: "Lecture 2 — slide design",
  author: "Opher Donchin",
)

#section-design-notes(
  title: [Section 1 — Exponential families give familiar distributions a common form],
  purpose: [
    Introduce exponential-family representation as a useful common coordinate
    system by starting from distributions students already know rather than from
    an abstract definition alone.
  ],
  entry: [
    Students know the Bernoulli model well from prior Bayesian statistics and
    have just reviewed Gaussian distributions in Lecture 1.
  ],
  endpoint: [
    Students can read $p(x|eta)=h(x) exp(eta^T T(x)-A(eta))$, identify the four
    roles, derive the Bernoulli representation, and explain why Bernoulli's
    natural parameter is log odds.
  ],
  arc: [
    1. Familiar distributions look different but admit a common algebraic form.    2. Name the four recurring roles in that form.    3. Recover those roles by algebraically rewriting Bernoulli.    4. Interpret the Bernoulli natural coordinate and its normalizer.    5. Compress the section into a general-form → Bernoulli-specialization story.
  ],
  anchors: [
    - Primary anchor: $p(x|eta)=h(x) exp(eta^T T(x)-A(eta))$.
    - Secondary anchor: the Bernoulli correspondence
      $T(x)=x$, $eta=log(mu/(1-mu))$, $h(x)=1$, $A(eta)=log(1+e^eta)$.
    - Interpretive anchor: $mu in (0,1) arrow.l.r eta in RR$.
    - Keep $mu$ for Bernoulli probability and $eta$ for the natural parameter.
  ],
  summary-brief: [
    Ordinary slides nominate reusable visuals and key points as they are
    established. The summary designer selects a small combination that best
    retells the section's argument; selection is not by vote or by exhaustive
    coverage. Prefer already-taught anchors and do not introduce a new argument.
  ],
  continuity: [
    The section should end with a representation students can immediately reuse
    when the Gaussian is derived in the next section.
  ],
  constraints: [
    The opening Gaussian is motivational only; do not let its algebra dominate.
    The Bernoulli derivation should feel like regrouping a familiar model, not
    like introducing a new probability law.
  ],
)

#slide-design(
  title: [Different distributions can share the same algebraic structure],
  section: [Section 1 — Exponential families give familiar distributions a common form],
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
      $ cal(N)(x | mu, sigma^2)
        = 1 / sqrt(2 pi sigma^2)
          exp(-(x-mu)^2 / (2 sigma^2)) $
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
      - Familiar distributions can look very different in their usual parameterizations.
      - Exponential-family form rewrites them using one common algebraic structure.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("bernoulli", "gaussian"),
    then: (
      reveal-step(("shared",), purpose: [Expose the common algebraic target.]),
      reveal-step(("takeaway",), purpose: [State the common-structure claim.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate(
      "shared",
      reason: [The general exponential-family equation is the section's main visual anchor.],
    ),
    summary-key-point-candidate(
      [Exponential-family form gives familiar distributions one common algebraic structure.],
      from: "takeaway",
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
      - $h(x)$ and $T(x)$ are data-side terms; $eta$ and $A(eta)$ are parameter-side terms.
      - Their central interaction is the linear pairing $eta^T T(x)$.
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
  summary-candidates: (
    summary-visual-candidate(
      "formula",
      reason: [This is the compact reusable form that later sections will repeatedly instantiate.],
    ),
    summary-key-point-candidate(
      [$h(x)$ and $T(x)$ are data-side terms; $eta$ and $A(eta)$ are parameter-side terms.],
      from: "takeaway",
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
      Rewriting the same Bernoulli probability exposes
      $T(x)=x$ and $eta=log(mu/(1-mu))$; the probability model itself is unchanged.
    ],
  ),
  reveal: design-reveal[
    Inside `derivation`, reveal the three displayed algebra lines cumulatively:
    ordinary Bernoulli probability → exponential rewrite → collect the coefficient
    of $x$. Keep earlier lines visible. Then reveal `mapping`, followed by
    `takeaway`. The mapping should not appear before the coefficient of $x$ is
    visible.
  ],
  summary-candidates: (
    summary-visual-candidate(
      "mapping",
      reason: [The Bernoulli correspondence is the section's clearest worked specialization.],
    ),
    summary-key-point-candidate(
      [Rewriting Bernoulli exposes $T(x)=x$ and $eta=log(mu/(1-mu))$ without changing the model.],
      from: "takeaway",
    ),
  ),
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
            $ mu in (0,1) quad arrow.l.r quad eta in RR $
    ],
    bordered-card(label: "normalizer", title: [Normalization in natural coordinates])[
      $ A(eta) = log(1 + e^eta) $
            $ p(x | eta) = exp(x eta - A(eta)) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      - $eta$ is the *log odds*, mapping $mu in (0,1)$ to an unconstrained real coordinate.
      - $A(eta)=log(1+e^eta)$ normalizes Bernoulli in those coordinates.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("coordinates",),
    then: (
      reveal-step(("normalizer",), purpose: [Show what the normalizer becomes in natural coordinates.]),
      reveal-step(("takeaway",), purpose: [Interpret the coordinate change.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate(
      "coordinates",
      reason: [The interval-to-real-line mapping gives the natural parameter an immediate interpretation.],
    ),
    summary-key-point-candidate(
      [$eta$ is log odds, mapping $mu in (0,1)$ to $eta in RR$.],
      from: "takeaway",
    ),
  ),
)

#slide-design(
  title: [One representation exposes the same ingredients across families],
  teaching-move: [
    Retell the section as a general-form → Bernoulli-specialization →
    natural-coordinate argument using only already-established anchors.
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
      - Exponential-family form separates data-side terms from parameter-side terms.
      - For Bernoulli, $T(x)=x$ and $eta=log(mu/(1-mu))$.
      - The natural parameter is log odds: $mu in (0,1) arrow.l.r eta in RR$.
    ],
  ),
  key-points: (),
  reveal: reveal-static(("summary-visual", "summary-takeaways")),
  rationale: [
    Select the general formula and the Bernoulli correspondence from the
    nominated visual anchors. Together they tell the section's general → specific
    story directly. Keep the log-odds interpretation in the takeaways rather than
    adding a third visual, which would weaken the summary's hierarchy.
  ],
)
