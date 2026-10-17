#import "../../../design.typ": *

#set page(paper: "a4", margin: (x: 12mm, y: 8mm))
#set text(size: 8.8pt)
#set par(leading: 0.52em)
#set document(title: "L01-R01 — Gaussian conditional density: revised design")

// Instructor-directed revision, 2026-10-17. Reviewable proposal, not acceptance.
// One recording section; no section divider or section-summary slides.
// The instructor's recording rule explicitly overrides the general summary rule.
// Sequence: P0–P17 in the revised slide_organization.md. No speaker notes.
// Separate rows below are semantic groups; production calibrates generous spacing.
#let rows(..items) = stack(spacing: 0.7em, ..items.pos())

#section-design-notes(
  title: [L01-R01 — one continuous density proof],
  purpose: [Prove the conditional density used in the lecture from the supplied joint Gaussian density.],
  entry: [Block Gaussian notation, conditional mean/covariance and centered residual from the lecture; matrix algebra, strict positive definiteness, determinants, density normalization. The lecture's residual-independence proof is not a premise of this argument.],
  endpoint: [$ p(x_1|x_2)=cal(N)_(d_1)(x_1;mu_1+B(x_2-mu_2),S) $, identified by integrating and dividing a proved normalized joint-density product.],
  arc: [Orientation → identify the exponential and its coefficient → choose and justify the residual coordinates → eliminate the two covariance cross blocks → prove positivity and the inverse identity → calculate the two quadratic terms → split the exponential, determinant and dimension factors → integrate and divide → interpret observation dependence.],
  anchors: rows(
    [$ H=Sigma_22, quad B H=Sigma_12 $],
    [$ u=x_2-mu_2, quad r=x_1-mu_1-B u $],
    [$ Q=(x-mu)^T Sigma^(-1)(x-mu) $],
    [The map $T$ subtracts the predicted deviation. $D=T Sigma T^T$ is block diagonal in the residual/observed coordinates. $C$ is the coefficient before the density's exponential.],
  ),
  summary-brief: [No summary slide: explicit instructor recording convention. P17 interprets the established mean and covariance as its own teaching move.],
  continuity: [Inspected rendered L01 handout p.48: conditional formula beside a labeled mean proof; the zero-covariance step retains its joint-Gaussian warrant. Inspected squared-loss proof source: carried-forward expansion, local operation “Take conditional expectation”, separately labeled cross-term and residual energy, interpretation in a lower key-point slot. Here, preserve operations and warrants beside equations and give useful meaning in every reveal state.],
  constraints: [All 18 units require production rebuild. Object kinds describe semantics: they do not require bordered production cards around every proof step. Prefer plain mathematical regions with nearby operation labels; reserve borders for a genuine orientation/comparison or key-point role. In production use math-rows only for standalone equations, never prose containing inline mathematics; prose must keep its inline symbols within the sentence. Pass raw interpretation content to content-block key-points, which already supplies its wrapper. P0 preserves the instructor's L01-R01 number and exact subtitle. No notebook or live-proof relocation. Keep full SPD, inverse, quadratic, determinant/dimension and integral/ratio arguments. No unexplained “normalizer”, “proof obligation”, or “Prepared live”. Formula rows require generous vertical separation, including recall cards; do not pack them through markup line breaks or shrink them to preserve a count. Timing remains unmeasured. Exact source record: math_derivation.md, Murphy Book 2 (2023), online December 10, 2025, §2.3.1.5, pp.25–27; explicit elimination/SPD/normalization completion is course construction.],
)

#slide-design(
  title: [Quadratic separation of a Gaussian], section: [P0 · L01-R01],
  teaching-move: [Identify the recording and its concrete purpose.],
  cards: (card([A proof of the formula for the conditional density of a Gaussian], label: "subtitle"),),
  layout: layout-stack(items: ("subtitle",), dominant: "subtitle"),
  reveal: reveal-static(("subtitle",)),
  constraints: [Production title metadata number is L01-R01. Exact subtitle as written. No section title follows this slide.],
)

#slide-design(
  title: [From the lecture to this proof], section: [P1],
  teaching-move: [Recall the supplied model on the left, state the density result to justify on the right, and orient the proof.],
  cards: (
    recall-card(rows(
      [$ X=mat(X_1;X_2) tilde cal(N)_(d)(mu,Sigma) $],
      [$ mu=mat(mu_1;mu_2), quad Sigma=mat(Sigma_11,Sigma_12;Sigma_21,Sigma_22) $],
      [$ Sigma=Sigma^T succ 0, quad d=d_1+d_2 $],
    ), label: "lecture", title: [From the lecture], from: [L01: Gaussian blocks, conditioning and centered residual]),
    card(rows(
      [$ p(x_1|x_2)=cal(N)_(d_1)(x_1;m(x_2),S) $],
      [The mean $m(x_2)$ and covariance $S$ obtained in the lecture.],
      [Derive this complete density from $p(x_1,x_2)$.],
    ), label: "goal", title: [To prove here]),
  ),
  key-points: (key-points(rows(
    [Fix the observed value $x_2$; the density describes the missing block $X_1$.],
    [We will account for the exponential and its coefficient, then identify the conditional by integration and division.],
  ), label: "kp"),),
  layout: layout-side(left: "lecture", right: "goal", key-points: "kp", dominant: "goal"),
  reveal: reveal-static(("lecture", "goal", "kp")),
  constraints: [Two orientation columns, then a distinct key-point region visible from the start. Each formula is a separate generously spaced row, especially in the supplied-model recall. $X_i,mu_i$ have dimension $d_i>=1$; covariance blocks match. Recalled conditional is a destination, never a proof premise.],
)

