# L01-R01 — provisional recording brief

**Title:** Quadratic separation of a Gaussian.
**Subtitle:** A proof of the formula for the conditional density of a Gaussian.

The separate recording allocation and required/examinable content are accepted.
The instructor's 2026-10-17 review authorizes revising the complete presentation
for clarity and changes the recording convention: **exactly one section, with no
section-heading or section-summary slides**. This overrides the ordinary live
lecture-section bookends. Preserve the full mathematical depth; final acceptance
of this revised realization and a measured duration remain open.

The task is inference about a missing block under a supplied joint Gaussian.
Starting from the live lecture's block notation, conditional law and residual
interpretation, prove that the joint density equals the product of the stated
conditional Gaussian and observed-block marginal Gaussian. Do not use the live
residual-independence proof as a premise of this second proof.

Use $H=\Sigma_{22}$, $B=\Sigma_{12}H^{-1}$,
$S=\Sigma_{11}-BHB^T$ and
$T=\begin{pmatrix}I&-B\\0&I\end{pmatrix}$ consistently with Scope. Preserve
positive-definiteness justifications, reversible block elimination, inverse
congruence, residual/observed quadratic separation, determinant and dimension
factors, integration to identify the marginal, and division to identify the
conditional. The coefficient before an exponential is part of the density;
proving only the exponential identity is incomplete. The nonsingular Gaussian
model is the validity regime, not a claim that the model fits every task.

After the title, use an orientation with **From the lecture** and **To prove here**
alongside key starting conditions. Name the joint quadratic and explain what its
residual and observed contributions mean before the block calculations. Explain
the choice $BH=\Sigma_{12}$ and why the observed block must be invertible, then
justify that inverse. Keep the destination visible and put the operation and
reason near each algebraic step. Replace “Prepared live,” “proof obligation” and
unexplained “normalizer” with direct mathematical language. Investigate tight
vertical formula spacing as a recurring production issue; readability must not
depend on compressing explanations or shrinking formulas.

The revised [Section Design](section_design.md) assigns the one-section contract;
[Organization](slide_organization.md) assigns the provisional continuous sequence.
[The derivation](math_derivation.md) remains the complete checking source,
including exact source records and course-completion attribution. Design and
Authoring must realize the same revised argument and inspect actual renders.
Agreement among specialists does not grant instructor approval.

No Woodbury proof, second Schur orientation, information-form unit, new
dataset/notebook, speaker notes or additional application. The live residual/loss
proofs and notebook remain unchanged. The recording has no notebook handoff,
viewing monitoring or promised exam question. The earlier **20–30-minute range is
unmeasured**; no fixed slide count or duration is required.

## L01-RECORDING-CONTRACT — revised presentation pending review

Owner: instructor/coordinator. Review whether the concrete revised explanation is
understandable and suitable for recording, followed by timed rehearsal. The
mathematical allocation and examinable content do not need to be reapproved.
Review the regenerated [deck](slide_deck.pdf) against the revised planning
artifacts once Design/Authoring checks are complete; a successful compile or an
earlier review of a different realization does not settle this review.

If rehearsal reveals excessive duration, request a tighter explanation preserving
the complete proof before considering a Scope change. Do not remove the density
coefficient or integration/division steps merely to meet an estimate. Capture and
publication remain dependent on final acceptance and rehearsal; independent live
deck checks and notebook preparation can proceed separately.
