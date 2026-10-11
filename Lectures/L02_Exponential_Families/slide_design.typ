// Lecture 2 design specification — complete lecture and Sections 1–8
// Build/revision against the approved eight-section organization.
// Design awaits instructor review; this is not a production deck.

#import "../design.typ": *

#set document(
  title: "Lecture 2 — slide design",
  author: "Opher Donchin",
)

#slide-design(
  title: [Exponential Families],
  section: [Lecture 2 — lecture title],
  teaching-move: [Open Lecture 2 with the established course title and subtitle.],
  layout: layout-stack(items: ("lecture-title", "lecture-footer"), dominant: "lecture-title"),
  cards: (
    card(label: "lecture-title", title: [Lecture title and subtitle])[
      Lecture 2

      *Exponential Families*

      Common coordinates for probability models
    ],
    card(label: "lecture-footer", title: [Abbreviated lecture title])[Exponential Families],
  ),
  reveal: reveal-static(("lecture-title", "lecture-footer")),
  constraints: [Static, restrained course title-slide treatment; no new mathematics. This lecture-level unit is separate from the 53 section slides and eight section design-notes pages.],
)

#section-design-notes(
  title: [Section 1 — Exponential families give familiar distributions a common form],
  purpose: [
    Introduce a useful common coordinate system for familiar distributions.
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
    + Open with the approved section title and subtitle.
    + Familiar distributions look different but admit a common algebraic form.
    + Name the four recurring roles in that form.
    + Recover those roles by algebraically rewriting Bernoulli.
    + Interpret the Bernoulli natural coordinate and its normalizer.
    + Retell the general-form → Bernoulli-specialization argument in the summary.
  ],
  anchors: [
    - Primary anchor: $p(x|eta)=h(x) exp(eta^T T(x)-A(eta))$.
    - Secondary anchor: the Bernoulli correspondence
      $T(x)=x$, $eta=log(mu/(1-mu))$, $h(x)=1$, $A(eta)=log(1+e^eta)$.
    - Interpretive anchor: $mu in (0,1) arrow.l.r eta in RR$.
    - Keep $mu$ for Bernoulli probability and $eta$ for the natural parameter.
  ],
  summary-brief: [
    Retell *shared template → Bernoulli mapping → log odds*. Select the general
    equation and Bernoulli correspondence as visual anchors, with takeaways for
    the four roles and natural coordinates. Gaussian algebra is excluded.
  ],
  continuity: [
    Enter from familiar Bernoulli probabilities and the Gaussian density.
    Retain the general form on the worked Bernoulli slide. End retrospectively;
    Section 2 owns its opening connection.
  ],
  constraints: [
    Six slides in 10–12 minutes. Gaussian is motivation only; no derivatives or
    MLE. Use $0 < mu < 1$ for finite natural coordinates; endpoints are limits.
    Source: Murphy Book 2 §§2.4.1–2.4.2.1, printed pp.34–35, equations
    (2.160) and (2.168)–(2.173).
  ],
)

#slide-design(
  title: [Exponential families give familiar distributions a common form],
  section: [Section 1 — title],
  teaching-move: [
    Open the question of how familiar distributions can be described in common
    coordinates using the approved title and subtitle.
  ],
  layout: layout-stack(
    items: ("section-title", "footer-title"),
    dominant: "section-title",
  ),
  cards: (
    card(label: "section-title", title: [Section title and subtitle])[
      *Exponential families give familiar distributions a common form*

      Bernoulli reveals the shared roles of data statistics, parameters, and normalization.
    ],
    card(label: "footer-title", title: [Abbreviated footer title])[
      Exponential-family form.
    ],
  ),
  reveal: reveal-static(("section-title", "footer-title")),
  constraints: [
    The full title is the dominant title-page object; the subtitle is subordinate
    directly beneath it. The abbreviated title specifies section footer metadata,
    not a second body panel. Use the established course section-title treatment.
    Do not add mathematics, an agenda, or a key-point region to this opening.
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
    card(
      label: "shared",
      title: [Shared exponential-family form],
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
      reveal-step(("shared",), emphasize: true, purpose: [Expose the common algebraic target.]),
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
    State the general form, then organize its four named roles into the
    data-side and parameter-side pieces asserted by the title.
  ],
  layout: layout-grid(
    columns: 2,
    cells: (
      layout-cell("formula", colspan: 2),
      layout-cell("data-side"),
      layout-cell("parameter-side"),
      layout-cell("takeaway", colspan: 2),
    ),
    dominant: "formula",
  ),
  cards: (
    card(label: "formula", title: [Exponential-family form])[
      $ p(x | eta) = h(x) exp(eta^T T(x) - A(eta)) $
      $ A(eta) = log Z(eta) $
    ],
    bordered-card(label: "data-side", title: [Data-side functions])[
      #stack(
        spacing: 0.35em,
        [$h(x)$ — *base measure*: fixed with respect to $eta$],
        [$T(x)$ — *sufficient statistics*: the data representation],
      )
    ],
    bordered-card(label: "parameter-side", title: [Parameter-side terms])[
      #stack(
        spacing: 0.35em,
        [$eta$ — *natural parameters*: pair linearly with $T(x)$],
        [$A(eta)$ — *log-partition function*: normalizes the distribution],
      )
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      - Data-side $h(x), T(x)$ meet parameter-side $eta, A(eta)$ through the linear pairing $eta^T T(x)$.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("formula",),
    then: (
      reveal-step(("data-side",), emphasize: true, purpose: [Identify the two data-side roles together.]),
      reveal-step(("parameter-side",), emphasize: true, purpose: [Identify the two parameter-side roles together.]),
      reveal-step(("takeaway",), purpose: [State the separation and the linear interaction.]),
    ),
  ),
  summary-candidates: (
    summary-key-point-candidate(
      [Data-side $h(x), T(x)$ meet parameter-side $eta, A(eta)$ through $eta^T T(x)$.],
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
    items: ("form-recall", "bernoulli-start", "exponential-rewrite", "collect-x", "mapping"),
    key-points: "takeaway",
    dominant: "collect-x",
  ),
  cards: (
    recall-card(
      label: "form-recall",
      from: [Previous slide: exponential-family form],
    )[
      $ p(x | eta) = h(x) exp(eta^T T(x) - A(eta)) $
    ],
    card(label: "bernoulli-start", title: [Familiar Bernoulli model])[
      $ "Ber"(x | mu)
        = mu^x (1-mu)^(1-x), quad x in {0,1}, quad 0 < mu < 1 $
    ],
    card(label: "exponential-rewrite", title: [Rewrite powers as an exponential])[
      $ = exp(x log mu + (1-x) log(1-mu)) $
    ],
    card(label: "collect-x", title: [Collect the coefficient of x])[
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
  reveal: reveal-cumulative(
    initial: ("form-recall", "bernoulli-start"),
    then: (
      reveal-step(("exponential-rewrite",), emphasize: true, purpose: [Expose the exponent of the familiar probability.]),
      reveal-step(("collect-x",), emphasize: true, purpose: [Separate the data term from the parameter-only term.]),
      reveal-step(("mapping",), emphasize: true, purpose: [Match the collected expression to the persistent general form.]),
      reveal-step(("takeaway",), purpose: [State the meaning of the rewrite.]),
    ),
  ),
  constraints: [
    The three labeled algebra steps form one aligned derivation in production,
    with earlier lines retained. Keep the general-form recall subordinate.
    Reveal mapping only after the coefficient of $x$ is visible; transient entry
    emphasis settles on subsequent states. Do not put borders around individual
    algebra lines. The final state must show the whole derivation and mapping.
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
    Interpret the carried-forward natural parameter as log odds, invert the
    coordinate change, and identify its normalizer.
  ],
  layout: layout-grid(
    columns: 2,
    cells: (
      layout-cell("eta-recall", colspan: 2),
      layout-cell("coordinates"),
      layout-cell("normalizer"),
      layout-cell("takeaway", colspan: 2),
    ),
    dominant: "coordinates",
  ),
  cards: (
    recall-card(
      label: "eta-recall",
      from: [Previous slide: Bernoulli exponential-family mapping],
      title: [Carried forward],
    )[
      $ eta = log(mu/(1-mu)) $
    ],
    schema-card(
      label: "coordinates",
      caption: [The natural parameter is an unconstrained coordinate for the same Bernoulli family.],
    )[
      #stack(
        spacing: 0.55em,
        [$ eta = "logit"(mu) quad arrow.l.r quad mu = sigma(eta) = 1/(1+e^(-eta)) $],
        [$ mu in (0,1) quad arrow.l.r quad eta in RR $],
      )
    ],
    bordered-card(label: "normalizer", title: [Normalization in natural coordinates])[
      $ Z(eta) = sum_(x=0)^1 e^(x eta) = 1 + e^eta $
      $ A(eta) = log(1 + e^eta), quad p(x | eta) = exp(x eta - A(eta)) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      - $eta$ is the *log odds*: it maps a constrained probability to an unconstrained real coordinate.
      - $A(eta)=log(1+e^eta)$ normalizes Bernoulli in that coordinate system.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("eta-recall", "coordinates"),
    then: (
      reveal-step(("normalizer",), emphasize: true, purpose: [Add the normalization term once the coordinate change is understood.]),
      reveal-step(("takeaway",), purpose: [State the interpretation of the natural coordinate.]),
    ),
  ),
  summary-candidates: (
    summary-key-point-candidate(
      [$eta$ is log odds, mapping $mu in (0,1)$ to $eta in RR$.],
      from: "takeaway",
    ),
  ),
)

#slide-design(
  title: [One representation exposes the same ingredients across families],
  section: [Section 1 — summary],
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
      - The exponential-family form separates data-side functions from parameter-side coordinates.
      - Bernoulli has $h(x)=1$, $T(x)=x$, $eta=log(mu/(1-mu))$, and $A(eta)=log(1+e^eta)$.
      - Its natural parameter is log odds: $mu in (0,1) arrow.l.r eta in RR$.
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
  constraints: [
    This is the final Section 1 teaching move. Select only material established
    on the preceding slides; include no forward pointer or closing handoff.
    Use the course's explicitly labeled summary treatment while preserving the
    approved slide title.
  ],
)

#section-design-notes(
  title: [Section 2 — A Gaussian can be rewritten in exponential-family coordinates],
  purpose: [
    Derive every piece of the Gaussian exponential-family representation from
    the familiar density in one self-contained section.
  ],
  entry: [
    Section 1 supplied the common form. Lecture 1 supplied the multivariate
    Gaussian density, mean, covariance, and quadratic forms. Introduce precision
    and information coordinates here; prior exposure to them is not assumed.
  ],
  endpoint: [
    Students can identify Gaussian $h(bold(x))$, $T(bold(x))$, $eta$, and $A(eta)$,
    and connect $Lambda=Sigma^(-1)$ and $xi=Lambda mu$ to the density's linear
    and quadratic coefficients.
  ],
  arc: [
    Familiar density → precision and expanded quadratic → linear and quadratic
    data statistics → natural coefficients and normalizer → complete mapping.
  ],
  anchors: [
    - $bold(x), mu in RR^D$; $Sigma$ and $Lambda$ are symmetric positive definite.
    - $Lambda=Sigma^(-1)$; $xi=Lambda mu$.
    - $T(bold(x))=[bold(x); op("vec")(bold(x)bold(x)^T)]$.
    - $eta=[xi; -1/2 op("vec")(Lambda)]$.
    - Use $h(bold(x))=(2 pi)^(-D/2)$ throughout.
  ],
  summary-brief: [
    Select the complete four-role mapping as the summary visual. Retain the
    meanings of precision and precision-weighted mean in two short takeaways.
    Do not repeat all quadratic-expansion lines or introduce moments.
  ],
  continuity: [
    Open by testing Section 1's common form on the known Gaussian density.
    This unit stands alone if moved to a recording; end retrospectively.
  ],
  constraints: [
    Six slides in 8–10 minutes. No conditioning, inference, or derivatives of
    $A$. Vectorization stacks matrix entries in one fixed order; the full
    symmetric-matrix representation is nonminimal. Source: Murphy Book 2
    §2.4.2.5, printed pp.38–39, equations (2.198)–(2.213).

    Precision and information coordinates are defined locally, consistent with
    the corrected upstream prerequisite contract.
  ],
)

