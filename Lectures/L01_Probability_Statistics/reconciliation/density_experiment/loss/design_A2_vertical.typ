#import "design_common.typ": *
#import "../../../../design.typ": *
#section-notes
#opening
#slide-design(
  title: [Centering the error makes the posterior mean optimal],
  section: [Linear Gaussian systems],
  teaching-move: [Average the expansion, evaluate residual moments, then select and interpret the minimizing action.],
  cards: (premise, moments, decomposition, choice, gaussian),
  key-points: (moment-point, risk-point, decision-point),
  layout: design-layout[Full-width subordinate pointwise premise with fixed-offset averaging cue. New moment work paired horizontally: centered mean/cross-term on the left and covariance/residual energy on the right. Full-width intact risk decomposition below those moments, followed by nonnegativity, action and minimum-risk statements, then subordinate Gaussian use. This tests a downward support-to-result path instead of the lateral A2 proof/result comparison. Key points have a separate lower slot. Exact geometry belongs to Authoring.],
  reveal: design-reveal[State1: premise + moments + moment-point. State2: add intact decomposition; replace moment-point with risk-point in the same interpretation slot. State3: retain all mathematics; add choice, Gaussian application, decision-point. Handout has risk-point and decision-point. The interpretation evolves with the established result; no mathematical support is replaced or hidden.],
  summary-candidates: (summary-key-point-candidate([The posterior mean minimizes conditional expected squared error.], from: "decision-point"),),
  rationale: proof-rationale,
  constraints: [All selected mathematics at course scale. First state contains new proof, not recall alone. Premise stays while averaging; identity and necessary moments survive into decision and handout. Organization owns boundaries/title; Authoring owns geometry and implementation.],
)
