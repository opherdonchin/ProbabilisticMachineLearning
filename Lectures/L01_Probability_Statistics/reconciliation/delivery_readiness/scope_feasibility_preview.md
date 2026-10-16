# L01 full-Scope feasibility preview

**Verdict: feasible with advisory risks.** No material Scope-level mathematical, prerequisite or organizing-purpose blocker was found. A plausible coherent route reaches the proposed live and guided-notebook endpoints within the accepted decisions. Confidence is high in the mathematical dependency chain and lower in the two-hour live / one-hour notebook fit. This preview is neither instructor approval nor downstream execution validation.

**Target and provenance.** Section Design, `feasibility-review` only; delivery branch `lecture/l01-delivery-readiness`, HEAD `44f9a4ddefae945cfd2e4ecc44120796940c0d5c`, with coordinator-assembled uncommitted Scope. Reviewed Scope SHA-256 `0e589e96d2053e5958a633bf670e6044de85fd970887809b9f617a37048ee0e2`, after the coordinator's nonsemantic Part 1 heading normalization. A separately delegated reviewer performed this preview; the reviewer did not build the Scope, worked solution or Q&A. The review was bounded and informed by the coordinator's accepted-decision brief and prior reports, so it is not a blind quality review. No agents were spawned. Only `/tmp/l01-scope-preview/` was written; no repository file, approval, branch or teaching record was changed.

## Why the argument is constructible and justified

The reusable understanding is identifiable apart from the notebook: a learning problem specifies observed and unknown variables, a probabilistic query and a criterion; one joint law can answer several questions, while Gaussian structure makes the relevant full-law calculations exact. The coin example reactivates an already familiar Bayesian model; Iris supplies a recognizable task and zero-one criterion; covariance geometry then retains the dependence needed for measurement reconstruction. The residual argument establishes the conditional law; LGS construction supplies a useful representation of the same joint, with inverse and forward questions. Squared loss selects an action from that conditional law. The proposed notebook applies that reasoning in a concrete computation rather than becoming the lecture's purpose.

This is consistent with the architecture's practical objective at the explicitly limited level of guided first use. The controlled seven-dimensional example teaches reconstruction, uncertainty, query choice and model-risk interpretation. It does not establish parameter fitting, empirical model adequacy, real missingness handling or large-scale performance; the Scope and notebook say so. The absence of a fitted real dataset or repeated-case baseline is therefore not a concealed practical-competence claim. No architecture amendment or route reopening is warranted by this preview.

The alternative source-led route is not missing a necessary foundation: Book 2 introduces MVN blocks/conditionals and derives them through block inversion; the proposed live course route supplies an independent affine-residual proof instead, then retains the quadratic identity at state/interpret depth and develops its full proof separately. Book 1's two-dimensional conditioning and known-parameter imputation passages support the chosen application. An application-first rearrangement might expose the destination earlier, but it supplies no mathematical prerequisite or deep course-purpose repair absent here. The accepted bivariate task-to-query checkpoint is a proportionate way to test the formulation-to-computation hinge while preserving the instructor's selected route.

## Prerequisites, mathematics and source checks

No earlier lecture in this semester has been taught. The actual map is empty, and the entry reference supplies probability/Bayesian reasoning, expectation, elementary covariance, matrix algebra and basic NumPy; multivariate covariance and nontrivial shapes still need scaffolding. The Scope supplies those live, and the solved notebook supplies local numerical/API support. Prior package experience does not create a sampler prerequisite after its accepted removal.

The load-bearing dependence is sound: affine Gaussian closure and block moments make `(r,X2)` jointly Gaussian; with `B = Sigma12 Sigma22^{-1}` and `r = X1-mu1-B(X2-mu2)`, zero cross-covariance yields independence **because the pair is jointly Gaussian**. That supplies the full shifted conditional law, not merely a linear predictor. The live source explicitly carries this warrant and then derives the residual covariance. Positive-definite joint covariance makes ordinary densities, diagonal-block inverses and Schur complements legitimate. No degenerate-Gaussian theory is needed for the selected endpoint.

For squared loss, conditional on `y`, `a` and `m=E[Z|y]` are fixed. Averaging the centered expansion gives `E[||Z-a||^2|y] = tr Cov(Z|y) + ||m-a||^2`; the second term is nonnegative and vanishes exactly at `a=m`. This establishes the unique mean action and attained minimum risk for finite conditional second moments without assuming Gaussianity. The selected three-move realization preserves the complete proof and its assumptions; its acceptance remains outstanding, and this preview does not substitute for visual/design review.

