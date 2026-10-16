# L01 production validation — bounded report

Status: source/output validation only; not design approval, production promotion, full-scope approval, or teaching-delivery evidence. Work used the live source at `main@8889ac0a433a784482a7ecf0931a006e3965bd6e` (Typst source Git blob `34f8b21d2e6720002a22b95570d41227e019d33c`, SHA-256 `5c4d188124c261ea0a576f4eb46fceeec136076bd3e9f9098305fee73b84006c`). No repository files were changed; rebuilt files and renders are under `/tmp/l01-delivery-production/`.

## Rebuild and inventory

Copied `Lectures/` to scratch, created handout and presentation source copies beside the original `slide_deck.typ` so relative imports remained valid, and changed only `config-common(handout: true)` to `true`/`false` in those scratch copies. Compiled with Typst `0.15.0 (3ae52774)` and project root `/tmp/l01-delivery-production/Lectures`:

```sh
typst compile --root /tmp/l01-delivery-production/Lectures \
  /tmp/l01-delivery-production/Lectures/L01_Probability_Statistics/slide_deck_handout.typ \
  /tmp/l01-delivery-production/handout.pdf 2>/tmp/l01-delivery-production/handout.log
typst compile --root /tmp/l01-delivery-production/Lectures \
  /tmp/l01-delivery-production/Lectures/L01_Probability_Statistics/slide_deck_presentation.typ \
  /tmp/l01-delivery-production/presentation.pdf 2>/tmp/l01-delivery-production/presentation.log
```

Both stderr logs are empty: zero current Typst warnings. The handout has 69 pages and the presentation has 162 states (16:9, 841.89 × 473.563 pt). The rebuilt handout has no blank/text-empty pages. Extracted text from all 69 pages matches committed `slide_deck.pdf` after removing the title-page date; the sole difference is the expected dynamic date, committed `2026-10-14` versus rebuild `2026-10-16`. Rebuilt PDF SHA-256 values: handout `572ca35b9c97394f64cddba5710ceea83e46be73e777ff1ded3510a618775595`, presentation `b0b322141fe51d4b2c09ca978641d0594bc4b1b8de81757ebd7259e0ea201ccf`. The math-attachment heuristic reports “No possible run-on math attachments found”; it is a narrow source heuristic and does not certify the missing rendered reveal objects described below.

The current live deck has its explicit title slide and all seven section dividers; there is no empty standalone-wrapper page or wrapper warning in either full-deck build. Historical experimental Gaussian standalones reported a blank wrapper page, but that warning does not reproduce in the live deck. Rendered headers, section footers, and `Slide n/69` counters were checked on the target slides and authentic neighbors; no footer mismatch or clipping was observed at export scale.

## Historical suspect pages and actual output

Page/state numbers below are one-based. Target and immediate-neighbor handout pages 40–42, 46–50 and all corresponding presentation states were rendered from the rebuilt PDFs. Scratch PNGs are grouped in `/tmp/l01-delivery-production/renders/`.

| Historical handout page | Current slide; current state range | Rebuild finding |
|---|---|---|
| 41 | “Affine maps carry Gaussian means and covariances”; handout p41, presentation pp94–97 (4 states); neighbors p40/p42 and pp92–93/98–99 | No current defect. State 4 and handout show the complete covariance argument and result `Cov[y]=AΣAᵀ`; both interpretations persist. This report does not reproduce a missing object on this page. |
| 47 | “Marginalization keeps the matching blocks”; handout p47, presentation pp105–108 (4 states); neighbors p46/p48 and pp103–104/109–112 | Current production defect. Source contains `PΣPᵀ = [I 0]Σ[I;0] = Σ₁₁`, but no reveal state or handout emits that covariance-selection multiplication. Output stops the marginal proof after `x₁ ∼ N(Pμ,PΣPᵀ)` while elsewhere stating the selected block formula. The missing proof object is not merely a hidden intermediate state. |
| 49 | “Conditioning removes explained covariance”; handout p49, presentation pp113–116 (4 states); neighbors p48/p50 and pp109–112/117–118 | Current production defect. Source contains the conditional-covariance argument after `B`, `r`, and residual independence: the fixed-mean warrant; `Σ₁|₂=Cov[x₁|x₂]=Cov[r]`; `Σ₁₁=BΣ₂₂Bᵀ+Cov[r]`; and the concluding Schur-complement equality. None of these rows renders in the handout or any presentation state. State 3 is visually unchanged from state 2 in the proof region; state 4 adds the symmetric formula and final interpretation on the left, while the right proof remains only `B`, `r`, and independence. The opening result and “conditioning cannot increase variance” interpretation remain visible without their displayed derivation. |

