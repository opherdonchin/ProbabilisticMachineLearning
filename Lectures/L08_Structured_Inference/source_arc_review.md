# L08 source-arc review — graphical factorization becomes inference algorithms

**Review mode:** source-arc fidelity, same-context, not a distinct Codex agent; no scope modifications made. **Books:** Murphy Book 2 Chapter 8, *Gaussian filtering and smoothing*, and Chapter 9, *Message passing algorithms*.

## 1. Reconstruct Murphy's two connected arcs

**Chapter 8** starts not from the Kalman formulas but from a *state-space model*: latent states, transitions, observations and optional controls in a chain-structured joint distribution (§8.1). It distinguishes **filtering** using observations through time t, **smoothing** using all T observations, and predictive questions. Under linear-Gaussian assumptions, all the relevant beliefs remain Gaussian; means/covariances become sufficient computational state (§8.2). Extensions ask what happens when model nonlinearities or non-Gaussian structure break that closure (§§8.3–8.7).

**Chapter 9** begins with the same general issue viewed through graphical models: exploit conditional independence to compute global marginals and decisions by **reusing local subcomputations**. It proceeds from chain belief propagation (§9.2) to trees (§9.3), loopy graphs (§9.4), variable elimination and junction trees (§§9.5–9.6), and an optimization view (§9.7). The intellectual idea is not that “HMMs have recurrences” but that **graph structure controls exact inferential computations**. A chain is the first, simplest instance of a more general mechanism.

## 2. Current L08 argument

The [L08 scope](lecture_scope.md) builds a known-parameter HMM, derives forward and backward messages and scaling, contrasts marginal-state versus whole-path decisions, counts the computational saving, then briefly applies Gaussian filtering/Kalman formulas. Its lab implements and verifies an HMM recurrence against full enumeration and an asymmetric-transition test. This is mathematically serious and well-grounded; avoiding a second complete Kalman lab is sound.

## 3. Arc fidelity and deviation

**Verdict: mathematically faithful as a *chain-inference* selection, but inadequately explicit as an account of Chapters 8+9; priority HIGH.** Murphy's generality lies in the relationship **model factorization → local summaries/messages → efficient exact inference**, then in **discrete and Gaussian closure as alternative representations**. The proposed scope's wording and examples sometimes make the distinctive theorem of computation appear to be HMM forward/backward, with graphical generalization a final omission. L08 is therefore at risk of becoming a specialized algorithm lesson rather than a recognizable selective route through both source chapters.

It is justified to omit tree/loopy BP, full junction tree, RTS smoothing, nonlinear Kalman variants and system identification. It is less clearly justified to omit the **one conceptual step that identifies the chain recursion as message passing on a factorized graph**. A small graph/cut argument would preserve the broader arc without implementing a second algorithm.

Also, the scope's *Gaussian filtering* segment inherits L01 conditioning, but the lecture does not substantially introduce the inferential distinction of **filtering vs smoothing in Gaussian state space**. That omission should be labeled a depth choice, not called coverage of the whole Ch. 8.

## 4. Smallest meaningful repair

Before the detailed HMM derivation, explicitly use the graph from L03 to show a chain separator: past and future become conditionally independent when the relevant hidden state is fixed. Derive conceptually why a message must summarize the likelihood of *all evidence on one side*, yielding a reusable operation. The HMM forward/backward formulas are then specific **sum-product messages**. After deriving them, make one deliberate abstract comparison: on trees the same local summation idea persists with other message schedules; on loopy graphs it can cease to be exact. **State**, don't implement, that generalization.

For the brief Kalman segment, emphasize *the same inferential questions and similar message flow with a different representation*: a Gaussian belief is summarized by mean and covariance rather than a K-vector. One explicit contrast filtering/smoothing (what future observations add) is more valuable than several disconnected Kalman matrix equations. Do not add a second derivation of an entire Kalman filter.

This change could be largely a **reorganization of the first and last portions**, but the scope must clearly assign depth and cut a lower-priority Viterbi/complexity side detail if necessary. The HMM checked lab remains excellent and unchanged.

## 5. Consequences and bounds

- **Core source spine preserved:** §9.1 local message-passing rationale and §9.2 forward/backward, with §8.1 state-space queries and §8.2 Gaussian filtering as structural alternative.
- **Intentionally omitted:** exact tree algorithm, general variable elimination, junction tree, full Gaussian smoothing, nonlinear filtering. Students must not think L08 covered all of both chapters.
- **Earlier dependency:** L03 must genuinely teach graph factorizations/conditional independences; the restored scope does.
- **Later benefit:** makes the distinction between exact structured inference (L08), distribution-family approximation (L09) and sample approximation (L10) clear.

**Disposition:** **targeted source-arc revision recommended**. The problem is missing conceptual generalization, not too few subsections or an inadequate HMM notebook. Highest risk is adding it without deleting existing material; the requested revision must preserve the same live time.