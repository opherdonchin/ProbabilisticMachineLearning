# L09 review: explanation for the instructor

This reading guide was written by the coordinator. The original independent review is preserved verbatim below; it identifies its own reviewer, exact earlier scope version and checks. [STATUS](../STATUS.md) identifies the current readable scope and any subsequent revision check. Rewriting a guide is not a new independent approval.

**What was assessed:** Approximate a posterior by fitting a simpler distribution. The reviewer asked whether the mathematics, student prerequisites and one-hour task could fit the proposed meeting.

**What the original review concluded:** The proposal was feasible with risks, meaning no demonstrated mathematical or structural obstacle was found, but time and supplied-code requirements remained uncertain. No student notebook or teaching trial was validated.

**What matters for the teaching choice:** The simpler-Gaussian posterior comparison makes the limits of approximation visible. The derivative check must use the same random draws and score as the training calculation. The observation likelihood and prior penalty must be counted consistently. No earlier sampling algorithm or new software library is assumed.

## Original independent review and later technical check records

# L09 independent Section Design feasibility preview

**Reviewer role/thread:** Section Design specialist `/root/review_l05`, independent of builder `/root/build_l03`. **Mode:** `feasibility-review` only. **Date:** 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`. **Exact target:** `Lectures/L09_Variational_Inference/lecture_scope.md`, Git blob **`a8080351116f51a34eddd3e5dc06d65f7025722e` before and unchanged after review**. **Contract:** architecture audit v3, blob `54064183398bd643a895c5e38a023f793dc2d9d6`. The interrupted review was resumed against these actual hashes; no partial L09 report existed. Only this report was authored; earlier reports and all upstream/shared files were preserved. No sections, slides, notebook, commit or approval was produced.

**Verdict: `feasible-with-risks`; no unresolved blocking concern identified.** Mathematical confidence is medium-high for the fixed Gaussian model and selected gradient route; timing confidence is medium-low. The 112-minute inclusive lecture and 60-minute scaffolded lab are plausible but unmeasured. This judgment depends on one diagonal fit, a bounded CAVI illustration, L05 software refresh and supplied diagnostics; it does not cover the full Pyro/GDP/HMC reference.

## Evidence and prerequisite route

Applied repository instructions, canonical Section Design feasibility-review procedure, shared backpressure, timing calibration and WORK_ORDER. Read the full target and contract v3; used protected L01/L02 evidence already inspected in this review thread, reviewed L05/L06 commitments and relevant L07/L08 handoffs. Exact predecessor scopes are L05 `736943b90f24826e29955115896929742f2961f5`, L06 `326267281c6b6775ac9a33d7ed4f022a859fc49b`, L07 `f12fba8de7339675d09a771c5f956c8ed93649d8`, L08 `b7a2de325c364bcde8230c33aaba2a5cd6b8596a`. These are proposed teaching outcomes, not delivered coverage. The actual ledger remains at L01; L02 is agreed, undelivered.

The route is constructible without VI/MCMC prerequisites: L06's bound identity supports restricted-q optimization; L01 Gaussian precision/LGS supports a known posterior; Gaussian KL gives an analytic family-error benchmark; one total pathwise derivative supports stochastic distribution optimization; bounded CAVI shows an alternative on that same target. L07 supplies query-specific checking; L08 demonstrates that structure can make exact inference possible. L05's data-index minibatch argument does not already teach gradients through a parameter-dependent distribution, so L09's new derivative is substantive rather than renamed review. Generic ELBO proof remains L06-owned, MC/dependent-chain/HMC theory L10-owned, neural/amortized implementation L11/L12-owned.

Directly inspected B2 `/tmp/pml-book2.txt` §§10.1.1–10.1.2, §10.2.1/§10.2.1.1, selected §10.2.1.5, §§10.3–10.3.1 and §§6.3.3–6.3.5.2. Reviewed source-inspection register, including its original-PDF p. 448 confirmation; this reviewer did not independently render that PDF page. Actual extracted Eq. 10.49/10.50 passages reproduce the recorded discrepancies. No B1 topic is silently added as new primary coverage.

## Mathematics and exact-example audit

**Restricted q versus EM:** with fixed model/data, evidence is constant in variational parameters, so maximizing the recalled F minimizes `KL(q||posterior)` within the chosen family. Restricted q need not attain L06's exact E-step tightness. Improving a restricted bound or taking a noisy gradient step does not automatically establish exact-EM observed-likelihood monotonicity. The scope preserves this distinction and treats factorization as an assumption about q, not a CI statement about the true posterior. Support asymmetry is explained without a universal mode-seeking/underdispersion theorem.

**Gaussian geometry:** the stated Gaussian KL is correct. Stationarity over mean and diagonal variances gives `m*=a`, `D_jj*=1/Lambda_jj`; these are conditional-scale variances, not target marginal variances. An independent rational-arithmetic check reproduced:

- `det S=9/100`; `Lambda=[[50/9,−40/9],[−40/9,50/9]]`; optimum `D=(9/50)I=0.18I`.
- Minimum reverse KL is `0.5 log(25/9)=0.5108256237659906` nats, rather than zero.
- Along `(1,1)`, latent variances are exact `9/5` versus diagonal `9/25`; along `(1,−1)`, exact `1/5` versus diagonal `9/25`. The error reverses direction despite smaller individual variances. Observation noise is added separately; the scope correctly distinguishes latent-mean uncertainty from future-observation uncertainty.
- The two-row regression realization gives `I+XᵀX=Lambda`, with zero posterior mean for `y=(0,0)`. Its prior/noise assumptions make it an exact analytic benchmark. It is honestly labeled course-constructed, not GDP data.
- Starting CAVI means `(1,−1)` produces sequential updated means `(-4/5,−16/25)`, factor variances `9/50`. This optimizes factors by expectations; it is not a Gibbs sample or coordinate MAP.

The full covariance optimum need not be implemented to expose family error. Exact a/S and the analytic diagonal optimum are sufficient to separate family mismatch from imperfect stochastic optimization. Predictive comparisons are exact in this controlled Gaussian model; no empirical accuracy, calibration or monotone-uncertainty guarantee follows.

**Total pathwise derivative:** `w=m+exp(rho)⊙epsilon` has covariance `diag(s²)`, not `diag(s)`. The scope keeps both the direct parameter term and the derivative through w, matching B2 §6.3.5.2. Parameter-independent base noise alone does not justify interchanging derivative and expectation; the stated local integrable-dominating-derivative assumption addresses that. Gaussian quadratic objectives satisfy this under bounded neighborhoods of finite m/rho. Analytic entropy gives `∇mF=E[g]` and `∇rhoF=E[s⊙epsilon⊙g]+1` for `g=∇w log p(D,w)`. The explicit +1 is essential. For the scalar standard-Normal target, population gradients are `−m` and `1−s²`, correctly vanishing at the match. Score-function identity includes its direct term and stays a stated contrast, with no second gradient derivation or implementation.

**KL corrections:** `F=E log likelihood−KL(q||prior)` and the diagonal standard-Normal KL `0.5Σ(m²+s²−1−2rho)` are correct. The scope corrects B2 Eq. 10.49's plus sign, Eq. 10.50's missing constant and ambiguous scale/covariance notation; matching Normals give zero KL. The earlier expected-log-joint-plus-entropy form and later analytic-prior-KL form are equal as expectations, but need not produce identical finite-draw gradient estimators. That matters for the local software check below.

**CAVI depth:** the stated expected-log-joint factor rule and Gaussian application are valid. The target permits a compact worked interpretation without a functional-optimization derivation, general Ising solver or VBEM catalogue. The scope avoids B2's blanket convergence claim from coordinatewise concavity alone; exact coordinate improvement does not recover omitted posterior correlations.

## Source/reference provenance

Inspected the actual 70-cell Pyro GDP notebook at local pyprobml checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`; SHA256 independently matches `415b81857e37701258718392c3c05db9a903f768ab59a54b03f438f211c204a1`. It fetches country data externally, log-transforms GDP, constructs Africa/ruggedness/interaction predictors, defines Pyro random weights/bias and unknown Uniform noise scale, then compares NUTS, `AutoDiagonalNormal` and `AutoMultivariateNormal`. It contains installation/API dependencies and substantially more software/model work than the selected lab. No downloaded data, fitted output, helper reliability or current package compatibility was verified.

