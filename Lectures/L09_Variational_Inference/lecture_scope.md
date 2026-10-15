# L09 — Fitting a simpler distribution when the posterior is hard to compute

**Application decision, current discussion 2026-10-15:** The instructor selected Challenger flight-level thermal distress for the cumulative Laplace → VI notebook comparison. The [accepted direction and boundaries](reconciliation/challenger_contract.md) fix all 23 erosion-or-blowby flights, any thermal distress as the response, standardized temperature plus intercept and prior `N(0,4I₂)`. The notebook/example passages below reconcile that selection. The whole Scope, student/supplied family allocation and any numerical accuracy requirement remain provisional; application selection does not approve them.

**Cumulative direction:** Revisit Laplace on this same posterior before comparing VI. The instructor's [joint direction](../course_architecture_scope/reconciliation/notebook_geometry/decision_and_tasks.md) then asks L10 to revisit the selected VI family before MCMC; dataset continuity is optional. The proposed minimal route here is one student diagonal fit plus a supplied full-Gaussian comparison. L10 could revisit the **supplied full family**, but must not call that reuse of the student's diagonal implementation. That family-allocation/continuity choice remains for the instructor via the coordinator. No live derivation, mathematical depth or time has been added by the application choice. See the [bounded handoff review](reconciliation/challenger_handoff_review.md) for evidence, open decisions and dependent checks.

**Status:** Rewritten for an instructor familiar with the course through L03–L04. The [course register](../course_architecture_scope/STATUS.md) records the exact current review and instructor-decision status. Lecture times are estimates; future notebooks have not been implemented or run.

Suppose two regression coefficients can compensate for each other: several combinations fit the data almost equally well. A best-fit pair hides that uncertainty. Ideally we want the posterior distribution over both coefficients, but in a more complicated model it may be expensive to compute. This lecture chooses a simpler distribution and adjusts it to approximate the posterior.

This is **variational inference (VI)**: optimize a distribution within a chosen family, rather than only a best-fit coefficient vector. The live derivations use a Gaussian with a separate mean and variance for each coefficient, but no correlations. We ask how to adjust its means and spreads, and what uncertainty this restriction can lose. A small Gaussian regression problem supplies an exactly solvable diagnostic. The accepted practical application is Bayesian prediction of any thermal distress from flight temperature; it lets us compare Laplace and VI on the same non-Gaussian posterior. Gaussianity and independence are choices of family, not the definition of VI.

**What earlier lectures supply:** L01 gives Gaussian conditioning and the exact known-noise regression posterior. L02's agreed plan supplies distribution moments; L05 supplies automatic differentiation, stochastic gradient descent and first PyTorch practice. L06 proves the identity connecting an approximate distribution's objective to its difference from the true posterior. L07 and L08 supply checked approximate and exact inference examples. These future plans are not already delivered material; the protected delivered boundary remains B2 §2.3.2/B1 §3.3. The notebook includes a ten-minute PyTorch refresh after three intervening meetings.

**Choice and cost:** Challenger replaces synthetic regression as the main lab application. Its 23 historical flights make data handling small, while the temperature-dependent probability query has a visible Laplace discrepancy that a full-Gaussian reverse-KL fit reduces. This is a course-constructed binary model of thermal distress, not catastrophic-failure risk or a launch policy. All flights enter the posterior: there is no held-out calibration claim. The exact Gaussian remains a bounded live argument and supplied diagnostic, rather than a second complete lab fit. The proposed supplied full-Gaussian comparison separates a change of fitting criterion from imposing diagonal covariance; it adds interpretation time, not a second student optimizer. The prior GDP/ruggedness example remains inspected source precedent, with no required GDP fitting or noise estimation.

A second possible main example is to update approximate distributions one coordinate at a time for L03's image model. That would reconnect to image restoration, but a full derivation and solver would displace the differentiable sampling skill needed in L12. Keep only a short coordinate-update example on the same Gaussian target. No new software library or required advanced sampler is introduced.

<details>
<summary>Source verification and original build record for later authors</summary>

The material below records exactly which sources were inspected. B1 and B2 mean Murphy's first and second books. Section and equation numbers identify source passages; they do not require familiarity with the surrounding chapters. These notes are for checking the later teaching material, rather than for understanding this proposal.