#slide-design(
  title: [The density contains an exponential and a coefficient], section: [P2],
  teaching-move: [Identify the exact quadratic and coefficient to transform, and explain what their transformations must achieve.],
  cards: (
    card([$ p(x_1,x_2)=C exp(-1/2 Q) $], label: "density", title: [Joint Gaussian density]),
    card(rows(
      [$ Q=(x-mu)^T Sigma^(-1)(x-mu) $],
      [Target: residual contribution + observed-deviation contribution.],
      [Residual: $x_1-m(x_2)$; observed deviation: $x_2-mu_2$.],
    ), label: "quadratic", title: [The quadratic in the exponent]),
    card(rows(
      [$ C=(2pi)^(-d/2)(det Sigma)^(-1/2) $],
      [Target: coefficient for the residual density × coefficient for the observed-block density.],
    ), label: "coefficient", title: [The factor before the exponential]),
  ),
  key-points: (key-points([Writing the exponential as a product will not establish the full density product until its coefficient also matches.], label: "kp"),),
  layout: design-layout([Joint-density equation above two adjacent targets: quadratic on the left, coefficient on the right. Distinct lower key-point slot.]),
  reveal: reveal-cumulative(initial: ("density", "quadratic", "kp"), then: (
    reveal-step(("coefficient",), purpose: [Identify the second part of the same density that must match.], emphasize: true),
  )),
  constraints: [“Residual” means deviation of $x_1$ from its observation-dependent conditional mean; “observed deviation” means $x_2-mu_2$. These labels precede the coordinate definitions on P4. Do not call either a “normalizer” or an “obligation”.],
)

