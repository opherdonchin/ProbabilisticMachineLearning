# L07 candidate: a useful local Gaussian for real binary classification

**Recommendation:** retain the already frozen binary-Iris logistic posterior as
the L07 candidate. Its Gaussian approximation is accurate enough for a bounded
first encounter with posterior-averaged prediction, while remaining visibly
approximate. There is no reason to search another dataset merely to obtain a
prettier Gaussian. This is a recommendation for instructor selection, not an
approved notebook or an amendment to the scope.

**Mode and target:** Lecture Scope revision research plus teacher-only
computational feasibility, 2026-10-15, branch
`investigate/l07-geometry-20261015`, base
`e8a0f6cc3601084714271d7c8d916803545e4fac`. The
[joint direction](../../course_architecture_scope/reconciliation/notebook_geometry/decision_and_tasks.md)
authorizes this bounded investigation. The only written files are in this
directory. Scope, maps, environment and prior probes remain unchanged.
The scope/investigation and technical-review input hashes are recorded in
[raw results](geometry_results.json). **Verdict: feasible-with-risks**, conditional
on selection, independent technical review and a one-hour workload trial.

## The task, coordinates and approximation

The practical task is forecasting whether an Iris flower is virginica rather
than versicolor from its sepal length, using 60 labeled training cases and
evaluating forecasts on 40 held-out cases. This deliberately small one-feature
classifier is a recognizable use of Bayesian logistic prediction, not a
competitive botanical classifier or a large-data benchmark. It reuses data
familiar from proposed L04/L05 work while changing the computation from point
fitting to integration over weights. The split, feature, prior and query points
were fixed by the earlier investigation; none was searched or altered here.

Use the raw-centimeter feature `a`, training mean `c=6.2733333333333325` and
training standard deviation `s=0.6843163660828879`. Coordinates are
`w=(b,β)` with `x=(1,z)`, `z=(a−c)/s`; `b` is the intercept and `β` is the
log-odds slope per training standard deviation. Both are unconstrained. Fix

$$w\sim N(0,4I_2),\qquad Y_i\mid w,x_i\sim\operatorname{Bernoulli}(\sigma(x_i^Tw)),
\qquad \sigma(t)=(1+e^{-t})^{-1}.$$

The prior is in these standardized coefficient coordinates. A new scaling with
the same numerical prior would change the statistical model. No nonlinear
reparameterization or hyperparameter estimation is involved. With all training
likelihood contributions summed once,

$$U(w)=\frac{w^Tw}{8}+\sum_{i=1}^{60}
 [\log(1+e^{x_i^Tw})-y_ix_i^Tw],\quad
 H(w)=\frac14I+X^T\operatorname{diag}(p_i(1-p_i))X\succ0.$$

The proper Gaussian prior makes `U` coercive and the Hessian makes it strictly
convex: there is one finite mode. That establishes a valid local construction,
not accuracy of all posterior queries. The existing fit gives
`m=(.0568009,1.3712899)` approximately and

$$q_L(w)=N(m,C),\qquad
C\simeq\begin{pmatrix}.090212&.014087\\.014087&.152756\end{pmatrix}.
$$

The new check finds mode-Hessian eigenvalues `6.4192,11.4698`. This is a regular
single-mode posterior with mild positive slope skew, not a boundary or separated
mode example. In the chosen coordinates, the reference mean is
`(.0673963,1.4619808)` and covariance is
`[[.0944083,.0153105],[.0153105,.1643641]]`.

## What the evidence actually supports

The existing classifier predictions and held-out scores were already independently
replayed in the [inference technical review](../../course_architecture_scope/reconciliation/reviews/inference_probe_validation.md).
They are reused, not recomputed as new evidence. New work in
[geometry_probe.py](geometry_probe.py) asks whether that positive prediction
result conceals a serious distributional mismatch, and whether a cheap Gaussian
query implementation gives the same answer as the existing implementation.