**Stage/mode:** Lecture Scope / BUILD. **Builder thread:** `/root/build_l03`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; input checkpoint `9b62b6c7033f64399c81f5ba6be6a96b95ae4e68`. **Upstream:** architecture contract v3, blob `54064183398bd643a895c5e38a023f793dc2d9d6`; autonomous authority in `WORK_ORDER.md`. Only this Scope is owned here; no sections, slides, notebook code or shared edits.

**Direct B2 inspection:** December 10, 2025 edition, local PDF identified in architecture/source register; `/tmp/pml-book2.txt` §§10.1.1–10.1.2 (printed pp. 439–442), §10.1.4–10.1.5 (pp. 444–445), §10.2.1/§10.2.1.1 (pp. 446–448), selected §10.2.1.5 (pp. 450–451), §§10.3–10.3.1 (pp. 455–457), §10.3.2 inspected only as another mean-field application; §§6.3.3–6.3.5.2 (pp. 273–277). B1 adds no required new coverage: the Gaussian/backprop scaffolding already has course owners. Book 2 remains the spine.

**Source discrepancy:** coordinator's `source_inspection.md` records visual inspection of original printed p. 448: Eq. 10.49 has an erroneous plus-KL sign and Eq. 10.50 omits the constant. Direct algebra below uses **expected log likelihood minus KL**, and `KL(N(m,diag(s²)) || N(0,I)) = (1/2)sum_j(m_j²+s_j²−1−log s_j²)`. Also distinguish standard deviation `s` from covariance `diag(s²)` throughout; do not inherit ambiguous source notation. These are corrected expressions, not literal reproduction of the defective equations.

**Inspected reference:** [linreg_bayes_svi_hmc.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb), local pyprobml path `notebooks/book2/10/linreg_bayes_svi_hmc.ipynb`, checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA-256 `415b81857e37701258718392c3c05db9a903f768ab59a54b03f438f211c204a1`. It downloads country ruggedness/GDP data, log-transforms GDP, includes Africa/interactions, unknown Uniform noise scale, Pyro autoguides, NUTS, and both diagonal/full-covariance fits. It is an inspected application precedent, not a validated course solution; no downloaded dataset, fitted result or runtime was verified here.

**Original upstream version references:** L05 scope blob `736943b90f24826e29955115896929742f2961f5`; L06 `326267281c6b6775ac9a33d7ed4f022a859fc49b`; L07 `f12fba8de7339675d09a771c5f956c8ed93649d8`; L08 `b7a2de325c364bcde8230c33aaba2a5cd6b8596a`.

</details>

## 1. Intellectual arc — what the lecture explains, in order

These are the lecture's main jobs, rather than final section boundaries. Later section design can split or combine them without changing the promised mathematics, outcomes or time. Explain necessary connections at the start of the receiving section. End every section with a summary of what it has taught. Notebook instructions remain a separate item. All required material is taught live; no recording is a prerequisite.

### A. Choose a family of simpler posterior distributions — 16 minutes

Recall L06's result: the log probability of the data equals an approximation objective F plus a nonnegative **Kullback–Leibler divergence (KL)** from the approximation to the true posterior. KL measures a directed discrepancy between distributions. Since the data probability is fixed here, increasing F makes this discrepancy smaller. F is also called the **evidence lower bound (ELBO)** because it cannot exceed the log data probability.

Select a Gaussian q with adjustable means and positive standard deviations, but zero correlations. This is a **mean-field** approximation: q factors into a product of independent coordinate distributions. That independence is our restriction on q, not a statement that the true posterior's coordinates are independent. Separate the regression weights w, the model's fixed settings, and the parameters used to adjust q.

Because this is `KL(q||p)`, often called reverse KL, it strongly penalizes putting q probability where the target p is very small. Explain that directional effect without claiming that every such fit picks one mode or always underestimates all uncertainties. We optimize expected log joint probability minus expected log q; the target's unknown normalizing constant is unnecessary.

**End summary:** We fit the best distribution available within a chosen family. Restricting the family can leave approximation error even when optimization is complete.

