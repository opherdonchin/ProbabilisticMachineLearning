# VS Code Codex prompt — revise L04–L12 after source-arc review

**Preparation state:** The revised [lecture-scope skill](../../.agents/skills/lecture-scope/SKILL.md) is committed on this branch, including source-arc fidelity checks and an explicit decision hierarchy: **authority/prerequisites → worthwhile intellectual argument → feasibility gate → notebook/application value**. The earlier [amendment proposal](source_arc_skill_recommendations.md) is historical and **must not be reapplied**. Nine source-arc reviews remain beside their scopes, summarized in [the review index](source_arc_review_index.md). This prompt is for **subsequent instructor-authorized revisions of the lecture scopes**, not further skill rewriting.

**How to use:** Check out and pull `scope-l03-l12-course-architecture` in VS Code, then open a new Codex conversation at the repository root. The instructor authorizes the *targeted revision process* by giving the launch prompt below. Do not reapply the older five-patch proposal or change the skill during the revision run.

---

$lecture-development

You are the Lecture Development Coordinator for a **targeted, source-grounded intellectual-arc revision of L04–L12**. Work on branch scope-l03-l12-course-architecture.

The instructor's objective is **not** to require complete or slavish adherence to Murphy's chapter organization. It is to make the selected and reorganized mathematics form a *recognizable intellectual development*, and require explicit justification for departures. Apply the current scope skill's decision priorities in order: (1) protect approved teaching and prerequisites, (2) construct a worthwhile mathematical argument, (3) test feasibility without silently sacrificing that argument, and (4) optimize notebook/application value within a feasible route. Do not trade source-arc quality for easy notebooks or chapter-count coverage.

### Gate 0: provenance, branch and protected decisions

- Confirm repository root, branch, exact HEAD and clean worktree. Protect all existing instructor-agreed work and don't overwrite a divergent local branch.
- Read AGENTS.md, .agents/skills/lecture-development/SKILL.md, .agents/skills/lecture-scope/SKILL.md, .agents/skills/section-design/SKILL.md, .agents/skills/shared/backpressure.md, the timing-calibration reference, L03 accepted scope and development_state, source inspection, current course syllabus/plan/ledger, scope status and all nine current L04–L12 scopes. Read all nine adjacent source_arc_review.md files and Lectures/course_architecture_scope/source_arc_review_index.md.
- Follow the **current** `.agents/skills/lecture-scope/SKILL.md`, including its decision priorities, source-arc review and Section Design feasibility check. Treat the old `source_arc_skill_recommendations.md` as historical; do not reapply it, invent additional review modes or edit canonical skills. Record the exact skill blob used.
- Protect the agreed L03 scope and the **L04 lecture/notebook split**: live two-message-bit/one-parity-bit detection and uncertain decoding; notebook five-bit distance-three code for guaranteed correction of at most one error, evaluated with 4×32 channel probabilities. Preserve the mathematics, while feasibility-checking the new hour. Keep L04 information, L05 substantive GLMs and optimization, L06 EM, inference L07–L10, neural prediction L11, VAE L12. Preserve L01/L02 delivered/agreed contracts.

### Gate 1: independent source-first assessment, *before* revision

Launch actual **independent lecture_scope feasibility/source-arc reviewers**, respecting .codex/config.toml concurrency limits. For each L04–L12 review task:

1. Give the agent ONLY Murphy's relevant source passages, earlier established course endpoints, and the accepted course allocation. Instruct it to write a 1–2-page *source-arc reconstruction* (driving question, indispensable conceptual transitions, endpoint and selective omissions) to an isolated scratch/report section before it reads the proposed scope or any existing source_arc_review.md. Do not seed it with the ChatGPT verdict.
2. After the reconstruction is frozen, allow it to read the current lecture scope and adjacent source_arc_review.md. Compare source and proposed arcs, assess justified deviation, missing intellectual transitions, links to previous/later lectures and value to this MSc BME audience. Include any disagreement with the existing review.
3. Give a source-arc classification: faithful selection / justified reorganization / unjustified displacement / fragmentation. This is **separate** from the existing feasible / feasible-with-risks / blocked verdict. Return the minimum repair preserving mathematical depth and selected lab where possible.
4. Save raw agent evidence under Lectures/course_architecture_scope/source_arc_agent_reviews/L04.md … L12.md, with reviewer thread, exact source scope/review hashes and source edition. Do not let a reviewer read another reviewer's report before finishing; do not let it revise the scope it is assessing.
5. If subagents do not actually launch, stop before claiming independent checks or agent approval and report the exact failure.

The earlier same-context files are constructive hypotheses, not a mandatory verdict. Where a prior instructor-agreed arc exists, compare to it before suggesting a competing route.

### Gate 2: narrowly scoped revisions, not another syllabus rebuild

Use the initial independent comparisons to decide **which** scopes need changes. Current working priorities are L07, L08 and L11; L04–L06, L09–L10 and L12 mainly need bridge/justification checks. This is a triage, not a foregone finding. **No compulsory rewrite:** if a source-faithful or justified arc is already present, document why it should be preserved.

Assign independent builders using lecture_scope in REVISION mode to each actual scope-level change. The revision request must specify exactly which mathematical **argument** is lost or underdeveloped, what alternative transitions have to replace it, and the existing lecture/notebook obligations to preserve. Do not add chapters or derive more math automatically.