For repair triage only (not implemented), p47 can preserve its current sequence by moving the complete matrix-selection equality into a state-4 outer reveal around the whole math block, instead of placing `uncover(...)` inside the math alignment. For p49, the existing state 3/4 rows can be made explicit as state-bound outer regions using the self-bound `uncover` pattern already used by neighboring p48 (`#slide(repeat: 4, self => ...)` and `utils.uncover.with(self: self)`), preserving the same order and thresholds. These appear to be Authoring-level reveal realization defects. No design or mathematical-depth change is implied; verify the exact repair by rebuilding and inspecting states 1–4 plus the same neighbors.

## Other source-grounded findings

- **Sensor-fusion qualification is a mathematical/source issue, not a reveal defect.** Current handout p66 / presentation pp155–158 show all three key points and the course-owned schematic. The slide model explicitly includes a finite prior `z∼N(μ_z,Σ_z)` as well as two sensor noise covariances, but the first claim says equal sensor uncertainty “puts the posterior mean between the measurements.” The figure-generation notebook sets a visually centered posterior for its equal-noise illustration without declaring or displaying the prior contribution. Equal sensor variances alone do not guarantee this: in the scalar model the posterior mean also weights the prior mean; a sufficiently concentrated prior outside the sensor interval can move the posterior outside it. The claim should be bounded to the depicted prior/measurement regime or the example should expose the prior contribution. This is a source/math clarification for Authoring to verify, not a layout approval.
- **Covariance/uncertainty wording:** the p49 PSD claim is mathematically valid for the jointly Gaussian block-conditioning regime used here, but its current “Covariance proof” object does not emit the source derivation. The formulas on the left already state the Schur complement; the omitted source rows explain why it is residual uncertainty. Do not report the theorem as generally true for arbitrary non-Gaussian conditioning without that regime.
- **Math-attachment diagnostics:** zero heuristic hits on the live `.typ` file. The missing p47/p49 content is a reveal/render mismatch, not evidence of a run-on exponent/subscript diagnostic.
- **Date/footer/wrappers:** only the title-page date differs between committed and rebuilt handout; page count/content otherwise match. Full live builds have no blank wrapper page, empty handout page, or compiler warning.

## Reproduction commands and versions

The page text comparison used Poppler `pdftotext 26.01.0`, extracting committed and rebuilt handouts with `pdftotext -layout`, splitting on form feeds, and comparing every page after removing the `YYYY-MM-DD` title-page line. Renders used `pdftoppm` and ImageMagick `montage`; Typst version is above. The repository checker command was:

```sh
python scripts/check_typst_math_attachments.py Lectures/L01_Probability_Statistics/slide_deck.typ
```

Output: `No possible run-on math attachments found.`

Target/neighbor image mapping:

- Handout: `renders/handout/page-{40,41,42,46,47,48,49,50}.png`; sensor-fusion handout p66 is `renders/handout/page-66.png`.
- Presentation for affine slide and neighbors: `renders/presentation/state-{92,93,94,95,96,97,98,99}.png`.
- Presentation for partition/marginal/mean/covariance/bivariate sequence: `renders/presentation/state-{103,...,118}.png`.
- Sensor-fusion states: `renders/presentation/state-{155,156,157,158}.png`.
