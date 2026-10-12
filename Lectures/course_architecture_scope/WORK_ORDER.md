# Autonomous L03–L12 scope and curriculum-architecture work order

**Authority:** Instructor instruction dated 2026-10-11. The course architecture was merged into main in PR #8 (merge commit b78a7650bb09ae851e412089d98525f7b71275d9). This document delegates bounded autonomy to a coordinating agent and independent specialists to deliver complete, agent-reviewed, **agent-approved** L03–L12 lecture scopes before instructor oversight. The architecture-scoping branch is scope-l03-l12-course-architecture.

**Status:** This is an execution contract, not proof that any agent or review has run. Never label a scope accepted or approved until the evidence and gates below exist. **Agent approval is not an instructor decision.**

## Purpose and non-negotiable deliverables

Produce one coherent graduate course architecture whose per-lecture scopes are intellectually substantial but **actually feasible** within ~100–120 minutes of live lecture plus a separate 60-minute computational notebook per meeting. The coordinator—not individual authors—owns global coherence, dependencies, coverage gaps, repetition, software continuity and consistent ledger/syllabus promises.

The completed branch must contain:

1. Ten individually **agent-approved**, five-part lecture scopes (L03–L12): Intellectual Arc, Mathematical Spine with explicit treatment depths, Notebook Handoff, Concrete Examples, Lecture Contract. Each lists included, deferred and omitted material, realistic extent, source support and prerequisite assumptions. Paths are Lectures/L03_Graphical_Models/lecture_scope.md, Lectures/L04_Information_Theory/lecture_scope.md, Lectures/L05_GLM_Optimization/lecture_scope.md, Lectures/L06_EM/lecture_scope.md, Lectures/L07_Inference/lecture_scope.md, Lectures/L08_Structured_Inference/lecture_scope.md, Lectures/L09_Variational_Inference/lecture_scope.md, Lectures/L10_MCMC/lecture_scope.md, Lectures/L11_Neural_Prediction/lecture_scope.md, Lectures/L12_VAE/lecture_scope.md.
2. **Committed independent review evidence per lecture:** Lectures/course_architecture_scope/reviews/L03_review.md … L12_review.md. Each names reviewer role/thread where supported, exact scope revision reviewed, verdict, objections, smallest repairs, residual risks and validation limits. A separate local summary does not count as an independent review.
3. One **cross-course architecture audit** with per-topic primary ownership, notebook skill sequence, source-to-lecture coverage matrix, prerequisite graph (including backward references and cross-lecture dependencies), omitted/deferred material and estimated overload. Store as Lectures/course_architecture_scope/architecture_audit.md, with an independently authored adversarial second-pass review in reviews/course_architecture_review.md.
4. **A consolidated questions-and-hesitations report for the instructor**, Lectures/course_architecture_scope/questions_and_hesitations.md. Organize loosely by the earliest affected lecture, but group genuine multi-lecture questions (e.g. L07–L09, L09–L12) without repeating them. Include the question, why it matters, alternatives, evidence, coordinator's provisional treatment, cost/impact and priority. Do not interrupt the instructor during the run.
5. Updated **course_architecture.typ**, **advanced_statistics_2027_1_syllabus.typ**, **Lectures/material_ledger.md**, **Lectures/notebook_reference_audit.md** and **Lectures/syllabus_planning_decisions.md**. The branch must be coherent as a single proposal. Delivered coverage and approved past lecture artifacts remain historically accurate.
6. Lectures/course_architecture_scope/STATUS.md recording branch/revision, per-lecture builder/reviewer evidence, approval state and unresolved blockers; all final report paths and final Git commit. Syllabus/ledger edits and scope approvals must refer to the same substantive revisions.

No slides, figures, full student notebooks or notebook runtime claims are required in this phase. Do not infer that a reference notebook is tested merely because a URL is available. Do not merge this branch to main or publish a new formal syllabus without a later human instruction.

## Fixed inputs, protected decisions and freedoms

**Protected:** actual delivered L01 material and ledger; L02 agreed scope (do not revise implicitly); 13 meetings (L13 projects, not a new lecture); ~2 hours mathematical presentation + 1 hour student notebook per teaching meeting; prerequisite background of rigorous probability plus undergraduate Bayesian modeling, including PyMC/Bambi/ArviZ; Book 2 as curricular spine and selective Book 1 backfill; information theory as both computational discipline and ML toolkit; substantive GLM-family modeling joined to autodiff/SGD in L05; sequence L04 information → L05 GLMs/optimization → L06 EM; PyTorch introduced with the early categorical Iris task, no new required JAX stack; assessment of mathematical novelty rather than slide count alone; source and terminology correctness.

