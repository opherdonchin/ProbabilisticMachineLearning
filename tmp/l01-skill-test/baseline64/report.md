# L01 single-slide design build report

Stage/mode: Slide Design, build. Branch: `test/l01-slide-skills-20261014`; baseline: `4b69e7e`. The coordinator commissioned exactly one live slide, titled **A point estimate needs a loss function**, following **Inference often combines conditioning and summarizing** and preceding the conditional-expectation proof of posterior-mean optimality.

Status: compiled, designer-inspected draft for coordinator review. This is a **limited-exposure replay, not a fully blind baseline**. No approval, independent feasibility review, or production validation is claimed. No instructor-owned decision is newly required within the clarified contract, and no execution backpressure was found.

## Actual design decisions

The opening context says that, after observing $y$, the student estimates latent $z\in\mathbb R^L$ by an unrestricted vector $a\in\mathbb R^L$. The finite conditional second-moment condition $E[\|z\|^2\mid y]<\infty$ is visible there. The dimension $L$ follows Book 2's LGS convention; $z$, $y$ and $\mu_{z\mid y}$ follow the lecture.

One dominant object groups the squared-Euclidean loss and its conditional risk:

$$L(z,a)=\|z-a\|^2,\qquad R(a\mid y)=E[L(z,a)\mid y]=E[\|z-a\|^2\mid y].$$

A lower object introduces $m=E[z\mid y]$, with the Gaussian notation $m=\mu_{z\mid y}$ as a continuity cue. It shows both the centered vector identity and its full squared-norm expansion:

$$z-a=(z-m)+(m-a),$$
$$\|z-a\|^2=\|z-m\|^2+2(z-m)^T(m-a)+\|m-a\|^2.$$

The squared-norm expansion was added following the coordinator's explicit clarification of the two-slide preparation contract. It is algebra only: the slide does not take conditional expectations of this expansion, cancel the cross term, identify a minimizer, or give a minimum risk. The centering object labels the two vector terms as centered residual and displacement. The sole takeaway says that conditional risk averages the loss over the posterior $p(z\mid y)$.

Layout is a full-width stack: subordinate context, dominant loss/risk, centering algebra, then the takeaway. There are two cumulative states. The opening contains context, criterion and takeaway; the second adds the complete centering object while retaining everything else. No transient entry emphasis is requested because the lower object's heading and position locate the addition. No assets, extra comparison, example, experiment, API extension or escape hatch is needed. Exact slide fonts, geometry, borders and reveal mechanics remain with Slide Authoring. Only the loss/risk takeaway is nominated for retrospective summary reuse; surrounding section-summary selection is outside this bounded task.

## Inputs and provenance

Read `AGENTS.md`, the current slide-design skill, shared backpressure protocol, course design conventions and `Lectures/design.typ`. The coordinator's bounded brief owns the title, count, placement and mathematical boundary. No separate organization or section artifact was substituted for it. The lecture scope was read for accepted live-proof context; its implementation/review references were not followed and do not determine this design.

Examined existing lecture source for earlier loss/empirical-risk material, LGS joint/posterior/gain/scalar development, the conditioning/summarizing predecessor and the sensor-fusion/forward-query neighbors. Inspected precisely the four supplied neighbor renders: `/tmp/l01-alignment-page-48.png`, `62.png`, `63.png`, and `66.png`. The L02 design artifact was inspected for constrained-language usage, not as a pedagogy or styling authority.

Verified local Murphy extracts: *Probabilistic Machine Learning: An Introduction*, online edition April 18, 2025, §5.1.5.1 **L2 loss**, Eqs. 5.32–5.33, for scalar loss and posterior risk; *Probabilistic Machine Learning: Advanced Topics*, online edition December 10, 2025, §§2.3.2.1–2.3.2.3 for LGS joint/posterior/sensor context, particularly §2.3.2.2 **Posterior distribution (Bayes' rule for Gaussians)**. Book 1 gives a scalar derivative proof of mean optimality; the centered vector expansion here is course elaboration, not attributed to Murphy as an exact source equation.

Incidental exposure: an overly broad adjacent-source read included current proof-slide tail lines 2800–2822. A later dimension search also returned the current setup-slide definition at line 2734. Those fragments were excluded from design decisions. Neither inserted slide's complete source or render was inspected; neither reconciliation design nor reconciliation review was opened. The initial exposure was reported promptly to the coordinator, who directed that the result be labeled limited-exposure replay. This limitation prevents a claim that the baseline is fully blind.

Source SHA-256 records:

| Input | SHA-256 |
| --- | --- |
| Current `.agents/skills/slide-design/SKILL.md` | `fe6d991d02811212c11a90fec501fae1ae608264823da7b88bcf3de5cd8cdc31` |
| `Lectures/design.typ` | `b839a0779d0533ac766566fa4d70dc7d768726c24dacc6e95d6cfd68b9e5a1b0` |
| `Lectures/slide_design_conventions.md` | `de8f64d104e366b23c502421cea61369f0829360b246c710fda9977ecee3ecdb` |
| Local `Resources/book1.pdf` | `89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf` |
| Local `Resources/book2-1.pdf` | `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf` |

## Validation and handoff

Compiled successfully with no diagnostics:

```bash
typst compile --root /home/opher/Repositories/ProbabilisticMachineLearning tmp/l01-skill-test/baseline64/slide_design.typ /tmp/l01-baseline64-design.pdf
```

The correct relative import is `../../../Lectures/design.typ`. Review-document page/text defaults match the design API's defaults and do not specify production-slide geometry. The final review document has two A4 pages: bounded section notes, then one complete slide-design unit. Rendered both pages with `pdftoppm` and visually inspected them. Objects, equations, layout and reveal table are readable; no clipping or split reveal table remains. The squared-norm cross term was explicitly checked in the render: only $T$ is superscripted, and $(m-a)$ remains its multiplicand. The transpose spacing repair was made before finalization.

The design API validates object labels and layout/reveal references. Author checks confirm an unrestricted same-dimensional estimate, fixed observed $y$, Euclidean norm, finite-moment assumption, exact centering identity, and the correct cross-term coefficient. This is a design review document, not a classroom-size production render or measured teaching-time result. The downstream author must preserve these objects and states and validate production readability.

Final `slide_design.typ` SHA-256: `5114e433af67cc1995f020299530ea903ab3e950283a191f4e53dbe2683917d1`.

Final temporary compiled review PDF SHA-256: `eb6f9d588652e25675bae97f6de1c33bdb8c77660596112e64f8d7a9bed7f031`.

Only `tmp/l01-skill-test/baseline64/slide_design.typ` and this report are persistent task outputs. Temporary renders remain under `/tmp`. No production, skill, course-map or other-stage source was edited; no commit, merge or publication was performed. The pre-existing `tmp/prune_verified_branches_2026-10-13.sh` was left untouched. Next owner: coordinator review, then Slide Authoring when directed by the coordinator.
