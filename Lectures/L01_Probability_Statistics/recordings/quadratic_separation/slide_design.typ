#import "../../../design.typ": *

#set page(paper: "a4", margin: (x: 12mm, y: 8mm))
#set text(size: 8.8pt)
#set par(leading: 0.52em)

#set document(title: "Quadratic separation — provisional slide design")

// PROVISIONAL BUILD: instructor-authorized unattended package, 2026-10-17.
// Organization SHA256: 05beb9d595435ecfbb71240251491d801d3e7c55a488e5090c2940654e2d753f.
// Not instructor approval, production validation, or a measured recording duration.
// Provisional revision: R1.1/R2.1 mapped to title/subtitle section dividers after actual Authoring backpressure; no new mathematics or slide count/order changed.
// Fixed sequence: P0, R1.1–R1.11, R2.1–R2.8. No speaker notes.
// Covariance convention: cal(N)_k(v;m,C), with C a covariance, not a scale.

#section-design-notes(
  title: [Recording design contract — PROVISIONAL],
  purpose: [Explain the exact normalized conditional law for a missing block under a supplied joint Gaussian. This separate proof supplements the prepared live residual argument.],
  entry: [Live block notation, Gaussian density and centered-residual interpretation; prior matrix algebra, positive definiteness, determinants and integration. The live independence proof is never a premise here.],
  endpoint: [Prove the normalized equality and identify its factors by integration and a positive-density ratio.],
  arc: [P0 introduces the recording; R1 proves valid elimination and quadratic separation; R2 completes normalization and identifies the probability laws. Twenty slides in the supplied order.],
  anchors: [Use $H=Sigma_22$, $B=Sigma_12 H^(-1)$, $S=Sigma_11-B H B^T$, $u=x_2-mu_2$, $r=x_1-mu_1-B u$. Matrices retain their exact order.],
  summary-brief: [Each section closes with its established objects and retrospective takeaways. R2.8 closes the recording.],
  continuity: [Inspected live handout 48: dominant conditional formula with adjacent mean proof, intrinsic reasons and separate lower key points. Handout 52: conditional/residual objects retain explicit centering maps. Carry forward this hierarchy; new algebra receives normal proof emphasis, recalled items stay subordinate.],
  constraints: [All slide titles/count/order are provisional upstream commitments preserved here. No timing claim. No new dataset, notebook, live-deck edit or alternate proof. Final acceptance and rehearsal remain instructor/coordinator matters. Source: Murphy Book 2 (2023), online Dec. 10, 2025, §2.3.1.5, printed pp. 25–27; elimination, SPD and explicit normalization completion are course constructions. See math_derivation.md for exact provenance.],
)

#slide-design(
  title: [Quadratic separation of a Gaussian], section: [P0 · Recording title],
  teaching-move: [Locate this separate density proof after the prepared live Gaussian-conditioning argument.],
  cards: (card([A complete density proof of Gaussian conditioning.], label: "subtitle"),),
  key-points: (key-points([Under a supplied joint Gaussian, why is the missing-block conditional exactly normalized?], label: "task"),),
  layout: layout-stack(items: ("subtitle",), key-points: "task", dominant: "subtitle"),
  reveal: reveal-static(("subtitle", "task")),
  constraints: [A recording title, without a new result or practical-competence claim.],
)

#section-design-notes(
  title: [R1 — Block elimination separates the joint quadratic],
  purpose: [Derive a reversible covariance elimination and use its inverse congruence to separate the quadratic.],
  entry: [The supplied joint covariance is symmetric positive definite. The Gaussian density and live residual interpretation are available; the desired conditional is not a proof premise.],
  endpoint: [$ (x-mu)^T Sigma^(-1)(x-mu)=r^T S^(-1)r+u^T H^(-1)u $. Every inverse has been justified; normalized factorization is still unproved.],
  arc: [Density obligations → observed-block positivity → reversible elimination → two block products → residual positivity → inverse order → residual coordinates → split quadratic.],
  anchors: [$T=mat(I,-B;0,I)$; $D=T Sigma T^T=mat(S,0;0,H)$. Identity/zero blocks match $d_1,d_2$. Transposes and inverse order remain explicit.],
  summary-brief: [Select congruence, block positivity and the quadratic split. Omit the intermediate inverse display from the recap because it already received its own derivation.],
  continuity: [Recall cards cite actual live or earlier recording objects. Block cancellations and SPD/inverse arguments are newly taught proof objects. Local labels identify operations; interpretation occupies a separate key-point slot.],
  constraints: [R1.3 and R1.10 are relatively dense; maintain readable normal mathematics and all warrants. Authoring may rebalance subordinate context, but must return any requested title/count/order change.],
)

