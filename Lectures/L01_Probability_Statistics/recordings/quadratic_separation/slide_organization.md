# Quadratic separation recording — provisional slide organization

**Mode/status:** Slide-Level Organization `build`, complete provisional draft under the instructor-authorized unattended package of 2026-10-17. This is a teaching-sequence contract for downstream provisional Design, not instructor approval or a validated duration. The coordinator owns review and acceptance. Only this artifact is owned by this stage.

The recording supplements the live inference problem: determine the law of a missing block under a supplied joint Gaussian. It proves the normalized density identity behind the conditional law already used live. It adds no fitting algorithm, dataset, notebook, practical-competence claim or viewing requirement. Gaussianity and a strictly positive definite joint covariance are the validity regime. Students bring block notation, the Gaussian density, the live residual interpretation, matrix algebra, positive definiteness, determinants and integration. The proof recalls those objects but does not invoke the live residual-independence argument.

**Proposed count:** 20 slides: one recording title, 11 in R1, and 8 in R2. Both section counts include their title and retrospective summary. There is no separate closing slide or activity handoff. Counts follow distinct teaching moves; they do not validate the unmeasured provisional 20–30-minute planning range or the upstream provisional section allocations. Final section summary also closes the recording.

## 1. Recording and section organization

### Recording title — outside the section counts

**P0. Quadratic separation of a Gaussian**  
**Subtitle:** A complete density proof of Gaussian conditioning.  
**Intention / goal:** Locate this separate proof supplement after the live Gaussian-conditioning argument. Frame the task as explaining why the conditional density is exactly normalized under the supplied model; do not claim a new algorithm or empirical result.

### R1 — Block elimination separates the joint quadratic (11 slides)

**R1.1. Block elimination separates the joint quadratic**  
**Section title metadata:** Full title as above; subtitle: *Proving the algebra behind Gaussian conditioning*; abbreviated footer title: *Quadratic separation*.  
**Intention / goal:** Frame the section's question: how can matrix elimination turn the joint quadratic into residual and observed-block terms? This opening identifies the proof's job without supplying its answer.

**R1.2. The joint density sets two proof obligations**  
**Intention / goal:** Recall the supplied block Gaussian, dimensions $d_1,d_2$, $d=d_1+d_2$, and $\Sigma=\Sigma^T\succ0$. Recall the complete density $\mathcal N_d(x;\mu,\Sigma)$, distinguishing its quadratic exponent from its determinant/dimension normalizer. Establish that separating the exponent alone will not prove normalized factorization. The desired conditional is a destination, not an assumed identity.  
**Design note:** Retain this distinction as context when the quadratic is separated and when R2 opens; no derivation of the Gaussian density is required.

**R1.3. Positive definiteness makes the observed block invertible**  
**Intention / goal:** Set $H=\Sigma_{22}$ and prove $z^THz=(0,z)^T\Sigma(0,z)>0$ for nonzero $z$. Only then define $B=\Sigma_{12}H^{-1}$ and $S=\Sigma_{11}-BHB^T$, with $B\in\mathbb R^{d_1\times d_2}$. Establish $BH=\Sigma_{12}$ and $HB^T=\Sigma_{21}$; identify $S$ as the same symmetric residual covariance from the live argument, with its strict positivity still to be proved here.  
**Design note:** Treat the definitions as the consequence of the invertibility proof; do not write an unjustified $S^{-1}$ yet.

**R1.4. The elimination matrix has an explicit inverse**  
**Intention / goal:** Define $T=\begin{pmatrix}I&-B\\0&I\end{pmatrix}$ and verify $T^{-1}=\begin{pmatrix}I&B\\0&I\end{pmatrix}$ by multiplication. Students should see why elimination is reversible, rather than assume a block-inverse lemma. Identity and zero blocks have dimensions determined by $d_1,d_2$.

