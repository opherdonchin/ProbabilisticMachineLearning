# L04 Iris handoff — Section Design feasibility preview

**Verdict: feasible-with-risks.** The retained live route can plausibly prepare the selected Iris evaluation endpoint within the estimated 110-minute lecture and separate 60-minute lab. There is no identified prerequisite or mathematical blocker at scope level. The lab is tight, and its feasibility depends on the promised supplied forecasts, plots, finite-law calculations and short conditional-score explanation. This is an independent preliminary feasibility review, not Section Design construction, instructor approval, downstream validation or evidence of a successful student hour.

## Exact target and evidence

Reviewed 2026-10-14 in `/tmp/pml-l04-l12-reconciliation`, branch `assess-l04-l12-reconciliation-20261014`, HEAD `b5bdb7c7fe2d0c1fcbbbfea8ec5d7cd2245a4a2e`. Target: `Lectures/L04_Information_Theory/lecture_scope.md`, Git blob **`79b8d471b2d0605bccb61c9f8b130c012b7ac68a`**, matching the delegated target on initial reading and before writing this report. The instructor's Iris endpoint selection is an input; acceptance of the complete revised scope is not inferred.

Upstream artifacts inspected and their Git blobs:

| Artifact | Blob |
|---|---|
| `course_architecture.typ` | `cb111196e44df211e39864be596233a1a3f22aba` |
| `curriculum_map.typ` | `21665f052e031ac569a346f01ee7783d12b580b3` |
| `curriculum_map_actual.typ` | `cf143d8c5427030cf3ac6c6ad05d8ad9cd420fe3` |
| L02 `section_design.md` | `bbf78a13db05224a839d0b2f8bda4c7a5bd0c764` |
| L03 `lecture_scope.md` | `2d5992a3f05d952dc21553690039fe021fd6284a` |

Also inspected relevant L01 prepared deck/notebook material, repository instructions, the Section Design skill, shared backpressure protocol and timing calibration. L01 introduces Iris and conditional probability; the missing-data notebook supplies experience with numerical conditioning, not classifier calibration. L02 promises normalized categorical counts, conditional transition probabilities and sequence scoring. L03 promises graphical conditional-independence reasoning. None has been taught; L01–L03 are evolving in a separate reconciliation stream. These are prospective dependencies to revisit, not claims about current student competence.

Direct source check: Murphy, *Probabilistic Machine Learning: Advanced Topics*, online edition December 10, 2025, local PDF SHA-256 `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`, at `/home/opher/OneDrive/CurrentSemester/Teaching/Advanced Bayesian Statistics/Oke Advanced Probability Course/book2-1.pdf`. Inspected printed pp. 237–240 (PDF pages 271–274) and pp. 578–579 (PDF pages 612–613). Focused reading: §5.2.4 **Cross entropy and perplexity** for empirical averaging; §14.2.1 **Proper scoring rules** for the conditional target expectation; §14.2.2.1 **Expected calibration error** for confidence, correctness and binning; §§5.3.1–5.3.3 for finite MI and its processing condition. No prior critique or author defense was read to form this verdict. The source-inspection register was used to identify the edition, not as a substitute for checking these passages.

## Why the route is constructible

The reusable argument remains distinct from the notebook product: distributions have uncertainty and discrepancy; observations retain a selected dependency; a decision rule and a resource budget measure other aspects of success. The live parity example provides an exact case where more information per message does not improve whole-message accuracy, and its information advantage disappears when measured per transmitted bit. Independent enumeration reproduced the stated posteriors, `H(Y)=2.9660780976`, `I(M;Y)=0.8002938129` bits/message and optimal error `9/25`. These calculations support the conceptual contrast; they do not substitute for practical ML evaluation.

The notebook can extend the live finite cross-entropy identity without assuming L05. With finite species labels and a possibly continuous predictor vector, condition on each `x`, apply the categorical identity, then average over the target predictor law:

$$
R_{\log}(q)=E_p[-\ln q(Y\mid X)]
=H_p(Y\mid X)+E_{p(X)}\mathrm{KL}(p(Y\mid X)\|q(Y\mid X)).
$$

Only the label variable needs to be finite. This is conditional label entropy, not differential entropy of Iris measurements. The identity explains the expected criterion; one observed label per test row does not reveal the unknown conditional law or its KL. The supplied explanation must establish that distinction before students interpret their empirical mean. Its promised treatment is **supply/explain, then apply**, not a second live derivation or a full scoring-rule module.

Likewise, the error students compute is the empirical error of a particular forecast's label rule:

$$
\widehat R_{01}(q)=N^{-1}\sum_n\mathbf1\{\arg\max_c q(c\mid x_n)\ne y_n\},\qquad
\widehat R_{\log}(q)=-N^{-1}\sum_n\ln q(y_n\mid x_n).
$$

Accuracy is `1−` empirical error. Both means estimate performance for fixed forecasts on fresh cases from the evaluation law; neither proves population superiority. The first is not the live channel's **optimal** Bayes error, whose exact target law was supplied. The second rewards probability assigned to the realized label, not simply a large maximum probability. Equal predicted labels imply equal accuracy on the same cases, but can produce different log losses; increasing confidence need not improve the latter.

The training-class-frequency baseline is mathematically valid and interpretable: it ignores predictors while using the same label space, training information and test cases. It is a useful ordinary comparison, not a Bayes-optimal classifier or an automatically representative deployment prior. The held-out sample and Iris sampling design delimit the conclusion. No model ranking or calibration improvement is promised, so the prepared package can remain honest if a particular comparison is inconclusive.

