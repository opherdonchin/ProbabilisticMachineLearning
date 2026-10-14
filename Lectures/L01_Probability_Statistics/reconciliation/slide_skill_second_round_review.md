# Fresh quality review of two isolated L01 candidates

Case A is **revision-needed, narrowly at the executable design-source level**: the production slide satisfies its mathematical and visual contract, but two squared norms in the design lack matched-delimiter attachment grouping. Case B is **ready within the supplied experimental one-slide contract**. Neither verdict approves production promotion or establishes classroom validation.

| Criterion | Case A: conditional squared-error risk | Case B: affine moments |
|---|---|---|
| Required mathematics and visible assumptions | Ready | Ready |
| Production typesetting and grouping | Ready | Ready |
| Executable design grouping | Revision needed at lines 33 and 53 | No material concern found |
| Semantic roles and reveal fidelity | Ready, subject to the design-source notation issue | Ready |
| Comparative visual alignment | Ready at the supplied preview scale | Ready at the supplied preview scale |
| Inspected output coverage | All 4 presentation states and 1 handout | All 4 presentation states and 1 handout |

This was a fresh read-only review against the supplied briefs, current repository instructions, Slide Design and Slide Authoring skills/conventions, `design.typ`, relevant `course.typ` helpers, and `/tmp/l01-skill-test-criteria.md`. I inspected the four permitted neighboring renders (pages 48, 62, 63 and 66) and their supplied source extract. I did not read the forbidden original slide sources/renders, prior trial outputs, process reviews, reconciliation discussion, builder reports or coordinator hypotheses. The candidates' development and exposure histories were not independently established; this review does not certify either as an untouched holdout. The criteria's slide-64 completeness requirement is prerequisite context, not a claim that this review inspected slide 64.

**Case A: mathematics and teaching roles.** With observed $y$ fixed, the slide defines $m=E[z\mid y]$, $C=\operatorname{Cov}[z\mid y]$, $r=z-m$, allows every $a\in\mathbb R^d$, and displays $E[\|z\|^2\mid y]<\infty$. It then shows both needed expectation calculations:

$$
E[r^T(m-a)\mid y]=E[r\mid y]^T(m-a)=0,
\qquad
E[\|r\|^2\mid y]=\sum_{j=1}^d E[r_j^2\mid y]=\sum_{j=1}^d C_{jj}=\operatorname{tr}C.
$$

These justify $R(a\mid y)=\operatorname{tr}C+\|a-m\|^2$, the singleton minimizer set $\{m\}$, and minimum risk $\operatorname{tr}C$. The squared-distance term visibly establishes uniqueness over the unconstrained action space. The conditional Gaussian is identified afterward by $m=\mu_{z\mid y}$ and $C=\Sigma_{z\mid y}$; the preceding argument does not depend on Gaussianity. Conditional notation and the displayed finite conditional second moment are adequate for this pointwise argument at the fixed observation. The design metadata additionally states the pointwise almost-sure interpretation for random observations.

The recalled expansion stays in a smaller Context region with prior-slide provenance. The vanishing cross-term and trace identity receive ordinary proof attention outside that region. The decomposition/minimizer is larger than the surrounding proof lines, and both interpretive sentences are in the separate course `key-points` wrapper ([production lines 28–80](/home/opher/Repositories/ProbabilisticMachineLearning/tmp/l01-skill-test/development65/slide_deck.typ:28)). No new proved equality is relegated to recall.

State 1 contains recalled context and the centered cross-term proof; state 2 adds residual energy; state 3 adds the risk decomposition and minimization; state 4 adds Gaussian identification and interpretation. All previous mathematics persists with stable positions. The Gaussian notation remains consistent with neighboring pages 63 and 66. Against page 48's proof precedent, this uses a stacked derivation rather than two columns, but preserves the same functional distinction between inspected mathematics and a lower declarative conclusion. The final object remains coherent, with no competing explanatory headings. The proof is somewhat smaller than page 48's proof, but readable at the supplied 1263-by-711 previews; I found no clipping or broken equation line. The handout contains the same complete content as presentation state 4.

**Case A's bounded source issue.** The design uses `||m-a||^2` at [line 33](/home/opher/Repositories/ProbabilisticMachineLearning/tmp/l01-skill-test/development65/slide_design.typ:33) and `||a-m||^2` at [line 53](/home/opher/Repositories/ProbabilisticMachineLearning/tmp/l01-skill-test/development65/slide_design.typ:53). Local Typst documentation describes matched delimiters and attachments. Fileless parsed-content probes give:

```text
typst eval 'repr($ ||m-a||^2 $)'
sequence([‖], [m], [−], [a], attach(base: [‖], t: [2]))

typst eval 'repr($ norm(m-a)^2 $)'
attach(base: lr(body: sequence([‖], sequence([m], [−], [a]), [‖])), t: [2])
```

The same difference occurs for `a-m`. The bare form attaches the exponent to the closing bar rather than to a matched norm object. Production uses the explicit `norm(...)^2` form at lines 38 and 58 and renders the intended squared norms. This is **not evidence of a wrong printed production formula**, but it is a real executable-design grouping inconsistency under the current skills' requirement to verify delimiter/attachment structure rather than accept a legal parse. The attachment checker does not flag it.

Owner: Slide Design. Smallest repair: use explicit norm constructors in those two existing equations, then check the design math and its render. This changes no mathematical commitment, layout, reveal or teaching time; no production layout revision is indicated by this evidence. The source pair should not be described as fully checked and faithful without recording or reconciling this difference. Production's mathematical and visual judgments above stand separately.