**R1.5. Left elimination removes the upper covariance block**  
**Intention / goal:** Rewrite $\Sigma=\begin{pmatrix}\Sigma_{11}&BH\\HB^T&H\end{pmatrix}$ and work the multiplication $T\Sigma=\begin{pmatrix}S&0\\HB^T&H\end{pmatrix}$. Show explicitly that the upper-right block is $BH-BH$, and that the upper-left is $S$. This first multiplication is not yet a covariance congruence.  
**Design note:** Keep the definitions of $B,S$ available during this calculation.

**R1.6. Right elimination completes the covariance congruence**  
**Intention / goal:** Multiply the preceding result by $T^T=\begin{pmatrix}I&0\\-B^T&I\end{pmatrix}$ to obtain $D:=T\Sigma T^T=\operatorname{diag}(S,H)$. Show the lower-left cancellation $HB^T-HB^T$ explicitly. The pair of multiplications establishes a congruence, not a similarity transformation.  
**Design note:** Carry the previous product forward so students can check the second cancellation rather than reconstruct the whole calculation.

**R1.7. Invertible congruence proves the residual covariance positive definite**  
**Intention / goal:** For $w\ne0$, use $T^Tw\ne0$ to prove $w^TDw=(T^Tw)^T\Sigma(T^Tw)>0$. Test $w=(a,0)^T$ to conclude $S\succ0$. Together with $H\succ0$, this justifies both inverse blocks and their positive determinants. It supplies a proof independent of any residual-independence claim.

**R1.8. Inverting the congruence fixes the order of the factors**  
**Intention / goal:** Derive $D^{-1}=T^{-T}\Sigma^{-1}T^{-1}$ and then $\Sigma^{-1}=T^TD^{-1}T$, where $D^{-1}=\operatorname{diag}(S^{-1},H^{-1})$. Explain the left multiplication by $T^T$ and right multiplication by $T$; no factors commute. Students can reconstruct the inverse identity from the proved congruence instead of memorizing the expanded block inverse.  
**Design note:** Preserve the covariance congruence alongside the inverse relation. The fully expanded partitioned inverse in the checking derivation is not a separate required slide or additional formula to memorize.

**R1.9. Elimination turns the centered vector into a residual and an observation**  
**Intention / goal:** Define $u=x_2-\mu_2$ and $r=x_1-\mu_1-Bu$, then work $T(x-\mu)=(r,u)^T$. Connect $r$ with the familiar centered residual without appealing to its independence. This prepares the substitution into the quadratic, while preserving the distinction between the original blocks and the residual coordinates.

**R1.10. The joint quadratic is the sum of two block quadratics**  
**Intention / goal:** Substitute the inverse congruence and transformed vector to prove
$$
(x-\mu)^T\Sigma^{-1}(x-\mu)
=[T(x-\mu)]^TD^{-1}[T(x-\mu)]
=r^TS^{-1}r+u^TH^{-1}u.
$$
State directly that exponent separation is proved, while normalized density equality has not yet been proved. Matrix inverses here express algebraic identities, not instructions to compute inverses in the notebook.  
**Design note:** Keep the transformed vector and diagonal inverse available; the final equality must be read as a consequence of them.

**R1.11. Retrospective: elimination separates the quadratic**  
**Intention / goal:** Consolidate the section's established argument: reversible elimination yields SPD residual/observed blocks, and inverse congruence gives the quadratic split. End retrospectively, without a teaser or handoff.  
**Candidate summary objects for Design to select:**

- $T\Sigma T^T=\operatorname{diag}(S,H)$ from R1.6: recall what the two cancellations accomplished.
- $H\succ0$ and $S\succ0$ from R1.3/R1.7: recall why the inverse blocks exist.
- $\Sigma^{-1}=T^T\operatorname{diag}(S^{-1},H^{-1})T$ from R1.8: recall the correct inverse order.
- The quadratic split from R1.10 with $r=x_1-\mu_1-Bu$: recall the result and which coordinates it uses.

These are nominations, not a requirement to fit all four objects on the summary.