#slide-design(
  title: [Choose B to remove the cross covariance], section: [P3],
  teaching-move: [Give the inverse a purpose: solve the cross-block cancellation equation, proving that the observed-block covariance permits its solution.],
  cards: (
    card(rows(
      [$ H:=Sigma_22 $],
      [$ Sigma_12-B H=0 quad <=> quad B H=Sigma_12 $],
    ), label: "target", title: [Subtract B times the observed deviation: cancel the cross block]),
    card(rows(
      [$ z in RR^(d_2) backslash {0} $],
      [$ z^T H z=mat(0;z)^T Sigma mat(0;z)>0 $],
      [$ H=H^T succ 0 quad => quad H^(-1) " exists" $],
    ), label: "positive", title: [Joint strict positivity applies to observed-block vectors]),
    card([$ B=Sigma_12 H^(-1), quad H B^T=Sigma_21 $], label: "solution", title: [Solve the cancellation equation; transpose it]),
  ),
  key-points: (
    key-points([Cancel the covariance cross blocks so its inverse acts separately on residual and observed coordinates. This will give the two terms in $Q$.], label: "meaning"),
    key-points([Strict positivity makes this choice well defined. It is the coefficient already used for the conditional mean in the lecture.], label: "result"),
  ),
  layout: design-layout([Cancellation target first, then adjacent proof regions: positivity test on the left, solved coefficient on the right. The two regions share a baseline and sufficient space for the full test-vector calculation. Plain equations and local operation labels, without a separate bordered card for every substep. Meaning accompanies the opening; result accompanies the solution in the distinct key-point slot.]),
  reveal: reveal-cumulative(initial: ("target", "meaning"), then: (
    reveal-step(("positive",), purpose: [Justify the inverse needed to solve this equation.], emphasize: true),
    reveal-step(("solution", "result"), purpose: [Right-multiply by the justified inverse; use symmetry of H inverse and Sigma21=Sigma12 transpose.], emphasize: true),
  )),
  constraints: [The cancellation target is displayed before the positivity calculation. $B$ has size $d_1 times d_2$. Do not introduce $S$ or its inverse here.],
)

#slide-design(
  title: [Subtracting the predicted deviation produces the residual], section: [P4],
  teaching-move: [Make the coordinate change intelligible before using it to transform the covariance.],
  cards: (
    card(rows(
      [$ u:=x_2-mu_2 $],
      [$ m(x_2):=mu_1+B u, quad r:=x_1-m(x_2) $],
    ), label: "coordinates", title: [Observed deviation and centered residual]),
    card(rows(
      [$ T:=mat(I_(d_1),-B;0,I_(d_2)) $],
      [$ T(x-mu)=mat(I,-B;0,I)mat(x_1-mu_1;u)=mat(r;u) $],
    ), label: "map", title: [Apply the subtraction while retaining the observed deviation]),
    card([$ Q = r^T S^(-1)r + u^T H^(-1)u $], label: "target", title: [To show: the residual and observed contributions]),
  ),
  key-points: (key-points([The first new coordinate is error around the predicted mean; the second is the observed deviation. These are the two contributions sought in the exponent.], label: "kp"),),
  layout: layout-stack(items: ("coordinates", "map", "target"), key-points: "kp", dominant: "map"),
  reveal: reveal-cumulative(initial: ("coordinates", "kp"), then: (
    reveal-step(("map", "target"), purpose: [Represent the meaningful subtraction as a block matrix operation and write the exact quadratic target.], emphasize: true),
  )),
  constraints: [Use the names residual and observed deviation adjacent to their definitions. Identity and zero block dimensions follow d1,d2 and may subsequently omit subscripts. No independence claim. $S$ in the target denotes the residual covariance recalled on P1; its formula is obtained on P6 and its positivity is proved on P8. The target is not a premise.],
)

#slide-design(
  title: [The coordinate change is reversible], section: [P5],
  teaching-move: [Verify the inverse of this specific coordinate change and explain why retaining the observation loses no information.],
  cards: (
    recall-card([$ T=mat(I,-B;0,I), quad T(x-mu)=mat(r;u) $], label: "recall", from: [P4: residual coordinates]),
    card([$ U:=mat(I,B;0,I), quad U mat(r;u)=mat(r+B u;u)=x-mu $], label: "undo", title: [Add the predicted deviation back]),
    card(rows(
      [$ T U=mat(I,B-B;0,I)=I $],
      [$ U T=mat(I,-B+B;0,I)=I quad => quad T^(-1)=U $],
    ), label: "check", title: [Check both matrix products]),
  ),
  key-points: (key-points([The residual together with the observation determines the original centered vector. This invertibility will preserve strict positivity and let us recover the inverse covariance.], label: "kp"),),
  layout: layout-stack(items: ("recall", "undo", "check"), key-points: "kp", dominant: "undo"),
  reveal: reveal-cumulative(initial: ("recall", "undo", "kp"), then: (
    reveal-step(("check",), purpose: [Verify that adding back the predicted deviation is the two-sided inverse.], emphasize: true),
  )),
)

