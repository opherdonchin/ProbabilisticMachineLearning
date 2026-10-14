# Slide 65 design notation repair

Stage: Slide Design. Mode: revision. This is a known development repair in response to `/tmp/l01-transfer65-review.md`, not a blind transfer test or an independent review. The coordinator authorized a bounded mathematical typesetting correction. The functional contract is `/tmp/l01-skill-inputs/contract65.md`.

## Changes and preserved commitments

Only `tmp/l01-skill-test/development65/slide_design.typ` and this report were edited. The incoming design was byte-identical to `tmp/l01-skill-test/transfer65/slide_design.typ` (SHA-256 `86e79f7451d46fd37bee973eece7fcc4725e1e4acbcbfc7e8595d280b46eaa8a`). No production, course API, skill, organization, or scope file was edited, and no commit was made.

Four occurrences of expectation-contained squared norms now use the documented `norm(...)` constructor: the finite-second-moment condition, the risk definition, the residual-energy term in the centered expansion, and the residual-energy/trace identity. This prevents the opening expectation bracket and norm boundary from being consumed as the `[|` shorthand for `⟦`. Three occurrences of `^T(m-a)` now read `^T (m-a)`, so the superscript is only `T` and the subsequent factor remains on the baseline. The source diff contains these corrections alone.

The intended theorem remains

\[
R(a\mid y)=\mathbb E[\lVert z-a\rVert^2\mid y]
=\operatorname{tr}C+\lVert a-m\rVert^2,
\quad m=\mathbb E[z\mid y],\quad C=\operatorname{Cov}[z\mid y].
\]

The finite conditional second moment, deterministic estimate for fixed observed `y`, pointwise almost-sure interpretation for random `Y`, unique minimizer over all of `R^d`, and conditional Gaussian identification are preserved. No algebra, proof depth, assumption, title, slide count, object role, layout relationship, semantic label, key point, summary nomination, reveal order, persistence, or attention cue changed. The new centered expectation and cross-term remain ordinary proof objects outside the recall object. The interpretation remains typed key points in its separate layout slot. The four cumulative teaching states remain unchanged.

## Syntax evidence and checks

Read current `AGENTS.md`, `.agents/skills/slide-design/SKILL.md`, `.agents/skills/shared/backpressure.md`, `Lectures/slide_design_conventions.md`, `Lectures/design.typ`, the functional contract, the supplied raw review, and the available `/home/opher/.agents/skills/typst-author/SKILL.md`. Verified math calls, attachments and delimiter constructors against the bundled local Typst documentation (`docs/reference/library/math.md`, particularly Function calls, Attach and Left/Right; `docs/changelog/earlier.md` documents `norm` and `[|`; `docs/changelog/0.8.0.md` recommends `norm` for norms). These local references supplied syntax evidence; no new textbook claim or source attribution was introduced.

Actual commands run from the repository root included:

```sh
typst --version
command -v typstyle
python scripts/check_typst_math_attachments.py tmp/l01-skill-test/development65/slide_design.typ
typst eval 'repr($ E[norm(r)^2 | y] $)'
typst compile --root . tmp/l01-skill-test/development65/slide_design.typ /tmp/l01-development65-design.pdf
typst query --root . --field body tmp/l01-skill-test/development65/slide_design.typ 'math.equation' > /tmp/l01-development65-design-equations.json
pdfinfo /tmp/l01-development65-design.pdf
pdftoppm -png -r 160 /tmp/l01-development65-design.pdf /tmp/l01-development65-design-page
diff -u tmp/l01-skill-test/transfer65/slide_design.typ tmp/l01-skill-test/development65/slide_design.typ
```

Typst is 0.15.0 (`3ae52774`). `typstyle` was unavailable (`command -v` exit 1); the prescribed formatting check was therefore skipped and no formatting changes were made. The attachment checker was run before and after the correction: before, exit 1 with the three expected `^T(` hits; after, exit 0, “No possible run-on math attachments found.” The compile succeeded without diagnostics. The query succeeded with only Typst's query-deprecation warning.

The minimal expression probe confirmed that `norm(r)^2` creates a superscript on a complete `lr` norm inside separate expectation brackets. Inspection of the actual design query confirmed all four squared complete norms and all three `T`-only transpose attachments; the following `(m-a)` factors are sibling baseline objects, not part of the superscripts. In the third transpose, the base is the whole expectation `E[r|y]`. No double-square-bracket symbols remain. This actual-source parsed-content check was also run:

```sh
python - <<'PY'
import json
from pathlib import Path
nodes = json.loads(Path('/tmp/l01-development65-design-equations.json').read_text())
def walk(obj):
    if isinstance(obj, dict):
        yield obj
        for value in obj.values():
            yield from walk(value)
    elif isinstance(obj, list):
        for value in obj:
            yield from walk(value)
all_nodes = list(walk(nodes))
assert not any(n.get('text') in ('⟦', '⟧') for n in all_nodes)
transposes = [n for n in all_nodes if n.get('func') == 'attach' and n.get('t', {}).get('text') == 'T']
assert len(transposes) == 3
assert all(n['t']['func'] == 'symbol' for n in transposes)
assert [n['base']['func'] for n in transposes] == ['symbol', 'symbol', 'sequence']
norms = [n for n in all_nodes if n.get('func') == 'attach' and n.get('t', {}).get('text') == '2' and n.get('base', {}).get('func') == 'lr']
assert len(norms) == 4
for n in norms:
    children = n['base']['body']['children']
    assert children[0]['text'] == children[-1]['text'] == '‖'
print('Parsed-content checks passed: four squared complete norms; three T-only transpose superscripts; no double-square-bracket shorthand.')
PY
```

It passed, exit 0. The assertions complement the manual grouping inspection; they do not substitute for it.

## A4 inspection and handoff

The new PDF has three A4 pages, 595.276 × 841.89 pt. All three page PNGs were visually inspected through `view_image`; the changed mathematics is on page 2. The expectation has ordinary square brackets containing complete double-bar norms; each square applies to the norm, and the conditioning bar remains inside the expectation. The transpose products visibly place `(m-a)` on the baseline. The full proof, Gaussian identification and two interpretation bullets fit without clipping. The page-3 reveal table still shows the same four cumulative states. The design document's page break between its reveal-sketch heading and table is inherited; no geometry repair was undertaken in this bounded task.

This is a local revision check, not instructor approval. No new instructor-owned decision or upstream backpressure was found. Slide Authoring can now implement the revised math in its owning production artifact and revalidate the affected presentation and handout states. Production readability and the separate authoring source-semantic correction identified in the supplied review remain downstream responsibilities; this A4 render does not establish classroom projection readability.

## Artifact versions

Repository HEAD during this task: `8d29c79891dc2e39d735151bfd974c9832c3c72a`. Working-tree hashes, rather than HEAD alone, identify the inputs and output.

| Artifact | SHA-256 |
|---|---|
| Revised `development65/slide_design.typ` | `00cf4dff699c5c52c7323d7472d36358e5373eaf2c976a9d86a2ed5a6547af0f` |
| Functional contract | `4fb0dc4488d71f81d4b16edd6999eac8841b98f88b77d6d4e484cef840dbbedc` |
| Supplied raw review | `c16746ec18982de103951686c118f04c22726fe1d9473aaea3f4233970ee128d` |
| `AGENTS.md` | `2786f4cd51cf8413e6e03f881b49aa1e5a41fd010c6d6fc2995f60918fdf919f` |
| Current Slide Design skill | `13366180faaf87285798aba4bbd989dd0ab25cc6d9fd95de63046c2a953ca21b` |
| Shared backpressure | `576bd81a09d9805338e78f3036959c60dc1840be2904263f2cd438b04ecbef40` |
| Typst Author skill | `4ae40b8d0514bf172dc0fabd3f4c092ce23f5d37e805c774d8d6f19d97bb3379` |
| Slide Design conventions | `1bb2a41252f9439e908f428c6eede960c5062e9734d105b72da57516a65137a9` |
| `Lectures/design.typ` | `b839a0779d0533ac766566fa4d70dc7d768726c24dacc6e95d6cfd68b9e5a1b0` |
| Math attachment checker | `a5a28a809b0a6a20205c934815f75e39366a013d0196fde07285d49b735d5023` |
| `/tmp/l01-development65-design.pdf` | `1a11b1c6bce7fc8067afe2146b9057c82dfe72ef6408fb581722bbca93ed7848` |
| Parsed design equations JSON | `a7923d779bbd70c64872b392a69c10243aeaea7e9935d26c5cc1a030a8cb61b6` |
| A4 PNG page 1 | `7dc082bb16b5f6f838d1f1265289b21c36fc4d9496a79e816325cede325c52c4` |
| A4 PNG page 2 | `4648af54f458ac2bc595650729402992efe603088119d5afd91d25a09345a37d` |
| A4 PNG page 3 | `59fd596c18da1fe9e48d3102aa148e51e9df1d65c4b1b21c862f68a863b1e844` |

