#import "../../../Lectures/design.typ": *

// Converged provisional D1 after mapped prototype tests. Not approved production.
#section-design-notes(
  title: [L01 — posterior summary to squared-loss reconstruction],
  purpose: [Justify choosing the preceding mean summary as an unconstrained reconstruction under conditional expected squared Euclidean loss.],
  entry: [Actual63 establishes $hat(z)=E[z|y]=mu_(z|y)$, not a loss criterion or optimality.],
  endpoint: [Complete finite-second-moment vector proof; unique optimum, minimum risk and Gaussian return.],
  arc: [Choose a criterion → center the pointwise error → average and evaluate its terms → assemble the risk → select the reconstruction.],
  anchors: [Introduce $m,V,r$ once. Preserve local operation labels and warrants, a whole risk identity, and separate interpretation. Actual48 keeps residual and cancellation warrant beside its target; actual61 assembles a result from visible ingredients.],
  summary-brief: [Internal cluster: existing retrospective section summary remains unchanged. Nominate the risk identity and conditional-mean conclusion.],
  continuity: [Use actual63 before these slides and actual66 after them unchanged. No new closing handoff.],
  constraints: [Organization selects D1's two-slide boundary after comparing its genuine adjacent proof/result prototype with viable three-slide B. Full proof depth and live placement are accepted; 2–4 minutes remains unmeasured. Instructor acceptance and independent quality review remain pending.],
)

#slide-design(
  title: [A point estimate needs a loss function],
  teaching-move: [Connect the prior mean summary to a reconstruction criterion, then center its pointwise error.],
  layout: layout-grid(
    columns: 1,
    cells: (
      layout-cell("mean-summary"), layout-cell("criterion"),
      layout-cell("moments"), layout-cell("center"), layout-cell("proof-source"),
      layout-cell("criterion-meaning"), layout-cell("centering-meaning"),
    ),
    dominant: "center",
  ),
  cards: (
    recall-card(label: "mean-summary", from: [Actual63 final state], [$ hat(z)=E[z|y]=mu_(z|y) $]),
    card(label: "criterion", [
      Observed $y$; unknown $z in RR^d$; $a in RR^d$ fixed at this $y$.
      Squared-loss criterion\
      Assume $E[norm(z)^2|y]<infinity$.
      $ L(a,z)=norm(z-a)^2, quad R(a|y)=E[L(a,z)|y] $
    ]),
    card(label: "moments", [
      Center at $m$:
      $ m=E[z|y], quad V=op("Cov")[z|y], quad r=z-m $
      Earlier Gaussian: $m=mu_(z|y)$, $V=Sigma_(z|y)$.
    ]),
    card(label: "center", [
      $ z-a=r+(m-a) $
      $ norm(z-a)^2=norm(r)^2+2r^T dot (m-a)+norm(m-a)^2 $
    ]),
    card(label: "proof-source", title: [Source note], [Murphy, Book 1 §5.1.5.1; vector decomposition: course elaboration]),
  ),
  key-points: (
    key-points(label: "criterion-meaning", [- We choose $a$ to reconstruct $z$ by minimizing posterior expected squared error $R(a|y)$.]),
    key-points(label: "centering-meaning", [- Centering writes the error as random residual $r$ plus the fixed offset $m-a$.]),
  ),
  reveal: reveal-cumulative(
    initial: ("mean-summary", "criterion", "criterion-meaning"),
    then: (
      reveal-step(("moments",), purpose: [Introduce general notation and immediate Gaussian correspondence as new definitions.]),
      reveal-step(("center", "proof-source", "centering-meaning"), purpose: [Rewrite then expand the same error; cross-term remains.]),
    ),
  ),
  rationale: [Recall is subordinate. One intrinsic criterion cue groups fixed-y conditions and loss/risk; the reconstruction task and minimization goal are in its key point. A distinct centering cue begins the new definitions and their subordinate Gaussian mapping; its later whole square is the final focal object. The centering key point names the random residual versus fixed offset. These are two mathematical operation groups, not peer headings for each line. Exact whitespace/hierarchy mechanics belong to Authoring.],
  constraints: [Do not average or claim optimality here. Proof and key points have different roles; no peer heading for each equation.],
)

