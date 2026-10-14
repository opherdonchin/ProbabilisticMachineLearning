# Affine-transfer Slide Design build report

The isolated build produces one design unit with the contracted title, **Affine maps carry Gaussian means and covariances**, in `slide_design.typ`. It is an experimental candidate for coordinator review, not an approved production slide. Only this file and this report were written in the repository. No actual affine target source/render, pages 64–65, prior calibration/transfer outputs or reconciliation reports were inspected.

The target-content input was `/tmp/l01-skill-inputs/contract_affine.md`. The supplied neighboring source and renders 48, 62, 63 and 66 supplied continuity evidence only. The contract substitutes for otherwise-required upstream artifacts in this bounded test. No textbook provenance for the target theorem is claimed.

## Mathematical regime and treatment

The input is a random vector $x\in\mathbb R^d$ with $E[\sum_{i=1}^d x_i^2]<\infty$, mean $\mu$ and covariance $\Sigma$. The map is $y=Ax+b$, with deterministic $A\in\mathbb R^{m\times d}$ and $b\in\mathbb R^m$. The slide derives

$$\mu_y=E[y]=A\mu+b,$$

then centers the transformed vector and expands its centered second moment:

$$y-\mu_y=A(x-\mu),$$

$$\Sigma_y=E[(y-\mu_y)(y-\mu_y)^T]
=E[A(x-\mu)(x-\mu)^TA^T]
=A E[(x-\mu)(x-\mu)^T]A^T
=A\Sigma A^T.$$

The identity $(Av)(Av)^T=Avv^TA^T$ uses transposition of the whole vector product. Moving the matrix factors through expectation uses their determinism and integrability. Neither calculation requires Gaussianity, an inverse, full rank or positive definite covariance. If $x$ is Gaussian, the already-stated affine-closure rule makes $y$ Gaussian with these parameters; its covariance can be singular, yielding a degenerate Gaussian. Closure is used at state depth, not proved. No extra example, estimation method or computational application was added.

## Object and interpretation contract

Page 48 presents a conditional-mean equation beside an explicitly new mean proof, followed by a separate lower interpretation region. Its supplied source reveals proof steps cumulatively while keeping the earlier mathematics. Page 62 combines an equation and three comparison objects with separate declarative key points. Page 63 similarly separates an inspected inference schema and expectation formula from two interpretive conclusions. Page 66 distinguishes model/query objects and a cloud schematic from its directional-uncertainty conclusions. These observations support role continuity without importing target-slide geometry.

The candidate has three stable objects:

- `affine-setting`: mathematical dimensions, deterministic map, input moments and finite-second-moment assumption. The word “deterministic” is an intrinsic condition needed for the proof, not a sentence-length explanation.
- `affine-proof`: the new mean line, centered-vector identity and four-line covariance derivation. It is the dominant right-hand object. Its short “Moment proof” label names the inspected object; no explanation is duplicated there.
- `affine-interpretation`: a separate full-width key-point region below both mathematical objects. It states that translation moves the Gaussian mean without changing covariance and that a linear map carries center and spread while closure preserves the Gaussian family.

No new equality is treated as recall. The setting supplies assumptions, rather than claiming a prior slide proved the result. Abstract side-by-side grouping preserves the algebra alongside its assumptions. Exact widths, fonts, optical alignment and Touying code remain authoring decisions.

Four cumulative states expose the complete mean computation, add centering, add the whole covariance derivation, and finally add interpretation. Earlier mathematics persists. Centering and the covariance block receive transient entry emphasis only when introduced. The final handout retains everything. A `design-reveal` records intra-object states that the structured object-level API cannot express; this is an explicit authoring-owned lowering obligation. No API extension is proposed. The transformed-moment proof and translation conclusion are nominated for retrospective reuse; this bounded insertion contains no section-summary unit.

## Validation and limits

Validation used Typst `0.15.0 (3ae52774)` and the loaded API. Local Typst documentation was checked for display math, aligned equation lines, superscript grouping and delimiters. `typstyle` was unavailable, so its formatting checks were skipped as the Typst-author skill permits.

