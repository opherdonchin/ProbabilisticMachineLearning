# Questions and hesitations for instructor oversight

**Status:** Completed autonomous proposal for instructor oversight, 2026-10-11. All ten scopes have actual independent feasibility reviews; a separate adversarial course review found no architectural blocker. Every resolution below is agent-approved / instructor-pending under WORK_ORDER. Exact final artifact identities and approval provenance live in [STATUS](STATUS.md), rather than this human decision report.

## L03 — What should the first restoration algorithm claim? (medium)

**Question:** Accept deterministic coordinate restoration as the image endpoint before formal VI/MCMC?

**Evidence:** The actual Murphy notebook uses Gibbs/mean-field, requiring later mathematics, and has inconsistent noise scaling. The course square has a verified coordinate-stable state whose posterior score is below exact joint MAP. Its local conditional is sound; its local decision is not a posterior sample or a marginal.

**Provisional resolution:** Keep image restoration using explicitly sequential ICM, a tiny enumeration oracle, and the nonglobal-optimum counterexample. All image construction, boundary handling, sweeps and plotting are supplied; students own the local mathematical computation.

**Alternatives and cost:** Exact tiny-image enumeration removes algorithmic risk but loses the larger image application. Teaching Gibbs/mean-field now would take primary derivations from L09/L10 and overload L03. Optional five-minute Gaussian precision comparison is the first cut; it is not a required outcome.

**Review evidence:** [L03 scope](../L03_Graphical_Models/lecture_scope.md), [independent review](reviews/L03_review.md), exact scope blob f4dab507f90618362c2e04c1c3791c8139f7de56. No blocker; CI pace and lab scaffolding remain downstream timing risks.

## L04 — Preserve real error correction with an adapted code? (medium)

**Question:** Accept the course-constructed five-bit channel example rather than reproducing the textbook's three-bit XOR code?

**Evidence:** The XOR source is a detection/ambiguous-decoding example; it cannot guarantee single-error correction. Our code c(m)=(m1,m2,m1,m2,m1 XOR m2) has minimum distance three. Independent arithmetic verifies all one-flip cases, ambiguous multiple-error posteriors, MI and Bayes block risk. A decoding guarantee is separate from average error or information per channel use.

**Provisional resolution:** One five-bit noisy-channel lab. Keep source coding at stated entropy/prefix-length bounds, MI identity at derivation depth and DPI at proof-sketch depth. Complete probability tables and noise curves belong to the lab; no second coding lab, capacity theorem or full information bottleneck.

**Alternatives and cost:** Retain source XOR as an optional two-minute contrast, or replace the entire operational endpoint with source compression. The latter changes the practical skill and would require a new scoped review. Shorten the sufficiency recall before cutting MI/DPI; use a finite candidate-parameter framing or only the CI interpretation, never a discrete-entropy substitution for a continuous Beta parameter.

**Review evidence:** [L04 scope](../L04_Information_Theory/lecture_scope.md), [independent review](reviews/L04_review.md), reviewed substantive blob 242ee28d251d583004daa25379b6a0f8cb44d622. No blocker; probability-table axes, support and zero-log handling require supplied helpers and a later student timing trial.

## L05 — How much first-exposure mathematics fits with PyTorch? (high)

**Question:** Is the combined family/gradient/AD endpoint the right use of the tightest early lecture?

**Evidence:** L05 budgets 115 minutes including 12 reserve for substantive Gaussian/Bernoulli/Poisson unification, one dispersion-correct canonical gradient, a short vector softmax application, a complete reverse-mode graph and minibatch SGD. Its independent review found no mathematical/source blocker, but judged live and first-PyTorch 60-minute workload tight and unmeasured.

**Provisional resolution:** Preserve the common GLM family and complete reverse graph; do not derive three separate family gradients. Give data, train/test split, standardization, indexing and plots; students check manual versus automatic gradients and one visible SGD cycle. No DataLoader tutorial, optimizer catalogue, Hessian/IRLS or Bayesian GLM inference.

**Alternatives and cost:** Remove the optional MAP/numerical-probit/repeated-application package first (estimated 6–8 minutes, not measured). Removing a core gradient or AD explanation would weaken later VI/neural/VAE work. Restoring a standalone GLM meeting would require displacing a whole accepted lecture; the autonomous proposal does not make that change.

