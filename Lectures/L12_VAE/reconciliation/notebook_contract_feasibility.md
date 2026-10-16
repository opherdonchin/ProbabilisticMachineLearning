# L12 receiving explanation and one-hour notebook: feasibility preview

**Verdict: feasible-with-risks.** The required city reconstruction / prior-decoder-mean / full-prior-observation comparison and one supplied model-criticism diagnostic can plausibly coexist with one student fit, checked sampled loss and β/rate interpretation. This requires an explicit redistribution of the hour and a short live explanation of the supplied observation map. Assigning the enlarged encounter only the removed traversal's five minutes is not credible evidence of fit. Confidence is **medium in dependency/supply feasibility, low in the numerical time estimates**. No timed learner pilot, notebook execution or live rehearsal was performed.

This is an independent Section Design **feasibility-review**, bounded to the receiving explanation and revised handoff. It is not a section partition, student-question sequence, technical validation, approval or publication assessment. The cities preference, training-only half-minimum bicycle-zero rule and required generation/critique encounter are accepted decisions and are not reopened. The remaining transform bundle and complete Scope remain provisional.

## Exact target and evidence

Reviewed in `review/l12-notebook-contract-20261015` at input HEAD `934fb5fdd805fb5f5bc60c016fc0ebb1284c0031`. The substantive target is [lecture_scope.md](../lecture_scope.md), accepted limited handoff changes at `582ff0e`, read together with [city_transform_direction.md](city_transform_direction.md). Returned computational evidence is `3e27b86`, collected at input HEAD. Exact Git blobs at that HEAD:

| Artifact under `Lectures/L12_VAE/` | Git blob |
|---|---|
| `lecture_scope.md` | `44572fb4779bf90a5988f52a2d36630301b6a9a4` |
| `notebook_geometry/assessment.md` | `edbd1cd9f58410a0ffbb11b0a74e3bd993bd4896` |
| `notebook_geometry/probe.py` | `7d4aba642914837219c61a5fe73bb2781dde1667` |
| `notebook_geometry/results.json` | `0528089b5c41a54f48bb945f893fd4f80a5a7963` |
| `notebook_geometry/source_records.json` | `1af41bc3e23164cf8fd52b6493d5b56341c9b50a` |

Read the five-part Scope, [assessment](../notebook_geometry/assessment.md), [source-arc review](../source_arc_review.md), [baseline investigation](../scope_investigation.md), current source records and relevant probe operations; architecture/maps; L06/L09/L11 scopes; cumulative student-knowledge and timing references; Section Design/backpressure and worked-solution/teaching-notebook skills. The earlier independent [neural probe validation](../../course_architecture_scope/reconciliation/reviews/neural_probe_validation.md) supports baseline mathematics, not transformed-model learner timing. The concurrent technical review owns independent checking of the new transform/source mathematics; this review does not replay its checks or certify their results. Its reviewer separately messaged that the climate residual and probability labels need no technical change, retaining the aligned-source caveat; the persistent technical report remains the owning evidence.

The [architecture](../../../course_architecture.typ) explicitly requires practical prior generation, actual reconstruction, two fitted tradeoffs and critical assessment, while preserving the ELBO/pathwise/rate-not-MI synthesis. The [planned map](../../../curriculum_map.typ) agrees. The [actual map](../../../curriculum_map_actual.typ) records no meetings taught. Scope and probe preparation cannot establish prior learner competence.

## Entry state and the dependency that must be taught

**Assume familiar:** conditional probability, expectations, prior/likelihood/posterior reasoning, the concept of generative simulation, basic NumPy and plotting. These are supported by the cumulative [student-knowledge record](../../../.agents/skills/teaching-notebook-authoring/references/student-knowledge.md).

**Previously encountered — scaffold when needed, conditional on future delivery:** L04 supplies KL/MI and log scoring; L06 the generic ELBO identity; L09 the diagonal-Normal KL, full pathwise derivative and sampled-objective checking; L05/L11 PyTorch training, neural output roles and Gaussian scoring. These are scoped future encounters, not established independent fluency. L09 uses log standard deviation ρ; L12 uses log variance ℓ, so explicitly map `ℓ=2ρ`. Refresh `B×19` observations/decoder outputs, `B×4` encoder heads/noise, event sums before batch averaging, `exp(ℓ/2)` and gradient connectivity. Supply gradient-reset/update boilerplate. L11's two deterministic output heads are a helpful analogy, but L12 must introduce their new mean/log-variance meanings. HMC, Bayesian network-weight inference, flow training and advanced PyMC/ArviZ operations are not prerequisites.

**New in L12:** per-case amortized inference, shared encoder/decoder training, aggregate encoded distribution and its rate decomposition, distinction between reconstruction and prior generation, and this course-constructed fixed observation map. Supply the transform implementation; introduce its probabilistic meaning before students interpret outputs. If planned L06/L09/L11 encounters are cut or materially changed, return the lost prerequisite to Scope rather than converting the ten-minute refresh into first instruction.

For the receiving explanation write recorded raw data as X and the accepted zero-adjusted observations as X̃. Define `U=S(X̃)`, where S includes the fixed nonlinear transform and training-fitted centering/scaling. The model being trained is

