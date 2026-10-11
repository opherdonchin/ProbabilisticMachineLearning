# Whole-course review: explanation for the instructor

This coordinator-written reading guide explains the independent report preserved verbatim below. The reviewer was a separate agent who had not built or individually reviewed the ten lectures. It first read the course without the coordinator's defense, then compared the other review evidence.

The original conclusion was that the course could fit its declared upper time budgets, with risks. It found no essential missing prerequisite or accidentally repeated full proof. It did not claim that lectures had been rehearsed or notebooks tested.

The main concerns are understandable without the book. Students need substantial supplied code to keep each notebook within an hour. Lecture time is tight and still estimated. The controlled examples lose MRI, forecasting and economic-data applications. The final mobility model describes patterns but does not establish causes. Its reconstruction comparisons must average over the inferred hidden distribution rather than merely decode its mean. Finally, the records must say which exact proposal was checked and distinguish agent review from instructor acceptance.

The report below checked the earlier five-bit L04 example. The instructor has now selected three-bit parity instead, and asked for a plain-language rewrite of all documents. Current revision evidence is listed in [STATUS](../STATUS.md); old example claims are not current promises. The technical record is retained to make the original review reproducible, not to require the instructor to understand every algorithm name before making a decision.

## Original independent report and final check of the earlier proposal

# Independent adversarial whole-course feasibility review

**Reviewer:** Lecture Scope specialist, actual thread `/root/course_adversary`, a fresh thread which did not build or individually review L03–L12. **Mode:** feasibility-review, bounded to the whole-course proposal; sole write ownership is this report. **Date:** 2026-10-11. **Target branch:** `scope-l03-l12-course-architecture`. **Checkpoint inspected:** `39ba5b50a40fa2af6dbc50ba69a059d637aa990d`. **Final verdict:** `feasible-with-risks`, unchanged from the cold pass; no demonstrated architectural blocker. This is review evidence, not agent approval or instructor approval.

## Cold-pass boundary

Initial findings below were formed from all ten frozen scopes, the factual `/tmp/course_coverage_for_review.md` table/graph/budgets, WORK_ORDER, canonical scope/backpressure/timing and notebook skills, protected actual L01 deck/missing-data solution, agreed L02 sections, ledger and direct textbook/application-source checks. The coordinator's architecture reconciliation and individual raw reviews were not read before these findings. The factual source-inspection register was consulted at the source-verification end of this pass; its source cautions are not treated as independent evidence where the actual passage/code was available. Post-reconciliation findings will be identified separately below.

The old future ledger/syllabus allocations are inputs awaiting phase-6 synchronization. Their greater breadth is not a reason to force content back into the course. The protected L01 delivered boundary and L02 commitments are the actual starting boundary; L02 is agreed rather than delivered.

## Exact frozen inputs

Git object IDs below are current file-content blobs, not just a common HEAD label. Final `git hash-object` checks matched every before blob; the reviewer changed no scope.

| Scope path under `Lectures/` | Before Git blob | After Git blob |
|---|---|---|
| `L03_Graphical_Models/lecture_scope.md` | `f4dab507f90618362c2e04c1c3791c8139f7de56` | `f4dab507f90618362c2e04c1c3791c8139f7de56` |
| `L04_Information_Theory/lecture_scope.md` | `242ee28d251d583004daa25379b6a0f8cb44d622` | `242ee28d251d583004daa25379b6a0f8cb44d622` |
| `L05_GLM_Optimization/lecture_scope.md` | `736943b90f24826e29955115896929742f2961f5` | `736943b90f24826e29955115896929742f2961f5` |
| `L06_EM/lecture_scope.md` | `326267281c6b6775ac9a33d7ed4f022a859fc49b` | `326267281c6b6775ac9a33d7ed4f022a859fc49b` |
| `L07_Inference/lecture_scope.md` | `f12fba8de7339675d09a771c5f956c8ed93649d8` | `f12fba8de7339675d09a771c5f956c8ed93649d8` |
| `L08_Structured_Inference/lecture_scope.md` | `b7a2de325c364bcde8230c33aaba2a5cd6b8596a` | `b7a2de325c364bcde8230c33aaba2a5cd6b8596a` |
| `L09_Variational_Inference/lecture_scope.md` | `b6b98a1a0027e710c18aa596b79ac04ef7af248f` | `b6b98a1a0027e710c18aa596b79ac04ef7af248f` |
| `L10_MCMC/lecture_scope.md` | `9503b32aef49e7090792ea7e38d3acfb808a973b` | `9503b32aef49e7090792ea7e38d3acfb808a973b` |
| `L11_Neural_Prediction/lecture_scope.md` | `0c564a7e5b1fd308282ab2ea6488927a44bc890a` | `0c564a7e5b1fd308282ab2ea6488927a44bc890a` |
| `L12_VAE/lecture_scope.md` | `fe07f77461bbded7e6a17be6050b204133994072` | `fe07f77461bbded7e6a17be6050b204133994072` |