**Review evidence:** [L05 scope](../L05_GLM_Optimization/lecture_scope.md), [independent review](reviews/L05_review.md), reviewed substantive blob 736943b90f24826e29955115896929742f2961f5. Later actual L02 delivery and software retention must be checked; scope approval is not runtime validation.

## Shared protected-prerequisite and publication gates

L02's agreed section contract is protected, but it is not recorded as delivered. Its malformed/stale development-state register is not evidence of new approvals. Reconcile the actual taught boundary before teaching these scopes; do not retrospectively alter L01/L02 to conceal backfill. All future labs require separately authored validated solutions, clean local uv execution and fresh hosted Colab runs before publication. Source inspection and small mathematical arithmetic checks do not establish student timing, source-output reliability or Colab compatibility.

## L06 — Gaussian uncertainty or biomedical mixtures? (medium)

**Question:** Prefer the deep missing-Gaussian EM example over the MRI segmentation candidate?

**Evidence:** The inspected Gaussian reference hides fitting in a helper, while L06 now exposes first and second conditional moments, a verified complete EM iteration and the exact monotonicity conditions. It naturally extends L01's known-parameter inference to learning unknown parameters. A full GMM update plus MRI preprocessing would add a second application and more implementation burden.

**Provisional resolution:** Gaussian EM lab with supplied driver and data/mask checks; mixture responsibilities are a short illustration, not full GMM fitting. Expected second moments include posterior covariance. Exact E-step tightness is essential; approximate q only gives a lower bound and does not inherit likelihood monotonicity.

**Alternatives and cost:** Substitute MRI/GMM as the primary case, with a new worked solution and scoped review; it gains biomedical interpretation but loses the uncertainty-preserving missing-data thread. Do not quietly retain both. Optional numerical mixture illustration is a six-minute first cut.

**Evidence:** [L06 scope](../L06_EM/lecture_scope.md), [independent review](reviews/L06_review.md), reviewed substantive blob 326267281c6b6775ac9a33d7ed4f022a859fc49b. Data-level SPD and sufficient co-observation remain later implementation checks, not proven by symbolic formulas.

## L07–L08 — Which exact computations earn deep treatment? (high for L08 practical choice)

**Question:** Accept one controlled scalar grid/Laplace comparison and HMM forward/backward as the sequence core, replacing the preferred Kalman forecasting lab?

**Evidence:** L07's fully specified logistic posterior has a finite unique mode from a proper prior, and independent arithmetic shows grid mean differs from the Laplace center. Domain widening and spacing refinement are required checks. L08's tiny exact HMM distinguishes path MAP from marginal modes and validates scaled recursions; a second full Kalman implementation would exceed the chosen one-algorithm budget. Oke forecasting questions and data were located, but the named solved notebook remains unverified.

**Provisional resolution:** L07 controlled eight-observation benchmark; L08 HMM NumPy lab and compact Kalman reuse of L01 conditioning. Generic inference menus remain recognition, not hidden prerequisites for VI/MCMC. No JAX/Dynamax stack.

**Alternatives and cost:** Keep Berkeley's random scalar case but revalidate all outputs, or reverse L08's depth allocation: Kalman forecasting primary, HMM compact. The latter is a coherent alternative but removes the current full discrete-message/smoothing practice and requires new source/workload review. It is a real practical tradeoff, not an equivalent label change. Optional Beta/determinant illustrations in L07 and Viterbi mechanics in L08 are first cuts.

**Evidence:** [L07 scope](../L07_Inference/lecture_scope.md), [independent review](reviews/L07_review.md); [L08 scope](../L08_Structured_Inference/lecture_scope.md), [independent review](reviews/L08_review.md). Preserve checking work before extra plots or method comparisons. Neither lab is executed/timed here.

## L06–L11 — Is exact checking worth the loss of empirical breadth? (high)

**Question:** Retain controlled cases as the main computational progression, or restore one displaced domain application?