### B. Show exactly what discarding correlation loses — 24 minutes

Use a two-dimensional Gaussian whose exact mean and covariance are known. State the Gaussian-to-Gaussian KL formula and work the diagonal restriction. A short stationarity calculation gives the best means and separate variances; do not prove the general KL formula again.

For the example in Part 4, the best means are correct but the separate variances are smaller than the true marginal variances. They reflect conditional rather than marginal spread. Correlation also affects uncertainty in combinations of coefficients: compare their sum and difference. The diagonal approximation underestimates one combination and overestimates the other, so “uncertainty is smaller” needs a specified query.

On this diagnostic, compare a supplied numerical fit with both the exact posterior and the analytic best diagonal approximation. Their difference identifies unfinished optimization separately from the unavoidable family restriction. Recall the known-noise Gaussian regression equations from L01 as a realization of the target, not the main notebook application. Do not add a fresh conjugacy proof, second complete diagnostic fit or student full-covariance optimizer.

**End summary:** Matching the center or improving the objective does not establish correct uncertainty. The lost correlation matters differently for different questions.

### C. Make a random draw depend differentiably on means and spreads — 31 minutes

Ordinary L05 training differentiated a loss evaluated at fixed data. Now the loss is averaged over random coefficients drawn from q, and changing q changes those draws. Ignoring that dependence loses part of the derivative.

Draw standard Gaussian noise ε independently of q's parameters. Construct a coefficient draw as `w=m+s⊙ε`, with `s=exp(ρ)>0`. The same noise draw then shows how w changes when m or ρ changes. This is **reparameterization**; differentiating through the sampled value is a **pathwise gradient**.

Derive the rewritten expectation and its total derivative, including any direct dependence of the objective on the distribution parameters. Give the conditions allowing derivative and expectation to be interchanged; independent noise alone is not enough. Derive mean and scale gradients for the diagonal Gaussian objective using its analytic entropy, the measure of the distribution's spread. Average sample derivatives to estimate the expectation. Distinguish noise from drawing latent coefficients from noise due to selecting data minibatches; detailed sampling-error theory belongs to L10.

Apply L05 automatic differentiation, keeping both mean and scale paths connected. State the alternative **score-function gradient**, which differentiates the density instead of the sample, including its direct term. It is a brief contrast, not a second derivation, estimator catalogue or coding task. A differentiable sample map/objective is needed for the pathwise method, and it is not universally lower variance.

**End summary:** Independent noise plus a differentiable transform lets us compute the complete derivative of the sampled objective, including how means and spreads affect the draws.

### D. Compare updating one distributional factor at a time — 16 minutes

Some models let us optimize one factor q_j exactly while holding the others fixed. This is **coordinate-ascent variational inference (CAVI)**. State its update: exponentiate the expected log joint probability, averaging over all other factors, and normalize.

Work one small sweep on the already known Gaussian target: other coordinates enter through their means, and the result is a Normal factor. Do not add the general functional-optimization proof. Unlike selecting the best fixed neighbor state in L03, this update averages over distributions. Unlike drawing a conditional value in a sampler, it adjusts a whole approximate distribution.

An exact coordinate update improves the same bound. Noisy gradient steps need not improve it individually. Neither fact establishes recovery of the true posterior or a general convergence theorem. There is no Ising solver or second variational-EM example.

**End summary:** Coordinate updates offer another way to improve the same restricted-distribution objective; they do not remove the family restriction.

### E. Check objective signs, loss scaling and predictions — 13 minutes

Write F as expected log likelihood **minus** KL to the prior. Use the corrected diagonal Gaussian KL in Part 2 and check that identical standard Normals give zero. The inspected book has a plus-sign error and a missing constant; later teaching must use the corrected expressions.

In the Gaussian regression diagnostic q describes one shared set of weights for the entire dataset. Sum the full-data likelihood contributions and include the prior KL once, not once per observation. State its predictive mean and variance, adding observation noise separately from coefficient uncertainty. This known model allows exact objective and posterior/predictive checks, rather than relying on a noisy loss trace. The lab applies the same objective scaling to the supplied Bernoulli likelihood and `N(0,4I₂)` prior; its predictive probability is an expectation of a sigmoid, not the Gaussian regression variance formula. That application requires no additional live derivation.

