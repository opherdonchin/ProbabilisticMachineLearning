# L07 — Approximate a posterior, then check what the approximation misses

**Status:** Rewritten for an instructor familiar with the course through L03–L04. The [course register](../course_architecture_scope/STATUS.md) records the exact current review and instructor-decision status. Lecture times are estimates; future notebooks have not been implemented or run.

**How to read this scope:** Parts 1, 3 and 5 explain the teaching proposal without requiring knowledge of Murphy's books. Part 2 gives the mathematics needed by later authors. Part 4 identifies the examples and their sources. “Derive” means show the calculation; “state” means explain the result without proving it; “apply” means use something already taught. Live teaching and the separate notebook session have their own budgets. These are lecture-wide commitments, not a section or slide outline. Every later section must finish by summarizing what it taught; connections to earlier work belong at the beginning of the receiving section.

## 1. Intellectual arc

A fitted best coefficient is only one point. Bayesian inference asks for a distribution over plausible coefficients, and predictions should average over it. This lecture builds a simple approximation: find the posterior's peak, measure how sharply it curves there, and fit a Gaussian to that local shape. This is the *Laplace approximation*. In a one-parameter example, students can also calculate the posterior on a fine numerical grid and see where the local approximation differs.

The example extends L05's yes/no regression to an unknown coefficient with a Gaussian prior. Students bring Bayes' rule, Gaussian shapes and a first derivative. Second derivatives as measures of posterior curvature are new here.

1. **Different questions require different computations — 16 minutes.** Separate normalizing a posterior, finding its highest-density point, calculating its mean/spread and averaging predictions over it. A known Gaussian or small finite table allows exact calculations; a general posterior may not. Structure can simplify some problems, but algorithms for long sequences belong to L08. End by summarizing the question/computation distinctions.
2. **A peak is not a distribution — 20 minutes.** Explain why the posterior mode (a point of maximum density, often called MAP) does not give uncertainty or necessarily equal the posterior mean. Work a short change-of-coordinate example showing that a continuous density peak can move under transformation. Then normalize a one-dimensional grid using integration weights. Distinguish probability assigned to a small grid interval from density height. Check both grid spacing and the interval covered; a plot that sums to one can still omit important tails. End with what a numerical grid can and cannot establish.
3. **A Gaussian from curvature around the peak — 32 minutes.** Expand negative log posterior to second order at an interior stationary point. Its positive curvature becomes Gaussian precision, the inverse of variance. Derive the scalar normalizer, then state the multidimensional version using L01 Gaussian notation. Explain why a flat direction, boundary peak, separated peaks or marked skew limits this approximation. An optional Beta example shows a Gaussian assigning mass outside the parameter's allowed range. End with the construction and its actual conditions.
4. **Test the approximation on one regression coefficient — 30 minutes.** Add a proper Gaussian prior to the familiar binary likelihood. Derive posterior curvature and show it is strictly positive. The prior also makes negative log posterior increase without bound far away, giving a finite unique mode even with separated labels. Compare the Laplace center/spread and predicted yes-probability with a grid checked by widening its interval and refining its spacing. Summarize later options in plain terms: exact structured calculation (L08), optimizing a simpler distribution (L09) and drawing dependent samples (L10). End by summarizing query-specific strengths and limitations, not a teaser for the later methods.

**Time:** **110 live minutes** (98 teaching plus 12 questions/slippage), and **60 minutes** for the separate notebook. Tight and unmeasured, with new grid and curvature bookkeeping. First remove the optional Beta calculation and multidimensional determinant illustration, about 6–8 minutes; retain the multidimensional statement, scalar normalization, conditions, logistic example and grid checks. No required recording. Do not resolve an overrun by calling an unchecked grid “exact”.

**Alternatives considered:** A conjugate Beta example would provide analytic truth with less computation but offer less progress beyond earlier conjugacy. A broad survey of all inference methods would leave little time to understand any one. The selected fixed eight-observation regression makes the local-versus-whole-distribution difference concrete without a new data-processing task.

