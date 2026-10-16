# L03 recovery and current feasibility review

**2026-10-14 · Section Design specialist · `feasibility-review` · independent delegated review.**
**Verdict: feasible-with-risks.** The recovered Scope has a coherent, dependency-respecting argument compatible with the revised architecture. This is an assessment, not renewed Scope approval, approval of the seven proposed sections, downstream validation, or notebook validation. No section contracts were built.

## Dispatch receipt and evidence

- **ID / owner:** `L03-RECOVERY` / delegated Section Design specialist `/root/l03_recovery_dispatch`; return owner: course coordinator `/root`.
- **Base:** `16423885e4bf6b4b4e8a0f4e642591f9832034f2`; branch `reconcile/l03-course-review-20261014`; isolated worktree `/tmp/pml-l03-course-review-20261014`.
- **Dependencies:** frozen L03 agreement and proposed contracts below, current architecture/maps, frozen L02 prerequisites. Future student knowledge is conditional on teaching. L01 candidate acceptance, completed L02 production, and answers to unrelated deferred queues are not dependencies of this review.
- **Allowed tracked write / deliverable:** this file only, `Lectures/L03_Graphical_Models/reconciliation/course_review.md`; leave uncommitted for coordinator boundary check. All scopes, contracts, notebooks, shared skills, architecture/maps, AGENTS, production and other worktrees are read-only. External L01 slide/skill and L04–L12 scope/map ownership is preserved.
- **Gate:** coordinator checks evidence and allowed diff; consequential teaching decisions return to their owning instructor-reviewed artifact. No merge, production, environment change or self-approval.
- **Coordinator instructions:** read updated `/tmp/pml-course-development-20261014/.agents/skills/course-development/SKILL.md`, SHA256 `a2e66a82f5bd58b16b38812d6cf53f8d37dbdf739a369edc345b1a2d4203678c`, and its `Lectures/course_development_state.md`. Deferred-review authorization applies; questions go to the coordinator.

| Exact input revision | Authority and inspected artifact |
|---|---|
| `origin/lecture-3-authoring` frozen at `8007d42b2871181a6966ab4d55417c10af9b5544` | `lecture_scope.md` blob `0656648fd43374997469174a845418a802b3aefe`; `development_state.md` blob `caef6a625c8525e90ecdfe83912a43f3a462fa8a`; proposed `section_design.md` blob `2cb8c35a417e02720c9b4f0b1138c93469db7c05`. |
| Rescope `a804af644a7ccb282c2ca113f78f4a2a12b1fc4d` | Restored Scope blob `2d5992a3f05d952dc21553690039fe021fd6284a`; register blob `8658d11618b40cfc3fcadeeaee172e9c4ec90c5f`. Register records instructor reopening of L01–L03 on 2026-10-14, with no L03 scope change approved. Existing `Lectures/course_architecture_scope/reviews/L03_review.md` retains prior raw reviews and authority corrections; those reviews assess their own versions. |
| Architecture/maps at both rescope and this base, identical blobs | `course_architecture.typ` `cb111196e44df211e39864be596233a1a3f22aba`; `curriculum_map.typ` `63fb5cea0a7b0a4c908c8f803e550d087d20a412`; `curriculum_map_actual.typ` `cf143d8c5427030cf3ac6c6ad05d8ad9cd420fe3`. Actual map explicitly records no classes taught. |
| L02 fix `6872177f4223c57119f92036b0b178fd6f31a83f` | Register distinguishes accepted organization from unaccepted Slide Design; Section Design blob `bac0d8a29887f232b2895375019482fce189d706`, organization `cf3818f2b78cc49061620f7c65db39984a203fcb`, design `243cca5f7b35e716ace7f0c41df139f2fff648c7`. |
| L02 titles `81c7c4a62ef7039d395caba73cbcf4a15625cf9d` | Earlier Section Design `bbf78a13db05224a839d0b2f8bda4c7a5bd0c764`, organization `9a9d36c8f660f6e0cb69f1cae7f967495a2870ab`; not preferred over the fix/register merely because its draft wording differs. |
| Review workflow at base | Section Design `4ebf03e9c94f00606da00a0eefcdd4e203120763`; backpressure `1f064971a7c5930d68e7859e42355a774b4de340`; Lecture Development `e01f5f8ab4b8fc82c9bfa60aa1c41c2b427e97a5`; timing calibration `9ac4b93e408800e985891291a2fa9d836788953a`. |