## Initial cold findings

### C1. L12 must separate its distortion estimator from mean-code reconstruction

**Owner/severity:** L12 Scope for the metric promise; Worked Solution/Notebook Authoring for implementation. **Advisory, consequential correctness guardrail**, not a blocker in the current mathematics.

**Evidence:** The spine correctly defines `D = E_pD E_q[-log p_theta(X|Z)]`, and the training discussion correctly calls a single reparameterized draw an unbiased reconstruction estimate. The lab, however, promises held-out “reconstruction/rate summaries” and a supplied beta comparison without explicitly fixing the evaluation estimator; decoder-mean plots/traversals are also allowed. Source PS4 notebook cells 10–11 decode fixed latent codes and label profiles as observations. For nonlinear decoders, reconstruction at the encoder mean is not the expected-q distortion: at `x=0`, `Z~N(0,1)`, decoder mean `d(z)=z²`, expected squared residual is 3, while squared error at `d(EZ)` is 0. This difference survives perfect event normalization.

**Smallest repair/provisional treatment:** Require prepared beta summaries to report held-out expected-q event-summed NLL (a supplied fixed multi-draw Monte Carlo estimator with uncertainty/repeatability check is enough) and average per-case prior KL under identical split, transforms, decoder variance and units. Label deterministic mean-code reconstruction as a separate descriptive score/profile. Continue scope development with this explicit handoff; no additional student implementation is needed.

**Downstream consequence:** Supplies the metric for the existing 13-minute comparison block and prevents a plot of deterministic reconstruction error versus rate being advertised as the promised D–R comparison. No core derivation, lecture order or endpoint changes. Instructor decision only if the intended practical endpoint is narrowed to deterministic reconstruction alone.

### C2. The labs are feasible as controlled mathematical practice, conditional on substantial supplied infrastructure

**Owner/severity:** Coordinator for course-wide skill promises; Notebook Authoring for supplied-versus-student boundaries. **Advisory**, greatest risk L05, then L08/L09/L12.

**Evidence:** L05 is first PyTorch use: 12 minutes of tensor/target orientation, 10 gradient checking, 15 training cycle, 12 evaluation, 6 optional comparison and 5 reserve. L09 budgets a 10-minute refresh after three NumPy/SciPy labs; L11 and L12 reuse that practice with wrappers/driver/checkpoints supplied. L08 implements two indexed recurrences plus scaling/oracle checks in 60 minutes. Most labs have only five minutes of reserve and include mathematical debugging. First exposure does not establish independent fluency under the canonical student-knowledge skill. The actual L01 solution likewise supplies substantial plotting/inference setup; scaffolded work is course-consistent, but not equivalent to writing a general inference/training pipeline.

**Smallest repair/provisional treatment:** Carry the scopes' supplied utilities, drivers, local gradient/reference checks and prepared comparison fits as binding authoring requirements. Keep optional batch-size reruns, CAVI numerical sweep, extra seeds/traversals out of required completion. Pilot L05 onboarding before promoting any PyTorch idiom to familiar; preserve the later refresh allowances. Formal promises should say implement the central calculation in a supplied workflow, rather than build every solver/model from scratch.

**Downstream consequence:** No new ecosystem or extra implementation is needed; additional scaffolding can solve normal authoring pressure. A lab that secretly requires preprocessing, generic model classes, multiple full fits, new diagnostic APIs or full driver construction would invalidate the corresponding scope feasibility. Lack of current notebook execution alone does not.

### C3. Live estimates leave credible but small margins; their first cuts are essential options

