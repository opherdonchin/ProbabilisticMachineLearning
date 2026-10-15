# City VAE: instructor direction and bounded feasibility task

Current discussion, 2026-10-15: instructor says “I like the city example better,
I think,” and proposes transforming observations to unconstrained space, encoding
and decoding there, then transforming back. This records a city preference and
authorizes investigation of that route. It does not select a final transform,
likelihood or complete Scope. The zero rule is subsequently accepted below.
Existing raw-Gaussian failures are
evidence for that exact older model, not a blocker against transformed models.
Do not repeat the handwriting-versus-city question while this route is assessed.

## Accepted zero replacement — 2026-10-15

Instructor's exact response to the concrete half-minimum proposal: “This sounds
prefect. Let's go with it.” Accepted rule: compute half the smallest strictly
positive bicycle fraction **in the training split only**. For the current fixed
data/split, minimum is `0.000187758167480285`, so
`delta = 0.0000938790837401425` (about 0.00939 percentage point). Reuse that fixed
training-derived value for any recorded bicycle zeros in validation/test;
do not recalculate from held-out data. Here one zero is in training, the other
in validation, and none in test. For each affected row set the zero part to delta
and multiply every other commuting part, including residual, by `1-delta`.
This preserves closure and positive-part ratios, without dropping rows.

The factor one-half is an agreed preprocessing convention, not an estimate of
true cycling prevalence. Survey margins establish uncertainty, not that exact
replacement. Log-ratio inversion recovers the adjusted composition. No structural
zero model, whole-Scope approval, acceptance of all other proposed transforms,
student notebook/publication approval or source-data mutation follows. The older
probe's fixed `1e-5` was exploratory; use this accepted rule for its continuation.

## Required generation and critique — accepted 2026-10-15

Instructor selected “Require generation and critique; replace the extra traversal
(recommended)” in the current discussion. Required notebook encounter: compare
reconstruction of observed cities, decoder means from prior latent draws, and
full prior-generated observations including observation noise and the complete
inverse observation map. Include one supplied model-criticism diagnostic, with
support compliance distinguished from plausible joint city relationships.
Replace the optional extra latent traversal; do not append a second student fit
or a new likelihood/Jacobian implementation exercise. The one-hour envelope and
accepted ELBO/pathwise/rate-not-MI commitments remain. Exact activity allocation
still needs feasibility review; this acceptance is not measured learner time,
approval of every transform, whole-Scope acceptance or publication permission.
L12-GENERATIVE-ENDPOINT is resolved; do not re-ask it.

## Bounded receiving-workload preview

Owner `/root/l12_notebook_preview`, Section Design / feasibility-review, separate
isolated `review/l12-notebook-contract-20261015` worktree
`/tmp/pml-l12-notebook-contract-review-20261015`. Base will be the committed
accepted scope and returned zero-rule validation revision, recorded before launch.
Exact sole write: `Lectures/L12_VAE/reconciliation/notebook_contract_feasibility.md`.
All other branches/inputs are read-only; reviewer is not alone and must not
revert peers, change the Scope or author sections/slides/notebook questions/code.

Read the current five-part scope with its limited accepted changes, source/actual
student-knowledge/timing records, and current computational assessment. Check
whether the receiving explanation and required one-hour encounter can coexist
with the live intellectual contract. Identify student-written versus supplied
work, prerequisite refresh, protected comparison/critique and funding from the
removed traversal. Distinguish conditional later-course prerequisites and rough
time estimates from actual learner evidence. Offer smallest allocation/supply
repairs; do not silently weaken required mathematics or add full derivations.
Return feasible/with-risks/blocked, exact target revision, owning severity and
minimum repair, remaining gates and only genuine instructor decisions. This is
a bounded preview, not full Section Design, independent technical validation,
notebook production, approval or a timed pilot. Source/math/runtime checks and
other course work can continue independently.

## Returned zero-rule validation and technical review

Collected `3e27b86`: only notebook_geometry/assessment.md, probe.py and
results.json changed. Exact half-minimum, train-only derivation, compositional
adjustment, finite coordinates, roundtrip and full-generation support checks
passed. Sensitivity did affect rare bicycle reconstructions, despite preserving
the broad beta/rate tradeoff. Those are limitations to report, not another
request for the instructor to choose a numerical epsilon. The report owns raw
findings; no whole model or learner readiness is approved.

Independent technical reviewer `/root/l12_transform_review`, isolated branch
`review/l12-transform-20261015`, worktree `/tmp/pml-l12-transform-review-20261015`.
Input: exact `3e27b86` probe/assessment/source records, accepted scope at `582ff0e`.
Sole writable artifact: `Lectures/L12_VAE/reconciliation/transform_technical_review.md`.
Review actual variable semantics and triangular/logratio transformations,
Jacobian/scaler, zero replacement and no-leak provenance, roundtrip target,
distribution labels, reference score comparability, sensitivity and limitations.
Selectively replay independent checks in /tmp with the existing locked interpreter;
do not repeat every fit, search variants, alter inputs or approve model/Scope.
Read relevant existing specialist instructions; worker is not alone and may not
revert peers, touch shared artifacts or spawn more agents. Return exact checked
revisions, independence, feasible/with-risks/blocked, owner/severity/evidence and
smallest repair. Any source corrections remain author work. This review can run
beside the receiving-workload preview; neither blocks unrelated course work.