### R2 — Normalizers identify the conditional and marginal densities (8 slides)

**R2.1. Normalizers identify the conditional and marginal densities**  
**Section title metadata:** Full title as above; subtitle: *From separated exponents to probability laws*; abbreviated footer title: *Normalized factorization*.  
**Intention / goal:** Receive R1's proved quadratic split and SPD blocks, and frame the remaining question: how do the determinant, dimensions and integration establish the full density identity? Do not present the answer on the title slide.

**R2.2. Unit-determinant elimination splits the covariance determinant**  
**Intention / goal:** Use the block triangular $T$ to prove $\det T=1$. Taking determinants of $D=T\Sigma T^T$ then gives $\det\Sigma=\det D=\det S\det H$. Recall strict positivity before taking square roots. This is the determinant obligation, distinct from the exponent calculation.  
**Design note:** Reuse the established congruence rather than introduce a new determinant lemma or orientation.

**R2.3. The dimensions split the remaining Gaussian normalizer**  
**Intention / goal:** Combine $d=d_1+d_2$ with the determinant identity to derive
$$
(2\pi)^{-d/2}(\det\Sigma)^{-1/2}
=\big[(2\pi)^{-d_1/2}(\det S)^{-1/2}\big]
 \big[(2\pi)^{-d_2/2}(\det H)^{-1/2}\big].
$$
Students should account for both determinant and dimension factors, rather than infer normalization from Gaussian-shaped exponentials.

**R2.4. The full density equals two normalized Gaussian factors**  
**Intention / goal:** Combine R1.10 and R2.3 to establish $p(x_1,x_2)=g_1(x_1;x_2)g_2(x_2)$, with $g_1=\mathcal N_{d_1}(x_1;\mu_1+Bu,S)$ and $g_2=\mathcal N_{d_2}(x_2;\mu_2,H)$. Each normalizer must be associated with the matching quadratic and dimension. For each fixed $x_2$, the first factor is a Gaussian density in $x_1$. Do not label the factors as conditional and marginal by assumption.  
**Design note:** Keep the dependence of $g_1$ on $x_2$ explicit; use a full equality, never merely proportionality.

**R2.5. Integrating the first factor identifies the marginal**  
**Intention / goal:** For fixed $x_2$, justify $\int_{\mathbb R^{d_1}}g_1(x_1;x_2)\,dx_1=1$ because $S\succ0$ and its mean is a fixed translation. Work $p(x_2)=g_2(x_2)\int g_1\,dx_1=g_2(x_2)$. This identifies the marginal by normalization, without importing the target marginal/conditional formula as a premise.

**R2.6. Dividing by the positive marginal identifies the conditional**  
**Intention / goal:** Establish $g_2(x_2)>0$ for all $x_2$ and use the density ratio to obtain
$$
p(x_1\mid x_2)=\frac{p(x_1,x_2)}{p(x_2)}
=g_1(x_1;x_2)=\mathcal N_{d_1}(x_1;\mu_1+B(x_2-\mu_2),S).
$$
Conclude the normalized identity $p(x_1,x_2)=p(x_1\mid x_2)p(x_2)$. The positive-density ratio supplies a conditional-density version defined for every $x_2$; no conditioning on a positive-probability singleton or uniqueness assertion at null events is needed.

**R2.7. The conditional mean retains the observed-block dependence**  
**Intention / goal:** Interpret the established law: its mean $\mu_1+B(x_2-\mu_2)$ is affine in the observation and can vary with it, while its covariance $S$ does not. Explain why the separated residual quadratic does not assert independence of $X_1$ and $X_2$: the first density factor can depend on $x_2$ through its mean. State the exact Gaussian/SPD validity regime and that a density proof does not establish adequacy of the supplied model. Do not develop singular-Gaussian or alternative-proof extensions.

**R2.8. Retrospective: normalization completes Gaussian conditioning**  
**Intention / goal:** Close the section and recording with the established result: the exponent, determinant and dimension factors all split; integrating then dividing identifies the Gaussian marginal and conditional without circularity. No new claim, assignment, notebook handoff or forward question.  
**Candidate summary objects for Design to select:**

