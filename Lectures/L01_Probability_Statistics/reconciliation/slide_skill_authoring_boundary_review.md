# Slide Authoring feasibility review — L01 point-estimate setup

**Mode:** `feasibility-review` (read-only)
**Verdict:** `feasible-with-risks`
**Target:** provisional `tmp/l01-skill-test/baseline64/slide_design.typ`, baseline `4b69e7e`
**Skill SHA-256:** `fad4293e3d4204f012eddb8fb2adb98e72af067f704cc13ed077c60c489abe88`

## Evidence and assessment

The design can be lowered with the live `course.typ` API. Its `layout-stack` is implementable as a single ordinary `content-block`: the stacked material can occupy `object:` and the separate takeaway can occupy `key-points:`. The API supplies those regions, `card`/`bordered-card`, `stack`, calibrated `fs(...)`/`sp(...)`, and cumulative `uncover`; no new primitive, asset, or reveal behavior is required. The reveal adds the centering and expansion at state 2 without entry emphasis, which matches the design's `emphasize: false` and preserves the definitions.

The requested mathematics is present and internally consistent. It distinguishes latent vector `z`, unrestricted estimate `a`, observed `y`, and conditional risk; assumes a finite conditional second moment; defines `m=E[z|y]`; and expands `||z-a||^2` with the correct cross term. It does not claim or prove that `m` minimizes risk. The supplied LGS notation is retained through `m=mu_(z|y)` for a Gaussian posterior. This establishes the specified preparation for the next proof.

The main risk is semantic-role placement. The `context` card contains sentence-length framing (“After observing … estimate …”), and the `centering` card contains both an explanatory heading and the interpretive phrase “Centered residual … + displacement.” The slide-design conventions say framing and interpretation normally belong in key points, while the mathematical object stays light on explanatory prose. The existing neighbor source and renders support the production convention: slides 48 and 62–63 and 66 put the principal equation/schema in the object region and interpretation in the distinct key-point region. These phrases can be typeset, but faithfully placing them in the object region would preserve a role mismatch with that convention. I did not treat their presence as a mathematical defect.

There is a manageable density risk in the final reveal: it adds the mean, centered identity, and full squared-norm expansion while retaining the context and risk definitions. The supplied neighboring proof render (page 48) shows multiple equations can fit in a proof object, and this candidate's final composition can use the broad object region. Production can tune widths, spacing, and line breaks; the long expansion may need an aligned break. Do not reduce important mathematics below classroom readability to force a fit.

## Backpressure

- **Owner / severity:** Slide Design / advisory role-division issue; resolve before authoring if the course convention is to be preserved strictly.
- **Evidence:** sentence-level framing and the algebra's interpretation sit inside `context`/`centering` objects, rather than the separately typed key-point object. See the current design's `cards` and the Slide Design conventions, “Objects and key points.”
- **Safe provisional treatment:** no production should silently relocate this language, since the design is the student-visible source of truth. If the current role assignment is retained, authoring can mechanically render it but should report the convention mismatch.
- **Smallest repair:** in Slide Design, move the framing and the short “residual + displacement” interpretation to `takeaway`/key points; leave the assumption and equations with the mathematical object. Keep the loss, conditional risk, mean definition, and full squared-norm expansion.
- **Consequence:** this changes only object-versus-interpretation placement. It need not change the title, order, reveal count, mathematical depth, or the next-slide proof. No instructor-owned decision is apparent unless the instructor wants those phrases to remain part of the object.

## Limits

This was a fresh, read-only review relative to the baseline builder: I was spawned separately, did not build the candidate, and had no exposure to prior fault reports or desired-composition notes. I inspected only the named candidate, contract, neighbor source, requested renders, `Lectures/design.typ`, `Lectures/course.typ`, the authoring/design conventions, and required repository instructions. I checked the displayed algebra for internal consistency, but did not independently validate textbook/source citations or broader source correctness. I did not read other test reports, output, current inserted slides 64–65, reconciliation reviews, or discussion. I did not create a production deck, edit the design, run a compile or render, or claim mechanical or visual production validation. Exact production fit and reveal-state rendering remain for Build.