#slide-design(
  title: [Block elimination separates the joint quadratic], section: [R1.1],
  teaching-move: [Introduce the section purpose through its title and subtitle.],
  cards: (card([Proving the algebra behind Gaussian conditioning], label: "subtitle"),),
  layout: layout-stack(items: ("subtitle",), dominant: "subtitle"),
  reveal: reveal-static(("subtitle",)),
  rationale: [Production backpressure resolved provisionally: The former opening question and key point repeated the section objective and introduced no mathematical object. The exact title/subtitle preserves the section opening within its existing slide.],
  constraints: [Render this unit as the course section divider. The subtitle object is section metadata, not an extra content card or additional slide. Full title as above; subtitle: Proving the algebra behind Gaussian conditioning; abbreviated footer: Quadratic separation. No theorem answer or new argument is introduced here.],
)

#slide-design(
  title: [The joint density sets two proof obligations], section: [R1.2],
  teaching-move: [Recall the complete joint density and distinguish exponent from normalizer.],
  cards: (
    recall-card([$ X=mat(X_1;X_2), quad mu=mat(mu_1;mu_2), quad Sigma=mat(Sigma_11,Sigma_12;Sigma_21,Sigma_22)=Sigma^T succ 0 $\
$ X_i,mu_i in RR^(d_i), quad Sigma_(i j) in RR^(d_i times d_j), quad d=d_1+d_2, quad d_i >= 1 $], label: "model", title: [Supplied block Gaussian], from: [Prepared live: Gaussian blocks and density]),
    card([$ p(x_1,x_2)=cal(N)_(d)(x;mu,Sigma) $\
$ = underbrace((2 pi)^(-d/2)(det Sigma)^(-1/2), "normalizer") exp(-1/2 underbrace((x-mu)^T Sigma^(-1)(x-mu), "quadratic")) $], label: "density"),
  ),
  key-points: (key-points([Separating the quadratic is one obligation. The normalizer must split as well.], label: "kp"),),
  layout: layout-stack(items: ("model", "density", ), key-points: "kp", dominant: "density"),
  reveal: reveal-cumulative(initial: ("model", ), then: (
    reveal-step(("density", "kp", ), purpose: [Inspect the two load-bearing parts of the same density.], emphasize: false),
  )),
  constraints: [Use covariance-parameterized Gaussian notation throughout; do not introduce target conditional as an established identity.],
)

#slide-design(
  title: [Positive definiteness makes the observed block invertible], section: [R1.3],
  teaching-move: [Prove observed-block positivity, then define the elimination coefficients.],
  cards: (
    card([$ H:=Sigma_22, quad z in RR^(d_2) backslash {0} $\
$ z^T H z=mat(0;z)^T Sigma mat(0;z)>0 quad => quad H=H^T succ 0 $], label: "positive", title: [Nonzero observed-block test]),
    card([$ B:=Sigma_12 H^(-1) in RR^(d_1 times d_2), quad S:=Sigma_11-B H B^T=S^T $], label: "definitions", title: [Now the inverse exists]),
    card([$ B H=Sigma_12, quad H B^T=Sigma_21 $\
$ S=Sigma_11-Sigma_12 H^(-1)Sigma_21 $], label: "identities"),
  ),
  key-points: (key-points([$S$ is the live residual covariance (the Schur complement of $H$). Its strict positivity still needs proof here.], label: "kp"),),
  layout: layout-stack(items: ("positive", "definitions", "identities", ), key-points: "kp", dominant: "identities"),
  reveal: reveal-cumulative(initial: ("positive", ), then: (
    reveal-step(("definitions", ), purpose: [Define B and S only after proving H invertible.], emphasize: true),
    reveal-step(("identities", "kp", ), purpose: [Use symmetry of H inverse and Sigma21=Sigma12 transpose.], emphasize: false),
  )),
  constraints: [Intrinsic implication and symmetry warrant stay with the proof. Do not display S inverse yet.],
)

