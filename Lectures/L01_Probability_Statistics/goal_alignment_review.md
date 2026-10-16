# L01: goal alignment — pending instructor review

**Status:** L01-JOINT-QUERY resolved in the 2026-10-16 delivery session; checkpoint implementation is locally validated. L01-NOTEBOOK-COMPUTATION is resolved and its exact-only pair passes local validation. L01-GAUSSIAN-TIME remains open. This does not approve the complete Scope or other proposed changes. No lecture has yet been taught; an older “delivered” label refers to prepared material, not classroom delivery.

**Current evidence:** [L01 coverage specification](lecture_01_coverage_spec.typ); [current slide source](slide_deck.typ); [course-spine review](../course_architecture_scope/l01_framework_course_spine_review.md). The lecture's intended endpoint is Gaussian conditioning for a linear Gaussian system, with missing-value imputation in the student notebook.

## L01-JOINT-QUERY — make the task-to-query learning outcome explicit

**Question:** Does the current lecture reliably enable students to move from a learning task and available observations to a **joint probabilistic model, a well-defined query, and the operation needed to answer it** (conditioning, marginalization or an expectation/decision)?

**Evidence / concern:** The coverage specification refers to task taxonomy, datasets and probabilistic queries, but does not make that translation a concrete required student outcome. The existing deck already contains relevant task/query framing, so the issue is to **verify whether the explanation and student work are sufficient**, not to assume the topic is absent.

**Options:** (A) Leave the deck unchanged if its existing examples and checks establish this competence; (B) adapt one existing dataset/task example or add a brief checkpoint explicitly naming model, observations, query and operation, using time reclaimed from less essential framing rather than adding a new survey.

**Provisional recommendation:** Verify the current slide progression against this explicit outcome and, only if needed, strengthen one worked transition or student checkpoint. Retain the distinction between choosing/estimating model parameters and conditioning on observed variables.

**Affected work:** L01 scope learning-outcome wording, early task/query slides and their transition to Gaussian conditioning; no reallocation of later lectures implied.

### Current-source assessment and concrete choice — 2026-10-16

Independent Scope review of common `main@8889ac0` finds substantial existing teaching: Iris Bayes classification and its class decision (source lines 839–875); the three-operation summary (1624–1683); the supplied-parameter LGS joint and three questions (2283–2378); and conditioning/summarizing/forward prediction (2689–2913). The case for keeping the explanation is therefore strong. The remaining concern is whether students can supply the translation themselves: the live source presents the queries and answers rather than eliciting the complete translation in a student checkpoint. This is a source-based pedagogical assessment, not evidence of student failure.

**Accepted targeted strengthening:** use the existing bivariate Gaussian example (current handout p51), before revealing its answer. Two standardized measurements have supplied joint law

$$
\begin{pmatrix}X_1\\X_2\end{pmatrix}
\sim\mathcal N\!\left(0,\begin{pmatrix}1&0.8\\0.8&1\end{pmatrix}\right).
$$

With $X_2=1.5$ recorded and $X_1$ missing, ask students to name the fixed parameters, observed and unknown variables, the distribution needed to report uncertainty about $X_1$, and the operation that gives it. Ask how that query changes when $X_2$ is unobserved and whether either calculation estimates $\mu$ or $\Sigma$.

The expected distinction is $p(X_1\mid X_2=1.5)=\mathcal N(1.2,0.36)$ by conditioning versus $p(X_1)=\mathcal N(0,1)$ by marginalization; both use fixed supplied model parameters. The second Gaussian argument is variance. This exercises the task-to-query choice using an existing model and theorem; it introduces no new proof.

Allow **2–3 minutes provisionally**, funded by shortening the repeated verbal walk through the four Task/Performance cells on current p33, “Learning problems become probabilistic queries.” Source lines 1448–1449 explicitly identify that grid as recap; its cells repeat p25. Retain p33's distinct query/performance key points and preserve the experience taxonomy and experience×task examples. This is a proposed reallocation requiring rehearsal, not measured time saved.

The alternative was to retain the current worked exposition, accepting its substantial explicit examples as sufficient preparation and relying on notebook work for elicitation. The coordinator recommended the targeted checkpoint because it makes the outcome observable before the LGS application. Neither choice changes the accepted route, live proof depths or selected design preferences.

