# Independent review of the L07 tail-envelope extension

Reviewer `/root/validate_reference_bounds`, 2026-10-14, isolated branch `assess-l04-l12-reconciliation-20261014`, HEAD `358fb4586de0356a3dba8236eb1bf65e5c927d64` at review. This bounded review covers the new [derivation](../../../L07_Inference/notebook_feasibility/reference_bounds.md), implementation, results and manifest extension. It does not reopen the classifier, VI, MH or sequence investigations, select a teaching route, approve a scope, assess student timing or certify a hosted runtime.

**Verdict: no mandatory mathematical or implementation repair was found.** The Gaussian-envelope argument is valid in exact arithmetic, including at a nonstationary anchor. Fresh isolated execution reproduces every JSON field exactly. The stated result concerns omitted posterior tails; it remains distinct from a trapezoidal mesh guarantee and a directed-rounding numerical certificate.

## Exact targets and replay

The following live SHA256 versions were read and validated. The dependency hashes identify the fixed model and numerical anchor without expanding this review into another assessment of their existing results.

| Target under `Lectures/L07_Inference/notebook_feasibility/` | SHA256 |
|---|---|
| `reference_bounds.md` | `05be5fa8edaf42f796712642c766ffa9a0c0af3d77b9cb5b3b128d42f202656a` |
| `reference_bounds.py` | `068acf422e33179b85e57bc67ea53aea7ddf337cc973e943ee71f85ff4e4a9e6` |
| `reference_bounds_results.json` | `38fefa2fc21dd5f9f20ff79c852224fe34ba15334d1dadda7e52f8c4105093fe` |
| `probe_manifest.json` | `60855fe2e1d06ca45cc7b19597e3ce6acbb1cd77afee0ea65feed9af7d05f990` |
| `classifier_probe.py` dependency | `519a8e8680df24818ffede2b3e40318a8a6ca45768999183192f352ee39265a3` |
| `classifier_results.json` anchor dependency | `da74dc516997234f063bdea46ef180206af60da3f2cc063c8b9fbd9c5fa40d7c` |

All **14** manifest entries match their current files. This checks integrity of the extended manifest, not a second substantive review of its other entries. The old classifier script/results are unchanged by this extension.

I copied only the two classifier dependencies and the new script/results to `/tmp/pml-reference-bound-review-20261014/`. A fresh process ran the copied script using `/tmp/pml-l04-l12-reconciliation/.venv/bin/python` (Python 3.12.13, NumPy 2.0.2, SciPy 1.16.3, scikit-learn 1.9.1). It overwrote only the mirrored results, which match the authored results exactly, including all strings, arrays and numerical values; there are no timing fields to exclude. No environment changes were made.

Independent checks are retained at that temporary location as `independent_checks.py`, SHA256 `92232f39a0fa5bdb9a3e2a30be6f3d167e739936e888cafc4385bbf9b34cb7bd`, and `independent_check_results.json`, SHA256 `f6d9e1e007f6de75344d23a1c959be628f12497e9b136bc256f9fa0edb8f5c40`. The durable report records their checks and exact outcomes below; these temporary files are not course source or another authoritative decision record.

## Mathematical verification

For the fixed logistic negative log unnormalized posterior

$$U(w)=\sum_i\left[\log(1+e^{x_i^Tw})-y_i x_i^Tw\right]+\frac{\|w\|^2}{8},$$

the gradient is `Xᵀ(σ(Xw)−y)+w/4`. Its Hessian is `B+XᵀD(w)X`, where `B=I/4` and each diagonal entry of `D` lies in `[0,1/4]`. Thus `B≼∇²U≼A=B+XᵀX/4` globally. Both bounding matrices are positive definite. Integrating the Hessian along the segment from any anchor `m` establishes the two quadratic bounds with the **actual residual gradient** `g=∇U(m)`. An exact mode assumption is unnecessary.

Completing the square for a precision `M` gives center `μ_M=m−M⁻¹g` and Gaussian-envelope integral