Historical approval is recoverable from the instructor-decision register, not from a claim that this reviewer saw the original chat transcript. The rescope register records that the instructor identified the agreed authoring branch on 2026-10-12. The source Scope was agreed for section planning. The seven-section design was **not approved as a whole**: splitting the abstract DAG argument from the student network, keeping plates after the network in the second section, and reusing the student network for directed motifs were individually agreed directions. Specific expansion of the later contracts remained proposed. No L03 slide organization/design/deck or worked solution/teaching notebook is recorded as authored or validated. The historical section plan's statement that L01 was “actually taught” is incompatible with the current actual map; interpret its prerequisite claim as prepared capability, not delivered coverage.

## Argument, prerequisites and extent

The reusable live argument is substantial independently of the notebook: the chain rule is an identity, parent factorization adds conditional-independence assumptions, local CPTs reduce representation cost, d-separation gives graph-entailment guarantees, and undirected potentials require global normalization and a different separation language. In a topological ordering, replacing

$$p(x_{1:D})=\prod_i p(x_i\mid x_{1:i-1})$$

by $\prod_i p(x_i\mid x_{\mathrm{pa}(i)})$ requires $X_i\perp X_{1:i-1}\setminus X_{\mathrm{pa}(i)}\mid X_{\mathrm{pa}(i)}$. This distinction supports practical judgment about what structure is assumed rather than inferred from a drawing. For $D$ variables with $K$ states and bounded indegree $m$, representation can fall from $K^D-1$ free parameters to at most $D K^m(K-1)$; this does **not** make every posterior query cheap.

**Architecture against existing teaching:** its restoration task, independent-pixel baseline and distinction between a local update, global MAP and marginals agree with the recovered Scope. Its two-hour mathematics/one-hour guided practice allocation does not require solving restoration live. **Existing teaching against architecture:** keep the mathematical spine; the student network and exact CI contrasts teach transfer beyond images, while restoration supplies the bounded application. Reducing L03 to its site-update calculation would discard the strongest existing argument. No consequential architecture revision is demonstrated by this review. Treat spatial dependence as a modeling assumption appropriate to some image/field tasks; independent pixels remain a meaningful baseline, not a universally impossible model.

The L02 fix establishes prospective first-order factorization, categorical conditionals and count normalization. It also corrects the earlier assumption that L01 supplied precision coordinates; L02 introduces them. L03 does not depend on precision coordinates, maximum-entropy proof details or a generated-text asset. It needs the Markov factorization and the normalization meaning of the log-partition function. The inspected base L01 deck (`34f8b21d2e6720002a22b95570d41227e019d33c`) and solved notebook (`ab441941c8b526151a927bfbcf292bd9bc629ce5`) support Gaussian conditioning and Bayes reasoning; they do not establish general d-separation or plates. No assumptions about external L01 candidate acceptance were imported.

The proposed contracts provide evidence of a plausible route, not a new partition: motif algebra precedes all-path queries; potential products precede undirected separation and expressivity comparisons; Ising interpretation precedes new notebook modeling. Their 104 substantive minutes leave 16 minutes in the 120-minute window, compared with the Scope's approximately 100+20 planning prior. The most demanding obligations are three motif justifications plus numerical explaining away, the multi-path/blanket applications, global normalization, and the four-cycle/collider comparison. The timing skill explicitly treats these as provisional priors; no rehearsal proves an overrun. **Advisory, Section Design owner:** measure extent using selected work and interaction, avoid extra graphs/proofs, then return only a demonstrated depth/delivery conflict to Scope. There is no basis now to invent a recording, omit a required contrast or change the endpoint.