**Rough authoring check:** four major responsibilities, 8–10 substantive source-page equivalents, 10–12 new equation/result families, 12–18 repeats of earlier formulas, 8–11 intermediate algebra blocks and 5–6 conceptual picture groups give the earlier approximate 19–23 content-slide-equivalent warning. This is not a slide target or time validation. L01's 61 content slides are a comparison anchor; the Taylor and grid portions need actual timing later.

## 2. Mathematical spine

Use scalar coefficient θ, natural logarithms and sigmoid `s(a)=1/(1+e^(−a))`. Let `u(θ)=p(θ)p(D|θ)` be unnormalized posterior density and `E(θ)=−log u(θ)`. E is a function of the coefficient, not a physical energy assumption. Additive constants do not change the shape or mode but matter for the integral of u.

| Mathematical commitment | Purpose and treatment |
|---|---|
| `p(θ\|D)=u(θ)/Z`, `Z=∫u`; mean of g `∫g(θ)p(θ\|D)dθ`; prediction `∫p(y*\|x*,θ)p(θ\|D)dθ` | Apply Bayes/expectations and motivate the separate questions. Evidence Z is named as the normalizer; model selection is not taught. |
| For `r=f(θ)`, `p_r(r)=p_θ(f⁻¹(r))\|d f⁻¹/dr\|` | State and work one normal-to-lognormal mode example. The derivative factor adjusts density under the coordinate change; no general transform-calculus development. Continuous density MAP differs from L04's discrete-message probability decision. |
| `Z_grid=Σ_j u(θ_j)ω_j`; grid masses `w_j=u_jω_j/Z_grid`; `E[g]≈Σ_jw_jg(θ_j)` | Derive/work integration weights. For equal-width intervals Δ, density is `w_j/Δ`, not w_j. Motivate subtracting a common maximum log value before exponentiating to avoid numerical overflow/underflow; implementation belongs to lab. |
| `E(θ)≈E(hatθ)+(1/2)H(θ−hatθ)²`, `H=E''(hatθ)>0` | Derive carefully. The first derivative vanishes at an interior differentiable stationary mode; a boundary maximum does not justify this step. Nonnegative curvature alone is insufficient for inverse variance. |
| `q_L=N(hatθ,H⁻¹)`; `Z_L=e^(−E(hatθ))√(2π/H)` | Derive scalar normalization. Z_L approximates the original integral Z; it exactly normalizes only the quadratic surrogate. The approximation's mean is the selected mode, not necessarily the true mean. |
| In d dimensions, `q_L=N(hatθ,H⁻¹)`; `Z_L=e^(−E(hatθ))(2π)^(d/2)\|H\|^(−1/2)` | State/explain; H is the symmetric Hessian matrix of second derivatives and must be positive definite. Determinant illustration optional. No error-rate theorem or general Hessian survey. |
| Regression `E=θ²/(2τ²)+Σ_i[log(1+e^(x_iθ))−y_ix_iθ]+constant` | Work: familiar Bernoulli likelihood plus Gaussian prior variance τ². No intercept in this specific example. |
| `E'=θ/τ²+Σ_i x_i(s_i−y_i)`; `E''=τ⁻²+Σ_i x_i²s_i(1−s_i)>0` | Apply first derivative, derive second derivative, sketch finite unique-mode reasoning from strict convexity and growth at infinity. No second-order optimizer/IRLS derivation. |
| Laplace mean `hatθ`, variance `1/E''(hatθ)` versus numerical posterior moments | Work/compare local approximation with checked full-distribution integration. Local curvature is not a guaranteed true posterior variance. |
| `P(y*=1\|x*,D)=E_p[s(x*θ)]` versus `s(x*hatθ)` | Apply/compare prediction by averaging with prediction at one point. In general averaging a nonlinear function differs from applying it to the mean. No extra sampler or analytic probit approximation. |

The Laplace method is not introduced as minimizing a particular KL divergence. L06's bound only helps recognize later methods; its full derivation is not repeated. L08–L10 own their respective algorithms.

## 3. Notebook handoff — check a one-coefficient posterior