**Instructor decision, current session 2026-10-16:** “Use the existing example as a checkpoint (recommended).” This explicitly accepts the question and provisional reallocation presented above. Implement this bounded adaptation with the existing example's visual language and preserve its mathematical result; do not add another survey, change proof depths, or infer complete-Scope approval. [Raw Scope review](reconciliation/delivery_readiness/scope_review.md) preserves the source-based assessment.

## L01-GAUSSIAN-TIME — protect the mathematical endpoint

**Question:** Does the live two-hour plan give students enough time to understand **Gaussian conditioning, posterior uncertainty and linear Gaussian inference**, rather than merely reach their equations?

**Evidence / concern:** The coverage specification budgets about 55–65 minutes for introductory ML framing and 55–65 minutes for all remaining statistics, estimation and Gaussian inference. This creates a credible crowding risk; it is **not evidence that the actual deck runs long** or that the mathematical proofs should be removed.

**Options:** (A) Preserve the current allocation if a timed run supports the endpoint; (B) compress repeated Bayesian/statistics review or taxonomy examples, or move suitable self-contained algebra to recorded support, while retaining the conceptual/mathematical core of Gaussian conditioning and the notebook handoff.

**Provisional recommendation:** Time the current lecture, preserve Gaussian conditioning and its uncertainty interpretation as the live endpoint, and choose the smallest upstream reduction only if needed.

**Affected work:** L01 timed slide sequence, scope time budget, and preparation for the missing-data notebook. No timing or notebook change is approved here.

**Current-source timing evidence, 2026-10-16:** the baseline rebuild confirms 69 handout pages, with one lecture title, seven section dividers and 61 content slides; 30 content slides precede Gaussian geometry. The calibration's 70-page/eight-divider inventory is stale. Neither these counts nor an agent read-through measures teaching time. Rehearse the current presentation aloud with normal derivations, the accepted checkpoint, interpretation and discussion pauses; record the existing section boundaries and the residual proof, squared-loss proof, scalar update and sensor-fusion durations separately. Include whichever loss sequence is ultimately accepted. The accepted 2–3-minute checkpoint allowance and historic 2–4-minute loss allowance remain provisional.

The only newly accepted compression is a shorter second verbal pass through the repeated Task/Performance grid to fund the checkpoint. Broader cuts await timed evidence. Moving or reducing the settled live residual or squared-loss derivations would require a new instructor decision and is not the current recommendation. The separate full block-elimination recording retains its existing boundary.

## L01-NOTEBOOK-COMPUTATION — exact computation, without PyMC

**Status: resolved, current instructor session 2026-10-16.** Exact answer: “I think we can get rid of PyMC entirely. It takes away from the current focus of the notebook.” This replaces both previously offered emphasis options: no PyMC model-building or supplied comparison remains in L01's active notebook/worked solution. The full notebook handoff, workload and publication validation remain separate.

Retain the accepted multiple-query direction: use the supplied joint Gaussian to obtain the hidden-block conditional distribution, choose its mean under squared loss and interpret remaining uncertainty, calculate the forward observation marginal under the same fixed parameters, and generate a fresh case. Reuse the existing seven-dimensional controlled example and its joint-to-LGS translation. Parameter estimation, generic posterior sampling, sampler diagnostics and PyMC/ArviZ APIs are outside this notebook.

The computational point is that this linear Gaussian structure permits exact answers, evaluated through the lecture equations and transparent linear solves. Generating a fresh Gaussian case is a use of the model, not an approximate conditional-inference algorithm. The conditional mean minimizes conditional model expected squared loss; that does not guarantee a smaller realized reconstruction error on every simulated case. Analytic marginal intervals concern individual coordinates, not simultaneous joint coverage.

The prior [runtime review](reconciliation/delivery_readiness/runtime/report.md) remains evidence about its exact pre-removal source hashes. Its isolated PyMC pass does not validate the new exact-only notebook. The revised worked solution passed repository uv first; the solved Q&A reproduces it, passes official clean local execution, and has a mechanically generated student version. [Current exact-only evidence](reconciliation/delivery_readiness/runtime/exact_only/report.md) records this source and its checks. Hosted Colab remains required before publication; the author’s 55–75-minute learner estimate is unmeasured. No PyMC dependency was present in the root manifest/lock, so this decision does not require removing a declared course dependency.