#slide-design(
  title: [The elimination matrix has an explicit inverse], section: [R1.4],
  teaching-move: [Verify reversibility by multiplication rather than importing a block-inverse lemma.],
  cards: (
    card([$ T:=mat(I_(d_1),-B;0,I_(d_2)), quad U:=mat(I_(d_1),B;0,I_(d_2)) $], label: "matrices"),
    card([$ T U=mat(I_(d_1),B-B;0,I_(d_2))=I_d $\
$ U T=mat(I_(d_1),-B+B;0,I_(d_2))=I_d quad => quad T^(-1)=U $], label: "products", title: [Multiply in both orders]),
  ),
  key-points: (key-points([Block elimination is reversible; no covariance or independence argument was used.], label: "kp"),),
  layout: layout-stack(items: ("matrices", "products", ), key-points: "kp", dominant: "products"),
  reveal: reveal-cumulative(initial: ("matrices", ), then: (
    reveal-step(("products", "kp", ), purpose: [Check the off-diagonal cancellation in both orders.], emphasize: true),
  )),
  constraints: [After this slide I and 0 may omit subscripts when block dimensions are fixed.],
)

#slide-design(
  title: [Left elimination removes the upper covariance block], section: [R1.5],
  teaching-move: [Work the first block multiplication, including its upper-right cancellation.],
  cards: (
    recall-card([$ B H=Sigma_12, quad H B^T=Sigma_21, quad S=Sigma_11-B H B^T $], label: "recall", from: [R1.3]),
    card([$ T Sigma=mat(I,-B;0,I) mat(Sigma_11,B H;H B^T,H) $\
$ =mat(Sigma_11-B H B^T,B H-B H;H B^T,H) $], label: "multiplication", title: [Left multiplication]),
    card([$ T Sigma=mat(S,0;H B^T,H) $], label: "result"),
  ),
  key-points: (key-points([The upper cross block vanishes. This single multiplication is not yet the covariance congruence.], label: "kp"),),
  layout: layout-stack(items: ("recall", "multiplication", "result", ), key-points: "kp", dominant: "result"),
  reveal: reveal-cumulative(initial: ("recall", ), then: (
    reveal-step(("multiplication", ), purpose: [Show all four product blocks; newly calculated cancellation gets entry emphasis.], emphasize: true),
    reveal-step(("result", "kp", ), purpose: [Identify S without suppressing the remaining lower cross block.], emphasize: false),
  )),
  constraints: [Final complete state preserves multiplication and result; no independence language.],
)

#slide-design(
  title: [Right elimination completes the covariance congruence], section: [R1.6],
  teaching-move: [Carry the preceding product forward and cancel its lower cross block.],
  cards: (
    recall-card([$ T Sigma=mat(S,0;H B^T,H), quad T^T=mat(I,0;-B^T,I) $], label: "recall", from: [R1.5 and transpose of R1.4]),
    card([$ T Sigma T^T=mat(S,0;H B^T,H) mat(I,0;-B^T,I) $\
$ =mat(S,0;H B^T-H B^T,H) $], label: "product", title: [Right multiplication]),
    card([$ D:=T Sigma T^T=mat(S,0;0,H) $], label: "diagonal"),
  ),
  key-points: (key-points([The two multiplications form a congruence: $T Sigma T^T$. They do not form a similarity transformation.], label: "kp"),),
  layout: layout-stack(items: ("recall", "product", "diagonal", ), key-points: "kp", dominant: "diagonal"),
  reveal: reveal-cumulative(initial: ("recall", ), then: (
    reveal-step(("product", ), purpose: [Students can compare the inherited lower block with its cancellation.], emphasize: true),
    reveal-step(("diagonal", "kp", ), purpose: [Name the diagonal covariance object D.], emphasize: false),
  )),
  summary-candidates: (
    summary-visual-candidate("diagonal", reason: [Central covariance anchor for the retrospective.]),
  ),
)

