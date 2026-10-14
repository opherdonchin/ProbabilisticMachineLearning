# Squared-error candidate packaging report

The isolated candidate is packaged at `Lectures/L01_Probability_Statistics/reconciliation/squared_loss_candidate.typ` with its handout export `squared_loss_candidate.pdf` and cumulative presentation export `squared_loss_candidate_presentation.pdf`. This is a proposed review artifact; the live lecture deck and the existing `build/l01-coupled/final/review/` packet were not edited.

## Exact source binding

The four level-2 slide bodies were extracted from the reviewed full-sequence source `build/l01-coupled/final/slide_deck.typ` (SHA-256 `74d34ddba30899feb971e229270276e43ee559b9699c3ccfff231aacba159131`). The original reviewed heading-plus-body slice hashes are retained below exactly as recorded before the terminal-whitespace cleanup. That earlier last slice included three extra newline bytes after the final `)`; the standalone source now ends with exactly one newline. For the final equality check, extraction trims newline padding at each slide boundary before byte comparison; all four body substrings then match the reviewed source exactly. The mathematical content and all internal body whitespace are unchanged.

| Original reviewed heading/body slice, including boundary newline padding | SHA-256 |
| --- | --- |
| Actual 63 — Inference often combines conditioning and summarizing | `14c610c63999036779e936280ce9db7dc5778e3afc04e7198534e0eca3f0fdc5` |
| Candidate 64 — A point estimate needs a loss function | `3d42c7317f31bc20277868b0f0050f873aec7323fe6d7bfa38c0aec969dab2a8` |
| Candidate 65 — The conditional mean uniquely minimizes squared-error risk | `fbd6b41a642a668fe591e74faae6f9f691ad37a53121973e47d0bdfdc103819d` |
| Actual 66 — Sensor fusion combines measurements according to their uncertainty | `fb26dbcd3b1390d25cedb94ba2a9d4482f288c327076a6aaff6dc6f685c4d0fc` |

Only the standalone wrapper was added: `course.typ` import, lecture theme metadata, the figure-path helper needed by actual 66, and section/footer context. No slide body wording, mathematics, reveal, or layout was changed. The sensor-fusion schematic resolved successfully from the new source location.

## Course framing and export differences

The course theme normally creates a visible level-1 section divider. Including that divider would make this package five handout pages and fifteen presentation pages, so the source preserves the established `7. Linear Gaussian systems` footer context through a small state initialization using the same section-state keys as `course.typ`, without adding a frame. The course header remains “Lecture 1 — Probability & Statistics.” The only pixel differences from the current review images are the bottom-right slide counters: the standalone exports show `Slide 1/4` through `Slide 4/4` instead of their full-deck positions. The section footer and all other pixels are unchanged.

## Validation and hashes

The canonical `scripts/review_slides.py` workflow compiled both modes and checked Typst math attachments after the EOF-only change. It reported zero warnings, four handout pages, and fourteen presentation states. The standalone header, footer and representative slide states were visually inspected; the previous pixel comparison remains applicable because only terminal source whitespace changed. Source extraction was checked byte-for-byte for all four bodies after trimming newline padding at the slide boundaries.

- Standalone Typst source SHA-256: `65e53c43aec474b83c3548e60a4c50d34653fca3516a417655eca9f7afd4dced`
- Handout PDF SHA-256: `70a8a565c9e41964acc4e404c760c3ff581b8e94c32393578a82d77c613ff3fe`
- Presentation PDF SHA-256: `e695b94431b44fc37465e6a4ce87c7c3d6272b32935e962fe96ad9bd8e271bd7`
- Canonical review manifest SHA-256: `db7be3b733c3a33d03814fe3315f5a85775abea0413a2c36dacb177486001a43`

These hashes identify the exact package files and render report. Packaging does not promote the candidate to the live lecture source or resolve instructor acceptance.