Generated check artifacts are under `/tmp`; no stale design PDF or PNG was left beside the revised repository source.

## Recheck: two remaining squared-norm groups (2026-10-14)

Stage: Slide Design. Mode: revision. The coordinator authorized this bounded repair after the fresh diagnosis in `/tmp/l01-second-round-quality-review.md` (SHA-256 `905d7ee18d9edbb802a55b76c2e74329fc71b2bfdbd3f9cf625f34ae5fe23a7d`). This is an informed repair, not an independent or held-out test. The input design SHA-256 was `00cf4dff699c5c52c7323d7472d36358e5373eaf2c976a9d86a2ed5a6547af0f`.

Only design line 33 changed from `||m-a||^2` to `norm(m-a)^2`, and line 53 from `||a-m||^2` to `norm(a-m)^2`. Reversing these two replacements reproduces the exact input hash, verifying that every other source byte—including all mathematics, assumptions, layout, reveals, semantic roles and metadata—was preserved. Production already uses the correct constructors according to the supplied review; it was not edited or rebuilt in this repair. No skill or main L01 slide file was edited.

The attachment checker passes (exit 0, “No possible run-on math attachments found.”). This checker did not diagnose the original norm issue, so the recheck also queried the actual design's equation bodies. All six squared norms now parse as `attach(base: lr(...), t: 2)` with matched `‖` delimiters; the two repaired bases contain the full sequences `m − a` and `a − m`. No superscript attaches to a lone norm bar. Assertions over the actual-source JSON passed. Local Typst documentation's Attach and Left/Right sections support the constructor and grouping choice.

The commands used were:

```sh
command -v typstyle
python scripts/check_typst_math_attachments.py tmp/l01-skill-test/development65/slide_design.typ
typst compile --root . tmp/l01-skill-test/development65/slide_design.typ build/slide-review/development65/design-norm-recheck.pdf
typst query --root . --field body tmp/l01-skill-test/development65/slide_design.typ 'math.equation' > build/slide-review/development65/design-norm-recheck-equations.json
pdfinfo build/slide-review/development65/design-norm-recheck.pdf
pdftoppm -f 2 -singlefile -png -r 160 build/slide-review/development65/design-norm-recheck.pdf build/slide-review/development65/design-norm-recheck-page2
```

`typstyle` remains unavailable, so no formatter changed the file. Typst 0.15.0 compiled without diagnostics. The equation query succeeded with only the query-subcommand deprecation warning. The PDF has three A4 pages (595.276 × 841.89 pt). Page 2, containing both affected equations, was visually inspected: the expansion ends in the complete squared norm of `m-a`, and the risk decomposition contains the complete squared norm of `a-m`. Both equations fit without clipping; the proof and interpretation remain intact. The inherited break between the reveal-sketch heading on page 2 and its table on page 3 remains outside this repair's scope.

Current artifact hashes:

| Artifact | SHA-256 |
|---|---|
| Rechecked `development65/slide_design.typ` | `30e14ffccf350d985c047a6438a8898a75b258fe7fe3e3856f7f566c84c1067d` |
| `build/slide-review/development65/design-norm-recheck.pdf` | `a163ac33ca2957ee4e9b065c2b8e26dd47c463d5d1fae42f3a26d1c7216fd5f1` |
| Actual-source equation JSON | `3005c180a225de39f3d48048bca25ad5ba11247a03db6718e772ac1f08cccb23` |

Generated artifacts are under the ignored `build/slide-review/development65/` path. No remaining issue was found within the bounded norm-grouping diagnosis; no instructor-owned pedagogical decision or upstream change is proposed. This recheck does not grant instructor approval or establish classroom readability. The earlier report remains the raw record of the previous repair; the current hashes above identify this rechecked source.