#slide-design(
  title: [Invertible congruence proves the residual covariance positive definite], section: [R1.7],
  teaching-move: [Prove D positive definite, then restrict its quadratic to the first block.],
  cards: (
    recall-card([$ D=T Sigma T^T=mat(S,0;0,H), quad T " invertible", quad Sigma succ 0 $], label: "recall", from: [R1.4 and R1.6]),
    card([$ w != 0 quad => quad T^T w != 0 $\
$ w^T D w=(T^T w)^T Sigma(T^T w)>0 quad => quad D succ 0 $], label: "congruence", title: [Every nonzero test vector]),
    card([$ a in RR^(d_1) backslash {0}, quad w=mat(a;0) $\
$ a^T S a=w^T D w>0 quad => quad S succ 0 $], label: "restriction", title: [Test the first block]),
  ),
  key-points: (key-points([Both $S$ and $H$ have inverses and positive determinants. This follows from strict joint positivity.], label: "kp"),),
  layout: layout-stack(items: ("recall", "congruence", "restriction", ), key-points: "kp", dominant: "restriction"),
  reveal: reveal-cumulative(initial: ("recall", ), then: (
    reveal-step(("congruence", ), purpose: [Invertibility prevents a nonzero vector from becoming zero.], emphasize: true),
    reveal-step(("restriction", "kp", ), purpose: [The first diagonal block inherits strict positivity.], emphasize: true),
  )),
  summary-candidates: (
    summary-visual-candidate("restriction", reason: [Explains why the residual inverse and normalizer are valid.]),
  ),
)

#slide-design(
  title: [Inverting the congruence fixes the order of the factors], section: [R1.8],
  teaching-move: [Derive the inverse identity in its exact matrix order.],
  cards: (
    recall-card([$ D=T Sigma T^T=mat(S,0;0,H) $], label: "recall", from: [R1.6; inverses justified in R1.7]),
    card([$ D^(-1)=T^(-T) Sigma^(-1) T^(-1), quad T^(-T):=(T^(-1))^T $], label: "invert", title: [Invert the product]),
    card([$ T^T D^(-1)T=Sigma^(-1) $\
$ Sigma^(-1)=T^T mat(S^(-1),0;0,H^(-1))T $], label: "isolate", title: [Multiply on the left by T transpose and on the right by T]),
  ),
  key-points: (key-points([The factors do not commute. The order follows from undoing the congruence.], label: "kp"),),
  layout: layout-stack(items: ("recall", "invert", "isolate", ), key-points: "kp", dominant: "isolate"),
  reveal: reveal-cumulative(initial: ("recall", ), then: (
    reveal-step(("invert", ), purpose: [Reverse the factor order when inverting.], emphasize: true),
    reveal-step(("isolate", "kp", ), purpose: [Cancel only adjacent inverse pairs.], emphasize: true),
  )),
  constraints: [Preserve covariance congruence alongside inverse proof. Expanded block inverse is checking material only.],
)

#slide-design(
  title: [Elimination turns the centered vector into a residual and an observation], section: [R1.9],
  teaching-move: [Work the coordinate transformation and identify both blocks.],
  cards: (
    card([$ u:=x_2-mu_2, quad r:=x_1-mu_1-B u $], label: "coordinates", title: [Centered coordinates]),
    card([$ T(x-mu)=mat(I,-B;0,I)mat(x_1-mu_1;u) $\
$ =mat(x_1-mu_1-B u;u)=mat(r;u) $], label: "transform"),
  ),
  key-points: (key-points([$r$ is the centered residual. Its coordinates contain $x_2$; the original first block is still $x_1$.], label: "kp"),),
  layout: layout-stack(items: ("coordinates", "transform", ), key-points: "kp", dominant: "transform"),
  reveal: reveal-cumulative(initial: ("coordinates", ), then: (
    reveal-step(("transform", "kp", ), purpose: [Elimination subtracts the predicted deviation while retaining the observation.], emphasize: true),
  )),
  constraints: [No independence statement is needed for this coordinate identity.],
)

