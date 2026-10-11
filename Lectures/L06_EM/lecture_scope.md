# L06 — Learning with hidden values: EM and expected sufficient statistics

**Status:** Reviewed five-part scope proposal; [current agent approval and exact reviews](../course_architecture_scope/STATUS.md) are maintained by the coordinator. Instructor acceptance pending; timing and notebook implementation remain unvalidated. **Stage/mode:** Lecture Scope / BUILD. **Builder thread:** `/root/build_l03`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; input checkpoint `791e71b632048f52e7b8f8bc3cd54fda264311bb`. **Upstream:** cross-course contract v2, `architecture_audit.md` blob `12ae5e1608eb2d74c6c70ba857eb5a75ff2114c1`; autonomous authority in `WORK_ORDER.md`. Only this Scope is owned here. No sections, slides, notebook code, shared-file edits or runtime validation.

## Starting boundary, sources and route choice

Actual protected L01 establishes Gaussian conditioning/LGS and a known-parameter missing-block lab (`slide_deck.typ` blob `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`; `InClass/Solutions/lecture1_missing_data.ipynb` blob `ab441941c8b526151a927bfbcf292bd9bc629ce5`). L06 changes the problem: **the Gaussian mean and covariance are unknown and must be learned from incomplete cases**. L02's agreed, undelivered `section_design.md` (`bbf78a13db05224a839d0b2f8bda4c7a5bd0c764`) supplies exponential families and moment matching. Its malformed/stale development register supplies no new authority. The ledger's delivered boundaries remain B2 §2.3.2/B1 §3.3; no future scope is delivery evidence.

Reviewed Wave A inputs: L03 blob `f4dab507f90618362c2e04c1c3791c8139f7de56` supplies latent/observed factors and distinguishes inference from coordinate optimization; L04 blob `242ee28d251d583004daa25379b6a0f8cb44d622` supplies KL/support interpretation, using bits; L05 blob `736943b90f24826e29955115896929742f2961f5` supplies fully observed likelihood optimization and gradients/updates. L06 uses natural logarithms/nats, does not repeat their derivations, and does not assume VI or MCMC theory. Current syllabus/ledger notebook candidates still leave Gaussian EM versus MRI open; the contract selects Gaussian depth provisionally, with MRI consequences recorded below.

**Direct textbook inspection:** Murphy B2 December 10, 2025 edition, local PDF identified in the architecture contract, extracted `/tmp/pml-book2.txt`: §6.5.1 (printed p. 287), §§6.5.3.1–6.5.3.3 (pp. 290–291), §§6.5.4.1–6.5.4.4 (pp. 292–293), §3.11 missingness (pp. 141–142), selected §§28.2–28.2.1 (pp. 929–932); §6.5.6 inspected only to delimit extensions. B1 April 18, 2025 edition, `/tmp/pml-book1.txt`: §§3.5–3.5.1 and §§8.7.2–8.7.3, supporting mixture/EM exposition. These selective passages, not full chapter ranges, support the commitments. Generic ELBO/KL identity, E-step tightness and EM monotonicity have **primary teaching ownership here**; L09 reuses them.

**Inspected solved application reference:** [gauss_imputation_em_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/opt/gauss_imputation_em_demo.ipynb), local `/home/opher/Repositories/pyprobml/notebooks/book2/opt/gauss_imputation_em_demo.ipynb`, checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA-256 `302a3b8f3608a5edf526f033d811bb71831c96925c671cabf59baa84adf991fc`. Two code cells construct 100 four-dimensional Gaussian cases with independent 50% entry masking, call `gauss_fit_em`/`gauss_impute`, and compare oracle/learned reconstructions. Imports include probml-utils, NumPy, Matplotlib and scikit-learn; it may install a Git dependency. The actual algorithm is hidden in an external helper, not exposed by these cells. B2's prose example says ten dimensions, whereas this inspected code sets four; do not attribute either size to the course adaptation. Source inspection is not execution or verification of fitted outputs.

