# Questions and hesitations for instructor oversight

Status: current coordinator synthesis during autonomous scoping, 2026-10-11; Wave A reviewed, later waves/global review pending. Every resolution is provisional agent judgment under WORK_ORDER, not instructor acceptance. No interim human decision is needed to continue.

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

**Review evidence:** [L04 scope](../L04_Information_Theory/lecture_scope.md), [independent review](reviews/L04_review.md), blob242ee28d251d583004daa25379b6a0f8cb44d622. No blocker; probability-table axes, support and zero-log handling require supplied helpers and a later student timing trial.

## L05 — How much first-exposure mathematics fits with PyTorch? (high)

**Question:** Is the combined family/gradient/AD endpoint the right use of the tightest early lecture?

**Evidence:** L05 budgets115 minutes including12 reserve for substantive Gaussian/Bernoulli/Poisson unification, one dispersion-correct canonical gradient, a short vector softmax application, a complete reverse-mode graph and minibatch SGD. Its independent review found no mathematical/source blocker, but judged live and first-PyTorch60-minute workload tight and unmeasured.

**Provisional resolution:** Preserve the common GLM family and complete reverse graph; do not derive three separate family gradients. Give data, train/test split, standardization, indexing and plots; students check manual versus automatic gradients and one visible SGD cycle. No DataLoader tutorial, optimizer catalogue, Hessian/IRLS or Bayesian GLM inference.

**Alternatives and cost:** Remove the optional MAP/numerical-probit/repeated-application package first (estimated6–8 minutes, not measured). Removing a core gradient or AD explanation would weaken later VI/neural/VAE work. Restoring a standalone GLM meeting would require displacing a whole accepted lecture; the autonomous proposal does not make that change.

**Review evidence:** [L05 scope](../L05_GLM_Optimization/lecture_scope.md), [independent review](reviews/L05_review.md), blob736943b90f24826e29955115896929742f2961f5. Later actual L02 delivery and software retention must be checked; scope approval is not runtime validation.

## Shared protected-prerequisite and publication gates

L02's agreed section contract is protected, but it is not recorded as delivered. Its malformed/stale development-state register is not evidence of new approvals. Reconcile the actual taught boundary before teaching these scopes; do not retrospectively alter L01/L02 to conceal backfill. All future labs require separately authored validated solutions, clean local uv execution and fresh hosted Colab runs before publication. Source inspection and small mathematical arithmetic checks do not establish student timing, source-output reliability or Colab compatibility.

## L06 — Gaussian uncertainty or biomedical mixtures? (medium)

**Question:** Prefer the deep missing-Gaussian EM example over the MRI segmentation candidate?

**Evidence:** The inspected Gaussian reference hides fitting in a helper, while L06 now exposes first and second conditional moments, a verified complete EM iteration and the exact monotonicity conditions. It naturally extends L01's known-parameter inference to learning unknown parameters. A full GMM update plus MRI preprocessing would add a second application and more implementation burden.

**Provisional resolution:** Gaussian EM lab with supplied driver and data/mask checks; mixture responsibilities are a short illustration, not full GMM fitting. Expected second moments include posterior covariance. Exact E-step tightness is essential; approximate q only gives a lower bound and does not inherit likelihood monotonicity.

**Alternatives and cost:** Substitute MRI/GMM as the primary case, with a new worked solution and scoped review; it gains biomedical interpretation but loses the uncertainty-preserving missing-data thread. Do not quietly retain both. Optional numerical mixture illustration is a six-minute first cut.

**Evidence:** [L06 scope](../L06_EM/lecture_scope.md), [independent review](reviews/L06_review.md), blob326267281c6b6775ac9a33d7ed4f022a859fc49b. Data-level SPD and sufficient co-observation remain later implementation checks, not proven by symbolic formulas.

## L07–L08 — Which exact computations earn deep treatment? (high for L08 practical choice)

**Question:** Accept one controlled scalar grid/Laplace comparison and HMM forward/backward as the sequence core, replacing the preferred Kalman forecasting lab?

**Evidence:** L07's fully specified logistic posterior has a finite unique mode from a proper prior, and independent arithmetic shows grid mean differs from the Laplace center. Domain widening and spacing refinement are required checks. L08's tiny exact HMM distinguishes path MAP from marginal modes and validates scaled recursions; a second full Kalman implementation would exceed the chosen one-algorithm budget. Oke forecasting questions and data were located, but the named solved notebook remains unverified.

**Provisional resolution:** L07 controlled eight-observation benchmark; L08 HMM NumPy lab and compact Kalman reuse of L01 conditioning. Generic inference menus remain recognition, not hidden prerequisites for VI/MCMC. No JAX/Dynamax stack.

**Alternatives and cost:** Keep Berkeley's random scalar case but revalidate all outputs, or reverse L08's depth allocation: Kalman forecasting primary, HMM compact. The latter is a coherent alternative but removes the current full discrete-message/smoothing practice and requires new source/workload review. It is a real practical tradeoff, not an equivalent label change. Optional Beta/determinant illustrations in L07 and Viterbi mechanics in L08 are first cuts.

**Evidence:** [L07 scope](../L07_Inference/lecture_scope.md), [independent review](reviews/L07_review.md); [L08 scope](../L08_Structured_Inference/lecture_scope.md), independent review in progress. Preserve checking work before extra plots or method comparisons. Neither lab is executed/timed here.

## Remaining synthesis

L09–L12 choices and the adversarial whole-course findings will be consolidated here after those gates close. This is an active report, not a completed proposal.
