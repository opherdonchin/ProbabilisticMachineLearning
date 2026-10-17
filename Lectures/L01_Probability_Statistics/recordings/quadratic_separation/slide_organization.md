# L01-R01 — provisional slide organization

**Mode/status:** Slide-Level Organization `revision`, following the instructor's
2026-10-17 review and revised one-section contract in `section_design.md`.
The instructor requires exactly one section per recording, with no section-heading
or section-summary slides. The sequence below applies that explicit exception to
the ordinary lecture-section bookends. It is authorized provisional revision,
not final instructor acceptance or evidence of a measured duration.

**Purpose and entry.** Prove the Gaussian conditional density from the supplied
joint Gaussian density, without relying on the live residual-independence proof.
Students bring block notation, the live conditional formula and residual
interpretation, Gaussian densities, matrix algebra, positive definiteness,
determinants and integration. The regime is Gaussian with strictly positive
definite covariance. No new fitting algorithm, dataset, notebook, or application
is introduced; the live residual/loss proofs remain unchanged.

**Provisional granularity:** 18 slides: one recording title, one orientation,
and sixteen connected mathematical moves, all within the recording's one section.
This is a proposal arising from the argument, not a fixed count or time allowance.
The earlier 20–30-minute range remains unmeasured. There are no internal section
titles, section-summary slides, separate closing slide or notebook handoff.

## 1. Continuous teaching sequence

### P0. Quadratic separation of a Gaussian

**Recording number:** L01-R01.
**Subtitle:** A proof of the formula for the conditional density of a Gaussian.
**Intention:** Identify this proof supplement to the live Gaussian-conditioning
lecture. Preserve the instructor's chosen number and subtitle.

### P1. From the lecture to this proof

**Intention:** Orient the viewer before introducing new algebra. **From the
lecture** recalls the supplied block Gaussian. **To prove here** states the
complete conditional-density target
$p(x_1\mid x_2)=\mathcal N_{d_1}(x_1;m(x_2),S)$, recalling the familiar
mean/covariance from the lecture, and explains that the recording derives it
from the joint density. Key starting conditions are Gaussianity,
$\Sigma\succ0$, and holding the observed $x_2$ fixed when considering the
conditional density. State that the route factors the joint density before
integrating and dividing; the orientation need not reproduce every formula
that the recording will prove.

**Design note:** Use the requested side-by-side orientation and clear key points.
Separate recalling the live result from using a result as a premise. The target
is known from the live proof, but is to be established afresh here. Do not stack
all block definitions and the full exponential formula in the “Supplied model”
box. Their mathematical role is developed below with adequate vertical spacing.

### P2. The density contains an exponential and a coefficient

**Intention:** Identify exactly what must be accounted for in the complete
joint density:

$$
p(x_1,x_2)=C\exp(-Q/2),\qquad
Q=(x-\mu)^T\Sigma^{-1}(x-\mu),
$$

$$
C=(2\pi)^{-d/2}(\det\Sigma)^{-1/2},\qquad d=d_1+d_2.
$$

Explain that the desired conditional density describes error around the predicted
value of $x_1$, while the marginal describes the observed deviation of $x_2$.
The exponent must become the sum of those two contributions; the coefficient
must become the product of their Gaussian coefficients. This compares the
starting density to the concrete destination on P1, rather than announcing
unexplained tasks. Do not call $C$ an unexplained “normalizer.”

**Design note:** Keep definitions of $C,Q$ adjacent to their actual roles in the
density. The meanings are destinations here; the equalities are proved later.

### P3. Choose B to remove the cross covariance

**Intention:** Explain the first required move before displaying inverse
formulas. Subtracting $B$ times the observed block cancels its cross covariance
when $\Sigma_{12}-BH=0$, with $H=\Sigma_{22}$. Solving this equation requires
an invertible $H$. Explain why cancellation helps the density proof: a block
diagonal covariance has a block diagonal inverse, so its residual and observed
coordinates contribute separate terms to the quadratic in the exponent. This is
the intended route, with its actual matrix identity still to be proved.
Prove, for $z\ne0$,

