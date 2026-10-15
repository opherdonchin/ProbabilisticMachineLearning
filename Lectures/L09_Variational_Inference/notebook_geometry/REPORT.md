# L09 candidate investigation: posterior geometry, query error and VI

**Verdict: feasible-with-risks; conditional recommendation: Challenger.** This is teacher-only computational evidence for the instructor's 2026-10-15 direction, at base `e8a0f6c`. It approves no dataset, model, family, scope or notebook. The bounded screen tested exactly two cases: multinomial Iris and one justified alternative, flight-level O-ring thermal distress. Both use the same full-Gaussian reverse-KL family for a fair comparison with full-Gaussian Laplace, plus diagonal VI to identify an additional family restriction. There was no feature, prior, split, threshold or dataset search after fitting.

Challenger gives the clearer useful contrast. At **60°F, inside the observed 53–81°F range**, the posterior probability of any thermal distress on a flight is approximately **.731342** under this model. Laplace gives **.692094**, whereas fitted full-Gaussian VI gives **.732994**. This is a 3.925 percentage-point Laplace discrepancy in a probability query, reduced to .165 points without changing the approximation family. It demonstrates a meaningful accuracy difference, rather than proving that a particular operational decision changes: no decision loss or acceptable-error tolerance has been supplied. The historical launch outcome must not be used to select the approximation retrospectively.

The [figure](challenger_geometry.svg) shows why the example is not a story of ever stronger algorithms. Local curvature places the Gaussian too near the mode for several predictions; reverse KL improves its placement but retains Gaussian shape error. At 31°F, a substantial extrapolation, the reference probability is .983105 and the full-Gaussian fit remains low by .573 percentage points. Dependence is moderate, not absent. Neither VI nor a tighter numerical reference validates the extrapolation or the logistic model.

## Fixed problems and provenance

**Multinomial Iris:** 150 real flowers, all three classes, one sepal-length predictor plus intercept, stratified 90/60 train/test split with `random_state=14`. The feature deliberately matches the existing L07 binary task; this is a bounded four-coefficient investigation, not an evaluation of the full four-feature classifier. Center/scale use training observations only. Setosa is the zero-logit reference class. The two remaining class coefficient vectors have independent `N(0,4I)` priors, fixing the otherwise redundant softmax representation. This prior on contrasts is a deliberate proper model, not a claim of class-exchangeable priors. The exact scikit-learn arrays, split indices, transformation constants and hashes are in [raw results](multinomial_iris_results.json). Scikit-learn's packaged Iris, rather than an assumed identical copy of every historical Iris transcription, is authoritative for this experiment. [Official dataset API](https://scikit-learn.org/stable/modules/generated/sklearn.datasets.load_iris.html), [UCI Iris](https://archive.ics.uci.edu/dataset/53/iris).

**Challenger:** all 23 flights in David Draper's UCI dataset, using `o-ring-erosion-or-blowby.data`, with `y_i=1` when the recorded number experiencing thermal distress is positive (7 flights). This is a binary flight-level model, not six independent ring observations. Temperature is standardized using these 23 flights; pressure is omitted as a fixed modeling simplification, not selected by this probe. The intercept and standardized-temperature slope have independent `N(0,4)` priors. Frozen query temperatures are 31,53,60,70,81°F. All 23 flights form the historical information set: there is no holdout performance claim. The question is accurate computation of the model's predictive probability, not independently demonstrated calibration on future flights.

