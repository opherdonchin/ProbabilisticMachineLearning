# Phase 1 — independent render-only review

This assessment was frozen before source, specification, contract, process, or author material was released. Its evidence is `render_order.json` and the rendered images alone. I inspected every one of the 56 unique bodies at native resolution with `view_image(detail="original")`, and assessed all 146 ordered references, including both handout and presentation orders for all nine sequences. The exposure record is `phase1_exposure.json`. Repeated IDs were inspected once; their occurrences still count in continuity assessment. No builders were consulted.

## Comparative finding

The renders support several distinct conclusions, rather than a single ranking. For the squared-error argument, **05 gives the clearest separation of derivation and minimization**, while **04 gives the clearest two-slide dependency structure**. **01 makes the two terms of risk especially easy to interpret**, and **02 supplies the most explicit mathematical checking material but has the heaviest simultaneous final state**. For the Gaussian conditional-mean argument, **07 is the strongest result-and-proof arrangement**; **09 is the strongest of the centered, derivation-led arrangements**. **08 retains the mathematics but gives its final result less visual independence**. **06 is workable, with a dense proof column and avoidable repetition**.

These are local render judgments. The renders cannot establish which sequence is a baseline or candidate, what process produced it, whether a process reliably improves slides, or how students performed. Extra whitespace, fewer symbols, or an extra slide is not independently evidence of improvement.

## Six-dimension comparison

The detailed sequence comments below substantiate this compact matrix. Assumptions and common-neighbor limitations are distinguished in the mathematical reconstruction that follows.

| Sequence | Mathematical validity and visible reasoning | Pedagogy / reconstructability | Simultaneous spatial and cognitive density | Hierarchy, grouping, spacing, relationships | Reveal logic / continuity | Course visual language |
| --- | --- | --- | --- | --- | --- | --- |
| 01 | Valid decomposition; moments stated; uniqueness inferred. | Clear setup and interpreted risk; final consolidation demands attention. | Moderate setup, high final compound load. | Strongly labeled risk terms; proof, two conclusion columns, and long takeaways compete. | Correct dependency order; large final addition. | Matches shared typography, rule, carry/proof box, and takeaway conventions. |
| 02 | Most explicit assumptions and expectation calculation; equality condition shown. | Most self-contained checking argument; hardest final consolidation. | Highest simultaneous spatial and cognitive load in the risk family. | Repeated carry material, full expectation, two columns, and wrapped summaries weaken priority. | Finest staging; does not resolve completed-state load. | Consistent styling; unusually crowded execution of familiar groups. |
| 03 | Valid in Gaussian context; averaging inferred; finite-moment condition unstated. | Recoverable left ingredients / right results. | Less prose than 02; many right-column conclusions remain active. | Cleaner setup; result column still compressed and risk terms less labeled. | Sensible proof-to-risk-to-optimum order; slight retained-content shift. | Familiar two-column proof and carry-box language. |
| 04 | Same valid mathematics and assumption gap as 03. | Clear two-ingredients-to-decomposition-to-decision structure. | Substantial final load, with clearer dependencies than 03. | Best two-slide relationships; wide top equations and dense lower central block. | Dependencies staged correctly; slight shift before central risk appears. | Consistent formula, carry-box, and retrospective-summary styling. |
| 05 | Proof and minimization both retained; general finite-moment condition unstated. | Clearest separation and carried-forward connection. | Lower simultaneous load; extra slide and repeated equation. | Distinct derivation and decision groups; final prose still wraps. | Decomposition finishes before transition; minimization appears in one simpler state. | Uses established carry boxes and summaries coherently. |
| 06 | Correct Gaussian residual proof; inverse requires unstated invertibility. | Target remains visible; reasoning concentrated on right. | Low overall occupancy, dense multi-step proof column. | Clear result/proof split; repeated coefficient definition and long takeaway. | Stable accumulation; common neighboring repeats add no visible step. | Directly exemplifies the shared result/proof convention. |
| 07 | Complete mean proof; affine closure explicit; same inverse assumption. | Strongest anchored target and proof tie-back. | Reduced repetition; compact proof still requires pacing. | Left result and coefficient definition relate clearly to right derivation. | Correct residual-to-independence-to-mean order; several steps arrive together. | Strong fit with course two-column proof and takeaway style. |
| 08 | Complete mean chain with Gaussian independence premise; same inverse assumption. | Straight vertical derivation; target only arrives at the end. | Plenty of empty space, but full proof chain remains concentrated. | Outcome is another proof row; weak distinction from intermediate steps. | Clean accumulation; interpretation is present before its proof completes. | Compatible styling; changes result/proof arrangement to one centered block. |
| 09 | Complete mean chain and premise retained; same inverse assumption. | Stronger derivation-led grouping; target still arrives late. | Low occupancy with unchanged essential inference chain. | Residual block and separated outcome give meaningful hierarchy. | Moments and independence staged; conclusion visibly separated in final state. | Compatible markers and summary; centered arrangement remains recognizable. |