| Genuine alternative | Intellectual endpoint / notebook | Disposition |
|---|---|---|
| **Missing Gaussian values → expected moments → EM** | B2 §6.5.3/§6.5.4; explicitly learn unknown parameters while retaining conditional uncertainty | Selected: repays L01, deeply demonstrates sufficient statistics, avoids a new application/data stack. |
| Gaussian mixture clustering/MRI | B2 §28.2/B1 §8.7.3; responsibilities and component fitting, image segmentation lab | Attractive biomedical outcome but would add component covariance updates, identifiability and MRI preprocessing. Keep one responsibility illustration, no MRI lab or second full derivation. MRI source/runtime not verified here. |
| General bound optimization before applications | B2 §§6.5.1–6.5.3; surrogate construction, logistic/robust examples | Broad optimization payoff, but spends the budget on several new bounds. State MM context; derive only the EM bound and one primary model. |

## 1. Intellectual arc

These are provisional macro-level responsibilities, not section contracts. Section Design may split/combine them within the retained endpoint/depth/time. Every resulting section ends retrospectively; connections begin receiving segments. All core mathematics is **Live**; no recording prerequisite or unbudgeted recording candidate.

### A. Unknown parameters make missing-value learning circular — 12 minutes

**Transition in:** L05 optimized a fully observed likelihood; L01 inferred a hidden Gaussian block using known parameters. Ask what changes when the missing-value predictor itself must be estimated.

**Purpose:** Distinguish an observed-data objective from the easier complete-data objective.

**Sources:** B2 §§6.5.3, 6.5.4 and §3.11.

**Core:** Name observed/missing row index sets and parameters `theta=(mu,Sigma)`. The likelihood marginalizes each missing block; it does not substitute a guessed completion. State MCAR/MAR/MNAR distinctions and the ignorability conditions used here. The lab uses parameter-independent MCAR masking; MAR additionally requires a separate missingness parameter/model whose factor can be ignored for likelihood estimation. MNAR cannot generally be discarded. Gaussian observed-block densities are computable, but their varying subsets make joint maximization less convenient than complete-data moments. No survey of missingness methods.

**Retrospective summary:** Missing-data learning maximizes the probability of the observed entries under unknown parameters; valid omission of a missingness mechanism is an assumption, not a consequence of calling data missing.

### B. A posterior distribution makes a lower bound tight — 26 minutes

**Transition in:** Filling missing values with one guess changes the objective. Introduce a distribution over those values and a bound on the original likelihood instead.

**Purpose:** Why can alternating inference and parameter optimization increase the observed likelihood?

**Sources:** B2 §§6.5.1, 6.5.3.1–6.5.3.3; B1 §8.7.2 supports the same argument.

**Core:** Derive the generic identity `ell(theta)=F(q,theta)+sum KL(q_n || p_theta(z_n|o_n))`. Nonnegative KL makes `F` a lower bound. Exact posterior E-step makes it tight at the old parameters; with `q` fixed, entropy is constant in the M-step. Derive the full three-link monotonicity argument. Distinguish the ELBO `F` from `Q=expected complete log likelihood`; `Q` alone omits the entropy constant and is not generally the touching lower bound. A short MM interpretation names minorize–maximize, without a second Jensen proof or a logistic surrogate. State that monotone likelihood does not prove global maximization, unique identification or convergence to a local maximum in every model. Exact algebra assumes finite likelihood/expectations and compatible supports.

**Retrospective summary:** The posterior makes the ELBO touch the observed likelihood; improving that same bound with the distribution fixed cannot lower the observed likelihood under the exact-EM assumptions.

### C. Gaussian E-steps retain means and uncertainty — 30 minutes

**Transition in:** The bound requires expectations of the complete-data log likelihood. L02 identifies sufficient statistics; L01 already gives the Gaussian conditional distribution needed to compute them.

**Purpose:** What information about missing values is sufficient for the Gaussian M-step?

**Sources:** B2 §6.5.4.1, Eqs. 6.157–6.162; L01 conditioning and L02 moment matching carried forward.

