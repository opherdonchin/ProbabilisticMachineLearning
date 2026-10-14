#import "../../../Lectures/design.typ": *

// A4 review-document defaults only; teaching-slide geometry remains downstream.
#set page(paper: "a4", margin: (x: 12mm, y: 8mm))
#set text(size: 8.8pt)
#set par(leading: 0.52em)

#section-design-notes(
  title: [L01 — paired squared-loss revision],
  purpose: [Justify the posterior mean as a reconstruction action under conditional expected squared Euclidean loss.],
  entry: [Actual slide 63 shows $p(z|y)=cal(N)(z|mu_(z|y),Sigma_(z|y))$ and $hat(z)=E[z|y]=mu_(z|y)$, distinguishing the whole posterior from its summary. Optimality and the loss criterion have not been taught.],
  endpoint: [Prove the complete vector risk decomposition with finite conditional second moments; establish the unique unconstrained optimum and minimum risk; apply it to the already computed Gaussian mean.],
  arc: [Summary → action and criterion → pointwise centered error → conditional averaging → two moment evaluations → intact risk identity → optimum and Gaussian application.],
  anchors: [Introduce $m=E[z|y]$, $V=op("Cov")[z|y]$ and $r=z-m$ on 64, including the correspondence $m=mu_(z|y)$, $V=Sigma_(z|y)$ for the preceding Gaussian. Retain that notation on 65. Short operation labels and local warrants belong to the inspected argument; key points interpret it separately.],
  summary-brief: [This internal insertion does not end the section. Nominate only the risk identity and conditional-mean conclusion for retrospective reuse; retain the existing section summary.],
  continuity: [The mean-proof precedent keeps its target and residual while placing the Gaussian-independence warrant beside cancellation (pp. 109–112). Gaussian Bayes maps variables before applying a rule and interprets each output (pp. 135–137). Scalar update computes peer ingredients before assembling a dominant result (pp. 141–143). Preserve these relations, not their geometry. Slide 66 retains its sensor-fusion task and two operations; no closing teaser is added.],
  constraints: [Two slides, fixed titles/order, full accepted live proof, 2–4 minutes unmeasured. Fix an observed $y$ with finite conditional second moment; $a$ is unrestricted in $RR^d$ and fixed at this $y$. Conditional distributions/moments are model quantities. No experiment, other-loss catalogue, quadratic-separation proof or new section.],
)

#slide-design(
  title: [A point estimate needs a loss function],
  section: [7. Linear Gaussian systems — provisional slide 64],
  teaching-move: [Give the preceding mean summary a decision criterion, then center the pointwise squared error to expose the terms whose conditional expectations determine risk.],
  layout: layout-grid(
    columns: 2,
    cells: (
      layout-cell("posterior-summary"), layout-cell("action-criterion"),
      layout-cell("conditional-moments", colspan: 2),
      layout-cell("centered-error", colspan: 2),
      layout-cell("criterion-meaning", colspan: 2),
      layout-cell("centering-meaning", colspan: 2),
    ),
    dominant: "centered-error",
  ),
  cards: (
    recall-card(
      label: "posterior-summary",
      from: [Actual slide 63, final state],
      heading: [Posterior and mean summary],
      [
        $ p(z|y)=cal(N)(z|mu_(z|y),Sigma_(z|y)) $
        $ hat(z)=E[z|y]=mu_(z|y) $
      ],
    ),
    card(
      label: "action-criterion",
      title: [Squared-loss criterion],
      [
        $ a in RR^d " fixed after observing " y $
        $ E[norm(z)^2|y]<infinity $
        $ L(a,z)=norm(z-a)^2 $
        $ R(a|y)=E[L(a,z)|y] $
      ],
    ),
    card(
      label: "conditional-moments",
      title: [Conditional moments and centered residual],
      [
        $ m=E[z|y], quad V=op("Cov")[z|y], quad r=z-m $
        Earlier Gaussian: $m=mu_(z|y)$, $V=Sigma_(z|y)$.
      ],
    ),
    card(
      label: "centered-error",
      title: [Center at the conditional mean],
      [
        $ z-a=r+(m-a) $
        $ norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2 $
      ],
    ),
  ),
  key-points: (
    key-points(
      label: "criterion-meaning",
      [- Choosing a reconstruction $a$ requires a criterion: $R(a|y)$ averages its squared error under the posterior.],
    ),
    key-points(
      label: "centering-meaning",
      [- Centering separates residual error from displacement of the chosen action; the cross-term is still present.],
    ),
  ),
  reveal: reveal-cumulative(
    initial: ("posterior-summary", "action-criterion", "criterion-meaning"),
    then: (
      reveal-step(
        ("conditional-moments",),
        purpose: [Introduce shared general moment notation once, with its Gaussian correspondence before reuse. Keep criterion and its interpretation visible.],
        emphasize: true,
      ),
      reveal-step(
        ("centered-error", "centering-meaning"),
        purpose: [Rewrite the same pointwise error around m and expand the square; interpret the three-term structure now, without averaging or claiming optimality.],
      ),
    ),
  ),
  rationale: [The opening contrasts an existing summary with a freely chosen action, interpreted immediately in the separate lower key-point slot. New definitions occupy a linking band; the full-width centered equality then becomes the focal object. “Center” and “Earlier Gaussian” identify mathematical operations/correspondence, not rival takeaways. The layout sketch's last two cells are one separate interpretation region, not mathematical cards.],
  constraints: [Keep the centered equality intact, with its cross-term. No average, cancellation or optimum on 64. Do not style conditional-moments as recall. Restrain borders to role/grouping; exact ratios and typography belong to authoring.],
  backpressure: [No upstream change requested. The A4 specification establishes content and relationships; every production reveal still requires classroom-scale validation.],
)