**Broad delegated discretion:** agents may change mathematical depths, omit non-load-bearing subtopics, choose between valid exemplars and notebook proposals, distribute advanced optimization/GLM content, assign recording candidates (not move material to a recording without documenting the curriculum consequence), and revise L03–L12 scope commitments and local notebook handoffs. They may update syllabus and proposed future-allocation ledger, and approve the resulting agent-level scopes, provided each is independently reviewed and cross-course reconciliation passes.

**Architecture deviations requiring a visible human question:** changing the core identity/order of L04 information, L05 GLMs/optimization or L06 EM; cancelling a whole lecture; disturbing L01/L02's established teaching; substituting a different major book spine; eliminating a major instructor-endorsed practical outcome; introducing new required software ecosystems; moving extensive live mathematics into unapproved recordings. The coordinator must choose a reasonable reversible provisional treatment rather than block routine work. If there is no defensible treatment, mark a scope blocked and raise a high-priority question rather than falsely approving it.

**Two levels of approval:** The instructor has accepted the **course architecture** by merging PR #8. The coordinator can mark a new lecture scope **agent-approved / instructor-pending** only after a complete five-part scope exists, an independent feasibility review has passed without unresolved blocking concerns, and cross-course reconciliation confirms consistency. The user reviews the resulting architecture later; do not use the label "instructor-approved" for the newly authored scopes.

## Required source workflow

Read AGENTS.md, the lecture-development, lecture-scope and section-design skills, the shared backpressure protocol, and lecture-scope timing-calibration reference; use the task-specific delegated authority here only for the instructor checkpoint and conditional agent-approval decisions. Do not weaken the canonical skills or rewrite them solely for this batch.

Inspect actual L01 lecture source and notebook; existing L02 scope, section-design and development-state files; current book sections (Murphy Book 2 and relevant Book 1); lecture ledger, syllabus and notebook audit; source references for the proposed notebooks. If a text/solution is unavailable, use official public sources when permitted, or mark unverified. Do not invent precise chapter subsection coverage, quoted theorems, figures, worked notebook reliability or measured teaching pace.

Honor source provenance:
- Book 2 vs Book 1 roles;
- established mathematical results vs course-specific synthesis;
- mentioned vs substantively taught vs practised in a notebook;
- source examples vs unverified/adapted references;
- delivered vs proposed coverage.

## Autonomous phases and gates

### 0. Reconcile reality before drafting

Confirm branch, working tree, main merge/base HEAD. Compare source artifacts with user-approved architecture. Map actual L01 and current L02 boundaries; inspect whether L03 or later has since been delivered or agreed. If new delivery changes assumptions, protect it and update the proposed downstream scopes. Populate STATUS with the precise revisions.

### 1. Build a global coverage contract

The coordinator writes a **provisional source-ownership matrix** before delegating: every central Chapter 4–12 and 15–16/21 concept must have one planned primary teaching destination or a named, reasoned exclusion/deferment. Identify bridges: L02 exponential families → L05 GLMs; L03 graphs → L06 EM / L08 message passing; L04 MI/coding → L12 rate-distortion; L05 gradient/autodiff → L09 VI and L11/12; L06 EM → L07 inference overview; L09 VI and L11 NN → L12 VAE. Account for Ch. 13 SMC and §§6.6–6.9 as deliberate choices, not invisible obligations.

Use a **shared scope budget** and do not let every author independently assign broad prerequisite material to their lecture. The coordinator owns reassignment.

### 2. Produce ten provisional five-part scopes

A lecture_scope subagent uses BUILD mode to author the five parts for its assigned lecture. Since human checkpoints are delegated for this batch, the agent should make evidence-grounded provisional decisions and log genuinely consequential hesitations to the questions file rather than asking the instructor. The instructor has explicitly authorized this batch-mode deviation from the ordinary interactive process.

Use sequential **curriculum waves**, not ten independent final scopes in parallel:
- Wave A: L03–L05 (establish graphs, information and learned conditional models).
- Wave B: L06–L08 (EM, general inference, structured inference).
- Wave C: L09–L12 (VI, MCMC, neural prediction, VAE).
After each wave, the coordinator revisits earlier commitments where later dependencies reveal an overload or gap. Two or three parallel lecture builders may prepare drafts against the *same versioned cross-course contract*, but no parallel agents edit the shared syllabus, ledger, status or questions file.

For each scope, protect coherent intellectual arc, a realistic live-time envelope, one reusable computational notebook skill, and **deliberate omissions**. Do not maximize chapter coverage. Explicitly select Derive/Prove/Work/State/Mention depths for each load-bearing mathematical item, and denote Recording candidate / Live without silently excluding unapproved recordings from the live budget.

### 3. Independently review each full scope

Once the builder stops editing the scope, dispatch a **different, actual subagent** using **section_design in feasibility-review mode**, whose job is to challenge whether the five-part scope can be expressed as a sensible sequence without designing sections. In parallel or in a later independent pass, a lecture_scope feasibility reviewer may challenge book fidelity and lecture-wide ambition. Preserve the raw report with target scope commit/hash and reviewer identity; never write "independent" unless a distinct thread ran.

