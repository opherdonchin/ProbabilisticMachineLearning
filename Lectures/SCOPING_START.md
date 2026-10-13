# Lecture scope reconciliation — starting point

This is the kickoff for the *next* instructor-led scoping phase, not an approved replacement of the existing scopes.

**Working branch:** `scope-l04-l12-reconcile-2027-1`, created directly from the merge of PR #16 into `scope-l03-l12-course-architecture` (merge commit `730b5cbde055cc166f48f1a73dc63df190e6187b`). Do not work on `main`. The course architecture and proposed allocation were reorganized before this branch; do not recreate the deleted material ledgers.

## Required sources and authority

Read `course_architecture.typ`, `curriculum_map.typ` (planned), `curriculum_map_actual.typ` (classroom record, initially empty), `advanced_statistics_2027_1_syllabus.typ`, `AGENTS.md` and `.agents/skills/lecture-development/SKILL.md`. The operative scope skill is `.agents/skills/lecture-scope/SKILL.md`, including its timing reference and source-arc and downstream feasibility review requirements. Consult Murphy Book 2 as the principal source and selected Book 1 passages as pedagogical backfill. Inspect previous lecture decks and solved/student notebooks; neither authored material nor future syllabus allocation counts as teaching delivered.

Recover instructor-approved content across current and historical branches before proposing changes. In particular, the accepted L03 scope was recovered from `lecture-3-authoring` and recorded in `Lectures/L03_Graphical_Models/development_state.md`; the full L03 Section Design is *not* instructor-approved. L02 has an agreed design. The L01 materials exist, but no class has yet been taught. L13 remains project synthesis, not extra teaching time.

## Open course-wide reconciliation

- The revised architecture makes **working familiarity with recognizable methods and datasets** the educational objective, supported by transferable probabilistic understanding. Each scope should explain the actual task, model/query, performance criterion, computational rationale, and bounded technique students will use.
- L04's current instructor-selected split is **three-bit parity in the live lecture; five-bit correcting code in the student notebook**. The newer *curriculum map* proposes comparing actual Iris probability predictions and information-preserving representations, with the coding exercise as a supplementary diagnostic. This is a genuine choice, not an automatic edit to the scope.
- L07, L09 and L10 currently have separate, mathematically controlled notebook endpoints (one-parameter logistic Laplace, Gaussian-regression VI, and MH on known targets). The newer map proposes returning to an overlapping binary Iris classification question to compare methods. Check whether the practical benefit outweighs loss of diagnostic clarity and what can fit one hour.
- Additional concerns remain L05 first-time PyTorch workload, L08 discrete HMM vs Kalman forecasting, and L12 mobility-data/model assumptions and runtime. Consult `Lectures/course_architecture_scope/questions_and_hesitations.md` and the corresponding `lecture_scope.md` before declaring a decision open.

## How to run the next scoping conversation

1. Start with a **short, evidence-based status table** for L03–L12: existing instructor agreement, newer architecture proposal, real conflict or no conflict, and priority for action. Do not invent approval from a written proposal or an agent review.
2. Treat **L03** as a preserved accepted scope requiring downstream Section Design review, *not* as a fresh scope competition unless an explicit instructor decision reopens it.
3. Begin **L04** as the first genuine scope conflict. Reconstruct the previous lecture's intellectual endpoint and the relevant Murphy Ch. 5 argument independently of either candidate notebook. Explain the mathematical and educational tradeoff between the accepted coding progression and a probabilistic-model-evaluation application. Include a realistic two-hour lecture / one-hour scaffolded Q&A notebook budget and indicate the cost of any combined approach.
4. Present only the **first consequential question** to the instructor, then wait. The instructor reviews scope decisions one at a time; do not preemptively rewrite all scopes or start slide, Section Design, or notebook implementation.
5. Once a scope decision is agreed, update only its owning `lecture_scope.md` and development state, run the specified independent source-arc and lightweight downstream feasibility reviews, record approval provenance, and reconcile the **planned** curriculum map. Never update the actual map before something has been taught. Move on to L05, L06, etc. only after the current decision is settled or deliberately deferred.

## Ready-to-send instigating prompt

> Work on `scope-l04-l12-reconcile-2027-1` in `opherdonchin/ProbabilisticMachineLearning`. Begin the instructor-led reconciliation of L04–L12 lecture scopes with the now-approved course architecture. Follow the repository's `lecture-development` and `lecture-scope` skills. First verify the branch and inspect the architecture, both curriculum maps, existing scope files, approved L03 history, L02 design, L01 materials, and relevant Murphy passages. Give me a compact overview of genuine conflicts and then **start with L04**, because its existing three-bit live/five-bit notebook agreement competes with the newer proposal to emphasize Iris probabilistic predictions and representations. Compare the intellectual argument, mathematical content, practical competence, and realistic notebook feasibility of the alternatives. Preserve previous instructor agreements unless I explicitly revisit them. Ask me **one consequential question at a time**; do not change lecture scopes or begin slide/notebook production until we have decided. Keep Book 2 order where it does not compromise the educational progression.
