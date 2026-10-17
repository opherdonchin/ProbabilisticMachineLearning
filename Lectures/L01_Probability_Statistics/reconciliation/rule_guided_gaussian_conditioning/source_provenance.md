# Mathematical source and experiment boundary

The source is Kevin P. Murphy, *Probabilistic Machine Learning: Advanced Topics*
(MIT Press, 2023), local online edition dated December 10, 2025,
`Resources/book2-1.pdf`. The title/copyright pages and the actual mathematical
passage were read in this run; printed pp.26–27 were also inspected as renders.
Exact input hashes are recorded in the experiment receipt.

| Passage | What it supplies |
| --- | --- |
| §2.3.1.3, printed p.24 / PDF p.58, Eqs.2.75–2.79 | Block partition, Gaussian marginals, conditional mean and covariance. |
| §2.3.1.5 “Derivation: moment form”, printed pp.25–27 / PDF pp.59–61 | Partitioned inverse in the observed-block Schur orientation (2.89, 2.91); inverse factorization (2.95–2.96); separated quadratic/exponent (2.97–2.98); density factorization and parameters (2.100–2.103). |

The recording develops this moment-form argument by deriving its elimination
identity. It does not teach information-form conditioning, the alternative Schur
orientation, or Woodbury. Murphy goes from proportional kernels to normalized
factors without displaying the determinant calculation. Positive-definiteness
proofs, determinant/dimension factors and integral identification in the candidate
are course completions of that argument, not quoted textbook steps.

For the general partitioned inverse, invertibility of the two diagonal blocks
alone does not ensure invertibility of the full matrix or its Schur complement.
The candidate uses the stronger symmetric positive-definite covariance
assumption and proves the required block and Schur positivity before taking
their inverses. It therefore does not inherit an incomplete general-domain
qualification from the brief introduction to Eq.2.89.

## Actual preparation in L01

The current live deck establishes the Gaussian density, partitioned parameters,
the affine covariance rule, marginal distributions, and conditioning by the
independent-residual argument. Its handout p.48 introduces
\(B=\Sigma_{12}\Sigma_{22}^{-1}\) and
\(r=x_1-\mu_1-B(x_2-\mu_2)\); p.49 obtains residual covariance; p.52 names
\(S\) as the Schur complement. Page 53 states the separated quadratic, without
deriving it. The recording must prove the full density identity without relying
on the live residual-independence proof as its premise.

The current deck uses \(\mathcal N(x\mid\mu,\Sigma)\), without a dimension
subscript. Its positive-definite symbol is used but not defined; the candidate
must make its meaning explicit. Dimensions matter for the normalizing factors
and compatible block operations. No new dimension-subscripted density family
is needed.

The live proof on handout p.65 is a visual precedent: it retains the earlier
expansion, labels the averaging operation, places the disappearing cross term
and residual-energy calculation together, and then shows their combined result.
This is evidence for composing operations with their warrants, not an approved
geometry for the new recording. The candidate is an autonomous design judgment.

## Fixed mathematical endpoint

For \(\Sigma=\Sigma^T\succ0\), choose
\(B=\Sigma_{12}\Sigma_{22}^{-1}\) and
\(T=\begin{pmatrix}I&-B\\0&I\end{pmatrix}\). Direct row and column elimination
gives

\[
T\Sigma T^T=\begin{pmatrix}S&0\\0&\Sigma_{22}\end{pmatrix},
\qquad S=\Sigma_{11}-\Sigma_{12}\Sigma_{22}^{-1}\Sigma_{21}.
\]

The proof must establish \(\Sigma_{22}\succ0\), \(S\succ0\), invertibility
of \(T\), and the inverse identity with multiplication order preserved. With
\(u=x_2-\mu_2\) and \(r=x_1-\mu_1-Bu\), these yield

\[
(x-\mu)^T\Sigma^{-1}(x-\mu)
=r^TS^{-1}r+u^T\Sigma_{22}^{-1}u,
\qquad \det\Sigma=\det S\det\Sigma_{22}.
\]

Together with \(d=d_1+d_2\), these identities factor the *entire* Gaussian
density. For each fixed \(x_2\), the factor in \(x_1\) integrates to one.
Integration therefore identifies the other factor as \(p(x_2)\); its strict
positivity licenses division to obtain \(p(x_1\mid x_2)\). This is a density
proof for nonsingular Gaussians; singular Gaussian measures are outside it.

## Authority

The current user request authorizes a complete autonomous experimental baseline,
overriding the two supplied documents' consultation pauses. Mathematical depth,
the live/recorded boundary, one continuous recording section, no divider/summary
slides, and canonical-artifact isolation remain fixed. Organization, notation
abbreviations, compositions and reveal choices are experimental author decisions,
not instructor approvals. No course skill or production source is changed.