## Reconstructed arguments and mathematical requirements

**Sequences 01–05:** conditioning first supplies a posterior distribution; summarization extracts its mean. After observing \(y\), choose an action \(a\in\mathbb R^d\) to reconstruct \(z\), under squared loss \(L(a,z)=\|z-a\|^2\). With \(m=E[z\mid y]\) and \(r=z-m\), the pointwise expansion is

\[
\|z-a\|^2=\|r\|^2+2r^T(m-a)+\|m-a\|^2.
\]

At this observed \(y\), the offset \(m-a\) is fixed. Centering gives \(E[r\mid y]=0\); covariance gives \(E[\|r\|^2\mid y]=\operatorname{tr}V\), where \(V=\operatorname{Cov}[z\mid y]\). Hence

\[
R(a\mid y)=\operatorname{tr}V+\|m-a\|^2,
\qquad a^*(y)=m,
\qquad \min_a R(a\mid y)=\operatorname{tr}V.
\]

The unique minimizer over the displayed unrestricted action space follows because the second term is nonnegative and vanishes only at \(a=m\). In the conditional Gaussian case, substitute \(m=\mu_{z\mid y}\), \(V=\Sigma_{z\mid y}\). The following sensor-fusion slide then uses conditioning and mean extraction as an application.

All five sequences retain this argument. The reader supplies elementary norm expansion, linearity/pull-out rules for conditional expectation, and the relation between diagonal covariance entries and centered second moments. Sequence 01 states the finite conditional second-moment condition in item-003; 02 states it before the expansion in item-012 and repeats its role in item-013. Sequences 03–05 do not visibly state that condition. Their Gaussian context makes the operations valid, but a general non-Gaussian reading requires \(E[\|z\|^2\mid y]<\infty\); a posterior with infinite second moment does not support the finite-risk decomposition as written. This is a visible completeness difference, not an algebra error within the Gaussian setting. The renders correctly speak of model expected loss, without establishing task performance from that claim.

**Sequences 06–09:** the predecessor marginalizes a jointly Gaussian vector by selecting coordinates through an affine map. The target conditional-mean proof then constructs

\[
B=\Sigma_{12}\Sigma_{22}^{-1},
\qquad r=x_1-\mu_1-B(x_2-\mu_2).
\]

It verifies \(E[r]=0\) and \(\operatorname{Cov}[r,x_2]=\Sigma_{12}-B\Sigma_{22}=0\). Affine Gaussian closure makes \((r,x_2)\) jointly Gaussian, so zero cross-covariance implies independence; consequently \(E[r\mid x_2]=0\) and

\[
E[x_1\mid x_2]=\mu_1+B(x_2-\mu_2)=\mu_{1\mid2}.
\]

All four target renders preserve the Gaussian premise needed for the independence inference. That is essential: the additional covariance precedent, item-054, expressly says zero covariance does not imply independence in general. The reader supplies covariance bilinearity, block notation, and the Gaussian independence theorem. Invertibility of \(\Sigma_{22}\) is required by the displayed inverse but is not stated on these target slides. The following shared covariance slide also displays \(\Sigma_{11}^{-1}\) for the reverse conditional, requiring that block to be invertible as well.

The shared following slide, item-034, displays the correct Schur-complement formulas, but its visible “Covariance proof” stops after recalling that \(r\) and \(x_2\) are independent. The reader must supply \(\operatorname{Cov}[x_1\mid x_2]=\operatorname{Cov}[r]\), expand the covariance of the residual, and recognize the subtracted matrix as positive semidefinite to justify “cannot increase variance in any direction.” Thus the complete visible conditional-mean proof should not be confused with a complete visible conditional-covariance proof.

## All nine sequences

### 01 — readable setup, crowded culmination

Items 002–003 are the two target slides. Item-002 defines the action, loss, risk, mean, covariance, and centered expansion in one central chain. Item-003 averages the expansion in a compact top box, then gives a prominently labeled risk decomposition, the optimal action, the Gaussian substitution, and two takeaway bullets. The labels “Remaining uncertainty” and “Excess risk from the chosen estimate” make the equation interpretable rather than merely correct.

