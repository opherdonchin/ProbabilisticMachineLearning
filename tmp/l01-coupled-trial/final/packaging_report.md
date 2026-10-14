# Squared-error candidate packaging report

The isolated candidate is packaged at `Lectures/L01_Probability_Statistics/reconciliation/squared_loss_candidate.typ` with its handout export `squared_loss_candidate.pdf` and cumulative presentation export `squared_loss_candidate_presentation.pdf`. This is a proposed review artifact; the live lecture deck and the existing `build/l01-coupled/final/review/` packet were not edited.

## Exact source binding

The four level-2 slide bodies were extracted from the reviewed full-sequence source `build/l01-coupled/final/slide_deck.typ` (SHA-256 `74d34ddba30899feb971e229270276e43ee559b9699c3ccfff231aacba159131`). Each extracted heading-plus-body substring in the standalone file is byte-identical to its counterpart in that source:

| Slide body | SHA-256 |
| --- | --- |
| Actual 63 — Inference often combines conditioning and summarizing | `14c610c63999036779e936280ce9db7dc5778e3afc04e7198534e0eca3f0fdc5` |
| Candidate 64 — A point estimate needs a loss function | `3d42c7317f31bc20277868b0f0050f873aec7323fe6d7bfa38c0aec969dab2a8` |
| Candidate 65 — The conditional mean uniquely minimizes squared-error risk | `fbd6b41a642a668fe591e74faae6f9f691ad37a53121973e47d0bdfdc103819d` |
| Actual 66 — Sensor fusion combines measurements according to their uncertainty | `fb26dbcd3b1390d25cedb94ba2a9d4482f288c327076a6aaff6dc6f685c4d0fc` |

Only the standalone wrapper was added: `course.typ` import, lecture theme metadata, the figure-path helper needed by actual 66, and section/footer context. No slide body wording, mathematics, reveal, or layout was changed. The sensor-fusion schematic resolved successfully from the new source location.

## Course framing and export differences

The course theme normally creates a visible level-1 section divider. Including that divider would make this package five handout pages and fifteen presentation pages, so the source preserves the established `7. Linear Gaussian systems` footer context through a small state initialization using the same section-state keys as `course.typ`, without adding a frame. The course header remains “Lecture 1 — Probability & Statistics.” The only pixel differences from the current review images are the bottom-right slide counters: the standalone exports show `Slide 1/4` through `Slide 4/4` instead of their full-deck positions. The section footer and all other pixels are unchanged.

## Validation and hashes

The canonical `scripts/review_slides.py` workflow compiled both modes and checked Typst math attachments. It reported zero warnings, four handout pages, and fourteen presentation states. The standalone header, footer and representative slide states were visually inspected; a pixel comparison against all eighteen current review PNGs found each image identical outside the slide-counter rectangle `(1126, 681)–(1203, 696)`. Source extraction was also checked byte-for-byte for all four slide bodies.

- Standalone Typst source SHA-256: `7da35cbe201c25f75e375f6c5bf33ee6b38cdc5d96332f7a815a8f05012e4caf`
- Handout PDF SHA-256: `70a8a565c9e41964acc4e404c760c3ff581b8e94c32393578a82d77c613ff3fe`
- Presentation PDF SHA-256: `e695b94431b44fc37465e6a4ce87c7c3d6272b32935e962fe96ad9bd8e271bd7`
- Canonical review manifest SHA-256: `2f143c6307658bc311a947b0f322b1db6a3039895223b4e1df60e744d50ee7c0`

These hashes identify the exact package files and render report. Packaging does not promote the candidate to the live lecture source or resolve instructor acceptance.
