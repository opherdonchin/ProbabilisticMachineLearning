# L04 source-arc review — Information theory: from changes of belief to coding

**Review type:** source-arc fidelity and educational value, *same-context independent analysis by ChatGPT* (not a separate Codex agent). **Scope status:** assessment only; no scope, syllabus, ledger, notebook or canonical skill edited. **Primary source:** Murphy, *Probabilistic Machine Learning: Advanced Topics*, online edition dated December 10, 2025, inspected directly; subsection names refer to that edition. This is an analysis of the selected material, not a requirement to cover the entire chapter.

## 1. Reconstruct Murphy's source argument without starting from the lab

The opening of **Chapter 5, Information theory**, explicitly calls machine learning an information-processing discipline. Murphy's first question is how to quantify a change in probabilistic beliefs: §5.1 develops KL divergence as the measure of an update, with properties and links to inference. **Entropy** (§5.2) and **mutual information** (§5.3) follow as related information measures: respectively uncertainty in a distribution and dependence/information shared by random variables. Then the chapter moves outward to *two operational uses of probabilistic models*: source coding/compression (§5.4, removing redundancy) and channel coding/error correction (§5.5, adding redundancy to withstand noise). Murphy makes the reciprocity explicit: probabilistic modeling enables compression and decoding, while information theory gives ML principled ways to think about representations and uncertainty. The information bottleneck (§5.6) reverses that direction; algorithmic information (§5.7) is a further extension.

The distinctive argument is not “a collection of formulas about entropy,” nor “a channel-decoding chapter.” It is **probabilistic measures → operational information tasks → information-theoretic perspectives on machine learning**. Reproducing all seven sections is neither feasible nor essential; preserving that bidirectional logic is.

## 2. Reconstruct the current course argument

The current [L04 scope](lecture_scope.md) opens with two message bits and a parity bit. It then develops entropy/cross-entropy/KL, derives MI and sketches DPI, works a full finite noisy-channel model, and gives an optional stronger code. It mentions the lossless source-length bound and sufficient statistics, then hands rate-distortion/IB to L12. Its notebook computes a 4×8 channel joint distribution, posteriors, MI, optimal decoding risk and resource cost. This is an intellectually coherent *communication-first* arc. It gives a practical meaning to information that is absent from a purely objectives-first lecture.

The selected three-bit code **detects** a single flipped bit but cannot guarantee correction; at the given noise level the coded and uncoded whole-message MAP error can be the same. Treating this as a contrast between information, redundancy, and decision quality is mathematically honest, not a flaw to conceal.

## 3. Arc fidelity and departures

**Judgment: justified reorganization, with one weak transition.** The core KL→entropy/MI→communication progression is recognizable from Murphy; the lecture intentionally makes a small noisy channel its opening narrative instead of Murphy's belief-update motivation. Focusing §5.5 and a constrained computation rather than full §5.4 is justified by notebook time. The risk is that students may learn *information quantities mostly as tools for decoding a message*, rather than see the broader source's reciprocity between probabilistic ML and information theory.

Specific source transitions:
- **Retained strongly:** KL/entropy/cross-entropy/MI relations (§§5.1–5.3); operational inference with a probabilistic noise model (§5.5).
- **Retained at recognition depth:** lossless source coding (§5.4.1), data-processing/sufficiency (§5.3).
- **Moved rather than fully lost:** rate-distortion (§5.4.2) and the link to learned representations/IB (§5.6), assigned selectively to L12.
- **Intentionally omitted:** more elaborate KL interpretations, variational MI bounds, bits-back, extended coding theorems, algorithmic information. Their omission does not intrinsically break the main argument.

A small conceptual issue: a parity check demonstrates *detection and posterior decision*, not **error-correction gain** in this specific lab. Thus the scope cannot claim it has operationally demonstrated reliable correction; it can demonstrate why coding and probabilistic inference are related, and why merely adding a bit does not guarantee improvement.

## 4. Minimum pedagogical repair, preserving the agreed scope

Do **not** replace the three-bit example or reopen the instructor's chosen L04 arc. Keep the same four intellectual steps and lab. Improve only the explanatory bridge: start by explicitly naming Murphy's original question—how should changes in beliefs/uncertainty be quantified?—then show why source coding removes redundancy whereas channel coding adds it. Before the final notebook handoff, put one *short* conceptual comparison in the live lecture: the probabilistic model is useful for decoding, and **KL/MI/DPI are also useful to ML representations**. State what the L12 rate-distortion return will and will not establish; do not prematurely derive the classical supervised IB objective.

The student should be able to explain the overall loop **probabilistic model → information quantities → communication task → representation-learning perspective**, rather than only compute a decoding posterior.

## 5. Feasibility and cross-course judgment

No material scope expansion is necessary. The repairs fit the existing motivations and final interpretation; adding a second source-code computation or a stronger-code notebook would be overambitious. The L12 scope must actually keep the promised bridge from MI to the VAE rate penalty rather than merely cite §5.6. **Residual risk:** the 110-minute live and 60-minute lab budgets remain untested; any extra concept must displace optional content.

**Disposition:** preserve current lecture goal and example; request a *targeted arc articulation revision* and later Section Design check. **No source-arc blocker.**
## Instructor update and review applicability — 2026-10-12

The instructor kept the reviewed **three-bit live parity example**, but subsequently assigned the **five-bit distance-three correcting code** to the *student notebook*. The previous source-arc analysis and its concerns about a detection-only **lab** reflect an earlier scope and should not be cited as review of the new student work. The new split better implements the source argument **information and communication → probabilistic decoding → demonstrated correction under a bounded error condition** while leaving KL/MI/DPI and the communication-first lecture arc intact. It adds computational scope, not lecture time; a separate instructor solution, targeted Section Design/notebook feasibility check and one-hour pilot are still necessary. This dated note does **not** claim independent approval of the amended notebook.
