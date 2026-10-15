# City VAE: instructor direction and bounded feasibility task

Current discussion, 2026-10-15: instructor says “I like the city example better,
I think,” and proposes transforming observations to unconstrained space, encoding
and decoding there, then transforming back. This records a city preference and
authorizes investigation of that route. It does not select a final transform,
zero treatment, likelihood or complete Scope. Existing raw-Gaussian failures are
evidence for that exact older model, not a blocker against transformed models.
Do not repeat the handwriting-versus-city question while this route is assessed.

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