The direct [UCI dataset record](https://archive.ics.uci.edu/dataset/92/challenger+usa+space+shuttle+o+ring) identifies two data variants: erosion-only and erosion-or-blowby differ at flight 21. Using the wrong variant would change the binary response. This probe freezes the latter, including its positive outcome at 75°F; it does not reconcile or silently mix alternate transcriptions. UCI attributes the dataset to David Draper (1993), DOI [10.24432/C5PW2T](https://doi.org/10.24432/C5PW2T), CC BY 4.0. The downloaded bytes and original `.names` documentation are included. Zip SHA256 is `efacde5516fd5d9c7ffb84332b34bdcd787f3a4a91b1e42e11fb2dcee05ded2a`; extracted data SHA256 is `7f38e97b501414fe1c08dfef29432065f0114ed997f5099ce28036086ef1c236`. The data record itself warns that 31°F is outside the previous launch-temperature range. The primary research [Dalal, Fowlkes and Hoadley (1989)](https://doi.org/10.1080/01621459.1989.10478858) establishes binomial/binary-logistic analysis as an application precedent; its accessible abstract was checked, not its complete model or Table 1. Our prior and simplified binary model are course constructions, not that paper's full risk analysis. **Thermal distress is not catastrophic failure.**

## Mathematical target and comparisons

For Challenger, `x_i=(1,(T_i−69.565217)/6.901960)` approximately; use the exact saved transformation in code/results. Let `w=(a,b)` and

$$p_i(w)=\operatorname{sigmoid}(x_i^Tw),\qquad y_i\mid w\sim\operatorname{Bernoulli}(p_i(w)),\qquad w\sim N(0,4I_2).$$

For Iris, replace the Bernoulli likelihood with three-class softmax probabilities with reference logit zero; `w` stacks the intercept and slope for each nonreference class (`d=4`). In both cases the numerical target is the **same posterior** for all algorithms. Laplace finds the MAP and uses the inverse Hessian of the negative log posterior. A Gaussian proxy's prediction is the integral of the same class-probability function, not evaluation at its mean.

For `q=N(m,LLᵀ)`, positive diagonal lower-triangular `L`, the minimized negative ELBO is

$$J(m,L)=E_{\epsilon\sim N(0,I_d)}[-\log p(D\mid m+L\epsilon)]
+\frac12\left[\frac{\|m\|^2+\|L\|_F^2}{4}-d+d\log4-2\sum_j\log L_{jj}\right].$$

Sum likelihood terms over observations; average over coefficient draws; add the prior KL once. Diagonal VI sets `L=diag(exp(rho))`; full VI supplies the strict-lower entries as extra parameters. The scale-path entropy derivative is included. With this finite design, logistic likelihood gradients have bounded data-dependent factors and Gaussian draws have finite moments, so the required locally dominated derivative condition for the pathwise interchange holds. The objective needs no posterior normalizer. Gaussian draws for optimization are not what distinguishes VI from Laplace; the distinction is global expected-log-density/entropy fitting versus local mode/curvature fitting.

All targets are globally log concave because the categorical logistic negative log likelihood is convex and the proper Gaussian prior adds curvature at least `I/4`. Thus there is one posterior mode; no multimodality failure is claimed. These targets have no special positive-parameter transformation. Standardization is an affine change of coefficients; full Gaussian families are closed under invertible affine changes **when the prior is transformed consistently**. Re-standardizing and reusing `N(0,4I)` would change the model. Diagonal restrictions depend on coordinates; nonlinear coordinate transforms could also change Gaussian approximation quality. This screen makes no intrinsic coordinate-free claim that a posterior defeats Gaussian VI.

### Actual query results

Challenger probabilities of **any thermal distress**:

| Temperature °F | Numerical posterior reference | Laplace | Diagnostic full VI | Diagnostic diagonal VI |
|---:|---:|---:|---:|---:|
| 31 (extrapolation) | .983105 | .959783 | .977380 | .976098 |
| 53 | .889514 | .850511 | .889116 | .883876 |
| 60 | .731342 | .692094 | .732994 | .729451 |
| 70 | .249548 | .266106 | .249237 | .251541 |
| 81 | .043867 | .065073 | .044830 | .041313 |
| Maximum absolute error | — | .039248 | .005725 | .007007 |

The full-Gaussian criterion improvement is distinct from removing independence. Diagonal VI already captures most of the gain here: its largest error is .701 percentage points. Approximate reverse KLs are .09526 (Laplace), .02910 (optimized full), .05281 (optimized diagonal) nats. The full-versus-diagonal objective gap `.02371` nats quantifies the extra restriction in these coordinates; it is not an error bar on the probabilities.

The checked posterior has mean `(-1.07463,-1.64510)`, marginal skewness `(-.260,-.532)` and correlation `.241`. Its mode is `(-.99055,-1.40011)`. Full VI centers at `(-1.07242,-1.63578)` but still misses skewness; its marginal SD errors are −2.38% and −6.19%, versus Laplace −5.18% and −9.23%. This is non-Gaussian, moderately dependent posterior geometry, not an approximately independent exact product distribution.

**Multinomial Iris does not establish a dramatic Laplace failure.** Across 3 fixed feature queries and 60 held-out cases, maximum class-probability errors are .012949 Laplace, .000268 full VI and .010396 diagonal VI. Marginal posterior skewness is only .12–.27, but correlations are strong enough that the best diagonal covariance has marginal SD errors roughly −42% to −51%. Full Gaussian VI's SD errors remain −1.8% to −2.6%. Numerical reverse KL is approximately .06816 Laplace, .02293 full VI and 1.15929 diagonal VI. All methods make **the same 60 class decisions**, with 20% error. Held-out log losses are .582971 Laplace, .573657 full VI, .572606 diagonal VI and .573728 reference. Diagonal VI happens to score slightly better on this finite holdout even while approximating the posterior worse. Posterior fidelity and finite-test predictive performance are different criteria. Nothing here licenses the statement that multinomial likelihood itself makes Laplace fail.

### Family error, optimizer error and integration error

`geometry_probe.py` actually runs PyTorch float64 reparameterized sampling, objective/backward and Adam for 4,000 fresh-noise updates, 64 coefficient draws per update, seeds 10/20/30. It includes both families for both cases. Laplace initializes each run; diagonal initialization uses its marginal SDs. This is cumulative reuse of supplied L07 code, not a second independent student MAP exercise. No stochastic step is claimed to improve the ELBO monotonically. Across-seed variation here measures optimizer variability, not posterior uncertainty; coefficient spread and uncertainty from finite numerical integration are separate quantities.

For Challenger, full stochastic fits have negative-ELBO gaps `.000525,.000229,.001678` above the diagnostic fit and maximum probability errors `.00680,.00579,.00943`. Diagonal gaps are `.000040,.000198,.001668`, errors `.00755,.00757,.00624`. A stochastic diagonal fit can accidentally improve a selected query relative to its own optimum; reverse KL is not that query's squared error. Iris full stochastic errors are `.00382,.00346,.00128`, larger than the `.000268` diagnostic limit; diagonal errors `.01372,.01185,.01524`. Do not attribute those optimizer gaps to an irreducible Gaussian restriction.

The diagnostic optimizer uses positive-weight numerical expectation rules and BFGS, two starting offsets (0 and .15); final objective differences across starts are recorded, not silently discarded. Challenger uses a 40×40 Gauss–Hermite objective; Iris uses antithetic scrambled Sobol Normal draws (`2×8192`) and an independent higher-resolution objective check (`2×65536`). The latter changes objectives by about `.00010` diagonal and `.000069` full nats: Iris “optimum” and gaps are numerical diagnostics, not exact certified minima. In direct `(m,L)` coordinates the exact negative ELBO is strictly convex for these models (convex expected likelihood, quadratic prior cost and convex `−log L_jj`); logarithmic-diagonal parameterization is a smooth bijection of the positive-diagonal domain. Small numerical gradients and two-start agreement support optimizer accuracy; they do not certify quadrature accuracy or a universal VI convergence guarantee.

Finite differences of the actual fixed-noise objective agree with the independent analytic gradients within `1.24e−9` for Iris and `1.98e−10` for Challenger. Separate PyTorch/analytic fixed-noise gradients agree within `7.11e−15`. The prior KL is zero at `m=0,L=2I` by the displayed formula. No source sign error is inherited.

## Numerical-reference checks and costs

Challenger has a trapezoidal reference in original coordinates. Extending `[-8,8]^2` to `[-10,10]^2` changes predictions at most `5.72e−10`; halving the latter mesh `.04→.02` changes them about `1.1e−15`. The audit also extends to `[-14,14]^2` with `.04` and `.02` meshes, agreeing to floating-point precision with one another and within about `8e−14` of the radius10 reference. An analytic Gaussian envelope from global strong convexity, retaining the MAP gradient residual, gives a numerically evaluated outside-radius14 probability bound **2.18e−9**. Its denominator is a numerical box integral, and arithmetic is float64: this is not interval-certified integration, nor does a tail bound certify mesh error. Independent inflated-Laplace `t_5` importance references agree with the grid to `2.06e−6` at `2^18` points. The reference is very well checked for these bounded probability queries; no exactness claim is made for arbitrary tail functionals.

For Iris the author reference is self-normalized importance integration with an inflated-Laplace multivariate `t_5` proposal; this has polynomial proposal tails rather than a compact integration box. There are 3 independent scrambled Sobol replications at each of `2^16,2^18` points. The last-three maximum predictive spread is `9.9e−6`; the change of replication means across powers is `1.26e−5`. Importance-weight ESS is about 182,877/262,144 in the final replication. These are useful numerical checks, not a certified error bound or an MCMC ESS. Log concavity rules out undiscovered secondary modes, but high weight ESS alone would not prove tail accuracy. No standard IID standard error is assigned to QMC points. Thus the `.000268` VI discrepancy is supported at a substantially finer numerical scale, while still approximate.

Challenger's separate one-dimensional Gaussian-logit Gauss–Hermite predictions at orders160 and240 agree within `4.2e−11`; the primary QMC approximation to Gaussian predictions differs by at most `5.5e−7`. This separates numerical integration of a fitted proxy from the proxy's posterior error.

Local measured single-run timings exclude import time: Challenger Laplace `.0021s`, stochastic VI approximately `1.8–2.0s`, full diagnostic deterministic optimization `.132s`, finest radius14 grid `7.14s`; one `2^18` importance reference `.74–.82s`. Iris Laplace `.012s`, stochastic VI about `3.4–3.5s`, deterministic diagnostic fits `14–19s`, one high-resolution importance reference `6.6–7.0s`. These scripts do **not** establish a VI speed advantage over Laplace. In this low dimension, accurate reference integration is also practical.

For repeated queries Laplace and full VI both store `d+d(d+1)/2` Gaussian parameters and have essentially the same subsequent integration/drawing cost; diagonal VI stores `2d`. This probe's deliberately large `2^17`-draw Gaussian query evaluation takes `.071s` for five binary queries and `1.61s` for 63 three-class queries. Binary queries can instead use the supplied one-dimensional Gaussian-logit quadrature; no new fit is needed per temperature. Training uses full-data likelihood gradients and no dense posterior Hessian, but full Cholesky VI still costs `O(d²)` storage/transform work. A dense Laplace Hessian costs `O(d²)` memory and an `O(d³)` factorization. A grid with `G` values per coefficient costs `G^d`; the finest 2D audit has 1,962,801 nodes and about31.4MB for its raw coordinate array alone (an array-size calculation, not measured peak RAM). These low-dimensional timings cannot establish high-dimensional practical efficiency.

## Scope and one-hour handoff proposal

The smallest revision is **replace the synthetic-regression main lab/old shared-Iris proposal with the Challenger binary-prediction problem**, keeping the existing Gaussian reverse-KL derivation, exact correlated-Gaussian diagnostic, pathwise total derivative, corrected KL convention, bounded CAVI comparison and L12 handoff intact. No architecture or map revision is proposed by this report. The synthetic Gaussian becomes a short supplied diagnostic, preserving its uniquely exact distinction between optimizer and family errors; it is not a second complete fitting exercise. Instructors should not infer that selecting this application approves the current whole L09 scope.

**Preserve derive/work depth:** diagonal reverse-KL Gaussian geometry and the pathwise mean/scale derivative stay live as currently committed. **Apply:** binary logistic negative log likelihood from L05, L06's ELBO identity, L07 supplied mode/Hessian routine. **State/recognize:** `w=m+Lε` and the Cholesky/full-Gaussian family as a supplied same-family comparator (Book2 §10.2.1.2), without a new general covariance-gradient derivation. **Bounded work:** see how the reference, Laplace and VI probabilities differ at60°F and distinguish the cold extrapolation. The reference integration and envelope proof remain author responsibilities. A non-Gaussian variational family is not required to obtain this observed improvement and was not tested; this investigation does not establish that Gaussian VI is always sufficient.

Proposed student-written work: diagonal `m+exp(rho)⊙epsilon`, the averaged full-data negative log likelihood plus one analytic prior KL, one fixed-noise gradient check, and query/error interpretation. Supply dataset loading/variant selection, fixed standardization/prior, logistic helper, Adam driver/settings, Gaussian quadrature, numerical reference, Laplace routine/results, and full-VI fit/results. Students run **one** diagonal optimizer. Their family choice is visible rather than defined as VI itself; the full-Gaussian supplied comparison isolates the fitting criterion. The L10 investigator has received full-Gaussian coordinates/objective plus the diagonal option; final cumulative selection is conditional on instructor approval.

| Activity | Estimated minutes |
|---|---:|
| Reconnect Torch parameters, draw/data axes and backward | 10 |
| Read frozen flight task, response and supplied Laplace/reference output | 8 |
| Complete sample transform and correctly scaled diagonal objective | 16 |
| Run one fit; fixed-noise derivative and diagnostic-gap check | 8 |
| Compare supplied full VI, diagonal fit and Laplace queries/geometry | 10 |
| Read exact correlated-Gaussian diagnostic; state family versus optimizer error | 5 |
| Consolidate numerical conclusion, assumptions and residual error | 3 |
| **Total** | **60** |

This estimate has **no reserve** and is not a learner pilot. Through L05, Torch/SGD is prospective, not delivered skill; after three meetings away from Torch the ten-minute refresh must stay. Generic NumPy knowledge does not establish coefficient-draw versus observation broadcasting or Cholesky fluency. CAVI code, source-data investigation, a second stochastic full-VI implementation and a new non-Gaussian-family derivation would overfill the hour. If a workload trial runs long, supply the fixed-noise check output or the exact-Gaussian diagnostic's numerical fit; preserve actual objective construction and probability comparison. Final pedagogical authoring must make those reductions explicit.

## Focused source route, unresolved decisions and gates

Read Murphy, *Probabilistic Machine Learning: Advanced Topics*, MIT Press 2023, **December10,2025 online edition**, whose date is confirmed by the [official book page](https://probml.github.io/pml-book/book2.html). Direct local source text was inspected again for this report; exact hash is in the manifest.

1. **§10.1.1.2 “The view from statistics: maximize the evidence lower bound (ELBO),” pp.440–441:** the unknown evidence is constant in variational parameters; inspect the expected-log-likelihood-minus-prior-KL sign in Eq.10.14.
2. **§10.1.2 “Form of the variational posterior,” pp.441–442:** choosing the family and choosing the optimizer are separate decisions; compare full and factorized Gaussians. The source's general overconfidence wording needs the course's query-specific qualification.
3. **§10.2.1.1 “Gaussian with diagonal covariance (mean field),” pp.447–448**, and **§10.2.1.2 “Gaussian with full covariance,” pp.448–449:** draw maps, positive scales, triangular determinant and what changes when retaining dependence. Printed Eqs.10.49–10.50 have the already documented plus-KL sign/missing-constant errors; use the corrected objective above, not those two literal expressions.
4. **§6.3.5.2 “Total derivative,” pp.276–277:** retain both direct parameter dependence and dependence through a transformed draw. No new score-function or covariance-gradient derivation is needed for the supplied full fit.

The current scope/source reviews and original classifier/pathwise probes were read and preserved. They establish the prior source arc and valid fixed-target computations, not approval of these new cases. L07's agent independently reported qualified good-Laplace binary Iris, commit `d2404b328239da604a974b173dbc1e58ddede44d`; no new L07 rerun is duplicated here. Its probability error (~1.48pp) and this mild multinomial Iris (~1.29pp) do not form a compelling “harder categorical likelihood” progression. Challenger creates the more visible query difference without changing the Gaussian pathwise mathematics.

**Instructor-owned consequential decision:** select Challenger with one student diagonal fit and supplied full-Gaussian comparator, or retain multinomial Iris accepting its smaller practical contrast. Both are serious conditional options; recommend Challenger. Gaussian VI remains a choice of approximation family, not a definitional limit. If the intended teaching consequence specifically requires a demonstrated operational decision reversal or a richer non-Gaussian variational fit, this bounded screen has **not established that endpoint**. Further investigation would require a new explicit envelope; it must not be inferred as permission for endless candidate search.

**Next owner/gates:** coordinator routes the candidate and smallest notebook/example Scope changes to the instructor; independent technical review and Scope/Section Design feasibility follow selection. Revalidate the affected notebook handoff, examples and dependent slide/section contracts, not unrelated live derivations. Then create a finalized worked solution, solved Q&A/student notebooks, a real workload trial and clean local/hosted Colab checks. None of those publication gates has passed here. No shared skill, architecture, map, old probe, scope or student notebook was changed.

## Reproduction and raw evidence

Run from the worktree root, with cache paths outside the repository:

```bash
OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1 OMP_NUM_THREADS=1 PYTHONDONTWRITEBYTECODE=1 \
 /tmp/pml-l04-l12-reconciliation/.venv/bin/python \
 Lectures/L09_Variational_Inference/notebook_geometry/geometry_probe.py
OPENBLAS_NUM_THREADS=1 MKL_NUM_THREADS=1 OMP_NUM_THREADS=1 PYTHONDONTWRITEBYTECODE=1 \
 MPLCONFIGDIR=/tmp/pml-l09-mpl \
 /tmp/pml-l04-l12-reconciliation/.venv/bin/python \
 Lectures/L09_Variational_Inference/notebook_geometry/audit_probe.py
```

The existing locked interpreter was reused read-only; no dependencies or lockfiles changed. [Runtime versions](runtime.json), [full execution log](execution.log), [audit log](audit_execution.log), [audit raw checks](audit_results.json), [Iris raw results](multinomial_iris_results.json), [Challenger raw results](challenger_results.json), [source/input/artifact hashes](manifest.json) (regenerated by `make_manifest.py` after the two probe commands), and [execution correction record](execution_notes.md) make successful and unsuccessful steps identifiable. Timings are one local machine's measurements, not Colab or student completion evidence.