The recording's proposed proof is also constructible from the stated entry. With `H=Sigma22`, `S=Sigma11-BHB^T` and `T=[[I,-B],[0,I]]`, congruence gives `T Sigma T^T=diag(S,H)`. Positive definiteness, the inverse identity, separated quadratic and `det Sigma=det S det H` then establish the **normalized** factorization. This avoids making an unexplained block-inverse lemma a hidden prerequisite. The live residual proof and notebook stand without viewing that proof. Its required/examinable status, with no monitored viewing, is preserved.

I inspected the local editions directly:

- Book 2, December 10, 2025: §2.3.1.3, printed p24, Eqs. 2.75–2.79 for block marginals/conditionals; §2.3.1.5, pp25–27, Eqs. 2.88–2.103 for the block/quadratic route; §§2.3.2.1–2.3.2.3, pp28–30, especially Eqs. 2.120–2.129 and Fig. 2.10 for joint/update/forward reuse and sensor fusion. The source's matrix-inverse discussion assumes diagonal-block invertibility, which alone does not guarantee Schur invertibility; the Scope's SPD condition supplies what is needed. The course's explicit determinant/normalizer completion is correctly identified as an elaboration.
- Book 1, April 18, 2025: §3.2.4, printed p85, Eqs. 3.29–3.32 uses observed value 1, while the course uses 1.5 and correctly obtains mean 1.2 and variance 0.36; §3.2.5, pp85–86 uses ten eight-dimensional cases with half their entries hidden, distinct from the course's seven-dimensional case; §5.1.5.1, p176, Eqs. 5.32–5.34 establishes scalar squared-loss mean optimality, with the vector decomposition honestly course-owned.

The sensor midpoint qualification is necessary: equal sensor noise gives a midpoint in the weak-prior limit; finite prior precision generally changes it. The Scope and current live source already include this correction. No additional numerical sensor claim is required by the proposal.

The actual solved notebook was read, not inferred solely from reports: 69 cells, 18 question/answer pairs. It supplies covariance setup/plots, applies conditional moments via solves, interprets individual intervals, computes mean action/minimum model risk, translates to an LGS, computes fresh-case forward moments and draws one fresh state/noise pair. The new solve/transpose, shape, diagonal/trace, interval and generation operations receive local support. The repeated conditional calculation and spectral/population checks are visibly supplied verification. Expected loss, one realized error, joint versus marginal coverage, forward generation and old-case inference remain distinct. No new inference algorithm is needed at handoff.

## Material advisory risks and ownership

### 1. Live extent is tight and unmeasured

**Owner/severity:** Lecture Scope/coordinator; advisory. Section Design can allocate the existing obligations, but cannot silently reduce their depth or relocate them.

**Evidence:** the proposed milestones consume 110 minutes plus roughly ten for discussion/slippage. In particular, the proposed 20-minute LGS/output allowance contains joint-block construction, posterior/gain use, scalar regimes, sensor interpretation, the complete vector loss proof, and the forward law. The checkpoint's 2–3 minutes and proof's 2–4 minutes are unmeasured. Moving the *additional* quadratic proof to recording does not release time from an existing live derivation that was never there. The instructor's assessment that the existing lecture length is appropriate supports plausibility, but the calibration has stale page/section counts and no measured timings. Source, slide and reveal counts cannot establish fit.

**Provisional treatment / minimum repair:** proceed with the Scope as a tight proposal; keep every accepted live obligation in budget. Rehearse the actual accepted source, including all intended interaction, retrospective closures and separate notebook handoff, before declaring two-hour readiness. Record actual time and where the endpoint was reached. No immediate content reduction is demanded by this preview.

**Impact and decision:** if rehearsal overruns, return the smallest consequential compression/relocation proposal to Scope/instructor. Do not solve it downstream by omitting proof warrants or silently moving the accepted loss proof to recording. Acceptance of the selected three-slide realization does not itself validate time.

### 2. One-hour notebook workload remains uncertain

**Owner/severity:** coordinator/Scope, supported by notebook authoring; advisory.

**Evidence:** the author's 55–75-minute estimate includes nine code and nine mathematical/prose answers plus supplied-cell reading. Applying solves, a right-side-inverse transpose, LGS remapping, intervals and three-law interpretation compounds novelty even with good local scaffolding. Clean execution and removed sampler work do not measure learner effort. This is consistent with the prior notebook feasibility report; no new factual repair was found.

**Provisional treatment / minimum repair:** keep the explicit unvalidated one-hour label and perform a representative timed learner trial of the actual self-work pair, including setup reading, AI-assisted work as intended and output interpretation. Record completion/points of delay; kernel runtime is separate evidence. No immediate cut is required.