**Case B: mathematics and teaching roles.** The setting visibly states $x\in\mathbb R^d$, $y=Ax+b\in\mathbb R^m$, deterministic $A\in\mathbb R^{m\times d}$ and $b\in\mathbb R^m$, $E[x]=\mu$, $\operatorname{Cov}[x]=\Sigma$, and $E[\sum_i x_i^2]<\infty$. The new proof shows the mean, the cancellation of translation in centering, and all four covariance lines:

$$
\mu_y=A\mu+b,\qquad y-\mu_y=A(x-\mu),
$$
$$
\Sigma_y=E[(y-\mu_y)(y-\mu_y)^T]
=E[A(x-\mu)(x-\mu)^TA^T]
=AE[(x-\mu)(x-\mu)^T]A^T
=A\Sigma A^T.
$$

The deterministic-map condition supports pulling both matrix factors outside expectation. No rank or invertibility restriction is introduced. The Gaussian interpretation refers to a Gaussian cloud and invokes the already available affine-closure rule; the slide does not purport to derive Gaussianity from finite second moments. Translation versus linear mapping is stated in the separate key-point region. A parsed-content probe of `E[(y-mu_y)(y-mu_y)^T]` confirms that `T` attaches to the entire second centered-vector parenthesis, agreeing with the intended outer product and the visible typesetting.

The setting is an ordinary object and the moment proof is a newly derived, visibly distinct proof object, matching the design roles ([design lines 25–71](/home/opher/Repositories/ProbabilisticMachineLearning/tmp/l01-skill-test/affine_transfer/slide_design.typ:25)). Production preserves the side-by-side setting/proof relationship and uses the course interpretation slot below ([production lines 18–66](/home/opher/Repositories/ProbabilisticMachineLearning/tmp/l01-skill-test/affine_transfer/slide_deck.typ:18)). This closely follows page 48's mathematical object/proof/lower-conclusion division; the short “Moment proof” title serves intrinsic proof grouping rather than duplicating the takeaways.

State 1 shows the setting and complete mean line. State 2 adds and transiently emphasizes the centered-vector identity. State 3 returns that identity to normal and adds/emphasizes the whole covariance calculation. State 4 removes that emphasis and adds the interpretation. All required equations persist, the column geometry stays fixed, and the handout shows the complete state without transient emphasis. The covariance calculation is legible and syntactically cohesive; both emphasis outlines enclose their requested new material without visible clipping. I found no material concern requiring a layout or mathematical revision.

**Mechanical evidence and limits.** The existing [Case A manifest](/home/opher/Repositories/ProbabilisticMachineLearning/build/slide-review/development65/slide_deck/report.json) and [Case B manifest](/home/opher/Repositories/ProbabilisticMachineLearning/build/slide-review/affine_transfer/slide_deck/report.json) each report one handout page, four presentation pages, and no warnings. Fresh source hashing matches their exact recorded SHA-256 values. A fresh run of `scripts/check_typst_math_attachments.py` over all four candidate `.typ` files reports no possible run-on attachments. These checks corroborate mechanical validity and render/source identity; they do not decide the visual verdicts. I inspected all ten manifest PNGs individually. I did not independently rebuild the candidates or inspect an A4 design-document render, so design-document pagination is outside this review. Readability is assessed at the supplied preview scale and against the permitted predecessors, not at an actual classroom projection distance. Both candidates remain experimental, and two cases provide no general guarantee about the skills.

**Targeted recheck — 2026-10-14, 12:13:25 UTC.** The initial finding and verdict above are preserved as the assessment of the original supplied design. A separate designer has now repaired precisely the two cited norm constructs. This read-only recheck examined those constructs and source identity only; it did not reopen either complete trial or provide a new held-out validation.

The current design's line 33 ends with `+norm(m-a)^2`, and line 53 reads `R(a|y)="tr" C+norm(a-m)^2`. Fileless `typst eval` parsed-content probes for both expressions return an `attach` whose base is an `lr` object enclosing the complete norm argument and whose top attachment is `2`. Thus both repaired exponents now attach to matched norm objects, resolving the specific source-level finding.

Exact SHA-256 evidence:

| Check | Observed SHA-256 |
|---|---|
| Current Case A design | `30e14ffccf350d985c047a6438a8898a75b258fe7fe3e3856f7f566c84c1067d` |
| Current design with only these two substitutions reversed in memory | `00cf4dff699c5c52c7323d7472d36358e5373eaf2c976a9d86a2ed5a6547af0f` |
| Current Case A production | `f9f49b9d6c40da43252347c8e12f72f33be1ef759f13e90309e45613529c95b4` |

Each repaired expression occurred exactly once. Reversing `+norm(m-a)^2 $` to `+||m-a||^2 $` and `"tr" C+norm(a-m)^2 $` to `"tr" C+||a-m||^2 $` restored the specified reviewed-design hash. This establishes that the repaired design differs from that reviewed version only by the two intended substitutions. No source file was written during this check. Production's hash remains the exact initially reviewed version.

**Disposition:** the bounded Case A executable-design grouping issue is resolved. Case A is now **ready within the supplied experimental one-slide contract**, carrying forward the initial production mathematics, visual, role and reveal judgments without a fresh full review. Case B's initial verdict is unchanged. I did not inspect the optional design-recheck PDF, so this disposition does not add design-document pagination or render approval. No production promotion or classroom validation is authorized by this recheck.