#slide-design(
  title: [The joint quadratic is the sum of two block quadratics], section: [R1.10],
  teaching-move: [Substitute the proved inverse and transformed vector into the quadratic.],
  cards: (
    recall-card([$ Sigma^(-1)=T^T D^(-1)T, quad T(x-mu)=mat(r;u) $\
$ D^(-1)=mat(S^(-1),0;0,H^(-1)) $], label: "recall", from: [R1.8 and R1.9]),
    card([$ (x-mu)^T Sigma^(-1)(x-mu)=[T(x-mu)]^T D^(-1)[T(x-mu)] $\
$ =mat(r;u)^T mat(S^(-1),0;0,H^(-1)) mat(r;u) $], label: "substitute", title: [Substitute without changing factor order]),
    card([$ (x-mu)^T Sigma^(-1)(x-mu)=r^T S^(-1)r+u^T H^(-1)u $], label: "split"),
  ),
  key-points: (key-points([The exponent separates exactly. A normalized density equality has not yet been proved.], label: "kp"),),
  layout: layout-stack(items: ("recall", "substitute", "split", ), key-points: "kp", dominant: "split"),
  reveal: reveal-cumulative(initial: ("recall", ), then: (
    reveal-step(("substitute", ), purpose: [Read the substitution as one whole equality, then the block product.], emphasize: true),
    reveal-step(("split", "kp", ), purpose: [Diagonal inverse gives the sum of two quadratic forms.], emphasize: true),
  )),
  summary-candidates: (
    summary-visual-candidate("split", reason: [Section endpoint: split quadratic in residual/observed coordinates.]),
  ),
  constraints: [The inverse notation is algebra, not a recommendation to form numerical inverses. Keep the first equality syntactically whole.],
)

#slide-design(
  title: [Retrospective: elimination separates the quadratic], section: [R1.11],
  teaching-move: [Retell the established algebraic argument, ending the section retrospectively.],
  cards: (
    section-summary-visual([$ T Sigma T^T=mat(S,0;0,H), quad H succ 0, quad S succ 0 $\
$ (x-mu)^T Sigma^(-1)(x-mu)=r^T S^(-1)r+u^T H^(-1)u $\
$ u=x_2-mu_2, quad r=x_1-mu_1-B u $], label: "summary"),
  ),
  key-points: (section-summary-takeaways([Reversible elimination yields valid residual and observed covariance blocks. The inverse congruence separates their quadratic contributions.], label: "kp"),),
  layout: layout-summary(visual: "summary", takeaways: "kp"),
  reveal: reveal-static(("summary", "kp", )),
  rationale: [Select congruence + positivity + final quadratic; the intermediate inverse formula is deliberately omitted to keep the recap recognizable and readable.],
  constraints: [Retrospective end: no next-section teaser, question or handoff.],
)

#section-design-notes(
  title: [R2 — Normalizers identify the conditional and marginal densities],
  purpose: [Complete the normalized density equality and identify the factors without importing the target law.],
  entry: [R1 proved the quadratic split and $H,S succ 0$. The determinant and dimension factors in the joint density remain to be separated.],
  endpoint: [$ p(x_1,x_2)=p(x_1|x_2)p(x_2) $ with the two Gaussian laws established by integration and division.],
  arc: [Unit-determinant elimination → determinant split → dimension split → full Gaussian factors → integrate → divide → interpret dependence.],
  anchors: [Retain $r,u,S,H,B$ and $D=T Sigma T^T$. Introduce $g_(1)(x_1;x_2)$ and $g_(2)(x_2)$ as normalized mathematical factors before assigning probability-law names.],
  summary-brief: [Select normalized product, its parameter labels and the integration/ratio identification. The takeaway recalls that quadratic, determinant and dimension factors all split; do not repeat every algebraic display.],
  continuity: [R2.1 receives R1's quadratic split. Normalizers remain next to their matching exponent/dimension. Prose explaining what the factorization establishes stays in the key-point slot.],
  constraints: [R2.4 full factors and R2.5 integral are load-bearing. Do not replace equality with proportionality or remove normalizers to fit. Production may choose stack versus adjacent factor regions if semantic pairing and readability survive; count/order repair returns to Organization.],
)