#slide-design(
  title: [Subtract the observed rows to cancel the upper-right block], section: [P6],
  teaching-move: [Work the first elimination and identify the remaining first-block covariance expression.],
  cards: (
    recall-card([$ Sigma=mat(Sigma_11,B H;H B^T,H), quad T=mat(I,-B;0,I) $], label: "recall", from: [P3: B H=Sigma12; P4: T]),
    card(rows(
      [$ T Sigma=mat(I,-B;0,I)mat(Sigma_11,B H;H B^T,H) $],
      [$ =mat(Sigma_11-B H B^T,B H-B H;H B^T,H) $],
    ), label: "multiply", title: [First block row minus B times the second]),
    card(rows(
      [$ S:=Sigma_11-B H B^T=Sigma_11-Sigma_12 H^(-1)Sigma_21 $],
      [$ T Sigma=mat(S,0;H B^T,H) $],
    ), label: "result", title: [Name the remaining first block]),
  ),
  key-points: (key-points([The chosen $B$ cancels the upper-right block exactly. The lower-left block remains because only the row operation has been applied.], label: "kp"),),
  layout: layout-stack(items: ("recall", "multiply", "result"), key-points: "kp", dominant: "multiply"),
  reveal: reveal-cumulative(initial: ("recall", "kp"), then: (
    reveal-step(("multiply",), purpose: [Work the targeted cross-block cancellation without hiding the other blocks.], emphasize: true),
    reveal-step(("result",), purpose: [Recognize the Schur-complement expression obtained in the lecture.], emphasize: true),
  )),
  constraints: [S is defined here by the actual product; its strict positivity is not yet established. Keep all four product blocks visible long enough to check.],
)

#slide-design(
  title: [The matching column operation cancels the lower-left block], section: [P7],
  teaching-move: [Finish the two-sided covariance transformation and exhibit the separate residual/observed covariance blocks.],
  cards: (
    recall-card([$ T Sigma=mat(S,0;H B^T,H), quad T^T=mat(I,0;-B^T,I) $], label: "recall", from: [P6 and transpose of T]),
    card(rows(
      [$ T Sigma T^T=mat(S,0;H B^T,H)mat(I,0;-B^T,I) $],
      [$ =mat(S,0;H B^T-H B^T,H) $],
    ), label: "multiply", title: [Apply the same coordinate change to covariance columns]),
    card([$ D:=T Sigma T^T=mat(S,0;0,H) $], label: "diagonal", title: [Residual block S; observed block H]),
  ),
  key-points: (key-points([The row and column operations together give the covariance in the residual/observation coordinates. Its off-diagonal blocks are zero; its inverse will produce the two quadratic terms.], label: "kp"),),
  layout: layout-stack(items: ("recall", "multiply", "diagonal"), key-points: "kp", dominant: "diagonal"),
  reveal: reveal-cumulative(initial: ("recall", "kp"), then: (
    reveal-step(("multiply",), purpose: [Show exactly where the remaining cross block cancels.], emphasize: true),
    reveal-step(("diagonal",), purpose: [Name the block diagonal result used in the exponent and determinant calculations.], emphasize: true),
  )),
  constraints: [This is a congruence TΣT transpose. No similarity-transformation or independence detour; the proof uses the displayed matrix identity.],
)

