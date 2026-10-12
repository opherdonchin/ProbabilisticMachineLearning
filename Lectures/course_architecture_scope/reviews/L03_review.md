# Current L03 review target — restored instructor-agreed scope

The current target is the instructor-agreed graphical-model scope recovered from `lecture-3-authoring`, final scope blob `2d5992a3f05d952dc21553690039fe021fd6284a`. The [independent authority correction and restoration review](#independent-authority-correction-and-restoration-review--2026-10-12) below assesses its restoration and shared-record reconciliation: **feasible with risks; no reconciliation blocker found**. The lecture develops factorization and conditional independence; image-model construction, posterior/conditional derivation and ICM remain new notebook work. Complete Section Design approval and notebook validation remain outstanding.

The earlier guide, reviews and diagnostic records below concern their stated batch-proposal versions. Their mathematical checks remain identifiable evidence; they are not transferred as approval of the restored scope. All previous report bytes are preserved after this notice. The [current register](../STATUS.md) records the exact authority and review status.

---

# L03 review: explanation for the instructor

This reading guide was written by the coordinator. The original independent review is preserved verbatim below; it identifies its own reviewer, exact earlier scope version and checks. [STATUS](../STATUS.md) identifies the current readable scope and any subsequent revision check. Rewriting a guide is not a new independent approval.

**What was assessed:** Graphical models: local calculations in a large model. The reviewer asked whether the mathematics, student prerequisites and one-hour task could fit the proposed meeting.

**What the original review concluded:** The proposal was feasible with risks, meaning no demonstrated mathematical or structural obstacle was found, but time and supplied-code requirements remained uncertain. No student notebook or teaching trial was validated.

**What matters for the teaching choice:** The probability calculation and simpler image update are defensible. The main risks are explaining what graph-based independence does and does not imply, and providing enough code so the lab focuses on the pixel calculation. A locally improved image is not guaranteed to be the best whole image.

## Original independent review and later technical check records

# L03 independent Section Design feasibility review

**Reviewer role:** Section Design specialist. **Mode:** `feasibility-review` only. **Reviewer thread:** `/root/review_l03`, distinct from Scope builder `/root/build_l03`. **Date:** 2026-10-11. **Branch checked:** `scope-l03-l12-course-architecture`.

**Exact target:** `Lectures/L03_Graphical_Models/lecture_scope.md`, Git blob `f4dab507f90618362c2e04c1c3791c8139f7de56`. The working-file blob matched the assignment before inspection and again after mathematical/source checks; final persistence check also required the same blob. Upstream cross-course contract v1: `Lectures/course_architecture_scope/architecture_audit.md`, blob `882a9b2e76134d4952b218492a3564e117f6d6b4`.

**Verdict: feasible-with-risks.** No demonstrated blocking Scope issue. Confidence is moderate in mathematical/dependency feasibility and lower in live/lab timing. This is a bounded independent preview, not Section Design construction, delivery validation, notebook validation, or approval. The coordinator retains the delegated agent-approval decision and subsequent instructor-facing questions. This reviewer changed only this report, generated no sections or slide outline, and did not commit.

## Assessment

The route can plausibly establish its endpoint from the actual prior boundary. L01 supplied joint/conditional queries, Gaussian observation laws and computation cross-checking; L02's protected agreed contract supplies exponential-family notation and first-order directed factorization. Neither artifact establishes MRF graphical CI, local Ising computation, formal Gibbs correctness or VI, so those cannot be smuggled in as review. The scope correctly teaches the first two and postpones the last two.

The critical dependency is sound: positive factor product and normalization → incident-factor cancellation → two-state local odds → Gaussian evidence field → a deterministic coordinate decision and its nonglobal limitation. Each mathematical prerequisite is supplied before it is used. Factor-graph representation is a justified new capability for L08; it does not require message-passing algorithms now. The square serves several distinct jobs without requiring several new models. Its repeated use is cumulative practice rather than repeated exposition.

The 100-minute substantive estimate plus 12-minute reserve is credible but tight. The declared 11–13 new retained families is a plausible algebraic estimate, not a complete estimate of conceptual novelty: graphical versus numerical independence, conditional versus marginal probability, and conditional maximization versus joint MAP all require substantial interpretation. The prototype extent estimate recomputes to approximately 25–31 from the stated feature ranges; its calibration to L01 gives no independent timing guarantee. L01's mathematical core establishes fewer model-type changes and spreads Gaussian reasoning over 29 content slides. Here the local algebra is shorter but the semantics are unfamiliar. I would not add mathematical proof depth, additional DAG queries, or a second substantial model family.

## Issues and smallest treatments

### R1 — CI interpretation and the local derivation share a tight allocation

**Owner/severity:** Lecture Scope, **advisory**; later boundary/time distribution belongs to Section Design. **Evidence:** The proposed 27 minutes includes global/local/pairwise Markov properties, positivity-qualified equivalence, two specified separator queries, cancellation, local odds/sigmoid, directed blanket recognition, and the arrow-deletion warning. Together with the 14-minute DAG recall, this is the main possible bottleneck. Positivity is needed for the converse equivalences, while graph compatibility supplies forward implications; conflating these with faithfulness would make apparently concise teaching incorrect.

**Provisional treatment:** Proceed at the specified State/Work depths, using only the promised square and collider. Treat directed blanket comparison as recognition, not another derivation. **Minimum repair:** No mandatory Scope change now. Preserve the 27-minute allocation as provisional and require a focused downstream timing check before adding any CI example or proof. If pressure appears, apply the explicit optional cut first; any reduction of required CI or conditional depth returns to Scope. **Downstream consequence:** Section Design may redistribute time within the live envelope; the conditional derivation must retain enough room for local normalization and marginal/conditional distinction. No need for a complete d-separation algorithm or moralization module.

### R2 — The lab is feasible only with the promised scaffolding

**Owner/severity:** Worked-solution/notebook authoring, **downstream-owned**. **Evidence:** The 60-minute budget already sums to 60 and includes exact enumeration, two local calculations, score interpretation, image restoration, one parameter comparison and an adverse initialization. L01's 80-cell solution demonstrates small student-owned array/algebra operations with substantial GIVEN setup/plotting. It does not establish student mastery of boundary-aware image loops or generic enumeration infrastructure.

**Provisional treatment:** Accept the lab interface because enumeration, image/noise construction, edge handling, sweep driver, stopping and plotting are explicitly supplied. **Minimum repair:** Preserve that division of responsibility in the later worked solution; student coding should remain the local field/conditional and numerical check. Default settings must yield quick, inspectable results, and later student-task timing must include interpretation and debugging. Supply additional helpers if needed before removing reasoning tasks. **Downstream consequence:** Implementation size, seed, image and parameter settings remain downstream choices. If 60 minutes proves insufficient even with supplied helpers, Scope owns any endpoint change. This review makes no execution or hosted Colab claim.

### R3 — ICM is a defensible practical choice but changes the reference method

**Owner/severity:** Lecture Scope/coordinator, **advisory** consequential practical-method choice. **Evidence:** B2 §4.3.8 defines the Ising/Gaussian model and distinguishes marginals from joint MAP; its displayed restoration is mean-field. The inspected one-cell reference implements Gibbs and mean field, not ICM. The scope explicitly labels its coordinate method as course-constructed and includes a verified local fixed point below the global MAP. A local conditional alone is neither a posterior sample nor a posterior marginal.

**Provisional treatment:** Retain deterministic sequential coordinate MAP as proposed. It preserves the image-restoration outcome while importing no L09/L10 correctness theory. **Minimum repair:** No mathematical repair needed. Carry the method choice into the coordinator's questions/hesitations and label the future student output as a coordinate-stable candidate, not exact MAP or marginal inference. **Downstream consequence:** L09/L10 remain primary owners of VI/MCMC and may reuse the conditional without repeating restoration. A request to adopt Gibbs or mean field now would require a new Scope allocation and prerequisite review, not a notebook-only substitution.

### R4 — Current syllabus preparation rows promise more than this scope teaches

**Owner/severity:** Coordinator/shared curriculum artifacts, **advisory reconciliation obligation**. **Evidence:** Both syllabi currently list §§4.3.7–4.3.9 as sampling/inference/learning and describe Ising/Potts interactions broadly. This scope offers selected §4.3.8 model/local optimization, no formal sampling, no MRF learning, and Potts only Mention. These are legitimate exclusions, but broad source ranges cannot become a substantive coverage claim. Actual ledger coverage correctly remains at L01; L02 is agreed, not delivered.

**Provisional treatment:** Review the narrow scope, not the broader syllabus wording. **Minimum repair:** In the authorized synchronization phase, narrow the preparation/coverage descriptions to the actual model/local-computation commitment; put formal VI/MCMC at their named later owners and distinguish Potts mention from substantive coverage. Preserve delivered L01 ledger entries. **Downstream consequence:** Agent approval must be reconciled with shared documents and the final cross-course audit. This report does not itself settle all later lecture allocations.

### R5 — Reference code must remain model provenance, not reusable verified computation

**Owner/severity:** Worked-solution authoring, **downstream-owned**. **Evidence:** Source creates `y = img2 + sigma * noise` with `sigma=2`, but both inference functions use `norm(..., scale=sqrt(sigma))`; Gibbs accumulates every sweep while dividing by `niter-nburin`. These issues are real even though the default burn-in value is zero. The mean-field expression also deserves independent derivation if ever reused: its `energy` helper returns twice the neighbor interaction and its likelihood log odds are negative-versus-positive. The proposed ICM lab does not depend on those implementations.

**Provisional treatment:** Use only the source model/application anchor, as the scope already requires. **Minimum repair:** Independently derive and validate the new deterministic worked solution; do not transplant the reference's noise/energy/update conventions or claim to reproduce its figure. **Downstream consequence:** The new implementation needs its own tiny-model oracle, local clean-kernel execution and hosted Colab validation later. No required dependency installs or external downloads are inherited.

### R6 — Agreed L02 knowledge is not evidence of delivered prerequisites

**Owner/severity:** Coordinator, **advisory dependency risk**. **Evidence:** L02's section design promises `A`, Bernoulli canonical form, categorical counts and Markov learning, ending before stationary distributions. Its development-state file contains duplicated malformed material and stale branch references. It cannot establish delivery or authorize new commitments. L03 correctly relies on the agreed section contract, not this register.

**Provisional treatment:** Retain L02 assumptions because they are protected agreed commitments; do not expand L03 to reteach maximum entropy or moment matching. **Minimum repair:** Reconcile the actual taught L02 boundary before delivery. If `A=log Z` is missing, prioritize local normalization and report any material backfill cost to Scope. **Downstream consequence:** No need for a stationary distribution, ELBO, sampling-convergence or optimization prerequisite. Delivery changes may invalidate pacing assumptions, without authorizing retrospective alteration of L02.

## Source and mathematical checks

- Read repository `AGENTS.md`, Section Design and shared backpressure instructions, timing calibration, full WORK_ORDER, and the Lecture Scope/Coordinator/Slide Organization stage boundaries.
- Inspected protected L01 `slide_deck.typ`, blob `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`, including three probability queries, Gaussian residual proof, LGS observation law and conditioning/summarization distinction. Inspected all 80 cells of `InClass/Solutions/lecture1_missing_data.ipynb`, blob `ab441941c8b526151a927bfbcf292bd9bc629ce5`, SHA-256 `f114516ca6a9c0823c14da0a734822a8901e4fdccf237481d47d0e3a61f80a8c`. Protected sources were not executed or changed.
- Inspected L02 `section_design.md`, blob `bbf78a13db05224a839d0b2f8bda4c7a5bd0c764`, its actual development-state content, material ledger, L03 syllabus entries and notebook audit. No delivered L03 artifact was supplied or found in the assigned inputs.
- Directly inspected `/tmp/pml-book2.txt`, December 10, 2025 edition: §§4.2.4.1–4.2.4.3 for collider/descendant and blanket semantics; §§4.3.1.1–4.3.1.2 for positivity, clique factors and energy; §4.3.2.1 for Ising pair/unary potentials; §4.3.2.2 for `J_P=2J_Ising`; §4.3.5.1 for precision structural zeros; §§4.3.6.1–4.3.8 for graph separation, positivity-qualified equivalence, arrow deletion and Gaussian denoising; §4.6.1.1 for exact variable–factor incidence. The scope correctly avoids turning source shorthand into universal dependence claims or requiring energy to be positive.
- Directly inspected `/tmp/pml-book1.txt`, April 18, 2025 edition, §§3.6.1–3.6.2: directed factorization, first-order sequence factorization, conditioning/marginalization and explaining away. Book 1 supports the recall rather than replacing Book 2's undirected spine.
- Inspected the complete local Pyprobml `ising_image_denoise_demo.ipynb`, SHA-256 `3d7a54f5c851c5de2efe196f9fa6cff8c82bdeb612c02137618fa8a0fdd4696e`. Its hash matches the scope's source pin. No runtime or stored-output reliability was inferred.
- Independently enumerated the specified course square using a small standard-library arithmetic check: interaction-sum counts `{-4:2, 0:12, 4:2}`, `Z(0)=16`, `Z(0.5)=27.048782764334526`. Tested the derived conditional against weights over all 16 states for three positive/zero/negative couplings and zero/nonzero unary fields; maximum discrepancy was `2.22e-16`.
- Independently checked the adverse example: all-negative fields are all `-0.8`, score `1.2`; exhaustive search identifies all-positive as exact MAP with score `2.8`. Algebraically, only incident terms change on a flip, giving `ΔS=-2z_iH_i`; sequential strictly improving flips with tie preservation terminate on a finite state space if run to stability. A capped run makes only an improvement claim.
- Collider arithmetic gives `p(C=1)=0.7`, `p(A=1|C=1)=9/14`, `p(A=B=1|C=1)=9/28`; these show dependence for the stated positive CPT. An optional descendant needs no invented CPT because only graphical activation is promised. Both diagonal separator claims follow from the exact square edge set; removing node 2 alone leaves path `1–3–4`.
- Rational matrix multiplication confirms the optional covariance is the inverse of its precision, with leading principal minors `2,3,4` positive. Exact matrices, square numbering, collider CPT and ICM failure example are explicitly course-constructed rather than attributed to Murphy figures.

## First cut, lingering risks and validation limits

**Most useful first cut:** omit the optional five-minute Gaussian precision worked comparison. It adds a second model family and is not needed for the binary endpoint or the lab. The scope already marks it optional; retain only an economical connection to L01. This takes the current estimate from 112 to about 107 minutes including reserve. Do not spend those five minutes expanding a proof or a new example. Further DAG compression is justified only after a prerequisite check; retain collider/descendant and guaranteed-versus-permitted dependence distinctions.

The required endpoint is a substantial advance beyond undergraduate DAG recall. It does not quietly promise Potts, CRF learning, MRF parameter learning or formal VI/MCMC. The course-constructed local/global example adequately protects against overclaiming ICM. Retrospective macrosegment endings and a separate notebook handoff satisfy the closure invariant; actual section boundaries remain downstream decisions.

Remaining uncertainty is concentrated in interaction time, real L02 delivery, new student exposure to spatial indexing, and default image behavior. Arithmetic checks are small mathematical verification, not notebook development or execution. No rehearsal, independent student lab trial, clean uv run, hosted Colab run, source figure rendering or full later-course scope comparison was performed. The coordinator's final course-wide audit must validate named deferred ownership against the actual L08–L10 scopes. A successful preview cannot preclude later execution backpressure.

**Approval/blockers:** no unresolved blocking Scope objection identified. This report grants no approval; agent approval/instructor-pending status belongs to the coordinator after cross-course reconciliation. Consequential method-choice hesitation belongs in the instructor report, without interrupting the instructor during this delegated batch.


## Independent diagnostic review of the organizing argument — 2026-10-12

**Reviewer:** `/root/scope_method_diagnosis`, Section Design specialist, `feasibility-review` diagnostic mode; distinct from the L03 author and coordinator. **Assignment:** investigate the instructor's objection that L03 does not follow the intellectual argument of the selected book passages or continue L01/L02's intellectual style. This is a bounded diagnosis, not Section Design construction or approval of a replacement scope.

**Exact inspected revision:** HEAD `2499e988706005b12c62f0d2bfb037f47b7c0c9e`; current L03 scope blob `cccc6f319d5d1046b14efb4078ba55a37e414268`; Lecture Scope skill blob `f5a5cbcda15bd915d9157e842636cd1964d368b9`. The report before this append had blob `10093ffbf8de6e581786dc966cb1591605c66a9c`. The analysis was completed against the skill before the coordinator's proposed process repair. This addendum does **not** claim to review or validate a subsequently patched skill.

### Finding: a valid application argument displaced the broader lecture argument

The current L03 scope makes noisy-image restoration the organizing purpose. Its main mathematical chain is product model → normalization → local conditional → noisy evidence → coordinate update. This is a coherent argument for the selected application, and the original independent review checked that chain carefully. It does not, by itself, establish that the lecture gives an adequate account of graphical models as a way to represent joint distributions and their conditional-independence structure. The distinction matters: students may successfully calculate a pixel update while receiving a compressed account of why the graph representation is mathematically useful beyond that update.

The Lecture Scope skill already required continuity in pacing, density, notation, mathematical depth and intellectual style, and recognizable forward progress through the books. Its core optimization principle explicitly rejected an independently optimized standalone lecture. The problem is therefore primarily **execution and review emphasis**, with a smaller process weakness: authors and reviewers were not required to demonstrate these commitments through a comparison of arguments. Adding the general requirement again would not resolve the failure.

### Evidence from the actual course and source

- **L02:** its agreed `section_design.md` states the trajectory exponential-family representation → Gaussian canonical derivation → log-partition moments → maximum-likelihood moment matching → maximum entropy → empirical Gamma fit → categorical and transition counts. Representation and general results do sustained intellectual work before specialization and application. Section 3 derives `∇A(η)=Eη[T(X)]`; Section 4 uses that result to derive the likelihood gradient and moment matching. This is evidence of the agreed intellectual style, not evidence that L02 has already been delivered.
- **L01:** the actual `slide_deck.typ` develops Gaussian geometry, marginals and conditionals before applying those results to linear Gaussian systems. Its conditional-mean explanation uses residual independence and affine Gaussian closure; the later system calculation applies the established conditioning rule. L01 also contains earlier application and taxonomy material, so the evidence does not support imposing a universal theorem-first template on every lecture.
- **Murphy Book 2, online edition December 10, 2025:** directly inspected `/tmp/pml-book2.txt`. Section 4.1 introduces graphical models through joint distributions and independence. Section 4.2.1, “Representing the joint distribution,” derives the directed product from the chain rule and an ordered conditional-independence assumption. Section 4.2.3, “Gaussian Bayes nets,” supplies a familiar mathematical example; §4.2.4, “Conditional independence properties,” develops graph semantics. Section 4.3.1, “Representing the joint distribution,” moves to clique potentials and a global partition function; §§4.3.4–4.3.6 treat maximum-entropy/exponential-family connections, Gaussian MRFs and conditional independence. The image application appears in §4.3.8, “Inference.” Exact book order is not mandatory, but its progression identifies foundational reasoning that should have an explicit disposition.
- **Original scope, blob `f4dab507f90618362c2e04c1c3791c8139f7de56`:** inspected directly from Git. It contained four pedagogically distinct alternatives and complete transition/purpose/source/content/summary fields for five explicitly provisional macrosegments. It did not claim finalized Section Design boundaries. Thus missing original §6a fields or a forbidden finished section outline are **not** supported diagnoses. The later readable version compressed those explanations into a timed list, reducing visibility of the reasoning and source map; that compression worsened inspectability but did not create the original application-led choice.
- **Alternative comparison:** the original scope presented Gaussian continuity as a competing Gaussian reconstruction laboratory, and stronger exponential-family continuity as an additional MRF-learning endpoint. It did not seriously compare a general graphical-model argument that still culminated in the same simple restoration lab. Mathematical continuity and the application were consequently treated as more mutually exclusive than the available evidence warrants.
- **Original independent review:** its assessment explicitly approved positive factors/normalization → cancellation → local odds → Gaussian evidence → deterministic coordinate decision. Its first-cut recommendation removed the optional Gaussian precision comparison. These are defensible choices for the selected application route; they did not independently establish that the route was the right continuation of the earlier course. The WORK_ORDER review checklist stressed mathematical novelty, prerequisites, source accuracy, coverage, notebook feasibility and overload, without explicitly requiring comparison of the book's argument and prior-course intellectual style. Source checking verified claims and provenance, rather than the adequacy of the selected reasoning route.

### Proposed small repair to authoring and review

Before choosing the endpoint and filling the arc, require three compact, inspectable statements:

1. **Previous-course argument:** what mathematical reasoning did the preceding lecture establish, beyond a list of available topics?
2. **Source argument:** what questions and results connect the selected source passages? Distinguish omitted illustrative models from omitted foundational steps.
3. **Proposed argument:** why is each successive result a valuable next intellectual move, and where does the proposal deliberately depart from the source or previous-course style?

When possible, compare at least one route that preserves the strongest source/continuity argument while retaining the same application. The notebook should practise and constrain the selected lecture argument; its executable endpoint should not automatically determine that argument. Preserve scope-level milestones and approximate envelopes without fixing section partitions.

An independent preview should additionally ask:

- Can the lecture's intellectual result be described without naming its notebook application?
- Which source foundations have been assumed, compressed, relocated or omitted, and are those choices justified by actual prior teaching and the intended endpoint?
- Does the proposed reasoning continue the previous lecture's mathematical style, or is a departure explicit and warranted?

These questions should be applied when other lectures are encountered. This diagnostic does not establish that all later scopes have the same defect and does not justify silently rewriting them.

### L03 decision ownership and possible repair

**Owner:** Lecture Scope, with the coordinator presenting the alternatives to the instructor. **Disposition:** the organizing arc is reopened by the instructor's current objection. The accepted accessible restoration method remains accepted; the original decision selected ICM and its weaker guarantee, rather than approving every aspect of the lecture argument. No replacement arc is approved by this review.

A candidate worth comparing is: constructing joint distributions from local structure → directed versus undirected factorization and independence → connections to familiar exponential-family/Gaussian mathematics → the Ising local conditional → noisy-image restoration and ICM's limitation. This is a reasoning route for discussion, not a section partition or a new required list of derivations. Its treatment depths and extent must be settled at Scope level before a focused feasibility check. A different balance may be justified; merely restoring all intervening textbook sections would not solve the problem.

**Review limits:** diagnostic confidence is high concerning the documented optimization/review emphasis, and moderate concerning the best replacement route. No replacement scope, teaching rehearsal, notebook implementation, execution or timing trial was produced. No new section contract was constructed. Actual L01/L02 artifacts remain protected. The review does not retract the original arithmetic/source checks; it exposes a separate weakness those checks did not test. No source or skill files were edited by this reviewer, and no instructor approval, publication or commit was performed.


### Independent targeted check of the process repair — 2026-10-12

**Reviewer:** `/root/scope_method_diagnosis`, read-only review of the three skill changes against HEAD `2499e988706005b12c62f0d2bfb037f47b7c0c9e`. Inspected Lecture Scope skill blob `870950cc3634b11db12acce5927253e835a0613a`, Section Design skill blob `ca25795e38f5f16113f2768f3ee2fc2c614526d8`, and Lecture Development Coordinator skill blob `b65a092e8623e54e13b92fae3d923b04ba449b5a`.

**Finding: no material concerns found in the targeted patch.** It addresses the diagnosed weakness by requiring comparison of the previous-course, source and proposed arguments; separating the lecture's mathematical endpoint from its notebook product; and requiring an independent check of whether the selected organizing purpose is justified. It explicitly permits deliberate departures from source order and legitimate application-led lectures. It imposes neither literal book order nor a universal theory-first pattern, adds no mandatory instructor checkpoints, and preserves the boundary between provisional scope milestones and actual Section Design. The coordinator change appropriately preserves partial approval and the instructor's chosen review pace.

**Limit:** this checks the instructions, not their success in use. It is not a forward test on a newly authored or revised scope, not a review of an approved replacement L03 arc, and not instructor approval. No source or skill files were changed by this reviewer; only this evidence addendum was appended.


## Independent authority correction and restoration review — 2026-10-12

**Reviewer:** `/root/scope_method_diagnosis`, Section Design specialist, `feasibility-review` / reconciliation diagnostic. **Verdict:** `feasible-with-risks` for the targeted restoration and shared-record reconciliation; no unresolved reconciliation blocker found. This review supplies new evidence for the restored accepted artifact. The earlier reviews of the batch-generated scope are not transferred as approval of this materially different scope.

### Correction to the earlier diagnosis

The instructor subsequently identified `lecture-3-authoring` as the location of an already agreed L03 scope. Direct inspection of `origin/lecture-3-authoring`, commit `8007d42b2871181a6966ab4d55417c10af9b5544`, establishes the missing authoritative input: scope blob `0656648fd43374997469174a845418a802b3aefe` and development register blob `caef6a625c8525e90ecdfe83912a43f3a462fa8a`. The register distinguishes **instructor-agreed Scope** from a **proposed seven-section design not approved as a whole**. It also documents partially agreed section directions and unresolved example checks, which must not be promoted into complete downstream approval.

My earlier diagnosis correctly identified weaknesses in the argument of batch scope `cccc6f319d5d1046b14efb4078ba55a37e414268`, but it was based on incomplete authoritative inputs. Its recommendation to reopen L03's organizing route is superseded: the route had already been agreed. There is no need for a new A/B route selection. The additional central failure was **agreement discovery across branches**: the batch run generated a replacement for an accepted scope. Its application-led optimization and review blind spot explain the replacement's shape, but do not justify replacing the instructor's existing agreement. The same authority correction applies to this reviewer's earlier candidate replacement route.

### Exact restoration and process targets

| Artifact | Inspected Git blob |
|---|---|
| Restored `Lectures/L03_Graphical_Models/lecture_scope.md` | `ac2235187caa75937761ca12fe57806760143b37` |
| Lecture Scope skill | `588e7b576175f2af638803d527d8c6b8edecb936` |
| Section Design skill | `ca25795e38f5f16113f2768f3ee2fc2c614526d8` |
| Lecture Development Coordinator skill | `7ad67412ae6810fb2beb46a5c029bc7d82602008` |
| `syllabus_plan.typ` | `ea06b6fe6253ffe9c0e66e54ba9ef241adad3e64` |
| `advanced_statistics_2027_1_syllabus.typ` | `3ed0a16f6d0e5a25d3ed6f5f05fccf22ecb7847d` |
| `Lectures/material_ledger.md` | `1c46686c21293c9ce19c39112330ee0321b30dc9` |
| `Lectures/notebook_reference_audit.md` | `a6daa64308f62ebe3433628557afa1b2a2bfa7e9` |
| `questions_and_hesitations.md` | `2b293c6a1620bc5da68479a43adc3e125a36e86e` |
| `architecture_audit.md` | `ebae9184cc708966a343cecfdcbc77e1438b5129` |
| `Lectures/syllabus_planning_decisions.md` | `4d6329db2adda0a3b0604c85ea7ca6c1f3c281f7` |

The lecture-local development register was inspected at blob `2489ca60dc6d6c68dd621b336b21e8b7ece0df71`; its review-pending metadata is expected to be updated by the coordinator after this evidence is returned. That update is not silently included in this snapshot. The report before this append had blob `2f186bcafdf60b4780087d42150c0bab17716338`.

### Checks and findings

**Accepted content is restored.** A direct string comparison against the source scope confirms that the entire pedagogical body matches after precisely two future-opportunity label substitutions: L07 becomes L08 for structured inference, and L08/L09 becomes L09/L10 for variational inference/sampling. The only added material is the explicitly labeled branch-reconciliation provenance appendix. These are optional future opportunities, not newly assigned coverage. No section partition or topic-specific timed milestones have been inserted. A Git diff check confirms that the nine other lecture scope files remain unchanged from HEAD `2499e988706005b12c62f0d2bfb037f47b7c0c9e`.

**The live/notebook boundary is materially different and now consistent.** The accepted live argument starts from L02's chain, distinguishes the probability chain rule from a parent-factorization independence assumption, works the student network and parameter economy, develops directed independence and d-separation, then introduces undirected potentials, normalization and separation. It compares the graphical independence languages and ends with interpretation of binary Ising interactions. Plate notation is brief. Gaussian observation/noise modeling, image prior–likelihood–posterior construction, the single-site conditional and ICM are new student mathematics and computation in the notebook; they are expressly not solved live. Both syllabi, the proposed ledger allocation, notebook audit, architecture explanation, questions and decisions consistently retain that boundary. They no longer present general d-separation as already mastered undergraduate recall or promise a primary L03 factor-graph treatment.

**The downstream dependency is not broken merely by removing factor graphs.** Current L08, inspected at blob `1c92cf00a125c33b1142cbd0696a1221a766ea36`, requires ordinary graphical factorization from L03. Its text does not require prior mastery of bipartite factor-graph notation. The restored scope supplies the actual prerequisite, while the shared architecture now removes the false L03 factor-graph ownership claim. Later local-update references may rely on the L03 notebook, but must not relabel that computation as live lecture coverage.

**The narrow process repair addresses both failures.** The Lecture Scope and Coordinator skills now require discovery of agreements on relevant local or remote-tracking branches, exact source provenance and reconciliation/revision instead of replacement when accepted work exists. They also retain the argument-comparison checks reviewed above. The Scope skill explicitly says newer generic fields do not retroactively invalidate an accepted scope or authorize adding boundaries/timed milestones. The changes do not impose literal book order, a universal theory-first pattern, excessive instructor checkpoints or actual Section Design within Scope. Their narrowness is appropriate. Reading the instructions is not evidence that future agents will reliably follow them.

### Residual risks and least repair

- **Notebook authoring, advisory:** constructing the image model, deriving the conditional and implementing ICM in one hour is demanding. Preserve the accepted mathematical contribution while supplying data preparation, plots, small interfaces and checks. Validate a worked solution and a student timing trial before deciding the task fits; no automatic transfer of the derivation into live teaching is authorized.
- **Section Design, exact-example blocker:** the source register records an unverified/mistaken Fig.4.23(a) multipath claim involving a purported direct `X4 → X7 ← X5` connection. Source verification belongs to the proposed Section Design. It blocks approval of that specific example, not restoration of the agreed Scope. This reconciliation reviewer has not reverified the full graph or approved the seven sections.
- **Section Design, advisory:** richer directed-independence work and graphical comparisons require a realistic extent check during construction. The accepted approximately 100 substantive minutes plus 20 minutes reserve is a provisional envelope, not rehearsal evidence.
- **Notebook source inspection, advisory:** the recovered secondary ICM reference remains a candidate. Its detailed source correctness and runtime are not established by this scope restoration. The previously inspected Murphy/Pyprobml example remains a related model/application source, not a validated drop-in ICM solution.

The least repair is the restoration already performed plus precise shared-record reconciliation and honest approval metadata. No fresh route decision, scope redesign, nine-lecture rewrite or new downstream artifact is required by this finding. Continue the instructor's chosen scope-by-scope review pace. Complete Section Design approval and notebook validation remain separate future work.

**Limits:** this is an independent comparison of accepted authority, current files and process instructions. It is not a fresh full source check of every selected Murphy figure, a construction of sections, an approval of downstream examples, a behavioral trial of future agents, a notebook execution, a hosted Colab check or a teaching rehearsal. The earlier raw review and diagnostic text remain preserved as evidence about their exact earlier inputs; this addendum explicitly corrects the authority gap rather than silently rewriting that evidence. No source, skill or approval-register edits were made by this reviewer; only this evidence was appended.


**Final formatting-only scope snapshot:** after the reconciliation checks above, three original metadata Markdown hard breaks written as trailing double spaces were converted to explicit backslashes. The final restored scope blob is `2d5992a3f05d952dc21553690039fe021fd6284a`. An independent repeat of the source comparison, normalizing those hard-break spellings and applying the two future-opportunity label substitutions, confirms equality of the pedagogical body with the accepted source. This formatting change does not alter the verdict or teaching commitments. Compiler results belong to the coordinator's mechanical validation; this reviewer does not claim to have performed them.
