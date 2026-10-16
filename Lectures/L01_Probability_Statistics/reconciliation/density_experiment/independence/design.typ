#import "../../../../design.typ": *

#section-design-notes(
  title: [Gaussian conditional mean — isolated exploratory design],
  purpose: [Derive the mean on actual48 through the independent Gaussian residual. This is an interior teaching move, not a replacement section.],
  entry: [Actual47 displays a joint Gaussian and uses the affine rule to obtain a marginal. Actual39 explicitly warns that zero covariance does not imply independence in general. Block covariance notation and ordinary invertible covariance matrices are established context.],
  endpoint: [Students can reconstruct why the residual is independent of the observed block, why its conditional mean is zero, and how the observed deviation shifts the conditional mean.],
  arc: [Construct the centered residual; verify its moments; use affine Gaussian closure and zero cross-covariance to obtain independence; take the conditional expectation.],
  anchors: [Keep the course notation $x_1,x_2,mu_1,mu_2,Sigma_(i j),B,r$. The final label $mu_(1|2)$ makes the residual identity recoverable for unchanged actual49. New proof uses ordinary objects, with local warrants and a separate key-point region.],
  summary-brief: [No new section-summary slide is owned by this bounded experiment. Existing retrospective section closure remains unchanged. The residual and conditional-mean result are suitable summary anchors if the section owner revisits them.],
  continuity: [Receive the Gaussian/block/affine context from actual47. Actual49 reuses the resulting independent residual. Preserve neighbors verbatim; no closing handoff is appended.],
  constraints: [Frozen instruction commit 61acb414c5956202add5f7ddbdbbdbfaadc5f304. Organization proposes one slide with the original title. This is provisional builder work, not production or approval. Compare realized alternatives at the existing course scale before freezing hierarchy.],
)

#slide-design(
  title: [Conditioning shifts the mean by an observed deviation],
  section: [Marginals and conditionals — actual48 only],
  teaching-move: [Derive the conditional mean from the independent centered Gaussian residual.],
  cards: (
    bordered-card(label: "residual", title: [Centered residual])[
      $ B=Sigma_12 Sigma_22^(-1), quad r=x_1-mu_1-B(x_2-mu_2) $
      $ E[r]=0 $
    ],
    card(label: "moments")[
      $ "Cov"[r,x_2]=Sigma_12-B Sigma_22=0 $
    ],
    card(label: "gaussian-warrant")[
      Affine closure: $(r,x_2)$ is jointly Gaussian.

      Zero cross-covariance gives $r$ independent of $x_2$.
    ],
    card(label: "conditional-residual")[
      $ E[r | x_2]=E[r]=0 $
    ],
    card(label: "mean-result")[
      $ E[x_1 | x_2]=mu_1+B(x_2-mu_2)=mu_(1|2) $
    ],
  ),
  key-points: (
    key-points(label: "interpretation")[
      - The observed deviation $x_2-mu_2$ shifts the mean through $B=Sigma_12 Sigma_22^(-1)$.
    ],
  ),
  layout: layout-stack(
    items: ("residual", "moments", "gaussian-warrant", "conditional-residual", "mean-result"),
    key-points: "interpretation",
    dominant: "mean-result",
  ),
  reveal: reveal-cumulative(
    initial: ("residual", "interpretation"),
    then: (
      reveal-step(("moments",), purpose: [The chosen coefficient removes cross-covariance.]),
      reveal-step(("gaussian-warrant",), purpose: [The joint family, not just Cov=0, licenses independence.]),
      reveal-step(("conditional-residual", "mean-result"), purpose: [Independence removes the conditional residual mean; substitution yields the mean shift.]),
    ),
  ),
  rationale: [Select the full inferential chain. Keep $E[r]=0$ visible because the conditional-mean step uses it; keep the joint Gaussian warrant adjacent to the covariance-to-independence inference. Routine covariance bilinearity and matrix inverse cancellation are prior mathematical operations and need not be expanded. Do not present $r=x_1-mu_(1|2)$ as a definition before proving the mean. The final result supplies that equivalent identity for actual49. Omit the conditional-density header from this mean-focused teaching move: actual49 derives covariance, and the subsequent section material assembles the Gaussian law. This changes projection, not the accepted residual derivation depth.],
  constraints: [The intended proof-led layout reads downward through grouped mathematical licenses and consequences. Keep the residual and central covariance equality whole. Proof support uses the established proof scale; the final mean occupies the main object scale and a separate semantic region. Avoid a long competing proof heading and avoid giving every line equal visual weight. The key point remains a separate interpretation slot. Source note: Murphy, Book 2 §2.3.1.3, Eq. 2.78; course residual proof uses affine Gaussian closure. Technical positive-definiteness/ordinary-density regime is checked against the accepted scope; it is not a new theorem projected here.],
  backpressure: [The builders provisionally prefer the proof-led hierarchy candidate after inspecting its complete handout and four meaningful states. One-slide count and original title are retained. A result-left/proof-right alternative and an equal-weight proof-led stack remain live experimental comparisons. This is builder convergence, not instructor acceptance or independent validation. No Scope or Section Design change is proposed.],
)
