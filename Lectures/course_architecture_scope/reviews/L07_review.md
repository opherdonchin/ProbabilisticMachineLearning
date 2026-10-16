# L07 review: explanation for the instructor

This reading guide was written by the coordinator. The original independent review is preserved verbatim below; it identifies its own reviewer, exact earlier scope version and checks. [STATUS](../STATUS.md) identifies the current readable scope and any subsequent revision check. Rewriting a guide is not a new independent approval.

**What was assessed:** Posterior approximation: compare a grid with a Gaussian shortcut. The reviewer asked whether the mathematics, student prerequisites and one-hour task could fit the proposed meeting.

**What the original review concluded:** The proposal was feasible with risks, meaning no demonstrated mathematical or structural obstacle was found, but time and supplied-code requirements remained uncertain. No student notebook or teaching trial was validated.

**What matters for the teaching choice:** The one-parameter posterior is a useful way to test a Gaussian shortcut. The comparison must check the numerical grid too, by widening it and refining its spacing. Source prose claiming close agreement is not evidence of actual accuracy.

## Original independent review and later technical check records

# L07 independent Section Design feasibility preview

**Role/thread:** Section Design specialist `/root/review_l05`, independent of scope builder `/root/build_l04`. **Mode:** `feasibility-review` only. **Date:** 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`. **Exact target:** `Lectures/L07_Inference/lecture_scope.md`, blob **`f12fba8de7339675d09a771c5f956c8ed93649d8` before and unchanged after review**. **Contract:** architecture audit v2, blob `12ae5e1608eb2d74c6c70ba857eb5a75ff2114c1`. Only this report was written; L05/L06 reports, upstream scopes and shared artifacts were preserved. No sections, slides, notebook or approval was produced.

**Verdict: `feasible-with-risks`; no unresolved blocking concern.** Confidence is medium-high for mathematical consistency and medium for route feasibility, medium-low for unmeasured timing. The 110-minute inclusive live plan contains genuine new approximation mathematics and a useful numerical-checking endpoint. The lab is plausible only with the promised solver/mesh/plot scaffolding and no VI/MCMC extension.

## Evidence, prerequisites and novelty

Applied canonical Section Design feasibility review, shared backpressure, timing calibration, repository instructions and WORK_ORDER. Read the full five-part scope and contract v2. This review thread inspected protected L01 source and known-parameter missing-Gaussian solution, L02 agreed section design/stale metadata, Wave A L03–L05 handoffs and L06's reviewed EM scope, plus ledger/syllabi/notebook audit. Relevant review targets: L05 blob `736943b90f24826e29955115896929742f2961f5`; L06 blob `326267281c6b6775ac9a33d7ed4f022a859fc49b`. Their mathematical and software outcomes are commitments, not future-delivery evidence.

L01 supplies Gaussian precision/normalization and probability queries; L05 supplies Bernoulli likelihood/gradient but expressly excludes the Hessian derivation. L06 supplies a generic ELBO identity, which L07 needs only to recognize VI's later purpose. Consequently Taylor normalization, posterior curvature, quadrature mass/density and query-specific checking are new here, rather than an inference overview renamed as substance. A coherent dependency route exists from likelihood gradients to a proper-prior scalar mode, positive curvature, normalized Laplace approximation and independent numerical integration. It needs neither MCMC correctness nor a VI solver. Exact structured recursions remain L08-owned; VI and sampling remain L09/L10-owned.

Direct book inspection used B2 `/tmp/pml-book2.txt` §§7.1–7.4.3, selected §7.5 and §§15.3.5–15.3.6; B1 `/tmp/pml-book1.txt` §4.6.8.2 and §10.5.1. Checked the actual Beta example data and Laplace/evidence formulas, not just subsection titles. Source limitations below distinguish correct scope commitments from problematic source wording.

## Mathematical and source checks

The scalar Taylor expansion drops the linear term only at a differentiable interior stationary mode. `H=E''(hatθ)>0` supplies a normalizable Gaussian with variance `H⁻¹`. Its quadratic-surrogate integral is `exp(−E(hatθ))sqrt(2π/H)`; the multivariate determinant statement is correct for symmetric positive-definite curvature. A nonnegative Hessian is insufficient. The scope distinguishes the surrogate's exact normalization from approximation of the original evidence and posterior moments, and covers boundary/singular/multimodal/skew limitations without an unbudgeted theorem catalogue.

Retaining constants in `u=p(θ)p(D|θ)` is essential for evidence. Omitting a constant in `E` changes `Z` by the corresponding multiplicative factor while leaving mode and normalized shape unchanged. The scope explicitly states this. No evidence-based model-selection outcome is promised, so a separate numeric evidence exercise is unnecessary.

The fixed logistic model is fully specified: eight observations, no intercept, prior variance 4. Its `E'` and `E''` have the correct prior precision and likelihood signs. `E''≥1/4>0`, while the Gaussian quadratic makes `E` coercive because Bernoulli NLL is nonnegative. Thus the finite unique mode exists even though the likelihood-only separated slope tends to positive infinity. This is a justified result for this model, not a blanket posterior-unimodality theorem. Laplace posterior variance is a local approximation; the scope does not equate it with actual posterior variance.