| Quantity | Checked result | Consequence |
|---|---:|---|
| Largest probability error over five fixed queries and 40 held-out cases | `.0147764` | At most 1.48 percentage points for these queries; no uniform input-domain guarantee. |
| Held-out mean negative log score, reference / Laplace / point / frequency | `.578677 / .578455 / .577904 / .693147` | The model beats a fixed `.5` forecast here; the tiny method-score differences cannot establish general predictive superiority. |
| Laplace mean error, in reference marginal SDs | `−.0345, −.2237` | The mode is a reasonable center, but differs detectably from the slope mean. |
| Laplace SD relative error | `−2.25%, −3.60%` | Modest spread underestimation, not exact uncertainty. |
| Reference marginal skewness | `.0348, .3341` | The slope is mildly asymmetric; single-mode does not mean Gaussian. |
| Reference marginal excess kurtosis | `.0694, .2158` | Tails depart from the local quadratic fit. |
| Numerically integrated `KL(p_box ∥ q_L)` | `.0417381` nats | Small aggregate discrepancy for this target; this is a diagnostic, not the fitting objective. |
| Numerical half-L1 density discrepancy on the box | `.0710636` | Some bounded event queries can differ more than the tested predictive means. |
| Reference mass inside nominal 50/90/95/99% Laplace ellipses | `.48823 / .88085 / .93282 / .97997` | The Gaussian ellipses under-cover slightly; nominal 99% becomes about 98%, so relative tail error matters. |

Here `p_box` is the exact target conditioned on the integration box, itself
numerically approximated. The half-L1 result compares its density with the
unconditioned Gaussian on that box; Gaussian mass on the box numerically equals
one. It is therefore a useful approximation to full total variation, not a
certified full-target bound. A posterior ellipse containing 95% probability
under `q_L` is a parameter uncertainty region, not a 95% prediction interval for
a Bernoulli outcome or a Monte Carlo confidence interval.

For this low-stakes teaching task, a candidate acceptance criterion of no more
than two percentage points error on the specified probability queries would be
met. That threshold is a proposed teaching criterion, not an externally imposed
scientific tolerance. A stricter requirement, a rare-event query or a different
feature/prior would require fresh checks. “Good Laplace” here means useful
predictions and moderate central uncertainty error, not exact Gaussianity.

### Reference checks and limits

The existing trapezoid reference widened `[-8,8]^2` to `[-10,10]^2` holding
spacing `.08`, then refined `.08→.04`, changing predictions by less than
`4e−15`. The independent reviewer also used radius 14 at spacing `.04`, checking
moments, covariance and predictions. Existing Gaussian expectations passed
24/32-node tensor Gauss–Hermite checks.

The new geometry computation independently widens radius 8→10 at spacing `.04`
and refines `.04→.02` at radius 10. Moments, skewness and KL stabilize near
roundoff. The nonsmooth absolute-density integral changes by `1.04e−6`, so its
last digits must not be treated like smooth-moment precision. Ellipse probability
is integrated directly in Laplace-whitened polar coordinates: Gauss–Legendre
radial 32→64 points and periodic angular 64→128 points agree to `2.3e−16`.
This avoids treating a discontinuous ellipse indicator on a square grid as a
high-accuracy probability integral. The shared normalizer remains the checked
finite-box normalizer.

The existing [tail-envelope analysis](../notebook_feasibility/reference_bounds.md)
uses global Hessian bounds and the nonzero numerical gradient residual to bound
radius-10 omitted target probability by `.000524` (`.000550` via a conservative
Mills formula). This bounds tail-only error for sigmoid queries in `[0,1]`;
it neither proves mesh error nor certifies unbounded coefficient moments, KL or
log score. Ordinary float64 is not interval arithmetic. Neither plots nor
refinement agreement constitute an analytic error certificate.

## Computational payoff and limits at scale

At `d=2` the reference is cheap. Laplace is useful here as an understandable
distribution approximation whose error can be checked, not because two-dimensional
integration is impossible. The `.04` reference has `251001` points; storing only
its two-coordinate nodes and normalized masses needs about 6.0 MB. The new
geometry run retains more arrays (30.1 MB by explicitly summed stored-array
sizes at `.04`, 120.2 MB at `.02`; these are not measured peak RSS). Its three
integrations plus checks took about 2.35 seconds locally, with radius-10 `.04`
geometry integration about `.34` seconds. These are author-machine measurements, not
runtime promises or learner timings.

