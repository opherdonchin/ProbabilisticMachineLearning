# L01 density and slide-process experiment

**Status:** experimental results for instructor review. Production slides, course documents and the instructor's checkout are unchanged. The instruction patch remains isolated and frozen; none of these alternatives has instructor approval.

**Recommendation: revise the patch narrowly before provisional adoption.** Its selection, density and negotiation responsibilities produced useful alternatives, but the acceptance evidence needs two concrete clarifications below. This test does not establish a generally reliable workflow. Review B3 first for squared loss, with A2 vertical as the shorter alternative. For Gaussian conditioning, compare A's result-first arrangement with C's derivation-first arrangement. The blind reviewer did not share the builders' preference for A2 side and did not regard C as an unconditional improvement over A. Those disagreements remain visible rather than being resolved by another round of author persuasion.

## What to inspect

Open [comparison.pdf](comparison.pdf). Its bookmarks identify all 17 full-scale pages; every composed page is pixel-identical to its source render. Pages 1–4 are actual L01 63–66; 5–6 are the previous separate candidate; 7 is the new common opening; 8–9 compare the two-slide geometries; 10–11 are B3's decomposition and decision. Pages 12–14 are actual slides 47–49, followed by Gaussian alternatives A, B and C on pages 15–17.

Each supplied candidate excerpt includes its authentic neighbors. The presentation PDFs contain every emitted target reveal, rather than just the final handout:

| Candidate | Handout | Presentation | Target slides / target states |
| --- | --- | --- | --- |
| A2 side: support left, result right | [PDF](loss/production/a2-side.pdf) | [PDF](loss/production/a2-side_presentation.pdf) | 2 / 6 |
| A2 vertical: ingredients above result | [PDF](loss/production/a2-vertical.pdf) | [PDF](loss/production/a2-vertical_presentation.pdf) | 2 / 6 |
| B3: separate decomposition and decision | [PDF](loss/production/b3.pdf) | [PDF](loss/production/b3_presentation.pdf) | 3 / 6 |
| Gaussian A: result beside proof | [PDF](independence/production/independence-result-proof.pdf) | [PDF](independence/production/independence-result-proof_presentation.pdf) | 1 / 4 |
| Gaussian B: one proof stack | [PDF](independence/production/independence-proof-led.pdf) | [PDF](independence/production/independence-proof-led_presentation.pdf) | 1 / 4 |
| Gaussian C: proof with separate mean result | [PDF](independence/production/independence-proof-led-hierarchy.pdf) | [PDF](independence/production/independence-proof-led-hierarchy_presentation.pdf) | 1 / 4 |

## Mathematical selection and visible explanation

The squared-loss candidates retain the pointwise expansion, conditional centering and cross-term cancellation, residual energy as covariance trace, and the intact identity

$$R(a\mid y)=\operatorname{tr}V+\|m-a\|^2,
\qquad m=E[z\mid y],\quad V=\operatorname{Cov}[z\mid y].$$

They also retain the nonnegative term and its equality case, the unique optimal action, minimum risk, and Gaussian application. The separate fully expanded expectation equation, repeated definitions and trace intermediate are omitted. Finite conditional second moments remain in checking metadata: the actual preceding slide supplies a Gaussian posterior. This is a legitimate abbreviation in that context, not a theorem about arbitrary heavy-tailed posteriors. Unlike the original 65, only the previously established pointwise expansion is displayed as recalled material; the moment calculation is new reasoning.

The Gaussian candidates retain residual construction, zero mean, zero cross-covariance, **joint Gaussianity through affine closure**, independence, conditional residual mean and the conditional-mean conclusion. Gaussianity remains a local warrant; it cannot be omitted as though zero covariance alone established independence. The conditional-density header and repeated residual alias are removed from this mean-only move. Covariance is treated by the receiving slide. No proof depth or lecture route was reduced.

## Compact rendered comparison

| Material | Mathematics and pedagogy | Density and layout |
| --- | --- | --- |
| Original 64–65 | Sound route; original 65's term labels interpret the risk well, but new moment work is placed in a recall box. | Fragmented risk equation and several competing conclusion regions. |
| Previous separate candidate | Most explicit checking argument, including the finite-moment premise and averaged expansion. | Blind reviewer found the heaviest simultaneous final state; additional reveals did not resolve handout density. |
| A2 side | Criterion→centering→averaging→choice is recoverable; the fixed-offset cue licenses cancellation. | Whole risk identity improves continuity, but a long result column competes with active proof support. Builders preferred it; blind reviewer preferred vertical. |
| A2 vertical | Same selected mathematics and states as side; two moment ingredients feed one decomposition and decision. | Clearest two-slide dependency structure in the blind review. Final stack remains substantial, with a small reveal-position shift. |
| B3 | Completes the decomposition before separately interpreting minimization and residual uncertainty. | Clearest derivation/decision separation in the blind review; extra transition and repeated identity. Final decision is static. |
| Original 48 / Gaussian A | Both have sufficient Gaussian reasoning. A reduces repetition and explicitly names affine closure while anchoring the result beside the proof. | Blind reviewer preferred A within the result-first approach; its proof column still needs deliberate pacing. |
| Gaussian B / C | Both preserve the full mean argument. C distinguishes the concluding mean from its supporting chain. | C improves B's hierarchy. The reviewer regarded A versus C as a result-first/derivation-first tradeoff, rather than choosing by whitespace. |

