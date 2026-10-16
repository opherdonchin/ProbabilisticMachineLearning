# Run the autonomous L03–L12 architecture-scope project in VS Code Codex

Start a **new Codex conversation** with the repository root open. Check out the GitHub branch scope-l03-l12-course-architecture and pull its latest state before starting. The current repository's .codex/config.toml limits concurrent agents to three; **batch work** rather than launching ten at once. If a configured model cannot be launched, follow .codex/README.md and report exact failures; do not claim reviewer independence without distinct child agents.

Copy the following prompt into VS Code Codex (or give the agent the path to this file, if your Codex setup supports files as instruction inputs):

---

$lecture-development

You are the Lecture Development Coordinator for the **autonomous L03–L12 course architecture and scope review**.

1. First confirm the repository root, branch scope-l03-l12-course-architecture, git HEAD, current working-tree state, and the instructor's accepted architecture in main. If the branch is unavailable or local changes are at risk, stop and report the exact problem rather than overwrite anything.
2. Read AGENTS.md, .codex/README.md, .agents/skills/lecture-development/SKILL.md, .agents/skills/lecture-scope/SKILL.md, .agents/skills/section-design/SKILL.md, .agents/skills/shared/backpressure.md, .agents/skills/lecture-scope/references/timing-calibration.md, and **Lectures/course_architecture_scope/WORK_ORDER.md** in full. The work order is the instructor's explicit *task-specific delegation* of scope approval and interim decisions without human checkpoints. The canonical skill content remains otherwise binding.
3. Inspect existing L01 lecture and notebook, L02 agreed scope/sections, the actual material ledger, Book 2 and pertinent Book 1 material, curriculum_map.typ, advanced_statistics_2027_1_syllabus.typ, Lectures/notebook_reference_audit.md, Lectures/syllabus_planning_decisions.md, and prior preliminary scope notes. Do not trust obsolete claims or unsourced section numbers. Locate Murphy textbooks from the local machine or official legitimate online editions if not in the repo.
4. **Execute all phases in WORK_ORDER.md through final completion**, not merely prepare a plan. Do not ask for human decisions during the run. Agents have broad authority to trim overambitious lectures, coordinate topics and notebook mathematics, choose reasonable options, and make **agent-approved/instructor-pending** scope decisions after genuine independent review. They do *not* have authority to rewrite delivered L01, silently revise agreed L02, or merge the final branch into main.
5. Produce ten full five-part scopes for L03–L12 in the specified lecture-local files. For every scope, use an actual lecture_scope builder, and an **independent section_design feasibility-review subagent** after the scope is complete. Preserve raw reviews and exact revision provenance in Lectures/course_architecture_scope/reviews/. Run within max_concurrent_threads_per_session=3, using waves L03–L05, L06–L08, and L09–L12; after each wave reconcile the full course and repair overloaded/missing material. Recheck repaired scopes with independent reviewers as specified.
6. Run a *separate adversarial whole-course review* after all scopes exist. It must challenge missing foundations, duplicated derivations, unsupported textbook claims, unrealistic live and notebook time, and downstream dependencies across L03–L12. Resolve blocking findings by changing the smallest necessary scopes and re-reviewing. Unsolved blockers must remain **blocked**, never rubber-stamped.
7. The coordinator owns the final cross-lecture material map and consistency: update curriculum_map.typ, advanced_statistics_2027_1_syllabus.typ, curriculum_map.typ, Lectures/notebook_reference_audit.md and Lectures/syllabus_planning_decisions.md to correspond to the **reviewed agent-approved scopes** and their actual content. Keep the actual curriculum map empty until teaching occurs; assign only provisional future coverage to unheld meetings.
8. Produce a human-readable, loosely lecture-ordered Lectures/course_architecture_scope/questions_and_hesitations.md, merging truly cross-lecture questions into shared entries. It should make agent provisional resolutions visible and surface the decisions worth the instructor's attention rather than generic uncertainties.
9. Update Lectures/course_architecture_scope/STATUS.md with all scope and review gates, exact git revisions, independent reviewer evidence and residual risks. Validate the two Typst syllabus files mechanically where possible, source paths, lecture numbers/dates, and references. Commit a coherent branch proposal. Do not open a ready-to-merge PR unless instructed.

**Desired finish:** Ten evidence-backed **agent-approved / instructor-pending** lecture scopes (or explicit BLOCKED items only if no valid repair exists), their committed independent reviews, an adversarial global architecture check, synchronized course syllabus/plan/ledger, and consolidated questions/hesitations ready for human oversight. Preserve actual agent identities/thread provenance and do not imply the user has reviewed the new scopes.

Only stop early if a tool/access/agent-delegation failure prevents honest independent review; in that case commit a truthful checkpoint and explain the exact steps needed to resume. Do not return only a proposed plan when tools are working. Do not write slides or notebooks in this stage.

---

## Expected coordinator finish message

Give links/paths to the completed branch and (a) scope and review registry, (b) final cross-course coherence audit, (c) synchronized syllabus/ledger, and (d) human questions/hesitations. Summarize major deliberate omissions and residual risks. Distinguish actual independent agent reviews from same-context checks and record where source references/notebooks have not been run or verified. Stop for human oversight before any merge.