The fitted Gaussian requires 48 bytes for the two mean and four covariance
entries. For any query `x`, Gaussian linear transformation gives

$$A=x^TW\sim N(x^Tm,x^TCx),\qquad
 r_L(x)=E[\sigma(A)].$$

Thus each predictive mean needs a one-dimensional numerical integral regardless
of `d`; it does not need tensor quadrature in coefficient space or posterior
samples. A supplied 32-node Hermite implementation agrees with the existing
two-dimensional result to `5.6e−16`. Seven evaluations of 100 new standardized
inputs in `[-2,2]` took median `.033` milliseconds (first run `.050` ms). These
timings show the bounded implementation works; they do not constitute a fair
end-to-end fit-versus-reference speed benchmark. The old approximately one-second
classifier probe includes fitting and several references together, so its timing
cannot be called Laplace fit time.

For `n` observations and `d` dense coefficients, each objective/gradient pass is
`O(nd)`, forming a dense Hessian is `O(nd²)`, and its factorization is `O(d³)`
with `O(d²)` storage. An optimizer uses multiple passes. Once fit, a logit mean
and variance cost `O(d²)` per dense query, followed by fixed-node scalar
integration. A product grid with `k` values per coordinate instead needs `k^d`
target evaluations; normalizing it does not remove this growth. Laplace's payoff
is moderate `d`, a trustworthy local Gaussian and many queries; Hessian cost,
weakly identified directions and important nonlocal structure limit that payoff.

## Proposed hour and the smallest scope implication

Preserve the scalar Taylor/normalizer derivation and logistic-curvature argument
at their existing live depths. **Proposed notebook-only change:** use one actual
two-coefficient application in place of the complete eight-observation scalar
lab. The latter can remain a supplied/live diagnostic if the instructor wants
its visible skew error; it must not become a second full lab. The multidimensional
formula is stated live and applied with a supplied Hessian scaffold. No solver,
automatic-Hessian, numerical-integration or plotting tutorial is added.

| Estimated minutes | Responsibility and code ownership |
|---:|---|
| 7 | Recover task, training-only scaling, coefficients, prior and held-out query. Supply loader/split/standardization and labeled design arrays. |
| 12 | Students form stable logistic-plus-prior objective and complete/check curvature from the given formula; supply optimizer wrapper and dimensional scaffolding. |
| 9 | Students construct/use the Gaussian from the supplied fit, check positive curvature, and compare its center/spread with reference summaries. Supply factorization/ellipse plotting. |
| 12 | Students normalize supplied weighted grid values and compute moments; supply mesh, endpoint weights, evaluation batching and plots. |
| 10 | Students compute weighted predictive means and compare point/Laplace/reference forecasts and the supplied held-out score table. Supply scalar-Gaussian integration helper. |
| 5 | Students inspect independent domain/spacing checks through a supplied harness; preserve a deliberately too-narrow-domain warning without another fit. |
| 5 | Debugging and interpretation of why this approximation is sufficient for these queries and what is not established. |

This sums to 60 minutes as an **estimate**, not a completed student pilot.
Writing a two-dimensional mesh, implementing polar integration, computing KL,
deriving matrix calculus and constructing a score pipeline are excluded from
student-written work. The teacher geometry diagnostics screen the example; they
need not become extra curriculum. If the pilot overruns, supply more mesh and
comparison mechanics before cutting independent refinement or predictive use.
No prior-sensitivity exercise fits the core estimate.

The entry knowledge file supports familiar Bayes, regression, expectations and
basic NumPy. Gaussian matrix operations remain scaffolded. L05's proposed binary
likelihood/gradient supports the posterior objective; Hessian use and numerical
normalization remain new. Actual teaching is still unrecorded in the empty
actual map, so these are prospective dependencies, not claims of delivery.
The actual prepared L01 deck already introduces Iris task/experience/performance,
Gaussian geometry and conditioning. Its hash is included among the inputs;
prepared material still does not establish fluent mesh or matrix programming.

