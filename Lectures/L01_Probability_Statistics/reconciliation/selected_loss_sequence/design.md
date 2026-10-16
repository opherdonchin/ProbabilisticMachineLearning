# L01 selected loss sequence — bounded Design revision

Status: one coherent proposal for instructor acceptance, not a promoted live deck or a new comparison. Inputs: current live deck at `8889ac0` (source blob `34f8b21d2e6720002a22b95570d41227e019d33c`), current `development_state.md` proposal envelope, and exact selected `reconciliation/slide_judgment/production/risk_variants.typ` handout p2 / shared p3 / p7. The selected setup and decision preferences and derive-live depth are settled. No new preference question, alternate layout, shared convention or proof reduction is proposed.

## Cluster contract and actual continuity

Purpose: justify choosing the conditional mean to reconstruct the unknown vector under conditional expected squared Euclidean loss. Entry: actual current p63 “Inference often combines conditioning and summarizing” supplies the Gaussian posterior, its mean and the integral defining that mean; it does **not** establish squared-loss optimality. Endpoint: derive the finite-second-moment vector risk identity, unique optimizer and minimum risk; specialize to the already known conditional Gaussian. All action vectors in $\mathbb R^d$ are admissible. At the observation $y$ considered, $E[\|z\|^2\mid y]<\infty$. Conditional on $y$, $a,m$ are fixed and $z,r$ random. Gaussianity is not needed for the optimization proof.

Inspected exact selected p2/p3/p7 PNGs and source, authentic current p63 and p66 handout renders, and their actual source. The predecessor's observed → condition → summarize schema and orange-rule key points carry the distinction between a law and its summary. Reuse its $z,y,\mu_{z\mid y},\Sigma_{z\mid y}$ notation. The selected setup names risk and centered-error inputs; decomposition evaluates the actual expansion; decision attaches consequences to intact risk terms. These arrangements serve different mathematical relationships in one continuous argument. Sensor-fusion successor reuses conditioning → mean summarization with two observations; no exit teaser or changed section summary is needed. Its separate existing correctness issue remains outside this loss proposal.

## 1. Choose a reconstruction by its conditional squared-error risk

Reuse **the first setup occurrence** in `risk_variants.typ` (selected handout p2), including named “Squared-error risk” and “Centered error” groups, full-width intact expansion, separate key points and three states. The other setup occurrence is excluded.

Exact inspected objects:

- `criterion`: intrinsic context “Observed $y$; $z,a\in\mathbb R^d$”; add the small mathematical assumption $E[\|z\|^2\mid y]<\infty$ immediately alongside/under this context. Then $L(a,z)=\|z-a\|^2$ and $R(a\mid y)=E[L(a,z)\mid y]$ on deliberate intact rows.
- `center`: $m=E[z\mid y]$, $r=z-m$; then $z-a=r+(m-a)$.
- `expansion`: $\|z-a\|^2=\|r\|^2+2r^T(m-a)+\|m-a\|^2$, intact, with the existing intrinsic “Squared-error expansion” label.

The assumption is a condition on these objects, not prose in the math card or a new derivation. It makes the accepted validity regime visible without adding a competing heading.

Separate key points, unchanged:

- “Choose $a$ to minimize conditional expected squared error $R(a\mid y)$.”
- “Given $y$, offset $m-a$ is fixed; uncertainty remains in $r$.”

States: 1 criterion (including the finite-moment condition) + first key point; 2 add centered-error group and fixedness key point; 3 add intact expansion, retaining all prior content. The mean is a definition here; neither zero conditional residual mean nor residual-energy trace has yet been proved.

## 2. Centering separates residual uncertainty from estimation error

Reuse **the first shared decomposition occurrence** (selected handout p3) and its two states. Ordinary proof objects are new reasoning. Only the immediately preceding intact squared expansion is subordinate recall, labeled “Conditional expansion” with its previous-slide provenance.

Exact new inspected proof:

$$
E[r\mid y]=E[z\mid y]-m=0,\qquad
E[r^T(m-a)\mid y]=E[r\mid y]^T(m-a)=0.
$$

$$
V=\operatorname{Cov}[z\mid y],\qquad
E[\|r\|^2\mid y]=\sum_{j=1}^{d}E[r_j^2\mid y]=\operatorname{tr}V.
$$