$$
Z\sim N(0,I_4),\qquad U\mid Z\sim N(d_\theta(Z),\tfrac12 I_{19}),\qquad
q_\phi(Z\mid U)=N(\mu_\phi(U),\operatorname{diag}(e^{\ell_\phi(U)})).
$$

For one sampled z at β=1, the student loss uses

$$
\|u-d_\theta(z)\|^2+\tfrac{19}{2}\log\pi+
\tfrac12\sum_{j=1}^4(\mu_j^2+e^{\ell_j}-1-\ell_j),
$$

then averages cases. Multiplying the KL by β changes the objective; β≠1 is not the standard negative ELBO. The protected information result is
`R=I_q(U;Z)+KL(qφ(Z)||p(Z))≥I_q(U;Z)`, where `qφ(z)=E_pD qφ(z|U)` and pD is the empirical case distribution. Neither reported R nor a descriptive latent correlation estimates population MI.

The sampling transform, event-summed Gaussian NLL/KL, gradient paths and information decomposition retain their promised depths. The observation map changes the likelihood in raw coordinates, not the four-dimensional Gaussian latent family or the VAE training algorithm. Its supplied inverse is a sampling operation, not a learned flow or a second inference method.

**State/apply**, without deriving all transforms: the commuting block is a six-part composition with five independent coordinates; inverse transformation recovers adjusted observations, not recorded bicycle zeros; observation noise is added in U before inversion. One supplied worked log-coordinate illustration suffices to establish that nonlinear inversion does not commute with averaging. **State** the bookkeeping identity `log p_X̃(x|z)=log p_U(S(x)|z)+log|det DS(x)|` on the strict-interior continuous proxy. For fixed S the Jacobian has no θ/φ gradient, so students assemble the U-space objective. Do not call its score an original-unit NLL or compare different maps' standardized distortions without correction. The full Jacobian proof and source/unit archaeology remain author checks.

For focused instructor reading, the existing source inspections verify Murphy, *Probabilistic Machine Learning: Advanced Topics*, December 10, 2025 online edition, §21.2.1 **Modeling assumptions** (printed p. 792) and §21.2.2 **Model fitting** (p. 793): inspect the latent joint, recognition distribution and joint objective. These passages support the VAE argument, not the course-constructed city map. The baseline investigation and independent neural review verify Algorithm 21.1's incorrect loss sign; use the checked positive-KL course objective rather than copying that algorithm. Source inspection is inherited evidence here, not repeated primary-source validation.

This receiving explanation needs an estimated **6–10 live minutes**, conditional on the earlier foundations. This estimate is an allowance to test, not a newly approved treatment-depth obligation. It need not enumerate nineteen transforms or prove the climate formula. End eventual sections retrospectively; keep the notebook handoff separate.

## What is supplied and what students actually practise

Supply access/provenance and unit labels, accepted zero handling, fixed row mapping and split, training-fitted S/S⁻¹, batched data, model skeleton, optimizer/driver, reference value/gradient checks, verified checkpoints and all plotting/estimation/diagnostic helpers. Provide concise probability labels with the displays, rather than asking students to infer a sampling path from helper code. Keep the central sample transform and loss visible.

Students complete the Gaussian latent draw and feature/latent-event-summed loss; run the supplied value/gradient checks and correct errors; run one bounded β=1 fit; inspect expected held-out D and analytic R; compare the supplied β settings and code-use summaries; distinguish the three required outputs and use one supplied criticism diagnostic. There is no new Jacobian implementation, likelihood derivation, zero-policy optimization, second student fit, PCA fit, MI estimator or extra traversal.

For observed-city reconstruction, a supplied mean-code display can use
`S⁻¹(dθ(μφ(S(x̃))))`, explicitly labeled **backtransformed mean-code reconstruction**. It is a descriptive reconstruction, not expected D or an exact posterior-predictive mean. A q-sampled reconstruction display is also compatible, provided its actual sampling law is labeled; its implementation is supplied. Hold the chosen convention fixed across β settings.

The two prior displays should share latent draws where helpful:

$$
\text{prior decoder-mean backtransform: }S^{-1}(d_\theta(Z)),\qquad
\text{full prior observation: }S^{-1}(d_\theta(Z)+\sqrt{1/2}\,\eta),
$$

with `Z~N(0,I₄)` and independent `η~N(0,I₁₉)`. The first is a transformed-space mean mapped back, generally not `E[X̃|Z]`. The second includes observation noise. Neither starts from an observed city's encoder. The expected-q NLL estimator stays supplied and separate from all deterministic reconstruction summaries.

Use the assessment's **one climate residual diagnostic**, supplied with its definition and real-data reference:
`h=CDD−HDD−366(F−65)` in degree-days for the 2020 measures. Explain its interpretation in the given material; students inspect a prepared comparison rather than derive weather identities or implement aggregation. The assessment reports training/test residual quantiles of tens of degree-days versus thousands for full prior draws. These are source-reported descriptive results, not an independently verified theorem of physical invalidity: source aggregation already leaves a nonzero empirical residual. Pair the diagnostic with a supplied statement of the selected support constraints that the map enforces. Passing those constraints does not establish credible joint climate or city relationships. Do not turn every author-side realism statistic or bicycle sensitivity result into another student exercise; retain the zero caveat and rare-share limitation visibly.