**Owner/severity:** Scope owners for depths/time; Section Design for constructing within them. **Advisory**, most pressure L05 and L10; L08/L09/L12 also tight.

**Evidence:** Inclusive plans are 110–115 minutes, not measured durations. L05 combines conditional-family/link semantics, scalar likelihood gradient, a short vector residual calculation, complete reverse-mode graph and minibatch expectation. L10 adds previously untaught stationarity/conditions before MH validity, Gibbs cancellation and dependent estimator variance. L08 has forward/backward/scaling before a 14-minute Gaussian filtering application. L09's 31-minute total pathwise derivative and L12's 23-minute rate identity require interpretation as well as algebra. The provisional slide formula is calibrated to L01 itself and cannot establish rates for these new concepts.

**Smallest repair/provisional treatment:** Use the declared first cuts if construction exposes overload: L05 optional penalty/noncanonical numerical/repeated family work; L10 optional numerical planning/proposal/NUTS elaboration; L08 optional Viterbi mechanics; L09 numerical CAVI sweep; L12 AE/sign-flip extras. Preserve the load-bearing calculations. A 100-minute delivered window is a tighter constraint than the nominal 110–115-minute plans and must trigger Scope backpressure, not faster speaking or use of reserve as content.

**Downstream consequence:** Scope-stage feasibility remains plausible within the upper part of the authorized 100–120 window; no rehearsal claim. Two or more missed upstream core skills would need a coordinated reallocation rather than repeated unbudgeted backfill. Retrospective section endings and separate notebook handoffs remain required.

### C4. Controlled examples preserve method outcomes but sacrifice several domain applications

**Owner/severity:** Coordinator/Scope and instructor for practical-outcome identity. **Advisory; visible human decision required where WORK_ORDER protects a major endorsed outcome.**

**Evidence:** L06 chooses missing-Gaussian EM instead of MRI segmentation; L08 chooses HMM inference rather than website-session Kalman forecasting/system identification; L09 chooses known-noise synthetic regression rather than the source's GDP/unknown-noise model; L11 is synthetic conditional-noise regression; L12 retains real mobility context but approximates transformed standardized mixed-domain features by a fixed-covariance Gaussian. This achieves checked EM, messages, stochastic VI, MH, probability-head and joint VAE learning. It does not jointly achieve the discarded empirical applications or a support-respecting scientific mobility generator. The scopes acknowledge these losses explicitly.

**Smallest repair/provisional treatment:** Keep these choices reversible and visible in the human questions and synchronized formal promises. In particular, do not claim both HMM implementation and real forecasting in L08, or MRI processing in L06. Adding the discarded application should displace core/lab work through its owning Scope, not become an extra hour of hidden work.

**Downstream consequence:** The current methods course is feasible; a requirement to deliver all prior candidate applications would change that verdict. Mobility permission/portable access must be resolved before publication; changing the dataset is a reviewed Scope choice, not silent implementation freedom.

### C5. Version/status metadata must distinguish frozen proposal text from actual review/approval evidence

**Owner/severity:** Coordinator, plus nearest Scope owner if cross-reference text is repaired. **Advisory provenance repair.**

**Evidence:** All ten Scope headers still say review/global reconciliation pending. L11 cites L09 blob `a8080351116f51a34eddd3e5dc06d65f7025722e`, whereas this pass inspects `b6b98a1a0027e710c18aa596b79ac04ef7af248f`. Other builder-input hashes accurately describe earlier inspected contracts, not necessarily the final frozen cross-course contract. Pending builder headers alone cannot prove that later reviews did or did not run.

**Smallest repair/provisional treatment:** Final STATUS should bind approval to exact substantive blobs and actual reviewer identities; distinguish build-input provenance from current handoff references. If headers/cross-references are updated, record new blobs without pretending that substantive review targeted those new metadata hashes. Do not silently inherit L02's malformed development-state register as fresh approval evidence.

**Downstream consequence:** No intellectual change; prevents misleading self-approval and stale upstream contracts during resumption. The adversarial report itself cannot approve scopes.

## Cold negative tests and source checks

