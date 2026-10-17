# Experimental argument map

Status: autonomous first candidate, unapproved. The instructor authorized completion without consultation; no choice below is an instructor approval. Canonical recording and lecture remain unchanged.

The question is the normalized density of the unobserved block given an observed block. The live lecture has already established the conditional mean and residual covariance using Gaussian independence. This recording proves the same law directly from the joint density.

For symmetric positive-definite Σ, partition x, μ and Σ consistently. Show the full density before abbreviating its exponent by Q and its coefficient by C. To identify the conditional density, separate both Q and C into residual and observed contributions.

1. A principal-block test proves Σ22 positive definite, licensing its inverse.
2. Subtract B times the observed block row. The upper-right cancellation equation Σ12−BΣ22=0 determines B=Σ12Σ22⁻¹. A matching column operation gives TΣTᵀ=diag(S,Σ22), with S=Σ11−Σ12Σ22⁻¹Σ21. This operation is a means to separate the inverse quadratic already displayed, not an unexplained covariance manipulation.
3. The explicit nonzero vector (a,−Bᵀa) proves aᵀSa>0. Thus S⁻¹ and both positive Gaussian determinant factors exist.
4. T maps the centered vector to (r,u), where u=x2−μ2 and r=x1−μ1−Bu. Adding Bu back gives the explicit inverse of T. Invert the congruence and multiply by Tᵀ and T to recover Σ⁻¹=Tᵀdiag(S⁻¹,Σ22⁻¹)T.
5. Substitute this inverse into the displayed Q. Co-locate T(x−μ)=(r,u) and the resulting block-diagonal multiplication. It yields Q=rᵀS⁻¹r+uᵀΣ22⁻¹u.
6. The same congruence and det T=1 give det Σ=det S det Σ22. Together with d=d1+d2 this splits C into two Gaussian coefficients.
7. Combine the two identities in the actual joint density, showing both explicit normalized factors before recognizing the familiar N notation. Integrating the first factor in x1 identifies the marginal; divide by its strictly positive value to identify the conditional.
8. End with the zero-cross-covariance diagnostic: the conditional law becomes the original marginal. This is a mathematical consequence, not a recap slide.

Notation: reuse live B, S and r; m(x2) is a new function abbreviation for the live μ_(1|2) formula and is defined explicitly on the orientation; keep Σ22 rather than aliasing H. T earns its role by representing the repeated subtraction, congruence, inverse and determinant operations. u shortens the observed deviation across quadratic/density displays. Q and C denote exactly the two parts of the full density; no dimension-subscripted Gaussian symbol, precision parameterization, D, or inverse-transpose abbreviation is introduced.

Source: Murphy, Advanced Topics, §2.3.1.3 and §2.3.1.5, online December 10, 2025, printed pp24–27. Explicit positive-definiteness, elimination and normalizer/integration details are course completions. The live source establishes partitioning, affine Gaussian closure, B and r, S as residual covariance, conditional formulas and the quadratic split. No independent-residual argument is used to license the recorded density calculation.

Visual contract from the live squared-loss proof: keep the preceding expression with the operation applied to it; put the local mathematical reason beside its term; reserve the key-point region for interpretation. The candidate uses equations and inline operation labels, not a sequence of equally weighted boxes. Mathematical equalities remain intact. Reveals add reasoning units, never individual symbols.