## A within-hour allocation to test

This table allocates workload, not sections or notebook questions. All times are **planning estimates**. It preserves the existing ten-minute refresh, fifteen-minute objective work and five-minute reserve.

| Required workload | Minutes | Supply/allocation condition |
|---|---:|---|
| Supplied data/model/map orientation and PyTorch/shape refresh | 10 | Map meaning already explained live; all preparation code is given. |
| Complete sample transform and loss; run value/gradient checks | 15 | Short mathematical operations, fixed reference checks; no driver implementation. |
| One bounded fit and held-out D/R/code-use checks | 8 | Driver, per-coordinate rates and summaries supplied; verified checkpoint fallback after checked updates. |
| Required reconstruction / prior-mean / full-observation comparison | 9 | One coordinated display with matched variables/units and explicit paths. |
| One supplied model-criticism diagnostic | 7 | Climate definition/reference already given; no new coding or source analysis. |
| Supplied β/rate/pattern interpretation | 6 | One consistent comparison reuses D/R and code-use summaries; preserves rate ≠ MI and finite-fit cautions. |
| Debugging/discussion reserve and retrospective consolidation | 5 | Do not pre-allocate this to another task. |
| **Total** | **60** | **One student fit.** |

The required comparison/critique now has **16 minutes**, funded by the removed five-minute traversal, four minutes of former twelve-minute driver/summary time, and seven minutes of former thirteen-minute β/pattern handling. The latter is plausible only because the same supplied summaries serve fit interpretation and β interpretation; it does not remove the rate decomposition taught live or replace interpretation with merely running cells. If the actual Q&A needs thirteen independent minutes for β/pattern interpretation, this allocation fails and must return to Scope.

The assessment's alternative hour allocates five minutes to setup and no explicit debugging reserve. Its fast local fits support compute feasibility, but do not justify those learner assumptions. Retain a real reserve. The one-second reported fit does not measure imports, access, novice debugging or hosted runtime. If a student fit overruns, use the already permitted verified checkpoint for required interpretation after checked bounded updates, without calling those updates converged. Do not cut generation or the diagnostic.

## Material findings and owners

1. **Lecture Scope — advisory timing risk, repair before final handoff.** Part 3 retains the old allocation while acknowledging review is needed. The accepted encounter is larger than five minutes. Smallest repair: replace that allocation with an explicit feasible estimate such as the table, preserving the required outcomes and fallback. Consequence: less independent β/pattern handling and driver overhead, with helpers doing the presentation work. No new instructor choice about requiring generation is needed.

2. **Lecture Scope — advisory live-time risk.** The current estimate is 100 teaching +12 reserve =112 live minutes. Adding 6–10 minutes of map explanation gives 118–122 if everything else stays. The Scope's existing optional deterministic-AE comparison and worked sign-flip cuts save about five; that leaves 113–117 if the full reserve is retained. Smallest within-envelope proposal: take those optional cuts and explicitly use 1–5 minutes of reserve, leaving approximately **7–11 minutes** reserve within 112. Preserve the identification caution, normalization example, joint-gradient application and derived rate identity. This is proposed arithmetic, not measured feasibility or authority to silently change Scope. If rehearsal needs more, return a concrete Scope tradeoff; do not invent a required recording.

3. **Section Design / notebook pedagogy — downstream-owned dependency and labeling risk.** The explanation is constructible with the supplied-map contract above, but original Scope formulas and raw-support cautions still describe the older baseline. After remaining transform acceptance, the Scope owner must make the adopted coordinate convention consistent before downstream authoring. Student entry, path labels, score meanings and the single diagnostic can then be organized downstream. Do not require nineteen transform derivations or treat code-use and realism diagnostics as interchangeable.

4. **Worked-solution / notebook / publication owners — downstream-owned readiness gates.** Prepare and verify actual checkpoints/plots, local reference checks and complete inverse-map sampling; scaffold APIs against the target environment; build solved Q&A and generate the student version; validate clean local uv and fresh hosted Colab; settle source packaging and conduct a learner timing trial. Source labels (including the unresolved GDP indicator units) and residual meaning are author correctness tasks, not requests for instructor mathematical approval. This preview neither blocks those authorized checks nor claims they passed.

## Instructor-owned decisions and handoff

**No new instructor question is forced by this bounded review.** City preference, the zero convention and required generation/critique have already been decided. Final adoption of the remaining fixed-transform model and complete Scope is an existing Scope decision; the coordinator should present the explicit live/lab allocation and its reduced reserve with that decision. The proposed minimum repairs do not require a new model, student derivation, extra fit or weakened ELBO/pathwise/rate-not-MI commitment.

Next owner: coordinator/Scope records the adopted model and allocation; later Section Design resolves receiving boundaries and tests the live explanation, and notebook authors test the supplied-work assumptions. If either fails in execution, return specific backpressure to its owner. This preview is complete without sections, slides, code or learner approval.