#slide-design(
  title: [The remaining residual block is positive definite], section: [P8],
  teaching-move: [Justify S as a valid nonsingular covariance and justify all subsequent inverse and square-root operations.],
  cards: (
    recall-card([$ D=T Sigma T^T=mat(S,0;0,H), quad Sigma succ 0, quad T " invertible" $], label: "recall", from: [P5 and P7]),
    card(rows(
      [$ w != 0 quad => quad T^T w != 0 $],
      [$ w^T D w=(T^T w)^T Sigma(T^T w)>0 $],
    ), label: "positiveD", title: [Invertibility keeps a nonzero test vector nonzero]),
    card(rows(
      [$ a in RR^(d_1) backslash {0}, quad w=mat(a;0) $],
      [$ a^T S a=w^T D w>0 quad => quad S=S^T succ 0 $],
    ), label: "positiveS", title: [Restrict the test to the residual block]),
  ),
  key-points: (key-points([The supplied joint strict positivity survives the reversible coordinate change. Both $S$ and $H$ therefore have inverses and positive determinants, as the Gaussian density requires.], label: "kp"),),
  layout: layout-stack(items: ("recall", "positiveD", "positiveS"), key-points: "kp", dominant: "positiveS"),
  reveal: reveal-cumulative(initial: ("recall", "kp"), then: (
    reveal-step(("positiveD",), purpose: [Apply joint strict positivity to the transformed test vector.], emphasize: true),
    reveal-step(("positiveS",), purpose: [A vector supported on the first block isolates S.], emphasize: true),
  )),
)

#slide-design(
  title: [Invert the covariance identity to reach the exponent], section: [P9],
  teaching-move: [Connect the transformed covariance to the inverse covariance actually appearing in Q, with exact operation order.],
  cards: (
    recall-card(rows(
      [$ Q=(x-mu)^T Sigma^(-1)(x-mu) $],
      [$ D=T Sigma T^T=mat(S,0;0,H) $],
    ), label: "recall", from: [P2: exponent; P7–P8: valid block covariance]),
    card(rows(
      [$ D^(-1)=T^(-T) Sigma^(-1) T^(-1) $],
      [$ T^(-T):=(T^(-1))^T $],
    ), label: "invert", title: [Invert the product: reverse its factors]),
    card(rows(
      [$ T^T D^(-1)T=Sigma^(-1) $],
      [$ Sigma^(-1)=T^T mat(S^(-1),0;0,H^(-1))T $],
    ), label: "isolate", title: [Multiply on the left by T transpose and on the right by T]),
  ),
  key-points: (key-points([We need the inverse covariance in the exponent. This identity places $T$ next to each centered vector, so the residual coordinates can be substituted directly.], label: "kp"),),
  layout: layout-stack(items: ("recall", "invert", "isolate"), key-points: "kp", dominant: "isolate"),
  reveal: reveal-cumulative(initial: ("recall", "kp"), then: (
    reveal-step(("invert",), purpose: [Use the already justified inverses; do not commute factors.], emphasize: true),
    reveal-step(("isolate",), purpose: [Cancel adjacent inverse pairs to obtain the expression needed in Q.], emphasize: true),
  )),
  constraints: [Keep operation labels next to their equalities. This is algebraic inverse notation; no numerical inverse algorithm is introduced.],
)

#slide-design(
  title: [The joint quadratic becomes a residual term plus an observed term], section: [P10],
  teaching-move: [Perform the promised quadratic split with explicit substitutions and labeled final terms.],
  cards: (
    recall-card([$ Sigma^(-1)=T^T D^(-1)T, quad T(x-mu)=mat(r;u) $], label: "recall", from: [P4 and P9]),
    card(rows(
      [$ Q=(x-mu)^T Sigma^(-1)(x-mu)=[T(x-mu)]^T D^(-1)[T(x-mu)] $],
      [$ =mat(r;u)^T mat(S^(-1),0;0,H^(-1))mat(r;u) $],
    ), label: "substitute", title: [Substitute the inverse; then the residual coordinates]),
    card([$ Q=underbrace(r^T S^(-1)r,"residual term")+underbrace(u^T H^(-1)u,"observed term") $], label: "split", title: [Multiply the diagonal blocks]),
  ),
  key-points: (key-points([At fixed $x_2$, $u$ is fixed and $r=x_1-m(x_2)$ varies with $x_1$. The exponent now has precisely a residual contribution and an observed-deviation contribution.], label: "kp"),),
  layout: design-layout([Subordinate recall strip keeps both anchors together. Below it, one wide plain proof region contains the whole inverse-substitution equality, the diagonal block multiplication, and the labeled final split as generously separated rows. Keep local operation labels adjacent, with no per-row bordered wrappers. Interpretation is a separate lower region.]),
  reveal: reveal-cumulative(initial: ("recall", "kp"), then: (
    reveal-step(("substitute",), purpose: [Each T acts on the centered vector beside it; retain the whole equality.], emphasize: true),
    reveal-step(("split",), purpose: [The zero off-diagonal inverse blocks remove mixed terms.], emphasize: true),
  )),
  constraints: [Keep the first equality whole and use labels adjacent to the two final terms. Do not yet identify a normalized conditional from the exponent alone.],
)