The lecture fixes the model, prior, curvature and integration logic. Students calculate the negative log posterior and curvature, find the mode through a supplied solver, construct weighted grid probabilities and compare means, standard deviations and predictions with the Gaussian approximation. The important new skill is challenging a numerical reference, not trusting a normalized plot.

**Students write/check:** stable posterior/curvature operations, probability-weight normalization, moment/prediction calculations and interpretation of separate spacing/domain checks. **Supplied:** the fixed data, solver wrapper, grid points/integration weights, plots and comparison table. NumPy/SciPy/Matplotlib suffice. No new probabilistic-programming library, automatic-Hessian tutorial, external data or sampling exercise.

Allocate 8 minutes to the model/axes, 12 to posterior/mode/curvature, 15 to grid probabilities/moments, 12 to widening/refining checks, 8 to prediction/comparison and 5 to debugging/interpretation. Prior sensitivity is optional outside the core hour. Refine spacing while holding interval fixed, and widen interval while holding spacing fixed, so the two error sources can be distinguished. A deliberately narrow interval shows how normalization can look correct despite lost probability.

Check near-zero derivative at the computed mode, positive curvature, normalized masses and stable mean/standard-deviation/prediction under refinements. Low boundary density and stability support credibility but do not certify a tail-error bound. Later authoring chooses and times tolerances, including the numerical integration used for Gaussian predictions. Separate numerical integration error from genuine Laplace approximation error.

No required recording, executed course notebook or Colab compatibility claim. A worked solution, workload pilot, local uv run and hosted Colab run remain downstream obligations.

## 4. Concrete examples and source checks

### Primary regression, course-created data

`x=(−2,−1.5,−1,−0.5,0.5,1,1.5,2)`, `y=(0,0,0,0,1,1,1,1)`; observations are conditionally independent with `Y_i|θ~Bernoulli(s(x_iθ))`; prior `θ~N(0,4)`, so `τ=2`. There is no intercept. The labels are separated: increasing a positive slope improves the unregularized likelihood indefinitely. The Gaussian prior produces a proper posterior and finite unique mode.

At θ=0, `E'(0)=−5` and `E''(0)=4`. A builder scratch calculation gives mode `≈2.272283`, curvature `≈0.734161`, Laplace standard deviation `≈1.167090`; checked grid mean/standard deviation `≈2.688288/1.199567`. At new `x*=1`, point-mode prediction is `≈0.906555`, grid-averaged prediction `≈0.901938` and Laplace-averaged prediction `≈0.863072`. Thus an approximation can look plausible while giving a different answer to the prediction question; it is not uniformly better than a point prediction on every example.

Standard-library root finding and trapezoidal integration checked intervals `[-8,8]`, `[-12,12]`, `[-16,16]` and spacings 0.004/0.002, stabilizing those rounded values. These are mathematical checks of our fixed example, not notebook execution or a proven tail bound.

### Short coordinate and support examples

- Course-created `Θ~N(0,1)`, `R=e^Θ`: transforming the normal mode gives 1, but the transformed density peaks at `e^(−1)` because of the density-adjustment factor. The underlying probabilities transform consistently; density height is coordinate-dependent.
- Optional Book 2 §7.4.2/Fig. 7.3: 10 heads, one tail and uniform prior yield `Beta(11,2)`, with mode 10/11 and mean 11/13. A Gaussian on the probability coordinate places some mass outside `[0,1]`. Interpret the failure, no second posterior derivation/lab. A coordinate transformation would require its derivative factor and would change the mode question.

**Text sources:** Book 2 Ch. 7 §§7.1–7.5, especially §§7.4.1–7.4.3, pp. 349–352/Eqs. 7.24–7.28; §15.3.5/Eq. 15.145 and §15.3.6/Eq. 15.146 supply the logistic application and predictive integral. Book 1 §4.6.8.2 and §10.5.1 support Gaussian/Taylor and logistic exposition. Book 2's reversed prior-variance limit explanation is corrected here: smaller variance shrinks more strongly, larger variance less strongly. Available Figs. 7.1/7.2/7.3/7.6 are context; only the optional Beta mathematics is selected. About 5–6 conceptual visual groups, no exact reproduction or layout commitment.

