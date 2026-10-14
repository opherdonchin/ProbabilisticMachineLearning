// Bounded design for two new live slides, not a complete L01 design.
// Instructor mandate: add the squared-error posterior-mean derivation live;
// reduction or transfer to a recording requires a later instructor decision.
// Organization and section contract supplied by the coordinator, 2026-10-14.
#import "../../design.typ": *

#set document(title: "L01 — bounded squared-loss slide design")

#section-design-notes(
  title: [Linear Gaussian systems — bounded squared-loss insertion],
  purpose: [
    Justify the point estimate already extracted from the conditional Gaussian
    by making its reconstruction criterion explicit.
  ],
  entry: [
    The preceding slide establishes $p(z|y)$ and $E[z|y]$; the lecture has
    introduced loss, expectation, covariance and matrix algebra.
  ],
  endpoint: [
    Students can derive $R(a|y)=op("tr")(V)+norm(m-a)^2$, select $a=m$
    under squared Euclidean loss, and distinguish posterior uncertainty from
    the excess risk caused by choosing another estimate.
  ],
  arc: [
    Define an action and conditional risk → center the reconstruction error
    around the posterior mean → average the expansion → select the minimizing
    action and specialize to the conditional Gaussian.
  ],
  anchors: [
    Preserve the deck's $z,y,mu_(z|y),Sigma_(z|y)$ notation. Use
    $m=E[z|y]$, $V=op("Cov")[z|y]$ and $r=z-m$ locally. The squared-norm
    expansion is the algebraic anchor; the risk decomposition is the conclusion.
  ],
  summary-brief: [
    The existing retrospective Linear Gaussian systems summary remains the
    section's final teaching move. Candidate takeaway: the conditional mean
    minimizes squared-error risk; its covariance measures remaining uncertainty.
    This bounded artifact does not redesign that summary.
  ],
  continuity: [
    Insert immediately after “Inference often combines conditioning and
    summarizing” and before “Sensor fusion combines measurements according to
    their uncertainty”. Connect to the preceding distribution-to-summary move
    at the opening of the first added slide.
  ],
  constraints: [
    Exactly two live slides, two and three cumulative states respectively.
    Finite conditional second moments suffice; Gaussianity is used only for
    specialization. Actions are fixed given $y$. No loss catalogue, new notebook
    experiment, recording production or whole-lecture approval is implied.
    Murphy Book 1, §5.1.5.1 “L2 loss”, Eqs. 5.32–5.34 gives the scalar result;
    this vector risk decomposition is a course elaboration.
  ],
)

#slide-design(
  title: [A point estimate needs a loss function],
  section: [Linear Gaussian systems — added live derivation 1/2],
  teaching-move: [
    Turn the posterior-mean summary into a decision problem, then expose the
    centered-error expansion whose expectation will select that summary.
  ],
  layout: layout-grid(
    columns: 1,
    cells: (
      layout-cell("loss-risk"),
      layout-cell("centered-expansion"),
      layout-cell("criterion"),
      layout-cell("fixed-action"),
    ),
    dominant: "centered-expansion",
  ),
  cards: (
    card(label: "loss-risk", title: [Choose a reconstruction after observing $y$])[
      $m=E[z|y], quad V=op("Cov")[z|y]$

      Choose any estimate $a in RR^d$ to reconstruct the unknown vector $z in RR^d$.

      $ L(a,z)=norm(z-a)^2, quad R(a|y)=E[L(a,z)|y] $
    ],
    card(label: "centered-expansion", title: [Center the error at the conditional mean])[
      $ r=z-m, quad z-a=r+(m-a) $
      $ norm(z-a)^2 = norm(r)^2 + 2r^T (m-a) + norm(m-a)^2 $
    ],
  ),
  key-points: (
    key-points(label: "criterion")[
      - A reconstruction is judged by conditional expected squared error.
    ],
    key-points(label: "fixed-action")[
      - Given $y$, the chosen $a$ is fixed; uncertainty remains in $z$.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("loss-risk", "criterion"),
    then: (
      reveal-step(
        ("centered-expansion", "fixed-action"),
        purpose: [Expose the cross term before taking its expectation.],
      ),
    ),
  ),
  rationale: [
    The loss and the distribution are visibly different objects. The norm
    expansion remains visible through the final state, so the next slide can
    carry forward its expectation without algebra appearing from nowhere.
  ],
  constraints: [
    Keep the expanded norm equation dominant and readable. It may be broken
    across aligned lines during authoring without changing the expression.
    Do not reveal the optimal action on this preparatory slide.
  ],
)