$$
z^THz=\begin{pmatrix}0\\z\end{pmatrix}^{T}
\Sigma\begin{pmatrix}0\\z\end{pmatrix}>0,
$$

then define $B=\Sigma_{12}H^{-1}$. Thus $BH=\Sigma_{12}$ and,
by symmetry, $HB^T=\Sigma_{21}$. Students should see why the observed block's
inverse is needed, as well as why that inverse exists.

**Design note:** Put cancellation motive, SPD justification and resulting
choice in their logical order; do not present them as an unrelated formula list.
No $S^{-1}$ is needed in the new derivation yet.

### P4. Subtracting the predicted deviation produces the residual

**Intention:** Give the impending matrix elimination an interpretable object:
$u=x_2-\mu_2$ is the observed deviation and $r=x_1-\mu_1-Bu$ is the centered
residual. Work the coordinate action

$$
T=\begin{pmatrix}I&-B\\0&I\end{pmatrix},\qquad
T(x-\mu)=\begin{pmatrix}r\\u\end{pmatrix}.
$$

The change keeps $u$ and subtracts its predicted contribution from the first
block. It is chosen to reach the residual/observed contributions described on
P2; it is not a matrix trick with an unstated purpose.

### P5. The coordinate change is reversible

**Intention:** Verify
$T^{-1}=\begin{pmatrix}I&B\\0&I\end{pmatrix}$ by multiplication with $T$.
Adding $Bu$ back recovers the original centered first block. Reversibility
preserves the full information and will justify both the strict-positivity and
inverse-congruence steps. Do not assume a general block-inverse lemma.

### P6. Subtract the observed rows to cancel the upper-right block

**Intention:** Work the first covariance multiplication with the cancellation
choice from P3 visible:

$$
\Sigma=\begin{pmatrix}\Sigma_{11}&BH\\HB^T&H\end{pmatrix},
\qquad
T\Sigma=
\begin{pmatrix}\Sigma_{11}-BHB^T&BH-BH\\HB^T&H\end{pmatrix}.
$$

Explain the operation as subtracting $B$ times the observed block row from the
first block row. Name the resulting upper-left block
$S=\Sigma_{11}-BHB^T=\Sigma_{11}-\Sigma_{12}H^{-1}\Sigma_{21}$,
identifying the familiar residual covariance. This removes the upper-right
block; one multiplication has not yet completed the covariance transformation
of both coordinates.

### P7. The matching column operation cancels the lower-left block

**Intention:** Carry the previous product forward and multiply by
$T^T=\begin{pmatrix}I&0\\-B^T&I\end{pmatrix}$. Show
$HB^T-HB^T=0$, retaining the upper-left block $S$ from P6. The result is

$$
D:=T\Sigma T^T=\begin{pmatrix}S&0\\0&H\end{pmatrix}.
$$

Explain that the same coordinate change acts on covariance rows and columns.
It has isolated the residual covariance $S$ and observed covariance $H$.
This is the familiar residual covariance from the lecture, derived here directly.

### P8. The remaining residual block is positive definite

**Intention:** Justify using $S$ as a nonsingular Gaussian covariance and later
inverting it. Since $T$ is invertible, $T^Tw\ne0$ for $w\ne0$, hence

$$
w^TDw=(T^Tw)^T\Sigma(T^Tw)>0.
$$

Taking $w=(a,0)^T$ with $a\ne0$ gives $a^TSa>0$. This proves $S\succ0$;
$H\succ0$ was proved on P3. Their inverses and positive determinant square
roots are therefore valid. No independence argument is invoked.

### P9. Invert the covariance identity to reach the exponent

**Intention:** The original density uses $\Sigma^{-1}$, whereas elimination
has so far given a statement about $\Sigma$. Derive the needed bridge:

$$
D=T\Sigma T^T
\ \Longrightarrow\ D^{-1}=T^{-T}\Sigma^{-1}T^{-1}
\ \Longrightarrow\ \Sigma^{-1}=T^TD^{-1}T,
$$

with $D^{-1}=\operatorname{diag}(S^{-1},H^{-1})$. State the local operations:
invert the product in reverse order, then multiply by $T^T$ on the left and
$T$ on the right. Do not commute factors. The expanded partitioned inverse
remains checking material, not an additional formula to memorize.

### P10. The joint quadratic becomes a residual term plus an observed term

**Intention:** Substitute the proved inverse relation and the coordinate action
from P4 into the explicitly named quadratic from P2:

$$
\begin{aligned}
Q&=[T(x-\mu)]^TD^{-1}[T(x-\mu)]\\
 &=\begin{pmatrix}r\\u\end{pmatrix}^{T}
 \begin{pmatrix}S^{-1}&0\\0&H^{-1}\end{pmatrix}
 \begin{pmatrix}r\\u\end{pmatrix}\\
 &=r^TS^{-1}r+u^TH^{-1}u.
\end{aligned}
$$

Identify the first contribution as the squared residual measured by $S^{-1}$;
the second measures the observed deviation using $H^{-1}$. Block diagonal form
removes the cross term. This is what “quadratic separation” means here.

### P11. A sum in the exponent becomes a product

**Intention:** Apply $\exp(a+b)=\exp(a)\exp(b)$ to the result on P10:

$$
\exp(-Q/2)=\exp(-r^TS^{-1}r/2)\exp(-u^TH^{-1}u/2).
$$

The exponential shapes now match the two intended Gaussian densities, but neither
exponential alone is the complete normalized density. The joint coefficient $C$
from P2 must still be assigned to the two factors. State this limitation directly
next to the resulting product, rather than silently claiming the conditional law.

### P12. The same elimination gives the determinant product

**Intention:** Reuse the already proved $D=T\Sigma T^T$ instead of introducing
another matrix lemma. $T$ is block triangular with identity diagonal blocks,
so $\det T=1$. Determinant multiplication gives

$$
\det D=(\det T)^2\det\Sigma=\det\Sigma,
\qquad \det D=\det S\det H.
$$

Therefore $\det\Sigma=\det S\det H$. Identify this as the part of the
coefficient split controlled by covariance, with determinants positive by P8/P3.

### P13. The factors before the exponentials split too

**Intention:** Account for the entire coefficient, including the dimension term:

$$
\begin{aligned}
C&=(2\pi)^{-(d_1+d_2)/2}(\det S\det H)^{-1/2}\\
 &=\big[(2\pi)^{-d_1/2}(\det S)^{-1/2}\big]
   \big[(2\pi)^{-d_2/2}(\det H)^{-1/2}\big].
\end{aligned}
$$

Use $d=d_1+d_2$, the determinant result and positive square roots. Identify
which coefficient belongs to the $d_1$-dimensional residual density and which
to the $d_2$-dimensional observed density. This completes the missing equality
from P11; it is not a second meaning of “separating the quadratic.”

### P14. Reassemble the complete Gaussian densities

**Intention:** Pair each coefficient from P13 with its matching exponential
from P11 to establish the full pointwise equality

$$
p(x_1,x_2)=g_1(x_1;x_2)g_2(x_2),
$$

$$
g_1(x_1;x_2)=\mathcal N_{d_1}(x_1;\mu_1+Bu,S),\qquad
 g_2(x_2)=\mathcal N_{d_2}(x_2;\mu_2,H).
$$

Make the parameter identification $r=x_1-(\mu_1+Bu)$ visible. For fixed $x_2$,
$g_1$ is a normalized Gaussian in $x_1$; it may depend on $x_2$. The algebra now
gives normalized factors; the following integral establishes which is the
marginal rather than assuming their probability-law identities.