Essential test cases:
- L04: Honor the **three-bit live / five-bit student** split without turning L04 into a coding-theory survey. Review the five-bit decoder, minimum-distance-three argument, MI/MAP error/rate comparison and one-hour workload with supplied NumPy enumeration; preserve Murphy's KL→entropy/MI→communication→ML-representation arc. Request targeted independent feasibility review of the changed notebook, not a redesign of the live lecture.
- L05: **Preserve the instructor's latest Bayesian-regression starting point:** begin from a familiar prior and Gaussian observation likelihood; explain that binary/count outcomes call for other response families, **not that hierarchical Bayes fails**. Then distinguish model selection (GLM links/families) from inference/computation (full parameter posterior versus MLE/MAP via AD/SGD). Keep genuinely substantive GLM generality and the Ch.15+Ch.6 synthesis, without adding another Bayesian regression lecture.
- L06: **Preserve the instructor's latest hierarchical-model starting point:** students know a latent-variable joint posterior already. Contrast that valid fully Bayesian inferential target with maximizing a *latent-marginalized observed-data likelihood* for a point estimate. Motivate EM as an alternative optimization method when conditional expectations/M-steps are manageable; retain the general MM/ELBO argument, not only a Gaussian missingness recipe. The Bayes-vs-EM contrast must fit existing time.
- L07: Make Chapter 7's query/structure/method map a real mathematical part of the lecture, with Laplace a deep worked case rather than the chapter's substitute. Make any time offsets explicit.
- L08: Connect L03 factorization/separators → general message passing → HMM forward/backward → Gaussian filtering as an alternative representation. Don't add full tree BP or another notebook by default.
- L09: Keep optimization over a **distribution** as the organizing innovation and separate choices of q from coordinate/gradient optimization.
- L10: Build the arc MC integral → valid dependent chain → mixing and proposal geometry, not just a collection of Markov-chain technicalities. Reassess HMC as an intentional depth choice.
- L11: Restore the computational-graph/compositional-function and *two network roles* arguments of Chapter 16; keep the heteroskedastic Gaussian regression as application, not as the definition of neural networks.
- L12: Distinguish prior generation from per-input reconstruction; ensure information-rate is an interpretation of the VAE objective, not a replacement for the generative-model argument.

Builder must state *which existing live concept or example is shortened/replaced* to pay for any restored transition. Keep a realistic ~100–120 minute live envelope and one-hour notebook; do not invent extra class time or assume recordings. Include mathematical treatment depth and source-to-arc correspondence; no slide outline or section contract.

### Gate 3: independent constructibility and course coherence

A different actual **section_design feasibility-review** agent must assess every materially changed scope. Have it verify: (a) the source-arc repair is teachable and not merely a new introductory sentence, (b) the core mathematical development and notebook are preserved, (c) transitions and examples support the agreed intellectual destination, and (d) no unbudgeted overload. Persist each raw report with exact target revision; re-review substantive targeted repairs. Not every formatting-only change requires a full review.

Then run a **separate whole-course source-arc review** examining the *intellectual argument across lectures*, not just coverage ownership. Specifically test L03→L08 (graph structure/message passing), L05→L06→L07 (prediction, latent learning, inference), L06→L09→L12 (bound/variational inference/generative learning), and L05→L11→L12 (differentiable probabilistic models/inference networks). For each reallocated idea distinguish *explained there*, *used there*, *named there*, or *omitted*. Do not rubber-stamp ten individually good arcs as a coherent course.

Preserve existing independent review records without overwriting them. Save new reports separately. If a reviewer finds the selected route must change a protected instructor-approved commitment, report a human decision rather than silently altering it.

### Gate 4: synchronized proposal and instructor-facing output

Only after revisions and independent reviews:
- Update syllabus_plan.typ, advanced_statistics_2027_1_syllabus.typ, Lectures/material_ledger.md (delivered L01 entries untouched), Lectures/notebook_reference_audit.md, Lectures/syllabus_planning_decisions.md and Lectures/course_architecture_scope/architecture_audit.md to reflect **actual** revised arc/depth/coverage, not the previously listed chapters.
- Update STATUS with agent/reviewer identities, exact before/after hashes, source-arc and feasibility verdicts, residual timing and notebook uncertainty. Compile both Typst files if possible, validate lecture numbering and protected L01/L02/L03 decisions, and report the checks honestly.
- Produce one final Lectures/course_architecture_scope/source_arc_revision_summary.md: by lecture, the old argument, identified problem, new argument, smallest change, displaced topic, separate reviews and unresolved decisions. Group cross-lecture questions in the existing questions_and_hesitations.md.
- Commit the coherent revised proposal to this **same review branch**; do not merge into main. Stop for instructor evaluation before Section Design building/slide authoring.

**Success is not nine lectures that sound more like Murphy.** It is nine strong, selected mathematical arcs that transparently preserve, combine or deliberately depart from Murphy's developments, reinforce the shared course argument, and remain feasible with a genuine student notebook.

---

**Execution note:** The adjacent `source_arc_review.md` files are provisional critiques, not authorization to overwrite agreed scopes. Use the revised canonical skill; the instructor's submission of the launch prompt authorizes the targeted revision run. Make reversible decisions within existing approval boundaries, collect consequential instructor questions instead of stopping for each one, and do not merge the course branch into `main`.
