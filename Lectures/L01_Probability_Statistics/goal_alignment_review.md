# L01: goal alignment — pending instructor review

**Status:** Open questions for instructor consideration, recorded from the 2026-10-16 discussion. This is **not** an approved change to the scope or slides. No lecture has yet been taught; an older “delivered” label refers to prepared material, not classroom delivery.

**Current evidence:** [L01 coverage specification](lecture_01_coverage_spec.typ); [current slide source](slide_deck.typ); [course-spine review](../course_architecture_scope/l01_framework_course_spine_review.md). The lecture's intended endpoint is Gaussian conditioning for a linear Gaussian system, with missing-value imputation in the student notebook.

## L01-JOINT-QUERY — make the task-to-query learning outcome explicit

**Question:** Does the current lecture reliably enable students to move from a learning task and available observations to a **joint probabilistic model, a well-defined query, and the operation needed to answer it** (conditioning, marginalization or an expectation/decision)?

**Evidence / concern:** The coverage specification refers to task taxonomy, datasets and probabilistic queries, but does not make that translation a concrete required student outcome. The existing deck already contains relevant task/query framing, so the issue is to **verify whether the explanation and student work are sufficient**, not to assume the topic is absent.

**Options:** (A) Leave the deck unchanged if its existing examples and checks establish this competence; (B) adapt one existing dataset/task example or add a brief checkpoint explicitly naming model, observations, query and operation, using time reclaimed from less essential framing rather than adding a new survey.

**Provisional recommendation:** Verify the current slide progression against this explicit outcome and, only if needed, strengthen one worked transition or student checkpoint. Retain the distinction between choosing/estimating model parameters and conditioning on observed variables.

**Affected work:** L01 scope learning-outcome wording, early task/query slides and their transition to Gaussian conditioning; no reallocation of later lectures implied.

## L01-GAUSSIAN-TIME — protect the mathematical endpoint

**Question:** Does the live two-hour plan give students enough time to understand **Gaussian conditioning, posterior uncertainty and linear Gaussian inference**, rather than merely reach their equations?

**Evidence / concern:** The coverage specification budgets about 55–65 minutes for introductory ML framing and 55–65 minutes for all remaining statistics, estimation and Gaussian inference. This creates a credible crowding risk; it is **not evidence that the actual deck runs long** or that the mathematical proofs should be removed.

**Options:** (A) Preserve the current allocation if a timed run supports the endpoint; (B) compress repeated Bayesian/statistics review or taxonomy examples, or move suitable self-contained algebra to recorded support, while retaining the conceptual/mathematical core of Gaussian conditioning and the notebook handoff.

**Provisional recommendation:** Time the current lecture, preserve Gaussian conditioning and its uncertainty interpretation as the live endpoint, and choose the smallest upstream reduction only if needed.

**Affected work:** L01 timed slide sequence, scope time budget, and preparation for the missing-data notebook. No timing or notebook change is approved here.
