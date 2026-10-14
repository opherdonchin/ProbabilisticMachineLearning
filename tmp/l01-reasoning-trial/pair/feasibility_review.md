# Slide Authoring feasibility review — paired squared-loss design

**Mode:** feasibility-review, read-only. **Verdict:** feasible-with-risks. This is a production-constructibility preview, not instructor approval, a production build, or visual quality validation.

## Exact scope and evidence

- Target design: `build/l01-reasoning-test/pair/slide_design.typ`, SHA-256 `05284d16daa8e24e49bd10eab7950c679411847ba0994ef4fba17b6d8cd582a1`.
- Owning organization: `Lectures/L01_Probability_Statistics/reconciliation/squared_loss_slide_organization.md`, SHA-256 `ae330a3d54a9f8597293c5e350c821229df8900de040dcd176dde91b85c19bdd`.
- Inspected branch and base: `test/l01-reasoning-alignment-20261014`, `15042b872d9d883be31b2f7f1e3bea5067807668`.
- Inspected the design report, `course.typ`, production conventions, existing slide 63/66 source and renders, and the requested proof-precedent renders pp. 109–112, 135–137, 141–143.
- Proposed eventual implementation scope is four teaching slides: copy actual 63 unchanged, implement design slides 64 and 65, copy actual 66 unchanged. This review does not authorize or begin that build.

## Constructibility

The design’s object/key-point distinction maps to the existing `content-block(object:, key-points:)` API. `recall-card` supports the provenance of the posterior summary on 64 and the actual pointwise expansion on 65. `card` is an unmarked semantic wrapper, and `key-points` supports the separate interpretations. The needed spatial relationships are expressible with the shared `grid`, `stack`, `twocol`/`cols`, and `sp` helpers; no new asset, primitive, or shared API is required.

The reveal plan is supported directly. Slide 64 has three cumulative states: initial criterion and interpretation, new shared moments with transient entry emphasis, then centered pointwise expansion and its interpretation. Slide 65 has five: carried expansion; new averaging operation with emphasis; peer cross-term and residual-energy evaluations; dominant assembled identity and interpretation; then optimization/Gaussian return and generality. The design’s two emphasized steps correspond to supported `step(n)` behavior; the remaining entries use ordinary cumulative appearance. Handout mode can show the complete final proof on each slide. No replacement or unstable geometry is required.

The requested proof relations also have production precedents: pp. 109–112 keep a target/residual construction and its local warrant together; pp. 135–137 map the variables before applying the Gaussian rule and interpret outputs; pp. 141–143 present peer ingredients before assembling the update. The paired design’s averaged risk, two term evaluations, and intact identity can preserve those semantic relations without copying precedent geometry. Actual slide 63 visibly establishes the posterior, its Gaussian mean, and the distinction between distribution and mean. Actual slide 66 starts a new sensor-fusion task and its two operations; it does not create a production dependency that prevents insertion.

## Issue for the owning stage

**Owner: Slide Design. Severity: advisory; resolve before a faithful build.** Slide 64 visibly states `E[‖z‖² | y] < ∞`, but slide 65’s carried object contains only `m`, `V`, `r`, and the pointwise expansion. Slide 65 first applies conditional expectation and evaluates moments in states 2–3; the finite-moment regime is stated only in the final key point. This makes an assumption used by the proof unavailable at the point of use on slide 65, despite the organization and design constraint that the regime persists across the pair. The fixed-`y` warrant is adjacent to the averaging operation; the finite-moment warrant is not.

**Smallest repair:** include the finite conditional second-moment condition in slide 65’s recall object, before the reveal that averages the expansion. This can be a compact assumption line in the same carried-forward semantic object. No change to proof depth, slide order, or mathematics is needed. Until that owning-stage repair is accepted, an author should not add the omitted statement independently of the design source of truth.

## Exact render constraints for the later build

- Preserve actual 63 and 66 source/content unchanged; inspect them together with every new presentation state.
- Keep one ordinary-slide object region and a separate key-point region. Do not flatten explanatory key points into proof cards or turn each equation into a peer card.
- On 64, retain the two opening roles, the full-width moments/definition bridge, and the complete dominant centered expansion with its cross-term. The final state must not average, cancel, or claim optimality.
- On 65, carry the actual 64 final-state definitions and pointwise expansion, plus the finite-moment assumption once resolved. Keep averaging as new reasoning; make the two moment evaluations visibly peer ingredients of that same averaged expression; keep their local warrants next to their algebra; make the intact risk identity dominant; subordinate minimization and Gaussian return to it.
- Retain every cumulative state and its intended emphasis timing. Inspect states 1–3 on 64 and 1–5 on 65, plus each final handout. There are no production renders yet, so classroom-scale legibility and density remain uncertain.
- Slide 65’s final state accumulates the recalled premise, averaged expansion, both detailed evaluations, identity, minimizer, Gaussian application and two interpretations. Allocate enough vertical room and ordinary classroom text size; if it does not fit legibly, return density pressure to Slide Design/Organization rather than shrinking the proof or dropping a warrant.
- Keep short operation/term labels with their equations and explanatory interpretation in the separate key-point region. The risk identity must remain a recognizable focal equality, not an equally weighted row.
- The 2–4-minute time estimate remains unmeasured and outside what this production feasibility review can validate.

**Limit:** feasibility is inferred from the current course API and existing renders. No new Typst source, compilation, slide rendering, or classroom legibility check was performed.

## Coordinator disposition and build recheck

The coordinator reviewed the finite-moment carry-forward finding and accepted the designer's explanation that slide 64 visibly establishes the condition for this same fixed-`y` paired proof; repeating it on slide 65 is optional for standalone excerpts and unnecessary in the actual sequence. Per that adjudication, slide design stayed unchanged. The later build/render pass exposed a separate execution issue: slide 65 overflows its available production area; see `author_report.md` and the `slide_deck` render manifest.