Reviewers must challenge:
- Novel mathematical derivations and number of distinct concepts versus lecture time;
- prior knowledge and prerequisite ordering;
- notebook link, lab extent, and whether the lab genuinely practices lecture mathematics;
- source accuracy, inclusion/exclusion, correct attribution;
- redundancy and source primary ownership;
- likely cognitive/coding overload given L01 pacing prior;
- how much material is merely named instead of truly taught.

Return verdict **feasible**, **feasible-with-risks**, or **blocked**, with owner/severity, evidence, minimum repair, downstream consequences and lingering uncertainties. "Feasible with risks" may be internally approved only if no blocking issue remains and the residual risk is explicit and bounded.

### 4. Repair, reconcile, approve agent scopes

Coordinator sends scope-owned objections back to the owning builder for smallest necessary repair; preserve unrelated decisions. After substantive repairs, arrange a targeted independent re-review. At most one routine full pass and one targeted check per scope; if repeated disagreement persists, coordinator must make a defensible provisional choice or flag a high-priority instructor question.

Maintain a single source-to-lecture ownership matrix. When L08 needs material claimed in L09, or L11 needs §15.2 material already too dense for L05, revise the *nearest owning scopes* together and revalidate. Do not solve local overload by silent duplication or pushing load onto a neighbor. Cross-course content is an allocation budget: promote a topic to full derivation in one place and refer to it concisely elsewhere.

The coordinator signs off each scope in STATUS with **agent-approved / instructor-pending**, author/reviewer identity, exact reviewed/approved revision, coverage/deferment, residual risk, and handoff obligations. Never claim stronger approval than evidence supports.

### 5. Global adversarial architecture review

After initial approvals, appoint a **separate reviewer** to inspect all ten scopes and course-level coverage as a whole, without pre-reading the coordinator's proposed justifications. This reviewer must look for gaps hidden by table rows, incompatible definitions, insufficient time for novel derivations, implicit notebook prerequisites, model-family fragmentation, sections that are accidentally all review, and unrealistic simultaneous implementation requirements. Review L03/L04/L05 transitions and L08/L09/L10/L11/L12 chain carefully. Save its complete raw critique.

The coordinator reconciles any global blocking findings with individual scope authors and targeted reviewers. A global blocker invalidates the affected agent approval until repaired. Regenerate affected allocations/summaries and seek targeted re-review; never leave mutually inconsistent scopes all labelled approved.

### 6. Synchronize all formal artifacts and finalize

Only after the scopes and global review settle, update course_architecture.typ, advanced_statistics_2027_1_syllabus.typ, material_ledger.md (planned allocation separate from delivered coverage), Lectures/notebook_reference_audit.md and Lectures/syllabus_planning_decisions.md. Match dates, lecture names, Book 1/2 sections, actual scope depth and notebook skills **exactly**; do not simply copy page ranges. Recheck whether an omitted item is deliberately omitted or assigned elsewhere.

Check the Typst files mechanically (compile if available, note missing tool/fonts); verify 13 meetings and L01/L02 protection; check all scope/review paths, links, statuses, and source ownership. No notebook is "validated" without executing it; document candidate status honestly. Use Git commits at meaningful checkpoints. Publish a coherent branch-level course proposal, **not** an automatically merged main update.

Finally write the questions/hesitations report **for a human**: clear, ranked, located at earliest relevant lecture, with cross-lecture issues grouped where suitable. Distinguish decisions already made provisionally by agents from questions whose answer would materially change the architecture. End with a compact executive summary, highest-priority issues and exact review provenance.

## Scope budget and overambition test

A lecture is too ambitious if its core intellectual outcome cannot be taught with the declared derivational depth and a compatible notebook without exceeding the live limit. Do not infer feasibility merely because each subsection gets a bullet, or because L01 contains ~61 slides. Use that L01 anchor plus mathematical novelty, carry-forward, derivation steps, visual/schema commitments and student notebook complexity. A reviewer should be able to identify **the single most important cut** that would make each overfull lecture workable.

For every lecture, separately identify: Core/Live (deep), Short bridge (recognize/apply), Notebook owned, Optional, Deferred to a named lecture, and Omitted by course decision. For optional content, do not silently promise it in the formal syllabus or ledger.

## Failure and stop conditions

If source access is missing, search permitted official sources first and record limitations. If subagents cannot actually launch, **stop short of fabricating reviewed or agent-approved scopes**; write a truthful checkpoint and give an exact resumption prompt. If any genuine conceptual blocker cannot be repaired without violating fixed architecture, preserve it as BLOCKED and ask the instructor later. If the work is interrupted, STATUS must preserve the current head, per-lecture approvals and next action.

**The coordinator's success criterion is not ten independently attractive lectures; it is one reviewed, coherent, feasible course architecture with transparent gaps and deliberate tradeoffs.**
