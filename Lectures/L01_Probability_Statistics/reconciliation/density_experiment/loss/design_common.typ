#import "../../../../design.typ": *

#let section-notes = section-design-notes(
  title: [Squared-error optimality — exploratory cluster],
  purpose: [Justify reconstruction of an unknown vector using conditional expected squared Euclidean error.],
  entry: [Actual63 establishes the Gaussian posterior and mean summary, but no optimality. Conditional expectation, covariance and Gaussian conditioning are available from actual48/59/61.],
  endpoint: [Derive $R(a|y)=op("tr") V+norm(m-a)^2$, the unique optimum $a=m$, and interpret its minimum as residual uncertainty.],
  arc: [Criterion → centering → conditional averaging → moments → decomposition → decision and Gaussian use.],
  anchors: [$m=E[z|y]$, $r=z-m$, $V=op("Cov")[z|y]$. Actual63/66 bodies unchanged.],
  summary-brief: [Internal insertion; existing retrospective section summary remains authoritative. Nominate the mean/loss and residual uncertainty connections; no new closing handoff.],
  continuity: [Gaussian mean is established context. Residual centering is familiar from actual48; these conditional risk calculations are new proof work.],
  constraints: [Experimental A2/B3 titles/boundaries accepted provisionally by Organization. Preserve derive-live depth. Given $y$, $a,m$ fixed, $z,r$ random. Finite conditional second moments suffice: a checking condition, not required projected theorem chrome. Gaussianity is not used in the proof.],
)

#let opening = slide-design(
  title: [Choose a reconstruction by its conditional squared-error risk],
  section: [Linear Gaussian systems],
  teaching-move: [Give the criterion and center its error, exposing random residual and fixed displacement.],
  cards: (
    card(label: "criterion")[Observed $y$; $z,a in RR^d$.
      $ L(a,z)=norm(z-a)^2, quad R(a|y)=E[L(a,z)|y] $],
    card(label: "center")[Center: $m=E[z|y], quad r=z-m$.
      $ z-a=r+(m-a) $],
    card(label: "expansion")[
      $ norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2 $
    ],
  ),
  key-points: (
    key-points(label: "task")[- Choose $a$ to reconstruct $z$ by minimizing conditional expected squared error.],
    key-points(label: "fixed")[- Given $y$, the offset $m-a$ is fixed; uncertainty remains in $r$.],
  ),
  layout: design-layout[Criterion above centering and pointwise expansion: a single downward argument, not three bordered peers. Separate interpretation slot for task and fixedness. Expansion is the final dominant object.],
  reveal: reveal-cumulative(initial: ("criterion", "task"), then: (
    reveal-step(("center", "fixed"), purpose: [Distinguish random residual from fixed displacement.]),
    reveal-step(("expansion",), purpose: [Square the centered vector error; previous context persists.]),
  )),
  rationale: [No full Gaussian recall block: actual63 supplies the mean. Covariance is introduced when used. Center is an intrinsic local operation cue. The square expansion is selected because the proof depends on its three terms.],
  constraints: [The action ranges over all of $RR^d$. Finite-moment qualification belongs in checking. $E[r|y]=0$ is not recalled from this slide: it is new reasoning on the next.],
)

#let premise = recall-card(label: "premise", from: [Previous slide: centered pointwise error])[
  $ norm(z-a)^2=norm(r)^2+2r^T (m-a)+norm(m-a)^2 $
]
#let moments = card(label: "moments")[
  Take $E[dot|y]$; $m-a$ fixed.
  $ E[r|y]=E[z|y]-m=0 $
  $ E[r^T (m-a)|y]=E[r|y]^T (m-a)=0 $
  $ V=op("Cov")[z|y] $
  $ E[norm(r)^2|y]=sum_(j=1)^d E[r_j^2|y]=op("tr") V $
]
#let decomposition = card(label: "decomposition")[
  $ R(a|y)=op("tr") V+norm(m-a)^2 $
]
#let choice = card(label: "choice")[
  $ norm(m-a)^2>=0, quad "equality iff" quad a=m $
  $ a^*(y)=m=E[z|y] $
  $ min_a R(a|y)=op("tr") V $
]
#let gaussian = card(label: "gaussian")[
  Earlier Gaussian:
  $ a^*(y)=mu_(z|y) $
  $ min_a R(a|y)=op("tr") Sigma_(z|y) $
]
#let moment-point = key-points(label: "moment-point")[- Centering removes the average cross-term with the fixed offset.]
#let risk-point = key-points(label: "risk-point")[- Risk is residual uncertainty plus squared distance from the posterior mean.]
#let decision-point = key-points(label: "decision-point")[- The posterior mean minimizes model expected squared error; covariance measures what remains.]
#let proof-rationale = [The immediate first slide has defined $m,r$; the subordinate recall keeps only its pointwise expansion, rather than repeat those definitions. The selected proof applies conditional expectation to the actual recalled expansion, then displays both nontrivial moment evaluations. The separately written full averaged expansion is implicit: conditional linearity and fixedness are established background, while cancellation and trace recognition remain visible new reasoning. Omitted $sum_j V_(j j)$ is the definition of trace; the component sum makes vector residual energy inspectable. Fixedness licenses factoring the cross-term. The identity is intact and central. Nonnegativity and equality establish uniqueness. Finite conditional second moments suffice at the observations where they exist. Model risk is not an empirical performance guarantee. Scalar source: Murphy Book1 §5.1.5.1; vector proof: course elaboration.]