#slide-design(
  title: [A Gaussian can be rewritten in exponential-family coordinates],
  section: [Section 2 — title],
  teaching-move: [
    Frame the Gaussian rewrite as a test of the common form established in
    Section 1.
  ],
  layout: layout-stack(
    items: ("section-title", "footer-title"),
    dominant: "section-title",
  ),
  cards: (
    card(label: "section-title", title: [Section title and subtitle])[
      *A Gaussian can be rewritten in exponential-family coordinates*

      From the familiar density to precision and information coordinates.
    ],
    card(label: "footer-title", title: [Abbreviated footer title])[
      Gaussian coordinates.
    ],
  ),
  reveal: reveal-static(("section-title", "footer-title")),
  constraints: [
    Use the established section-title treatment: full title dominant, subtitle
    beneath it, abbreviated title as footer metadata. This title page contains
    no agenda or new mathematical content.
  ],
)

#slide-design(
  title: [The Gaussian density hides an exponential-family representation],
  teaching-move: [
    Place the known Gaussian density against the common-form target and name
    the rewrite students will perform.
  ],
  layout: layout-stack(
    items: ("gaussian-density", "common-form"),
    key-points: "takeaway",
    dominant: "gaussian-density",
  ),
  cards: (
    card(label: "gaussian-density", title: [The familiar multivariate Gaussian])[
      $ p(bold(x) | mu, Sigma)
        = 1/((2 pi)^(D/2) |Sigma|^(1/2))
          exp(-1/2 (bold(x)-mu)^T Sigma^(-1) (bold(x)-mu)) $
      $ bold(x), mu in RR^D, quad Sigma = Sigma^T > 0 $
    ],
    recall-card(
      label: "common-form",
      from: [Section 1: common exponential-family form],
    )[
      $ p(bold(x) | eta) = h(bold(x)) exp(eta^T T(bold(x)) - A(eta)) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      The rewrite separates functions of the data from parameter coefficients
      and normalization.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("gaussian-density",),
    then: (
      reveal-step(("common-form",), purpose: [Make the representation target visible.]),
      reveal-step(("takeaway",), purpose: [Identify the algebraic task.]),
    ),
  ),
  constraints: [
    The complete familiar density is the main inspection object; the recalled
    target is subordinate. State that $Sigma>0$ means positive definite.
    Preserve the Lecture 1 notation: bold data vector, unbold mean vector.
  ],
)

