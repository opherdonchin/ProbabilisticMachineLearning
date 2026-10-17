# L01 approved squared-loss production check

Mode/scope: revision; exact accepted three-slide patch in isolated scratch only. No repository files were changed.

## Inputs and patch

- Canonical base source: `Lectures/L01_Probability_Statistics/slide_deck.typ`, SHA-256 `66ec0914f65f008b8ecacb20c2faad61e9b630dfd1f8b1dc5a9e8f196d073e7f`.
- Patch: `proposal.patch`, SHA-256 `3536ac868ab69bb6ca5eeaf3f82a43a15ca5054e6486381b033d8856fc69bb6a`.
- Scratch source after patch: `Lectures/L01_Probability_Statistics/slide_deck.typ`, SHA-256 `b13a173b6432f901a9f1bfad9c4aa08163f6a9b506fe01ed50e6cec07c0730cc`.
- `patch --dry-run -p1` succeeded; patch applied cleanly. The original 17 approved contextual render PNGs remain in the copied source evidence directory.

## Commands and outcomes

From `/tmp/l01-approved-loss-production`:

```sh
python scripts/check_typst_math_attachments.py Lectures/L01_Probability_Statistics/slide_deck.typ
sed 's/config-common(handout: true)/config-common(handout: true)/' Lectures/L01_Probability_Statistics/slide_deck.typ > Lectures/L01_Probability_Statistics/slide_deck_handout.typ
typst compile --root Lectures Lectures/L01_Probability_Statistics/slide_deck_handout.typ handout.pdf
sed 's/config-common(handout: true)/config-common(handout: false)/' Lectures/L01_Probability_Statistics/slide_deck.typ > Lectures/L01_Probability_Statistics/slide_deck_presentation.typ
typst compile --root Lectures Lectures/L01_Probability_Statistics/slide_deck_presentation.typ presentation.pdf
pdftoppm -png -f 63 -l 67 -scale-to-x 1400 -scale-to-y -1 handout.pdf renders/current-handout/p
pdftoppm -png -f 149 -l 160 -scale-to-x 1400 -scale-to-y -1 presentation.pdf renders/current-presentation/p
```

Typst: `0.15.0 (3ae52774)`. Attachment check: “No possible run-on math attachments found.” Handout: 70 pages. Presentation: 164 states. Compilations emitted no warnings/errors. Full PDFs: `handout.pdf` SHA-256 `2d12a7a69f6db9aa4813f2bc07b658d4e41fd7ef655aeca2a25718b1fb758a84`; `presentation.pdf` SHA-256 `55cc7647c780261663764b9d5b08133916f8c69ad5385505c44415184c3cb681`.

## Contextual visual review

Rendered and inspected handout pp. 63–67 and presentation states 149–160 (17 images total, each 1400×788). These cover predecessor p63/states149–150, changed proof p64–66/states151–156, and sensor successor p67/states157–160. Every current render is pixel-identical to its corresponding approved contextual PNG; dimensions and exact-match results are recorded in the command output. Contact sheets are `renders/contact/handout.png` and `renders/contact/presentation.png`.

The finite-moment condition is visible and readable on the setup; the pointwise expansion, cross-term warrant, covariance-trace calculation, risk identity, attached term annotations, minimum/action pairing, and Gaussian specialization remain legible. The actual predecessor and corrected sensor successor retain continuity and their intended reveals. I observed no clipping, missing content, unstable reveal layout, or footer/page-count issue.

The independently re-extracted five-page and twelve-state PDFs have 5 and 12 pages. Their PDF byte hashes differ from the preserved approved excerpt PDFs, while every corresponding rendered page is pixel-identical at 1400×788.

## Artifacts

Scratch root: `/tmp/l01-approved-loss-production`. Hash manifest: `SHA256SUMS.txt`; approved and current PNG manifests: `approved-render-SHA256SUMS.txt`, `current-render-SHA256SUMS.txt`. No issue or upstream backpressure found. This is a production validation report, not self-approval or canonical promotion.