**Why/evidence:** The [adversarial review, C4](reviews/course_architecture_review.md) independently identifies the same tradeoff as the local reviews: missing-Gaussian EM replaces MRI segmentation, HMM messages replace forecasting, known-noise regression replaces GDP/unknown-noise VI-versus-HMC, and synthetic heteroskedastic prediction replaces broader neural applications. Method outcomes survive; these domain outcomes do not. Repeated Gaussian work changes the query or operation (conditioning, expected statistics, local approximation, restricted posterior, nonlinear likelihood), rather than repeating a proof.

**Provisional resolution:** Retain controlled comparisons and exact numerical oracles, then one real mobility application in L12. Formal syllabus and ledger remove the discarded domain promises.

**Alternatives/cost:** Restore one chosen domain by replacing that lecture's primary lab and rechecking its workload. Forecasting is the highest-priority alternative because it changes L08's algorithmic depth allocation. Restoring all applications would require more lab time or displacement of methods; it is not an optional plotting extension. This question groups the global breadth decision; the local entries above retain their distinct algorithm choices.

## L09 — Which variational error should students isolate? (medium)

**Question:** Prefer known-noise regression with exact and best-diagonal references over source GDP/unknown-noise/HMC?

**Evidence:** [L09 scope](../L09_Variational_Inference/lecture_scope.md) and [review including targeted HMC repair](reviews/L09_review.md) separate optimizer, family and sampling-estimator error. The reverse-KL optimum uses inverse diagonal precision, not marginal variances. A single total pathwise derivative includes direct parameter dependence. Source HMC would create a backward dependency on L10 and Pyro would add a stack.

**Provisional resolution:** One PyTorch diagonal-Gaussian fit with supplied reference/driver; ten-minute software refresh is included. CAVI is a bounded same-target application, not a second implementation. Analytic/autograd checks compare the same finite-draw likelihood-minus-analytic-KL estimator at fixed epsilon.

**Alternatives/cost:** Unknown-noise empirical regression is more realistic but loses a clean exact reference and adds preprocessing/inference choices. A full CAVI/VBEM treatment displaces the pathwise spine. Optional numerical CAVI sweeps are first cuts, not required extra work.

## L09–L12 — Can loss units and probability axes remain explicit? (high implementation gate)

**Question:** Accept the normalization contracts as binding worked-solution checks?

**Evidence:** [Source inspection](source_inspection.md) and [adversarial C1/negative tests](reviews/course_architecture_review.md) expose errors that plausible learning curves cannot detect. L09 sums observation likelihoods and counts prior KL once; mean likelihood requires KL/N. L11's mean-loss Gaussian-prior coefficient includes N. L12 sums observed and latent event axes separately, then averages observations; source feature/latent means make source beta 4 equivalent to course coefficient 19, not course beta 4. L04 uses bits; later losses use nats. B2's printed pathwise-ELBO sign and Gaussian-KL constants require correction.

**Provisional resolution:** Carry exact axis/unit/variance conventions and matched-estimator gradient checks into the [notebook audit](../notebook_reference_audit.md). L12 held-out D averages event-summed NLL over q draws and weights batches by case count; mean-code reconstruction remains a separate visualization. Supplied beta comparisons must be freshly trained under the same course objective, splits, transforms and decoder variance.

**Alternatives/cost:** An equivalent rescaled objective is valid only if every term/coefficient is transformed together and stated explicitly. Reusing stored source fits without conversion is not defensible. These checks add supplied assertions/metric helpers, not a second student fit or extra hour.

## L10 — How much sampler theory is enough? (medium)

**Question:** Prioritize MH validity and observable mixing failure over a full HMC derivation?

**Evidence:** [L10 scope](../L10_MCMC/lecture_scope.md) and [review](reviews/L10_review.md) allocate 110 live minutes including reserve to IID error, stationarity/detailed balance, Hastings correction/rejection, bounded Gibbs and dependent-query error. The multimodal target makes start/proposal sensitivity visible. ESS cannot certify convergence and stuck chains need explicit diagnostic flags.

**Provisional resolution:** MH is the single implemented kernel; Gibbs cancellation is bounded, HMC mechanics are recognition only. Full HMC theory is omitted consistently in L09/L10 and formal records.

**Alternatives/cost:** HMC as the main lab needs geometry, integrator/acceptance and additional software/theory, and loses the current mode-exploration comparison unless another topic is displaced. Remove optional numerical planning/NUTS/proposal elaboration first; return core overruns to Scope rather than accelerate the proof.