**What students could subsequently approach:** a small Bayesian binary GLM with
moderate coefficient dimension and a regular mode, for which they can fit a
Laplace Gaussian, obtain coefficient uncertainty and averaged probabilities, and
challenge reference/domain checks and model mismatch. This is guided first use,
not competence with every GLM, a guarantee of calibration or a rare-tail solver.

## Sources, provenance and next owner

Dataset provenance was rechecked against primary sources. The
[UCI Iris record](https://archive.ics.uci.edu/dataset/53/iris) documents the real
classification dataset. The
[scikit-learn loader](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_iris.html)
and [dataset description](https://scikit-learn.org/stable/datasets/toy_dataset.html#iris-plants-dataset)
document that its distributed data correct two entries from UCI's older copy.
Those rows are setosa, outside this binary target; nevertheless the installed
scikit-learn data, rather than an unspecified “UCI Iris” file, define the exact
input. Row IDs, transformations and full array hash are retained in results;
the installed CSV hash is `f13ffa8f…9d1449`. No external data access is required
when running the actual probe. [Source records](source_records.json) preserve
retrieval URLs, dates, exact downloaded-byte hashes and local evidence paths.

Focused verified reading, directly checked in the available book extractions:

- Murphy, *Probabilistic Machine Learning: Advanced Topics*, online edition
  December 10, 2025: §7.4.2 **Grid approximation**, pp.350–351, for weighted
  finite-grid probability and dimension cost; §7.4.3 **Laplace (quadratic)
  approximation**, pp.351–352, for Taylor expansion, inverse Hessian and the
  skew/support warning. Keep the exact normalizer `Z` distinct from `Z_L`.
- Same edition: §15.3.5 **Laplace approximation to the posterior**, pp.613–615,
  Eq.15.145, for Bayesian logistic application; §15.3.6 **Approximating the
  posterior predictive distribution**, pp.615–616, especially Eqs.15.146 and
  15.148, for averaging the sigmoid and Gaussian logits. The printed prior
  variance-limit explanation is reversed: small variance shrinks strongly,
  large variance weakly. No source probit shortcut is needed here.
- Murphy, *Probabilistic Machine Learning: An Introduction*, April 18, 2025
  online edition: §4.6.8.2 **Quadratic (Laplace) approximation**, pp.152–153,
  and §10.5.1 **Laplace approximation**, pp.363–364, offer the shorter parallel
  route. The source derivations motivate the method; they do not establish this
  course-constructed binary feature/split/model's empirical accuracy.

The existing source register records PDF hashes `54d6bfa8…fdbaf` (Book 2) and
`89749245…742dcf` (Book 1); this investigation records hashes of the actual
extractions inspected. It did not redownload or newly authenticate those PDFs.

**Decision returned to coordinator:** select or reject this bounded positive-regime
candidate and the stated notebook-only replacement. No L09/L10 family or dataset
is imposed; they can refer to these supplied L07 outputs or revisit the method
on another problem. If a substantially more Gaussian posterior is required,
first state which query/tolerance fails here; another dataset search is not yet
justified. This decision blocks final worked-solution and notebook authoring and
the affected scope handoff/example commitments. It does not block independent
source checks or L09/L10 screening.

**Separate remaining gates:** independent technical audit of these new diagnostics;
Scope reconciliation and consequential instructor approval; required Section
feasibility review if the adopted change invalidates its earlier target; final
worked-solution handoff; solved Q&A/student derivation; measured workload trial;
clean local locked-uv and hosted Colab checks. This script passed a fresh local
process using the allowed locked interpreter without environment changes. No
student notebook, Colab run, pilot, new independent review or scope approval is
claimed.

Reproduce from repository root:

```bash
/tmp/pml-l04-l12-reconciliation/.venv/bin/python -B Lectures/L07_Inference/notebook_geometry/geometry_probe.py
```

The JSON is the complete successful raw output. There were no computational
probe failures or alternative-target trials in this bounded investigation.