Briefly explain **amortized inference**: one shared map can return an approximate posterior for each new observation, avoiding a separate optimization each time. The current notebook has one global weight posterior, not a per-row encoder. L12 constructs that shared map; no network or new gap derivation is required here.

**End summary:** Correct signs and scaling define the intended objective. Exact probability queries reveal errors a training trace can hide; sharing inference across inputs is a later extension.

### Time estimate and what to shorten first

The five parts total **100 substantive plus 12 reserve =112 live minutes**, with a separate 60-minute lab. The estimate is tight and unmeasured, with medium-low confidence. The main new derivations are diagonal-approximation geometry and the total derivative through random draws. Earlier Gaussian algebra and L06's bound proof are reused.

First remove the six-minute numerical coordinate-update sweep, keeping the rule and Gaussian-factor interpretation. The result is about 106 live minutes and leaves the lab unchanged. Preserve the pathwise derivation, correlation/query comparison and correct KL. No required material moves to a recording without a decision.

The later-author extent counts are `K=5`, `P≈10–14`, `E_new≈12–15`, `E_carry≈14–22`, `E_deriv≈10–14`, `V≈6–8`: main parts, substantive source pages, new equation families, repeated support, intermediate algebra and visual groups respectively. The rough model predicts 24–30 content-slide equivalents. This is neither a target nor validated time. L01's 61-slide judgment does not measure the pace of stochastic differentiation; check actual explanations during section design and rehearsal.

## 2. Mathematical spine — the results students will use

There are three different sets of parameters. The model's prior settings, and the Gaussian diagnostic's observation noise, are fixed. w denotes unknown coefficients: regression weights in the live diagnostic and intercept/temperature slope in the notebook. `ψ=(m,ρ)` denotes the parameters we optimize to adjust q: means m and log standard deviations ρ. Thus `s_j=exp(ρ_j)>0` and `q=N(m,diag(s²))`. Squaring s is essential: s is standard deviation, while `diag(s²)` is covariance.

For the exact Gaussian target, a is its mean, S its covariance and `Λ=S⁻¹` its precision, the inverse covariance. D is the diagonal covariance of q. `⊙` means element-by-element multiplication; `J_g` is the derivative matrix of the sample transform. F is the lower-bound objective, H(q) is entropy and all logarithms are natural. The two KL uses are different: KL to the posterior measures approximation error; KL to the prior appears in the computable training objective.

In the table, **Derive** means work through the calculation; **Work** means carry out an example; **State** means give the result without proving it; **Apply** means use a result established earlier. These depths are unchanged by the wording revision.