#slide-design(
  title: [A sum in the exponent becomes a product], section: [P11],
  teaching-move: [Show exactly how the quadratic split transforms the joint density and identify the remaining coefficient calculation.],
  cards: (
    recall-card([$ Q=r^T S^(-1)r+u^T H^(-1)u $], label: "recall", from: [P10]),
    card(rows(
      [$ exp(-1/2 Q)=exp(-1/2 r^T S^(-1)r) exp(-1/2 u^T H^(-1)u) $],
      [$ p(x_1,x_2)=C exp(-1/2 r^T S^(-1)r) exp(-1/2 u^T H^(-1)u) $],
    ), label: "product", title: [Use exp(a+b)=exp(a)exp(b)]),
    card([$ C=(2pi)^(-d/2)(det Sigma)^(-1/2) $], label: "coefficient", title: [The coefficient is still the joint-density coefficient]),
  ),
  key-points: (key-points([The two exponentials have the required shapes. To make them two complete Gaussian densities, $C$ must supply the coefficient belonging to each dimension and covariance.], label: "kp"),),
  layout: layout-stack(items: ("recall", "product", "coefficient"), key-points: "kp", dominant: "product"),
  reveal: reveal-cumulative(initial: ("recall", "kp"), then: (
    reveal-step(("product", "coefficient"), purpose: [Apply the elementary exponential identity while visibly retaining C.], emphasize: true),
  )),
)

#slide-design(
  title: [The same elimination gives the determinant product], section: [P12],
  teaching-move: [Use the same block transformation to calculate the determinant appearing in the remaining coefficient.],
  cards: (
    recall-card([$ D=T Sigma T^T=mat(S,0;0,H), quad T=mat(I,-B;0,I) $], label: "recall", from: [P4 and P7]),
    card(rows(
      [$ det T=det I_(d_1) det I_(d_2)=1 $],
      [$ det D=det T det Sigma det T^T=det Sigma $],
    ), label: "triangular", title: [T is block triangular; determinants multiply]),
    card([$ det D=det S det H quad => quad det Sigma=det S det H $], label: "product", title: [D is block diagonal]),
  ),
  key-points: (key-points([The coefficient contains $(det Sigma)^(-1/2)$. This identity replaces it by the determinant factors for the residual and observed blocks.], label: "kp"),),
  layout: layout-stack(items: ("recall", "triangular", "product"), key-points: "kp", dominant: "product"),
  reveal: reveal-cumulative(initial: ("recall", "kp"), then: (
    reveal-step(("triangular",), purpose: [Unit determinant means the elimination does not change det Sigma.], emphasize: true),
    reveal-step(("product",), purpose: [Read the determinant of the block diagonal result.], emphasize: true),
  )),
  constraints: [All determinants are positive by the already proved strict positivity. This is the coefficient calculation promised on P2/P11, not an isolated matrix lemma.],
)