The controlled known-noise synthetic model is an explicit course adaptation, not a replication or validated port of this source. Exact data dimension/seed/sample-size remain appropriately later worked-solution decisions. They must actually create a correlated posterior and meaningful two-direction comparison; the tiny two-row zero-response oracle is not falsely identified as the whole student dataset. A real GDP variant with unknown scale would lose the stated Gaussian exact-reference model and require a new contract, not a cosmetic data substitution.

## Concerns, repairs and consequences

### 1. Diagonal geometry plus total differentiation is a tight live contract

**Owner/severity:** Lecture Scope — advisory, high priority; Section Design owns local allocation. **Evidence:** `16+24+31+16+13=100`, plus 12 reserve gives 112 minutes. New responsibilities include diagonal KL stationarity, rotated-query variance, sample-transform dependence, explicit entropy/scale derivatives and interpretation of one factor update. Calling CAVI bounded must not turn it into a second full functional proof. Carrying L06/L01 results reduces backfill but does not remove distribution-parameter differentiation novelty. Timing prototype and L01 slide anchor are not measured rates.

**Provisional treatment:** retain one target and one deep pathwise route; preserve reserve. **Smallest repair:** take the stated six-minute numerical CAVI-sweep cut first, retaining rule and Gaussian factor interpretation; rehearse the geometry/pathwise portions. The six-minute saving remains estimated. **Consequence/decision:** no lab dependency or L12 prerequisite changes. A further core-depth reduction requires Scope-level decision rather than silently omitting the direct term, covariance comparison or prior KL. This preview covers 112 minutes, not an unchanged 100-minute cap.