- **Foundations/order:** No load-bearing backward dependency found. L02 owns EF moments/categorical and observed Markov learning; L03 factors/conditionals; L04 finite KL/MI; L05 AD/finite-sum SGD; L06 generic bound; L07 curvature/grid; L08 messages; L09 parameter-dependent expectation; L10 stationarity/error; L11 nonlinear likelihood; L12 amortization/information-rate. Operational sample averages before L10 are valid with rigorous probability background and do not require MCMC theory. L09 has no pre-L10 HMC obligation. L12's encoder construction is new locally and not silently presumed from L11.
- **Duplicate derivations:** The generic bound is primary L06 and recalled L09/L12. Full reverse-mode traversal is primary L05, bounded local reuse L11/L12. Pathwise total derivative is primary L09, applied L12. Diagonal Normal KL is applied once with corrected sign/constants. Repeated Gaussian/NLL/factor expressions support new queries rather than duplicate full proofs. CAVI versus coordinate MAP versus Gibbs remain distinct operations.
- **Terminology/units:** L03 positivity and entailment-versus-faithfulness, ICM versus marginal/joint MAP; L04 message-block error versus information versus code rate and bits; L07 quadrature mass versus density, coordinate-dependent MAP and local curvature; L08 backward likelihood versus belief and path versus pointwise decisions; L10 invariance versus convergence/mixing, target uncertainty versus MCSE are all properly qualified. Later losses use nats. L11 SD/variance, softplus floor, fixed-weight observation intervals and posterior-weight uncertainty are explicitly separated.
- **L09 scaling:** Current Scope explicitly requires full-data summed likelihood and one global prior KL. A mean full-data NLL implementation must divide that KL by N too (or multiply mean likelihood by N). Sample averaging over latent draws is a separate axis. Do not replace the stipulated objective by mean likelihood plus unscaled prior KL; that would temper the posterior. The current contract itself is correct.
- **L12 scaling:** At `tau²=1/2`, event-summed squared residual plus `d/2 log(pi)` is the stated Gaussian NLL. Independent PS4 code inspection confirms source feature-MSE mean plus latent-KL mean; source beta 4 becomes coefficient 19 after multiplying by d=19 and k=4. Fresh course-beta checkpoints are required. Rate equals MI plus aggregate mismatch, not MI. The scope avoids empirical point-mass-to-continuous-density KL and does not guarantee causal/disentangled factors.
- **Coverage:** Chapters 4–12, 15–16 and 21 have central selected concepts owned or explicitly omitted; generalized graph algorithms, full optimizer/estimator catalogues, transformed/structured VI families, full HMC, architecture zoo and VAE extensions are deliberate breadth cuts. Chapter 13 SMC and §§6.6–6.9 are explicitly omitted. No missing concept identified here requires another lecture. L12 supplies Murphy's selected variational D/R formulation; a classical Shannon-optimal rate-distortion theorem is not promised or needed for its endpoint.
- **Independent mathematical spot checks:** Standard-library rational enumeration verified L03 four-cycle counts `2/12/2`; L04 4×32 channel normalization, both posteriors, MI `1.1234293566` and exact optimal block error `693/3125`; L08 eight-path evidence `589/5000`, all smoothed marginals and unique path mode `000`; L06 tiny updated covariance determinant `53/54`; L09 minimum diagonal KL `0.5108256238`; L12 NLL and source-beta conversion. These are mathematical spot checks, not complete validation of every numerical value, notebooks, teaching time or production.

## Post-evidence reconciliation check

Read the full current `architecture_audit.md`, all ten raw individual reviews including L09's targeted addendum, and STATUS after persisting the initial cold critique. Their assessments were compared with the actual frozen scopes and the independent checks above. The reconciliation is substantively credible, with the following precise dispositions:

| Cold finding | Post-evidence result | Required next treatment |
|---|---|---|
| C1 expected-q distortion | Independently also raised in L12 raw review concern 2, including correct count-weighted held-out averaging. This is not a newly discovered blocker. The audit's cross-lecture safeguards cover event normalization but do not explicitly carry the estimator/profile distinction. | Carry that raw-review requirement into the final notebook audit/authoring handoff. Prepared D/R summaries use expected-q NLL and count-weighted observation averages; mean-code plots remain separately labeled. No compulsory Scope depth change or second student fit. |
| C2 supplied lab infrastructure | Local reviews challenge exactly these hidden-load boundaries; audit explicitly admits helpers/checkpoints/ports are future production work, not existing validated artifacts. Refresh is included in the later hour budgets. | Preserve the division of labor in formal skill promises and later worked solutions. No full source-notebook replication, new stack or extra independent solver construction. Pilot first-library and recurrence/stochastic-objective cores. |
| C3 tight live windows | All individual previews preserve estimated rather than measured timing; audit sums inclusive live time as 1117 minutes, of which 120 is reserve. It does not treat optional/recording candidates as free time. | Apply local first-cut options only when actually present in drafted content. In particular, removing an optional lab rerun already outside the 60-minute core creates no core margin. Return actual core overruns to Scope. |
| C4 lost domain outcomes | Audit explicitly lists MRI, forecasting, GDP, standalone regularized/count labs, BNN and calibration losses; L06/L08/L09 reviews retain these choices as questions rather than pretending all outcomes survive. | Formal synchronization and the human report must retain those losses and alternatives. The current model/algorithm outcomes survive; empirical-domain breadth is a deliberate tradeoff, not a hidden promise. |
| C5 exact status/versions | STATUS binds exact current scopes/reviews and distinguishes agent approval from instructor approval and pending global gate. L09 targeted addendum checks the single HMC-depth row change; L11 reviewer compares both L09 blobs and confirms unchanged relevant prerequisite content. The apparent stale handoff is resolved substantively. | Finalize pending builder headers/current handoff references as metadata with transparent new hash mapping; no substantive re-review required for that correction alone. Do not erase original review targets. |

Further raw-review safeguards remain valid and should survive synchronization: L08's symmetric live oracle cannot catch `A` versus `Aᵀ`, so its supplied harness needs an asymmetric-transition enumeration assertion; exact-zero support and floating-point underflow are distinct. L09's finite-draw analytic/autograd check must compare the actual sampled-likelihood-minus-analytic-prior-KL estimator at identical epsilon, rather than a different finite-draw log-joint-plus-entropy estimator or a population gradient. L11's supplied fixed-scale baseline must share the split/scaling and use training data for residual variance; test data cannot select an early-stopped run. L12 source-beta normalization must be rebuilt with fresh course checkpoints. These are downstream-owned checks within already supplied infrastructure; none adds another core lecture derivation or student implementation.

The source-ownership matrix matches actual scope depths rather than using rows to hide extra required mathematics. No substantive HMC proof is left assigned to L10 or debt to L11/L12. General tree/loopy graph inference, smoothing extensions, full transformed/general VI, optimizer catalogues, modern architectures and generative alternatives remain explicit omissions. The audit's Gaussian reuse rationale agrees with the independent query-by-query cold reading. No scope is merely an all-review meeting: each introduces a mathematical operation or model capability absent from its actual prerequisites.

No consequential scope repair is demanded by this whole-course pass. Minimum final repairs are the metric/harness/gradient/baseline handoff requirements above, precise provenance finalization, and honest formal promises. The coordinator owns disposition and any agent-approval decision. Remaining instructor-owned choices concern practical application identity/breadth, fixed-Gaussian mobility interpretation and access, and how much slack the actual live/lab windows allow.

## Exact provenance and direct-source limits

The protected current blobs are L01 deck `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`, L01 solution `ab441941c8b526151a927bfbcf292bd9bc629ce5`, and L02 agreed sections `bbf78a13db05224a839d0b2f8bda4c7a5bd0c764`. They were read and left unchanged. The factual coverage extract SHA256 is `4d92171de9e1a2bca2aca3c514150f75786184d1e6080841b69f9aa0a00ae91d`.

Post-evidence audit blob: `e529161487b8a11e956ddf5e7a207aea1e7cd94a`; STATUS blob: `0d84452c635fd82b2b9e543b2479fcd0dcd79b47`. Raw review blobs actually read:

| Review | Git blob |
|---|---|
| L03 | `d1935f9d91363357c932deabc46788225f587a5a` |
| L04 | `45e733979a2e29e50182f2ee8205cf4b158d4194` |
| L05 | `de0ba605f50bc1997eba1cf98738e7e36ac4be40` |
| L06 | `206d3a72ea2d7f3f8406b429f1a485d157019b61` |
| L07 | `71cb04ec9c9b9c65acb3254620f4792b4e03498b` |
| L08 | `ccdb82afd3899c3bdeb974cdaaf6c3a119169aab` |
| L09 including targeted check | `240e3f31d1d156804c06c835ba7129c13183d472` |
| L10 | `681b5d1d2c85cecd41b21e06bb2a53949684a276` |
| L11 | `455baa985337507aa54b69be9f047766a92b1968` |
| L12 | `3bf9b82a83c6ae8ca7f25ec6ddaeb45a06b6b354` |

Direct textbook inspection used `/tmp/pml-book2.txt` (SHA256 `1d77150146caf0f7e44b88b20370292abe5b6bfc506ce92fe26509a7bdb131b6`) and `/tmp/pml-book1.txt` (SHA256 `69291936872f6ced92a874015ed7b2d0d27962307bf84da5c5ca9b0fa2c9eb20`). Cold source checks included actual B2 §5.4.2 D/R and beta expressions, §21.2.4 aggregate posterior, §21.3.1 objective/interpretation, and §10.2.1.1 defective sign/constant; their correct replacement formulas were checked algebraically. Additional post-evidence checks inspected actual B2 §§4.3.1/4.3.6 positivity, potentials, energy and graphical-CI wording; §6.5.3 ELBO/tightness/M-step; §9.2.6.2 erroneous unique-path-versus-marginal claim; §15.1.3 sign and overstrong MLE uniqueness prose; and B1 §13.2.4.4's variance-head/noise-law wording. The scope's corrections are mathematically defensible. No claim that this reviewer independently rendered exact PDF figures/pages or checked every chapter sentence is made. Broader passage/figure checks by individual reviewers remain their attributed evidence, not silently claimed as this thread's own work.

The actual local Oke PS4 `vae.ipynb` code was independently inspected for scaling, transform, loss, reparameterization, plots and decoded-mean sampling claims; model dimensions and source beta match the frozen L12 contract. Local source paths are inspection provenance, not course runtime dependencies. Pyprobml/Batra/Berkeley model references were assessed through the scope/raw-review source contracts; this whole-course pass did not rerun or independently parse all of those reference notebooks. Their availability and stored outputs are not claimed as validation. Mathematical enumeration was a scratch standard-library check only, with no persisted course implementation.

## Validation limits and verdict-change conditions

Scope-stage confidence is moderate. The report does not construct sections/slides, implement/run the proposed labs, inspect Colab behavior, certify sources' embedded outputs, approve pedagogical choices, merge or publish. Unexecuted references are application/method precedents only. Precise downstream geometry, optimizer settings, random seeds and student task granularity remain authoring-owned. Existing scope formulas suffice to assess prerequisites; missing production is not a scope blocker.

The verdict would become **blocked** if a binding contract required all discarded domain applications, multiple full independent implementations/fits in the same hour, required new stacks, repeated derivations/backfill outside reserve, or deterministic reconstruction advertised as expected-q distortion without correction. It would become **feasible** with stronger timing/workload evidence and the metric/provenance repairs above; such evidence remains later-stage work, not a demand to build notebooks in this review.


---

## Independent final synchronization verification — 2026-10-11

**Reviewer/thread:** the same independent Lecture Scope feasibility reviewer, `/root/course_adversary`; bounded final synchronization check dispatched by coordinator `/root`. **Branch/HEAD at inspection:** `scope-l03-l12-course-architecture`, `3fae81a7512792a3c59be3990a030ae7054f7ec8`. This append-only addendum preserves every byte of the initial report (Git blob `fc653399c06bba5773ecee62464626f646a3d8a9`), including its cold targets and limitations. No new whole-course pedagogical build or review loop was performed.

**Final synchronized-proposal verdict: `feasible-with-risks`; no unresolved synchronization or architectural blocker found.** The original substantive feasibility assessment still applies. C1 is now explicitly repaired in the owning L12 Scope and independently targeted-rechecked. C2–C4 remain stated constraints and instructor-owned choices; C5 has an exact old-to-current revision map. This is review evidence, not this reviewer's agent approval or instructor acceptance.

### Final exact scope identities and change classification

