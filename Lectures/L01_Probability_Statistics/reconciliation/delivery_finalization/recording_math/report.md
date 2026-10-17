# Independent mathematical review: quadratic-separation recording

**Finding:** the proposed proof is mathematically complete under its stated Gaussian/SPD assumptions. No blocking mathematical defect or inaccurate attribution in the selected source passages was found. The four reviewed artifacts can proceed provisionally to production, with the minor interpretation wording below tightened. This is an independent technical review, not instructor approval, rendered-deck validation or a duration claim. I authored none of the reviewed artifacts and edited none of them.

Exact input hashes are in `reviewed-input-hashes.json`; immutable review copies of the four Markdown inputs are in `inputs/`. The reviewed derivation is SHA-256 `346dcd2a3905b39b2810be5188c4327242fefeecc5b75b728c16cad460eeaa7d`; organization is `05beb9d595435ecfbb71240251491d801d3e7c55a488e5090c2940654e2d753f`. The review covers the brief, section design, derivation and organization, and the named Murphy passages. It does not independently re-audit the reported live-deck or scope hashes/approval history.

## General proof audit

The dimensions are consistent: H is d2×d2, B is d1×d2, S is d1×d1, and T is d×d. Principal-block positivity proves H≻0 before its inverse is used in the proof. Symmetry gives BH=Σ12 and HBᵀ=Σ21. Both covariance products are correct:

$$
T\Sigma=\begin{pmatrix}S&0\\HB^T&H\end{pmatrix},\qquad
D=T\Sigma T^T=\operatorname{diag}(S,H).
$$

The explicit triangular inverse of T is valid in both orders. Since T is invertible, congruence proves D≻0 and hence S≻0, without invoking Gaussian independence or assuming the target conditional formula. The explicit vector test with (a,−Bᵀa) is also correct. Thus every subsequent inverse, determinant and positive square root is justified.

Inverting the congruence yields Σ⁻¹=TᵀD⁻¹T, with precisely this order. Its expanded blocks are correct, including the lower-right H⁻¹+BᵀS⁻¹B. For u=x2−μ2 and r=x1−μ1−Bu, T(x−μ)=(r,u)ᵀ proves the complete quadratic identity. This is a congruence, not a similarity; the artifacts preserve that distinction. No factors commute implicitly.

The normalizer proof discharges the obligation left by separated exponents. Unit det T gives det Σ=det S det H, and d=d1+d2 splits the (2π) powers. Pairing the two positive determinant factors with their corresponding quadratic forms yields exact normalized Gaussian factors g1 and g2. This calculation is a pointwise density equality in the original variables, so no unmentioned change-of-variables Jacobian is required.

The law identification is noncircular: for fixed x2, the Gaussian normalization theorem gives ∫g1(x1;x2)dx1=1; integrating the proved joint product identifies g2 as the marginal. Its strictly positive density permits the ratio giving g1 as a conditional-density version for every x2. The organization correctly avoids a uniqueness claim at null conditioning events. Gaussian normalization is a stated entry prerequisite, rather than the conditional result being smuggled into its own proof. Singular Gaussian measures are properly excluded from this Lebesgue-density proof.

## Minor mathematical wording precision

The derivation §4, Section Design R2 and Organization R2.7 say that the conditional mean “changes with” x2. The exact formula permits unchanged means: when Σ12=0, B=0 and the mean is μ1 for every observation; more generally, observation differences in ker B have no effect. Use **“The conditional mean is affine in x2 and can depend on the observation; its covariance S is constant in x2.”** Likewise, the first density factor *generally* depends on x2. This is a small interpretation correction, not a defect in the proof or grounds to change its scope. No new independence theorem or example is needed in the recording.

Other conventions are harmless and clear: covariance rather than standard deviation parameterizes each Gaussian; lowercase r is the deterministic centered residual coordinate; the ratio selects an everywhere-defined smooth conditional version; inverse notation expresses an identity rather than a numerical implementation instruction.

## Independent source verification

The local PDFs' title/copyright pages and dated footers confirm Murphy, *Advanced Topics* (2023), online December 10, 2025, and *An Introduction* (2022), online April 18, 2025. Their hashes match the derivation's records. Text was extracted directly and all six relevant content pages were rendered and inspected.

- **Book 2 §2.3.1.3**, printed p.24/PDF p.58, Eqs.2.75–2.78: verified partition, marginal and conditional destination.
- **Book 2 §2.3.1.5 “Derivation: moment form”**, beginning printed p.25/PDF p.59: verified title/start; printed p.26/PDF p.60 contains Eq.2.89 in the selected H-Schur orientation and Eq.2.91's Schur definition. The alternate orientation and Woodbury are present but not required by this recording.
- **Book 2 Eqs.2.94–2.98 and 2.100–2.103**, printed pp.26–27/PDF pp.60–61: verified inverse-factor/exponent route and final Gaussian factorization/parameters. The source passes from proportional kernels to normalized factorization without separately displaying this course's congruence/SPD proof, determinant/dimension calculation or integral identification. Describing those as course completions is accurate. The selected source identities themselves are correct.
- **Book 1 §3.2.3**, printed p.84/PDF p.114, Eqs.3.26–3.28, and **§3.2.4**, printed p.85/PDF p.115, Eqs.3.29–3.32: verified the stated supporting results. The scalar example uses ρ=0.8, unit marginal variances, zero means and observation y2=1. The recording's x2=1.5 is explicitly a course choice, not Murphy's observation. Its resulting mean1.2, variance0.36 and observed quadratic2.25 are correct.

Raw selected-page/frontmatter extractions and rendered source-page PNGs are retained here. No remote source or Git operation was used.

## Actual algebraic checks and production advice

`check_algebra.py` and `algebra-results.json` retain exact rational specializations for unequal block dimensions (2,3) and (3,2), plus (1,1). Both T inverse products, covariance congruence, inverse congruence, expanded inverse, quadratic equality and determinant equality passed exactly. Leading principal minors of S and H were positive; the recorded scalar arithmetic also agrees. These finite checks supplement the manual general proof audit above; they do not replace it.

The organization carries all derive/prove obligations through its two sections and ends both retrospectively. No further mathematical prerequisite, proof branch or instructor choice is required by this review. Preserve full normalizers and integral/ratio identification in production. The 20–30-minute estimate remains unmeasured; readable layout and rehearsal should test it without dropping those steps. A later targeted render check should inspect transposes, block placement, dimensional subscripts, square-root determinant factors and the visible distinction between g1/g2 and their subsequently identified probability laws.
