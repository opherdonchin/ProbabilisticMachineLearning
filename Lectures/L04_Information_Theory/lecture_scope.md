# L04 — How much can we learn from a noisy message?

**Status:** Rewritten for an instructor familiar with the course through L03–L04. The [course register](../course_architecture_scope/STATUS.md) records the exact current review and instructor-decision status. Lecture times are estimates; future notebooks have not been implemented or run.

**How to read this scope:** Parts 1, 3 and 5 explain the teaching proposal without requiring knowledge of Murphy's books. Part 2 gives the mathematics needed by later authors. Part 4 identifies the examples and their sources. “Derive” means show the calculation; “state” means explain the result without proving it; “apply” means use something already taught. Live teaching and the separate notebook session have their own budgets. These are lecture-wide commitments, not a section or slide outline. Every later section must finish by summarizing what it taught; connections to earlier work belong at the beginning of the receiving section.

**Instructor decision:** Use the lighter two-message-bit plus one-check-bit example. Reference the stronger error-correction result rather than require its calculation. The simpler example remains mathematically correct when described honestly: it can detect a single-bit error, but cannot identify which bit changed or guarantee recovery of the original message. We narrow the teaching outcome accordingly. This replaces the previous five-bit correction exercise; it does not weaken the information-measure definitions or proof commitments.

## 1. Intellectual arc

Suppose we send two bits, such as `00` or `10`, through a noisy channel. Adding one extra bit can tell a receiver that something has gone wrong. It cannot always tell the receiver what the original message was. This small example lets students distinguish uncertainty, information gained from an observation, and the success of a particular guessing rule.

The lecture uses finite probability tables, Bayes' rule and familiar entropy/KL ideas. It does not assume knowledge of coding theory or Murphy's chapter contents.

1. **Uncertainty and a mismatched probability model — 24 minutes.** Explain entropy as average uncertainty, cross-entropy as average log-score cost under a chosen probability model, and KL divergence as their difference. KL means *Kullback–Leibler divergence*, a directed measure of discrepancy between distributions. Work a binary example. Briefly state the relation between entropy and lossless description length: removing unnecessary bits is a different task from adding check bits to withstand noise. End with a summary of those distinctions.
2. **How an observation reduces uncertainty — 22 minutes.** Introduce *mutual information*: average uncertainty about one variable removed by observing another. Derive its equality with KL between a joint distribution and the product of its marginals. Work one fair bit independently flipped with probability `α`. Information reduction is an average; not every realized observation must reduce uncertainty. End with the meaning and calculation of mutual information.
3. **Processing an observation cannot recover information already lost — 16 minutes.** Compare reversing the labels of a received bit with throwing it away. Sketch the *data-processing inequality*: when Z is obtained from Y without new information about X, Z cannot tell us more about X than Y does. Briefly connect a sufficient statistic to retaining all information about a specified parameter, not retaining every detail of the original data. End by summarizing the condition and equality interpretation.
4. **One check bit: detect an error, then make an uncertain guess — 36 minutes.** Encode `(m1,m2)` as `(m1,m2,m1 XOR m2)`. XOR is 1 when its two inputs differ and 0 when they agree. List the four valid words. A single changed bit violates the check, but can produce a received word compatible with three different originals. Work the three-way tied posterior for `100`. A decoder may still select a most probable message, but that is a guess, not guaranteed correction. Compare information, probability of a wrong whole-message guess and number of transmitted bits. Reference the stronger minimum-distance-three result and optional five-bit construction without requiring a second calculation. End with the honest capability and limitation of the chosen code.

**Time:** retain the **110-minute live envelope**: 98 teaching minutes plus 12 for questions/slippage, and a separate **60-minute notebook**. The smaller code reduces bookkeeping; the original envelope remains an upper planning allowance, not a reason to add topics. Timing is unmeasured. First shorten the optional stronger-code reference and the sufficient-statistic recall. Full numerical information aggregation can remain lab-owned if needed; keep the mutual-information derivation, processing proof sketch, parity limitation and resource comparison live. No required recording.

**Other routes considered:** A compression-first lesson would emphasize shorter descriptions instead of noisy transmission. A representation-first lesson would emphasize what a summary retains. The selected communication example gives a concrete task with fewer new concepts, while preserving both connections briefly.

**Rough authoring check:** the smaller primary code gives approximately four major responsibilities, 8–10 substantive source-page equivalents, 10–13 new equation/result families, 12–20 repeats of earlier formulas, 7–11 intermediate algebra blocks and 4–6 conceptual picture groups. The provisional timing formula gives about 19–24 content-slide equivalents. These revised estimates exclude the former required five-bit proof/table; they are not a slide target or measured timing. L01's 61 content slides are only a comparison anchor.

