# Gaussian independence slide: authoring report

## Scope and inputs

This is the authorized isolated exploratory build for actual L01 slide 48, with actual slides 47 and 49 before and after it. It uses the frozen experimental instructions at commit `61acb414c5956202add5f7ddbdbbdbfaadc5f304` and the exact inputs recorded in `inputs/manifest.json`; the live course source, scope, maps and production deck were not changed. The accepted scope route is the residual derivation of the conditional mean. Actual47 supplies the Gaussian marginal/affine-rule context; actual49 uses the residual independence result to interpret conditional covariance.

The selected visible reasoning, accepted by Design, is: define `B=Σ₁₂Σ₂₂⁻¹` and `r=x₁−μ₁−B(x₂−μ₂)`; establish `E[r]=0` and `Cov(r,x₂)=Σ₁₂−BΣ₂₂=0`; use affine Gaussian closure to state that `(r,x₂)` is jointly Gaussian; only then infer `r ⟂ x₂`; hence `E[r|x₂]=E[r]=0` and `E[x₁|x₂]=μ₁+B(x₂−μ₂)=μ₁|₂`. The Gaussian premise is essential: zero covariance alone does not imply independence for arbitrary distributions. The full conditional density and the repeated alias `r=x₁−μ₁|₂` are omitted from this mean-only teaching move; actual49 restates the latter identity for its covariance argument.

## Layout alternatives and resolution

Three one-slide candidates were rendered with the same selected mathematical chain and unchanged actual47/49 source excerpts:

- `production/independence-result-proof.typ` (SHA-256 `ca8cf2462a4a4d6afe73c4578d470afdab7efdb55fea562be476eebb8bc052ad`) retained the result-left/proof-right arrangement. The result remained visible from state 1 and the proof accumulated over states 2–4. Its left result region was sparse beside the dense right proof, and the conclusion was stated both before and at the end of the proof.
- `production/independence-proof-led.typ` (SHA-256 `c8f4a299e78372450834f96849976c4a559ca2a0aa3ed19d315133266df57a21`) placed the whole proof in one full-width vertical path and removed the duplicate early result. The complete chain fit at `fs("l")`, but the endpoint had the same visual weight as intermediate proof lines and competed with a long card heading.
- `production/independence-proof-led-hierarchy.typ` is the current provisional choice (SHA-256 `a3e8221d31d5a87492d2ac1f4a700bca33328c8819c9abb02eae6e131d9dcf06`). It groups the setup/centering, covariance, and Gaussian independence warrant in a short-titled “Centered residual” card, then places the conditional expectation and mean in a separate, larger, unheaded region. Four presentation states reveal the setup, covariance check, Gaussian warrant, and final conditional argument in order. This preserves one slide-level teaching move without treating its provisional count as an instructor commitment.

Design accepted this hierarchy provisionally; Organization accepted the unchanged one-slide boundary and title, preferring Candidate C. Their agreement is a stage convergence, not instructor approval or independent quality validation.

## Render evidence

Candidate C's complete handout and presentation PDFs, review report, three handout previews, and every presentation state are under `build/slide-review/production/independence-proof-led-hierarchy/`. The target is `conditioning-shifts-the-mean-by-an-observed-deviation-45ab94fd-handout-1.png`; its four states are the matching `...-presentation-1.png` through `...-presentation-4.png`. Actual47 and actual49 handouts and all their emitted states are in the same directory under `marginalization-keeps-the-matching-blocks-3fc75697-...` and `conditioning-removes-explained-covariance-ee0fd26b-...`. Footer pagination changes in the three-slide standalone deck; their slide bodies and reveal source are copied unchanged from the frozen production source.

At presentation scale, the conditional-mean endpoint is legible as a distinct result while all covariance and Gaussianity warrants remain visible in the handout. State 3 places affine Gaussian closure immediately before the zero-covariance-to-independence statement; state 4 then shows the conditional expectation identity and the mean. No proof step depends on a reveal that disappears before the handout. The two authentic neighboring slides continue to provide the marginalization entry and the covariance use of residual independence. The actual39, actual59 and actual61 snapshots were consulted as notation/scale precedents; they do not prescribe this slide's layout.

## Validation and limits

`UV_CACHE_DIR=/tmp/uvcache uv run scripts/review_slides.py <candidate-source> --slide "Marginalization keeps the matching blocks" --slide "Conditioning shifts the mean by an observed deviation" --slide "Conditioning removes explained covariance"` was run for each candidate. Candidate C's PDFs contain six handout pages and fifteen presentation pages. In the handout, page 1 is the title, page 2 is empty except for the footer, page 3 is the section divider, and pages 4–6 are actual47, target48, and actual49. In the presentation PDF, pages 1–3 are the same front matter; pages 4–7 are actual47's four states, pages 8–11 are target48's four states, and pages 12–15 are actual49's four states. Typst/Touying's empty-content warning correctly identifies the extra blank wrapper page 2 in both PDFs. This is an unresolved standalone implementation defect, not a false-positive detector warning. No clipping was visible in the inspected target or neighbor states.

`UV_CACHE_DIR=/tmp/uvcache uv run python scripts/check_typst_math_attachments.py <candidate-source>` reports no possible run-on math attachments for all three sources. `typstyle` is unavailable in the worktree, so the optional formatting check could not run. The source equations and rendered grouping were inspected directly.

The builder team judges Candidate C's spatial hierarchy clearer than A or B while preserving the complete selected reasoning at the existing course scale. This is a render-based authoring judgment, not a classroom outcome. Timing, student attention during delivery, and the independent review commissioned for the experiment remain unmeasured/pending. No independent-review verdict or instructor approval is claimed.
