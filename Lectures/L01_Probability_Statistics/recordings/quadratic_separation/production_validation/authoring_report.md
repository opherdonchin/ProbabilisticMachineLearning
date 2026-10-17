# Recording production report

**Status:** provisional production build; instructor review remains open.

## Inputs and outputs

- Design source: `slide_design.typ`, SHA256 `b5bda3fee7e459c6ff3d0fdfb29300d9ba75b291c95ba3f4cddf68813cacf7a4`.
- Production source: `slide_deck.typ`, SHA256 `2c90505066df61f8ebcb2ffc78a9a30828896747a19862b2bd3c2f865828cd4d`.
- Handout: `../slide_deck.pdf`, SHA256 `ce86c4a1ce3e4829d8918df71c2b89215cdcc8256bc4d310066d6f012ce11f51`.
- Presentation: `slide_deck_presentation.pdf`, SHA256 `7cfd937d9f0c33345b20e211803ff6da3777211a55ff4e8177bea3a548007205`.
- Geometry and reveal validation: `render_report.json`.

## Mechanical and visual checks

The complete deck compiles to 20 handout pages and 47 presentation states. The math-attachment checker reports no possible run-on attachments. Extracted handout text contains no leaked Typst helper syntax. The render report has no compile, font, or overflow warnings.

The render report records eight “Final reveal differs from handout” notices. These are expected transient entry-emphasis backgrounds on the newly revealed content; the equations and their geometry match the final handout. No extra click was introduced to remove the emphasis. The eight titles and raw warning strings are preserved in `render_report.json`.

All 47 presentation states were reviewed in contact sheets. Full-size render checks covered the full block-elimination and normalized-factorization algebra, including handout pages 5–11 and 14–20, with targeted full-size presentation states for the inverse, covariance congruence, quadratic, normalized factors, and marginal integration. The earlier overlap on pages 5, 6, 7, 11, and 16 is resolved by giving each multiline equation its own vertically padded block; primary proof mathematics remains at normal size. No overlap, clipped equation, or unintended state loss was observed. Contact sheets are included here as visual coverage records.

Textual and mathematical fidelity checks found no missing proof step in the reviewed source. R2.7 describes the conditional mean as affine in the observed block and says it can depend on the observation, since the coefficient may vanish. The proof retains complete Gaussian normalizers, the strict-positive-definiteness argument, integration to identify the marginal, and division by the positive marginal to identify the conditional. The algebra and reveal ordering received an earlier independent audit. A fresh independent rendered review of this frozen source passed: see `/tmp/l01-recording-math-review/rendered/final-review/report.md`. The reviewer checked source `2c90505066df61f8ebcb2ffc78a9a30828896747a19862b2bd3c2f865828cd4d`, design `b5bda3fee7e459c6ff3d0fdfb29300d9ba75b291c95ba3f4cddf68813cacf7a`, handout `ce86c4a1ce3e4829d8918df71c2b89215cdcc8256bc4d310066d6f012ce11f51`, and presentation `7cfd937d9f0c33345b20e211803ff6da3777211a55ff4e8177bea3a548007205`; all 20/47 pages/states, the prior collisions, final text geometry/content identity, and all 27 transitions passed.

## Decisions and limits

The design owner accepted R1.1 and R2.1 as title-plus-subtitle section dividers. Their repeated prompt/recall cards were omitted without changing the 20-unit sequence or removing new mathematics; the subtitle and short-title metadata remain. This is a production implementation decision recorded by the design owner, not instructor approval of the recording.

This is a provisional standalone recording deck. No teaching-time measurement has been made, and it is not final approval of the recording pedagogy or timing. No speaker notes were authored.