- $\det\Sigma=\det S\det H$ from R2.2 and the dimension split from R2.3: recall what completes the normalizer.
- $p(x_1,x_2)=g_1g_2$, with named Gaussian parameters, from R2.4: recall the exact normalized equality.
- $\int g_1\,dx_1=1\Rightarrow p(x_2)=g_2$ and $p(x_1\mid x_2)=g_1$ from R2.5/R2.6: recall how the factors acquire their probabilistic identities.
- The observation-dependent mean and constant covariance from R2.7: recall what the result says about dependence.

Design chooses a small coherent subset rather than compressing every proof step into the recap.

## 2. Open issues, assumptions and sequence check

The entry state and two-section responsibility split are inherited provisionally from Section Design. The sequence preserves every required derive/prove obligation. It introduces $H^{-1}$ only after $H\succ0$, $S^{-1}$ only after $S\succ0$, positive square roots only after SPD, and probabilistic factor names only after integration/division. Neither residual independence nor an assumed conditional formula is used to prove the target identity. Transposes, dimensions and matrix order were checked against the complete supplied derivation. The expanded inverse is checking material, not an omitted assigned proof.

The distinct teaching moves justify separating the two covariance multiplications, inverse-order derivation, coordinate transformation and quadratic substitution. R2 gives full normalizers, integral and ratio their own moves rather than compressing them into a last-minute assertion. Titles alone recover the proof route; each summary nominates only earlier objects and ends its section. There is no required new numeric exercise: the worked objects are the symbolic block products and normalized densities assigned upstream.

**Timing uncertainty — Scope/coordinator advisory, inherited rather than a discovered contradiction.** Twenty slides do not establish a 20–30-minute recording. The largest pause/reconstruction demand lies in R1.5–R1.10; R2.2–R2.6 is load-bearing and cannot be dropped to meet a duration target. Provisional treatment retains the full proof and the upstream estimate as unmeasured. The smallest next action is readable downstream design followed by rehearsal; if duration conflicts, return the allocation or range to its owner rather than silently reducing proof depth. No new upstream repair is required on current organizational evidence.

**Source attribution constraint.** The source-verified mathematical route and exact source records are in `math_derivation.md`. Murphy Book 2, *Advanced Topics* (2023), online version December 10, 2025, §2.3.1.5 “Derivation: moment form,” printed pp. 25–27 / PDF pp. 59–61, supports the relevant inverse/exponent/factorization route. The explicit congruence, SPD proof, normalizer completion and integral identification are course completions; do not label these as separately displayed Murphy proofs. This stage checked internal sequencing and algebra against the supplied derivation; it did not repeat the upstream PDF provenance inspection or obtain independent mathematical review.

No final visual layout, reveals, assets, Typst, speaker notes or notebook content is specified here. Provisional Design may split an overloaded visible argument through Organization; it must preserve the proof obligations and retrospective endings.

## 3. Upstream change requests and inspected versions

**No new substantive upstream change is requested.** Final instructor acceptance of the detailed recording route and extent remains open through the coordinator. No self-approval is claimed. The timing uncertainty above stays advisory until design/rehearsal supplies evidence.

Worktree `/tmp/pml-l01-recording`; dispatched base `196e5e5`. SHA-256 values identify the exact uncommitted upstream inputs inspected for this build:

| Input in this recording directory | SHA-256 |
|---|---|
| `recording_brief.md` | `73d00c177d321f7d9d32ef406d4060dcd98ad892893c44ef743962fb6c2d739f` |
| `section_design.md` | `d717d3a60af70212c1f74fefa33ff331a541e807ac8138e45d3b68ab826d7c4a` |
| `math_derivation.md` | `346dcd2a3905b39b2810be5188c4327242fefeecc5b75b728c16cad460eeaa7d` |
