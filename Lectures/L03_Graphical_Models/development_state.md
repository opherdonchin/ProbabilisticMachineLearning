# Lecture 3 — development state

**Operational handoff only.** The accepted lecture scope and evolving section contracts are authoritative for pedagogy. This file records stage status and cross-conversation decisions, not a second lecture plan. Reconcile against current branches and user decisions before resuming.

## Repository and artifact revisions

- Active lecture branch: `lecture-3-authoring`. The seven-section plan and scope are here; do not infer that they are already on `main`.
- Agreed scope: `Lectures/L03_Graphical_Models/lecture_scope.md` (read the current branch version).
- Proposed section contracts: `Lectures/L03_Graphical_Models/section_design.md` (read the current branch version).
- `main` gained a revised lecture-development coordinator, Section Design skill, Slide Design/Authoring skills and shared backpressure guidance. Those process changes are **not** currently reconciled into this lecture branch.
- Read the latest file revisions and Git history when resuming; this register is not a frozen SHA cache.

## Stage and acceptance status

- **Lecture Scope:** agreed by the instructor; two-hour lecture plus a separate one-hour student notebook.
- **Section Design:** **proposed / under instructor review**, **not approved as a complete seven-section design**. The source-specific expansion of Sections 3–7 was made by the assistant before the instructor reviewed all its details.
- **Slide-Level Organization, Slide Design, Slide Authoring:** not begun/approved for L03.
- **Notebook:** scope-level contract only; not authored or validated.

## Instructor decisions and current constraints

- The lecture has **seven sections**, approximately **104 substantive minutes** within 120 minutes, with timings provisional and potentially tight.
- The first section develops Markov-chain, chain-rule and DAG-factorization distinctions. **No student network or plates in Section 1.**
- Section 2 works Murphy's five-node student network, including its factorization, numerical CPTs, complete-assignment probability, and 15-vs-47 free-parameter contrast. **Introduce plate notation only in Section 2, after that example**, and keep it brief. Approximate allocation 15 minutes. The instructor agreed with this revised direction, but the slide sequence was not approved.
- Section 3 builds pipe/fork/collider motifs and explaining away; use Murphy's simple motifs and **return to the student network** for tangible examples, including numerical explaining away. The instructor agreed with the proposed use of the student network.
- Section 4 includes whole-DAG d-separation and directed Markov blankets. **Sections 4–7 require source-grounded review of specificity, feasible extent, and boundaries before approval.**
- **Stylistic invariant:** every section must end with a retrospective summary of its own material, **not** a teaser, bridge, question about the next section, or "next we will" announcement. Any genuinely necessary connective explanation begins the receiving section.
- **Lecture/notebook boundary:** Lecture 7 ends with the uniform binary Ising model and coupling interpretation. The Gaussian observation model, restoration prior/likelihood/posterior, single-site conditional/log odds and ICM belong to the separate one-hour student notebook, not the live lecture.

## Review findings / blockers

- **Blocking before approving Section 4's exact worked example:** verify the proposed multi-path d-separation calculation in Murphy Fig. 4.23(a). An earlier review found that the Section 4 claim `X_4 -> X_7 <- X_5` does not match the figure; the relevant connection passes through `X_6`. Do not make its path argument an approved teaching commitment until the actual graph and all paths have been checked.
- **Advisory:** Sections 3–6 have several demanding worked calculations relative to their provisional 20/20/18/14 minute allocations. Make a realistic extent review using the new Section Design specificity criteria.
- **Source-boundary issue:** Section 5 includes a course-constructed three-node numerical potential table, which must be validated mathematically and justified by its distinct teaching job rather than falsely attributed to Murphy.
- **Cross-branch conflict:** `main` rewrote shared skills and `Lectures/README.md`, while this branch retained local retrospective-ending instructions and L03 planning. Perform a content-level reconciliation before any cherry-pick/merge; never replace an accepted lecture decision with a newer generic workflow rule.
- No independent specialist feasibility review, true Codex subagent smoke test, or approved L03 slide-design pass has yet been recorded here.

## Next action and owner

1. **Section Design review:** source-verify the Section 4 graph and apply the new specificity-vs-slide-sequencing test to Sections 3–7; present *consequential* tradeoffs to the instructor, without rewriting scope.
2. **Coordinator / repository maintenance:** reconcile branch conflicts with the newer authoring workflow and the instructor's retrospective-summary preference. Preserve agreed scope and proposed-status labeling. Do not merge or publish without explicit authorization.
3. **Instructor:** review Section 4 and remaining section contracts. Record explicit section-design approval before downstream organization starts.

Update this operational register when decisions are accepted, stage changes, or another conversation will resume work; do not treat silence or a self-declared review as instructor approval.