### 2. Fixed-noise gradient checks must compare the same estimator

**Owner/severity:** Notebook authoring — downstream-owned. **Evidence:** live derivation uses analytic entropy plus sampled log joint, while the lab selects sampled log likelihood minus analytic prior KL. Both target the same expected F, but their finite-draw derivatives differ. A population formula such as `1−s²` need not equal a finite-noise derivative. Resetting/resampling epsilon between analytic/autograd paths would also make equality meaningless.

**Provisional treatment:** keep the prescribed analytic-prior-KL lab objective and identical supplied base-noise draws. **Smallest repair:** label sample averages versus population gradients and derive/check the finite-draw objective actually used. For this lab, with likelihood gradient h(w), its F gradient is `mean h(w)−m` in m and `mean[s⊙epsilon⊙h(w)]+1−s²` in rho. Do not add entropy or a sampled prior a second time. **Consequence/decision:** a local verification obligation, no new model or lecture derivation required. Detaching sampled w, omitting scale dependence or mixing estimators must fail the later check.

### 3. Preserve Bayesian likelihood/prior scaling when reusing L05 mechanics

**Owner/severity:** Notebook authoring — downstream-owned; no unresolved Scope-level scaling contradiction found. **Evidence:** L05 used mean empirical NLL. L09 prescribes the full-data `log p(D|w)`, one prior KL and an exact posterior `S=(I+XᵀX/sigma_y²)⁻¹`; these commitments mathematically fix summed-observation likelihood scaling. “Full data” does not itself prevent a mistaken mean-loss implementation. Averaging observations while leaving KL unscaled would change the posterior and invalidate the oracle.

**Provisional treatment:** use the full specified Gaussian likelihood. **Smallest repair:** make observation reduction explicit in the later solved objective: sum over observations, average over latent Monte Carlo draws. Alternatively divide the entire F, including KL, by N consistently; do not average only likelihood. Compare the supplied exact objective/posterior checker at a declared parameter value, not only its stochastic training trace. **Consequence/decision:** correct implementation preserves the approved mathematical model; a different prior/likelihood weighting requires explicit model revision. No blocking scope edit is necessary for the current unambiguous F/model formulas.

### 4. The required lab has little real spare capacity after refresh

**Owner/severity:** Lecture Scope — advisory; notebook authoring owns scaffolding/pilot/runtime. **Evidence:** ten-minute PyTorch refresh is counted, followed by 15-minute sample-objective/gradient work, 12-minute supplied fit, 18-minute distribution/predictive comparison and five-minute reserve. The reference cannot be completed within this envelope. The stated first lab cut is an extra run/noise comparison only “if added later”; it is not in the current 60-minute core, so removing it creates no core margin. There is no measured optimizer configuration or student pilot.

**Provisional treatment:** supply model/data, configuration, bounded driver, exact-reference routines and comparison plots; student work remains one sample/objective assembly and one check. **Smallest repair:** pilot that narrow core with the refresh included, provide completed indexing/diagnostic-table infrastructure and avoid a second training formulation. If refresh runs long, reduce authoring boilerplate while preserving gradient check and queries; an actual core endpoint/time failure must return to Scope. **Consequence/decision:** no new Pyro package, inference network, pre-L10 HMC or full-covariance optimizer. Stochastic trace noise is not a reason to assume failed optimization is irreducible family error.

### 5. Controlled synthetic reference changes practical context explicitly

**Owner/severity:** Coordinator/Lecture Scope — advisory. **Evidence:** exact-reference mathematics and a one-hour refresh-aware lab motivate replacing real GDP/HMC comparison. This preserves VI's computational skill but loses that empirical narrative. The scope reports the choice and its valid alternative rather than claiming the source model was retained.

**Provisional treatment:** keep known-noise synthetic regression and consolidate the practical-outcome question for instructor review. **Smallest repair:** reconcile syllabus/notebook audit with this actual choice and selective Chapter 10 depths; do not promise Pyro/GDP/HMC or substantive amortization/structured-family coverage. **Consequence/decision:** no extra L09 content; a prepared known-noise GDP variant needs data/model validation, while the original unknown-noise reference requires substantive re-review.