**Core:** Recall block-conditional mean/covariance at the current parameter estimate. Assemble full-row expected vector `m_n` and conditional covariance `C_n`, which has zeros in observed rows/columns. Derive `R_n=E[X_n X_n^T|observed,theta_t]=m_n m_n^T+C_n`. Work one two-dimensional partly observed row, explicitly including observed–missing cross moments. Compare its second moment against mean-only completion to expose the lost variance. Handle complete rows (`C_n=0`); fully missing rows contribute current prior moments and no observed information, so exclude them from the lab. Do not rederive Gaussian conditioning or introduce sampling.

**Retrospective summary:** The E-step supplies conditional expectations of `X` and `XX^T`; the second statistic contains conditional covariance that a completed mean vector cannot represent.

### D. Expected moments give a Gaussian M-step and a checkable iteration — 23 minutes

**Transition in:** Each row's required moments are now available. Apply L02's complete-data moment-matching principle to the expectations rather than to a fabricated complete sample.

**Purpose:** How do those moments update the parameters, and how do we check the algorithm?

**Sources:** B2 §6.5.4.2, Eqs. 6.163–6.164; §6.5.4.3 initialization.

**Core:** Express `Q` using the expected quadratic statistic; derive the mean stationarity condition and work the covariance update from Gaussian sufficient-statistic matching. Full matrix-calculus proof is not required. Work one complete iteration on the tiny case below. Evaluate observed likelihood using Gaussian marginal densities; distinguish a likelihood trace from imputation accuracy. Start from SPD covariance and adequate observed/co-observed data; small improvements alone do not establish a global optimum or an accurate data-generating parameter estimate. No automatic covariance ridge is added to an exact M-step: if conditioning fails, diagnose the data/initialization or explicitly change the estimation objective.

**Retrospective summary:** Gaussian EM alternates conditional expected sufficient statistics with mean/covariance updates; observed likelihood checks the optimization property while reconstruction evaluates a different task.

### E. Mixture responsibilities express the same expectation principle — 9 minutes

**Transition in:** Missing measurements are one kind of latent variable. A mixture model hides a discrete component label while following the same posterior-expectation logic.

**Purpose:** Recognize EM's generality without introducing a second complete fitting algorithm.

**Sources:** B2 §§28.2–28.2.1; B1 §§3.5.1, 8.7.3.1.

**Core:** State mixture joint and marginal, apply Bayes to normalized responsibilities and work one scalar numerical responsibility. Interpret responsibilities as expected indicator statistics rather than hard assignments. Mention weighted moments as the M-step analogue; no component covariance derivation, GMM implementation, cluster-number selection or MRI processing. Close by consolidating the established bound and expected-statistic principle, not by previewing VI or handing out lab instructions.

**Retrospective summary:** Gaussian missing values and discrete mixture labels differ in their latent representation; both require posterior expectations of complete-data statistics rather than a single guessed latent state.

### Extent and first cut

**100 substantive minutes + 12 reserve = 112 live minutes**, with summaries/transitions included; separate 60-minute lab. **Tight, unmeasured, confidence medium-low.** Two substantial linked chains dominate: KL identity/tightness/monotonicity, and conditional second moments/Gaussian updates. L01's 61-content-slide anchor is an instructor extent judgment, not a timed conversion; carried Gaussian equations reduce backfill but not moment-assembly effort.

Provisional calibration: `K=5`, `P≈9–12` substantive page equivalents, `E_new≈10–12`, `E_carry≈14–20`, `E_deriv≈9–13`, `V≈5–7`; prototype `S_hat≈22–27`, an uncertain warning signal, not a slide target. New families include marginal objective, ELBO identity, tightness, monotonicity, expected quadratic statistics, first/second moments, parameter updates and responsibility normalization. Gaussian conditioning, KL nonnegativity and EF moment matching are carried support. **First cut:** remove the six-minute numerical mixture/moment comparison while retaining a three-minute mixture/responsibility recognition; total falls to about 106 minutes. Protect second moments and monotonicity. No core derivation is moved to recording to manufacture feasibility; actual downstream extent/rehearsal can return Scope-owned pressure.

## 2. Mathematical spine

Use full row `X_n`, observed realization `o_n`, missing vector `z_n`, index sets `O_n,M_n`. `theta_t` is fixed while taking E-step expectations. Logs are natural; `Q` never denotes the entropy-including bound here.