Each scope's current working-file Git blob was checked before and after this review and remained unchanged. Diffs against the original cold-pass revisions were independently inspected; the following classification is not inferred from STATUS alone.

| Scope | Final blob, identical before/after this check | Difference from cold-pass target |
|---|---|---|
| L03 | `f4ab82808c1cc6b4b32c38588c6c2e969483b036` | Status/next-owner metadata and review-pending wording only |
| L04 | `6b008770631926f61e51d838a126651c2200466e` | Status metadata and historical committed URL for deleted preliminary input only |
| L05 | `6f7200e2383a2136687fe03cbb8b35b67f76d696` | Status/next-owner metadata only |
| L06 | `c29aefd80dbd192a6a4da4b79e5e299df343875a` | Status/next-owner metadata only |
| L07 | `80eacfd8c3e7e3bb4eb00d9bb23ccdb1c2ddcb0a` | Status/next-owner metadata only |
| L08 | `4ae9853bf48899edeab65a1c2b503dfad0c1f990` | Status/next-owner metadata only |
| L09 | `7072832dfbf350454d66a0440abea8201bf530e0` | Status/next-owner metadata only since the already reviewed `b6b98a1…` HMC repair |
| L10 | `55359f7aeeeb5eb838915386ca5222981f8236c5` | Status/next-owner metadata only |
| L11 | `c9c3298efa4e11a0baedaa6bd06d72aba64ee86d` | Status/next-owner/review-evidence metadata only |
| L12 | `ae38514fa2daf5502c411a3c5528cfa6a2becbdc` | Author's C1 scoring paragraph plus status/next-owner metadata only |

The L12 author repair at blob `e2dcff939358ac4321c9ee5859f919ece1e4b488`, committed at the inspected HEAD, adds only the event-summed expected-q NLL/count-weighted scoring paragraph. The final L12 targeted addendum was read at review blob `e6beff2e2c81fd87b646288a568c4f9a09d3b896`; its original raw-review prefix is byte-identical to `3bf9b82a83c6ae8ca7f25ec6ddaeb45a06b6b354`. No mathematical depth, model/data contract, required fit count, dependency or live/lab time allocation changed. L09's recognition-only HMC handoff remains intact; the final metadata does not restore the old overpromise. All ten headers link to the current registry; build-input hashes remain historical provenance rather than new approval targets.

### Synchronized artifacts actually inspected

| Input | Git blob inspected |
|---|---|
| `syllabus_plan.typ` | `1dfd798b0b983d99de07991404071708bbaa8947` |
| `advanced_statistics_2027_1_syllabus.typ` | `cefb55ff8e7cdc37183e52894b01ee9d13b81d9e` |
| `Lectures/material_ledger.md` | `7282d267523910277897c86fa02c4a71bc21729b` |
| `Lectures/notebook_reference_audit.md` | `55227a7ac115bca66485d2b9925352ebd292295d` |
| `Lectures/syllabus_planning_decisions.md` | `56753d899441f161beb41342304c679f88fcebde` |
| `architecture_audit.md` | `fcbbd26f8038212923da9004c628547108c3acd4` |
| `questions_and_hesitations.md` | `12d0285a7075dd1bcf68c1c72038e19a13581cb6` |
| `STATUS.md` | `6d3780f25dcc0cb06240c6a144bc973d20bb617c` |
| `validation.md` | `3a38ba20e0f4013a5bb8368cd9fba15e5796a9c1` |
| Appended `L12_review.md` | `e6beff2e2c81fd87b646288a568c4f9a09d3b896` |

These are the exact working-file revisions checked, not a claim they were all committed at HEAD. STATUS's final proposal commit/addendum identity and mechanical closure are explicitly in progress and belong to the coordinator after this reviewer stops. That disclosed registry closure is not a failed pedagogical gate. Original review-target hashes in the human report identify historical substantive evidence; STATUS supplies their exact mapping to current metadata-finalized blobs.

### Findings and minimum next treatments

