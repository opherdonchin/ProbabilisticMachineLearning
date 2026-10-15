# L09 Challenger application: bounded Scope and notebook handoff

**Stage/mode:** Lecture Scope / revision, 2026-10-15. **Assessment:** coherent provisional route, feasible-with-risks; no new technical blocker identified. This is a bounded reconciliation, not independent feasibility approval, whole-Scope acceptance or a finalized worked solution. The instructor's application choice is accepted; the student/supplied family allocation below remains proposed.

The [accepted decision](challenger_contract.md) authorizes replacing the main synthetic-regression notebook application with Challenger thermal distress while preserving the live intellectual arc and depth. The reconciled [Scope](../lecture_scope.md) keeps the exact correlated-Gaussian diagnostic, reverse-KL/ELBO, diagonal pathwise total derivative including its direct term, bounded CAVI and the 112-minute live/60-minute lab envelopes. It changes the introduction, affected notebook/example references, model-specific objective/query and contract wording. It adds no full-covariance derivation, student full fit, live logistic derivation or required recording. The original source/build records and unrelated omissions remain.

## Evidence and authority

Work began from clean branch `resume/l09-challenger-contract-20261015`, HEAD `172686c21023c2025601609396700b2cbde1865b`, in `/tmp/pml-l09-challenger-contract-20261015`. Only the Scope and this handoff are owned. No probe, dataset, result, map, architecture, environment or shared skill was changed; no new fit, candidate/data search or screen was performed.

The technical inputs are the L09 investigation at `f64fb54de202378430da644fd66173507da16907`: [REPORT](../notebook_geometry/REPORT.md), [raw Challenger results](../notebook_geometry/challenger_results.json), [audit results](../notebook_geometry/audit_results.json), [manifest](../notebook_geometry/manifest.json), [execution corrections](../notebook_geometry/execution_notes.md), and the [exact-Gaussian/pathwise evidence](../notebook_feasibility/pathwise_results.json). Raw adverse optimizer messages, stochastic variability and source records remain identifiable rather than being replaced by this summary. The independent technical review is `dcf2a81`, [technical_review.md](/tmp/pml-inference-geometry-review-20261015/Lectures/course_architecture_scope/reconciliation/notebook_geometry/technical_review.md). It found no blocking mathematical/implementation defect; findings F1–F3 require honest family continuity, no invented tolerance and preservation of coordinate/query/reference qualifications. That report remains owned by its review branch; this handoff does not copy or merge it.

Course context checked: `course_architecture.typ`, both curriculum maps, L05/L07/L08/L10 scopes, the L01 deck's Gaussian/LGS argument, L09's [source-arc review](../source_arc_review.md) and [investigation](../scope_investigation.md), and the cumulative [student-knowledge record](../../../.agents/skills/teaching-notebook-authoring/references/student-knowledge.md). The actual map explicitly records no classes taught; prepared L05 Torch/SGD and L06 ELBO are prospective dependencies, not delivered fluency. The previous argument progresses from L05 point optimization to L06's distributional bound and L07's local Gaussian proxy; L08 separately shows when structure permits exact computation. L09 retains Murphy's distributional-optimization argument rather than reorganizing the lecture around the flight dataset. No map/history update is warranted by this preparation.

Document checks passed: relative/local links resolve, display-math delimiters balance, and there are no control characters or whitespace errors. Comparison with the base confirms unchanged live A/C/D, timing envelope and all five retrospective closures; the seven activity allocations sum to 60 minutes, and data bytes/counts match the recorded hash and response arrays. These checks do not substitute for the outstanding teaching/runtime gates.

## Fixed problem and mathematical handoff