#slide-design(
  title: [Normalizers identify the conditional and marginal densities], section: [R2.1],
  teaching-move: [Receive the established exponent split through the section subtitle and frame normalization as the remaining proof job.],
  cards: (card([From separated exponents to probability laws], label: "subtitle"),),
  layout: layout-stack(items: ("subtitle",), dominant: "subtitle"),
  reveal: reveal-static(("subtitle",)),
  rationale: [Production backpressure resolved provisionally: The former quadratic/SPD recall repeats R1.7, R1.10 and the immediately preceding R1.11 retrospective; no new mathematical claim is omitted. The exact title/subtitle preserves the section opening within its existing slide.],
  constraints: [Render this unit as the course section divider. The subtitle object is section metadata, not an extra content card or additional slide. Full title as above; subtitle: From separated exponents to probability laws; abbreviated footer: Normalized factorization. No theorem answer or new argument is introduced here.],
)

#slide-design(
  title: [Unit-determinant elimination splits the covariance determinant], section: [R2.2],
  teaching-move: [Use the established congruence and block triangular determinant.],
  cards: (
    recall-card([$ T=mat(I,-B;0,I), quad D=T Sigma T^T=mat(S,0;0,H) $], label: "recall", from: [R1.4 and R1.6]),
    card([$ det T=det I_(d_1) det I_(d_2)=1 $], label: "unit", title: [Block triangular T]),
    card([$ det D=(det T)(det Sigma)(det T^T)=det Sigma $\
$ det Sigma=det S det H, quad det Sigma,det S,det H>0 $], label: "determinants", title: [Take determinants of the congruence]),
  ),
  key-points: (key-points([Elimination changes the covariance blocks while preserving this determinant. Positivity licenses positive square roots.], label: "kp"),),
  layout: layout-stack(items: ("recall", "unit", "determinants", ), key-points: "kp", dominant: "determinants"),
  reveal: reveal-cumulative(initial: ("recall", ), then: (
    reveal-step(("unit", ), purpose: [The identity diagonal blocks make the determinant one.], emphasize: true),
    reveal-step(("determinants", "kp", ), purpose: [Combine multiplicativity with the block diagonal determinant.], emphasize: true),
  )),
  summary-candidates: (
    summary-visual-candidate("determinants", reason: [The determinant obligation is discharged.]),
  ),
)

#slide-design(
  title: [The dimensions split the remaining Gaussian normalizer], section: [R2.3],
  teaching-move: [Keep determinant and dimension factors visible in the same exact identity.],
  cards: (
    recall-card([$ d=d_1+d_2, quad det Sigma=det S det H, quad S,H succ 0 $], label: "recall", from: [R1.2, R1.7 and R2.2]),
    card([$ (2 pi)^(-d/2)(det Sigma)^(-1/2) $\
$ =(2 pi)^(-(d_1+d_2)/2)(det S det H)^(-1/2) $], label: "substitution", title: [Substitute both identities]),
    card([$ (2 pi)^(-d/2)(det Sigma)^(-1/2) $\
$ =[(2 pi)^(-d_1/2)(det S)^(-1/2)] [(2 pi)^(-d_2/2)(det H)^(-1/2)] $], label: "split", title: [Separate positive factors]),
  ),
  key-points: (key-points([Each block receives its own determinant factor and its own dimension factor.], label: "kp"),),
  layout: layout-stack(items: ("recall", "substitution", "split", ), key-points: "kp", dominant: "split"),
  reveal: reveal-cumulative(initial: ("recall", ), then: (
    reveal-step(("substitution", ), purpose: [Replace d and determinant Sigma before splitting.], emphasize: true),
    reveal-step(("split", "kp", ), purpose: [Pair dimension d1 with S and dimension d2 with H.], emphasize: true),
  )),
  summary-candidates: (
    summary-visual-candidate("split", reason: [Normalizers split exactly, including 2 pi powers.]),
  ),
  constraints: [The final equality may occupy two lines at its equals sign. Keep each bracketed block normalizer intact; do not use a proportionality symbol.],
)

