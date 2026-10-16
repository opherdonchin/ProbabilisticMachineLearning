# L01 bounded production repair validation

Status: validated scratch realization for coordinator boundary review; not promoted, merged, or committed. Scratch source is `/tmp/l01-delivery-production/Lectures/L01_Probability_Statistics/slide_deck.typ`, based on `main@8889ac0a433a784482a7ecf0931a006e3965bd6e`, deck blob `34f8b21d2e6720002a22b95570d41227e019d33c`. No repository files changed. Baseline findings remain in `report.md`; its section-divider count is corrected to seven. Current deck count: title 1 + section dividers 7 + content slides 61 = 69.

## Build and output

Typst `0.15.0 (3ae52774)`, project root `/tmp/l01-delivery-production/Lectures`. Canonical source and two configuration variants are beside each other to preserve relative imports. The only variant change is `config-common(handout: true)` / `false`.

```sh
typst compile --root /tmp/l01-delivery-production/Lectures \
  /tmp/l01-delivery-production/Lectures/L01_Probability_Statistics/slide_deck_handout.typ \
  /tmp/l01-delivery-production/handout_repaired.pdf \
  2>/tmp/l01-delivery-production/handout_repaired.log
typst compile --root /tmp/l01-delivery-production/Lectures \
  /tmp/l01-delivery-production/Lectures/L01_Probability_Statistics/slide_deck_presentation.typ \
  /tmp/l01-delivery-production/presentation_repaired.pdf \
  2>/tmp/l01-delivery-production/presentation_repaired.log
```

Both logs are empty (no errors or warnings). Handout: 69 pages. Presentation: 163 states. Both are 841.89 × 473.563 pt. SHA-256: handout `a28855332fb8fa2455dce8e8a0e4d5dd76b4237eaed7406bdd35e356b46e315b`; presentation `4c08a023edb33fd71268029efdfdcf1bfc9d1018acbd58a81e5935c0ffb8777a`; scratch canonical source `66ec0914f65f008b8ecacb20c2faad61e9b630dfd1f8b1dc5a9e8f196d073e7f`.

The source-level repair patch against the agreed baseline is `/tmp/l01-delivery-production/repair.patch`. It changes only p47, p49, p51, and the approved sensor qualification on p66. The full compiled matching artifacts are `/tmp/l01-delivery-production/handout_repaired.pdf` and `/tmp/l01-delivery-production/presentation_repaired.pdf`.

## Findings by slide

**p47, “Marginalization keeps the matching blocks” — source/reveal repair.** The content-block’s nested states were unbound to a slide repeat, so displayed states omitted the proof rows. Bound the original reveal helpers to an explicit four-state slide, retaining all rows and original thresholds. Corrected an independent mathematical defect in the hidden multiplication: the covariance must be the full block matrix

`P Σ Pᵀ = [I 0] [[Σ₁₁, Σ₁₂], [Σ₂₁, Σ₂₂]] [I; 0] = Σ₁₁`.

The malformed one-row matrix in the baseline was dimensionally invalid; visibility restoration required the full matrix. Handout p47 and presentation states 105–108 now show the complete progression. State 1 shows the marginal statement with no proof card; state 2 reveals the initial proof card; state 3 reveals `Pμ=μ₁` and the full, dimensionally valid multiplication; state 4 reveals `=Σ₁₁`, the second marginal, and the final interpretation. The result is readable at presentation scale and no row was removed. Evidence PNGs: `final-states/handout-page-47.png`, `final-states/presentation-p105.png` through `presentation-p108.png`.

**p49, “Conditioning removes explained covariance” — source/reveal repair.** Bound original nested reveal helpers to an explicit four-state slide. No row, equation, order, or reveal threshold changed. Handout p49 and presentation states 113–116 now show the full existing sequence: residual and independence; fixed conditional mean and `Σ₁|₂=Cov[x₁|x₂]=Cov[r]`; `Σ₁₁=BΣ₂₂Bᵀ+Cov[r]`; then the Schur-complement result. State 4 adds the symmetric formula and interpretation already present in source. All equations fit the proof panel. Evidence PNGs: `final-states/handout-page-49.png`, `final-states/presentation-p113.png` through `presentation-p116.png`.

**p51, “One observed coordinate can change both the estimate and its uncertainty” — approved design handoff realized.** Preserved title, position, and slide count. Presentation states 119–121 and handout p51 implement the supplied joint Gaussian and recorded/missing case, an unanswered checkpoint with three separate prompts, then the conditional law and interpretation, and finally the marginal law alongside the conditional result and supplied-parameter distinction. The conditional and marginal laws are both visible in the final state. The provenance note is revealed only with the answer, so the entry state does not disclose the operation. Reserved answer space prevents reveal jumps. A small local increase in the supplied-model card row spacing separates its label from the tall joint-law delimiters without shrinking the math. Design’s independent fidelity review passed the final entry and hashes; see `/tmp/l01-delivery-checkpoint/fidelity_review.md`. Render evidence: `final-states/presentation-p119.png` through `presentation-p121.png`, `final-states/handout-p51.png`.

**p66, “Sensor fusion combines measurements according to their uncertainty” — bounded mathematical qualification.** The hand-placed schematic is unchanged; the asset generator does not calculate a posterior from a finite prior. The source now identifies it as a qualitative weak-prior-limit schematic, and the key point reads: “With independent sensor noises, equal isotropic noise gives the midpoint in the weak-prior limit; finite-prior mean and precision also matter.” The model above the figure states `x|z ~ N(z,Σₓ), y|z ~ N(z,Σᵧ)`, making the conditionally independent sensor noises explicit. No figure or prior parameters were altered. On the scalar model with prior precision `τ₀`, sensor precisions `τₓ,τᵧ`, and independent measurements `x,y`,

`E[z|x,y] = (τ₀ μ₀ + τₓ x + τᵧ y)/(τ₀ + τₓ + τᵧ)`.

Equal sensor precisions give the midpoint only as `τ₀→0` (or for special alignment of the prior mean); at finite prior precision the prior mean contributes and the posterior mean need not be the midpoint or even lie between the measurements. The visible claim is explicitly limited to the weak-prior limit. The card spacing and image height were adjusted locally to accommodate the qualification; no font shrinking or content removal. Handout p66 and presentation states 156–159 were inspected. Render evidence: `final-states/handout-p66.png`, `final-states/presentation-p156.png` through `presentation-p159.png`.

## Other checks and boundaries

The known p41 issue was not changed; baseline inspection remains in `report.md` and p41 current output was previously clear. Authentic neighbors p48, p50, p52 and p63 are not edited. p66 is the deliberately qualified sensor-fusion successor described above. p47/48/49/50/51/52 visual sequence and slide footer/counters were checked. No blank pages, missing wrappers, clipping, overflow warnings, or newly empty content were observed in final builds. No broad deck QA, notebook run, speaker notes, source/model/figure redesign, shared API/skill changes, or loss insertion was performed here.

Classification: p47 and p49 are author-owned source/reveal repairs (including p47’s dimensionally valid equation); p51 is a faithful authoring realization of Design’s instructor-approved checkpoint; p66 is an author-owned accuracy qualification checked against the actual figure generator. The scalar formula above is validation rationale, not new on-slide theorem content. Remaining delivery approval/promotion belongs to the coordinator/instructor.