#slide-design(
  title: [The factors before the exponentials split too], section: [P13],
  teaching-move: [Account for both determinant and dimension factors in the full coefficient.],
  cards: (
    recall-card([$ d=d_1+d_2, quad det Sigma=det S det H, quad S,H succ 0 $], label: "recall", from: [P1, P8 and P12]),
    card(rows(
      [$ (2pi)^(-d/2)=(2pi)^(-d_1/2)(2pi)^(-d_2/2) $],
      [$ (det Sigma)^(-1/2)=(det S)^(-1/2)(det H)^(-1/2) $],
    ), label: "split", title: [Add the dimensions; use positive determinant square roots]),
    card(rows(
      [$ C=C_1 C_2 $],
      [$ C_1:=(2pi)^(-d_1/2)(det S)^(-1/2) $],
      [$ C_2:=(2pi)^(-d_2/2)(det H)^(-1/2) $],
    ), label: "coefficients", title: [Group each covariance with its matching dimension]),
  ),
  key-points: (key-points([The residual exponential receives $C_1$, the coefficient for dimension $d_1$ and covariance $S$. The observed exponential receives $C_2$, for dimension $d_2$ and covariance $H$.], label: "kp"),),
  layout: layout-stack(items: ("recall", "split", "coefficients"), key-points: "kp", dominant: "coefficients"),
  reveal: reveal-cumulative(initial: ("recall", "kp"), then: (
    reveal-step(("split",), purpose: [Expose both pieces of the coefficient; positivity justifies the square-root identity.], emphasize: true),
    reveal-step(("coefficients",), purpose: [Pair dimension and covariance before reassembling densities.], emphasize: true),
  )),
)

#slide-design(
  title: [Reassemble the complete Gaussian densities], section: [P14],
  teaching-move: [Pair each coefficient with its exponential and establish exact normalized factorization before naming probability laws.],
  cards: (
    card(rows(
      [$ g_(1)(x_1;x_2):=C_1 exp(-1/2 r^T S^(-1)r) $],
      [$ =cal(N)_(d_1)(x_1;m(x_2),S) $],
      [$ m(x_2)=mu_1+B(x_2-mu_2), quad r=x_1-m(x_2) $],
    ), label: "factor1", title: [Gaussian density in x1 for fixed x2]),
    card(rows(
      [$ g_(2)(x_2):=C_2 exp(-1/2 u^T H^(-1)u) $],
      [$ =cal(N)_(d_2)(x_2;mu_2,H), quad u=x_2-mu_2 $],
    ), label: "factor2", title: [Gaussian density in the observed block]),
    card([$ p(x_1,x_2)=g_(1)(x_1;x_2)g_(2)(x_2) $], label: "product", title: [The exponential and coefficient products both match]),
  ),
  key-points: (key-points([These are complete Gaussian densities because their coefficients and positive definite covariances match their dimensions. Integration and division will identify which factor is the marginal and which is the conditional.], label: "kp"),),
  layout: design-layout([Adjacent Gaussian-factor regions, each with its own coefficient/exponent pairing, on a common baseline. First factor in x1 on the left; observed-block factor on the right. Product equality below both. No extra bordered wrapper around every formula. Keep lower interpretation separate and keep its prose in normal paragraphs. C1 and C2 may be expanded instead of abbreviated if readable; their definitions from P13 must remain available.]),
  reveal: reveal-cumulative(initial: ("factor1", "kp"), then: (
    reveal-step(("factor2",), purpose: [Match the observed-block coefficient and exponential.], emphasize: true),
    reveal-step(("product",), purpose: [Combine P11 exponential equality with P13 coefficient equality.], emphasize: true),
  )),
  constraints: [No proportionality sign. Retain x2 dependence in g1. The two factors are not yet named conditional/marginal. If C1/C2 are expanded, retain matching d1,S versus d2,H.],
)

#slide-design(
  title: [Integrate over x1 to identify the marginal], section: [P15],
  teaching-move: [Use Gaussian normalization in the missing block to identify g2 as the observed marginal.],
  cards: (
    recall-card([$ p(x_1,x_2)=g_(1)(x_1;x_2)g_(2)(x_2) $], label: "recall", from: [P14]),
    card(rows(
      [$ x_2 " fixed", quad m(x_2) " fixed", quad S succ 0 $],
      [$ integral_(RR^(d_1))g_(1)(x_1;x_2) dif x_1=1 $],
    ), label: "normalization", title: [Integrate the Gaussian density in x1]),
    card(rows(
      [$ p(x_2)=integral_(RR^(d_1))p(x_1,x_2) dif x_1 $],
      [$ =g_(2)(x_2) integral_(RR^(d_1))g_(1)(x_1;x_2) dif x_1=g_(2)(x_2) $],
      [$ p(x_2)=cal(N)_(d_2)(x_2;mu_2,H) $],
    ), label: "marginal", title: [g2 is constant with respect to x1]),
  ),
  key-points: (key-points([For each fixed observation, the first factor integrates to one. Marginalizing the joint therefore leaves exactly the second factor.], label: "kp"),),
  layout: layout-stack(items: ("recall", "normalization", "marginal"), key-points: "kp", dominant: "marginal"),
  reveal: reveal-cumulative(initial: ("recall", "normalization", "kp"), then: (
    reveal-step(("marginal",), purpose: [Apply the marginal-density definition and move the x1-constant factor outside the integral.], emphasize: true),
  )),
  constraints: [Keep the domain, integration variable and fixed observation visible. Normalization of a Gaussian density is prior knowledge; no Jacobian proof is needed.],
)

