# Provisional visible explanations

Revision D3, 2026-10-15 (consolidated after inspected D2 realization). Exploratory design agreement with Organization;
Authoring realization and instructor judgment remain open. This is a bounded
prototype contract, not an approved whole-section `slide_design.typ`.

## Contract and evidence

Keep the B3 setup → decomposition → decision sequence, its three exact titles,
derive-live depth, accepted vector mathematics and Gaussian application. The
sequence itself is instructor-preferred; neither realization is accepted.
Source content is frozen `density_experiment/loss/design_B3.typ` and
`design_common.typ`. The vector derivation is course elaboration; its scalar
source attribution is Murphy Book 1 §5.1.5.1 as recorded there, not a new source
verification in this task. Finite conditional second moments suffice; Gaussianity
is needed only for the named Gaussian application. Model risk is conditional
expected loss under the model, not a performance guarantee on external data.

I inspected comparison.pdf pp7/11 and slide_deck.pdf pp58–61 at 1600-pixel width,
then their actual Typst sources. In comparison p7, four similarly centered prose
and equation bands require the student to recover criterion → centering → expansion.
The observed/choose sentence repeats the key-point task statement. In p11, recall,
nonnegativity, action, minimum and Gaussian substitution are vertically stacked;
the two application outputs can read as just two more proof lines. Actual58
names inputs and resulting joint distribution; actual59 keeps named support left
and substitution result right; actual60 distinguishes recall from gain definition;
actual61 exposes the three ingredients that enter the scalar result. These are
observations about explanatory relationships, not evidence for mandatory borders,
columns or universally large labels. Actual61 is itself dense and cannot establish
that every multi-object slide is successful.

## Selected mathematical argument, identical in A and B

All mathematical statements below are student-visible, with typography chosen
downstream. In B, the explicit positivity/equality statement is rendered as
equivalent term-local words as specified below rather than a duplicate ≥0 line.
Retain the intact expansion and intact risk identity. All norms are Euclidean.
Given observed y, a and m are fixed; z and r remain random conditionally.

### 1. Choose a reconstruction by its conditional squared-error risk

- `criterion`: observed y; z,a ∈ R^d. L(a,z)=||z−a||²;
  R(a|y)=E[L(a,z)|y].
- `center`: m=E[z|y], r=z−m; z−a=r+(m−a).
- `expansion`: ||z−a||²=||r||²+2rᵀ(m−a)+||m−a||².
- `task`: Choose a to minimize conditional expected squared error R(a|y).
- `fixed`: Given y, offset m−a is fixed; uncertainty remains in r.

States: (1) criterion + task; (2) add center + fixed;
(3) add intact expansion. All earlier mathematics persists. Key points retain
separate interpretation role; no repeated task sentence in the object.

### 2. Centering separates residual uncertainty from estimation error

- `premise` subordinate recall: previous slide's intact expansion.
- `averaging` local operation cue: Take E[·|y]; m−a is fixed.
- `cross-term`: E[r|y]=E[z|y]−m=0;
  E[rᵀ(m−a)|y]=E[r|y]ᵀ(m−a)=0.
- `energy`: V=Cov[z|y];
  E[||r||²|y]=∑ⱼ₌₁ᵈ E[rⱼ²|y]=tr V.
- `decomposition`: R(a|y)=tr V+||m−a||².
- Intermediate key point: Centering removes the average cross-term with the fixed offset.
- Final key point: Risk is residual uncertainty plus squared distance from the posterior mean.

States: (1) premise + averaging + cross-term + energy + intermediate key point;
(2) add decomposition, final key point replaces intermediate interpretation.
Definitions alone do not establish either averaged consequence; both evaluations
are new proof work, not recall. Conditional linearity and routine sum/trace
identification are sufficient background for omitting a separately expanded
averaged identity. No mathematical premise disappears.

### 3. The posterior mean minimizes squared-error risk

- `risk-recall`: R(a|y)=tr V+||m−a||², established immediately before.
- `positivity`: ||m−a||²≥0, equality iff a=m.
- `action`: a*(y)=m=E[z|y].
- `minimum`: minₐ R(a|y)=tr V.
- `gaussian-action`: a*(y)=μ_z|y.
- `gaussian-minimum`: minₐ R(a|y)=tr Σ_z|y.
- Key points: The conditional mean minimizes model expected squared error.
  The posterior covariance describes uncertainty that remains after the mean
  action is chosen.

Static complete state, as in frozen B3, so application and general conclusion
remain jointly inspectable. Gaussianity does not license the optimization step;
it supplies the earlier posterior's parameter names.

## A: named mathematical objects and dependency composition

Setup: named `Squared-error risk` and `Centered error` regions side by side;
criterion left, centering right. The loss and risk definitions occupy separate
deliberate rows, each equality intact; compact intrinsic context reads
“Observed y; z,a ∈ R^d”. Full-width intact expansion below is their
new consequence. Expansion becomes the attention target at state 3. The loss
and risk are kept together, avoiding a split of definition from expectation.

Decomposition: subordinate premise across top; averaging cue directly below it;
two named evaluations `Cross-term` and `Residual energy` below; intact
risk decomposition across bottom. This is a dependency grouping, not three
independent conclusions. Key points occupy the usual separate lower slot.