The final commands both passed:

```text
python scripts/check_typst_math_attachments.py tmp/l01-skill-test/affine_transfer/slide_design.typ
No possible run-on math attachments found.

typst compile --root . tmp/l01-skill-test/affine_transfer/slide_design.typ /tmp/affine-transfer-design.pdf
Exit 0; no warnings.
```

`pdfinfo` confirms two A4 pages (595.276 × 841.89 pt): a section-notes page and the single slide-design unit. Both final pages were rendered with `pdftoppm` and visually inspected at `/tmp/affine-transfer-finalcheck-1.png` and `/tmp/affine-transfer-finalcheck-2.png`. The title, role sketch, all assumptions, all proof equations, reveal description and final rationale fit without clipping or a continuation page. The rendered transpose attaches to the complete centered vector; outer-product expectations retain their matching square brackets. The candidate was compared with the allowed precedent contract for role division and new-proof attention.

The imported API's document set rules do not propagate, so the candidate explicitly activates its existing A4 document defaults. This changes only the review document; no production geometry is prescribed. During local iteration an incorrect import depth was corrected and metadata prose was shortened to keep the design unit on one page. The final validation above applies to the final source hash below.

These checks are same-agent checks. They establish executable design mathematics and a readable A4 specification, not independent feasibility, final classroom readability, exact production alignment or reveal execution. Authoring must preserve the separate key-point slot, all assumptions and proof steps, lower the four states and transient emphasis faithfully, then inspect the actual slide states. No instructor-owned contract repair was needed or made. The coordinator owns review routing and any subsequent approval.

## SHA-256 provenance

The active files were read directly; “frozen v2” is the coordinator's supplied designation, while these hashes identify the bytes actually used.

| File | SHA-256 |
| --- | --- |
| `slide_design.typ` | `bda10dbba1ddb9fd62257f79cfbb53adc53756152b795df0f4c0c822cd429bbf` |
| `/tmp/l01-skill-inputs/contract_affine.md` | `9ff495528d31ede41641aea21e32d36e8fcca7348bf2da72568f4af93c915918` |
| `/tmp/l01-skill-inputs/neighbors.typ.txt` | `94a6e731af46d8505f4973b04fc4249f6c40bc7521fb484a288244d0d830a849` |
| `.agents/skills/slide-design/SKILL.md` | `13366180faaf87285798aba4bbd989dd0ab25cc6d9fd95de63046c2a953ca21b` |
| `Lectures/slide_design_conventions.md` | `1bb2a41252f9439e908f428c6eede960c5062e9734d105b72da57516a65137a9` |
| `Lectures/design.typ` | `b839a0779d0533ac766566fa4d70dc7d768726c24dacc6e95d6cfd68b9e5a1b0` |
| `.agents/skills/shared/backpressure.md` | `576bd81a09d9805338e78f3036959c60dc1840be2904263f2cd438b04ecbef40` |
| `AGENTS.md` | `2786f4cd51cf8413e6e03f881b49aa1e5a41fd010c6d6fc2995f60918fdf919f` |
| `/home/opher/.agents/skills/typst-author/SKILL.md` | `4ae40b8d0514bf172dc0fabd3f4c092ce23f5d37e805c774d8d6f19d97bb3379` |
| `/tmp/l01-alignment-page-48.png` | `f13126a77ea56ef1b1d7d7b832629e7c31beec53427aef58cb4304be5ba7ea04` |
| `/tmp/l01-alignment-page-62.png` | `8d16ebf7282c0ed48fd7e4b33cc3af859b33f170f6e8bb06bd24b0945fbd26f4` |
| `/tmp/l01-alignment-page-63.png` | `6bb76bab806cf90ba9e4285648dccbaf4df8a37434cb538f62ab1e17a6cc3d15` |
| `/tmp/l01-alignment-page-66.png` | `cbb106ba355529b0f16adce13dfad9ece32f50182e9c96623ebc6f725a4d841d` |