## Zero-rule validation follow-up

Owner `/root/l12_city_transform`, current branch/worktree verified clean at
`0c621d3` before recording this answer; launch base is the next decision commit.
Mode worked-solution revision / teacher-only validation using the existing skills.
Exact allowed writes remain `Lectures/L12_VAE/notebook_geometry/`; coordinator
alone owns this decision, scope notice, old question pointer and course index.
Worker is not alone and must not revert or edit any other owner/input/shared file.

Implement the accepted training-derived rule in the current reproducible probe
and report; regenerate affected current results rather than leaving obsolete
nominal-policy outputs beside updated code. Preserve original raw evidence through
its committed input revision. Reuse baseline evidence where practical; no model,
data, split, architecture or broader transform search. Check value/data provenance,
closure, positive-part ratios, roundtrip to adjusted data, finite log-ratios,
and affected fit/reconstruction behavior. Evaluate the accepted value and a small
declared sensitivity around it; explicitly inspect bicycle reconstructions for
the two affected rows, not just aggregate loss/rate. Do not select delta by score.
Retain honest observation-noise versus mean-backtransform labels, source GDP and
joint climate limitations, and local-only/estimated-time status. Return exact
diff/input revisions, numeric findings and any actual blocker or teaching issue.
This validation is unblocked; final pedagogical authoring and shared adoption
retain their existing gates. No new instructor permission is needed for checks.

Source base `61f113e`, exact data/version and baseline model are in existing
scope_investigation.md and notebook_feasibility/probe.py. Preserve live VAE/ELBO,
Gaussian latent inference and unrelated commitments. A fixed observation map
U=T(X), Gaussian decoder on U, and inverse-map generation can retain the current
VAE training structure. This is distinct from simply transforming decoder means
and adding unconstrained noise in original units.

## Bounded task and ownership

Stage: Lecture Scope revision / worked-solution computational feasibility;
teacher-only probes, no student notebook/slides or final scope rewrite.
Owner `/root/l12_city_transform`, same isolated branch/worktree
`investigate/l12-city-transform-20261015`, `/tmp/pml-l12-city-transform-20261015`.
Base: commit containing this envelope, resolved before launch. Exact allowed
write prefix: `Lectures/L12_VAE/notebook_geometry/`. Coordinator alone owns this
record, the scope notice and old question's resolution pointer. Worker is not
alone; do not revert others or edit existing inputs, shared skills/API/maps/env.

Use lecture-scope and worked-solution-authoring skills, architecture, current
scope/investigation/probe/source-unit evidence and student-knowledge/timing refs.
Task: assess one transparent fixed-transform pipeline, validate its mathematics,
and execute a compact VAE comparison if a defensible zero policy can be labelled.
No unrelated dataset/architecture search. Existing pinned data, train/validation/
test split, Gaussian latent q, small CPU model and original seed/config should
be reused where they isolate the transform's effect. At most a small explicit
zero-policy sensitivity, not hidden data pruning/clipping or a winner search.

Audit each actual variable's units/support from primary sources. For strictly
positive variables consider log (shift for a verified nonzero lower bound);
bounded fractions logit; five selected commuting shares plus a residual category
form a six-part composition with five unconstrained log-ratios. In inspected
349 rows the five-share sum spans .92713268–.99745821, so residual is positive;
bicycle share is exactly zero in two rows. Do not silently replace zeros or call
an altered observation an exact invertible transform. Investigate recorded-zero
meaning and distinguish continuous approximation/explicit replacement from a
boundary-mass or censored model. No need to ask instructor about routine numeric
correctness; return a teaching decision only if materially different routes remain.

Validate forward/inverse, joint support of full inverse-transformed observation
draws, dimensions, Jacobian/density bookkeeping and stable implementation.
For fixed T the raw density is p_X(x|z)=p_U(T(x)|z)|det DT(x)|; its Jacobian
term is constant with respect to trainable parameters, but required for raw-unit
density comparisons. Include train-fitted standardization in bookkeeping.
Report reconstruction/query changes, latent rate, real-data generation summaries,
remaining implausible joint patterns, runtime and the student-written/supplied
work implied. Geometric support alone does not establish useful generation.

Use the locked existing `/tmp/pml-l04-l12-reconciliation/.venv/bin/python`
read-only, caches/scratch in /tmp, no dependency/lock writes. Browse primary
sources for transform/data claims. Return reproducible code/raw compact results,
exact source hashes, focused recommendation and genuine open issues, with proposed
one-hour workload labelled estimate. No learner/Colab/publication claim, scope
approval, final dataset substitution, merges or shared-skill promotion. Stop after
this bounded route; source/technical uncertainty is not automatic instructor hold.