## First cut, invariants and limits

**Single best live cut:** the optional numerical CAVI sweep, preserving the factor rule, expectation-versus-conditioning distinction and recognition that both algorithms share family restrictions. Keep the total pathwise derivative, Gaussian geometry, corrected analytic KL and query comparisons. Extra lab runs are excluded already and provide no credited core time saving.

No material redundancy with predecessors appears at the declared depths. Generic identity is reused; Gaussian algebra is applied; the new stochastic-gradient skill follows L05 without assuming L10 theory. Retrospective endings and separate lecture-level notebook handoff are explicit. Exact section boundaries and slide moves remain downstream-owned.

**Validation limits:** numerical checks here used standard-library rational arithmetic only. No Pyro/GDP source notebook, protected notebook or course adaptation was executed. No data download, uv/Colab execution, training convergence/runtime test, PyTorch API/version validation, student pilot or lecture rehearsal occurred. The original-PDF discrepancy confirmation is attributed to the coordinator's register, not a new reviewer render. Exact future lab data and stochastic training tolerances remain unvalidated. Source outputs are not course guarantees.

**Disposition:** no mandatory blocking Scope repair before continued cross-course reconciliation. Preserve advisories and local objective/gradient-check obligations. This independent preview does not grant agent/instructor approval, downstream structural validation or publication readiness. Re-review only after substantive changes to the target family/model, required depths, dataset/reference identity, prerequisites or inclusive time envelope.

---

## Targeted HMC-allocation recheck — 2026-10-11

**Reviewer role/thread:** Section Design specialist `/root/review_l11`, distinct from original builder `/root/build_l03` and original reviewer `/root/review_l05`. **Mode:** `feasibility-review`, targeted repair check only, dispatched by coordinator `/root`. **Exact repaired target:** `Lectures/L09_Variational_Inference/lecture_scope.md`, blob `b6b98a1a0027e710c18aa596b79ac04ef7af248f`, verified before and after. **Original reviewed target:** `a8080351116f51a34eddd3e5dc06d65f7025722e`. **Cross-lecture evidence:** actual L10 scope blob `9503b32aef49e7090792ea7e38d3acfb808a973b`, matching the live file. The original raw review above is preserved byte-for-byte; this addition does not retroactively change its target or claims.

**Changes verified:** exact Git-blob comparison shows one changed row only: L09's deferred allocation of “MC variance/dependent chains/HMC theory” to L10 now assigns MC/dependent-chain analysis and HMC recognition/mechanics there, explicitly omitting full HMC theory. All L09 mathematics, examples, prerequisites, 112-minute inclusive live budget, 60-minute lab, other source depths and implementation boundaries are unchanged. Read the original raw review and L10's actual commitments: its five-minute State/recognize HMC bridge covers momentum, trajectory/energy correction and refresh; its spine excludes Hamiltonian/leapfrog correctness derivation; its contract excludes full HMC/leapfrog proof and all HMC implementation. Thus the former blanket theory promise exceeded the receiving scope; the repaired row matches it.

**Verdict: `feasible-with-risks`; no blocking concern in the repair.** The narrowed handoff resolves the cross-lecture depth mismatch without creating a prerequisite gap: L09's controlled known-noise Gaussian reference, restricted-q optimization and pathwise-gradient lab require no HMC, and its original reference's unknown-noise/HMC comparison remains deliberately omitted. L10 establishes its own stationarity/MH mathematics and does not depend on an HMC proof from L09. The earlier review's phrase “HMC theory L10-owned” describes the original revision; the current contract is the bounded recognition/mechanics allocation checked here.

**Owner/severity and downstream consequence:** coordinator/Lecture Scope — resolved allocation concern; no new teaching repair is needed. Synchronize the final source-ownership matrix, syllabus and notebook audit to bounded HMC recognition and explicit omission of full theory. Do not convert recognition into substantive proof coverage or hidden L11/L12 debt. Section Design receives the same L09 mathematical and lab contract; no timing, section-boundary or example change follows from this repair.

**Residual risks:** all original L09 pacing, finite-draw gradient-estimator consistency, likelihood/KL scaling and scaffolded-lab concerns remain. This targeted check neither repeats nor strengthens the full review. **Validation limits:** exact text/diff and dependency inspection only; no implementation test, notebook execution, training/runtime check or rehearsal was performed. No scope/shared files, L11 report, approval or commit was changed. Coordinator owns any approval disposition; instructor approval remains distinct.
