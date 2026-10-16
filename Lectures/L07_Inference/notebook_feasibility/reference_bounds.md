# Tail-envelope check for the fixed classifier reference

This is author-facing reference-quality checking, dated 2026-10-14, by `/root/investigate_l07_l10`. It adds no lecture scope, student task or instructor decision. Existing reference results remain unchanged. [Implementation](reference_bounds.py) and [raw results](reference_bounds_results.json) use the frozen classifier/model/data in `classifier_probe.py`.

Let `U(w)` be its negative log unnormalized posterior, `B=Σ₀⁻¹=I/4`, and `A=B+XᵀX/4`. Since `0≤σ(z)(1−σ(z))≤1/4`, its Hessian satisfies the global matrix inequalities `B≼∇²U(w)≼A`. At **any** anchor m, with gradient `g=∇U(m)` and displacement v, integrating the Hessian along the segment gives

$$U(m)+g^Tv+\tfrac12v^TBv\ \le U(m+v)\le\ U(m)+g^Tv+\tfrac12v^TAv.$$

The anchor need not be an exact MAP. Completing both squares, define

$$\mu_M=m-M^{-1}g,\qquad Z_M=e^{-U(m)+\frac12g^TM^{-1}g}(2\pi)^{d/2}|M|^{-1/2},\qquad M\in\{A,B\}.$$

Then `Z_A φ_A(w) ≤ e^(−U(w)) ≤ Z_B φ_B(w)`, where `φ_M=N(μ_M,M⁻¹)` is a normalized Gaussian density. Consequently the true normalizer Z lies between `Z_A` and `Z_B`, and for a box `C_r=[−r,r]^d`,

$$P_p(W\notin C_r)\le \frac{Z_B}{Z_A}P_{\phi_B}(W\notin C_r),\quad
\frac{Z_B}{Z_A}=\sqrt{\frac{|A|}{|B|}}\exp\left[\tfrac12g^T(B^{-1}-A^{-1})g\right].$$

The gradient correction is nonnegative. Dropping it at a nonstationary numerical anchor would be unjustified; likewise, the envelope Gaussian is centered at `m−B⁻¹g`, not merely at m. For the fixed diagonal prior precision, `φ_B` has independent coordinates of variance4. Scalar Normal tails therefore give an exact Gaussian outside-box probability; a sum of marginal tails is a valid union upper bound even without independence. A separate Mills-ratio union bound, `P(Z>t)≤φ(t)/t` for t>0, avoids requiring a Normal CDF formula.

At the stored numerical mode, gradient norm is approximately `9.08e−11`, `A≈15.25I`, and the normalizer-envelope ratio is61. The resulting normalized-target tail bounds are:

| Box | Gaussian-tail union bound | Mills-ratio union bound |
|---|---:|---:|
| `[-8,8]^2` | .0319911 | .0344323 |
| `[-10,10]^2` | .000523947 | .000549243 |

These conservative analytic bounds do **not** claim that actual omitted mass is that large; the prior-based lower curvature is much flatter than the posterior near its mode. The second anchor, displaced by `(.01,−.01)`, checks the residual correction in a genuinely nonstationary case. Numerical checks compare the quadratic inequalities and completed-square identities at710 points per anchor, test Hessian brackets, and compare analytic gradients with finite differences. These tests check signs/constants and implementation; structural Hessian reasoning establishes the inequality rather than those sampled points.

For any sigmoid query `f(w)∈[0,1]`, define its exact box-conditional expectation `E_p[f|C_r]`. Writing `δ=P_p(C_rᶜ)`,

$$|E_p f-E_p[f\mid C_r]|=\delta|E_p[f\mid C_r^c]-E_p[f\mid C_r]|\le\delta.$$

Thus `.000524` (or the more conservative `.000550` Mills bound) bounds the **tail-only** probability-query truncation discrepancy at radius10. It says nothing about the trapezoidal mesh error, which remains unproved; domain/refinement agreement near machine precision still provides empirical evidence only. It also does not certify log loss, which is unbounded as the observed-class forecast approaches zero.

Coefficient moments are unbounded, so the sigmoid result cannot be applied to their mean/variance. As an optional separate first-moment check, Cauchy–Schwarz under the Gaussian envelope yields

$$\int_{C_r^c}|w_j|p(w)\,dw\le \frac{Z_B}{Z_A}\sqrt{(\mu_{B,j}^2+(B^{-1})_{jj})P_{\phi_B}(C_r^c)}.$$

Since box-conditional `|E[w_j|C_r]|≤r`, the absolute difference between full and box-conditional means is bounded by this first-moment tail plus `rδ`. The radius10 bounds are loose, about`.363` for intercept and`.439` for slope. They do not certify the displayed mean digits or small MCMC coefficient errors. No second-moment/variance certification is claimed.

The inequalities are rigorous in exact arithmetic. Reported numerical bounds use ordinary float64, not validated interval arithmetic or directed rounding. The Mills expression gives an independently evaluated conservative formula, but floating-point/special-function rounding is not formally certified. This is a stronger analytic truncation check, **not a fully certified posterior reference**. Existing finite-box trapezoidal normalizer is separately checked to lie between the computed analytic envelopes as a sanity diagnostic, with no new discretization guarantee.