#slide-design(
  title: [The conditional mean minimizes squared-error risk],
  section: [7. Linear Gaussian systems — provisional slide 65],
  teaching-move: [Average the centered error; evaluate both moments; assemble the risk identity; minimize and apply to the Gaussian mean.],
  layout: layout-grid(
    columns: 2,
    cells: (
      layout-cell("pointwise-carry", colspan: 2),
      layout-cell("average-error", colspan: 2),
      layout-cell("cross-term"), layout-cell("residual-energy"),
      layout-cell("risk-identity", colspan: 2),
      layout-cell("optimum"), layout-cell("gaussian-return"),
      layout-cell("risk-meaning", colspan: 2),
      layout-cell("generality", colspan: 2),
    ),
    dominant: "risk-identity",
  ),
  cards: (
    recall-card(
      label: "pointwise-carry",
      from: [This pair's slide 64, final state],
      heading: [Pointwise expansion],
      [
        $m=E[z|y], quad V=op("Cov")[z|y], quad r=z-m$
        $ norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2 $
      ],
    ),
    card(
      label: "average-error",
      title: [Take conditional expectation],
      [
        $ R(a|y)=E[norm(r)^2|y]+2E[r^T (m-a)|y]+norm(m-a)^2 $
        Linearity; $m$ and $a$ are fixed at the observed $y$.
      ],
    ),
    card(
      label: "cross-term",
      title: [Cross-term: centering cancels it],
      [
        $ E[r|y]=E[z|y]-m=0 $
        $ E[r^T (m-a)|y]=E[r|y]^T (m-a)=0 $
      ],
    ),
    card(
      label: "residual-energy",
      title: [Residual energy: sum of variances],
      [
        $ E[norm(r)^2|y] &= sum_(j=1)^d E[r_j^2|y] \
          &= sum_(j=1)^d V_(j j)=op("tr") V $
        Centered $r$: $V=E[r r^T|y]$.
      ],
    ),
    card(
      label: "risk-identity",
      title: [Substitute the two moment evaluations],
      [
        $ R(a|y)=E[norm(z-a)^2|y]=op("tr") V+norm(m-a)^2 $
      ],
    ),
    card(
      label: "optimum",
      title: [Minimize the squared-distance term],
      [
        $ norm(m-a)^2 >= 0 quad "with equality iff" quad a=m $
        $ a^*(y)=m, quad min_(a in RR^d) R(a|y)=op("tr") V $
      ],
    ),
    card(
      label: "gaussian-return",
      title: [For the earlier Gaussian],
      [
        $ a^*(y)=m=hat(z)=mu_(z|y) $
      ],
    ),
  ),
  key-points: (
    key-points(
      label: "risk-meaning",
      [- The covariance trace is the remaining model expected squared error; displacement from the mean adds squared distance.],
    ),
    key-points(
      label: "generality",
      [- The mean is the unique optimum for squared loss with finite conditional second moments; Gaussianity is unnecessary.],
    ),
  ),
  reveal: reveal-cumulative(
    initial: ("pointwise-carry",),
    then: (
      reveal-step(
        ("average-error",),
        purpose: [First new proof operation: average the carried pointwise expansion using linearity and fixed-y action status. This is an ordinary proof object, never recall.],
        emphasize: true,
      ),
      reveal-step(
        ("cross-term", "residual-energy"),
        purpose: [Evaluate the two expectation terms as parallel ingredients of that averaged equation; their labels match its terms, with centering/fixed-action warrants adjacent. Earlier context persists.],
      ),
      reveal-step(
        ("risk-identity", "risk-meaning"),
        purpose: [Substitute zero and covariance trace into the same risk. Give the intact equality primary weight and interpret its two terms together.],
      ),
      reveal-step(
        ("optimum", "gaussian-return", "generality"),
        purpose: [Read nonnegativity and its equality case to obtain the unique optimum/minimum; apply the established Gaussian correspondence to the earlier mean summary. Retain the risk identity as the dominant anchor.],
      ),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("risk-identity", reason: [Retains objective, uncertainty and excess risk in one coherent equality.]),
    summary-key-point-candidate([The conditional mean uniquely minimizes expected squared loss.], from: "generality"),
  ),
  rationale: [This is an assembly argument: subordinate pointwise premise above the new averaging operation; two peer term evaluations below it; one full-width dominant identity assembled from both; optimization and Gaussian return subordinate to that result. Labels name operations/terms, not independent lessons. Match cross-term and residual-energy labels to their terms in the averaged equation through adjacency and consistent attention, without splitting either equality into disconnected pieces. The two key points occupy a separate interpretation region and appear with the results they explain.],
  constraints: [Recall carries only what 64 visibly established. The fixed-y and finite-moment regime persists across the pair; for random Y the statement is pointwise almost surely. The central equality must be recognizably dominant, not one more equally weighted row. Avoid drawing a border around every stage. No repeated Gaussian density, new loss or empirical guarantee. Validate proof/identity/interpretation at classroom scale; do not solve density by shrinking the proof.],
  backpressure: [No title/order/count/depth/section change is proposed. Exact geometry and reveal implementation are authoring-owned; preserve the term-to-evaluation-to-identity relationships and revalidate every state. The 2–4-minute live allocation remains unmeasured.],
)