The reveal order 006→002 and 007→008→003 preserves the argument: decision criterion, expansion, averaged moments, decomposition, optimum. The last reveal adds two conclusion regions and a long bottom statement while the proof remains visible. The final state is materially denser than its early reveals, although its mathematical lines remain legible. Uniqueness is inferable rather than written as an equality condition. The central risk equation has strong hierarchy; its surrounding proof box, two lower columns, and long takeaway lines compete for attention. Overall: effective, with a demanding final consolidation.

### 02 — strongest explicit assumptions, weakest simultaneous density

Items 012–013 make the observed \(y\), fixed action, finite conditional second moment, residual definition, covariance identity, conditional expectation of the expansion, cancellation, trace calculation, equality condition, minimizer, and Gaussian specialization explicit. A mathematically mature reader can reconstruct the proof with less supplementation than in the other two-slide versions.

That completeness is purchased by stacking a carried-forward box above several central blocks, then placing two proof/result columns above two multi-line summaries. Item-013 is the most crowded final state in this family: the small repeated expansion in the top box, the full expectation equation, left-hand moment calculations, right-hand optimization and Gaussian formulas, and long bottom prose are simultaneously active. The finer reveal sequence 016→017→018→019→013 helps live pacing, but does not repair the final-state hierarchy or handout load. No clipping or overlap is visible. Overall: valuable checking detail, least comfortable live consolidation.

### 03 — cleaner setup, two competing proof columns

Item-020 delays \(V\) until it is used and cleanly develops criterion→centering→pointwise expansion. Item-021 carries the expansion, puts the centered moments and covariance on the left, and puts risk, nonnegativity, minimizer, minimum risk, and Gaussian substitution on the right. The proof is reconstructable, with a more explicit equality condition than 01, but without its stated finite-moment condition.

The final state is less text-heavy than 02, yet the right column still contains several successive claims while the left column remains active. There is no displayed conditional expectation of the entire expansion; the “Average” instruction supplies that operation. The reveal order 024→025→021 is sensible, although the carry box and existing content move slightly when the risk appears, and the bottom summary changes its emphasis. Overall: a sound compression with moderate residual density; clearer setup than 01, less immediately labeled interpretation of the risk terms.

### 04 — clearest two-slide mathematical relationships

This uses the same item-020 setup. In item-026, the two moment calculations sit side by side across the top; their consequence, the risk equation, occupies the center, followed vertically by nonnegativity, optimum, minimum risk, and Gaussian specialization. That arrangement visibly expresses two ingredients→one decomposition→one decision. It offers a stronger hierarchy than 03 without deleting its essential proof.

The top equations are still wide, and the lower central block still asks students to distinguish a general risk result from its Gaussian substitution. The average operation is expressed in the carry-box caption rather than by a separate expectation equation. The order 027→028→026 supports the dependency structure; existing material again shifts slightly between the first two states. Overall: strongest two-slide compromise for this audience, subject to the unstated finite-moment condition and a still substantial final state.

### 05 — clearest proof pacing, additional continuity cost

Items 020, 029, and 030 split the target argument over three slides. Item-029 retains the expansion, explicitly says to take conditional expectation with fixed \(m-a\), shows the two moment calculations, and concludes with the risk decomposition. Item-030 carries that decomposition and separately shows the equality condition, optimal action, minimum risk, and Gaussian specialization.

This is a substantive reduction of simultaneous intellectual demands: neither the averaging argument nor the minimization argument is omitted. The 031→029 reveal completes the decomposition before a slide transition; item-030 then introduces its whole simpler minimization block at once. The carry box prevents the new slide from relying solely on memory. The cost is another slide and another repeated equation, not a demonstrated increase or decrease in teaching time. The final covariance takeaway wraps over two lines, but neither target proof is spatially cramped. Overall: strongest reconstructable teaching sequence when an extra slide is acceptable; 04 remains a credible shorter alternative.

### 06 — valid mean proof, concentrated column load

Item-050 states the conditional Gaussian distribution and mean formula on the left. Its right proof defines \(B\) again, defines \(r\) using the proposed mean, checks centered moments and zero cross-covariance, asserts joint Gaussianity, derives independence, and concludes the conditional mean. The proposal is justified by the proof; this is not circular once the left formula is understood as the candidate expression.

The 051→052→053→050 order gives stable accumulation. The right column carries almost all reasoning while the left remains largely static; the many short centered rows create cognitive density despite abundant whitespace elsewhere. The left distribution also introduces conditional covariance before this slide proves it, with the following slide supplying its formula. The final summary repeats a long interpretation in two lines. Overall: workable and mathematically sound, with avoidable repetition and a crowded proof column.

