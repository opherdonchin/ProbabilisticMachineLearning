# L01-R01 — provisional section design

**Mode/status:** Section Design `revision`, responding to the instructor's
2026-10-17 review. The instructor explicitly requires recordings to have exactly
one section and no section-heading or section-summary slides. That instruction
overrides the general lecture-section bookend rule for this recording. The
separate proof allocation and required/examinable content remain accepted. This
revised realization is provisional; final acceptance and measured duration are
not claimed.

## One section: prove the Gaussian conditional density from the joint density

**Purpose and endpoint.** Under a supplied joint Gaussian model, determine the
law of a missing block after observing another block. Prove why the conditional
formula already established in the live lecture is exactly a normalized density:

$$
p(x_1\mid x_2)=\mathcal N_{d_1}(x_1;\mu_1+B(x_2-\mu_2),S).
$$

The continuous argument establishes the complete joint-density identity

$$
\mathcal N_d(x;\mu,\Sigma)
=\mathcal N_{d_1}(x_1;\mu_1+B(x_2-\mu_2),S)
 \mathcal N_{d_2}(x_2;\mu_2,H).
$$

The exponential terms and the coefficients before them must both agree.
Integration identifies the marginal; division then identifies the conditional.
No fitting algorithm, dataset, or new practical-competence claim is added.

**Entry state.** Students can partition Gaussian means and covariances, use the
multivariate Gaussian density, distinguish conditional and marginal queries,
and interpret the centered residual and its Schur-complement covariance from
the live lecture. Matrix multiplication, transposition, inversion, positive
definiteness, determinants and ordinary density normalization are available.
These are the prepared live lecture's entry commitments, not evidence that class
delivery has occurred. Recall the live result as the destination; do not use
residual independence to prove that result again.

**Notation and conditions.** Let $x_i,\mu_i\in\mathbb R^{d_i}$,
$d=d_1+d_2$, $\Sigma=\Sigma^T\succ0$ and
$\Sigma_{21}=\Sigma_{12}^T$. Write

$$
H=\Sigma_{22},\qquad B=\Sigma_{12}H^{-1},\qquad
S=\Sigma_{11}-BHB^T,
$$

$$
u=x_2-\mu_2,\qquad r=x_1-\mu_1-Bu,\qquad
T=\begin{pmatrix}I&-B\\0&I\end{pmatrix}.
$$

Here $u$ is the observed deviation and $r$ is the error after subtracting the
predicted deviation $Bu$. Gaussianity and strict positive definiteness are
essential to this ordinary-density argument. Singular Gaussian measures are
outside its scope. Identity and zero blocks have matching dimensions.

**Assigned mathematics and depth.** Preserve the complete proof at
**derive/prove** depth. These dependencies belong to one section, not to
proposed subsection boundaries:

- Motivate $B$ by the cancellation equation $BH=\Sigma_{12}$. Prove
  $H\succ0$ by testing the joint quadratic on $(0,z)^T$ before using
  $H^{-1}$ in the new derivation. Explain why the observed covariance must
  be inverted and why doing so is legal.
- Show that $T$ takes centered observations to $(r,u)^T$. Verify
  $T^{-1}=\begin{pmatrix}I&B\\0&I\end{pmatrix}$ by multiplication.
  The change removes the predicted deviation and can be undone.
- Work both block multiplications in
  $T\Sigma T^T=D=\operatorname{diag}(S,H)$, displaying each off-diagonal
  cancellation. Identify the resulting $S$ with the residual covariance
  from the live lecture. Prove $D\succ0$ by invertible congruence and
  infer $S\succ0$.
- Derive $\Sigma^{-1}=T^TD^{-1}T$ with the correct multiplication order.
  Use $T(x-\mu)=(r,u)^T$ to prove
  $Q:=(x-\mu)^T\Sigma^{-1}(x-\mu)=r^TS^{-1}r+u^TH^{-1}u$.
  Explain how this gives a product of exponential terms and why that
  product alone is insufficient to prove the density equality.
- Derive $\det T=1$ and $\det\Sigma=\det S\det H$ from the same covariance
  identity. Combine this with $d=d_1+d_2$ to split the coefficient
  $(2\pi)^{-d/2}(\det\Sigma)^{-1/2}$ into the two Gaussian coefficients.
- Assemble $p(x_1,x_2)=g_1(x_1;x_2)g_2(x_2)$ with full normalized
  Gaussian factors. For fixed $x_2$, integrate $g_1$ over $x_1$ to identify
  $p(x_2)=g_2(x_2)$; use $g_2(x_2)>0$ and division to identify
  $p(x_1\mid x_2)=g_1(x_1;x_2)$.

**Interpret** why the conditional mean can change with $x_2$ while its covariance
does not. The original blocks can be dependent: the residual $r$ itself contains
$x_2$. Finish with this direct interpretation of the proved law, without adding
a summary slide or a future-looking handoff.

**Explanation constraints.** Begin after the title with an orientation separating
**From the lecture** from **To prove here**, alongside the starting conditions.
Make the supplied density and intended density identity visible before the
elimination calculation. Define the joint quadratic and explain its residual and
observed terms before using their names as shorthand. Each transformation needs
its local operation and reason nearby. Avoid “Prepared live,” “proof obligation,”
and unexplained “normalizer.” Do not substitute a formula stack for what an
operation accomplishes. Allow sufficient vertical space for formula groups;
resolve density downstream without shrinking mathematics or deleting reasons.
Organization owns granularity; Design owns the visible explanation.

**Worked objects and sources.** Required calculations are the symbolic block
products, inverse relation, density coefficient and integral/ratio. A new numeric
example is not required. Murphy, *Probabilistic Machine Learning: Advanced Topics*
(2023), online version December 10, 2025, §2.3.1.3 “Marginals and conditionals of
an MVN,” printed p. 24/PDF p. 58, supplies the destination; §2.3.1.5 “Derivation:
moment form,” printed pp. 25–27/PDF pp. 59–61, especially Eqs. 2.89, 2.91 and
2.94–2.103, supports the inverse/exponent route. Explicit elimination, SPD proof,
determinant/dimension calculation and integral identification are course
completions, not separately displayed Murphy derivations. Exact source records
remain in [math_derivation.md](math_derivation.md). This revision checked the
dependency structure against that derivation; it did not repeat PDF inspection.

**Extent, boundaries and carry-forward.** The earlier 20–30-minute range is an
unmeasured planning estimate. There is no fixed slide count, internal time split,
or approved duration. Preserve the full proof while making its meaning legible;
return measured timing pressure to the coordinator rather than dropping the
coefficient calculation or density identification. No Woodbury proof, second
Schur orientation, information-form unit, speaker notes, new notebook or additional
application. The live residual/loss proofs and notebook remain unchanged and
independent of viewing this recording. Viewing is not monitored; no exam question
is promised. No notebook handoff is required.

## Revision checks and remaining decisions

The single responsibility is proving the conditional density from the joint
density. Each inverse is justified before use in this new proof; orientation's
recollection of the live law is explicitly a destination, not a premise of this
argument. The coefficient, integration and ratio remain essential work. The final
interpretation is a teaching move, not a replacement section summary.

The instructor's one-section/no-bookend convention is settled. The detailed
presentation, actual rendered readability and duration require downstream checks
and instructor review. No self-approval or independent review of this revision is
claimed. Inputs inspected: the three recording planning artifacts and
`math_derivation.md` at dispatched base `ea3c267` on
`lecture/l01-delivery-readiness`, plus the instructor's current review.