| Object/result | Depth / delivery and role |
|---|---|
| `log p(D)=F(q)+KL(q\|\|p(w\|D))`, `F=E_q[log p(D,w)−log q(w)]` | **Recall + Apply**, Live A; L06-owned identity. Restrict q, keep evidence constant in psi. |
| `q=product_j q_j`; diagonal Gaussian versus correlated target | **State/Motivate**, Live A/B. Family factorization is an assumption about q, not an asserted independence in p. |
| `KL(N(m,D)\|\|N(a,S)) = (1/2)[tr(S^{-1}D)+(m−a)^T S^{-1}(m−a)−d+log(det S/det D)]` | **State + Work**, Live B. With diagonal D, **Work** stationarity giving `m*=a`, `D_jj*=1/(S^{-1})_jj`. No general Gaussian-KL proof. |
| `w=m+exp(rho)⊙epsilon`, parameter-independent standard Normal epsilon | **Derive** expectation rewrite, Live C. Distribution covariance is diag(s²), not diag(s). |
| `grad_psi E_epsilon f_psi(g_psi(epsilon))=E[partial_psi f+J_g^T grad_w f]` | **Derive**, Live C. Retain the direct term; require almost-everywhere differentiability and an integrable dominating derivative locally to interchange derivative/expectation. Gaussian quadratic model meets these conditions. |
| `H(q)=(d/2)(1+log(2pi))+sum rho_j`; `g(w)=grad_w log p(D,w)`; `grad_m F=E[g]`, `grad_rho F=E[s⊙epsilon⊙g]+1` | Entropy **State/Apply**, gradients **Derive + Work**, Live C. Analytic entropy includes explicit scale dependence; sample-average gradients target these expectations, without a monotone-SGD guarantee. |
| Score-function `grad_psi E_q f_psi=E_q[partial_psi f_psi+f_psi grad_psi log q]` | **State/contrast only**, Live C, common-support/differentiability assumptions. No score-function implementation or variance proof. |
| `q_j* ∝ exp(E_q_-j log p(D,w))` | **State + bounded Work**, Live D. Gaussian target gives `m_j←a_j−Lambda_jj^{-1}sum_{k≠j}Lambda_jk(m_k−a_k)`, variance `Lambda_jj^{-1}`. Numerical sweep optional; no full CAVI functional derivation. |
| Standard-Normal-prior KL `(1/2)sum(m²+s²−1−2rho)`; `F=E log likelihood−KL` | **Apply/Work**, Live E; L12 specializes/reuses it. For notebook prior `N(0,4I₂)`, **Apply** `(1/2)sum[(m²+s²)/4−1+log4−2rho]`. Prior KL differs from KL to the posterior. |
| Known-noise regression `w~N(0,I)`, `y\|w~N(Xw,sigma_y² I)`; exact `S=(I+X^T X/sigma_y²)^{-1}`, `a=S X^T y/sigma_y²` | **Recall/Apply**, Live B and supplied notebook diagnostic, L01 LGS. Prior/noise fixed, no unknown scale or parameter-fitting E/M loop. |
| Prediction at feature vector v: mean `v^T m`, variance `sigma_y²+v^T Dv`; exact uses a,S | **Apply/Work**, Live B/E and supplied notebook diagnostic. Distinguish latent-mean uncertainty from future-observation uncertainty. |
| Challenger `y_i\|w~Bernoulli(sigmoid(x_i^T w))`, `w~N(0,4I₂)`; query `r(T)=E_p(w\|D)[sigmoid(x(T)^T w)]` | **Apply**, Notebook: L05 likelihood, L06 identity and supplied L07 Laplace routine. One proposed diagonal student fit; supplied full-Gaussian result `q=N(m,LL^T)` at **recognition/comparison** depth, with no new covariance-gradient derivation. |

## 3. Notebook handoff — what students do and what is supplied

**Accepted application; proposed allocation:** Fit a diagonal Gaussian coefficient posterior for Challenger thermal distress by differentiating through random draws, then evaluate the same predictive probabilities as supplied Laplace, full-Gaussian VI and checked numerical-reference results. This is a proposal for student work, not an inference that the application decision approved diagonal-only VI or a full-covariance implementation. The exact correlated-Gaussian case is a short supplied diagnostic; students do not fit it as a second exercise.

**Frozen problem:** all 23 UCI erosion-or-blowby flights, with `y_i=1` for any thermal distress (7 positives), `x_i=(1,(T_i−c)/h)`, `c=69.56521739130434`, `h=6.901959941907628`, and independent `N(0,4)` intercept/slope priors. Preserve the exact arrays, transformation and hashes in [raw results](notebook_geometry/challenger_results.json) and [manifest](notebook_geometry/manifest.json); the variant differs from erosion-only. Pressure is omitted by construction. These data supply historical experience, not held-out performance evaluation. Queries are frozen at 31, 53, 60, 70 and 81°F; 31°F is outside the observed 53–81°F range.

**Supplied:** data/provenance, fixed model and transformation, stable logistic likelihood helper, Laplace routine/results on this posterior, initialization, Adam settings and bounded driver, plotting, Gaussian predictive quadrature, checked posterior-reference outputs, full-Gaussian VI results and diagnostic objectives, and the exact-Gaussian/analytic-best-diagonal comparison. Full-Gaussian notation `w=m+Lε` and `C=LL^T` is explained for reading those outputs. No new Cholesky optimizer or covariance-gradient derivation is assigned. **Students complete:** one diagonal sampled transform/objective, one fixed-noise gradient check using a supplied checking scaffold, one fit using the driver, and concrete probability/error comparisons. Reuse L05 Torch tensors/backward/update with a ten-minute refresh; no new data loader or inference library.