#slide-design(
  title: [The conditional mean minimizes squared-error risk],
  section: [Linear Gaussian systems — added live derivation 2/2],
  teaching-move: [
    Average the centered expansion, separate uncertainty from action-dependent
    excess risk, and select the optimal point estimate.
  ],
  layout: layout-grid(
    columns: 2,
    cells: (
      layout-cell("expected-terms", colspan: 2),
      layout-cell("risk-decomposition", colspan: 2),
      layout-cell("optimal-action"),
      layout-cell("gaussian-case"),
      layout-cell("validity", colspan: 2),
      layout-cell("interpretation", colspan: 2),
    ),
    dominant: "risk-decomposition",
  ),
  cards: (
    recall-card(
      label: "expected-terms",
      from: [Previous slide: $r=z-m$, $V=op("Cov")[z|y]$],
      title: [Average the centered expansion],
    )[
      $ E[r|y]=0 $
      $ E[2r^T (m-a)|y]=2E[r|y]^T (m-a)=0 $
      $ E[norm(r)^2|y]=sum_j V_(j j)=op("tr")(V) $
    ],
    card(label: "risk-decomposition", title: [Conditional squared-error risk])[
      $ R(a|y)=underbrace(op("tr")(V), "remaining uncertainty")
        +underbrace(norm(m-a)^2, "excess risk from the chosen estimate") $
    ],
    card(label: "optimal-action", title: [Optimal reconstruction])[
      $ a^*(y)=m=E[z|y] $
      $ min_a R(a|y)=op("tr")(V) $
    ],
    card(label: "gaussian-case", title: [For the conditional Gaussian])[
      $ m=mu_(z|y), quad V=Sigma_(z|y) $
    ],
  ),
  key-points: (
    key-points(label: "validity")[
      - This decomposition needs finite conditional second moments, not Gaussianity.
    ],
    key-points(label: "interpretation")[
      - The conditional mean minimizes model expected squared error; covariance
        describes the uncertainty that remains.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("expected-terms",),
    then: (
      reveal-step(
        ("risk-decomposition", "validity"),
        purpose: [Combine the averaged terms into the risk decomposition.],
      ),
      reveal-step(
        ("optimal-action", "gaussian-case", "interpretation"),
        purpose: [Minimize the nonnegative excess-risk term and identify the Gaussian mean.],
      ),
    ),
  ),
  summary-candidates: (
    summary-key-point-candidate(
      [The conditional mean minimizes squared-error risk; covariance describes remaining uncertainty.],
      from: "interpretation",
      reason: [Connects the lecture's loss criterion to its existing posterior summary.],
    ),
  ),
  rationale: [
    The zero-mean residual eliminates the cross term. The trace equals the sum
    of conditional coordinate variances. The decomposition makes the minimizing
    choice visible without an additional differentiation proof.
  ],
  constraints: [
    Treat expected terms as subordinate carried-forward algebra. Keep the risk
    equation dominant; its underbrace explanations may be implemented as aligned
    labels if that is more legible. The two final cards are subordinate and may
    be arranged beside each other or in a compact stack. Include a source note:
    “Murphy, Book 1 §5.1.5.1; vector decomposition: course elaboration”.
    Model expected loss does not assert a measured empirical reconstruction
    error or optimality under another loss.
  ],
)
