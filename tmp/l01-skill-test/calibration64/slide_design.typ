#import "../../../Lectures/design.typ": *

// Experimental one-slide design. No production or upstream artifact is amended.
// Desired composition before API mapping: subordinate posterior-mean context;
// loss and risk definitions; one dominant, full-width centered norm expansion;
// a separate interpretation slot. Definitions persist during the new algebra.

#section-design-notes(
  title: [L01 — isolated point-estimation insertion],
  purpose: [Introduce the criterion for judging a point estimate of the latent state after observing $y$.],
  entry: [The preceding slide establishes $p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y))$ and $E[z | y]=mu_(z|y)$. Euclidean vectors and squared norms are available.],
  endpoint: [Students can read conditional squared-loss risk and the complete centered squared-error expansion. Optimality and the minimizer remain outside this slide.],
  arc: [Carry the posterior mean forward; define loss and posterior expected loss for an arbitrary estimate; expand the squared error around that mean.],
  anchors: [Keep $z,y,mu_(z|y),Sigma_(z|y)$ from slide 63. Use $a$ for a freely chosen estimate, not the already-displayed mean summary $hat(z)$. New algebra is an ordinary mathematical object.],
  summary-brief: [This is not a section-ending slide. Nominate only the criterion key point for possible later retrospective selection; do not design or amend the section summary.],
  continuity: [Slide 48 distinguishes an established Gaussian formula from a new mean proof. Slides 62–63 and 66 separate inspected mathematics from conclusions below. Carry that role distinction into this insertion.],
  constraints: [One slide, supplied title, finite conditional second moments, unconstrained Euclidean estimate. No new model parameters, no numerical example, no minimizer or cancellation of the cross term.],
)

#slide-design(
  title: [A point estimate needs a loss function],
  section: [7. Linear Gaussian systems — experimental slide 64],
  teaching-move: [Define conditional squared-loss risk and prepare its analysis by expanding the squared error about the conditional mean.],
  layout: layout-stack(
    items: ("posterior-context", "loss-risk", "centered-expansion"),
    dominant: "centered-expansion",
    key-points: "criterion",
  ),
  cards: (
    recall-card(
      [
        $ p(z | y)=cal(N)(z | mu_(z|y),Sigma_(z|y)), quad E[z | y]=mu_(z|y) $
      ],
      label: "posterior-context",
      from: [Slide 63, “Inference often combines conditioning and summarizing”],
      heading: [Posterior mean],
    ),
    card(
      [
        $ y " observed", quad a in RR^d, quad E[norm(z)^2 | y] < infinity $
        $ ell(a,z)=norm(z-a)^2, quad R(a | y)=E[ell(a,z) | y] $
      ],
      label: "loss-risk",
    ),
    card(
      [
        $ norm(z-a)^2
          &= norm((z-mu_(z|y))+(mu_(z|y)-a))^2 \
          &= norm(z-mu_(z|y))^2
            + 2(z-mu_(z|y))^T (mu_(z|y)-a)
            + norm(mu_(z|y)-a)^2 $
      ],
      label: "centered-expansion",
    ),
  ),
  key-points: (
    key-points(
      [- A point estimate is judged by its posterior expected loss.],
      label: "criterion",
    ),
  ),
  reveal: reveal-cumulative(
    initial: ("posterior-context", "loss-risk"),
    then: (
      reveal-step(
        ("centered-expansion",),
        purpose: [Add the complete centered squared-norm expansion as one algebraic step. Recall and loss/risk definitions persist.],
        emphasize: true,
      ),
      reveal-step(
        ("criterion",),
        purpose: [Interpret the risk criterion with all mathematics still visible. Entry emphasis has ended; the expansion now displays normally.],
      ),
    ),
  ),
  summary-candidates: (
    summary-key-point-candidate(
      [A point estimate is judged by its posterior expected loss.],
      from: "criterion",
      reason: [Retains the distinction between a posterior summary and a criterion for choosing an estimate.],
    ),
  ),
  rationale: [The new expansion dominates; the recalled Gaussian context is subordinate. Loss and risk are new definitions, not recall. The only object prose is the intrinsic condition “$y$ observed”; motivation and interpretation occupy the separate key-point slot.],
  constraints: [The two lines of the expansion form one proof object, with no competing explanatory headings. Preserve the complete cross term and both squared norms. Exact geometry, font calibration and reveal mechanics belong to Slide Authoring.],
  backpressure: [No upstream change requested. Downstream-owned validation: check the complete expansion at classroom scale; retain its mathematics rather than shrinking it or omitting the cross term. This A4 design render does not establish production-slide readability.],
)
