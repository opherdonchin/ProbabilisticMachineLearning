# Experimental slide 64 design report

Stage/mode: Slide Design / build. Branch: `test/l01-slide-skills-20261014`. Bounded scope: the single insertion specified in `/tmp/l01-skill-inputs/contract64.md`. The result is a provisional experimental design for coordinator review, with no instructor approval, promotion, or production edits. Only `slide_design.typ` and this report were created in the assigned repository output directory. No excluded slide, reconciliation artifact, prior output, review, or discussion was opened.

## Contract recovered from the supplied evidence

The explicit functional contract is to retain the title **A point estimate needs a loss function**, define an unconstrained estimate of latent `z` at observed `y`, define squared Euclidean loss and conditional expected risk, and expand the squared error around the conditional mean. Finite conditional second moments are required. The endpoint is the expansion, before the next slide's optimality proof.

Concrete visual evidence, rather than theme alone, controls the design:

| Supplied precedent | Observed relationship | Consequence for this design |
|---|---|---|
| Slide 48 render and matching neighbor source | Established Gaussian formula is separated from the new mean proof. The proof receives several cumulative states. A declarative conclusion occupies a separate lower key-point region. | Only the already-established posterior and mean are recalled. The new expansion is an ordinary proof object and receives its own reveal; its status is not reduced to recall. |
| Slide 62 render and matching source | A dominant update equation sits above uncertainty cases; interpretation appears below the inspected objects. The mean is written `mu_(z|y)`. | Preserve the live mean notation; avoid substituting new model parameters or surrounding the expansion with explanatory headings. |
| Slide 63 render and matching source | The observed → condition → summarize schema establishes `p(z|y)=N(z|mu_(z|y),Sigma_(z|y))` and `E[z|y]=mu_(z|y)`. Its posterior-mean integral is visible separately from the key points. | Carry this exact Gaussian context as a subordinate recall object. Use `a` to distinguish a freely selected estimate from the existing displayed mean summary. |
| Slide 66 render and matching source | Model and operation schemas precede the sensor schematic; conclusions remain in the separate lower key-point region. Model notation retains `mu_z`, `Sigma_z`, `Sigma_x`, and `Sigma_y`. | Leave the sensor-fusion route and its parameters intact. Do not insert a different model or additional example. |

The stacked relationship is a design inference, not a supplied corrected composition: subordinate posterior context, loss/risk definitions, one dominant full-width expansion, then a dedicated key-point slot. It adapts the proof/context distinction on slide 48 to a longer squared-norm identity rather than copying the precedent's two-column geometry. The source file begins with a short pseudo-Typst composition description before its constrained API mapping.

## Exact student-visible content and roles

The only recall content is

$$p(z\mid y)=\mathcal N(z\mid\mu_{z\mid y},\Sigma_{z\mid y}),\qquad E[z\mid y]=\mu_{z\mid y}.$$

Its provenance is supplied slide 63. The recall heading is “Posterior mean”; `from` is design metadata, not a proposed student-visible source attribution for the new proof.

The new definitions and conditions are one ordinary mathematical object:

$$y\text{ observed},\qquad a\in\mathbb R^d,\qquad E[\|z\|^2\mid y]<\infty,$$
$$\ell(a,z)=\|z-a\|^2,\qquad R(a\mid y)=E[\ell(a,z)\mid y].$$

At the fixed observed `y`, `a` is a freely chosen vector. The conditional second-moment condition makes the conditional mean and squared-loss risk finite. Squared norms mean Euclidean squared norms. “Observed” is an intrinsic local condition, not an explanatory paragraph.

The dominant new object is the entire two-line centered squared-norm expansion:

$$\begin{aligned}
\|z-a\|^2
&=\|(z-\mu_{z\mid y})+(\mu_{z\mid y}-a)\|^2\\
&=\|z-\mu_{z\mid y}\|^2
 +2(z-\mu_{z\mid y})^T(\mu_{z\mid y}-a)
 +\|\mu_{z\mid y}-a\|^2.
\end{aligned}$$

This is course-constructed elementary Euclidean algebra, with no asserted textbook equation attribution. The cross term has the correct positive sign for the chosen displacement `mu_(z|y)-a`. Both centered squared norms and the cross term remain visible. Conditional expectation of the expansion, cross-term cancellation, a risk decomposition, and the minimizer are not asserted here.