#slide-design(
  title: [The conditional mean uniquely minimizes squared-error risk],
  teaching-move: [Average and evaluate the centered error, assemble its risk identity, then read off the unique optimum and apply it to the Gaussian summary.],
  layout: layout-grid(
    columns: 2,
    cells: (
      layout-cell("pointwise", colspan: 2),
      layout-cell("average", colspan: 2),
      layout-cell("zero-mean"), layout-cell("risk"),
      layout-cell("trace", rowspan: 2), layout-cell("choice"),
      layout-cell("gaussian"),
      layout-cell("risk-meaning", colspan: 2),
      layout-cell("regime", colspan: 2),
    ),
    dominant: "risk",
  ),
  cards: (
    recall-card(label: "pointwise", from: [This cluster's first slide], [
      $ m=E[z|y], quad V=op("Cov")[z|y], quad r=z-m $
      $ norm(z-a)^2=norm(r)^2+2r^T dot (m-a)+norm(m-a)^2 $
    ]),
    card(label: "average", [
      Take conditional expectation; $a,m$ are fixed at this $y$.
      $ R(a|y)=E[norm(r)^2|y]+2E[r^T dot (m-a)|y]+norm(m-a)^2 $
    ]),
    card(label: "zero-mean", [
      Centering cancels the cross-term:
      $ E[r|y]=E[z|y]-m=0 $
      $ E[r^T dot (m-a)|y] $
      $ =E[r|y]^T dot (m-a)=0 $
    ]),
    card(label: "trace", [
      Residual energy; $V=E[r r^T|y]$:
      $ E[norm(r)^2|y]=sum_(j=1)^d E[r_j^2|y] $
      $ =sum_(j=1)^d V_(j j)=op("tr") V $
    ]),
    card(label: "risk", [
      Substitute the two moments:
      $ R(a|y)=op("tr") V+norm(m-a)^2 $
    ]),
    card(label: "choice", [
      $ norm(m-a)^2>=0 quad "with equality iff" quad a=m $
      $ a^*(y)=m=E[z|y], quad min_a R(a|y)=op("tr") V $
    ]),
    card(label: "gaussian", [
      Earlier Gaussian:
      $ a^*(y)=m=hat(z)=mu_(z|y) $
      $ min_a R(a|y)=op("tr") Sigma_(z|y) $
    ]),
  ),
  key-points: (
    key-points(label: "risk-meaning", [- Risk is residual uncertainty plus the squared distance of the chosen action from the mean.]),
    key-points(label: "regime", [- This is model expected loss; finite conditional second moments suffice without Gaussianity.]),
  ),
  reveal: reveal-cumulative(
    initial: ("pointwise",),
    then: (
      reveal-step(("average",), purpose: [Average the actual expansion as new reasoning, with fixed-y warrant; preserve premise for direct comparison.]),
      reveal-step(("zero-mean", "trace"), purpose: [Evaluate the two expectation terms beside the still-visible averaged expression; warrants stay local.]),
      reveal-step(("risk", "risk-meaning"), purpose: [Substitute both evaluated moments; the intact identity is the focal result beside its supporting proof.]),
      reveal-step(("choice", "gaussian", "regime"), purpose: [The squared-distance equality case licenses unique optimum/minimum, then the earlier Gaussian mapping supplies the application. Proof and risk identity persist.]),
    ),
  ),
  summary-candidates: (
    summary-visual-candidate("risk", reason: [One equality combines irreducible and excess risk.]),
    summary-key-point-candidate([The conditional mean uniquely minimizes conditional expected squared loss.], from: "choice"),
  ),
  rationale: [A whole averaged equality spans the upper context; left evaluations support the adjacent right identity and choice. The risk result has primary mathematical weight; operation cues connect it to the proof. Keep the pointwise expansion and definitions in their subordinate prior role through every state, matching the successful actual prototype. Separate lower key points interpret the result. Exact sizes, ratios and geometry remain Authoring-owned.],
  constraints: [Local warrants are necessary mathematics, not rival lesson headings. Keep full averaged expression, zero-mean derivation, fixed-action factorization, sum-to-trace evaluation and equality-case argument. The two-line cancellation break preserves the complete factorization and zero together. No clipping, arbitrary proof shrinkage, empirical guarantee or extra loss catalogue.],
  backpressure: [The genuine D1 realization is mechanically successful and all meaningful prototype states have been inspected; Organization chooses it provisionally over viable B. This is coherent specialist agreement, not instructor acceptance. Exact final changes and affected-state validation remain Authoring-owned.],
)