Preserve both accepted boundaries: every section ends with its own retrospective summary; essential connections begin the receiving section. The live endpoint interprets binary Ising coupling. Gaussian corruption, prior–likelihood–posterior construction, local conditional/log odds and ICM remain original notebook work; its introduction is a separate lecture-level item. No required recording is assumed.

## Exact-source finding: the recovered Fig. 4.23 blocker is incorrect

Read-only PDF inspection used the PDF skill, text extraction and full-page visual renders of printed **pp.180–181**, **1-based PDF pp.214–215**. Source: Kevin P. Murphy, *Probabilistic Machine Learning: Advanced Topics*, MIT Press 2023, **online version December 10, 2025**, `/home/opher/Repositories/ProbabilisticMachineLearning/Resources/book2-1.pdf`, SHA256 **`54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`**. Book 1 was available read-only, SHA256 `89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf`; no selected example here depends on an uninspected Book 1 graph.

**Historical finding retained as historical:** both registers and the earlier restoration review say the proposed direct `X4 → X7 ← X5` collider is wrong and must pass through `X6`. **Current-source correction:** Fig.4.23(a) visibly contains the direct edges `4→7` and `5→7`, as well as `6→7`. The complete inspected edge set is

`1→2, 1→3, 2→4, 2→5, 3→5, 3→6, 5→6, 4→7, 5→7, 6→7`.

The following exhaustive simple-path check uses those visually verified edges. Numbers denote $X_i$; a listed blocker suffices to close that path with evidence $C=\{X_2\}$.

| Simple path from 4 to 5 | Blocker(s) with $C=\{2\}$ |
|---|---|
| 4–2–5 | conditioned noncollider 2 |
| 4–2–1–3–5 | conditioned noncollider 2 |
| 4–2–1–3–6–5 | 2; unobserved collider 6 |
| 4–2–1–3–6–7–5 | 2; unobserved collider 7 |
| 4–7–5 | unobserved collider 7 |
| 4–7–6–5 | unobserved collider 7 |
| 4–7–6–3–5 | unobserved collider 7 |
| 4–7–6–3–1–2–5 | 7; conditioned noncollider 2 |

Thus $X_4\perp_G X_5\mid X_2$. Adding $X_7$ to evidence opens `4–7–5`, `4–7–6–5` and `4–7–6–3–5`; CI is then **not graph-entailed**, without asserting dependence for every parameterization. A small read-only enumeration checked all eight paths and collider descendants. Murphy §4.3.6.2, **“An undirected alternative to d-separation”**, printed p.181, explicitly confirms the first query and identifies 4,5,6 as parents of 7. The changed-evidence application is course-selected work, not an attributed Murphy classroom sequence.

**Disposition:** the alleged nonexistent-edge blocker is discharged for this exact PDF; no instructor choice is involved. The Section Design/register owner should later correct the current blocker metadata and attach this source check. Original historical evidence is not edited here. Source support does not approve the entire proposed contract or its timing.

Additional author-owned checks: the proposed course-constructed potential table is internally correct: $Z=5\cdot5+3\cdot3=34$ and the specified assignment has mass $8/34$; keep its course provenance. Relevant cautions in the inspected source text are Eq.4.116's converse (absence of an edge guarantees CI for a Markov distribution, but additional parameter-specific CI may occur), p.166's unnecessary $E(x)>0$ restriction (energy can have either sign), and p.167's frustration claim (a nearest-neighbor square lattice with ordinary bipartite boundary conditions admits a checkerboard satisfying every negative coupling). These must not override the Scope's correct I-map, positivity and coupling interpretations. They are correctness repairs, not approval questions. This was not a visual audit of every proposed figure or CPT.

