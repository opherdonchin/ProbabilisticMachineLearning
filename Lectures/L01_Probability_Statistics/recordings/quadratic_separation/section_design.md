# Quadratic separation recording — provisional section design

**Mode/status:** Section Design `build`; complete provisional contract for the
instructor-authorized unattended package of 2026-10-17. Neither instructor
approval of these sections nor downstream validation is claimed. The separate
proof allocation and required/examinable status are accepted; detailed structure,
duration and final recording acceptance remain open. The coordinator owns review
and instructor decisions. Organization may develop this provisional route under
the same bounded authorization.

## Global frame

**Trajectory and endpoint.** An invertible block elimination converts the joint
covariance into diagonal residual/observed blocks; the same congruence separates
the joint quadratic; determinants and dimensions complete the normalized density
identity

$$
\mathcal N(x;\mu,\Sigma)
=\mathcal N(x_1;\mu_1+B(x_2-\mu_2),S)\,
 \mathcal N(x_2;\mu_2,H).
$$

The learning problem remains inference about a missing block under a supplied
joint Gaussian. This recording proves why the conditional law used live is an
exact normalized distribution under that model. It introduces no new inference
algorithm, fitting problem or practical-competence claim.

**Entry state.** After the live Gaussian-conditioning material, students can
partition means/covariances, use the multivariate Gaussian density, distinguish
conditional and marginal queries, and interpret the independent centered residual
and its Schur-complement covariance. Matrix multiplication, transposition,
inversion, positive definiteness, determinants and the ordinary density
normalization integral are prior mathematics. The recording briefly recalls
the notation; its proof does not use the live independence argument to establish
the desired factorization.

**Fixed notation.** Let $x_i,\mu_i\in\mathbb R^{d_i}$, $d=d_1+d_2$,
$\Sigma=\Sigma^T\succ0$, $\Sigma_{21}=\Sigma_{12}^T$,
$H=\Sigma_{22}$, $B=\Sigma_{12}H^{-1}$,
$S=\Sigma_{11}-BHB^T$, $u=x_2-\mu_2$ and
$r=x_1-\mu_1-Bu$. Identity/zero blocks always have the matching dimensions.

**Extent and delivery.** Entirely a separate recording: **20–30 minutes is an
unmeasured provisional planning range**, not an approved duration or slide count.
The provisional allocation below reserves explicit time for normalization rather
than treating exponent separation as the endpoint. Rehearsal and downstream
organization must test the estimate. Proof content is required/examinable;
viewing is not tracked, evaluated or monitored, and no exam question is promised.
The live residual proof and notebook stand independently of viewing this recording.

**Boundaries and handoff.** No Woodbury proof, second Schur orientation,
information-form unit, new dataset/notebook, speaker notes or additional empirical
application. This is a proof supplement, with no notebook task handoff. The live
results already supply the notebook prerequisites. The mathematically complete
[derivation](math_derivation.md) is checking material for downstream explanation,
not a prescribed slide sequence. Organization owns titles, order and granularity
within each contract; Design owns the visible explanation.

**Sources and precedent.** The exact source versions and hashes are recorded in
`math_derivation.md`. Primary reading is Murphy, *Probabilistic Machine Learning:
Advanced Topics* (2023), online version December 10, 2025, §2.3.1.5 “Derivation:
moment form,” printed pp. 25–27 (PDF pp. 59–61), especially Eqs. 2.89, 2.91 and
2.94–2.103. §2.3.1.3, printed p. 24/PDF p. 58, Eqs. 2.75–2.78 supplies the
block law and destination. The live source/handout pp. 46–54 supplies entry-state
and notation precedent, including the already displayed quadratic identity.
These are prepared materials, not evidence of actual prior delivery.

## Section R1 — Block elimination separates the joint quadratic

**Status and single job.** Provisional. Establish how removing the linearly
predicted block yields a valid covariance congruence and, consequently, a split
quadratic form. This is the load-bearing algebraic argument.

**Entry/transition in.** Recall the supplied joint law and live residual notation.
Students know the conditional result; the new obligation is to prove the density's
quadratic separation through matrix elimination rather than residual independence.

**Assigned mathematics and treatment.** **Derive/prove**:

$$
T=\begin{pmatrix}I&-B\\0&I\end{pmatrix},\qquad
T^{-1}=\begin{pmatrix}I&B\\0&I\end{pmatrix},\qquad
T\Sigma T^T=\begin{pmatrix}S&0\\0&H\end{pmatrix}.
$$

Justify $H\succ0$ before defining $H^{-1}$, then $S\succ0$ by congruence
(or the equivalent nonzero-vector quadratic argument). **Derive/prove**

$$
\Sigma^{-1}=T^T\begin{pmatrix}S^{-1}&0\\0&H^{-1}\end{pmatrix}T,
\qquad
(x-\mu)^T\Sigma^{-1}(x-\mu)=r^TS^{-1}r+u^TH^{-1}u.
$$

