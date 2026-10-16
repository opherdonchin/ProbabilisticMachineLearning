# Selected squared-loss sequence — bounded authoring review

Status: one contextual proposal for instructor acceptance. It is not in the live source and has not been promoted. Source patch applies to the repaired source `Lectures/L01_Probability_Statistics/slide_deck.typ` with SHA-256 `66ec0914f65f008b8ecacb20c2faad61e9b630dfd1f8b1dc5a9e8f196d073e7f` (accepted repair revision). Proposal source scope replaces only the existing two-slide squared-error insertion with the selected setup, decomposition and final decision blocks. The patch is `/tmp/l01-delivery-production/loss-proposal/selected_loss_sequence/proposal.patch`; `patch --dry-run` succeeds against the base source. Nothing was copied to the repository.

The adjacent Organization and Design documents are the owning proposals. This review reports their one selected sequence in production, without changing scope, organization or design. The proposal uses the **actual current p63 predecessor** and the **corrected current p66 sensor-fusion successor**; adding one slide moves the latter to p67 in this proposal. The other selected neighboring slide p68 follows as before. There is one selected sequence and no A/B alternative.

## Exact excerpt and source map

- Handout excerpt `/tmp/l01-delivery-production/loss-proposal/selected_loss_sequence/handout_excerpt.pdf`: 5 pages, original proposal pages 63–67, SHA-256 `6af06881b523afc396f731d4982b959da8473252b666a4f1ec755ce4404883b8`.
- Presentation excerpt `/tmp/l01-delivery-production/loss-proposal/selected_loss_sequence/presentation_excerpt.pdf`: 12 states, original proposal states 149–160, SHA-256 `5c4dc4a8f65fae942b719f598cdb4e11099cf86e7f692c4e2d3364ef9f0aea8f`.
- Patch SHA-256 `3536ac868ab69bb6ca5eeaf3f82a43a15ca5054e6486381b033d8856fc69bb6a`.

The built full contextual handout has 70 pages and the presentation has 164 states. The intended five-slide handout excerpt is p63 (actual predecessor), p64 (risk setup), p65 (averaged decomposition), p66 (decision), p67 (actual sensor successor). The twelve-state presentation excerpt maps exactly as follows:

| Proposal handout page | Presentation state(s) | Slide |
|---|---:|---|
| 63 | 149–150 | Actual current “Inference often combines conditioning and summarizing” predecessor; both original states retained |
| 64 | 151–153 | “Choose a reconstruction by its conditional squared-error risk”; criterion, then centered-error quantities, then pointwise expansion |
| 65 | 154–155 | “Centering separates residual uncertainty from estimation error”; moment evaluations, then risk decomposition |
| 66 | 156 | “The posterior mean minimizes squared-error risk”; static decision and Gaussian application |
| 67 | 157–160 | Corrected “Sensor fusion combines measurements according to their uncertainty” successor; original four states |

Selected source blocks are the first setup on handout p2, the common decomposition on p3, and the final decision on p7 of `risk_variants.typ`. The only new mathematical line on the selected setup is the visible validity condition `E[||z||² | y] < ∞`. It is placed in the “Squared-error risk” card alongside the observed input and action/state vectors. The decomposition retains the existing source record “Murphy, Book 1 §5.1.5.1; vector decomposition: course elaboration.” The final decision keeps the annotations attached to the two terms, presents minimum risk at left and action at right, and retains the conditional-Gaussian mapping. The sensor successor uses the separately authorized corrected p66 source; its conditional independent-noise model, weak-prior-limit schematic qualification and finite-prior note are intact.

## Validation and visual findings

The full contextual deck builds with Typst `0.15.0 (3ae52774)` from a scratch copy of the canonical L01 source at `/tmp/l01-delivery-production/loss-proposal/Lectures/L01_Probability_Statistics/slide_deck.typ`, project root `/tmp/l01-delivery-production/loss-proposal/Lectures`. Handout: 70 pages. Presentation: 164 states. Both final Typst stderr logs are empty. Full handout SHA-256 `14f9066e4b11165b926c00ef98c54052b1dec1ffb59491d7de29dffedf70db3a`; presentation SHA-256 `be606b016aa43f16a65f80d966ad952042a73350b5cae172d2a222d8f1abe07e`. The handout and presentation variants sit beside `slide_deck.typ`; relative imports and lecture assets resolve without source relocation.

Rendered and visually inspected every presentation state 149–160 and all five handout pages at 1400 px, including the actual p63/p66 neighboring slides. The supplied-moment assumption is legible and does not crowd the setup, the full pointwise expansion remains intact, both conditional-moment warrants and the trace calculation fit on the decomposition, and the attached term labels/readable action–minimum correspondence fit on the decision slide. The actual predecessor still shows the conditional Gaussian and mean calculation before the risk question. The corrected sensor model and qualified schematic follow the result without a teaser or an added handoff slide. No clipping, empty page, missing reveal object, footer/counter mismatch or layout warning was observed.

## Reproduction

Starting from source hash `66ec0914f65f008b8ecacb20c2faad61e9b630dfd1f8b1dc5a9e8f196d073e7f`, apply the patch to the canonical lecture source (`patch -p1`). In a scratch copy of the repository's `Lectures/` tree, create adjacent handout/presentation source variants from `slide_deck.typ` by setting `config-common(handout: true)` / `false`, then run:

```sh
patch -p1 < selected_loss_sequence/proposal.patch
sed 's/config-common(handout: true)/config-common(handout: true)/' \
  Lectures/L01_Probability_Statistics/slide_deck.typ \
  > Lectures/L01_Probability_Statistics/slide_deck_handout.typ
sed 's/config-common(handout: true)/config-common(handout: false)/' \
  Lectures/L01_Probability_Statistics/slide_deck.typ \
  > Lectures/L01_Probability_Statistics/slide_deck_presentation.typ
typst compile --root Lectures \
  Lectures/L01_Probability_Statistics/slide_deck_handout.typ handout.pdf
typst compile --root Lectures \
  Lectures/L01_Probability_Statistics/slide_deck_presentation.typ presentation.pdf

pdfseparate -f 63 -l 67 handout.pdf handout-page-%d.pdf
pdfunite handout-page-{63,64,65,66,67}.pdf handout_excerpt.pdf
pdfseparate -f 149 -l 160 presentation.pdf presentation-state-%d.pdf
pdfunite presentation-state-{149,150,151,152,153,154,155,156,157,158,159,160}.pdf presentation_excerpt.pdf
```

The excerpt PDFs and all 17 rendered handout/state images in `loss-proposal/selected_loss_sequence/` preserve the selected evidence; the full contextual outputs remain one level above. Any downstream copy should preserve the exact base hash and corrected sensor source.

No notebook, live source, speaker notes, neighboring slides, or section summary were changed. Timing remains unmeasured. Instructor acceptance and any insertion into live source remain outstanding.
