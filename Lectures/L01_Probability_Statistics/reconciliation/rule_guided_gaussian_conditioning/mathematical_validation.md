# Mathematical validation

The coordinator checked the general argument against the actual local Murphy
passage and the candidate's executable mathematics. This is a mathematical and
source check within a coordinated build, not a fresh-student exposition review.
Final artifact identities and render coverage are bound in the receipt.

1. **Domain and observed-block inverse.** A nonsingular Gaussian has symmetric
   positive-definite covariance. For nonzero \(z\in\mathbb R^{d_2}\), the vector
   \((0,z)^T\) is nonzero and its joint quadratic equals
   \(z^T\Sigma_{22}z>0\). Thus the observed covariance block is positive definite,
   invertible and has positive determinant. The candidate defines the symbol
   \(\succ0\) rather than assuming its prior explanation.
2. **Both cancellations.** The upper-right block of \(T\Sigma\) is
   \(\Sigma_{12}-B\Sigma_{22}\), so its cancellation gives
   \(B=\Sigma_{12}\Sigma_{22}^{-1}\). Symmetry implies
   \(\Sigma_{22}B^T=\Sigma_{21}\), which cancels the lower-left block upon
   multiplication by \(T^T\). The resulting top-left block is exactly
   \(S=\Sigma_{11}-\Sigma_{12}\Sigma_{22}^{-1}\Sigma_{21}\).
3. **Residual positivity.** The vector \((a,-B^Ta)^T\) is nonzero whenever
   \(a\ne0\). Its full positive quadratic equals \(a^TSa\) by the proved
   congruence. Symmetry follows from the symmetric covariance/congruence.
   Therefore \(S\) is an invertible positive-definite Gaussian covariance with
   positive determinant; positivity is not inferred from a suggestive density
   kernel.
4. **Inverse and quadratic.** The explicit inverse of \(T\) adds back \(Bu\).
   Inverting the congruence reverses multiplication order. Multiplication by
   \(T^T\) and \(T\) then gives the inverse covariance in the form needed to
   act on \(x-\mu\). The identity \((Tv)^T=v^TT^T\) and
   \(T(x-\mu)=(r,u)^T\) yield the two displayed quadratics. No factor commutation
   or assumed independence is used.
5. **Determinant and normalization.** The triangular matrix \(T\) has determinant
   one. Multiplicativity in the same congruence gives
   \(\det\Sigma=\det S\det\Sigma_{22}\). Positive determinants license the
   square-root split; \(d=d_1+d_2\) splits the powers of \(2\pi\). Thus the
   explicit factors contain all Gaussian coefficients, not only their kernels.
6. **Identification of the laws.** At each fixed \(x_2\), the first factor is
   normalized in \(x_1\). Its integral is one; the *marginal density itself*
   is the second Gaussian factor. Its strict positivity licenses the density
   ratio for every \(x_2\). The conditional mean and covariance match Eq.2.78.
7. **Diagnostic case.** If \(\Sigma_{12}=0\), the conditional mean and covariance
   become \(\mu_1,\Sigma_{11}\); the derived conditional is the established
   marginal. This gives independence in the joint Gaussian model. The converse
   implication is not claimed for arbitrary distributions.

The factored inverse is fully derived. Expanding all four blocks of the inverse
would add another expression without being used in this proof, so that expansion
is deliberately omitted. No Gaussian integral is rederived; normalization of a
positive-definite Gaussian density is available preparation.

The [numerical checks](mathematics_checks.json) independently exercise the matrix,
quadratic, determinant and normalized-density identities on fixed random
positive-definite examples with block dimensions (1,1), (2,3), (3,2), and (4,4).
They guard against order/transposition/constant errors in finite cases; they
cannot replace the general reasoning above.

During the first lowering pass a normalization annotation was transcribed as a
final equality for the whole marginal-density chain. The coordinator caught this
in the source before completion; the author restored the annotation on the
integral alone. This was an implementation error, not an alternative proof or a
change of mathematical scope. Local operation labels and the full-density first
reveal were also restored to match the design.
