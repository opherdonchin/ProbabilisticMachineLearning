# L01 p51 checkpoint: bounded Slide Design revision

Status: proposed realization of the instructor's explicit 2026-10-16 choice, “Use the existing example as a checkpoint (recommended).” This specification changes only the student-visible explanation and reveals of current p51; it does not approve the full Scope or other design. Production realization and render validation remain downstream.

Basis: main `8889ac0`, deck blob `34f8b21d2e6720002a22b95570d41227e019d33c`; accepted question and time tradeoff in `goal_alignment_review.md`. Preserve title **One observed coordinate can change both the estimate and its uncertainty**, position, and slide count. Budget 2–3 minutes provisionally, reclaimed through the authorized shorter verbal recap at p33. No proof cuts.

## Precedent and continuity contract

Inspected current source around p50–52; rebuilt handout p51/p52; presentation-neighbor montage through p50. P50 establishes the bivariate conditional formula, including mean shift and standard-deviation reduction. P51 currently has a light centered equation object and separate orange-rule key-point slot, with numerical answer and interpretation entering together. P52 returns to conditional/residual mathematics. Preserve that hierarchy and quiet visual language: model and numerical laws are inspected objects; questions and interpretation occupy a separate task/key-point slot. Do not repeat p50's general conditional formula on entry: it would supply the query students should formulate. No figure, new visual system, section redesign, or extra slide is needed.

## Stable visible objects

**`supplied-joint` — main inspected model, persistent.** Intrinsic label: “Supplied joint model”. Exact mathematics:

$$
\begin{pmatrix}X_1\\X_2\end{pmatrix}
\sim\mathcal N\!\left(\mu=\begin{pmatrix}0\\0\end{pmatrix},\;\Sigma=\begin{pmatrix}1&0.8\\0.8&1\end{pmatrix}\right).
$$

This explicitly supplies joint Gaussianity; two Gaussian marginals and a correlation would not suffice. Use the existing Gaussian/matrix notation. A minor production simplification to `N(0, [1 .8; .8 1])`, with μ/Σ identified intrinsically, is faithful if needed for readability.

**`recorded-case` — intrinsic conditions under the model, persistent.** Exact compact content: “Recorded: $X_2=1.5$; missing: $X_1$.” These are task inputs, not the answer. Do not label the unknown as a conditional distribution yet.

**`conditional-answer` — new inspected calculation, state 2 onward.** Intrinsic label: “$X_2=1.5$ recorded”. Exact mathematics:

$$
(X_1\mid X_2=1.5)\sim\mathcal N\!\left(0.8(1.5),\,1-0.8^2\right)=\mathcal N(1.2,0.36).
$$

**`marginal-answer` — comparison object, state 3 onward.** Intrinsic label: “$X_2$ unobserved”. Exact mathematics: $X_1\sim\mathcal N(0,1)$. Keep this simultaneous with the conditional answer in final state, so the contrast in mean and variance is inspectable. The second Gaussian argument is variance throughout.

**`source-record` — subordinate provenance.** Persistent visible wording: “Course-constructed example; Murphy, Book 2 §2.3.1.3, Eq. 2.78.” This avoids suggesting that these synthetic numbers came from the book and avoids supplying the requested operation in the unanswered state. If the explanatory words “Gaussian conditioning” are retained, reveal them only with state 2 onward. No independent source claim is added beyond the already established theorem and checked calculation.

## Task and key-point roles; reveal contract

**State 1: student checkpoint, no answer.** Show `supplied-joint` and `recorded-case`. In the separate task/key-point region show exactly:

- “Which quantities are fixed, observed or unknown?”
- “Which law reports uncertainty about $X_1$, and which operation gives it? What if $X_2$ is unobserved?”
- “Does either calculation estimate $\mu$ or $\Sigma$?”

These interrogatives serve the checkpoint task; they are not take-home claims or prose inside the mathematical card. No `p(X_1|X_2=1.5)`, conditional/marginal operation labels, fitted-parameter answer, or numerical answer appears in this state. The title necessarily signals the broad lesson, as in the retained deck; it does not provide the query or operation. Let students answer before advancing.

**State 2: conditional answer and supported interpretation.** Persist model and case; reveal `conditional-answer`; replace the task prompts with these key points:

- “Condition on the recorded $X_2$ to obtain uncertainty about the missing $X_1$.”
- “The mean rises from $0$ to $1.2$; the variance falls from $1$ to $0.36$.”

The equation carries the substitution; key points state operation and consequence. No need for a separate fixed/observed/unknown answer grid: the model and recorded-case objects identify them, and the instructor can confirm those responses before the reveal.

**State 3: changed information, changed query.** Persist model and both numerical laws. Keep the mean/variance interpretation; change the first key point to these two concise conclusions:

- “With $X_2$ unobserved, marginalize it to obtain $p(X_1)$.”
- “Both calculations use supplied $\mu,\Sigma$; neither fits them.”

State 3 therefore has three short conclusions, including the retained mean/variance interpretation. It must remain readable at the deck's established size. If this creates density, production may make the interpretation a single compact line; do not shrink all text, embed the prompts into the math card, or drop the fixed-parameter distinction.

Abstract arrangement: supplied model above compact case; answer area below, with the two case labels and their laws visually paired in final state; a distinct task/key-point region below the object. **Render-informed clarification:** full-width stacked conditional and marginal law rows are faithful and preferred over a half-width conditional equation that clips or requires smaller mathematics. Keep each case label intrinsic to its law, without extra card chrome. Reserve answer space so entry does not jump. Exact geometry and reveal syntax belong to Authoring. Handout shows final state with the two laws and the three conclusions; presentation must also expose the distinct unanswered state. No new summary nomination or section-ending change.

## Validation and remaining ownership

Mathematics checked locally: conditional mean `0 + .8*(1.5-0)=1.2`; variance `1-.8²=.36`; marginal mean/covariance are the first supplied blocks, `0,1`. This is inference with known parameters, not parameter estimation. The model is a supplied joint Gaussian, so the conditional theorem applies.

Authoring should inspect all three candidate states at presentation scale and the handout alongside p50/p52. Verify the entry contains no answer; final laws are simultaneous; no rows vanish because of nested reveal binding; title/place/count persist; prompts remain legible. Only p51 needs rebuilding for this bounded change. No instructor-owned conflict found. Timing remains a rehearsal question, not measured savings.