Decision: subordinate risk recall across top; below, `Minimizing action` contains
positivity, action and minimum, while `Conditional Gaussian` contains its two
specialized outputs. The general result is dominant. A visually restrained
application relation connects general result to Gaussian outputs; a label or
arrow may be used if geometry alone leaves that relation ambiguous. Visible
borders are optional; names do not require boxes.

Expected benefit: names make it possible to locate and refer to each object.
Risk: named regions could become peers despite their asymmetric dependencies.
The Gaussian region must not compete with the proof or look like its assumption.

## B: transformation and term-to-consequence composition

Setup: criterion above a continuous centered-error argument. `Center:
m=E[z|y], r=z−m` is an intrinsic operation cue next to z−a=r+(m−a), followed
by the intact expansion below. Avoid a stack of heading/equation pairs or peer
criterion/center panels. Relation is successive transformation of the error.

Decomposition: same selected proof and states as A. Authoring may share this
slide between variants; the uncertain contrast is setup and decision, not a
broad search over every state.

Decision: intact risk identity across top, with term-local labels below its RHS:
`independent of a` directly attached to tr V; `zero exactly at a=m` directly
attached to ||m−a||². These must annotate the actual RHS terms, not two
far-apart page columns beneath a detached equality. Do not repeat an isolated
tr V merely to label it. Authoring may realize the attachment with restrained
mathematical annotation. The final selected B annotation reads
“nonnegative; zero iff a=m” directly under ||m−a||². Design accepts this as
the explicit positivity/equality warrant instead of a separate ≥0 line; it
preserves exactly the mathematical proposition stated symbolically in A.
Then expose two consequences along their term dependencies: minimum risk under
residual-energy term, optimal action under displacement term. Their placement
must still communicate that the minimum is attained by the optimal action.
The Gaussian application sits as a subordinate paired mapping below these
consequences, with both action and minimum outputs visible, explicitly labeled
`For the conditional Gaussian`. Its title must remain subordinate to the
risk/consequence argument; it must not become the strongest named attention
target. The minimum-risk and action columns stay in the same order in the
general and Gaussian rows. This is not a second optimization.

Expected benefit: shows why changing a affects one term and how the two outputs
follow. Risk: connecting labels and branches can fragment the intact equality
or cause a left-to-right reading that reverses inferential order. Reject a
render if that occurs; do not repair merely with smaller text or extra arrows.

## Distinct Gaussian transfer: actual59

Title unchanged: Bayes' rule for Gaussians. Preserve the mathematical content:

- Joint distribution (z,y)ᵀ ~ N((μ_z,μ_y)ᵀ, [[Σ_zz,Σ_zy],[Σ_yz,Σ_yy]]).
- μ_y=Wμ_z+b, Σ_zz=Σ_z; Σ_zy=Σ_z Wᵀ=Σ_yzᵀ;
  Σ_yy=WΣ_z Wᵀ+Ω.
- Conditioning rule: μ_1|2=μ_1+Σ_12 Σ_22⁻¹(x_2−μ_2);
  Σ_1|2=Σ_11−Σ_12 Σ_22⁻¹Σ_21.
- Explicit mapping x_1=z, x_2=y.
- p(z|y)=N(z|μ_z|y,Σ_z|y).
- μ_z|y=μ_z+Σ_zy Σ_yy⁻¹(y−μ_y).
- Σ_z|y=Σ_zz−Σ_zy Σ_yy⁻¹Σ_yz.

Keep joint blocks and general rule as named support; make the mapping intrinsic
to the operation connecting support to posterior outputs. Do not copy B's term
labels: this move substitutes a model's blocks into a rule; it does not minimize
an expression. Keep actual59's three key points verbatim and states: support +
posterior form; add mean + mean interpretation; add covariance + covariance
interpretation. Actual58 final state is the inspected predecessor. Reuse it as
context; do not imply the transfer prototype teaches the joint construction.
All math is inherited from actual59; its recorded source is Murphy Book 2
§2.3.2.2 Eq. 2.121, not newly verified against a book in this task.

## Initial peer agreement and needed render evidence

Organization accepted A and B with the condition that Gaussian application is
an application of the general result and never a proof assumption. Organization
requires all actual59 blocks/rule/outputs remain visible and rejects applying
fixed/variable labels to the transfer. Authoring implemented D1, then D2 clarified
the risk-definition wrapping and
term-attachment/application hierarchy discovered in actual renders. D3 records
Design acceptance of the final term annotation’s equivalent positivity wording;
actual counteroffers and inspected evidence are recorded in design_report.md.

Minimum evidence: actual63 final predecessor; both setup final states, shared
averaging predecessor/final, both decision states; actual58 predecessor and
transfer states. Inspect meaningful reveal states and full handout, not only an
isolated fitted equation. No instructor acceptance or measured live-time claim.

Final realization checked: risk source SHA256
`5e7686f113a1faa9cf2c6eafd020fa31ba5064d21a94a12855898de948ee1d3a`;
all states/handouts inspected at earlier content revision, then changed decision
presentation p13 and handout p7 re-inspected. The intact identity and attached
annotation are realized; instructor visual acceptance remains open.