The live budget is plausible but not generous: the conditional-entropy/MI expansion and processing proof are the main novel dependencies, while categorical normalization and likelihood products have prospective support. The 36-minute code treatment remains bounded only because the full aggregation is supplied. The calibration model's 19–24 slide equivalents are a weak density check, not a timing guarantee. The lab's allowances total exactly 60 minutes with only five minutes for debugging/consolidation; explanation and interpretation, rather than fitting or arithmetic, are its main pressure points.

## Material issues and smallest repairs

### 1. Retained live emphasis versus the selected ML endpoint

**Owner/severity:** Lecture Scope / advisory; instructor-owned emphasis choice. **Evidence:** the live arc spends 36 minutes on parity and supplies conditional scoring/calibration context only in the lab (§§1, 3, 5). Architecture L04 identifies evaluation of actual predictions as the practical destination. The mathematical bridge is available, but the communication example alone does not teach what an Iris forecast or reliability check means.

**Provisional treatment:** preserve all retained live commitments and keep the explicit application bridge in the lab. **Smallest repair:** record whether the instructor accepts that division of intellectual labor as the complete scope, rather than inferring it from the Iris endpoint selection. **Impact:** acceptance leaves coverage unchanged; choosing greater live ML emphasis requires Scope to name its time/depth tradeoff within 110 minutes. A reviewer cannot implement that rebalance.

### 2. The hour depends on bounded explanation and interpretation

**Owner/severity:** Lecture Scope / advisory; subsequent worked-solution and notebook authors own measurement and scaffolding. **Evidence:** §3 allocates 8 minutes to roles/dimensions, then scoring, baseline comparison, confidence diagnosis, reliability and MI. The conditional target/empirical-score distinction has no separate allowance and must fit within those stated explanatory intervals. Supplying a plot does not eliminate its conceptual cost.

**Provisional treatment:** require short supplied explanations and ready-to-inspect objects as already promised; do not demand a conditional-scoring proof, ECE implementation, MI estimator or second fit. **Smallest repair:** explicitly account for the conditional bridge within the existing lab estimate and test interpretation time in a student-time pilot. **Impact:** no missing mathematics needs a new module. An overrun discovered after scaffolding should return to Scope for a depth decision; the score/baseline comparison must remain intact. Timing cannot be certified at this preview stage.

### 3. Reliability supports a narrower claim than full multiclass calibration

**Owner/severity:** downstream-owned explanation/source correctness. **Evidence:** §3 requests average confidence versus observed correctness. Set `C=max_c q(c|X)` and `A=1{Y=argmax_c q(c|X)}`. The relevant ideal relation is `E[A|C]=C`; supplied bins approximate this relationship on a finite sample. Matching it does not establish calibration of every species probability or equality with `p(Y|X)`. Small bins increase uncertainty. The source itself distinguishes the top-label check from multiclass marginal calibration on p. 579.

**Provisional treatment/minimal repair:** call the supplied object a **top-label confidence-versus-correctness reliability summary**, show counts, and describe only the evidence it supplies. Carry the empirical-versus-expected score distinction above into the same interpretation. **Impact:** wording and the supplied notebook explanation suffice; no additional calibration method or instructor choice is needed.

**Exact source caution:** §14.2.2.1 begins on printed p. 578 and continues on p. 579. The printed Eq. 14.19 weights each bin by `|B_b|/B`, where `B` was defined as the number of bins; the sample-weighted ECE requires `|B_b|/N`. PDF page 613 was rendered and visually inspected to confirm that this is a printed formula error, not text-extraction damage. The chosen notebook does not require ECE computation. If an author reuses that formula, correct it and retain the source-error attribution. This is a correctness repair, not an approval question.

### 4. A joint label/representation table alone does not specify a DPI comparison

**Owner/severity:** downstream-owned mathematical object/provenance. **Evidence:** §3 supplies a finite `p(Y,Z)` and a stated processing relation. That joint table determines `I(Y;Z)`, but a comparison to an earlier representation needs its joint law or processing kernel as well. Relabeling the live variables also changes the direction: a predictor representation has `Y→X→Z` when `Z` is formed from `X` without label information, rather than assuming the live `X→Y→Z` labels retain their meaning.

**Provisional treatment/minimal repair:** supply the relevant predecessor variable and deterministic map or stochastic kernel under the same identified finite law. A deterministic further coarsening of a supplied discrete representation suffices; a second estimator is unnecessary. If an empirical Iris table is used, the claimed identity/inequality concerns that empirical law, not unknown population information. **Impact:** object validation and explanatory precision can be solved downstream without changing endpoint, depth or time. Do not infer a numerical population DPI comparison from a standalone `Y,Z` table.

## Confidence, limits and next owner

Confidence is moderate in mathematical reachability and lower in the student-hour estimate. No forecast package, chosen split, reliability outputs or finite-information law yet exists for inspection; there was no notebook execution, student pilot or independent timing rehearsal. The source check was focused on the new bridge, not a re-audit of every retained coding/source-bound claim. Upstream reconciliation or actual delivery can change the assumed student entry state and require a targeted dependency check. Every later section still must end with a retrospective summary; the notebook handoff remains separate.

**One next consequential Scope decision for the coordinator:** obtain explicit acceptance, or an explicit rebalance, of the retained communication-led live route with conditional-score and top-label reliability context supplied in the lab. The recommendation from this feasibility preview is that retaining that route is plausible under the stated scaffolding and subsequent timing check. The endpoint selection does not settle this choice. Source/metric corrections above belong to authors and do not need instructor approval. No section contracts, outline, slides, notebook questions/code, implementation, approval, merge or publication were produced.