For `s=exp(ρ)` and `w=m+s⊙ε`, minimize the sampled negative ELBO below, where `softplus(u)=log(1+exp(u))` is evaluated stably by the supplied helper and K is the number of coefficient draws:

$$
\widehat J(m,\rho)=\frac1K\sum_{k=1}^K\sum_{i=1}^{23}
\left[\operatorname{softplus}(x_i^Tw^{(k)})-y_ix_i^Tw^{(k)}\right]
+\frac12\sum_{j=1}^2\left[\frac{m_j^2+s_j^2}{4}-1+\log4-2\rho_j\right].
$$

Average over coefficient draws; sum over observations; add the prior KL once. Preserve both mean and scale paths, including the direct entropy contribution. The KL is zero at `m=0,s=(2,2)`. A fixed-noise analytic/autograd or finite-difference comparison checks this finite sampled objective; it does not remove sampling error or prove optimization convergence. Supplied deterministic integration monitors the fit's objective gap against a diagnostic optimum; students do not build another optimizer.

At temperature T, compare `r_q(T)=E_q[sigmoid(x(T)^T w)]` with the numerical posterior reference, rather than plugging the mean into the sigmoid. The supplied Gaussian-logit quadrature uses `x(T)^T w~N(x(T)^T m,x(T)^T Cx(T))`. At 60°F the checked reference is about `.73134`, Laplace `.69209`, diagnostic full VI `.73299` and diagnostic diagonal VI `.72945`. Those last two are author diagnostic fits, not promised outputs of the student stochastic fit. Laplace versus full VI holds the Gaussian family fixed and compares criteria; diagonal versus full VI exposes an extra restriction. The Gaussian diagnostic makes family versus optimizer error exact; the Challenger diagnostic optima and reference remain numerical. Full VI still has about `.00573` absolute probability error at 31°F; better integration does not validate extrapolation, and no acceptable-error threshold or decision loss has been approved.

| Proposed activity | Minutes |
|---|---:|
| Refresh Torch parameters, coefficient-draw/data axes and backward | 10 |
| Read frozen flight task and supplied Laplace/reference outputs | 8 |
| Complete diagonal transform and correctly scaled objective | 16 |
| Fixed-noise gradient check, one fit and supplied objective-gap check | 8 |
| Compare full VI, diagonal fit and Laplace at common queries | 10 |
| Read exact-Gaussian diagnostic; distinguish family and optimizer error | 5 |
| State numerical conclusion, assumptions and remaining error | 3 |
| **Total** | **60** |

The estimate has no reserve and has not been piloted. Supply all arbitrary setup and result extraction; do not turn reference integration, CAVI, source-data investigation or the full-Gaussian fit into extra student work. If a workload trial runs long, supply the gradient-check output for inspection and keep the exact-Gaussian numerical fit supplied; preserve objective construction, one diagonal fit and task-query comparison. Any loss of required student practice must be returned explicitly to Scope. No learned value, convergence tolerance, runtime, local execution pass or hosted Colab readiness is promised by this proposal.

**Proposed L10 continuity:** carry this accepted posterior/query specification and the L09 family allocation, once approved, as separate records. If L10 uses its investigated full-Gaussian comparator on a different accepted target, introduce it as revisiting the **supplied** L09 full family and reverse-KL principle, not the student's diagonal implementation. A supplied summary `q=N(m,LL^T)`, its criterion and common query outputs is the minimal bridge; it adds no student full fit or live derivation. If direct continuation of the student family is required, the selected L10 target needs a bounded diagonal fit/check before its final comparison is promised. The coordinator must resolve that consequential choice with L09/L10 Scope; this document selects no L10 dataset or sampler.

## 4. Concrete examples and their sources

The first three examples keep the live mathematical checks independently solvable. Correlated Gaussian coefficients reveal uncertainty lost by an independent approximation; a tiny regression design realizes that posterior; a scalar derivative check catches a wrong entropy or scale sign. The accepted Challenger application then tests probability computation on real observations using a checked numerical reference. “Oracle” means the exact answer used to test a calculation. Automatic differentiation is abbreviated AD; a Gibbs sample would be a random conditional draw, unlike the coordinate distribution update here.