B3 does **not** add clicks: all three squared-loss alternatives have six target states and twelve states including neighbors. It adds a slide boundary and repeats the decomposition. Its static decision trades a separate Gaussian-entry cue for stable simultaneous comparison. The builders' 3–4 versus 4–5 minute estimates were not rehearsed or measured; an extra slide does not establish an extra minute. The accepted live-time allowance remains an instructor decision.

## Process evidence and its limits

Instructions were frozen at `61acb41` before either fresh builder team began. Three separate specialists per case owned Organization, Design and Authoring. The briefs supplied actual material and precedents without prescribing omissions, geometry or a final count. Organization's existing negotiation contract proved sufficient and was not modified.

There was substantive negotiation: Design deferred covariance until its use and selected an abbreviated visible proof; Authoring rendered two genuine spatial arrangements; Organization entertained a three-slide division. Later render evidence prompted whole optimizer equations, a shorter title and a static B3 decision. The Gaussian team rejected B's undifferentiated endpoint and offered C's separate result. These changes were returned to their owning stages rather than silently implemented as authoring choices.

The patch helped distinguish a complete **selected explanation** from a complete reference proof. The blind reviewer reconstructed both mathematical arguments and identified improvements in their relationships, not merely reductions in text or symbols. However, builder convergence did not establish the preferred layout, and the two-slide final states remain mathematically demanding.

Execution and verification also failed in identifiable ways. Early loss renders contained literal Typst calls, a vertical overflow and moving retained content. The roles caught and corrected these through iteration; the new instructions did not prevent them. Builders also reported title clipping, but the independent reviewer did not reproduce it in the identified checkpoint: that claim remains builder evidence. Failed sources and renders are preserved in Git at `5748947`, `cd1d755` and `f73c76f`, with no superseded output folders left in the current tree. Coordinator checkpointing initially delayed routine corrections unnecessarily.

The Gaussian standalone sources still emit a title, a genuinely blank wrapper page and a divider before the three selected slides. Their full builds therefore have 6 handout pages / 15 presentation pages and an unresolved warning. The author initially misidentified that warning; the coordinator checked the full PDFs and required a report correction. The delivered 3-page / 12-state PDFs are explicitly selected excerpts, not evidence that the source is warning-free. A second report correction distinguishes unchanged body pixels from different standalone footer counters.

The independent reviewer first saw only neutrally numbered full-resolution renders. Its [Phase1 assessment](review/phase1_render_review.md) and [exposure record](review/phase1_exposure.json) were committed at `4b9b277` before source/process release. All 56 distinct bodies and 146 ordered references were assessed across six separate dimensions. Exact duplicates above the footer were viewed once; every meaningful target state was included. This is a fresh-agent review, not classroom validation. Original slides provide comparison baselines, **not** a matched old-skill control; two cases cannot establish general reliability or causal improvement from the patch alone.

## Source/process adjudication and next owner

The separate [Phase2 review](review/phase2_source_process_review.md) verified primary-source passages, selected mathematical content, accepted depth, current source/PDF bindings and complete output inventories. It recommends narrow revision followed by provisional adoption. It also distinguishes a checked regime in the instructor's scope from an assumption actually shown to students. The projected abbreviations are defensible here; they must be reconsidered when reused in a different context.

I agree with two precise changes, proposed here **without changing the tested files**:

1. In [Slide Authoring](../../../../.agents/skills/slide-authoring/SKILL.md), replace “A readable incomplete explanation can be intentional” with: **“The projected explanation may intentionally abbreviate the checked reference proof when its essential reasoning remains reconstructable in the actual student context. Missing agreed visible content is an implementation defect.”** This preserves the instructor's freedom to omit formal checking detail while preventing “incomplete” from licensing a missing new inferential warrant. Design already states the necessary distinction; no new per-equation inventory is needed.
2. In Authoring's completion report and [shared convergence](../../../../.agents/skills/shared/slide-convergence.md), add: **“Distinguish selected slide/state exports from the complete emitted PDFs. Report both inventories and map each unresolved warning to the actual affected page; inspect that page before explaining or dismissing the warning.”** This addresses the blank-page misdiagnosis directly. Good selected slides do not settle the readiness of the containing artifact.

Keep Organization unchanged. Preserve actual peer counteroffers and the separate render-first review as acceptance evidence for substantial changes. Builder preference, constructibility, source fidelity and independent comparative judgment should remain separate findings. Repeating generic demands for clarity would not correct the execution failures seen here.

Two shared-neighbor findings need separate production attention, not an automatic expansion of this experiment. Actual slides 47/49 have source proof objects missing from their renders; the receiving covariance derivation is therefore incomplete in production. Slide 66's midpoint claim needs a prior/noise qualification: even equal sensor variances can give a posterior mean outside the measurements when an influential prior lies outside them. For example, a prior with mean 100 and variance 0.01, and two unit-noise observations 0 and 2, yields a mean of $10002/102\approx98.06$. The Phase2 report records the source concern and next ownership. These defects predate the candidates and have not been silently repaired.

The **next owner is the instructor**: review the local alternatives and the proposed narrow instruction revision. After that decision, the coordinator can commission the accepted changes; Authoring owns the wrapper correction, and the production owners should separately resolve the neighboring defects. The trial is committed on `experiment/l01-density-20261014` in `/tmp/pml-l01-density-20261014`; the instructor's alignment branch remains at `a804af6`. No deck replacement, skill promotion, merge, push, L02 work or scope amendment has occurred. Work stops here for instructor review.