$$Z_M=e^{-U(m)+\frac12g^TM^{-1}g}(2\pi)^{d/2}|M|^{-1/2}.$$

The lower energy bound using `B` supplies the upper density envelope, and the upper energy bound using `A` supplies the lower density envelope. Consequently `Z_A≤Z≤Z_B`, and normalized posterior density is bounded above by `(Z_B/Z_A)φ_B`. The ratio

$$\frac{Z_B}{Z_A}=\sqrt{\frac{|A|}{|B|}}\exp\!\left[\frac12g^T(B^{-1}-A^{-1})g\right]$$

has the correct determinant direction and residual sign. Since `B≼A`, the residual contribution is nonnegative. The implementation retains it and shifts both envelope centers correctly. I independently checked the completed quadratics against SciPy's normalized multivariate Gaussian log density at 103 additional points for each envelope and both anchors; maximum log-density identity error was **1.71×10⁻¹³**.

For the upper envelope covariance `4I`, coordinate tails are independent. The outside-box probability is `1−∏_j(1−t_j)`, where `t_j` is the sum of the two marginal tails. The union bound `Σ_j t_j` is also valid and remains valid with correlated coordinates. Independent Normal survival/CDF evaluation reproduces the exact independent-tail expression, the union bound and the normalizer ratio. The Mills expression bounds each positive-threshold tail by `φ(t)/t`; substituting 1 for nonpositive thresholds is conservative. Summing and capping at 1 preserves a valid upper bound. The actual box radii have positive thresholds.

At the supplied numerical anchor, the ratio is approximately 61 and the radius 10 posterior-tail union bound is **0.0005239473112881752**; the separate Mills bound is **0.000549243199968572**. The displaced anchor has gradient norm **0.14543501384800878** and a nonnegligible log-ratio residual correction **0.04160919984190919**, so the nonstationary case genuinely exercises the required correction.

If `δ=P(Cᶜ)` and `0≤f≤1`, the mixture decomposition gives

$$E_pf-E_p[f\mid C]=\delta\left(E_p[f\mid C^c]-E_p[f\mid C]\right),$$

so its absolute value is at most `δ`. This is the correct **tail-only** bound for sigmoid probability queries. Independent conditional-mixture checks at three tail masses confirm the implementation's interpretation. It cannot be transferred directly to log loss or coefficient moments.

The optional coordinate first-moment bound follows separately from density domination and Cauchy–Schwarz:

$$\int_{C^c}|w_j|p(w)\,dw\le\frac{Z_B}{Z_A}\sqrt{E_{\phi_B}[W_j^2]\,P_{\phi_B}(C^c)}.$$

Replacing the Gaussian outside probability by its union bound is conservative. Subtracting the box-conditional mean introduces the additional term `δ|E[W_j|C]|≤rδ`, exactly as implemented. I independently evaluated the Gaussian absolute first moment outside the rectangle using independent Normal marginals; the direct expressions lie below the reported Cauchy bounds for both coordinates, both radii and both anchors. The loose radius 10 mean-error bounds, approximately `.363` and `.439`, are stated accurately; no variance or displayed-digit guarantee follows.

## Limits and downstream obligations

The 710-point tests at each anchor reproduce the quadratic, Hessian, gradient and completion diagnostics; their role is implementation consistency. The global Hessian argument establishes the analytic inequalities. The finite-box trapezoidal log normalizer lies between the envelope integrals as reported, but that is a sanity check, not a proof of the quadrature error.

There is **no required repair** for the stated author-facing result. Before claiming a fully certified posterior reference, an author would still need a valid discretization-error bound and controlled numerical rounding. Ordinary float64 special functions and Mills-formula evaluation do not establish a machine-verifiable upper bound. Any teaching use must retain the distinction between the tail-only bounded-query result, unbounded loss/moment quantities, and empirical grid agreement. These are author responsibilities; they do not introduce another instructor decision or block the independent scope investigations.