**Impact and decision:** a substantive overrun requires an instructor-owned workload choice. Supply more routine inspection/implementation only through the owning notebook/Scope process; retain the accepted query uses, loss result and same-joint LGS translation unless explicitly revised. The recording's separate 20–30-minute estimate is also unmeasured student workload; do not describe it as live-time reserve or optional content.

## What remains downstream or instructor-owned

Section Design can settle boundaries, prerequisite reinforcement, local time allocation and retrospective closure within the accepted route. Ensure connections begin in the receiving section, every section ends retrospectively, and the notebook handoff remains lecture-level. These are downstream obligations, not reasons to demand a partition before Scope approval. No section titles, contracts, slide sequence or notebook changes are proposed here.

The instructor owns complete Scope acceptance, selected-loss realization acceptance, the recording's detailed pedagogical contract/workload, and any consequential change after timing evidence. Formula correctness, authentic source attribution, rehearsal/learner evidence collection, matched output regeneration, mechanical notebook derivation and hosted Colab execution belong to authors/reviewers/coordinator. Hosted readiness is still outstanding; this preview did not rerun notebooks, render slides, rehearse teaching or observe learners. These distinctions do not block Section Design construction but do prevent a delivery-ready or approved claim.

## Exact reviewed-source hashes

The following records the read inputs, not a claim that every source received a full independent quality audit. Local PDF extraction warnings were nonfatal; the cited passages were readable. Full local text extracts and notebook cell text are retained only in this scratch directory. The separate worked source's existing validation was reviewed through its owning integration report; this preview did not independently execute it.

```text
0e589e96d2053e5958a633bf670e6044de85fd970887809b9f617a37048ee0e2  Lectures/L01_Probability_Statistics/lecture_scope.md
cac83d7b547ce7129edd6d3d5c23a7d231dbb6a8eae48be99f77bc46fcd2b63f  Lectures/L01_Probability_Statistics/development_state.md
66ec0914f65f008b8ecacb20c2faad61e9b630dfd1f8b1dc5a9e8f196d073e7f  Lectures/L01_Probability_Statistics/slide_deck.typ
b0e021e47be497e0275749bf08bbb7af6f575c112828e0928573ae8d701c05aa  course_architecture.typ
af566520ad382eadfa46f60f460f6cac534460dd9825549302126a710ecb6204  curriculum_map.typ
73eb85d3b02ef6b37b3f0f34b29d1ccc37764b2fd921f041841d398434621ff1  curriculum_map_actual.typ
df2d19bf3d136c69c2c16890bb25aa20da121538bec8c7b3567bafb18372f58e  .agents/skills/lecture-scope/references/timing-calibration.md
90bef6aacfc3519f4f70e868d23f46234a8ebf7bd51cc3e32ee57ecdcbb2b7ff  .agents/skills/teaching-notebook-authoring/references/student-knowledge.md
1c6a0f8afff996219e0e5a33eed7e2d395ab526422f3e5f904ffed88490f3de7  InClass/Preparation/lecture1_missing_data_authoring_report.md
42dec1fa6d59af3f76e9102d3c07832b944bd3c225ed5947df2766b0e03ee9b7  InClass/Solutions/lecture1_missing_data.ipynb
e04c8a9f45b2d79f1f187020c8fa6c5732b7b583fab6777ef66d062e36180169  Lectures/L01_Probability_Statistics/reconciliation/delivery_readiness/runtime/exact_only/notebook_feasibility_review.md
1edc67cc45ee37794aec347f4e512ecc7d2b8a80df69212fa74b9a6b5d060066  Lectures/L01_Probability_Statistics/reconciliation/delivery_readiness/runtime/exact_only/report.md
957a79bcf88e655a42bcc1341003147280d155a7582bf916b3a55206cc8bf045  Lectures/L01_Probability_Statistics/reconciliation/selected_loss_sequence/result.md
2092fbbffe02c3bf1dc8484923730005c0d7998df43d11b566335fd13db95910  Lectures/L01_Probability_Statistics/reconciliation/selected_loss_sequence/organization.md
89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf  Resources/book1.pdf
54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf  Resources/book2-1.pdf
418514e095826507cf29d19efd1f83e6a7f3aacbf657d2b19be317c24d9527cc  AGENTS.md
f64a94ae48886994413a65aa43341effad73e971787afdc5fb5241e977fb5f35  .agents/skills/section-design/SKILL.md
5fe6ba181dfd5f67b459c16c13215d01f1f4bade7e2f9da52f5161ae72d6122d  .agents/skills/shared/backpressure.md
```