| Result / object | Treatment and delivery | Purpose / limits |
|---|---|---|
| `ell(theta)=sum_n log integral p_theta(o_n,z_n) dz_n` | **State + Motivate**, Live A | Observed likelihood; sums replace integrals for discrete latent values. No claim it is always intractable to evaluate. |
| `F(q,theta)=sum_n E_q[log p_theta(o_n,z_n)-log q_n(z_n)]`; `ell=F+sum_n KL(q_n||p_theta(z_n|o_n))` | **Derive**, Live B; primary L06 ownership | Rearrange posterior definition. Assume compatible densities/supports and finite quantities; no continuous point-mass entropy manipulation. |
| `q_n^t=p_theta_t(z_n|o_n)` and `F(q^t,theta_t)=ell(theta_t)` | **Derive**, Live B | Exact E-step tightness. Approximate q need not make the bound touch. |
| `Q(theta|theta_t)=sum_n E_q^t log p_theta(o_n,z_n)`; M-step maximizes Q with q fixed | **Derive/Explain**, Live B | Entropy is independent of candidate theta. Do not differentiate q with theta during this step. |
| `ell(theta_{t+1}) ≥ F(q^t,theta_{t+1}) ≥ F(q^t,theta_t)=ell(theta_t)` | **Prove** short chain, Live B | Exact M-step or a demonstrated Q increase suffices. No guarantee for arbitrary optimizer steps, changed regularizers or an approximate E-step. |
| `a_n=mu_M+Sigma_MO Sigma_OO^{-1}(o_n-mu_O)`; `V_n=Sigma_MM-Sigma_MO Sigma_OO^{-1}Sigma_OM` | **Apply/Work**, Live C; carried L01 | Current estimates; stable linear solves in lab. No fresh conditioning proof. |
| `m_n=E[X_n|o_n]`; `C_n[M,M]=V_n`, other blocks zero; `R_n=m_n m_n^T+C_n` | **Derive + Work**, Live C | Expected sufficient statistics include full symmetric cross blocks. Mean imputation misses C. |
| `Q=const-(N/2)log det Sigma-(1/2)tr(Sigma^{-1} sum_n[R_n-m_n mu^T-mu m_n^T+mu mu^T])` | **Motivate + Work** expansion, Live D | Symmetric outer-product terms; avoid copying shorthand `-2 mu m_n^T` as a nonsymmetric matrix equality. |
| `mu_{t+1}=N^{-1}sum m_n`; `Sigma_{t+1}=N^{-1}sum R_n-mu_{t+1}mu_{t+1}^T` | Mean **Derive**; covariance **Apply** moment matching/Work, Live D | ML denominator N, not unbiased N−1. A PSD expression is not automatically strictly positive definite. |
| `ell=sum_n log Normal(o_n|mu_O,Sigma_OO)` | **Apply**, Live D / Notebook | Supplied likelihood checker; no entropy computation needed for the lab trace. |
| Mixture `p(x)=sum_k pi_k Normal(x|mu_k,Sigma_k)`; `r_nk ∝ pi_k Normal(x_n|mu_k,Sigma_k)` | **State + compact Work**, Live E; numerical Work first cut | Posterior expected indicator; weighted-moment interpretation only. No second M-step derivation. |

**Missingness/identification assumptions:** independent Gaussian rows, MCAR designed mask for the lab; MAR ignorability additionally requires distinct variation-independent missingness parameters. Such a mechanism contributes a theta-independent factor to the observed-data likelihood and conditional missing-value posterior. Adequate samples and co-observation of coordinates are required to learn unrestricted covariance; disconnected observation patterns can leave correlations unidentified. Supplied dataset has informative complete rows and all coordinate pairs co-observed. SPD initialization, nonsingular observed blocks and a finite SPD maximizer are working assumptions, verified later; no convergence guarantee covers singular boundaries or poorly identified data.

## 3. Notebook handoff — scaffolded 60-minute Gaussian EM