### P15. Integrate over x1 to identify the marginal

**Intention:** Hold $x_2$ fixed and use the full normalized Gaussian $g_1$,
with $S\succ0$, to show $\int g_1(x_1;x_2)\,dx_1=1$. Work

$$
p(x_2)=\int p(x_1,x_2)\,dx_1
=g_2(x_2)\int g_1(x_1;x_2)\,dx_1=g_2(x_2).
$$

Explain why $g_2$ is constant with respect to the integration variable and why
the observation-dependent mean is only a fixed translation for this integral.
The factor has now been identified as the marginal by calculation.

### P16. Divide by the marginal to obtain the conditional density

**Intention:** Since the Gaussian marginal is positive for every $x_2$, the
conditional-density ratio yields

$$
p(x_1\mid x_2)=\frac{p(x_1,x_2)}{p(x_2)}
=g_1(x_1;x_2)
=\mathcal N_{d_1}(x_1;\mu_1+B(x_2-\mu_2),S).
$$

Show the cancellation and connect the result to the destination on P1. This
finishes the density proof independently of the live covariance-to-independence
argument. The ratio supplies a conditional-density version for every $x_2$;
do not describe conditioning on a continuous singleton as division by its mass.

### P17. The observation can shift the conditional mean

**Intention:** Interpret the newly proved law. Its mean
$\mu_1+B(x_2-\mu_2)$ can vary with $x_2$, whereas its covariance $S$ does not.
The original blocks need not be independent: the first factor contains $x_2$
inside its shifted mean, even though the residual and observed contributions
to $Q$ have separated. This resolves the possible misreading of the product
identity. End on this ordinary mathematical conclusion, without a recap panel,
section-summary slide, new assignment or future-looking handoff.

## 2. Checks, open issues and downstream handoff

The title sequence describes one continuous proof. Orientation supplies the
known destination; P2 identifies the complete starting density; P3–P4 explain
what the elimination must accomplish before P6–P7 carry it out. The inverse order
is derived rather than memorized. SPD precedes inverse/determinant use in the new
proof; recollection of the established live result is labeled as recollection.
No residual-independence claim or assumed conditional formula proves itself.
Both dimensions and determinants are included; integration and division remain
explicit, separately meaningful operations.

The sequence and opening distribution were negotiated with Slide Design during
this revision. Design may request the smallest teaching-move split if actual
capacity evidence requires it; eighteen slides are not a frozen constraint.
Keep operation reasons, object meanings, target links and comfortable vertical
formula spacing in the visible explanation. Authoring must inspect actual
complete/reveal states. Implementation fit, independent mathematical checking,
classroom effectiveness and instructor approval are distinct claims.

**Timing advisory, coordinator/Scope owner.** The 20–30-minute estimate remains
unmeasured. Readable explanation and then rehearsal must test it. Preserve the
complete proof if the initial estimate proves optimistic; substantial duration
or treatment changes return to the coordinator/instructor.

**Source limit.** Internal algebra and dependency order were checked against
`math_derivation.md`. Its exact verified Murphy source records and course-completion
attribution remain authoritative checking evidence. This revision did not repeat
PDF source inspection. The previous realization's reviews do not establish that
this revised presentation has been reviewed or approved.

## 3. Decisions and inspected inputs

No new change in proof depth, mathematical endpoint, live/recorded allocation or
notebook work is requested. The explicit instructor change to a single section
without bookend slides is incorporated. Final detailed presentation and duration
remain for instructor/coordinator review after downstream checks.

Inputs: existing `recording_brief.md`, `section_design.md`, `slide_organization.md`
and complete `math_derivation.md` at dispatched base `ea3c267` on
`lecture/l01-delivery-readiness`, the instructor's current comments, and the
same-turn revised one-section contract. Exact earlier source inspection records
remain in the derivation rather than being rewritten as new review evidence.