**Correlated Gaussian, Work/Live B and reused D/E.** Course-constructed target mean zero, `S=[[1/2,2/5],[2/5,1/2]]`; determinant `9/100`, precision `Lambda=[[50/9,−40/9],[−40/9,50/9]]`. Best diagonal covariance is `D=(9/50)I`, versus exact marginal variances `1/2`; minimum reverse KL is `(1/2)log(25/9)≈0.510826` nats. Direct rational arithmetic checked these values. B2 Fig. 10.2 supplies the phenomenon, not these parameters or claims of source figure replication.

For `v=(1,1)`, exact latent predictive variance is `9/5` versus diagonal `9/25`; for `v=(1,−1)`, exact is `1/5` versus diagonal `9/25`. Add known observation variance separately. Thus diagonal error can reverse direction for a linear query. One optional CAVI sweep starting at means `(1,−1)` gives `m_1=−4/5`, then `m_2=−16/25`, with variances `9/50`; this is coordinate distribution optimization, not a Gibbs sample or L03 coordinate MAP.

**Regression realization, Brief Work/Live B.** With standard Normal prior and noise variance 1, choose rows `X_1=(3/√2,−3/√2)`, `X_2=(1/(3√2),1/(3√2))`, observations `y=(0,0)`. Then `I+X^T X=Lambda` above and exact posterior is the same target. Algebra checked; course-constructed, not ruggedness/GDP observations. It shows that posterior correlation arises within familiar Gaussian regression. No fresh conjugate-posterior proof or empirical-accuracy claim.

**Gradient check, Work/Live C.** Scalar standard-Normal target specialization gives `F=−KL(q||p)`, gradients `partial_m F=−m`, `partial_rho F=1−s²`; at matching `m=0,s=1` both vanish. This checks the entropy sign and direct scale term, not a separate application/model. The lab uses the same checking principle on its actual sampled Bernoulli objective, with supplied noise and a checking scaffold.

**Challenger, Apply/Notebook; accepted application.** The course-constructed flight-level Bernoulli-logistic model in Part 3 uses the pinned [UCI erosion-or-blowby data](notebook_geometry/o-ring-erosion-or-blowby.data) and [original documentation](notebook_geometry/o-ring-erosion.names), not six independent rings per flight. Data SHA256 is `7f38e97b501414fe1c08dfef29432065f0114ed997f5099ce28036086ef1c236`. The [investigation](notebook_geometry/REPORT.md) preserves source provenance, query tables, numerical-reference checks and stochastic-fit evidence. At the in-range 60°F query, full-Gaussian VI reduces the Laplace discrepancy from about 3.925 to .165 percentage points. This compares fitting criteria within the same family, not a generic VI superiority claim or a launch recommendation. The posterior remains skewed, so retaining correlation does not remove Gaussian shape error. The exact Gaussian diagnostic remains necessary because Challenger alone does not isolate all family error analytically.

About 6–8 selected conceptual visual groups support family geometry, rotated versus diagonal uncertainty, sample-transform dependence, one gradient calculation, coordinate factor interpretation and posterior/predictive comparisons. No source asset reproduction or generated figure is required at Scope stage.

## 5. Lecture contract — what this proposal commits to

**Starting knowledge:** Gaussian conditioning and regression from L01; L05 differentiation/training and PyTorch; L06's posterior-approximation identity. L07/L08 provide context about approximate versus exact computation. No L10 sampling theory is assumed.

**Main question:** How do we fit and evaluate a simpler posterior distribution when exact inference is difficult? **Lecture endpoint:** explain the chosen family/objective, calculate its Gaussian limitation, derive differentiable sampling gradients, recognize coordinate factor updates, and check a correctly signed/scaled objective against predictions. **Notebook endpoint, proposed allocation:** one diagonal Challenger fit with a fixed-noise gradient check and common-query comparisons to supplied Laplace, full VI and a checked numerical reference, plus the supplied exact-Gaussian diagnostic. The estimate is 112 live minutes plus 60 lab minutes; there is no required recording.

