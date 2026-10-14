// Bounded Slide Design build: one L01 live setup slide.
// Commission: test/l01-slide-skills-20261014, baseline 4b69e7e.
// This is a design specification, not an approved production slide.
#import "../../../Lectures/design.typ": *

#set document(title: "L01 — point-estimate loss setup design")
// Review-document defaults match design.typ; these are not slide geometry.
#set page(paper: "a4", margin: (x: 12mm, y: 8mm))
#set text(size: 8.8pt)
#set par(leading: 0.52em)

#section-design-notes(
  title: [Linear Gaussian systems — bounded point-estimate setup],
  purpose: [Connect the established posterior summary to a criterion for judging a point estimate. This artifact designs only the commissioned setup slide.],
  entry: [Students have conditioned the LGS on the observed measurement $y$ and seen $E[z|y]=mu_(z|y)$. Loss and empirical risk appeared earlier in the lecture.],
  endpoint: [Students distinguish the estimate $a$ from the latent vector $z$, write squared loss and conditional risk, and expand the squared error about $m=E[z|y]$.],
  arc: [State the decision after observing $y$; define loss and risk; center the vector error and expand its squared norm.],
  anchors: [Retain $z$ for the latent state and $y$ for the observed measurement. Use $L$ for the latent dimension, $a$ for an unrestricted candidate estimate, and $m=E[z|y]$ as a short name for the mean already denoted $mu_(z|y)$ in the Gaussian case.],
  summary-brief: [Nominate only the already established loss/risk distinction. The surrounding section's retrospective summary and its selection are outside this one-slide commission.],
  continuity: [Insert immediately after “Inference often combines conditioning and summarizing.” Supply the criterion omitted by the preceding summary operation. The following teaching move proves posterior-mean optimality; this slide supplies definitions and centered squared-error algebra.],
  constraints: [Exactly one live slide with the supplied title. Require finite conditional second moments. Include the full squared-norm algebra per the coordinator's clarified preparation contract. Do not expand expected risk, prove a minimizer, or add an experiment. No API changes are proposed.],
)

#slide-design(
  title: [A point estimate needs a loss function],
  section: [L01 — Linear Gaussian systems],
  teaching-move: [Define the decision and criterion after observing $y$, then center and algebraically expand the squared error for the subsequent conditional-expectation proof.],
  layout: layout-stack(
    items: ("context", "criterion", "centering"),
    key-points: "takeaway",
    dominant: "criterion",
  ),
  cards: (
    card(label: "context")[
      After observing $y$, estimate the latent state $z in RR^L$ by a vector $a in RR^L$.

      Assume $E[ norm(z)^2 | y ] < infinity$.
    ],
    card(label: "criterion")[
      *Squared-Euclidean loss*
      $ L(z,a) = norm(z-a)^2 $

      *Conditional risk*
      $ R(a|y) = E[L(z,a)|y] = E[ norm(z-a)^2 | y ] $
    ],
    card(label: "centering")[
      *Center the error about the posterior mean*
      $ m = E[z|y] quad (= mu_(z|y) " for the Gaussian") $
      $ z-a = (z-m) + (m-a) $
      $ norm(z-a)^2 = norm(z-m)^2 + 2(z-m)^T (m-a) + norm(m-a)^2 $

      Centered residual $z-m$ + displacement $m-a$.
    ],
  ),
  key-points: (
    key-points(label: "takeaway")[
      - Conditional risk averages the loss over the posterior $p(z|y)$.
    ],
  ),
  reveal: reveal-cumulative(
    initial: ("context", "criterion", "takeaway"),
    then: (
      reveal-step(
        ("centering",),
        purpose: [Add centering and squared-norm algebra; retain definitions.],
        emphasize: false,
      ),
    ),
  ),
  summary-candidates: (
    summary-key-point-candidate(
      [Conditional risk averages the loss over the posterior $p(z|y)$.],
      from: "takeaway",
      reason: [Links the posterior to a decision criterion; selection is outside this commission.],
    ),
  ),
  rationale: [Keep context subordinate; group loss and risk. The first state establishes the criterion. Reveal the mean, centered identity and squared-norm expansion together below; retain the definitions and takeaway. The final state is a coherent handout.],
  constraints: [Only the four objects are student-visible. Fix $y$ and choose $a$ freely. Norms are Euclidean; retain the moment assumption. Omit entry emphasis: the lower object has its own heading and position. Geometry and mechanics belong to authoring. Scalar loss/risk: Murphy, Book 1 §5.1.5.1, Eqs. 5.32–5.33. Vector algebra: course elaboration. Gaussian notation: existing LGS slides and Book 2 §2.3.2.2.],
)