Focused verified reading route: §4.2.1 **“Representing the joint distribution”** (p.143), §4.2.2.2 **“The ‘student’ network”** (pp.145–146), §4.2.4.1 **“Global Markov properties (d-separation)”** (pp.149–151), §4.2.4.3 **“Markov blankets”** (pp.153–154), and the exact Fig.4.23 discussion above. For the second language, §4.3.1.1 **“Hammersley-Clifford theorem”**, §4.3.1.2 **“Gibbs distribution”** (p.166), §4.3.2.1 **“Ising models”** (pp.167–168), and §4.5.1 **“CI properties”** (pp.194–195). Look for identity versus assumption, all-path blocking, cancellation in full conditionals, global normalization, strict positivity, and exact graphical CI sets rather than an ordering of universally stronger model classes.

## Dependency disposition and deferred review

**Artifact/advisory risks, not skill blockers:** proposed section completeness/extent and unvalidated notebook feasibility. The old workflow missed branch authority and confused application feasibility with justification of the lecture argument; the retained raw diagnosis documents that failure. Current canonical instructions require both checks. This run supplies bounded evidence that the recovery procedure works here, not proof that all skill uses succeed. No current shared-skill failure blocks L03 source review or independent notebook feasibility. No source-access or runtime blocker prevented this review; no runtime validation was attempted.

**New instructor-choice IDs: none.** No demonstrated conflict requires a fresh route, endpoint, depth, recording or live/notebook allocation decision. Do not re-ask the withdrawn A/B route question or request approval of author-owned correctness. Historical full Section Design acceptance remains outstanding; this report does not constitute an approval-ready new design. Under reopening, renewed Scope acceptance belongs to the lecture coordinator/instructor when a concrete reconciliation proposal is presented, not to this reviewer.

**Exact dependent work:** promotion of reconciled Scope, consequential changes to required treatment/delivery, complete Section Design acceptance, and slide organization/design/production require their owning reconciliation/approval gates. L03 notebook publication requires a validated worked solution, pedagogy, clean uv run and hosted Colab run. **Independent work:** source checks, selected-example correctness, extent evidence, and bounded notebook feasibility may continue without waiting for answers to other lecture queues or L01 slide acceptance. Prospective prerequisites must remain conditional. Eventual destinations are L03 `lecture_scope.md` for Scope decisions, `section_design.md` for section contracts, and `development_state.md` for approval/status provenance; another owner must apply any updates under a fresh checked write envelope.

**One recommended independent follow-up, not performed:** dispatch bounded technical validation under `worked-solution-authoring`, report-only, for the accepted one-hour ICM notebook handoff; no end-to-end notebook build. Use the frozen Scope above and Murphy §4.3.8 **“Inference”** (p.182). Inspect the candidate external references before adoption; do not substitute Gibbs/mean-field for the selected ICM method. Return a report only, with derivation, algorithm guarantees, scaffold requirements and timing risks; no notebook creation, environment change or execution. Reserve a new disjoint report path and exact inputs before launch.

For that review the relevant calculation is precise: under $z_i\in\{-1,+1\}$, Ising coupling $J$, and independent $y_i\mid z_i\sim\mathcal N(z_i,\sigma^2)$,

$$\log\frac{p(z_i=+1\mid z_{-i},y)}{p(z_i=-1\mid z_{-i},y)}=2J\sum_{j\in\mathrm{ne}(i)}z_j+\frac{2y_i}{\sigma^2}.$$

This is a review criterion, not supplied student notebook content. Cancellation gives an $O(\deg(i))$ site calculation and $O(|V|+|E|)$ sequential sweep; it avoids enumerating $2^{|V|}$ configurations but does not compute global MAP or marginals. A coordinate MAP update is nondecreasing in posterior; retaining the current state on ties supports termination without cycling on a finite state space. The feasibility review should preserve students' derivation, supply data/plots/interfaces, compare with independent-pixel restoration, and assess oversmoothing or initialization/local-optimum error. The model's binary states, assumed noise law and spatial coupling regime must be judged against restoration quality, not merely whether the formula runs. This check needs no new teaching answer and would supply the missing evidence for later notebook decisions.