## 2. Mathematical spine

All information calculations here use base-2 logs, in **bits**. Later likelihood calculations use natural logs, in **nats**; bits equal nats divided by `ln 2`. Random variables use capitals. `M` is the two-bit message, `C=c(M)` the transmitted three-bit word and `Y` the noisy received word.

| Mathematical commitment | Purpose and treatment |
|---|---|
| `H(p)=−Σp log₂p`; `h₂(α)=−αlog₂α−(1−α)log₂(1−α)` | Motivate and work finite uncertainty. State `0≤H(X)≤log₂|X|`; recall rather than repeat L02 maximum entropy. |
| `H_ce(p,q)=−Σp log₂q`; `KL(p||q)=H_ce−H` | Derive the identity and work a binary example. State nonnegativity, direction/asymmetry and support convention: `0log0=0`; positive p with zero q gives infinite divergence. |
| Empirical cross-entropy `−N⁻¹Σ_n log₂q(x_n)` | Apply to recalled categorical counts and likelihood fitting. This finite identity is not an assertion about KL from point masses to continuous densities. |
| Best binary prefix-code average length `H≤L_min<H+1`; independent n-symbol blocks `H≤L_min,n/n<H+1/n` | State/explain, no code-construction or theorem proof. A prefix code permits unique reading of concatenated words; integer lengths differ from ideal fractional information lengths. This is lossless source coding, not our check-bit model. |
| `H(Y|X)=−Σp(x,y)log₂p(y|x)`; `H(X,Y)=H(X)+H(Y|X)` | State conditional averaging and derive the chain rule briefly. |
| `I(X;Y)=KL(p_xy||p_xp_y)=H(Y)−H(Y|X)` | Derive by expanding one finite sum. State symmetry, nonnegativity, the joint-entropy equivalent and zero iff independence. Work a fair bit-flip channel: `I=1−h₂(α)`. |
| Conditional `I(X;Y|Z)` is average conditional KL, hence nonnegative; `I(X;Y,Z)=I(X;Y)+I(X;Z|Y)=I(X;Z)+I(X;Y|Z)` | State/explain enough to follow the processing proof, not a separate result catalogue. |
| `X⟂Z|Y ⇒ I(X;Z)≤I(X;Y)` | Proof sketch using the two decompositions and zero conditional information. Work invertible recoding versus constant output. |
| `θ⟂D|S(D) ⇒ I(θ;S(D))=I(θ;D)` | State/motivate using Bernoulli counts under an explicit joint prior/data model. A sufficient statistic preserves parameter-relevant information, not literal sample reconstruction. |
| `c(m)=(m1,m2,m1 XOR m2)`; `p(y|m)=α^d(1−α)^(3−d)` | Work the three-bit channel; d is the number of differing bit positions (*Hamming distance*). Noise flips each position independently. Uniform message prior, known α. |
| `p(m,y)=p(m)p(y|m)`; `p(y)=Σ_m p(m,y)`; `p(m|y)=p(m,y)/p(y)` | Work the tied example live; full 4×8 table in the lab. A maximum-a-posteriori (MAP) decoder chooses a message with greatest posterior probability. State tied maximizers explicitly. |
| For a uniform message prior and `0<α<1/2`, likelihood decreases with distance | Derive briefly: one more differing position multiplies likelihood by `α/(1−α)<1`. A nearest valid word is therefore a most probable message, but several can be equally near. Boundary noise values are checked separately. |
| Every pair of distinct valid words has distance 2 | Work the parity/detection implication: one changed bit creates an invalid word, but the original is not uniquely identified. Briefly state the stronger result: minimum distance at least 3 guarantees unique nearest-word correction after at most one bit error. No required five-bit table/proof/enumeration. |
| `H(M)=H(C)=2`; `H(Y|M)=3h₂(α)`; `I(M;Y)=H(Y)−3h₂(α)` | Derive conditional entropy from independent noise, apply mutual information. Full received marginal/curve calculation is lab-owned. Two bits of message uncertainty do not become three just because representation is longer. |
| Optimal whole-message error `P_error*=1−Σ_y max_m p(m,y)`; rate `2/3` message bits per transmitted bit | State and explain: for each received word, success mass is the largest joint entry. Complete calculation in lab; rate is a resource count, not channel capacity. |

L06/L09 reuse KL nonnegativity; L12 reuses entropy, mutual information and processing. Neither the lower-bound identity used for hidden variables nor L12's lossy-compression optimization is taught here.