## L11 — What does a neural interval represent? (medium)

**Question:** Retain conditional-noise learning as the neural endpoint without claiming posterior weight uncertainty?

**Evidence:** [L11 scope](../L11_Neural_Prediction/lecture_scope.md) and [review](reviews/L11_review.md) preserve positive-SD heads, correct Gaussian NLL/derivatives and Gaussian-prior/L2 scaling. The source standard-deviation law and variance law differ. A fitted-weight observation interval is not a Bayesian neural-network posterior interval.

**Provisional resolution:** One shallow PyTorch fit plus a supplied fixed-scale baseline/checkpoint, common split and training-only residual-scale estimation. AD/SGD are reused; total-variance interpretation is applied. No architecture zoo, dropout-as-inference, calibration survey or BNN implementation.

**Alternatives/cost:** Adding posterior-weight inference or modern architecture theory requires a substantial replacement, not a renamed output band. One CPU fit and supplied fallback must be piloted; test data cannot select the run or checkpoint.

## L12 — How should mobility latent patterns be interpreted and distributed? (high)

**Question:** Accept a standardized fixed-Gaussian mobility VAE as a descriptive application, conditional on portable, permitted data access?

**Evidence:** [L12 scope](../L12_VAE/lecture_scope.md), [review and targeted metric check](reviews/L12_review.md) and inspected instructor PS4 source specify 349 rows, 19 features, four latent coordinates and fixed decoder variance. Mixed-domain features are only approximately Gaussian after transformation. Rate decomposes into mutual information plus aggregate mismatch; positive rate need not imply informative codes. Latent coordinates are not identifiable causal or guaranteed disentangled factors. The local instructor source/data were inspected, not redistributed or run.

**Provisional resolution:** Compact one-fit lab with supplied preprocessing, driver and fresh normalized beta comparisons; descriptive profiles and collapse/rate interpretation only. Expected-q distortion is distinct from encoder-mean visualization. Resolve data permission/portable delivery and CPU/checkpoint preparation before publication.

**Alternatives/cost:** A synthetic or openly licensed tabular substitute reduces distribution friction but changes the empirical endpoint and needs a targeted Scope review. Support-respecting mixed likelihoods add modeling/implementation beyond this lab. Optional deterministic-AE/sign-flip/traversal extras are first cuts; multiple full beta fits remain supplied, not student requirements.

## Whole-course omissions and feasibility envelope (high if broader coverage is required)

**Question:** Accept a selected methods spine rather than requiring every central-book extension or prior candidate application?

**Evidence:** The [whole-course ownership matrix](architecture_audit.md) explicitly allocates or excludes Chapters 4–12, 15–16 and 21, plus Ch13 and §§6.6–6.9. [Independent cold review](reviews/course_architecture_review.md) found no necessary missing foundation or backward dependency. The ten inclusive budgets total 1117 live minutes, including 120 reserve, and 600 lab minutes; all estimates are unmeasured and most labs require supplied infrastructure.

**Provisional resolution:** Omit SMC, natural/advanced optimization, Bayesian optimization, transport, specialized graph inference, sparse/hierarchical GLM inference, full VI/HMC catalogues, broad calibration, BNN/GP/shift, architecture surveys and modern generative alternatives. No required recording is used to hide coverage. Preserve live load-bearing calculations and the one-lab boundary.

**Alternatives/cost:** Choose one omitted field and name the lecture/topic it replaces. A strict 100-minute delivery window, rather than the authorized upper 110–115-minute plans, requires scope backpressure and reallocation. Removing an optional lab rerun already outside the core creates no core margin. Rehearse sections and pilot L05/L08/L09/L12 before treating feasibility estimates as observed pace.

## Executive oversight priorities

The proposal is complete, with ten agent approvals supported by distinct specialist reviews and a separate adversarial pass; no unresolved architectural blocker remains. The highest-value human choices are L05's first-PyTorch density, HMM versus Kalman forecasting and the combined loss of empirical breadth, plus L12's descriptive likelihood/data-access assumptions. Timing, scaffolding/checkpoints and clean local uv/hosted Colab execution remain downstream production gates. Actual L02 delivery must be reconciled without rewriting its agreed contract. Instructor acceptance is still pending; this branch is not merged or released.