**Anchor:** B2 §6.5.4 and inspected Gaussian-imputation reference. **Endpoint:** expose and verify one row's expected first/second moments, aggregate them to update unknown `mu,Sigma`, run a supplied EM driver and interpret observed likelihood plus held-out missing-entry error. The final conditional mean reconstruction is a plug-in estimate, not a posterior integrating parameter uncertainty.

Lecture supplies the entire E/M mathematics, support/ignorability assumptions, ML scaling and monotonicity conditions. Students bring NumPy slicing/solves from L01 and cumulative checking skills; returning to NumPy/SciPy after L05 PyTorch introduces no new ecosystem. Supply synthetic correlated low-dimensional data, mask/index helpers, SPD initialization, plotting, stopping driver and a Gaussian observed-block log-likelihood utility. The student-owned computation is **conditional expected sufficient statistics**, with a supplied aggregation interface; avoid simultaneously implementing a generic optimizer, covariance repair and all plotting infrastructure.

Course adaptation uses a small MCAR-masked Gaussian dataset, excludes fully missing rows, and guarantees enough complete/co-observed cases for the exercise. Exact dimension, sample size, covariance, seed and masking pattern must be fixed and validated in the later worked solution; neither the book's ten dimensions nor the reference's four dimensions is an obligatory replication. Complete latent truth is kept solely for evaluation, never used for E/M updates or initialization. Compare fitted conditional means with a supplied oracle conditional-mean baseline and a supplied mean-only-update baseline; explain covariance distortion without promising EM improves every realization's reconstruction error.

| Lab work | Minutes |
|---|---:|
| Inspect given data/mask, index mapping and unknown-versus-oracle parameters | 8 |
| Compute/check one conditional moment pair; include covariance in R | 16 |
| Aggregate one update and complete the supplied EM driver interface | 12 |
| Run fit, check observed-likelihood trace and SPD/covariance outputs | 10 |
| Compare mean-only and oracle baselines using given tables/plots | 9 |
| Debugging/retrospective reserve | 5 |
| **Total** | **60** |

One reusable computational skill is retained: **turn posterior uncertainty into expected statistics and verify an alternating estimator against its objective**. A second initialization run is optional and excluded from completion. No MRI download/segmentation, Gibbs sampling, VI solver or `GaussianMixture.fit` exercise. Reference helper calls are computational precedent, not a verified exposed solution. Later authoring must validate formulas, finite/SPD behavior, bounded iteration count and student duration, and pass clean local uv plus hosted Colab before publication; no execution claim is made here.

## 4. Concrete examples and provenance

- **One conditional second moment, Work/Live C.** Course-constructed `mu_t=(0,0)`, `Sigma_t=[[1,1/2],[1/2,1]]`, row `(2,missing)`. L01 conditioning gives missing mean 1 and variance 3/4; `m=(2,1)`, `R=[[4,2],[2,7/4]]`. Mean-only completion gives bottom-right 1, missing 3/4. B2 Eqs. 6.157–6.162 supply the formulas, not these numbers. Direct arithmetic checked.
- **One complete EM iteration, Work/Live D, small lab oracle.** Same current parameters, observed rows `(-1,-1)`, `(0,1)`, `(2,missing)`. Aggregate moments give `mu_{t+1}=(1/3,1/3)` and `Sigma_{t+1}=[[14/9,8/9],[8/9,41/36]]`. Its determinant is `53/54>0`. Dropping conditional covariance lowers the second variance by exactly `1/4` after dividing by N=3. The observed log likelihood rises from approximately `−7.640344` to `−7.137887`. These course-constructed values were checked using a direct two-dimensional/one-dimensional Gaussian arithmetic calculation, not a run of the source notebook. This illustrates one update, not convergence or population recovery.
- **Compact mixture responsibility, Work/Live E, first cut.** Course-constructed equal-weight unit-variance scalar components centered at −1 and +1. At `x=1/2`, positive-component responsibility is `sigmoid(1)≈0.731059`, because its likelihood ratio is `exp(1)`. Source B2 Eq. 28.8/B1 Eq. 8.160 supports Bayes normalization; no source numerical attribution or GMM fitting follows. Hard assignment loses uncertainty.