The normal-to-lognormal example correctly yields transformed mode `e⁻¹` rather than transformation of the normal mode, 1. The change-of-variable Jacobian distinguishes continuous density height from L04 finite-state probability mass. The optional B2 Fig. 7.3 example is source-verified: 10 heads/one tail plus uniform prior gives `Beta(11,2)`, mode `10/11`, mean `11/13`. Gaussian support leakage on that coordinate is real; a logit treatment would require its Jacobian and is not silently equivalent.

Grid quadrature correctly uses weighted masses `w_j=u_jω_j/Z_grid` and weighted expectations. Equal-width masses and density heights are different units. This improves on B2 Eq. 7.20's ambiguous normalized-score/density convention: a sum-normalized score cannot also be treated as a density and multiplied by cell width without correcting normalization. For trapezoidal endpoints or unequal weights, downstream implementation should obtain density from `u/Z_grid` (equivalently `w_j/ω_j`); the scope's `w_j/Δ` statement applies to genuinely equal quadrature weights. This is a local explanation/implementation detail, not a Scope blocker.

B2 §15.3.5 reverses the Gaussian-prior variance-limit interpretation. L07 correctly says small variance strengthens shrinkage and large variance weakens it. B2's approximate normalizer uses the same symbol as the exact evidence; L07's separate `Z_L` avoids adopting an exactness claim. Posterior prediction integrates the sigmoid against either posterior reference or Laplace density; substituting a mode is a different computation. No probit shortcut, sampler or KL-optimality claim is smuggled in.

### Independent fixed-example arithmetic

Used a separate standard-library scratch calculation with stable softplus/sigmoid, bisection and trapezoidal quadrature; no reference or course notebook was run. It gives `E'(0)=−5`, `E''(0)=4`, mode `2.272282974655834`, curvature `0.7341609182304524`, Laplace SD `1.1670900568622982`, plug-in prediction `0.9065553643760276`. Domain/resolution checks were:

| Domain / spacing | Grid mean | Grid SD | Grid prediction at x*=1 |
|---|---:|---:|---:|
| `[-8,8]`, 0.004 | 2.686942595 | 1.196450573 | 0.901915477 |
| `[-12,12]`, 0.004 | 2.688288149 | 1.199567048 | 0.901938311 |
| `[-16,16]`, 0.004 | 2.688288221 | 1.199567332 | 0.901938311 |
| `[-16,16]`, 0.002 | 2.688288221 | 1.199567332 | 0.901938311 |

Laplace-integrated prediction on the final domain is `0.863072224919592`, reproducing the quoted target. The Laplace predictive discrepancy is appreciable even though its SD is near the actual SD; plug-in happens to be closer for this specific query. No universal ranking is justified. Domain expansion matters before the final targets stabilize. Refinement at the widest domain independently confirms spacing stability to the shown precision; it does not mathematically certify tail error. These are independently checked course-constructed numbers, not source outputs or a notebook-runtime result.

### Berkeley reference inspection

Inspected the actual saved HTML `/tmp/berkeley-laplace.html`, parsed its code blocks and stored outputs. SHA256 matches `539be24de77588d434e7a52de238194cfafa8938f7bfe8590fba6eab36496c63`. The scalar case uses 30 simulated logistic observations, `τ=2`, fixed `[-8,8]` grid with 10,000 nodes, SciPy optimization and a Gaussian VI/Gauss–Hermite branch; later material reads frogs data and adds multivariate inference/MH. Its printed scalar grid mean `2.778120321...` and Laplace mean `2.522942209...` do not support prose suggesting agreement to two or three decimals. A normalized fixed-domain plot is also not analytic truth. The scope properly prunes these branches, freezes different course data and corrects the reference's “exact grid” language.

## Material concerns and minimum repairs

### 1. Preserve the substantial core within the inclusive live budget