## 3. Notebook handoff — one complete small channel

Students extend the lecture's one or two observations to **all four messages and eight possible received words**, only 32 joint entries. They fill a supplied NumPy table, check normalization, calculate mutual information in two equivalent ways and evaluate posterior guessing, including ties. A supplied noise sweep compares coded transmission (three uses) with the same message sent uncoded (two uses).

**Students write:** small probability/marginal/posterior operations, information calculations and interpretation of the decoding comparison. **Supplied:** bit-word generation, array-axis explanation, plotting, sweep driver and any tie-policy simulation. No pgmpy or new inference package; no external dataset. The reference uses a larger graphical-model software stack, but its probability model can be enumerated directly.

Allocate 10 minutes to arrays/axes, 15 to probability tables and checks, 15 to information/posterior guesses, 15 to the provided noise sweep and uncoded comparison, and 5 to interpretation. An extra simulation is optional outside the hour. There is no five-bit student task.

**Required checks:** each channel row, joint table and received marginal sum to one. Posterior columns normalize only when `p(y)>0`. Both information calculations agree and lie between 0 and 2 bits. At α=0, only four received words are possible; an impossible word has no posterior. At α=0.5, all messages have posterior 1/4, information is zero and optimal whole-message error is 3/4. A first-index `argmax` does not prove a unique answer. State the tie policy if guesses are simulated; exact optimal aggregate error is unchanged by choosing among equally probable maximizers.

**Lab conclusion:** the check bit detects a one-bit error, yet cannot guarantee correction. Extra retained information and better whole-message accuracy are different claims. Label information per message and per transmitted bit, and show that the coded model uses more resources. A validated worked solution, numerical checks, workload trial, local uv run and hosted Colab run remain future work.

## 4. Concrete examples and source checks

### Binary uncertainty and processing

Course-chosen `p=(0.8,0.2)`, `q=(0.5,0.5)` give entropy `0.721928` bits, cross-entropy 1 bit and KL `0.278072` bits. A separate fair source bit flipped with probability 0.2 has mutual information `1−h₂(0.2)=0.278072` bits. The equal numerical value belongs to these particular examples, not a general identity equating KL and channel information.

For processing, let `Y=X XOR E`, with fair X and independent `E~Bernoulli(α)`. Replacing Y by `1−Y` retains information; replacing it by constant zero loses all information. Bernoulli counts give a brief sufficient-statistic recall.

### Primary three-bit code

| Message | Transmitted word |
|---|---|
| 00 | 000 |
| 01 | 011 |
| 10 | 101 |
| 11 | 110 |

The last bit checks whether the first two agree. Every valid word has an even number of ones. Exactly one flip changes that parity. Two flips can produce another valid word and go undetected; the check is not a detector of every possible corruption.

At `α=1/5`, received `y=100` is one bit away from `000`, `101` and `110`, and three bits away from `011`. In table order its posterior is `(16,1,16,16)/49`. Each leading candidate could have produced the same received word through one flip. A guessing rule can choose one, but cannot call it guaranteed recovery. Received `000` instead has posterior `(16,1,1,1)/19`; a unique most probable guess still has uncertainty.

**Complete-model check at α=0.2:** `H(Y)≈2.966078` bits, `H(Y|M)=3h₂(0.2)≈2.165784`, `I(M;Y)≈0.800294` bits/message and optimal whole-message error `9/25=0.36`. Uncoded two-bit transmission has information `≈0.556144` bits/message and the **same** optimal whole-message error 0.36. Coded information per use is `≈0.266765`, versus uncoded `≈0.278072`. These values warn against presenting any extra check bit as guaranteed accuracy improvement. Exact-fraction enumeration of all 32 pairs checked row/joint normalization, both posteriors and error; floating-point entropy checked the information values. This verifies the small model, not a student notebook or teaching duration.

**Optional stronger reference:** the earlier course-created code `c=(m1,m2,m1,m2,m1 XOR m2)` has words `00000,01011,10101,11110` and minimum distance 3, sufficient for correcting one error. It may be mentioned or linked as the stronger construction. Its posterior calculations, 4×32 enumeration and performance numbers are no longer required outcomes.

### Provenance

