# L01: goal alignment — pending instructor review

**Status:** L01-JOINT-QUERY resolved in the 2026-10-16 delivery session; bounded checkpoint implementation is authorized. L01-GAUSSIAN-TIME remains open. This does not approve the complete Scope or other proposed changes. No lecture has yet been taught; an older “delivered” label refers to prepared material, not classroom delivery.

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

## L01-NOTEBOOK-COMPUTATION — PyMC's role in the one-hour handoff

**Status:** ready for instructor decision after L01-JOINT-QUERY. Owner: Scope/notebook handoff; the full notebook contract is still unapproved. [Actual runtime review](reconciliation/delivery_readiness/runtime/report.md) separates the analytic check in repository uv from an isolated PyMC check and the still-required repository-locked and hosted Colab runs.

The existing 80-cell solved draft develops supplied joint Gaussian → PyMC conditional sampling → LGS translation → exact conditional posterior → comparison. Actual exploratory execution confirms its sampling/API path works with the tested dependencies. Its success answers a technical question, not whether that sequence is the best allocation for the accepted hidden-block, squared-loss-summary, forward-marginal and generation aims in one hour.

**Recommended choice:** make the exact block-conditioning/LGS computation the core, applying the live equations with theoretical, technical and interpretive scaffolding. Use its conditional mean for the squared-loss summary; compute the forward law under supplied parameters; generate a fresh case. Retain PyMC as a short supplied comparison against the same analytic conditional law rather than a second extended implementation route. This preserves an encounter with a generic sampler while freeing learner attention for different queries. The tradeoff is less student practice constructing a PyMC missing-data model in L01.

**Alternative:** retain the current PyMC-first route and its guided model-building work, then add forward/generation activities. This prioritizes practical sampler use and exact-versus-sampled checking, but requires a learner-time pilot to establish that the combined workload fits; passing a fast kernel run does not establish that.

The mathematical distinction must survive either choice: analytic Gaussian conditioning gives the exact posterior within the supplied model; a generic sampler numerically explores that target, and its summaries have Monte Carlo error. Direct draws from a known Gaussian also have sample-summary error but do not define an approximate posterior family. Seven controlled dimensions do not justify a large-scale inference bottleneck. Neither choice changes live proof depth, silently adds parameter fitting, approves the whole notebook, or establishes hosted readiness.