### 07 — strongest result-and-proof arrangement

Item-033 factors the left result through \(B\), with its definition directly beneath it. The right proof uses the explicit residual expression rather than repeating \(B\)'s definition. “Affine closure” names why the residual pair is jointly Gaussian, and the final equation expands the result back to the expression shown on the left. This makes both the target and its justification available throughout the completed slide.

The 037→038→039→033 reveals establish target, residual, independence argument, and conclusion in that order. Several logical steps still arrive together in item-039, so oral pacing remains necessary. The right proof remains a compact chain rather than becoming effortless merely because it is shorter. The shorter single-line takeaway and reduced redundancy improve grouping and spacing. It hands the independent residual to item-034 coherently. Overall: strongest visible balance of anchored result, sufficient proof, and course-style two-column relationships.

### 08 — complete derivation, weak distinction of outcome

Item-042 uses a single centered proof block under “Residual proof of the conditional mean.” It contains every essential step, including affine closure and independence. The reveal order 043→044→045→042 follows residual→moments→independence→conditional expectation and mean.

The vertical reading order is straightforward, and the widest expressions have ample room. However, the final conditional-mean equation is another similarly styled row at the bottom of the proof block. The desired result is absent as an independent anchor until the last reveal, while the large interpretation bullet is already visible from the first state. The block concentrates a full logical chain in the upper portion of a mostly empty slide; the extra space below does not reduce that chain's cognitive load. Overall: mathematically complete and visually clean, but less differentiated than 07 or 09.

### 09 — strongest centered derivation-led arrangement

Item-046 groups the centered residual, its moments, affine closure, independence, and conditional residual mean in one upper block. It separates the resulting conditional mean below that block. The gap and larger standalone equation give the conclusion a distinct role rather than leaving it as the last line of one undifferentiated stack.

The 047→048→049→046 order checks the mean residual first, then cross-covariance, then Gaussian independence, then the conclusion. It still requires students to understand why this particular residual was chosen before the target equation appears; 07 offers the target earlier. The complete mathematics survives the grouping change, and the following covariance slide receives the same independent residual. Overall: best of the centered alternatives, with a real derivation-first versus result-first tradeoff against 07, not an automatic victory from whitespace.

## Shared continuity, presentation scale, and course visual language

All nine sequences use the same serif typography, muted dark text, ivory field, orange title rule, and large retrospective takeaway bullets. The additional precedents support orange vertical proof/group markers, gray source captions, carry boxes with orange captions, and layouts that combine formulas with interpretation. Items 054–056 themselves contain substantial mathematics; consistency with the course does not imply a requirement to make every slide sparse. The candidate-looking centered layouts remain stylistically compatible, although 08 changes the familiar result/proof relationship into one long chain.

At native presentation scale, the target formulas and principal prose remain readable. Density problems arise chiefly from competing mathematical units and repeated information, not visible overflow. Item-013 is the clearest case of simultaneous spatial and cognitive pressure. Items 042 and 046 illustrate the opposite caution: wide margins coexist with a multi-step proof requiring attention. In the common sensor-fusion neighbor, item-004's diagram labels are much smaller than the surrounding prose and would need verbal guidance or a closer view; the color/shape legend helps, but cannot compensate fully for their scale.

The shared marginal and covariance presentation orders contain consecutive repeats of items 036 and 041. These add no visible body change; they may serve as pauses, but the images cannot show their timing or intention. Several risk variants slightly reposition retained material and replace the early cancellation takeaway with a later risk takeaway. These are modest continuity costs, not a lost mathematical step. All sequences end their target argument with retrospective conclusions before the next application or covariance result.

The shared sensor-fusion slide visibly assumes a Gaussian prior and two conditional Gaussian measurements, but does not state conditional independence of their noises or the prior regime behind its diagram. “Equal uncertainty puts the posterior mean between the measurements” is not a general consequence of those displayed model statements: a sufficiently influential prior mean outside that interval can pull the posterior mean outside it. The schematic and precision interpretation therefore require an appropriate prior and noise setup. This limitation is shared by 01–05 and should not be attributed to a particular target variant.

## Limits of this review

This review establishes what the renders make visible to a mathematically prepared audience, not classroom comprehension, spoken explanation, timing, or accessibility under a particular projector. It does not verify the displayed Murphy citations or course-construction attributions against their sources. It cannot judge fidelity to an unseen approved contract or infer process reliability from a few outputs. Those questions require a separate Phase 2 review; this Phase 1 record must remain unchanged.