**Computational reference:** [Berkeley Stat 238, scalar posterior example](https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/), inspected source SHA-256 `539be24de77588d434e7a52de238194cfafa8938f7bfe8590fba6eab36496c63`. Its scalar case uses 30 simulated observations, `x=linspace(−2,2)`, prior standard deviation 2, SciPy helpers and a fixed `[-8,8]` 10,000-point grid. We retain the method, replace its data with the fixed eight observations above and add checks. We omit its approximate-distribution method, eight-parameter frogs example and sampling comparison. Stored scalar grid mean 2.778 and Laplace mean 2.523 contradict its prose claim of agreement to two or three decimals; neither that claim nor its “exact grid” wording is adopted. Source inspection is not execution.

### Evidence about the earlier course

L01's actual slides and missing-data solution establish joint and conditional probabilities, Gaussian conditioning and numerical checks. The solution hides three coordinates of a known seven-dimensional Gaussian; it compares a numerical calculation with the exact conditional distribution. It does not teach how to estimate the unknown Gaussian parameters or prove a sampling algorithm correct. L02's agreed `section_design.md` promises exponential-family distributions, derivatives of their normalizing function, likelihood moment matching and simple categorical/Markov-chain fitting. These are planned prerequisites, not evidence that L02 has already been delivered. If delivery changes, the coordinator must revisit the affected prerequisite and time budget.

The material ledger's recorded delivered boundaries remain Book 2 §2.3.2 and Book 1 §3.3. The actual L01/L02 files are protected. L02's malformed development-state text does not establish additional approval. The [source-inspection register](../course_architecture_scope/source_inspection.md) identifies the textbooks and reference files inspected for the proposal: Murphy Book 2, online edition December 10, 2025; Book 1, April 18, 2025. Source inspection is not notebook execution.

**Original proposal provenance:** `/root/build_l04`, 2026-10-11; checkpoint `791e71b`, contract v2 blob `12ae5e1608eb2d74c6c70ba857eb5a75ff2114c1`. Readability revision `/root/readable_early` preserves the fixed-data model, derivations, numerical targets, live/notebook time and code ownership. L04's smaller parity code changes no prerequisite used here.

## 5. Lecture contract

**Start:** Bayes/Gaussians from L01, agreed L02 distribution work, L05 binary likelihood and gradients, and L06's distinction between hidden-value inference and fitting. **Question:** how can a best-fit point supply a distribution approximation, and how can a checked integral reveal its errors? **Lecture result:** derive and normalize the scalar Laplace approximation under its conditions, apply it to one regression coefficient and distinguish mode, approximate spread, numerical posterior moments and prediction. **Lab result:** a grid reference challenged by two independent refinement checks and compared for specified questions. No required recording.

Students can identify which computation their question requires, derive the local Gaussian, explain positive curvature/interior-mode requirements and assess approximation discrepancies. Core source coverage is selected §7.4.3, numerical §7.4.2, logistic §15.3.5 and selected §7.5; §§7.1–7.3/§7.4.1 and the predictive integral are short bridges. This is not blanket teaching of Ch. 7.

Exact sequence calculation is deferred to L08, optimizing a restricted distribution to L09 and sampling theory to L10. Sequential Monte Carlo, a method maintaining a population of samples as observations arrive, is named only and omitted substantively. Wider difficult-posterior tours, multiple-mode approximations, transformed/constrained Laplace, evidence-based model comparison, full Bayesian-GLM methods and frogs/reference extensions are omitted (Book 2 §7.4.6/Ch. 13, §7.4.7 and advanced extensions). Students will not be equipped to handle every high-dimensional posterior; the gain is one understood approximation and an honest checking procedure.

**Remaining oversight:** the controlled dataset replaces a richer/random application and makes skew/prediction differences easy to check. The numerical-grid hour may still be demanding; supply solver/mesh/plots, remove optional sensitivity first and retain both refinements. An optional Beta illustration is expendable. Further changes to endpoint or core depth require scope review rather than calling a rough grid a gold standard.
