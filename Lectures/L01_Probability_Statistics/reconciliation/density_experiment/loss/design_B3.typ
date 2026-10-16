#import "design_common.typ": *
#import "../../../../design.typ": *
#section-notes
#opening
#slide-design(
  title: [Centering separates residual uncertainty from estimation error],
  section: [Linear Gaussian systems],
  teaching-move: [Average the expansion to expose residual uncertainty and avoidable displacement penalty.],
  cards: (premise, moments, decomposition),
  key-points: (moment-point, risk-point,),
  layout: design-layout[Subordinate pointwise premise followed by new moment evaluations and dominant full-width decomposition. Interpretation has its separate slot. No decision/Gaussian application here.],
  reveal: design-reveal[State1: premise + moments + moment-point. State2: add intact decomposition and replace moment-point with risk-point in the same interpretation slot. Handout has risk-point. No mathematical support is replaced or hidden.],
  rationale: proof-rationale,
  constraints: [The extra boundary tests separate decision attention rather than merely creating whitespace. Same selected proof as A2. Retained premise and moments stay stable when the decomposition appears.],
)
#slide-design(
  title: [The posterior mean minimizes squared-error risk],
  section: [Linear Gaussian systems],
  teaching-move: [Read the decomposition as a decision rule and connect reconstruction and residual risk to Gaussian inference.],
  cards: (
    recall-card(label: "risk-recall", from: [Previous slide: conditional risk decomposition])[$R(a|y)=op("tr") V+norm(m-a)^2$],
    choice,
    gaussian,
  ),
  key-points: (key-points(label: "decision-point")[
    - The conditional mean minimizes model expected squared error.
    - The posterior covariance describes uncertainty that remains after the mean action is chosen.
  ],),
  layout: layout-stack(items: ("risk-recall", "choice", "gaussian"), key-points: "decision-point", dominant: "choice"),
  reveal: reveal-static(("risk-recall", "choice", "gaussian", "decision-point")),
  rationale: [The prior decomposition supports genuine subordinate recall. New operation: read its nonnegative displacement to decide the action; interpret Gaussian covariance trace as irreducible conditional model risk. This slide must do the action/uncertainty job, not repeat the identity alone. Design and Organization accepted a static complete final job after repeated Authoring reveal geometry shifts; simultaneous comparison preserves the connection, at the cost of a distinct Gaussian-entry attention cue.],
  constraints: [Normal course scale and hierarchy. Static complete state avoids shifting recalled identity/action while specialization appears. B3 adds a transition and reorientation to the identity; live-time effect remains unmeasured. No live/recorded or endpoint change.],
)