The task is accurate Bayesian prediction of **any thermal distress on a flight**, conditional on temperature and these historical data. Use all 23 flights, seven positives, from the pinned UCI **erosion-or-blowby** file; erosion-only differs and must not be substituted. Data SHA256 is `7f38e97b501414fe1c08dfef29432065f0114ed997f5099ce28036086ef1c236`. Original [data](../notebook_geometry/o-ring-erosion-or-blowby.data) and [documentation](../notebook_geometry/o-ring-erosion.names) are supplied. UCI attribution is David Draper (1993), DOI [10.24432/C5PW2T](https://doi.org/10.24432/C5PW2T), CC BY 4.0, as verified in the investigation/review. This is a course-constructed simplified model, not the full historical risk analysis.

Observed quantities are temperature `T_i` and binary distress `y_i`; `σ(u)=1/(1+exp(−u))` denotes the sigmoid. Unknowns are intercept/slope `w=(a,b)`. Pressure is omitted by fixed construction. Keep

$$
x_i=(1,(T_i-c)/h),\quad c=69.56521739130434,\quad h=6.901959941907628,
\qquad w\sim N(0,4I_2),\quad y_i\mid w\sim\operatorname{Bernoulli}(\sigma(x_i^Tw)).
$$

The prior is on these standardized coefficients. Re-standardizing while retaining `N(0,4I₂)` changes the model. All 23 flights enter inference; no held-out score or future calibration is established. Thermal distress is not catastrophic failure, and no launch decision loss/policy is supplied.

For the proposed student family `q=N(m,diag(s²))`, `s=exp(ρ)`, draw `w=m+s⊙ε` with standard Normal, parameter-independent ε. Minimize the sample average of the **full-data** Bernoulli negative log likelihood plus one analytic

$$
\operatorname{KL}(q\|N(0,4I_2))=
\frac12\sum_{j=1}^2[(m_j^2+s_j^2)/4-1+\log4-2\rho_j].
$$

Sum data rows, average coefficient draws, include the prior once. Check zero KL at `m=0,s=(2,2)` and preserve the direct entropy/scale contribution. Fixed-noise differentiation checks the actual finite sampled objective, not its expectation or convergence. For a supplied full comparator `q=N(m,LL^T)`, explain `w=m+Lε` and positive-diagonal triangular L only as needed to read its covariance/results. No general covariance-gradient proof or second student optimizer follows from that notation.

The frozen queries are

$$r(T)=E_{p(w\mid D)}[\sigma(x(T)^Tw)],\qquad T\in\{31,53,60,70,81\}\text{°F}.$$

A fitted Gaussian's prediction integrates the sigmoid using its projected Normal law; it is not `sigmoid(x(T)^T m)`. Supplied one-dimensional Gaussian-logit quadrature removes a new integration exercise. Observation Bernoulli variation and posterior uncertainty in the latent probability differ; the live Gaussian-regression observation-variance formula must not be applied to this model.

At 60°F, an in-range query, reference/Laplace/diagnostic-full-VI/diagnostic-diagonal-VI give about `.73134/.69209/.73299/.72945`. The same-full-family comparison reduces the absolute discrepancy from 3.925 to .165 percentage points. At 31°F, below the observed 53–81°F range, full VI still differs by about .573 points. These are computation comparisons conditional on the model, not evidence of calibrated extrapolation, adequacy at an agreed tolerance, or an operational decision reversal.

Separate three questions. **Laplace versus full VI** holds the family fixed and compares mode/curvature fitting with expected-log-density/entropy fitting. **Full versus diagonal VI** measures an added coordinate-dependent restriction; its diagnostic objective gap is about `.02371` nats, not a predictive error bar. **Stochastic versus diagnostic fit** measures unfinished fitting: Challenger diagonal seed gaps are about `.000040–.001668` negative-ELBO units, and their maximum probability errors `.00624–.00757`. A less optimized fit can accidentally improve one query, since reverse KL is not that query's squared error. Gaussian shape error remains even for full VI.

The exact live diagnostic still does a job the application cannot: with `S=[[.5,.4],[.4,.5]]`, best reverse-KL diagonal covariance is `.18 I`; sum/difference variances are `1.8/.2` exactly versus `.36/.36` under q. One linear query is too narrow, the other too wide. Comparing a supplied fit with the analytic diagonal optimum separates optimizer and family errors exactly. This is not a second practical fit or a proof that all VI uncertainties shrink.

## Proposed student/supplied split and one-hour limit

Students construct one diagonal sample map/objective, use a supplied fixed-noise gradient-check scaffold, run one supplied Adam driver, and compare concrete query outputs. Supply variant selection, standardization, stable logistic helper, Laplace routine/results on this posterior, initialization/settings, full-VI fits/results, numerical-reference outputs, diagnostic objectives, all plotting/extraction and the exact-Gaussian comparison. Full-family covariance is interpreted, not independently implemented. The final worked solution must expose the student objective rather than hiding its central mathematics in a helper.

| Work | Minutes | Student action / supplied support |
|---|---:|---|
| Torch refresh | 10 | Reconnect parameters, backward and draw/data axes; supplied small scaffold |
| Flight task and cumulative Laplace baseline | 8 | Read response/prior/query; inspect supplied Laplace/reference |
| Transform and scaled objective | 16 | Complete diagonal map and loss; stable logistic helper given |
| Check and fit | 8 | One fixed-noise check and one fit; driver and objective diagnostic supplied |
| Shared-query comparison | 10 | Distinguish criterion/family/optimizer effects; full VI and quadrature supplied |
| Exact Gaussian diagnostic | 5 | Read supplied results and identify query-dependent family error |
| Consolidation | 3 | State measured error and validity limits |
| **Total** | **60** | **No reserve; no measured learner trial** |

The three-category knowledge report is: **assume familiar** probability/Bayes, expectations, regression, elementary NumPy and basic posterior summaries; **previously encountered, scaffold** multivariate covariance/shapes, prospective L01 linear solves, L05 Torch backward/update after three intervening meetings and L06's identity if taught as planned; **new** variational parameters versus sampled weights, coefficient-draw/data axes, scale path/direct term, KL scaling, criterion versus family versus optimizer error, and reading a full covariance comparator. Basic NumPy `@` does not establish Torch broadcasting/Cholesky fluency. Prior PyMC/HMC experience does not establish VI implementation skill. No shared knowledge-state promotion is made here.

No new data API, CAVI implementation, full fit, reference derivation or dependency survey belongs in the hour. If a pilot runs long, supply gradient-check output for inspection and keep the Gaussian numerical fit supplied; preserve actual objective construction, one fit and probability comparison. A reduction of required student practice is Scope backpressure, not an unannounced authoring shortcut. The 112-minute live estimate is unchanged, tight and unmeasured; the timing-calibration prior does not validate either the live or learner estimate. The optional six-minute CAVI sweep remains the first possible live reduction, without automatically deleting it. Every future section still ends retrospectively; the notebook handoff is separate.

## Validity, computation and task error

**Validity:** the finite logistic design, proper Gaussian prior, smooth draw map and locally integrable derivative bounds support pathwise differentiation. Strong log concavity gives a unique posterior mode, not Gaussianity. Full VI retains moderate dependence but misses skewness. In the exact Gaussian diagnostic the analytic optimum is known; in Challenger, quadrature/BFGS diagnostic fits are numerical checks, not certified optima.

**Payoff:** diagonal storage is `O(d)`, full Gaussian storage and transforms `O(d²)`; full-data sampled likelihood gradients can avoid building a dense posterior Hessian. Fitted Laplace and full VI have essentially the same repeated-query representation/integration cost. A generic `G`-point-per-coordinate grid costs `G^d`, but accurate low-dimensional reference computation is practical here. Local measurements (Laplace about `.002s`, stochastic VI about `1.8–2s`) establish no VI speed advantage or large-data scaling result. Repeated temperatures reuse q without refitting. Author seconds do not measure learner minutes or hosted runtime.

**Error:** retain posterior-family mismatch, unfinished stochastic optimization, integration of the fitted proxy, and numerical-reference error separately. Grid refinements, a numerically evaluated strong-convexity tail envelope and independent importance integration support the bounded probability reference; the independent review's different Gauss–Legendre rule agreed within `7.2e−14`. This is corroboration, not interval certification of arbitrary tails/moments or mesh error. Proxy-query quadrature was separately refined. None of these checks tests the omitted pressure assumption or out-of-range model validity.

## L09 → L10 continuity and decisions returned

Independent review F1 is real: investigated L10 `0e5a39375369ff4258881e83d1a933de52fa8b8d` uses full-Gaussian VI, while this L09 proposal has students fit diagonal q. **Minimal honest proposal:** L09 supplies a full-family comparison; L10 explicitly revisits that supplied family/criterion on its selected target, before estimating the same target's queries by MCMC. Carry `q=N(m,LL^T)`, the reverse-KL objective and approved L09 artifact version in a supplied comparison summary. This preserves distributional-method continuity with no second L09 student optimizer or new live derivation. Dataset reuse is optional under the accepted direction. It does not establish that the student's diagonal implementation has been reused.

If the instructor requires continuation of the **student-implemented** family, the selected L10 target needs a bounded diagonal fit/check and a reconciled handoff before that endpoint is promised. The other alternative, teaching/assigning a full L09 optimizer, would change workload/depth and cannot be enacted under application approval. If L10 selects Eight Schools, a Gaussian in noncentered coordinates induces a different, non-Gaussian family over centered effects; label that change rather than claiming an unchanged family in different notation. This handoff selects no L10 target, coordinate system or sampler.

| Owner / severity | Evidence and provisional treatment | Smallest repair and affected dependency |
|---|---|---|
| L09/L10 Scope + instructor; **required before final family contract** | Application choice did not approve diagonal-student/full-supplied allocation; L10 currently revisits full family only. Use the explicit provisional supplied-family bridge above. | Coordinator asks whether that split and supplied-family continuity meet the endpoint. If yes, pin the accepted Scope version in L10; if direct student-family reuse is required, commission only the selected L10 target's diagonal check. Final dependent notebook promises wait for that choice. |
| Notebook author + Section Design reviewer; **advisory feasibility risk** | The 60-minute route has no reserve, with prospective Torch skill and 10 minutes comparison. Fast scripts do not establish workload. | Affected lightweight Scope feasibility preview, then worked-solution/learner trial. Preserve derivations and reduce supplied-result/software burden first; return actual overrun before adding live work or removing required student practice. |
| Scope/instructor if an adequacy claim is required; **advisory** | No numerical accuracy requirement or decision loss is accepted. Measured discrepancies support comparison only. | Keep measured-error language. Choose a task-specific requirement only if the intended endpoint includes adequacy/decision; event thresholds and 31°F are not accuracy tolerances. No tolerance is needed just to report the current comparison. |
| Worked-solution/notebook author; **downstream-owned gates** | Technical review passed its bounded target, not a final teaching artifact. | Freeze the approved allocation, validate the final worked solution and handoff, then solved Q&A and mechanically generated self-work, learner-time trial, locked local uv and fresh hosted Colab checks. Keep reference and stochastic output labels distinct. |

The consequential instructor question for the coordinator is therefore whether to accept **one student diagonal fit, supplied full-Gaussian comparison, and explicitly supplied-family continuity to L10**. Correctness of the KL/gradients, source repair and reference validation are author/reviewer responsibilities, not instructor approval questions. No substantive live change is required by this proposed route. No current L09 section/slide design exists in this checkout; future downstream artifacts must use the reconciled application contract. Existing source-arc and technical reviews retain their original targets; the coordinator owns arranging the affected preview before a Scope freeze.

## Focused reading for the decision

Use Murphy, *Probabilistic Machine Learning: Advanced Topics*, MIT Press 2023, online edition **December 10, 2025**, as recorded in the investigation manifest. This revision re-inspected the available local text at the passages below; it did not newly authenticate the PDF or retrieve sources.

- **§10.1.1.2, “The view from statistics: maximize the evidence lower bound (ELBO),” pp.440–441:** evidence is fixed in variational parameters; Eq.10.14 gives expected log likelihood **minus** prior KL.
- **§10.1.2, “Form of the variational posterior,” pp.441–442:** separate a family restriction from its optimization. Figure10.2 motivates covariance loss; the course's exact sum/difference example qualifies the source's broad overconfidence wording by query.
- **§10.2.1.1, “Gaussian with diagonal covariance (mean field),” pp.447–448; §6.3.5.2, “Total derivative,” pp.276–277:** connect positive scales and transformed draws to the complete derivative. Preserve the already recorded errors in Eqs.10.49–10.50 (plus-KL sign and missing constant); use the corrected objective above.
- **§10.2.1.2, “Gaussian with full covariance,” pp.448–449:** read only enough to understand `C=LL^T`, dependence and the supplied same-family comparison. This is not approval to add its optimizer/derivation to student work.

These passages support the family/allocation choice without requiring a full chapter or new L10 theory. The existing §§10.3–10.3.1 CAVI bridge and §10.1.5 amortization recognition remain as already scoped; L12 still receives the diagonal sample derivative and corrected KL convention, not a new covariance prerequisite.
