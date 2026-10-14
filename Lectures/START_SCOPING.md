# Start lecture scoping — post-architecture handoff

**Working branch:** `assess-l04-l12-reconciliation-20261014`, isolated worktree `/tmp/pml-l04-l12-reconciliation`, based on `origin/scope-l04-l12-after-architecture-20261014` at `16850fb`.
**Frozen starting point:** merge commit `730b5cbde055cc166f48f1a73dc63df190e6187b` on `scope-l03-l12-course-architecture` (PR #16, already merged).
**Stage:** Lecture Scope / instructor-led reconciliation and revision; **not** slides, Section Design, or notebook implementation.
**Current research mode:** parallel L05–L12 scope/notebook-feasibility investigation with deferred instructor review, explicitly requested 2026-10-14. Continue independent tasks when local decisions arise; only their affected downstream work waits. The [review queue](course_architecture_scope/reconciliation/instructor_review_queue.md) indexes owning decision records. Ask one highest-leverage question only when the instructor requests review.
**Protected:** `main`. Do not merge to it; do not merge this scoping branch without a separate instructor request.

## Authority and inputs

1. Read `AGENTS.md`, `course_architecture.typ` (the teaching vision), and `curriculum_map.typ` (prospective allocations). `curriculum_map_actual.typ` has identical lecture/reading/notebook columns but is intentionally empty: **no lecture has been taught yet**. Never fill it from drafted slides or completed solutions.
2. Read `.agents/skills/lecture-development/SKILL.md` and `.agents/skills/lecture-scope/SKILL.md`, including timing calibration and the downstream Section Design **feasibility-review** contract. Use the `$lecture-development` coordinator for a multi-lecture sequence and the `$lecture-scope` specialist for an individual scope. Honor the skill's build/revision distinction and actual delegation capability; do not claim independent reviews unless separate reviewers worked.
3. Review `Lectures/course_architecture_scope/STATUS.md`, `Lectures/syllabus_planning_decisions.md`, `Lectures/course_architecture_scope/questions_and_hesitations.md`, and the target `LXX/lecture_scope.md`, associated reviews, and `development_state.md` (where present). These record prior approvals and proposals with different authority.
4. Inspect actual earlier teaching **artifacts** for what students will encounter: L01's existing lecture/solved notebook; L02's agreed lecture/section design; L03's **approved** DAG-to-undirected-graph lecture scope, preserved from `lecture-3-authoring`. Actual delivery has not yet occurred. Follow Murphy Book 2 primarily and Book 1 selectively; recover the source's mathematical argument rather than using section numbers as a checklist. Ask for access if a named source cannot be inspected.

## Decisions not to overwrite

- **L01:** prepared lecture and solved notebook; not yet taught. Do not invent delivery information.
- **L02:** agreed exponential-family/Markov-chain design; use as a prerequisite assumption but confirm final drafted artifacts later.
- **L03:** instructor-agreed live graphical-model scope and notebook-only Ising image-restoration model and local algorithm. **Do not redo L03 scope**; proposed seven-section design on `lecture-3-authoring` is not fully approved and has separate review issues.
- **L04:** On 2026-10-14 the instructor selected the recommended focused Iris probability-evaluation notebook, replacing the previous five-bit student construction. Keep the live three-bit parity example and information-theory mathematics. Full-scope acceptance, live emphasis and detailed handoff remain separate; see the L04 and [reconciliation registers](course_architecture_scope/reconciliation/development_state.md).
- **L05–L12:** existing detailed scope files are proposals and review evidence, not blanket instructor approval of the newer curriculum-map examples. Preserve proven decisions, explicitly reopen consequential changes, and do not replace a scope merely because a newer map is more recent.

## The teaching principle to protect

The educational end is *working competence* with recognizable probabilistic ML problems and useful algorithms. Probabilistic models, queries, performance criteria and mathematically justified computation provide transferable understanding. Each lecture must show both its **mathematical contribution** and **practical capability**—the data/task, method, output, evaluation, meaningful baseline and failures. Distinguish mathematical check examples from substantive application; one hour cannot support two full implementations. Use the repository's guided Q&A notebook pattern, not an open-ended programming assignment.

Do not mischaracterize L05–L10 as increasingly advanced posterior approximations: model/parameter fitting, exact message passing, posterior proxy fitting and target-expectation sampling perform different tasks.

## Scoping process

1. **Before changing a scope:** verify its latest blob/branch, prior instructor approvals and immediate prerequisites. Reconstruct the preceding lecture argument and Murphy's relevant argument. Identify any tension with the newer architecture and practical notebook proposal.
2. Present a concise diagnosis and a small number of *substantively different* alternatives only where choice is open. Provide mathematics, rationale, meaningful application and opportunity cost; say which prior decision an option changes. Ask **one consequential question at a time**, following the instructor's preferred pace.
3. Once the instructor chooses, develop the five Lecture Scope parts *iteratively*: intellectual arc; mathematical spine with treatment depth; notebook handoff; concrete examples; lecture contract. Do not make slides, section outlines, generated figures or notebooks in this phase. Identify deferrals, exact Book 2/Book 1 passages, realistic live/notebook workloads and genuine recording candidates.
4. Have Section Design evaluate the provisional scope in `feasibility-review` mode without producing section contracts. Obtain instructor approval for consequential choices, write/update only the target lecture's scope and compact development-state record, and synchronize the *prospective* curriculum map. Record review provenance and any unresolved notebook validation. Never update the actual map before class.
5. Continue lecture by lecture, with cross-lecture checks where topics/examples recur. Preserve the accepted course spine rather than redoing prior approvals.

## Current L04 checkpoint

The notebook-endpoint decision is resolved: prepared Iris forecasts, student accuracy/log-score comparisons and supplied reliability/bounded information interpretation. The required five-bit construction is removed; live parity remains. Develop the affected handoff without silently rewriting the communication-led intellectual arc or live allocations. Obtain current-target source/Section Design review, then present any consequential live-emphasis change as one decision. No full-scope acceptance or notebook implementation is implied.

**Next instructor interaction:** do not ask the resolved notebook-endpoint question again. The instructor now requests deferred review: record the pending live-emphasis item at its owner, continue other investigations, and present the highest-leverage unresolved question only when asked for review. Preserve the separate L01 workstream.

## Later decisions to surface only when their lectures arise

- **L05:** breadth of GLMs plus first PyTorch/autodiff/SGD in one meeting.
- **L06:** missing-data Gaussian EM versus a biomedical segmentation example; exact expected second moments and one-hour workload.
- **L07/L09/L10:** shared posterior-prediction application versus existing different diagnostic testbeds, preserving Laplace/VI/MCMC distinctions and defensible computation/accuracy regimes.
- **L08:** HMM discrete messages versus Kalman forecasting as the main application; exactness and sequential structure.
- **L11:** heteroskedastic conditional prediction and honest separation of fitted-noise versus weight uncertainty.
- **L12:** mobility VAE data access, Gaussian likelihood limitations, beta/reduction conventions, runtime and prior-generation checks.
- **L13:** synthesis/projects, not overflow lecture time.

## Status at handoff

This file creates no new pedagogical approval. The target L04 conflict is **pending**; prior scope documents remain untouched. Before starting each discussion, check current branch and commits for intervening changes.