Selected visual/schema groups: observed/latent versus parameter roles, bound/touching semantics, conditional moment blocks, one update comparison, likelihood/reconstruction distinction and optional mixture weights (about 5–7 groups). No figure asset is required or generated. B2 Fig. 6.8 is available reference context, not a guaranteed course result; its plotted performance is not evidence that the adaptation will match it.

## 5. Lecture contract

**Start:** probability/conditioning, actual L01 Gaussian results and numerical solves; agreed L02 sufficient statistics/moment matching; L04 KL; L05 likelihood optimization. Neither exact posterior sampling nor VI theory is prerequisite. **Goal:** learn model parameters when observations hide some sufficient statistics. **Lecture endpoint:** derive the ELBO/KL decomposition and exact-EM monotonicity, compute uncertainty-preserving Gaussian E-step statistics and perform their mean/covariance M-step. **Lab endpoint:** a checked scaffolded Gaussian EM fit with objective and reconstruction comparisons. **No required recording.** Estimated duration 112 minutes plus separate 60-minute lab.

Supported outcomes: distinguish observed versus complete likelihood; explain tightness and correct EM monotonicity assumptions; retain conditional covariance in expected second moments; update unknown Gaussian parameters and diagnose a failed objective check; recognize responsibility as an expected latent indicator. No mastery of mixture fitting, missingness sensitivity analysis or approximate EM is claimed.

| Allocation | Commitment and boundary |
|---|---|
| **Core/Live deep** | B2 §6.5.3 identity/E/M/tightness/monotonicity; §6.5.4 first/second moments and Gaussian updates. L06 primary ownership of generic ELBO mathematics. |
| **Short bridge** | §6.5.1 MM interpretation; §3.11 ignorability assumptions; §§28.2–28.2.1/B1 §3.5 mixture/responsibilities. No full chapter or mixture-fitting coverage. |
| **Notebook owned** | Row moment implementation, aggregation, supplied alternating driver, observed-objective check and plug-in reconstruction comparisons. |
| **Optional/first cut** | Numerical mixture illustration; extra initialization experiments. No formal-syllabus promise. |
| **Deferred to named owner** | Restricted-q variational objectives/approximate expectations → L09; stochastic sampling methods → L10; exact structured latent-state computation → L08; VAE specialization → L12. L07 may recognize EM's query/computation distinction, without rederiving it. |
| **Omitted by course decision** | §6.5.2 logistic MM, §6.5.5 robust-regression EM, §6.5.6 extension catalogue and online/ECM/MCEM derivations; full GMM E/M derivation, MAP covariance priors, component-number selection, MRI preprocessing/segmentation, mixture degeneracy theory and full Ch. 28 latent-factor catalogue. No invisible recording debt. |

Coordinator should record selective proposed §§6.5.1, 6.5.3–6.5.4 allocation and narrow broad §6.5.1–6.5.6/§28.2 syllabus references; actual delivered ledger boundaries remain unchanged. L09 inherits the general identity and the exact-versus-restricted-q distinction, and must not assume Gaussian mean imputation was taught as EM.

**Questions/hesitations for consolidation:**

1. **Scope owner / advisory, medium priority:** accept Gaussian missing-data EM as the primary lab, losing the proposed biomedical MRI segmentation outcome? Provisional choice protects expected-second-moment depth and L01 continuity within one hour. MRI is a legitimate alternative with extra preprocessing/model burden, not a second required lab; instructor preference could change the example and notebook contract.
2. **Scope owner / advisory:** generic proof plus moment assembly is tight. First cut is the six-minute mixture calculation, preserving recognition; deeper cuts must preserve conditional covariance and return through Scope. Actual timing remains unknown.
3. **Notebook owner / downstream-owned:** ensure MCAR mask/co-observation and SPD behavior support an unregularized demonstration. More data/scaffolding is the first repair; silently adding ridge changes the exact update/objective promise. Runtime and reference-helper reliability are unverified.

**Next owner:** Instructor oversight of this reviewed proposal. Subsequent Section Design requires human acceptance; its execution backpressure returns to the nearest owning stage. Review and approval provenance are in the registry. No rehearsal, notebook runtime or hosted Colab validation is implied.