The core new mathematics comes from selected B2 §§10.1.1–10.1.2, §10.2.1.1 and §§6.3.3/6.3.5.2. Coordinate updates are a short application of §§10.3–10.3.1. The generic bound proof belongs to L06, and the shared neural inference map belongs to L12.

**What is left out, and the lost capability:** Students do not implement correlated, low-rank or flow-based variational fits. The proposed supplied full-Gaussian result lets them inspect what retaining correlation changes, but does not establish independent competence in fitting that family; neither Gaussian family represents posterior skewness. They do not fit the source's real-data unknown-noise model or compare it with advanced sampling. They do not derive alternative noisy-gradient estimators, natural-gradient methods, automatic variable-transform systems, broad variational-EM examples, image-model coordinate solvers or other approximate-inference frameworks. These specialist extensions are deliberately omitted, not future recording obligations. L10 owns Monte Carlo variance and dependent-chain analysis; it recognizes Hamiltonian sampling but omits its full theory. L11 introduces nonlinear networks; L12 builds shared encoders/decoders and the autoencoding application.

**Choices and risks:** Challenger supplies the accepted practical application; exact Gaussian checks remain bounded diagnostics. The proposed diagonal-student/full-supplied split protects the live derivative and avoids a second student optimizer, but needs instructor acceptance and an affected Section Design feasibility preview. The one-hour allocation has no reserve; learner workload remains a risk despite fast author fits. Total differentiation and covariance interpretation may be slow live: cut the optional coordinate sweep first. The ten-minute PyTorch refresh stays. L10 continuity is explicitly supplied-family reuse unless a direct student-family continuation is separately approved and checked. Required error tolerances remain unagreed: report measured query discrepancies without calling any method adequate for an unspecified decision. Thermal distress, model adequacy, extrapolation and catastrophic failure remain distinct.

**Record updates:** Narrow broad Chapter 10/§10.4 promises to this selective coverage, without changing delivered ledger history. Merely recognizing shared inference does not count as teaching it. L12 can rely on the Gaussian sample derivative and correct KL, but must establish its own neural inference model.

<details>
<summary>Exact source allocation for checking the syllabus and material ledger</summary>

This table preserves the reviewed source boundaries. The plain-language explanation above states what the omissions mean for students. A method named as omitted is not promised elsewhere unless a receiving lecture is explicitly named.

| Allocation | Commitment / boundary |
|---|---|
| **Core/Live deep** | B2 §§10.1.1–10.1.2 restricted objective/geometry; §§6.3.3, 6.3.5.2 and §10.2.1.1 Gaussian total pathwise derivative. Generic bound identity reused from L06. |
| **Short bridges** | §6.3.4 score-function contrast; §§10.3–10.3.1 CAVI update/application, numerical sweep optional; §10.1.5 amortization recognition. Gaussian KL/known-noise posterior applied, not complete source derivations. |
| **Notebook owned — proposed allocation** | PyTorch refresh, one diagonal Challenger transform/objective and fit, fixed-noise gradient check; supplied Laplace/full-VI/numerical-reference query comparison and bounded exact-Gaussian/analytic-diagonal diagnostic. Full-Gaussian draw map recognized, not derived or independently fitted by students. |
| **Deferred, named owners** | MC variance/dependent-chain analysis → L10; HMC recognition/mechanics there, full HMC theory omitted; nonlinear networks → L11; amortized encoder/decoder, VAE specialization and joint training → L12. |
| **Omitted by course decision** | Full source GDP unknown-noise/HMC comparison; student full-covariance optimizer; low-rank/flow family implementation; natural gradients, ADVI transforms/Jacobian catalogue, control-variate/score estimator derivations, stochastic-variational-EM/VBEM model catalogue, Ising CAVI solver, EP/wake-sleep, semi-amortized inference, IWAE and normalizing flows. These are not hidden future obligations. |

</details>

**Next owner:** The coordinator routes the proposed family/student allocation and L10 continuity choice, and arranges an affected Section Design feasibility preview before whole-Scope acceptance. Detailed section design follows acceptance. If later writing or rehearsal cannot meet the stated commitments, return the affected choice to Lecture Scope. The [registry](../course_architecture_scope/STATUS.md) holds review evidence. This document does not establish notebook runtime, Colab readiness or measured teaching time.