#slide-design(
  title: [Divide by the marginal to obtain the conditional density], section: [P16],
  teaching-move: [Use the now-identified strictly positive marginal to obtain the conditional-density formula.],
  cards: (
    recall-card([$ p(x_2)=g_(2)(x_2)=cal(N)_(d_2)(x_2;mu_2,H)>0 $], label: "positive", from: [P15; H strictly positive definite]),
    card(rows(
      [$ p(x_1|x_2)=frac(p(x_1,x_2),p(x_2)) $],
      [$ =frac(g_(1)(x_1;x_2)g_(2)(x_2),g_(2)(x_2))=g_(1)(x_1;x_2) $],
    ), label: "divide", title: [Use the conditional-density ratio; cancel the positive factor]),
    card([$ p(x_1|x_2)=cal(N)_(d_1)(x_1;mu_1+B(x_2-mu_2),S) $], label: "law", title: [The Gaussian conditional density]),
  ),
  key-points: (key-points([The factor identified by division is already normalized in $x_1$. This establishes the complete conditional density for every observed value $x_2$.], label: "kp"),),
  layout: layout-stack(items: ("positive", "divide", "law"), key-points: "kp", dominant: "law"),
  reveal: reveal-cumulative(initial: ("positive", "kp"), then: (
    reveal-step(("divide",), purpose: [Identify the first factor from the joint and the independently established marginal.], emphasize: true),
    reveal-step(("law",), purpose: [Write the resulting law with the proved parameters.], emphasize: true),
  )),
  constraints: [Positivity is a density statement, not positive probability of a continuous singleton. This defines a conditional-density version everywhere; do not assert uniqueness at null events.],
)

#slide-design(
  title: [The observation can shift the conditional mean], section: [P17],
  teaching-move: [Interpret where observation dependence resides in the proved law, distinguishing original blocks from residual coordinates.],
  cards: (
    recall-card([$ p(x_1|x_2)=cal(N)_(d_1)(x_1;mu_1+B(x_2-mu_2),S) $], label: "law", from: [P16]),
    card(rows(
      [$ m(x_2)=mu_1+B(x_2-mu_2) $],
      [$ m(x_2+Delta)-m(x_2)=B Delta $],
      [$ Sigma_(1|2)=S=Sigma_11-Sigma_12 H^(-1)Sigma_21 $],
    ), label: "dependence", title: [A changed observation shifts the mean; the covariance stays S]),
  ),
  key-points: (key-points(rows(
    [The mean can change with $x_2$ through $B$; $S$ does not depend on the observed value.],
    [The residual $r=x_1-m(x_2)$ uses the observation. Writing its quadratic separately does not make the original $X_1$ and $X_2$ independent.],
    [The result is exact for the supplied Gaussian model with $Sigma succ 0$; it does not test that model against data.],
  ), label: "kp"),),
  layout: layout-stack(items: ("law", "dependence"), key-points: "kp", dominant: "dependence"),
  reveal: reveal-cumulative(initial: ("law", "kp"), then: (
    reveal-step(("dependence",), purpose: [Vary the observation in the proved mean formula while holding model parameters fixed.], emphasize: true),
  )),
  constraints: [Final slide is interpretation, not a disguised section summary. “Can change” includes B=0 and directions in its kernel. Delta has dimension d2. No new algorithm, singular extension, notebook handoff, or rehearsal claim.],
)