Book 2 Ch. 5 is primary: selected §§5.1.2–5.1.3/5.1.6 for discrepancy and fitting, §§5.2.1/5.2.4 for finite entropy/cross-entropy, §§5.3.1–5.3.4 for mutual information/processing/sufficiency, §5.4.1 for lossless coding context and §5.5/Fig. 5.11 for the parity-channel example. Book 1 §§6.1.1–6.1.4, 6.2.1–6.2.4, 6.3.1–6.3.4 and 6.3.8–6.3.9 provide finite-sum explanations. The primary [MIT 6.450 Lecture 3](https://ocw.mit.edu/courses/6-450-principles-of-digital-communication-i-fall-2009/f57623d4056984d18685fdb37cea01d6_MIT6_450F09_slide03.pdf), PDF pp. 3 and 13, inspected 2026-10-11, supplies the finite upper bounds; its construction/proof material is not added.

The inspected [parity-code notebook, fixed revision](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/05/error_correcting_code_demo.ipynb), SHA-256 `b557bf8b97488541d1f11b88a6b92ad172b0f4d7501de8c92fe00f634ba04cd1`, uses this three-bit encoder, uniform messages, flip probability 0.2 and received `100`. It calculates joint/marginal posterior with pgmpy/probml-utils and installation cells; these APIs and dependencies are not course requirements. It was inspected, not executed. The support is exactly the four valid words above; an incomplete printed list of invalid words is not adopted. Figs. 5.4/5.6/5.11 are explanatory references, not promised reproduced figures. The smaller model matches Murphy's encoder; our exact checks and uncoded comparison are course calculations.

### Evidence about the earlier course

L01's actual slides and missing-data solution establish joint and conditional probabilities, Gaussian conditioning and numerical checks. The solution hides three coordinates of a known seven-dimensional Gaussian; it compares a numerical calculation with the exact conditional distribution. It does not teach how to estimate the unknown Gaussian parameters or prove a sampling algorithm correct. L02's agreed `section_design.md` promises exponential-family distributions, derivatives of their normalizing function, likelihood moment matching and simple categorical/Markov-chain fitting. These are planned prerequisites, not evidence that L02 has already been delivered. If delivery changes, the coordinator must revisit the affected prerequisite and time budget.

The material ledger's recorded delivered boundaries remain Book 2 §2.3.2 and Book 1 §3.3. The actual L01/L02 files are protected. L02's malformed development-state text does not establish additional approval. The [source-inspection register](../course_architecture_scope/source_inspection.md) identifies the textbooks and reference files inspected for the proposal: Murphy Book 2, online edition December 10, 2025; Book 1, April 18, 2025. Source inspection is not notebook execution.

**Original proposal provenance:** builder `/root/build_l04`, 2026-10-11; starting HEAD `906ce71dd9c8e29f3dede51ec809442a885354c9`, contract checkpoint `374bc6d`, contract v1 blob `882a9b2e76134d4952b218492a3564e117f6d6b4`. The original preliminary brief is preserved in [Git history](https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/906ce71dd9c8e29f3dede51ec809442a885354c9/Lectures/curriculum_scope_previews.md). Readability/substantive revision: `/root/readable_early`, under the instructor's current choice of the lighter model. Previous five-bit reviews do not approve this changed decoding outcome.

## 5. Lecture contract

**Start:** finite probabilities, Bayes' rule, L02's entropy/categorical background and elementary conditional independence. **Question:** what does a noisy observation tell us, and what does one check bit help us do? **Lecture result:** derive mutual information, follow the processing proof sketch, understand lossless-description bounds and compute a small message posterior with an honest detection-versus-correction distinction. **Lab result:** complete the 4×8 model and compare information, guessing error and transmission cost. No required recording.

Students can distinguish entropy/cross-entropy/KL, calculate information reduction, explain the processing condition, detect the specified single-bit errors and interpret uncertain/tied message guesses. They do **not** claim reliable one-error correction from the three-bit code.

Selected finite information/coding material is core. Full coding-theorem proofs, code-design algorithms, continuous entropy/typical-set theory, KL geometry and advanced information bounds are omitted; students are not being trained to design efficient practical communication systems. Technical exclusions remain the fuller Book 2 §§5.1.1–5.1.2/5.1.5/5.1.7–5.1.10, §§5.2.2–5.2.3, §§5.3.5–5.3.7, §5.4.3, §5.6 and large-code inference §9.4.8. L12 owns §5.4.2's tradeoff between compressed representation and reconstruction loss; naming it here is not coverage.

**Remaining uncertainty:** table interpretation and zero-probability handling need a teaching trial; sufficient-statistic equality needs its explicit random-parameter framing. The lighter-code selection is instructor-agreed. The syllabus, ledger and notebook record use the selected three-bit detection and uncertain-decoding task. The [current revision review](../course_architecture_scope/reviews/readability_revision_review.md) records the independent check of this changed example; the stronger five-bit result is reference material.
