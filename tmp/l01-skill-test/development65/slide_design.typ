#import "../../../Lectures/design.typ": *

// Review-document defaults from design.typ; imported set rules are module-local.
// These govern this A4 specification, not the eventual teaching slide geometry.
#set page(paper: "a4", margin: (x: 12mm, y: 8mm))
#set text(size: 8.8pt)
#set par(leading: 0.52em)

#section-design-notes(
  title: [Isolated L01 design test — slide 65],
  purpose: [Justify summarizing a conditional distribution by its mean when the loss is squared Euclidean error.],
  entry: [Conditional law, mean and covariance; the preceding slide established squared Euclidean loss, conditional risk and centered norm expansion.],
  endpoint: [Derive the risk decomposition, minimize over all estimates in $RR^d$, and identify the optimizer for the conditional Gaussian.],
  arc: [Carry the expansion; evaluate its centered terms; read off the unique minimizer; identify the Gaussian parameters.],
  anchors: [Use $z$ and $y$ from the supplied neighboring slides. Locally abbreviate the general conditional mean and covariance as $m$ and $C$; identify them with $mu_(z|y)$ and $Sigma_(z|y)$ only after the proof. Equations are the inspected objects; interpretation has a separate key-point slot.],
  summary-brief: [Nominate the risk decomposition and the conditional-mean conclusion for a future section summary. This isolated assignment does not create or amend that summary.],
  continuity: [The supplied slide 63 distinguishes conditioning from summarizing. Slide 48 supplies the proof precedent: visible residual equations support a separate declarative conclusion. Slide 66 uses the same $z,y$ notation for sensor fusion. No closing handoff is added.],
  constraints: [One teaching slide, fixed title and assigned derivation. Functional authority is the supplied contract, not a reopened section plan. Finite conditional second moments suffice; no Gaussian assumption enters the general proof.],
)

#slide-design(
  title: [The conditional mean minimizes squared-error risk],
  section: [L01 — isolated slide 65],
  teaching-move: [Evaluate the two conditional-moment terms in the centered expansion to prove the risk decomposition and its unique minimizer; identify the conditional Gaussian case.],
  cards: (
    recall-card(
      label: "context",
      from: [Supplied contract: preceding slide's conditional risk and centered norm expansion; earlier conditional mean and covariance.],
      [
        $ m=E[z|y], quad C="Cov"[z|y], quad r=z-m $
        $ a in RR^d, quad E[norm(z)^2|y]<infinity $
        $ R(a|y) &= E[norm(z-a)^2|y] \
          &= E[norm(r)^2|y]+2 E[r^T (m-a)|y]+norm(m-a)^2 $
      ],
    ),
    card(
      label: "centered-cross-term",
      [
        $ E[r|y]=E[z|y]-m=0 $
        $ E[r^T (m-a)|y]=E[r|y]^T (m-a)=0 $
      ],
    ),
    card(
      label: "residual-energy",
      [
        $ E[norm(r)^2|y] &= sum_(j=1)^d E[r_j^2|y] \
          &= sum_(j=1)^d C_(j j)="tr" C $
      ],
    ),
    card(
      label: "risk-and-minimizer",
      [
        $ R(a|y)="tr" C+norm(a-m)^2 $
        $ arg min_(a in RR^d) R(a|y)={m}, quad min_(a in RR^d) R(a|y)="tr" C $
      ],
    ),
    card(
      label: "gaussian-identification",
      [
        $ p(z|y)=cal(N)(z|mu_(z|y),Sigma_(z|y)) $
        $ m=mu_(z|y), quad C=Sigma_(z|y), quad hat(z)=mu_(z|y) $
      ],
    ),
  ),
  key-points: (
    key-points(
      label: "interpretation",
      [
        - The conditional mean uniquely minimizes squared-error risk; Gaussianity is unnecessary.
        - The minimum risk is the covariance trace; displacement from the mean adds squared distance.
      ],
    ),
  ),
  layout: layout-stack(
    items: ("context", "centered-cross-term", "residual-energy", "risk-and-minimizer", "gaussian-identification"),
    key-points: "interpretation",
    dominant: "risk-and-minimizer",
  ),
  reveal: reveal-cumulative(
    initial: ("context", "centered-cross-term"),
    then: (
      reveal-step(("residual-energy",), purpose: [Convert centered residual energy into covariance trace.]),
      reveal-step(("risk-and-minimizer",), purpose: [Substitute both identities and minimize the nonnegative squared-distance term.]),
      reveal-step(("gaussian-identification", "interpretation"), purpose: [Identify the earlier conditional Gaussian's mean and covariance, then interpret the general theorem.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("risk-and-minimizer", reason: [Retells the proof's decision-theoretic conclusion in one equation.]),
    summary-key-point-candidate([The conditional mean uniquely minimizes squared-error risk; Gaussianity is unnecessary.], from: "interpretation"),
  ),
  rationale: [The opening context is subordinate recall. The centered expectation, vanished cross-term and trace identity are new proof objects, not recall. Their adjacent regions form one continuous derivation, without separate student-facing explanatory headings or competing card borders. The final state preserves the identities above the dominant risk decomposition; Gaussian identification follows below, with interpretation in its own slot. Reveal steps provide attention by entry order, so additional transient emphasis is unnecessary.],
  constraints: [Fix $y$ at a value for which the conditional second moment is finite and interpret $a$ as deterministic once $y$ is observed. For random $Y$, the conclusion is pointwise almost surely. Conditions and local definitions belong with the equations; all sentence-length interpretation belongs in key points. Production must keep the proof adjacent, the recall subordinate and the final identities simultaneously visible. Exact font sizes, geometry and Touying syntax remain downstream.],
  backpressure: [No upstream change is proposed. Authoring must check classroom readability of the complete proof state; the A4 design document cannot establish it. The one-slide contract is retained without adding another teaching move.],
)