#slide-design(
  title: [The full density equals two normalized Gaussian factors], section: [R2.4],
  teaching-move: [Associate each full normalizer with its quadratic, then show the exact product.],
  cards: (
    recall-card([$ u=x_2-mu_2, quad r=x_1-(mu_1+B u), quad S,H succ 0 $], label: "recall", from: [R1.3, R1.7 and R1.9]),
    card([$ g_(1)(x_1;x_2):=(2 pi)^(-d_1/2)(det S)^(-1/2) exp(-1/2 r^T S^(-1)r) $\
$ =cal(N)_(d_1)(x_1;mu_1+B u,S) $], label: "factor1", title: [First normalized factor]),
    card([$ g_(2)(x_2):=(2 pi)^(-d_2/2)(det H)^(-1/2) exp(-1/2 u^T H^(-1)u) $\
$ =cal(N)_(d_2)(x_2;mu_2,H) $], label: "factor2", title: [Second normalized factor]),
    card([$ p(x_1,x_2)=g_(1)(x_1;x_2) g_(2)(x_2) $], label: "product"),
  ),
  key-points: (key-points([For fixed $x_2$, $g_1$ is a Gaussian density in $x_1$. The factor names do not yet identify the marginal and conditional.], label: "kp"),),
  layout: layout-stack(items: ("recall", "factor1", "factor2", "product", ), key-points: "kp", dominant: "product"),
  reveal: reveal-cumulative(initial: ("recall", ), then: (
    reveal-step(("factor1", ), purpose: [Pair the d1 normalizer and residual quadratic.], emphasize: true),
    reveal-step(("factor2", ), purpose: [Pair the d2 normalizer and observed quadratic; first factor persists.], emphasize: true),
    reveal-step(("product", "kp", ), purpose: [Combine R1.10 exponent split and R2.3 normalizer split.], emphasize: false),
  )),
  summary-candidates: (
    summary-visual-candidate("product", reason: [Exact normalized factorization before probability-law identification.]),
  ),
  constraints: [Keep both full normalized factors, parameter labels and subordinate residual definitions. Never replace equality by proportionality or name the probability laws before R2.5–R2.6.],
)

#slide-design(
  title: [Integrating the first factor identifies the marginal], section: [R2.5],
  teaching-move: [Use normalization in x1 for fixed x2, then integrate the joint product.],
  cards: (
    recall-card([$ p(x_1,x_2)=g_(1)(x_1;x_2)g_(2)(x_2), quad g_(1)(x_1;x_2)=cal(N)_(d_1)(x_1;mu_1+B u,S) $], label: "recall", from: [R2.4]),
    card([$ S succ 0, quad m:=mu_1+B(x_2-mu_2) " is fixed" $\
$ integral_(RR^(d_1)) g_(1)(x_1;x_2) dif x_1=integral_(RR^(d_1)) cal(N)_(d_1)(x_1;m,S) dif x_1=1 $], label: "unitintegral", title: [Fix x2; integrate in x1]),
    card([$ p(x_2)&=integral_(RR^(d_1))p(x_1,x_2) dif x_1 \
&=g_(2)(x_2) integral_(RR^(d_1)) g_(1)(x_1;x_2) dif x_1 \
&=g_(2)(x_2)=cal(N)_(d_2)(x_2;mu_2,H) $], label: "marginal", title: [Marginalize]),
  ),
  key-points: (key-points([Normalization identifies $g_2$ as the marginal; no conditional formula was assumed.], label: "kp"),),
  layout: layout-stack(items: ("recall", "unitintegral", "marginal", ), key-points: "kp", dominant: "marginal"),
  reveal: reveal-cumulative(initial: ("recall", ), then: (
    reveal-step(("unitintegral", ), purpose: [The fixed observation translates the mean but does not change the Gaussian integral.], emphasize: true),
    reveal-step(("marginal", "kp", ), purpose: [The second factor is constant with respect to x1.], emphasize: true),
  )),
  summary-candidates: (
    summary-visual-candidate("marginal", reason: [Integration supplies the first probability-law identity.]),
  ),
  constraints: [Gaussian normalization is prior mathematics; no new Jacobian/determinant proof is required. Keep the integration domain, variable, fixed-x2 condition and SPD warrant visible.],
)