Keep the local cue “Take $E[\cdot\mid y]$; $m-a$ is fixed” and the named “Cross-term” / “Residual energy” groupings from selected p3. Centering makes the diagonal second moments covariance entries, so the component sum licenses the trace identification. The cross-term factoring is justified by fixedness, not by independence. Conditional linearity then gives the intact new result:

$$R(a\mid y)=\operatorname{tr}V+\|m-a\|^2.$$

The doubled cross-term in the recalled expansion vanishes because its displayed expectation is zero; a second redundant factor-of-two row is unnecessary. No newly averaged expression is labeled as recall.

States: 1 recall + operation cue + both new moment evaluations, with separate key point “Centering removes the average cross-term with the fixed offset.” State 2 adds intact risk identity; replace the intermediate key point with “Risk is residual uncertainty plus squared distance from the posterior mean.” Both proof evaluations persist.

Retain the current live insertion's subordinate source record on this slide: “Murphy, Book 1 §5.1.5.1; vector decomposition: course elaboration.” It records the established scalar-source/vector-elaboration distinction; this task does not newly verify the textbook passage.

## 3. The posterior mean minimizes squared-error risk

Reuse **the final decision occurrence** in `risk_variants.typ` (selected handout p7) exactly in content and relationship. This is one static state, as in the selected realization.

Dominant intact established risk identity:

$$R(a\mid y)=\underbrace{\operatorname{tr}V}_{\text{independent of }a}+\underbrace{\|m-a\|^2}_{\text{nonnegative; zero iff }a=m}.$$

Annotations remain attached to the actual right-hand terms, not detached page columns. The nonnegativity/equality annotation supplies the uniqueness warrant; do not omit it or add a detached duplicate inequality merely to change the layout.

Consequences at the minimizing action, with **minimum left, action right**:

$$\min_a R(a\mid y)=\operatorname{tr}V,\qquad a^*(y)=m=E[z\mid y].$$

Subordinate “For the conditional Gaussian” row, with the same correspondence:

$$\min_a R(a\mid y)=\operatorname{tr}\Sigma_{z\mid y},\qquad a^*(y)=\mu_{z\mid y}.$$

This substitutes the previously established posterior moments; it is not a second optimization or a Gaussian premise for the proof. Preserve the selected relative hierarchy and alignment.

Separate key points, unchanged:

- “The conditional mean minimizes model expected squared error.”
- “The posterior covariance describes uncertainty that remains after the mean action is chosen.”

The optimum is unique for the stated full action space and squared Euclidean loss. The guarantee concerns conditional expected loss under the model; it does not assert external-data accuracy. No additional qualification paragraph is needed on the slide.

## Handoff and validation

Organization's selected three titles/order are adopted provisionally without change. Authoring can select the exact existing source blocks and primitives rather than redesign them; the only necessary visible addition to selected source is the setup finite-moment condition and retention of the current scalar-source/vector-elaboration record. Preserve prior source comments/provenance when extracting.

Return one five-slide contextual proof: authentic current p63 predecessor (all two states), selected setup (three), shared decomposition (two), selected decision (one), authentic sensor successor (four). Handout: five pages; presentation: twelve states, barring a verified technical reason returned to owners. Do not use the experiment's simplified static p1 in place of actual p63. For the successor, the coordinator's 2026-10-16 follow-up explicitly requires the separately authorized technical sensor repair: independent sensor noises, qualitative weak-prior limit, midpoint for equal isotropic noise only in that limit, and the finite-prior contribution. Use Authoring's corrected successor and label its exact source revision; the known unqualified old claim must not reappear merely for historical fidelity. These are separately owned source corrections, not changes to the loss argument. No whole live PDF promotion.

Inspect all meaningful states, the final handout, and actual predecessor/successor continuity at lecture export scale. Check that the extra condition fits without shrinking all mathematics; expansion and risk identities stay intact; cross-term factoring and trace evaluation remain readable; recall contains only already established material; selected term annotations attach correctly; general/Gaussian minimum-action order matches; no reveal drops content; the final Gaussian mapping still reads as application. Source syntax/attachment diagnostics and actual render fidelity belong to Authoring. The Design specification is Markdown, so it introduces no executable Typst syntax to lint.

No mathematical-depth, timing-envelope or instructor-owned conflict found. A 2–4-minute historical estimate remains unmeasured. This selected sequence remains a proposal requiring instructor acceptance even after specialist realization checks pass.