#slide-design(
  title: [Expanding the quadratic separates data-dependent and parameter-only terms],
  teaching-move: [
    Introduce precision, expand the quadratic, and collect the data terms apart
    from the parameter-only terms of the density.
  ],
  layout: layout-stack(
    items: ("density-recall", "precision", "quadratic-expansion", "grouped-density"),
    key-points: "takeaway",
    dominant: "quadratic-expansion",
  ),
  cards: (
    recall-card(
      label: "density-recall",
      from: [Previous slide: Gaussian density],
    )[
      $ p(bold(x) | mu, Sigma)
        = 1/((2 pi)^(D/2) |Sigma|^(1/2))
          exp(-1/2 (bold(x)-mu)^T Sigma^(-1) (bold(x)-mu)) $
    ],
    card(label: "precision", title: [Precision replaces inverse covariance])[
      $ Lambda = Sigma^(-1), quad Lambda = Lambda^T > 0 $
      $ |Sigma|^(-1/2) = |Lambda|^(1/2) = exp(1/2 log |Lambda|) $
    ],
    card(label: "quadratic-expansion", title: [Expand, then use symmetry])[
      $ (bold(x)-mu)^T Lambda (bold(x)-mu)
          &= bold(x)^T Lambda bold(x) - bold(x)^T Lambda mu
             - mu^T Lambda bold(x) + mu^T Lambda mu \
          &= bold(x)^T Lambda bold(x) - 2 bold(x)^T Lambda mu + mu^T Lambda mu $
    ],
    schema-card(label: "grouped-density", title: [The expanded log density])[
      $ log p(bold(x) | mu, Sigma)
          &= -D/2 log(2 pi) \
          &quad + underbrace(bold(x)^T Lambda mu - 1/2 bold(x)^T Lambda bold(x), "data-dependent") \
          &quad + underbrace(1/2 log |Lambda| - 1/2 mu^T Lambda mu, "parameter-only") $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      The data enter through a linear term and a quadratic term; the remaining
      terms depend only on the parameters.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("density-recall",),
    then: (
      reveal-step(("precision",), emphasize: true, purpose: [Define precision and rewrite the determinant factor.]),
      reveal-step(("quadratic-expansion",), emphasize: true, purpose: [Use symmetry to combine the two cross terms.]),
      reveal-step(("grouped-density",), emphasize: true, purpose: [Collect the three roles in the log density.]),
      reveal-step(("takeaway",), purpose: [State what expansion exposed.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate(
      "grouped-density",
      reason: [Shows the origin of data terms and normalization.],
    ),
  ),
  constraints: [
    Retain the original density as compact subordinate context. Treat each
    expansion or grouping as one teaching state, keeping both expansion lines
    visible together. Underbrace labels are explanatory annotations.
    Do not make the determinant identity a separate derivation.
  ],
)

#slide-design(
  title: [The Gaussian sufficient statistics are `x` and `xxᵀ`],
  teaching-move: [
    Rewrite the quadratic term as a coefficient–statistic pairing, then identify
    the linear and quadratic sufficient statistics.
  ],
  layout: layout-stack(
    items: ("data-terms", "quadratic-pairing", "statistics"),
    key-points: "takeaway",
    dominant: "statistics",
  ),
  cards: (
    recall-card(
      label: "data-terms",
      from: [Previous slide: data-dependent exponent],
    )[
      $ bold(x)^T Lambda mu - 1/2 bold(x)^T Lambda bold(x) $
    ],
    card(label: "quadratic-pairing", title: [Expose the quadratic data object])[
      $ bold(x)^T Lambda bold(x)
          = sum_(i,j) Lambda_(i j) x_i x_j
          = op("vec")(Lambda)^T op("vec")(bold(x)bold(x)^T) $
      $ (bold(x)bold(x)^T)_(i j) = x_i x_j $
    ],
    schema-card(label: "statistics", title: [One vector of linear and quadratic statistics])[
      $ T(bold(x)) = mat(bold(x); op("vec")(bold(x)bold(x)^T), delim: "[") $
      $ op("vec")(M) : "stack the columns of" M $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      Gaussian sufficient statistics contain the coordinates and their pairwise
      products: $bold(x)$ and $bold(x)bold(x)^T$.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("data-terms",),
    then: (
      reveal-step(("quadratic-pairing",), emphasize: true, purpose: [Expose the entries of the quadratic statistic.]),
      reveal-step(("statistics",), purpose: [Stack the two data objects into the common-form statistic vector.]),
      reveal-step(("takeaway",), purpose: [Name what the statistics retain.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("statistics", reason: [Supplies the Gaussian data side of the final mapping.]),
    summary-key-point-candidate(
      [Gaussian sufficient statistics are the coordinates and their pairwise products.],
      from: "takeaway",
    ),
  ),
  constraints: [
    Column stacking is a bookkeeping convention. Display the equality of the
    quadratic form, entry sum, and vector pairing simultaneously. Mention once
    that symmetric matrices repeat off-diagonal entries, so this full-vector
    representation is nonminimal; do not derive a minimal parameterization.
  ],
)

#slide-design(
  title: [Precision and precision-weighted mean are Gaussian natural parameters],
  teaching-move: [
    Match the coefficients to the statistic vector, then convert the
    parameter-only exponent into the log-partition term.
  ],
  layout: layout-grid(
    columns: 2,
    cells: (
      layout-cell("statistics-recall", colspan: 2),
      layout-cell("natural-parameters"),
      layout-cell("normalization"),
      layout-cell("canonical-density", colspan: 2),
      layout-cell("takeaway", colspan: 2),
    ),
    dominant: "natural-parameters",
  ),
  cards: (
    recall-card(
      label: "statistics-recall",
      from: [Previous slide: Gaussian sufficient statistics],
    )[
      $ T(bold(x)) = mat(bold(x); op("vec")(bold(x)bold(x)^T), delim: "[") $
    ],
    schema-card(label: "natural-parameters", title: [Natural coordinates])[
      $ xi = Lambda mu, quad eta = mat(xi; -1/2 op("vec")(Lambda), delim: "[") $
      $ eta^T T(bold(x)) = bold(x)^T xi - 1/2 bold(x)^T Lambda bold(x) $
      $ Sigma=Lambda^(-1), quad mu=Lambda^(-1)xi $
    ],
    bordered-card(label: "normalization", title: [Parameter-only terms give −A])[
      $ mu^T Lambda mu = xi^T Lambda^(-1)xi $
      $ -A(eta) = 1/2 log |Lambda| - 1/2 xi^T Lambda^(-1)xi $
      $ h(bold(x)) = (2 pi)^(-D/2) $
    ],
    card(label: "canonical-density", title: [Complete exponential-family form])[
      $ p(bold(x) | eta)
        = h(bold(x)) exp(eta^T T(bold(x)) - A(eta)) $
      $ A(eta) = -1/2 log |Lambda| + 1/2 xi^T Lambda^(-1)xi $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      - Precision $Lambda$ controls the quadratic coefficient; precision-weighted
        mean $xi$ controls the linear coefficient.
      - $(xi,Lambda)$ are information coordinates for the same Gaussian.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("statistics-recall",),
    then: (
      reveal-step(("natural-parameters",), emphasize: true, purpose: [Identify the coefficients paired with the statistics.]),
      reveal-step(("normalization",), emphasize: true, purpose: [Read the base measure and negative log partition from the expanded density.]),
      reveal-step(("canonical-density",), purpose: [Assemble all four common-form roles.]),
      reveal-step(("takeaway",), purpose: [Interpret the Gaussian natural coordinates.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("natural-parameters", reason: [Pairs the data statistics with their Gaussian coefficients.]),
    summary-visual-candidate("canonical-density", reason: [Completes the Gaussian common-form mapping.]),
    summary-key-point-candidate(
      [Precision controls the quadratic coefficient; precision-weighted mean controls the linear coefficient.],
      from: "takeaway",
    ),
  ),
  constraints: [
    Keep the statistic vector subordinate while the natural coefficients become
    the dominant object. Then compare coefficients and normalization side by
    side. With $h(bold(x))=(2 pi)^(-D/2)$, $A$ has no additional $D/2 log(2 pi)$
    term. Require $Lambda$ symmetric positive definite. Introduce the name
    “information coordinates” here without claiming it was taught in Lecture 1.
  ],
)

#slide-design(
  title: [Gaussian information coordinates are exponential-family coordinates],
  section: [Section 2 — summary],
  teaching-move: [
    Retell the completed rewrite as a single four-role mapping from ordinary
    Gaussian parameters to exponential-family coordinates.
  ],
  layout: layout-summary(
    visual: "summary-visual",
    takeaways: "summary-takeaways",
  ),
  cards: (
    section-summary-visual(label: "summary-visual")[
      $ Lambda=Sigma^(-1), quad xi=Lambda mu $
      $ p(bold(x)|eta)=h(bold(x))exp(eta^T T(bold(x))-A(eta)) $
      #summary-map(
        ([$h(bold(x))$], [$(2 pi)^(-D/2)$]),
        ([$T(bold(x))$], [$ mat(bold(x); op("vec")(bold(x)bold(x)^T), delim: "[") $]),
        ([$eta$], [$ mat(xi; -1/2 op("vec")(Lambda), delim: "[") $]),
        ([$A(eta)$], [$-1/2 log |Lambda| + 1/2 xi^T Lambda^(-1)xi$]),
      )
    ],
    section-summary-takeaways(label: "summary-takeaways")[
      - Gaussian sufficient statistics are the coordinates and their pairwise products.
      - Precision controls the quadratic coefficient; precision-weighted mean controls the linear coefficient.
    ],
  ),
  reveal: reveal-static(("summary-visual", "summary-takeaways")),
  rationale: [
    Select the statistic vector, natural coefficients, and completed canonical
    density. Recombine them into one mapping; omit the nominated expansion
    because it would repeat the algebra rather than summarize its result.
  ],
  constraints: [
    This final teaching move is retrospective. Preserve the same base-measure
    convention and full-vector representation used above. Include the course's
    explicit summary label without changing the approved title. No moments,
    derivative identities, or closing handoff appear here.
  ],
)

#section-design-notes(
  title: [Section 3 — The log-partition function connects parameters to moments],
  purpose: [
    Derive the mean identity from normalization, then interpret natural and mean
    coordinates and sketch the covariance identity.
  ],
  entry: [
    Use the general form and Bernoulli mapping from Section 1. Gaussian algebra
    is optional context; the argument does not depend on Section 2 being live.
  ],
  endpoint: [
    Students can derive $nabla A(eta)=E_eta [T(X)]$, read mean parameters, and
    interpret $nabla^2 A(eta)=op("Cov")_eta [T(X)]$ as covariance and convexity.
  ],
  arc: [
    Normalization for each parameter → differentiate under the integral → mean
    statistic → Bernoulli coordinate check → covariance and convexity → summary.
  ],
  anchors: [
    - $p(x|eta)=h(x)exp(eta^T T(x)-A(eta))$.
    - $m(eta)=E_eta [T(X)]=nabla A(eta)$.
    - $nabla^2 A(eta)=op("Cov")_eta [T(X)]$.
    - Bernoulli: $T(x)=x$, $A(eta)=log(1+e^eta)$, $m=mu$.
  ],
  summary-brief: [
    Select the paired mean/covariance identities as the dominant visual. Retain
    Bernoulli's logistic map as a compact check, with a convexity takeaway.
    Omit the full differentiation sequence from the summary.
  ],
  continuity: [
    Open by asking what Section 1's normalizer must do when the natural weights
    change. Close by consolidating only the model-moment identities taught here.
  ],
  constraints: [
    Seven slides in 18–20 minutes. Fixed parameter-independent support, interior
    natural parameters, finite required moments, and valid differentiation under
    the integral are assumed. Replace integrals by sums for discrete models.
    State covariance/convexity without claiming strict convexity. Do not claim
    a unique general inverse unless the family is minimal; Bernoulli's inverse
    is explicit. No conjugate functions, Fisher information, or MLE.
    Source: Murphy Book 2 §§2.4.3–2.4.4, printed pp.39–41, equations
    (2.216)–(2.230) and (2.233)–(2.237).
  ],
)

#slide-design(
  title: [The log-partition function connects parameters to moments],
  section: [Section 3 — title],
  teaching-move: [
    Frame the question of what normalization reveals about model statistics.
  ],
  layout: layout-stack(items: ("section-title", "footer-title"), dominant: "section-title"),
  cards: (
    card(label: "section-title", title: [Section title and subtitle])[
      *The log-partition function connects parameters to moments*

      Normalization links natural parameters to means and covariance.
    ],
    card(label: "footer-title", title: [Abbreviated footer title])[
      Log-partition moments.
    ],
  ),
  reveal: reveal-static(("section-title", "footer-title")),
  constraints: [
    Use the shared section-title hierarchy, with the abbreviated title as footer
    metadata. No new formula or key-point panel appears on this title page.
  ],
)

#slide-design(
  title: [The normalizer must change when the natural parameter changes],
  teaching-move: [
    Expose the normalization identity that holds at every valid natural
    parameter, providing the fixed identity to differentiate.
  ],
  layout: layout-stack(items: ("form-recall", "partition", "normalization"), key-points: "takeaway", dominant: "normalization"),
  cards: (
    recall-card(label: "form-recall", from: [Section 1: common form])[
      $ p(x|eta)=h(x)exp(eta^T T(x)-A(eta)) $
    ],
    card(label: "partition", title: [Normalization determines A])[
      $ Z(eta)=integral h(x)exp(eta^T T(x)) dif x, quad A(eta)=log Z(eta) $
    ],
    card(label: "normalization", title: [One identity for every valid parameter])[
      $ integral p(x|eta) dif x = exp(-A(eta)) Z(eta) = 1 $
      For discrete models, replace the integral by a sum.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      $A(eta)$ compensates for the natural weights so total probability stays one.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("form-recall",),
    then: (
      reveal-step(("partition",), purpose: [Identify the unnormalized mass and its logarithm.]),
      reveal-step(("normalization",), emphasize: true, purpose: [Make the invariant total probability explicit.]),
      reveal-step(("takeaway",), purpose: [State the role of the normalizer.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("normalization", reason: [The fixed identity starts the derivative argument.]),
  ),
  constraints: [
    The support is fixed with respect to $eta$; all displayed identities apply
    where $Z(eta)<infinity$. The normalization identity becomes the next slide's
    subordinate recall. Do not assert a nonzero change in every parameter direction.
  ],
)

#slide-design(
  title: [Differentiating normalization exposes the expected sufficient statistic],
  teaching-move: [
    Differentiate the constant total probability, then use the common-form
    derivative to expose an expectation of the statistic.
  ],
  layout: layout-stack(items: ("normalization-recall", "differentiate", "inside-derivative", "expectation"), key-points: "takeaway", dominant: "inside-derivative"),
  cards: (
    recall-card(label: "normalization-recall", from: [Previous slide: total probability])[
      $ integral p(x|eta) dif x = 1 $
    ],
    card(label: "differentiate", title: [Differentiate both sides])[
      $ 0=nabla_eta integral p(x|eta) dif x=integral nabla_eta p(x|eta) dif x $
    ],
    card(label: "inside-derivative", title: [Derivative of the common-form density])[
      $ nabla_eta p(x|eta)=p(x|eta)(T(x)-nabla A(eta)) $
    ],
    card(label: "expectation", title: [Recognize the expectation])[
      $ 0 &= integral (T(x)-nabla A(eta))p(x|eta) dif x \
          &= E_eta [T(X)]-nabla A(eta) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      Differentiating normalization equates $nabla A(eta)$ with the expected statistic.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("normalization-recall",),
    then: (
      reveal-step(("differentiate",), emphasize: true, purpose: [The derivative of total probability is zero.]),
      reveal-step(("inside-derivative",), emphasize: true, purpose: [The chain rule produces the statistic minus the normalizer gradient.]),
      reveal-step(("expectation",), emphasize: true, purpose: [Integrate the density-weighted statistic and use normalization.]),
      reveal-step(("takeaway",), purpose: [Name the equality the calculation established.]),
    ),
  ),
  constraints: [
    Preserve the normalization identity and prior derivative steps throughout.
    The final two lines form one aligned equation group. State the regularity
    assumption when moving the derivative inside the integral; do not expand
    it into a separate theorem. For discrete models the same steps use sums.
  ],
)

#slide-design(
  title: [The gradient of the log-partition function is the mean parameter],
  teaching-move: [
    Separate the reusable mean identity from the calculation and interpret the
    mapping from natural weights to expected statistics.
  ],
  layout: layout-stack(items: ("mean-identity", "coordinate-map"), key-points: "takeaway", dominant: "mean-identity"),
  cards: (
    card(label: "mean-identity", title: [Mean parameters])[
      $ m(eta)=E_eta [T(X)]=nabla A(eta) $
    ],
    schema-card(label: "coordinate-map", title: [From natural weights to model means])[
      $ eta arrow.r^(nabla A) m $
      Natural parameters weight the statistics; mean parameters state their expectations.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      The mean parameter is the expected sufficient statistic, which need not be $E[X]$.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("mean-identity",),
    then: (
      reveal-step(("coordinate-map",), purpose: [Interpret the direction of the parameter map.]),
      reveal-step(("takeaway",), purpose: [Distinguish a statistic mean from the raw-data mean.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("mean-identity", reason: [The section's first reusable derivative identity.]),
    summary-key-point-candidate([The mean parameter is the expected sufficient statistic.], from: "takeaway"),
  ),
  constraints: [
    Show a one-way map here; do not assert a unique inverse for a redundant
    representation. The general mean parameter may be a vector.
  ],
)

#slide-design(
  title: [Bernoulli shows natural and mean parameters are two coordinates for one family],
  teaching-move: [
    Differentiate the known Bernoulli log partition and identify its result as
    both the mean statistic and the inverse log-odds map.
  ],
  layout: layout-stack(items: ("bernoulli-recall", "derivative", "coordinate-map"), key-points: "takeaway", dominant: "derivative"),
  cards: (
    recall-card(label: "bernoulli-recall", from: [Section 1: Bernoulli mapping])[
      $ T(x)=x, quad A(eta)=log(1+e^eta), quad eta=log(mu/(1-mu)) $
    ],
    card(label: "derivative", title: [Recover the model mean])[
      $ A'(eta)=e^eta/(1+e^eta)=1/(1+e^(-eta))=mu=E_eta [X] $
    ],
    schema-card(label: "coordinate-map", title: [Two coordinates, one Bernoulli model])[
      $ eta in RR arrow.r^"logistic" m=mu in (0,1) $
      $ mu in (0,1) arrow.r^"log odds" eta=log(mu/(1-mu)) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      Bernoulli's natural coordinate is log odds; its mean coordinate is the success probability.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("bernoulli-recall",),
    then: (
      reveal-step(("derivative",), emphasize: true, purpose: [Verify the mean identity in the known example.]),
      reveal-step(("coordinate-map",), purpose: [Interpret the explicit reversible map.]),
      reveal-step(("takeaway",), purpose: [State the meaning of the two coordinates.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("derivative", reason: [A compact concrete check of the mean identity.]),
  ),
  constraints: [
    Keep $mu$ as the Bernoulli probability, matching Section 1. Finite natural
    coordinates correspond to $0<mu<1$. The visible inverse belongs to this
    minimal example, not to every possible exponential-family representation.
  ],
)

#slide-design(
  title: [Differentiating again turns curvature into covariance],
  teaching-move: [
    Sketch the second derivative using the density derivative, recognize the
    covariance, and state its positive-semidefinite consequence.
  ],
  layout: layout-stack(items: ("mean-recall", "covariance-sketch", "curvature"), key-points: "takeaway", dominant: "covariance-sketch"),
  cards: (
    recall-card(label: "mean-recall", from: [Earlier in this section: mean and density derivatives])[
      $ m=E_eta [T(X)]=nabla A(eta), quad nabla_eta p=p(T-m) $
    ],
    card(label: "covariance-sketch", title: [Differentiate the expected statistic])[
      $ nabla^2 A(eta)
          &= integral T(x)(T(x)-m)^T p(x|eta) dif x \
          &= E_eta [T(X)T(X)^T]-m m^T \
          &= op("Cov")_eta [T(X)] $
    ],
    card(label: "curvature", title: [Covariance gives nonnegative curvature])[
      $ v^T nabla^2 A(eta)v=op("Var")_eta [v^T T(X)] >= 0 $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      - Curvature of $A$ is the covariance of the sufficient statistics.
      - $A$ is convex; the covariance need not be positive definite.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("mean-recall",),
    then: (
      reveal-step(("covariance-sketch",), emphasize: true, purpose: [Recognize the second moment minus the outer product of the mean.]),
      reveal-step(("curvature",), purpose: [Read convexity from nonnegative variance in every direction.]),
      reveal-step(("takeaway",), purpose: [Retain covariance and convexity without a strictness claim.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("covariance-sketch", reason: [The section's second derivative identity.]),
    summary-key-point-candidate([Covariance gives positive-semidefinite curvature, so A is convex.], from: "takeaway"),
  ),
  constraints: [
    This is a derivational sketch, not a second long live proof. Show the three
    sketch lines together; retain the recall. Do not add a Fisher-information
    interpretation or claim strict convexity for a nonminimal representation.
  ],
)

#slide-design(
  title: [The log-partition function converts parameters into moments],
  section: [Section 3 — summary],
  teaching-move: [
    Consolidate the paired derivative identities with the Bernoulli mean check.
  ],
  layout: layout-summary(visual: "summary-visual", takeaways: "summary-takeaways"),
  cards: (
    section-summary-visual(label: "summary-visual")[
      $ nabla A(eta)=E_eta [T(X)] $
      $ nabla^2 A(eta)=op("Cov")_eta [T(X)] $
      Bernoulli: $A'(eta)=1/(1+e^(-eta))=mu$.
    ],
    section-summary-takeaways(label: "summary-takeaways")[
      - Normalization makes derivatives of $A$ encode model statistics.
      - The gradient gives mean statistics; curvature gives their covariance.
      - Covariance makes $A$ convex.
    ],
  ),
  reveal: reveal-static(("summary-visual", "summary-takeaways")),
  rationale: [
    Select the mean identity, covariance result, and Bernoulli derivative.
    Omit the nominated normalization algebra; the takeaways recall its role
    without competing with the paired results.
  ],
  constraints: [
    Final retrospective teaching move, explicitly labeled as a summary in
    production. No dataset statistics, estimation condition, or closing handoff.
  ],
)

#section-design-notes(
  title: [Section 4 — Learning an exponential-family model means matching model moments to data],
  purpose: [
    Derive one general IID maximum-likelihood rule and check it against Bernoulli.
  ],
  entry: [
    Section 3 supplied $nabla A(eta)=E_eta [T(X)]$ and convexity of $A$.
    Students know IID samples, likelihoods, and the Bernoulli sample proportion.
  ],
  endpoint: [
    Students can collect $T(cal(D))=sum_(n=1)^N T(x_n)$, derive the score,
    and identify the finite-interior-MLE condition
    $E_(hat(eta)) [T(X)]=T(cal(D))/N$.
  ],
  arc: [
    IID product → aggregate statistic and log likelihood → derivative identity
    → score as discrepancy → moment matching → Bernoulli check → summary.
  ],
  anchors: [
    - $cal(D)={x_1,dots,x_N}$, with $N$ fixed.
    - $T(cal(D))=sum_(n=1)^N T(x_n)$; $overline(T)=T(cal(D))/N$.
    - $m(eta)=E_eta [T(X)]$.
    - $nabla ell(eta)=T(cal(D))-N m(eta)$.
  ],
  summary-brief: [
    Retell data → aggregate statistic → score discrepancy → fitted mean with one
    compact equation chain. Keep Bernoulli as a short check rather than another
    main visual. Preserve the finite-interior qualification.
  ],
  continuity: [
    Open by applying the common form to an observed sample. Close on the
    established likelihood learning rule; no maximum-entropy handoff.
  ],
  constraints: [
    Seven slides in 16–18 minutes. Fixed support and regular differentiation
    assumptions carry forward. Data reduction is a likelihood factorization,
    not literal equality of dataset and statistic densities. Concavity alone
    guarantees neither existence nor uniqueness of a finite MLE. Boundary
    Bernoulli fits have infinite limiting natural coordinates.
    Source: Murphy Book 2 §2.4.5, printed p.42, equations (2.242)–(2.249);
    use the factorization and qualified optimum statements described here.
  ],
)

#slide-design(
  title: [Learning an exponential-family model means matching model moments to data],
  section: [Section 4 — title],
  teaching-move: [
    Frame how an observed sample determines parameters within a specified family.
  ],
  layout: layout-stack(items: ("section-title", "footer-title"), dominant: "section-title"),
  cards: (
    card(label: "section-title", title: [Section title and subtitle])[
      *Learning an exponential-family model means matching model moments to data*

      IID likelihoods turn observed statistics into an estimation rule.
    ],
    card(label: "footer-title", title: [Abbreviated footer title])[
      Moment matching.
    ],
  ),
  reveal: reveal-static(("section-title", "footer-title")),
  constraints: [
    Use the established section-title hierarchy with abbreviated footer metadata.
    No mathematical argument appears on the title page.
  ],
)

#slide-design(
  title: [An IID sample enters the likelihood through its aggregate sufficient statistic],
  teaching-move: [
    Form the IID product, collect repeated terms, and expose the aggregate
    sufficient statistic in the log likelihood.
  ],
  layout: layout-stack(items: ("iid-product", "collected-product", "aggregate", "log-likelihood"), key-points: "takeaway", dominant: "aggregate"),
  cards: (
    card(label: "iid-product", title: [An IID sample from one model])[
      $ cal(D)={x_1,dots,x_N}, quad p(cal(D)|eta)=product_(n=1)^N p(x_n|eta) $
      $ p(x_n|eta)=h(x_n)exp(eta^T T(x_n)-A(eta)) $
    ],
    card(label: "collected-product", title: [Collect the repeated terms])[
      $ p(cal(D)|eta)
          = (product_(n=1)^N h(x_n))
            exp(eta^T sum_(n=1)^N T(x_n)-N A(eta)) $
    ],
    schema-card(label: "aggregate", title: [Aggregate sufficient statistic])[
      $ T(cal(D))=sum_(n=1)^N T(x_n) $
    ],
    card(label: "log-likelihood", title: [Log likelihood])[
      $ ell(eta)=eta^T T(cal(D))-N A(eta)+C(cal(D)) $
      $ C(cal(D))=sum_(n=1)^N log h(x_n) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      For fixed $N$, all parameter-dependent data information enters through $T(cal(D))$.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("iid-product",),
    then: (
      reveal-step(("collected-product",), emphasize: true, purpose: [Collect repeated statistic and normalization terms.]),
      reveal-step(("aggregate",), purpose: [Name the sample statistic.]),
      reveal-step(("log-likelihood",), emphasize: true, purpose: [Separate the constant data term from parameter-dependent terms.]),
      reveal-step(("takeaway",), purpose: [State the likelihood reduction.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("aggregate", reason: [The data side of the learning rule.]),
  ),
  constraints: [
    The collected product and log likelihood are one continuous derivation.
    $C(cal(D))$ is independent of $eta$. Preserve the factorization; never replace
    it with $p(cal(D)|eta)=p(T(cal(D))|eta)$. Assume observed data lie in the
    common support with positive base-measure weight.
  ],
)

#slide-design(
  title: [Differentiating the likelihood reuses the log-partition moment identity],
  teaching-move: [
    Differentiate the carried-forward log likelihood and substitute Section 3's
    mean identity to obtain the score.
  ],
  layout: layout-stack(items: ("likelihood-recall", "mean-recall", "differentiate", "substitute"), key-points: "takeaway", dominant: "differentiate"),
  cards: (
    recall-card(label: "likelihood-recall", from: [Previous slide: log likelihood])[
      $ ell(eta)=eta^T T(cal(D))-N A(eta)+C(cal(D)) $
    ],
    recall-card(label: "mean-recall", from: [Section 3: mean identity])[
      $ nabla A(eta)=E_eta [T(X)] $
    ],
    card(label: "differentiate", title: [Differentiate with the data fixed])[
      $ nabla_eta ell(eta)=T(cal(D))-N nabla A(eta) $
    ],
    card(label: "substitute", title: [Substitute the model moment])[
      $ nabla_eta ell(eta)=T(cal(D))-N E_eta [T(X)] $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      The derivative of the normalizer supplies the model's expected statistic.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("likelihood-recall", "mean-recall"),
    then: (
      reveal-step(("differentiate",), emphasize: true, purpose: [The data constant drops out; the linear term contributes the aggregate statistic.]),
      reveal-step(("substitute",), emphasize: true, purpose: [Reuse the already-derived moment identity.]),
      reveal-step(("takeaway",), purpose: [Identify the role of normalization in learning.]),
    ),
  ),
  constraints: [
    Keep both recall equations subordinate and visible while the two score
    lines form an aligned progression. No new model-specific derivative is needed.
  ],
)

#slide-design(
  title: [The likelihood gradient compares empirical and model statistics],
  teaching-move: [
    Interpret the score as a discrepancy by displaying empirical and model
    statistics simultaneously.
  ],
  layout: layout-grid(
    columns: 2,
    cells: (
      layout-cell("score", colspan: 2),
      layout-cell("empirical"),
      layout-cell("model"),
      layout-cell("takeaway", colspan: 2),
    ),
    dominant: "score",
  ),
  cards: (
    card(label: "score", title: [The score measures a discrepancy])[
      $ nabla_eta ell(eta)=T(cal(D))-N E_eta [T(X)]=N(overline(T)-m(eta)) $
    ],
    bordered-card(label: "empirical", title: [Empirical mean statistic])[
      $ overline(T)=1/N sum_(n=1)^N T(x_n) $
      Computed from the observed sample.
    ],
    bordered-card(label: "model", title: [Model mean statistic])[
      $ m(eta)=E_eta [T(X)] $
      Expected under the current parameter.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      The score is zero when empirical and model mean statistics agree.
    ],
  ),
  reveal: reveal-static(("score", "empirical", "model", "takeaway")),
  summary-candidates: (
    summary-visual-candidate("score", reason: [The central empirical–model comparison.]),
    summary-key-point-candidate([The score compares empirical and model mean statistics.], from: "takeaway"),
  ),
  constraints: [
    Comparison is simultaneous. Keep the equation dominant and place the two
    meanings beneath it at equal visual rank. The sample statistic stays fixed
    while the model mean depends on $eta$.
  ],
)

#slide-design(
  title: [At the MLE, model moments match empirical moments],
  teaching-move: [
    Set the score to zero at a finite interior optimum and foreground the
    resulting general moment-matching condition.
  ],
  layout: layout-stack(items: ("score-recall", "zero-score", "matched-moments", "concavity-note"), key-points: "takeaway", dominant: "matched-moments"),
  cards: (
    recall-card(label: "score-recall", from: [Previous slide: likelihood gradient])[
      $ nabla ell(eta)=N(overline(T)-m(eta)) $
    ],
    card(label: "zero-score", title: [If a finite interior MLE exists])[
      $ nabla ell(hat(eta))=0 arrow.r m(hat(eta))=overline(T) $
    ],
    card(label: "matched-moments", title: [Moment matching])[
      $ E_(hat(eta)) [T(X)] = 1/N sum_(n=1)^N T(x_n) $
    ],
    card(label: "concavity-note", title: [A brief curvature consequence])[
      $ nabla^2 ell(eta)=-N op("Cov")_eta [T(X)] <= 0 $
      Concavity does not guarantee existence or uniqueness of a finite maximizer.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      A finite interior MLE matches expected sufficient statistics to their empirical averages.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("score-recall",),
    then: (
      reveal-step(("zero-score",), emphasize: true, purpose: [Apply the interior optimum condition.]),
      reveal-step(("matched-moments",), emphasize: true, purpose: [State the reusable learning rule.]),
      reveal-step(("concavity-note", "takeaway"), purpose: [Retain the learning rule with its existence qualification.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("matched-moments", reason: [The central estimation result.]),
    summary-key-point-candidate([A finite interior MLE matches model and empirical mean statistics.], from: "takeaway"),
  ),
  constraints: [
    Moment matching is the dominant result; keep the curvature consequence as
    a subordinate note. The matrix inequality means negative semidefinite.
    Do not turn concavity into another teaching move or an existence theorem.
  ],
)

#slide-design(
  title: [Bernoulli moment matching recovers the sample proportion],
  teaching-move: [
    Apply the general rule to Bernoulli's single statistic and recover the
    familiar probability MLE, including its boundary interpretation.
  ],
  layout: layout-stack(items: ("bernoulli-recall", "proportion", "natural-fit"), key-points: "takeaway", dominant: "proportion"),
  cards: (
    recall-card(label: "bernoulli-recall", from: [Sections 1 and 3: Bernoulli statistic and mean])[
      $ T(x)=x, quad E_eta [T(X)]=mu $
    ],
    card(label: "proportion", title: [Observed successes determine the fitted probability])[
      $ k=sum_(n=1)^N x_n, quad hat(mu)=k/N $
    ],
    card(label: "natural-fit", title: [Natural-coordinate interpretation])[
      $ 0<k<N : quad hat(eta)=log(k/(N-k)) $
      If $k=0$ or $k=N$, the probability MLE is $0$ or $1$; its natural
      coordinate is a limit $eta arrow.r -infinity$ or $eta arrow.r +infinity$.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      Bernoulli moment matching is the familiar count-and-divide estimate.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("bernoulli-recall",),
    then: (
      reveal-step(("proportion",), emphasize: true, purpose: [Match the success probability to the observed fraction.]),
      reveal-step(("natural-fit",), purpose: [Interpret finite and boundary natural coordinates.]),
      reveal-step(("takeaway",), purpose: [Recognize the familiar estimator.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("proportion", reason: [The compact familiar check of the general rule.]),
  ),
  constraints: [
    This is a brief specialization, not a new Bernoulli likelihood derivation.
    Mention boundary cases to interpret the earlier interior qualification.
  ],
)

#slide-design(
  title: [Maximum likelihood in an exponential family is moment matching],
  section: [Section 4 — summary],
  teaching-move: [
    Consolidate aggregate statistics, the score discrepancy, and the qualified
    moment-matching result as one learning chain.
  ],
  layout: layout-summary(visual: "summary-visual", takeaways: "summary-takeaways"),
  cards: (
    section-summary-visual(label: "summary-visual")[
      $ cal(D) arrow.r T(cal(D))=sum_(n=1)^N T(x_n) $
      $ nabla ell(eta)=T(cal(D))-N E_eta [T(X)] $
      At a finite interior MLE:
      $ E_(hat(eta)) [T(X)]=T(cal(D))/N $
      Bernoulli check: $hat(mu)=k/N$.
    ],
    section-summary-takeaways(label: "summary-takeaways")[
      - The sample enters learning through its aggregate sufficient statistic.
      - The score compares observed and model-expected statistics.
      - A finite interior MLE matches model and empirical mean statistics.
    ],
  ),
  reveal: reveal-static(("summary-visual", "summary-takeaways")),
  rationale: [
    Select the aggregate statistic, score, and matched-moment result. Compress
    the Bernoulli nomination to one line; omit the product algebra and
    concavity note so the full learning chain remains dominant.
  ],
  constraints: [
    Final retrospective teaching move, with the explicit course summary label.
    Keep the existence qualification visible; no maximum-entropy teaser or
    notebook handoff belongs here.
  ],
)

#section-design-notes(
  title: [Section 5 — Moment constraints and maximum entropy lead to exponential families],
  purpose: [
    Construct a distribution from expected-feature constraints using minimum
    KL to a reference, with maximum entropy as the uniform-reference case.
  ],
  entry: [
    Students know expectation, entropy, KL, and the common exponential-family
    form. Section 4 estimated parameters in a chosen family; this section
    instead starts from feature constraints and chooses the distribution.
  ],
  endpoint: [
    Students can identify the constraint inputs and see that an interior
    minimum-KL solution has $h=q$, $T=f$, $eta=-lambda$, and $A=log Z$.
  ],
  arc: [
    Known feature expectations → closest constrained distribution to q →
    uniform reference and entropy → multiplier proof sketch → common form.
  ],
  anchors: [
    - Finite support $cal(X)$ with $M$ states; $q(x)>0$.
    - $E_p [f_k (X)]=F_k$, $k=1,dots,K$.
    - $op("KL")(p||q)=sum_(x in cal(X)) p(x)log(p(x)/q(x))$.
    - $T(x)=f(x)$, $h(x)=q(x)$, $eta=-lambda$.
  ],
  summary-brief: [
    Recombine constraints, the KL criterion, and the resulting exponential form.
    Use short takeaways for the roles of features, multipliers, and reference.
    Do not repeat the Lagrangian or add a new Gaussian example.
  ],
  continuity: [
    Open with a new model-construction question after Section 4's estimation
    problem. Entropy/KL are review; this is not an inference from MLE concavity.
    End with the completed construction, without a closing bridge.
  ],
  constraints: [
    Five slides in 8–10 minutes. Finite discrete support keeps the live proof
    to ordinary derivatives; assume feasible constraints admitting an interior
    optimum. Uniform q is proper on this support. Boundary constraints can
    require limits; no functional calculus or convex duality is taught.
    Source: Murphy Book 2 §2.4.7, printed pp.43–44, equations (2.251)–(2.256).
    Follow Murphy's maximization of negative KL, giving $eta=-lambda$.
  ],
)

#slide-design(
  title: [Moment constraints and maximum entropy lead to exponential families],
  section: [Section 5 — title],
  teaching-move: [
    Frame the construction question that begins from known feature expectations.
  ],
  layout: layout-stack(items: ("section-title", "footer-title"), dominant: "section-title"),
  cards: (
    card(label: "section-title", title: [Section title and subtitle])[
      *Moment constraints and maximum entropy lead to exponential families*

      Choose a distribution from expected features and a reference measure.
    ],
    card(label: "footer-title", title: [Abbreviated footer title])[
      Maximum entropy.
    ],
  ),
  reveal: reveal-static(("section-title", "footer-title")),
  constraints: [
    Use the established section-title hierarchy and abbreviated footer metadata.
  ],
)

#slide-design(
  title: [Moment constraints state what we know about an otherwise unknown distribution],
  teaching-move: [
    Define the supplied feature expectations and feasible distributions before
    introducing a selection criterion.
  ],
  layout: layout-stack(items: ("given-information", "feature-constraints", "probability-constraints"), key-points: "takeaway", dominant: "feature-constraints"),
  cards: (
    card(label: "given-information", title: [Inputs to the construction])[
      Choose a distribution $p$ on a fixed finite set $cal(X)$.
      Given: feature functions $f_1,dots,f_K$ and expected values $F_1,dots,F_K$.
    ],
    card(label: "feature-constraints", title: [The information p must preserve])[
      $ E_p [f_k (X)]=sum_(x in cal(X)) p(x)f_k (x)=F_k, quad k=1,dots,K $
      These values are supplied constraints on the distribution.
    ],
    card(label: "probability-constraints", title: [p must also be a distribution])[
      $ p(x)>=0, quad sum_(x in cal(X)) p(x)=1 $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      Feature expectations constrain the unknown distribution but may not determine it.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("given-information",),
    then: (
      reveal-step(("feature-constraints",), emphasize: true, purpose: [State precisely what is assumed known.]),
      reveal-step(("probability-constraints",), purpose: [Specify feasibility as probabilities as well as moments.]),
      reveal-step(("takeaway",), purpose: [Explain why a selection criterion is needed.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("feature-constraints", reason: [The starting information of the construction.]),
  ),
  constraints: [
    $F$ denotes supplied expectations, not automatically the sample statistic
    from Section 4. Explain that multiple p may satisfy the same constraints;
    no numerical example or new dataset is needed.
  ],
)

#slide-design(
  title: [Maximum entropy chooses the least committed distribution satisfying those constraints],
  teaching-move: [
    State minimum KL to a positive reference and show that uniform reference
    reduces it to maximizing entropy under the same constraints.
  ],
  layout: layout-stack(items: ("constraints-recall", "minimum-kl", "uniform-reference"), key-points: "takeaway", dominant: "minimum-kl"),
  cards: (
    recall-card(label: "constraints-recall", from: [Previous slide: supplied feature expectations])[
      $ E_p [f_k (X)]=F_k, quad sum_x p(x)=1, quad p(x)>=0 $
    ],
    card(label: "minimum-kl", title: [The general selection principle])[
      Given a reference distribution $q(x)>0$:
      $ p^star = arg min_(p:"constraints") op("KL")(p||q) $
      $ op("KL")(p||q)=sum_x p(x)log(p(x)/q(x)) $
    ],
    bordered-card(label: "uniform-reference", title: [Uniform reference gives maximum entropy])[
      $ q(x)=1/M, quad M=|cal(X)| $
      $ op("KL")(p||q)=log M-H(p), quad H(p)=-sum_x p(x)log p(x) $
      Minimizing KL then maximizes entropy.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      - Minimum KL chooses the closest feasible distribution to the reference.
      - With a uniform reference, the same criterion is maximum entropy.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("constraints-recall",),
    then: (
      reveal-step(("minimum-kl",), emphasize: true, purpose: [Define the general meaning of least commitment relative to q.]),
      reveal-step(("uniform-reference",), emphasize: true, purpose: [Identify the entropy special case through an additive constant.]),
      reveal-step(("takeaway",), purpose: [Retain the reference-dependent selection principle.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("minimum-kl", reason: [The general criterion behind the exponential form.]),
    summary-key-point-candidate([Uniform reference turns minimum KL into maximum entropy.], from: "takeaway"),
  ),
  constraints: [
    Sum over the fixed finite support. Use the conventional zero-probability
    limit in entropy/KL. A uniform distribution on all of RR is not proper and
    is not part of this discrete proof. q is a reference, not a fitted parameter.
  ],
)

#slide-design(
  title: [Lagrange multipliers turn feature constraints into exponential-family natural parameters],
  teaching-move: [
    Sketch the finite-dimensional multiplier calculation and identify the
    features, reference, natural weights, and log partition in its solution.
  ],
  layout: layout-stack(items: ("lagrangian", "stationarity", "solution", "mapping"), key-points: "takeaway", dominant: "solution"),
  cards: (
    card(label: "lagrangian", title: [Maximize negative KL with the constraints])[
      $ J(p,lambda)
          &= -sum_x p(x)log(p(x)/q(x)) \
          &quad + lambda_0 (1-sum_x p(x)) \
          &quad + sum_(k=1)^K lambda_k (F_k-sum_x p(x)f_k (x)) $
    ],
    card(label: "stationarity", title: [At an interior constrained optimum])[
      $ (partial J)/(partial p(x))
        = -1-log(p(x)/q(x))-lambda_0-sum_k lambda_k f_k (x)=0 $
    ],
    card(label: "solution", title: [Rearrange and normalize])[
      $ p^star (x)=q(x)/Z exp(-sum_k lambda_k f_k (x)) $
      $ Z=sum_x q(x)exp(-sum_k lambda_k f_k (x)) $
    ],
    schema-card(label: "mapping", title: [Match the four roles])[
      $ h(x)=q(x), quad T(x)=f(x), quad eta=-lambda, quad A(eta)=log Z(eta) $
      $ p^star (x)=q(x)exp(eta^T f(x)-A(eta)) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      The constrained solution is an exponential family in the supplied features.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("lagrangian",),
    then: (
      reveal-step(("stationarity",), emphasize: true, purpose: [Differentiate the probability coordinate in the finite vector p.]),
      reveal-step(("solution",), emphasize: true, purpose: [Exponentiate the stationarity equation and impose total probability one.]),
      reveal-step(("mapping",), purpose: [Read off the reference, statistic, natural parameter, and normalizer.]),
      reveal-step(("takeaway",), purpose: [State the construction result.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("mapping", reason: [The completed multiplier-to-family correspondence.]),
    summary-key-point-candidate([Features become sufficient statistics; multiplier negatives become natural parameters.], from: "takeaway"),
  ),
  constraints: [
    Treat p as a finite probability vector. Show the three Lagrangian lines
    together and each subsequent equation group as one state; no functional
    derivatives or click-by-click algebra. The sign convention is $eta=-lambda$
    because the objective is negative KL with constraints written as given minus
    model expectation. Finite multipliers assume an interior solution.
  ],
)

#slide-design(
  title: [Moment constraints plus maximum entropy produce an exponential-family model],
  section: [Section 5 — summary],
  teaching-move: [
    Consolidate the constraint inputs, selection principle, and exponential-form
    result with their four-role correspondence.
  ],
  layout: layout-summary(visual: "summary-visual", takeaways: "summary-takeaways"),
  cards: (
    section-summary-visual(label: "summary-visual")[
      $ E_p [f_k (X)]=F_k, quad p^star=arg min_(p:"constraints") op("KL")(p||q) $
      $ p^star (x)=q(x)exp(eta^T f(x)-A(eta)) $
      $ h=q, quad T=f, quad eta=-lambda, quad A=log Z $
      Uniform q: minimum KL is maximum entropy.
    ],
    section-summary-takeaways(label: "summary-takeaways")[
      - Supplied features and expectations define the constraints.
      - Minimum KL chooses a feasible distribution relative to q.
      - The multiplier solution has exponential-family form.
    ],
  ),
  reveal: reveal-static(("summary-visual", "summary-takeaways")),
  rationale: [
    Select the feature constraints, KL criterion, and completed mapping. The
    summary omits the Lagrangian while retaining the reference and multiplier
    signs that make the final form meaningful.
  ],
  constraints: [
    Final retrospective teaching move with the explicit summary label. The
    finite-support and interior assumptions remain those stated in the section;
    introduce no empirical example or later-application bridge.
  ],
)

#section-design-notes(
  title: [Section 6 — Maximum likelihood fits a Gamma model to rainfall data],
  purpose: [Apply the general MLE rule to a real positive-data, two-parameter model.],
  entry: [Return to Section 4's moment matching after the model-construction view of Section 5.],
  endpoint: [Identify Gamma statistics $(log x,x)$, sample aggregates, and their role in a fitted rainfall model.],
  arc: [Rainfall distribution → Gamma statistics → aggregate moments → fitted-density comparison.],
  anchors: [
    - Shape $alpha>0$, rate $beta>0$, rainfall $x>0$ in inches.
    - $T(x)=(log x,x)$, $eta=(alpha-1,-beta)$.
    - $E[log X]=psi(alpha)-log beta$; $E[X]=alpha/beta$.
  ],
  summary-brief: [Return to the rainfall histogram with fitted Gamma overlay and a compact two-statistic reminder.],
  continuity: [Reconnect to the estimation rule at entry. Keep the empirical fit and retrospective summary as the endpoint.],
  constraints: [
    Five slides in 7–9 minutes; currently live. Recording or removal remains a
    later instructor option, not a current delivery change. No Gamma-property
    survey or optimizer derivation. Figure assets are delegated below.
    Sources: MIT 18.443 R Project 2, Le Cam–Neyman southern Illinois summer-storm
    rainfall, 1960–1964; MIT Lecture 4, pp.9–11, for shape/rate MLE.
    Raw files are available from the Western University course mirror; local
    import, independent refit, positivity checks, and plot validation remain
    outstanding. Do not infer or invent numeric sample aggregates.
  ],
)

#slide-design(
  title: [Maximum likelihood fits a Gamma model to rainfall data],
  section: [Section 6 — title],
  teaching-move: [Frame a real-data test of the general MLE rule with a two-parameter positive-data model.],
  layout: layout-stack(items: ("section-title", "footer-title"), dominant: "section-title"),
  cards: (
    card(label: "section-title", title: [Section title and subtitle])[
      *Maximum likelihood fits a Gamma model to rainfall data*

      Two sufficient statistics connect a positive-data fit to the general learning rule.
    ],
    card(label: "footer-title", title: [Abbreviated footer title])[Gamma rainfall fit.],
  ),
  reveal: reveal-static(("section-title", "footer-title")),
  constraints: [Use the established section-title hierarchy and abbreviated footer metadata.],
)

#slide-design(
  title: [Rainfall amounts are positive and strongly right-skewed],
  teaching-move: [Establish the empirical shape and support of the rainfall sample through its distribution plot.],
  layout: layout-stack(items: ("rainfall-data",), key-points: "takeaway", dominant: "rainfall-data"),
  cards: (
    design-card(label: "rainfall-data", title: [Figure asset brief — rainfall histogram])[
      *Visible figure:* density-scaled histogram of the five years of southern
      Illinois storm averages. Horizontal axis: “Rainfall per storm (inches)”;
      vertical axis: “Density”. Preserve the long positive tail; no synthetic points.

      *Caption:* Le Cam–Neyman summer-storm rainfall, southern Illinois, 1960–1964.
      *Visible source note:* Le Cam–Neyman data in Rice, 3rd edition; MIT 18.443
      R Project 2. Raw-file access: Western University course mirror.

      *Provenance / authoring:* concatenate `illinois60.txt` through
      `illinois64.txt` from
      #link("https://fisher.stats.uwo.ca/faculty/kulperger/SS3858/handouts-2017.htm")[Western University course handouts],
      `Data/` links. Verify units, sample size, parsing, and strictly positive
      observations against the MIT project before plotting. Record any discrepancy.
      Reuse the same binning and axes in the section summary.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[Positive support and right skew motivate the Gamma model.],
  ),
  reveal: reveal-cumulative(initial: ("rainfall-data",), then: (
    reveal-step(("takeaway",), purpose: [Connect observed shape and support to the model choice.]),
  )),
  summary-candidates: (summary-visual-candidate("rainfall-data", reason: [The observed distribution anchors the final fit comparison.]),),
  constraints: [The figure dominates; prose and source caption are subordinate. No method-of-moments or numerical fitting discussion.],
)

#slide-design(
  title: [A Gamma model summarizes the rainfall through `x` and `log x`],
  teaching-move: [Rewrite the shape/rate density only far enough to identify its two data statistics and natural coefficients.],
  layout: layout-stack(items: ("gamma-density", "gamma-mapping"), key-points: "takeaway", dominant: "gamma-mapping"),
  cards: (
    card(label: "gamma-density", title: [Gamma shape/rate model])[
      $ p(x|alpha,beta)=beta^alpha/Gamma(alpha) x^(alpha-1)exp(-beta x), quad x>0 $
      $ log p(x|alpha,beta)=(alpha-1)log x-beta x+alpha log beta-log Gamma(alpha) $
    ],
    schema-card(label: "gamma-mapping", title: [Match the common form])[
      $ T(x)=mat(log x; x), quad eta=mat(alpha-1; -beta) $
      $ h(x)=1 " on " x>0, quad A(eta)=log Gamma(alpha)-alpha log beta $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[The Gamma data statistics are log rainfall and rainfall itself.],
  ),
  reveal: reveal-cumulative(initial: ("gamma-density",), then: (
    reveal-step(("gamma-mapping",), emphasize: true, purpose: [Identify the data statistics and their coefficients.]),
    reveal-step(("takeaway",), purpose: [Retain the nontrivial log statistic.]),
  )),
  summary-candidates: (summary-visual-candidate("gamma-mapping", reason: [The two-statistic compression underlying the fit.]),),
  constraints: [Use rate beta throughout; never substitute a scale parameter without inversion. The fixed support is positive rainfall.],
)

#slide-design(
  title: [The Gamma MLE depends on `Σx` and `Σlog x`],
  teaching-move: [Apply the existing learning rule to the two Gamma statistics and acknowledge the resulting digamma equation.],
  layout: layout-stack(items: ("sample-statistics", "moment-equations", "fitted-comparison"), key-points: "takeaway", dominant: "fitted-comparison"),
  cards: (
    card(label: "sample-statistics", title: [Two aggregates determine the sample likelihood])[
      $ S_1=sum_(n=1)^N log x_n, quad S_2=sum_(n=1)^N x_n $
      $ ell(alpha,beta)=(alpha-1)S_1-beta S_2-N(log Gamma(alpha)-alpha log beta) $
    ],
    card(label: "moment-equations", title: [Apply moment matching])[
      $ psi(hat(alpha))-log hat(beta)=S_1/N, quad hat(alpha)/hat(beta)=S_2/N $
      $ psi(alpha)=(dif log Gamma(alpha))/(dif alpha) $
    ],
    design-card(label: "fitted-comparison", title: [Figure asset brief — establish the fitted comparison])[
      Reuse the rainfall histogram with a fitted Gamma density overlaid, using
      the same axes and binning. Caption: “Gamma MLE fitted to southern Illinois
      rainfall”. Label MIT-reported $hat(alpha) approx 0.4408$ (dimensionless) and
      $hat(beta) approx 1.9648 "in"^(-1)$, pending independent refit.
      Visible source note: Le Cam–Neyman/Rice data, MIT 18.443 R Project 2;
      raw files accessed through the Western University mirror.
      Import the Western University raw files, independently refit, compare the
      reported values, and validate the plotted curve before production.
      With shape below one, evaluate the curve only at $x>0$.

      Retained compact anchor: $cal(D) arrow.r (S_1,S_2) arrow.r (hat(alpha),hat(beta))$.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[Two sample summaries feed the same moment-matching rule; the shape equation is solved numerically.],
  ),
  reveal: design-reveal[
    State 1: show `sample-statistics`. State 2: retain it and add `moment-equations`
    with transient entry emphasis. State 3: replace the detailed likelihood and
    moment equations with `fitted-comparison`, retaining only the displayed
    $(S_1,S_2)$ compression anchor and adding `takeaway`. The histogram and fitted
    curve remain simultaneous in the final state and handout. This replacement
    gives the empirical result room without shrinking the earlier mathematics.
    Authoring owns the exact replacement mechanics.
  ],
  summary-candidates: (
    summary-visual-candidate("sample-statistics", reason: [The empirical sufficient-statistic reduction.]),
    summary-visual-candidate("fitted-comparison", reason: [The fitted result is established before the summary.]),
  ),
  constraints: [State digamma notation and numerical solution; do not derive its properties or methods. No unverified numeric aggregates appear. The final applied result establishes the fit comparison before retrospective reuse.],
)

#slide-design(
  title: [A low-dimensional sufficient statistic determines a useful rainfall fit],
  section: [Section 6 — summary],
  teaching-move: [Return to the observed distribution with its Gamma fit and consolidate the data-to-statistics-to-fit chain.],
  layout: layout-summary(visual: "summary-visual", takeaways: "summary-takeaways"),
  cards: (
    design-card(label: "summary-visual", title: [Summary figure asset brief — histogram and Gamma fit])[
      Reuse the exact `fitted-comparison` histogram, overlay, caption, fitted
      values, and compression anchor established on the preceding slide.
      No new fitted result, dataset, or empirical conclusion is introduced here.
    ],
    section-summary-takeaways(label: "summary-takeaways")[
      - Gamma uses $log x$ and $x$ as its sufficient statistics.
      - Their sample sums determine the likelihood and its fitted parameters.
      - The fitted density is compared against the observed rainfall distribution.
    ],
  ),
  reveal: reveal-static(("summary-visual", "summary-takeaways")),
  rationale: [Select the fitted comparison and two-statistic compression already established on Slide 4. The summary retells that completed estimation chain.],
  constraints: [Retrospective closure. The fit comparison is provisional until the delegated data/figure checks pass.],
  backpressure: [
    Downstream-owned asset requirement: import and validate the recovered raw
    files, fit the Gamma model, and build both figures. Current design is complete
    as an asset specification; no fabricated histogram or refit is supplied.
    Source fit: #link("https://live.ocw.mit.edu/ans7870/18/18.443/s15/projects/Rproject2_script2_gamma_MOMwithMLE.html")[MIT R Project 2].
    Source math: #link("https://ocw.mit.edu/courses/18-443-statistics-for-applications-spring-2015/2a08e2ffa8c87f3187d3969cc24c168b_MIT18_443S15_LEC4.pdf")[MIT Lecture 4, pp.9–11].
  ],
)

#section-design-notes(
  title: [Section 7 — Categorical distributions extend the same learning rule to multiple outcomes],
  purpose: [Extend the Bernoulli learning rule to one distribution over K mutually exclusive outcomes.],
  entry: [Use Bernoulli indicators, the common form, and Section 4's moment-matching rule.],
  endpoint: [Read categorical indicators, softmax logits, sample counts, and normalized-count MLE probabilities.],
  arc: [One-hot data → indicator statistics → logit-to-probability map → count and normalize → summary.],
  anchors: [
    - $x in {1,dots,K}$; $T_k (x)=op("I")(x=k)$ for all K categories.
    - $p_k=P(X=k)=E[T_k (X)]$; $sum_k p_k=1$.
    - Full logits: $A(eta)=log sum_k e^(eta_k)$; $p_k=e^(eta_k-A(eta))$.
    - $N_k=sum_(n=1)^N T_k (x_n)$; $hat(p)_k=N_k/N$.
  ],
  summary-brief: [Pair indicator means and softmax with counts and normalized MLE probabilities.],
  continuity: [Reconnect to Bernoulli at entry. End with one categorical distribution learned from counts, without introducing dependence.],
  constraints: [
    Six slides in 10–12 minutes. Use full K indicators and logits throughout;
    this is a redundant representation. Explain that adding a common constant
    changes no probability. Fixing $eta_K=0$ is a reference convention, not a
    switch to a differently sized statistic vector. Zero counts give boundary
    fitted probabilities and no finite full-logit representation.
    Source: Murphy Book 2 §2.4.2.2, printed p.36, equations (2.174)–(2.186).
    The full-logit form restates (2.174); reference fixing connects to (2.183)–(2.186).
  ],
)

#slide-design(
  title: [Categorical distributions extend the same learning rule to multiple outcomes],
  section: [Section 7 — title],
  teaching-move: [Frame the K-outcome extension of Bernoulli and reuse of the general learning rule.],
  layout: layout-stack(items: ("section-title", "footer-title"), dominant: "section-title"),
  cards: (
    card(label: "section-title", title: [Section title and subtitle])[
      *Categorical distributions extend the same learning rule to multiple outcomes*

      One-hot indicators turn observations into normalized counts.
    ],
    card(label: "footer-title", title: [Abbreviated footer title])[Categorical learning.],
  ),
  reveal: reveal-static(("section-title", "footer-title")),
  constraints: [Use the established section-title hierarchy and abbreviated footer metadata.],
)

#slide-design(
  title: [Categorical data replace one binary indicator with a one-hot vector],
  teaching-move: [Make mutually exclusive category membership visible as one active coordinate.],
  layout: layout-stack(items: ("support", "one-hot-example"), key-points: "takeaway", dominant: "one-hot-example"),
  cards: (
    card(label: "support", title: [One outcome among K categories])[
      $ x in {1,dots,K}, quad T_k (x)=op("I")(x=k) $
    ],
    schema-card(label: "one-hot-example", title: [Course-constructed three-category illustration])[
      $ x=1 arrow.r mat(1;0;0), quad x=2 arrow.r mat(0;1;0), quad x=3 arrow.r mat(0;0;1) $
      $ sum_(k=1)^K T_k (x)=1 $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[Each observation activates exactly one category indicator.],
  ),
  reveal: reveal-cumulative(initial: ("support",), then: (
    reveal-step(("one-hot-example",), purpose: [Compare the three possible encoded observations simultaneously.]),
    reveal-step(("takeaway",), purpose: [State the mutual-exclusion structure.]),
  )),
  summary-candidates: (summary-visual-candidate("one-hot-example", reason: [Concrete meaning of the indicator statistic.]),),
  constraints: [The illustration is constructed for the course, not a Murphy example. Keep all three vectors simultaneous; no distribution fitting yet.],
)

#slide-design(
  title: [Category indicators are the sufficient statistics],
  teaching-move: [Show the categorical density in indicator form and identify indicator expectations as probabilities.],
  layout: layout-stack(items: ("categorical-density", "indicator-means"), key-points: "takeaway", dominant: "indicator-means"),
  cards: (
    card(label: "categorical-density", title: [The selected category determines the probability])[
      $ p(x|bold(p))=product_(k=1)^K p_k^(T_k (x)), quad h(x)=1 " on " {1,dots,K} $
      $ T(x)=mat(T_1 (x); dots; T_K (x)) $
    ],
    card(label: "indicator-means", title: [The model moments are category probabilities])[
      $ E[T_k (X)]=P(X=k)=p_k, quad k=1,dots,K $
      $ E[T(X)]=bold(p) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[The categorical mean statistic is the vector of category probabilities.],
  ),
  reveal: reveal-cumulative(initial: ("categorical-density",), then: (
    reveal-step(("indicator-means",), emphasize: true, purpose: [Connect each indicator expectation to its category probability.]),
    reveal-step(("takeaway",), purpose: [Read the entire mean vector.]),
  )),
  summary-candidates: (summary-visual-candidate("indicator-means", reason: [Connects statistics directly to the eventual estimator.]),),
  constraints: [Keep the full K-vector convention. All probabilities are positive for the finite-logit mapping developed next.],
)

#slide-design(
  title: [Natural parameters become category probabilities through softmax],
  teaching-move: [Normalize category log weights and explain their common-shift redundancy.],
  layout: layout-stack(items: ("logit-form", "softmax", "reference-convention"), key-points: "takeaway", dominant: "softmax"),
  cards: (
    card(label: "logit-form", title: [Full-logit exponential-family form])[
      $ p(x|eta)=exp(sum_(k=1)^K eta_k T_k (x)-A(eta)) $
      $ A(eta)=log sum_(j=1)^K e^(eta_j) $
    ],
    schema-card(label: "softmax", title: [Normalized log weights])[
      $ p_k=e^(eta_k)/(sum_(j=1)^K e^(eta_j)), quad bold(p)=op("softmax")(eta) $
      $ op("softmax")(eta+c bold(1))=op("softmax")(eta) $
    ],
    card(label: "reference-convention", title: [One reference fixes the shared shift])[
      $ eta_K=0 arrow.r eta_k=log(p_k/p_K), quad k<K $
      $ A(eta)=log(1+sum_(j=1)^(K-1) e^(eta_j)) $
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[Softmax turns natural log weights into probabilities; a common shift changes none of them.],
  ),
  reveal: reveal-cumulative(initial: ("logit-form",), then: (
    reveal-step(("softmax",), emphasize: true, purpose: [Show the probability map and its shared-shift invariance.]),
    reveal-step(("reference-convention",), purpose: [Explain how a reference category selects one representative.]),
    reveal-step(("takeaway",), purpose: [Retain the map and redundancy.]),
  )),
  summary-candidates: (summary-visual-candidate("softmax", reason: [The categorical natural-to-mean map.]),),
  constraints: [Keep full T and eta vectors, with etaK fixed only in the reference convention. Do not silently use a K−1 statistic vector with a K-term log partition.],
)

#slide-design(
  title: [Category counts are sufficient statistics, and normalization gives their MLE],
  teaching-move: [Aggregate indicators into category counts and apply moment matching in the same teaching move.],
  layout: layout-stack(items: ("category-counts", "matched-probabilities", "boundary-note"), key-points: "takeaway", dominant: "matched-probabilities"),
  cards: (
    card(label: "category-counts", title: [Aggregate the indicators])[
      $ N_k=sum_(n=1)^N op("I")(x_n=k), quad T(cal(D))=mat(N_1; dots; N_K) $
      $ sum_(k=1)^K N_k=N>0 $
    ],
    card(label: "matched-probabilities", title: [Match expected indicators to observed fractions])[
      $ E_(hat(p)) [T_k (X)]=hat(p)_k=N_k/N $
    ],
    card(label: "boundary-note", title: [Zero counts are boundary fits])[
      If $N_k=0$, then $hat(p)_k=0$; finite logits cannot represent that boundary.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[Categorical MLE is count and normalize, reusing the general moment-matching rule.],
  ),
  reveal: reveal-cumulative(initial: ("category-counts",), then: (
    reveal-step(("matched-probabilities",), emphasize: true, purpose: [Apply the indicator-mean identity to the sample counts.]),
    reveal-step(("boundary-note", "takeaway"), purpose: [Retain the estimator, including zero counts.]),
  )),
  summary-candidates: (summary-visual-candidate("matched-probabilities", reason: [The categorical learning result.]),),
  constraints: [No fresh Lagrange derivation or smoothing. Distinguish probability MLE from existence of a finite natural-coordinate MLE.],
)

#slide-design(
  title: [For categorical models, learning means count and normalize],
  section: [Section 7 — summary],
  teaching-move: [Consolidate categorical statistics, probabilities, natural coordinates, and normalized-count learning.],
  layout: layout-summary(visual: "summary-visual", takeaways: "summary-takeaways"),
  cards: (
    section-summary-visual(label: "summary-visual")[
      $ T_k (x)=op("I")(x=k), quad E[T_k (X)]=p_k $
      $ p_k=e^(eta_k)/(sum_j e^(eta_j)) $
      $ N_k=sum_(n=1)^N T_k (x_n) arrow.r hat(p)_k=N_k/N $
    ],
    section-summary-takeaways(label: "summary-takeaways")[
      - One-hot indicators encode mutually exclusive outcomes.
      - Softmax maps log weights to category probabilities.
      - Normalized category counts give the probability MLE.
    ],
  ),
  reveal: reveal-static(("summary-visual", "summary-takeaways")),
  rationale: [Select indicator means, softmax, and the normalized-count estimator. Omit the three-category illustration and reference-fixing details from the compact summary.],
  constraints: [Final retrospective teaching move, explicitly labeled as a summary. No conditional sequence model or receiving-section teaser.],
)

#section-design-notes(
  title: [Section 8 — A Markov model learns one categorical distribution for each preceding state],
  purpose: [Learn a first-order sequence model by reusing categorical estimation for each conditioning state.],
  entry: [Section 7 established one categorical distribution learned from counts. Here the preceding state selects which categorical row applies.],
  endpoint: [Read the factorization, transition rows, transition counts, row MLE, sequence scoring, and repeated conditional sampling.],
  arc: [Order matters → previous-state context → categorical rows → transition counts → normalized-row MLE → text counts and fitted rows → scoring and sampling → retrospective summary.],
  anchors: [
    - $A_(j k)=P(X_t=k|X_(t-1)=j)$; row j is preceding, column k is next.
    - $pi_j=P(X_1=j)$; $p(x_(1:T))=pi_(x_1)product_(t=2)^T A_(x_(t-1),x_t)$.
    - $N_(j k)=sum_(t=2)^T op("I")(x_(t-1)=j,x_t=k)$; $N_j=sum_k N_(j k)$.
    - $hat(A)_(j k)=N_(j k)/N_j$ when $N_j>0$.
  ],
  summary-brief: [Select the count-to-row-normalization chain, then recall scoring and sampling as two uses of the same learned rows. No notebook task belongs inside the summary.],
  continuity: [Open with the limitation of independent categorical observations for ordered data. End with what the fitted first-order model does; the notebook handoff remains a separate lecture-level activity.],
  constraints: [
    Eleven slides in 20–24 minutes. Finite state space and time-homogeneous
    transitions. Transition counts suffice for A; initial-distribution estimation
    needs separate start-state counts. Unobserved predecessor rows are not
    identified; zero transition factors give zero unsmoothed sequence probability.
    No stationary distributions, matrix powers, or live smoothing extension.
    Sources: Murphy Book 2 §§2.6.1–2.6.3, printed pp.47–50, equations (2.265),
    (2.274)–(2.278), Fig.2.15(a), and Fig.2.17.

    Approved sampling source: course-generated first-order Time Machine output
    from the validated matrix.
  ],
)

#slide-design(
  title: [A Markov model learns one categorical distribution for each preceding state],
  section: [Section 8 — title],
  teaching-move: [Frame a sequence model as a collection of conditional categorical rows.],
  layout: layout-stack(items: ("section-title", "footer-title"), dominant: "section-title"),
  cards: (
    card(label: "section-title", title: [Section title and subtitle])[
      *A Markov model learns one categorical distribution for each preceding state*

      Transition counts fit conditional categorical models for sequence data.
    ],
    card(label: "footer-title", title: [Abbreviated footer title])[Markov learning.],
  ),
  reveal: reveal-static(("section-title", "footer-title")),
  constraints: [Use the established section-title hierarchy and abbreviated footer metadata.],
)

#slide-design(
  title: [Sequence models need conditional probabilities, not independent draws],
  teaching-move: [Show that identical category counts can conceal different order and transition structure.],
  layout: layout-side(left: "same-counts", right: "different-order", key-points: "takeaway", dominant: "different-order"),
  cards: (
    schema-card(label: "same-counts", title: [Same categorical totals])[
      Course-constructed sequences: `ab` and `ba`.
      Both contain one a and one b.
      $ p_("IID")("ab")=p_a p_b=p_("IID")("ba") $
    ],
    schema-card(label: "different-order", title: [Different conditional transitions])[
      `ab` contains $a arrow.r b$; `ba` contains $b arrow.r a$.
      $ p("ab")=pi_a A_(a b), quad p("ba")=pi_b A_(b a) $
      Ordered models can distinguish the two sequences.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[Category totals describe frequencies; conditional transitions describe order.],
  ),
  reveal: reveal-cumulative(initial: ("same-counts",), then: (
    reveal-step(("different-order",), purpose: [Compare the two order-sensitive transition factors.]),
    reveal-step(("takeaway",), purpose: [State what a sequence model must retain.]),
  )),
  constraints: [The toy comparison is course-constructed. Explain pi as an initial probability and A as a conditional transition; their general definitions follow immediately. No empirical text probabilities are invented.],
)

#slide-design(
  title: [A first-order Markov model keeps only the previous state as context],
  teaching-move: [State the first-order conditional assumption and factorization, supported by a state-transition schema.],
  layout: layout-stack(items: ("markov-assumption", "factorization", "state-diagram"), key-points: "takeaway", dominant: "factorization"),
  cards: (
    card(label: "markov-assumption", title: [First-order context])[
      $ p(x_t|x_(1:t-1))=p(x_t|x_(t-1)) $
    ],
    card(label: "factorization", title: [Joint sequence probability])[
      $ p(x_(1:T))=p(x_1)product_(t=2)^T p(x_t|x_(t-1)) $
      $ pi_j=P(X_1=j) $
    ],
    design-card(label: "state-diagram", title: [Schema asset brief — two-state chain])[
      Adapt Murphy Fig.2.15(a): states 1 and 2; arrows 1→2 labeled A12,
      2→1 labeled A21, and self-loops labeled A11 and A22. These correspond to
      Murphy's alpha, beta, 1−alpha, 1−beta respectively. All four legal
      transitions remain visible. Caption: “A state chooses the next-state distribution”.
      Draw as a restrained native course schema; no numeric weights are assigned.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[The model uses only the preceding state to predict the next state.],
  ),
  reveal: reveal-cumulative(initial: ("markov-assumption",), then: (
    reveal-step(("factorization",), emphasize: true, purpose: [Apply the conditional assumption to the chain rule.]),
    reveal-step(("state-diagram",), purpose: [Make the transition structure concrete.]),
    reveal-step(("takeaway",), purpose: [Retain the first-order assumption.]),
  )),
  summary-candidates: (summary-visual-candidate("factorization", reason: [The model's probability structure.]),),
  constraints: [Distinguish a state-transition diagram from a time-indexed dependency graph. T denotes sequence length here. No graphical conditional-independence claims beyond the stated Markov assumption.],
)

#slide-design(
  title: [Each transition-matrix row is one categorical distribution],
  teaching-move: [Interpret rows as next-state categorical probabilities for a fixed preceding state.],
  layout: layout-stack(items: ("transition-definition", "row-distribution"), key-points: "takeaway", dominant: "row-distribution"),
  cards: (
    card(label: "transition-definition", title: [A time-homogeneous K-state model])[
      $ A_(j k)=P(X_t=k|X_(t-1)=j), quad A in RR^(K times K) $
    ],
    schema-card(label: "row-distribution", title: [Hold the preceding state j fixed])[
      $ A_(j dot)=(A_(j 1),dots,A_(j K)), quad A_(j k)>=0, quad sum_(k=1)^K A_(j k)=1 $
      $ X_t | (X_(t-1)=j) tilde op("Cat")(A_(j dot)) $
      Rows: preceding state. Columns: next state.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[A Markov chain has one categorical next-state distribution for each preceding state.],
  ),
  reveal: reveal-cumulative(initial: ("transition-definition",), then: (
    reveal-step(("row-distribution",), emphasize: true, purpose: [Read a fixed row as the familiar categorical model.]),
    reveal-step(("takeaway",), purpose: [State the reuse of Section 7.]),
  )),
  summary-candidates: (summary-visual-candidate("row-distribution", reason: [The conditional categorical interpretation.]),),
  constraints: [A is now the transition matrix, not the earlier log-partition function A(eta). Tie the same row across time; do not introduce stationarity or a stationary distribution.],
)

#slide-design(
  title: [Transition counts are the sufficient statistics for a Markov chain],
  teaching-move: [Count observed transitions and group the transition likelihood into row-wise categorical factors.],
  layout: layout-stack(items: ("transition-counts", "grouped-likelihood", "initial-note"), key-points: "takeaway", dominant: "grouped-likelihood"),
  cards: (
    card(label: "transition-counts", title: [Count j→k transitions in one observed sequence])[
      $ N_(j k)=sum_(t=2)^T op("I")(x_(t-1)=j,x_t=k), quad N_j=sum_k N_(j k) $
    ],
    card(label: "grouped-likelihood", title: [Collect identical conditional factors])[
      $ p(x_(2:T)|x_1,A)=product_(t=2)^T A_(x_(t-1),x_t)=product_(j,k) A_(j k)^(N_(j k)) $
      $ ell(A)=sum_(j,k) N_(j k) log A_(j k) $
    ],
    card(label: "initial-note", title: [Initial probabilities are a separate part])[
      Transition counts suffice for A. Estimating pi across separate sequences
      uses their initial-state counts, not these transition counts.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[The transition likelihood depends on the sequence through the j→k counts.],
  ),
  reveal: reveal-cumulative(initial: ("transition-counts",), then: (
    reveal-step(("grouped-likelihood",), emphasize: true, purpose: [Group repeated factors by preceding and next state.]),
    reveal-step(("initial-note", "takeaway"), purpose: [State exactly which model parameters the counts inform.]),
  )),
  summary-candidates: (summary-visual-candidate("transition-counts", reason: [The observed statistics used to learn A.]),),
  constraints: [Conditional likelihood holds the initial state fixed. For a collection of independent sequences, sum these counts within each sequence; never count a transition across a sequence boundary.],
)

#slide-design(
  title: [Normalizing each row gives the maximum-likelihood transition matrix],
  teaching-move: [Apply categorical count normalization independently to each observed predecessor row.],
  layout: layout-stack(items: ("categorical-recall", "row-mle", "unobserved-row"), key-points: "takeaway", dominant: "row-mle"),
  cards: (
    recall-card(label: "categorical-recall", from: [Section 7: categorical MLE])[
      $ hat(p)_k=N_k/N $
    ],
    card(label: "row-mle", title: [One row, one count-and-normalize fit])[
      $ hat(A)_(j k)=N_(j k)/N_j, quad N_j>0 $
      $ sum_k hat(A)_(j k)=1 $
    ],
    card(label: "unobserved-row", title: [What the data do not determine])[
      If $N_j=0$, row j is unidentified. If $N_j>0$ but $N_(j k)=0$, the
      unsmoothed MLE gives $hat(A)_(j k)=0$.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[Normalize observed transition counts within each preceding-state row.],
  ),
  reveal: reveal-cumulative(initial: ("categorical-recall",), then: (
    reveal-step(("row-mle",), emphasize: true, purpose: [Reuse count normalization for the conditional distribution.]),
    reveal-step(("unobserved-row", "takeaway"), purpose: [Retain the learning rule and its data-coverage condition.]),
  )),
  summary-candidates: (summary-visual-candidate("row-mle", reason: [The transition learning rule.]),),
  constraints: [No fresh Lagrange derivation or silent smoothing. Keep Nj>0 adjacent to the estimator.],
)

#slide-design(
  title: [Character bigrams turn text into a transition-count matrix],
  teaching-move: [Make the corpus-to-counts operation concrete through the empirical bigram matrix.],
  layout: layout-stack(items: ("text-to-counts", "bigram-counts"), key-points: "takeaway", dominant: "bigram-counts"),
  cards: (
    schema-card(label: "text-to-counts", title: [Count adjacent characters])[
      $ (x_(t-1),x_t)=(j,k) arrow.r N_(j k) " increases by 1" $
    ],
    design-card(label: "bigram-counts", title: [Figure asset brief — Time Machine raw counts])[
      Dominant empirical count matrix corresponding to Murphy Fig.2.17(a),
      trained on H. G. Wells's The Time Machine. Character order follows
      decreasing unigram frequency, with space explicitly labeled “space”.
      Axes: “Preceding character (row)” and “Next character (column)”.
      Highlight the verified source example e→space, the most frequent bigram.
      Use a clearly labeled count scale and verify any numeric annotations.
      Visible source note: Murphy Book 2 Fig.2.17(a), The Time Machine bigrams;
      course reconstruction if regenerated.

      Authoring: obtain the source corpus and inspect the cited
      `bigram_hinton_diagram.ipynb` preprocessing/count construction. Record
      corpus version, preprocessing, alphabet, and boundary handling. Regenerate
      rather than infer numerical counts from plotted square areas. Use the
      same verified counts, order, and labels on the normalized-matrix slide.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[Each matrix cell counts how often its next character followed its preceding character.],
  ),
  reveal: reveal-cumulative(initial: ("text-to-counts",), then: (
    reveal-step(("bigram-counts",), purpose: [Inspect the real corpus counts and a verified character transition.]),
    reveal-step(("takeaway",), purpose: [State what a cell represents.]),
  )),
  summary-candidates: (summary-visual-candidate("bigram-counts", reason: [The empirical learning input.]),),
  constraints: [No unverified cell values or replacement toy matrix is presented as Murphy's empirical data. The figure is a delegated asset.],
)

#slide-design(
  title: [Row normalization turns bigram counts into next-character distributions],
  teaching-move: [Show the fitted conditional probabilities produced by normalizing the same empirical count matrix.],
  layout: layout-stack(items: ("row-rule", "bigram-probabilities"), key-points: "takeaway", dominant: "bigram-probabilities"),
  cards: (
    recall-card(label: "row-rule", from: [Earlier in this section: row MLE])[
      $ hat(A)_(j k)=N_(j k)/(sum_l N_(j l)), quad N_j>0 $
    ],
    design-card(label: "bigram-probabilities", title: [Figure asset brief — validated normalized bigrams])[
      Use the same counts, alphabet order, and axes as `bigram-counts`; display
      conditional probabilities with an explicit probability scale. Highlight
      one preceding-character row and mark its row sum as 1 after validation.
      Caption: “Next-character distributions from row-normalized bigram counts”.
      Source note: “Course reconstruction of Murphy Fig.2.17(b) from the
      verified The Time Machine counts”.

      Normalize using `row_sums = counts.sum(axis=1, keepdims=True)` and divide
      each observed row by its own total. Verify nonnegativity and unit sums
      for every observed row; mark unobserved rows as unidentified. The source
      notebook's broadcasting expression is not a valid implementation to copy.
      Do not assume its normalized plot passed these checks.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[A row is a fitted distribution over the next character, conditional on its predecessor.],
  ),
  reveal: reveal-cumulative(initial: ("row-rule",), then: (
    reveal-step(("bigram-probabilities",), purpose: [Inspect the empirical counterpart of categorical row fitting.]),
    reveal-step(("takeaway",), purpose: [Read one row as the learned conditional model.]),
  )),
  summary-candidates: (summary-visual-candidate("bigram-probabilities", reason: [The empirical fitted transition model.]),),
  constraints: [Keep the preceding/next orientation explicit. Correct row normalization is an authoring-owned data-validation requirement, not a change to the approved teaching move.],
)

#slide-design(
  title: [The fitted Markov model assigns probabilities to new sequences],
  teaching-move: [Reuse the learned transition factors to score a new sequence.],
  layout: layout-stack(items: ("sequence-score", "score-example", "zero-factor"), key-points: "takeaway", dominant: "sequence-score"),
  cards: (
    card(label: "sequence-score", title: [Multiply the selected transition probabilities])[
      $ p(x_(1:T)|pi,hat(A))=pi_(x_1)product_(t=2)^T hat(A)_(x_(t-1),x_t) $
      $ log p(x_(1:T)|pi,hat(A))=log pi_(x_1)+sum_(t=2)^T log hat(A)_(x_(t-1),x_t) $
    ],
    schema-card(label: "score-example", title: [Course-constructed symbolic score])[
      $ p("aba"|pi,hat(A))=pi_a hat(A)_(a b) hat(A)_(b a) $
    ],
    card(label: "zero-factor", title: [Unseen transitions under an unsmoothed fit])[
      A zero initial or transition factor makes the sequence probability zero.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[The same fitted rows assign a probability to any sequence whose required rows are defined.],
  ),
  reveal: reveal-cumulative(initial: ("sequence-score",), then: (
    reveal-step(("score-example",), emphasize: true, purpose: [Read the factors for a short symbolic sequence.]),
    reveal-step(("zero-factor", "takeaway"), purpose: [State what scoring means, including unsmoothed zero factors.]),
  )),
  summary-candidates: (summary-visual-candidate("sequence-score", reason: [Scoring is one use of the fitted model.]),),
  constraints: [pi is a separately declared initial distribution; transition counts do not silently fit it. Numeric scores require validated pi and all required rows. Do not add smoothing or likelihood-comparison exercises.],
)

#slide-design(
  title: [Sampling the fitted transitions generates new text],
  teaching-move: [Show repeated categorical row sampling and its generated first-order text output.],
  layout: layout-stack(items: ("sampling-rule", "generated-text"), key-points: "takeaway", dominant: "generated-text"),
  cards: (
    schema-card(label: "sampling-rule", title: [Repeated conditional sampling])[
      $ X_1 tilde op("Cat")(pi), quad (X_t|X_(t-1)=j) tilde op("Cat")(hat(A)_(j dot)) $
      Current character j → sample from row j → new current character.
    ],
    design-card(label: "generated-text", title: [Asset brief — course-generated first-order sample])[
      Generate a short fixed-seed sample from the validated Time Machine
      first-order character transition matrix used above, with a documented
      initial distribution or given starting character. Preserve spaces.
      Visible caption: “Course-generated sample: first-order character model,
      trained on The Time Machine”. Show the actual unedited sample, not
      invented English or selected prose presented as model output. Keep its
      short-memory character visible; do not promise coherent language.

      Source distinction: Murphy Fig.2.16 is a 10-gram model trained on the King
      James Bible. Its printed excerpt is not output from this first-order fit.
      Authoring verifies the seed, model parameters, starting condition, and
      defined rows before producing this asset.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[Generation repeatedly samples the fitted categorical row selected by the current character.],
  ),
  reveal: reveal-cumulative(initial: ("sampling-rule",), then: (
    reveal-step(("generated-text",), purpose: [Inspect actual output of the stated first-order fitted model.]),
    reveal-step(("takeaway",), purpose: [Connect the generated sequence to repeated row sampling.]),
  )),
  summary-candidates: (summary-visual-candidate("sampling-rule", reason: [Generation is the second use of the same fitted rows.]),),
)

#slide-design(
  title: [From text to a fitted Markov model],
  section: [Section 8 — summary],
  teaching-move: [Consolidate the text-to-counts-to-rows learning chain and the two uses of the learned model.],
  layout: layout-summary(visual: "summary-visual", takeaways: "summary-takeaways"),
  cards: (
    section-summary-visual(label: "summary-visual")[
      Text → transition counts → normalized rows → scoring / sampling.
      $ N_(j k) arrow.r hat(A)_(j k)=N_(j k)/N_j, quad N_j>0 $
      $ p(x_(1:T)|pi,hat(A))=pi_(x_1)product_(t=2)^T hat(A)_(x_(t-1),x_t) $
      $ (X_t|X_(t-1)=j) tilde op("Cat")(hat(A)_(j dot)) $
    ],
    section-summary-takeaways(label: "summary-takeaways")[
      - Each preceding state selects one categorical next-state distribution.
      - Transition counts learn those rows by count and normalize.
      - The fitted rows support sequence probabilities and conditional sampling.
    ],
  ),
  reveal: reveal-static(("summary-visual", "summary-takeaways")),
  rationale: [Select the row MLE, factorization, and sampling rule. The established empirical matrices are supporting evidence; omit large repeated figures and generated excerpts from this compact summary.],
  constraints: [Final retrospective section teaching move. No new claim or exercise is introduced. The separate lecture-level notebook handoff in slide_organization.md follows outside this slide and outside the section contract.],
)