#slide-design(
  title: [Dividing by the positive marginal identifies the conditional], section: [R2.6],
  teaching-move: [Establish positivity and identify the conditional using the density ratio.],
  cards: (
    card([$ p(x_2)=g_(2)(x_2)=cal(N)_(d_2)(x_2;mu_2,H)>0 quad (x_2 in RR^(d_2)) $], label: "positive", title: [Every observation has positive marginal density]),
    card([$ p(x_1|x_2)&:=frac(p(x_1,x_2),p(x_2)) \
&=frac(g_(1)(x_1;x_2)g_(2)(x_2),g_(2)(x_2))=g_(1)(x_1;x_2) \
&=cal(N)_(d_1)(x_1;mu_1+B(x_2-mu_2),S) $], label: "ratio", title: [Density ratio]),
    card([$ p(x_1,x_2)=p(x_1|x_2)p(x_2) $], label: "identity"),
  ),
  key-points: (key-points([The positive-density ratio gives a conditional-density version for every $x_2$. Its normalization was already proved.], label: "kp"),),
  layout: layout-stack(items: ("positive", "ratio", "identity", ), key-points: "kp", dominant: "identity"),
  reveal: reveal-cumulative(initial: ("positive", ), then: (
    reveal-step(("ratio", ), purpose: [Divide by the marginal identified in R2.5.], emphasize: true),
    reveal-step(("identity", "kp", ), purpose: [Name the normalized factors only after the integral and ratio.], emphasize: false),
  )),
  summary-candidates: (
    summary-visual-candidate("identity", reason: [Final normalized probability-law identity.]),
  ),
  constraints: [Do not interpret a continuous singleton as a positive-probability event or claim uniqueness of conditional versions at null events.],
)

#slide-design(
  title: [The conditional mean retains the observed-block dependence], section: [R2.7],
  teaching-move: [Interpret the law and distinguish original blocks from residual coordinates.],
  cards: (
    recall-card([$ p(x_1|x_2)=cal(N)_(d_1)(x_1;mu_1+B(x_2-mu_2),S) $], label: "law", from: [R2.6]),
    card([$ mu_(1|2)(x_2)=mu_1+B(x_2-mu_2), quad Sigma_(1|2)=S $\
$ r=x_1-mu_(1|2)(x_2) $], label: "parameters"),
  ),
  key-points: (key-points([The mean is affine in $x_2$ and can depend on the observation; the covariance does not. A separated residual quadratic does not assert that $X_1$ and $X_2$ are independent.This exact density proof assumes a joint Gaussian with $Sigma succ 0$; it does not establish adequacy of the supplied model.], label: "kp"),),
  layout: layout-stack(items: ("law", "parameters", ), key-points: "kp", dominant: "parameters"),
  reveal: reveal-cumulative(initial: ("law", ), then: (
    reveal-step(("parameters", "kp", ), purpose: [The x2 dependence remains in the first Gaussian factor through its mean.], emphasize: false),
  )),
  constraints: [No singular-Gaussian extension or new algorithm. The wording includes $B=0$ and directions in the kernel of $B$.],
)

#slide-design(
  title: [Retrospective: normalization completes Gaussian conditioning], section: [R2.8],
  teaching-move: [Close the recording with the normalized factors and their noncircular identification.],
  cards: (
    section-summary-visual([$ p(x_1,x_2)=g_(1)(x_1;x_2)g_(2)(x_2) $\
$ g_1=cal(N)_(d_1)(x_1;mu_1+B(x_2-mu_2),S), quad g_2=cal(N)_(d_2)(x_2;mu_2,H) $\
$ integral_(RR^(d_1))g_(1)(x_1;x_2) dif x_1=1 quad => quad p(x_2)=g_(2)(x_2) $\
$ frac(p(x_1,x_2),p(x_2))=g_(1)(x_1;x_2)=p(x_1|x_2) $], label: "summary"),
  ),
  key-points: (section-summary-takeaways([The quadratic, determinant and dimension factors all split. Integration then division identify the Gaussian marginal and conditional.], label: "kp"),),
  layout: layout-summary(visual: "summary", takeaways: "kp"),
  reveal: reveal-static(("summary", "kp", )),
  rationale: [Select normalized product and identification from R2.4–R2.6. The normalizer identities are recalled in the takeaway, not duplicated as another dense proof. Dependence interpretation already has its own preceding slide.],
  constraints: [Final recording slide. Retrospective only; no new claim, task, assignment, handoff or forward question.],
)