The separate key point reads: **A point estimate is judged by its posterior expected loss.** It supplies interpretation rather than repeating an equation-object heading. It is the sole retrospective summary nomination. This isolated insertion is not a section ending; no section summary or handoff is added.

## Reveals and persistence

1. Opening state: posterior recall and the loss/risk definitions and finite-moment condition are visible together.
2. Add the complete expansion in a single conceptual step. All opening context persists. Request transient entry emphasis on this new object so students locate the new algebra among persistent equations; the emphasis ends in the following state.
3. Add the declarative key point. All mathematics persists normally, making the final handout state complete.

There are no intra-object animation instructions, production reveal callbacks, font sizes, exact widths, or API escape hatches. Stable labels are `posterior-context`, `loss-risk`, `centered-expansion`, and `criterion`; only the first is a `recall-card`.

## Validation and backpressure

`typst compile --root . tmp/l01-skill-test/calibration64/slide_design.typ /tmp/calibration64-design.pdf` passed without diagnostics using Typst 0.15.0. `typstyle` was unavailable. The design API checks passed for labels, placement, reveals, and summary references. The three-page A4 artifact comprises section notes, content/reveal specification, and remaining rationale/constraints. All pages were rendered with `pdftoppm` and visually inspected. The full expansion fits its content object without clipping; title, stable labels, mathematical objects, dedicated interpretation, and reveal table are legible. The report records a same-agent design check, not an independent feasibility review or approval.

Validation artifacts are outside the repository: `/tmp/calibration64-design.pdf` and `/tmp/calibration64-design-1.png` through `-3.png`. The A4 render establishes the review artifact's integrity, not final classroom readability or exact slide alignment. The supplied proof precedent is honored semantically: no new consequence is classified as recalled knowledge, and sentence-length interpretation occupies the key-point role.

No upstream backpressure or instructor-owned pedagogical decision was discovered within the supplied contract. Slide Authoring owns checking the full-width expansion and subordinate context at classroom scale, implementing temporary entry emphasis, and calibrating geometry. If it cannot retain readable mathematics, it should return concrete density evidence to Slide Design; shrinking or omitting the cross term is not a repair. The coordinator remains responsible for any later instructor approval and production authorization.

## SHA-256 provenance

| Input or output | SHA-256 |
|---|---|
| `.agents/skills/slide-design/SKILL.md` | `e26604d81995042ac4200e7d9987757e79e0719e837c9208f30be763f3083223` |
| `Lectures/slide_design_conventions.md` | `1bb2a41252f9439e908f428c6eede960c5062e9734d105b72da57516a65137a9` |
| `Lectures/design.typ` | `b839a0779d0533ac766566fa4d70dc7d768726c24dacc6e95d6cfd68b9e5a1b0` |
| `.agents/skills/shared/backpressure.md` | `576bd81a09d9805338e78f3036959c60dc1840be2904263f2cd438b04ecbef40` |
| `AGENTS.md` | `2786f4cd51cf8413e6e03f881b49aa1e5a41fd010c6d6fc2995f60918fdf919f` |
| `/tmp/l01-skill-inputs/contract64.md` | `5ded9acfd4e6399c4d05db0f5ceb65389bfa3f2fa71a27c0628bb4e539527e1f` |
| `/tmp/l01-skill-inputs/neighbors.typ.txt` | `94a6e731af46d8505f4973b04fc4249f6c40bc7521fb484a288244d0d830a849` |
| `/tmp/l01-alignment-page-48.png` | `f13126a77ea56ef1b1d7d7b832629e7c31beec53427aef58cb4304be5ba7ea04` |
| `/tmp/l01-alignment-page-62.png` | `8d16ebf7282c0ed48fd7e4b33cc3af859b33f170f6e8bb06bd24b0945fbd26f4` |
| `/tmp/l01-alignment-page-63.png` | `6bb76bab806cf90ba9e4285648dccbaf4df8a37434cb538f62ab1e17a6cc3d15` |
| `/tmp/l01-alignment-page-66.png` | `cbb106ba355529b0f16adce13dfad9ece32f50182e9c96623ebc6f725a4d841d` |
| `slide_design.typ` | `5ccf01bbbbbd95dfb586b7de960477659b932de5e7570ce172fcc44eab5cec0f` |

The report's own output SHA is returned in the coordinator handoff rather than embedded self-referentially.