- **C1 — resolved Scope clarification; downstream implementation owner.** The current L12 paragraph, architecture audit, notebook audit and human questions all require expected-q event-summed Gaussian NLL with fixed variance/constants and observation-count weighting. Mean-code decoding is separately labeled and is not D. Fresh course-normalized beta comparisons are required. The supplied estimator helper adds no student fit/task/minutes. No additional repair to the proposal is required; later implementation must validate estimator accuracy and comparison consistency.
- **C2 — retained bounded risk; Notebook Authoring owner.** The formal documents promise central computations in supplied workflows, one required implementation/fit per hour, PyTorch first introduced L05 and refresh included later. They do not require the source Pyro/JAX/TFP implementations, an unbudgeted second algorithm, or already-existing validated checkpoints. Notebook audit explicitly carries all named infrastructure as future production work. Minimum later treatment is the pilot/scaffolding already prescribed; a failed core pilot returns to Scope.
- **C3 — retained bounded risk; Scope/Section Design owners.** Inclusive 110–115-minute plans and total 1117 live minutes including 120 reserve remain estimates. The human report explicitly distinguishes a strict 100-minute cap and warns that deleting an already-excluded optional lab run yields no core margin. No required recording is used to balance the scope. Rehearsal and student pilots remain necessary later; this final consistency check adds no timing evidence.
- **C4 — explicit human decision; Coordinator/Scope owner.** MRI/GMM, real Kalman forecasting, GDP/unknown-noise VI-HMC and wider domain/architecture outcomes are removed from required formal promises and retained as alternatives with costs. HMM, controlled VI and descriptive standardized-Gaussian mobility are honestly named. No causal/disentangled-factor or support-valid scientific mobility-generation outcome reappeared. Dataset permission and portable access remain later publication gates, not fulfilled by local source inspection.
- **C5 — resolved synchronization; Coordinator owner.** Current approval labels are uniformly agent-approved / instructor-pending, with actual reviewer/thread and old/current hashes in STATUS. Protected delivery is separated from proposed allocation. Final commit/hash closure remains disclosed. The reviewer grants no approval and changes no shared source.

The notebook audit also retains the important individual-review safeguards: L08 asymmetric-transition enumeration checks; L09 summed-observation/single-prior-KL scaling and identical finite-draw gradient estimator; L11 matching B×1 shapes, actual softplus gradients and a training-only fair fixed-scale baseline; L10 rejection repeats and stuck-query diagnostic limits; and L12 joint log-variance gradients, source-beta conversion and count-weighted expected distortion. The human questions additionally prohibit test-data run/checkpoint selection. These safeguards fit supplied assertions/helpers rather than creating new required student implementations.

Across both syllabi, future ledger and planning decisions, substantive source promises match the reviewed scopes: scalar/vector GLM gradient distinctions; one reverse graph; generic bound ownership L06; exact HMM messages and compact Kalman application; diagonal pathwise VI with bounded CAVI; MH correctness with recognition-only HMC; nonlinear conditional mean/SD; and VAE roles/rate decomposition/collapse cautions. Global preparation-range qualifications and the explicit ownership matrix prevent subsection ranges from promising every intervening derivation. Ch13 SMC, §§6.6–6.9, generalized graph/VI/MCMC catalogues, sparse/hierarchical GLM inference, BNN/GP/shift/calibration, broad architectures and generative extensions remain deliberate omissions. No backward dependency, duplicated full proof or new L13 debt was introduced during synchronization.

### Independent mechanical checks and limits

Independently compared all 66 tracked protected L01/L02 files plus the delivered L01 solution, counted together, against starting commit `906ce71dd9c8e29f3dede51ec809442a885354c9`: every byte matches. The delivered-ledger prefix through L01 delivery notes matches exactly. Formal L01/L02/L13 blocks and plan L01/L02 rows match the starting commit. The formal schedule has exactly 13 numbered meetings, every seven days on Wednesday from 21 October 2026 through 13 January 2027. `git diff --check` passed. Initial adversarial-report bytes and the original L12 raw-report prefix were explicitly checked before this append.

Read the coordinator's validation record of successful warning-free Typst 0.15.0 compilation and seven rendered pages; this reviewer did not independently recompile or render them. Link/render/compiler evidence remains attributed to that record. No notebook, estimator, fit/checkpoint, runtime, uv/Colab session or student/lecture timing was run in this final pass. No source/shared-artifact edits, commits, approval, merge or publication were performed. Only this addendum was appended. No further source/pedagogical repair is demanded by the bounded synchronization check; coordinator mechanical/registry closure and later instructor oversight are the next owners.