The symbolic block multiplication is the worked calculation: its job is to show
exactly why both off-diagonal blocks vanish and why the inverse identity uses
$T^T$ on the left and $T$ on the right. Do not assume the block-inverse formula
as a memorized prerequisite. **Interpret** $S$ as the same residual covariance
established live; do not repeat the independence proof. Inverses express identities,
not a recommendation to form inverses in notebook code.

**Source allocation.** Murphy Book 2 §2.3.1.5, Eq. 2.89 and Eq. 2.91,
printed p. 26/PDF p. 60, support the relevant block-inverse orientation and
Schur complement; Eqs. 2.94–2.98 give the inverse/exponent factorization.
The explicit $T\Sigma T^T$ construction and positive-definiteness justification
are the course's fully justified route to that identity. Do not attribute these
as separately displayed Murphy proofs.

**Endpoint/carry-forward.** Students can justify every inverse and reproduce the
elimination-to-quadratic argument. They have the two Gaussian-shaped exponent
terms, but have not yet proved normalized equality. Remaining obligation:
determinant and $(2\pi)$ factors and identification of the marginal/conditional.
Notebook prerequisites are unchanged.

**Boundary and extent.** No general matrix inversion lemma or alternate
orientation. Provisionally 12–18 minutes; 8–12 minutes remain for R2. If this
algebra exhausts the recording budget, report timing pressure to the coordinator
rather than dropping normalization or silently changing proof depth.

**Final retrospective teaching move.** Invertible block elimination gives positive
definite residual and observed covariance blocks; its inverse congruence expresses
the joint quadratic as the sum of the residual quadratic and the observed-block
quadratic.

## Section R2 — Normalizers identify the conditional and marginal densities

**Status and single job.** Provisional. Establish why the separated expression is
the product of two normalized Gaussian densities, not merely a proportional
factorization of kernels.

**Entry/transition in.** Begin from R1's proved quadratic split and valid SPD
blocks. The joint density also has a determinant and a dimension-dependent
normalizer, which must be accounted for to establish the full probability law.

**Assigned mathematics and treatment.** **Derive/prove** $\det T=1$ and

$$
\det\Sigma=\det S\det H,\qquad
(2\pi)^{-d/2}(\det\Sigma)^{-1/2}
=\big[(2\pi)^{-d_1/2}(\det S)^{-1/2}\big]
 \big[(2\pi)^{-d_2/2}(\det H)^{-1/2}\big].
$$

Combine these with the quadratic split to obtain the Gaussian density equality
in the global endpoint. **Work/justify** the density identification: for fixed
$x_2$, the first factor integrates to one over $x_1$, so integrating the product
gives $p(x_2)=\mathcal N(x_2;\mu_2,H)$. This marginal is strictly positive,
and dividing the joint by it gives
$p(x_1\mid x_2)=\mathcal N(x_1;\mu_1+Bu,S)$. This final check avoids using the
target conditional law as an assumption of its own proof. **Interpret** the
dependence: the conditional mean is affine in $x_2$ and can depend on the observation; the conditional covariance
does not. The two original blocks are generally dependent despite the separated
residual quadratic.

**Source allocation/provenance.** Murphy Book 2 §2.3.1.5 Eqs. 2.100–2.103,
printed pp. 26–27/PDF pp. 60–61, states the factorization and its parameters.
The explicit determinant/dimension completion and normalization-integral check
are the course's completion, verified in `math_derivation.md`; Murphy's displayed
proportionality-to-factorization passage does not separately show those steps.
No source error in the selected moment-form identity was found.

**Endpoint/carry-forward.** Students can prove normalized factorization and explain
why exponent separation alone leaves a proof obligation. All recording obligations
are discharged. No new live/notebook prerequisite or additional assignment is
created.

**Boundary and extent.** No new numerical example is required; the proof's two
normalized factors are the worked objects. Provisionally 8–12 minutes, yielding
20–30 minutes overall. No additional proof family or application follows.

**Final retrospective teaching move.** Determinant and dimension factors split
with the quadratic, giving the normalized joint density as its Gaussian
conditional times its Gaussian marginal; normalization establishes which factor
is each law.

## Whole-route check and open decisions

The forward construction leaves one explicit obligation after R1 and resolves it
in R2. Both sections have a single intellectual job and retrospective closure.
Positive definiteness precedes inverse/determinant use; no conditional law is
assumed to prove itself. The route fits the assigned recording boundary without
changing the live lecture or notebook.

There is no identified blocking mathematical or source issue. **Scope/coordinator
advisory:** the two-section structure and its 12–18 / 8–12-minute allocation are
provisional, and the detailed recording contract has not received final instructor
acceptance. Continue the authorized provisional downstream build, preserve full
normalization depth, and return substantial timing or responsibility pressure to
the owning stage. Author checking is complete here; independent mathematical
review and actual downstream organization remain pending. Feasibility does not
constitute instructor approval or validated Section Design.