**Owner/severity:** Lecture Scope — advisory; Section Design owns local allocation. **Evidence:** `16+20+32+30=98`, plus 12 reserve gives 110 minutes. The first 36 minutes combine query framing, coordinate modes and quadrature, leaving 62 for Taylor normalization and the logistic curvature/comparison. This is plausible, but an expanded taxonomy, new conjugacy proof or generic Newton/Hessian lesson would displace the genuinely new work. The 19–23 prototype slide-equivalents do not establish a fast rate for normalization and numerical error distinctions.

**Provisional treatment:** proceed with carried Bayes/Bernoulli formulas and the promised scalar derivation; retain reserve. **Smallest repair if pressure appears:** remove optional Beta support calculation and determinant illustration, preserving the multivariate statement and scalar normalizer; rehearse Taylor/grid explanation. Claimed 6–8-minute savings are estimates. **Consequence/decision:** this first cut preserves the endpoint. Further reductions to grid checks or curvature/normalizer depth require Scope backpressure; this preview does not certify unchanged coverage at a strict 100-minute cap. Section Design may choose exact boundaries without creating a second model.

### 2. The lab's checking skill must survive software scaffolding

**Owner/severity:** Notebook authoring — downstream-owned, with advisory Scope risk. **Evidence:** the 60-minute lab allocates 12 minutes to posterior/solver/curvature, 15 to grid moments and 12 to independent domain/spacing checks. First-time quadrature users may otherwise mistake a sum-normalized finite grid for an exact posterior. Students are not presumed fluent in SciPy solver or integration APIs, and the reference is a substantially larger multi-method lesson.

**Provisional treatment:** supplied solver, mesh/weights, table and plotting harness; student work remains stable objective/curvature, weighted summaries and interpretation of convergence changes. **Smallest repair:** pilot this narrow path, provide explicit shape/unit checks and automate repetitive comparison runs; remove optional prior sensitivity first. Account for the Laplace Gaussian tails independently rather than renormalizing both methods on a misleading narrow common domain. **Consequence/decision:** no new library/solver tutorial or source-code replication obligation. If the core checking cannot fit, return to Scope rather than relabel an unchecked grid “exact” or omit predictive integration.

### 3. Later ownership and source corrections require consistent bookkeeping

**Owner/severity:** Coordinator/Lecture Scope — advisory; source-faithful exposition is downstream-owned. **Evidence:** the source and old broad syllabus ranges can imply full Chapter 7 methods, VI, MCMC or SMC. The reviewed endpoint instead contains one Laplace derivation and one checked scalar posterior. L05 did not teach Hessians, so this lecture must keep its new curvature derivation; L06 supplies only recognition-level VI context here. Scope source corrections concerning normalizers, grid language and prior variance are materially important for downstream explanations.

**Provisional treatment:** maintain narrow algorithm ownership and the controlled eight-case benchmark. **Smallest repair:** reconcile syllabus/ledger wording to selected §7.4.2–§7.4.3 and §7.5 checks, with other methods explicitly recognized/deferred/omitted. Carry source cautions to downstream design so exact and approximate constants remain distinct. **Consequence/decision:** no extra live theory; changing the fixed data, prior or intercept would invalidate all numerical targets and require a targeted mathematical recheck. Instructor review of the controlled-data choice remains a consolidated question, not a reason to halt this authorized batch.

## First cut, invariants and limits

**Single best cut:** remove optional Beta support/skew calculation and determinant illustration; keep coordinate-dependence warning, scalar Taylor/normalizer, positive-definite condition, proper-prior logistic calculation and grid/predictive comparison. Optional sensitivity is outside required lab time already and cannot be claimed as recovered core margin.

Retrospective closure and separate notebook handoff are explicitly preserved. The scope avoids repetition of L01 Gaussian inference, L05 likelihood differentiation and L06 ELBO proof by applying their results to a new approximation/checking responsibility. Exact section partition and slide organization remain downstream decisions.

**Validation limits:** no notebook/reference was executed; no local uv run, hosted Colab run, API/version validation, student pilot, runtime benchmark or lecture rehearsal occurred. Scratch bisection/quadrature checks establish the named numerical commitments only. They provide empirical domain/resolution evidence, not an analytic tail bound, global guarantee for arbitrary logistic models or publication readiness. The old reference outputs are inspection evidence only.

**Disposition:** no mandatory blocking Scope repair before continued cross-course reconciliation. Keep timing/scaffolding risks and source corrections visible. This independent preview is not agent/instructor approval or validated Section Design. Re-review only when a substantive change invalidates the assessed model, route, depths, prerequisites or inclusive time envelope.
