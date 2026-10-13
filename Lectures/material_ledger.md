# Course Material Ledger — authored coverage

This file records what is substantively included in *authored or drafted lecture and notebook materials*. It is not a record of classroom delivery, student completion, or actual teaching. The first class has not yet taken place. The [curriculum map](../curriculum_map.typ) contains prospective allocations; [material_lecture_actual.md](material_lecture_actual.md) will record what actually happened in each meeting.

## Conventions

### Disposition
- `Covered` — substantively developed in a lecture deck or solved notebook currently in the repository, whether or not taught yet.
- `Deferred` — considered during authoring but deliberately set aside for later.
- `Skipped` — deliberately omitted from the present authored curriculum rather than postponed.
- `Unreached` — beyond the current authoring boundary.

### Coverage method
Used only when `Disposition = Covered`.
- `Lecture`
- `Notebook`
- `Recording`

Each item has one primary *authored coverage* point. Other encounters can be noted briefly in `Comment` (for example, `Reviewed L03` or `Briefly mentioned L01`).

A mention is not coverage.

### Authored-material boundary
Each lecture records a provisional material boundary for each book. It is the furthest point addressed by the currently written progression, not a statement of what a class has reached. An isolated review or forward reference does not move it.

---

# Lecture 1

## Authored content boundaries in L01

- **Book 1:** through §3.3, *Linear Gaussian systems*
- **Book 2:** through §2.3.2, *Linear Gaussian systems*

## Book 1

| Section | Material | Disposition | Method | First point | Comment |
|---|---|---|---|---|---|
| §1.1 | What is machine learning? | Covered | Lecture | L01 | |
| §1.2, §1.2.1 | Supervised learning; classification | Covered | Lecture | L01 | Iris/classification framing |
| §1.3 | Unsupervised learning | Covered | Lecture | L01 | Brief taxonomy |
| §1.3.3 | Self-supervised learning | Covered | Lecture | L01 | Brief taxonomy |
| §1.4 | Reinforcement learning | Covered | Lecture | L01 | Brief taxonomy |
| §§1.5.1–1.5.2 | Common image and text datasets | Covered | Lecture | L01 | Examples |
| §2.3 | Bayes' rule | Covered | Lecture | L01 | Review |
| §2.4.1 | Bernoulli and binomial: definition | Covered | Lecture | L01 | Review |
| §2.7.4 | Beta distribution | Covered | Lecture | L01 | Review |
| §3.1.1 | Covariance | Covered | Lecture | L01 | |
| §3.1.2 | Correlation | Covered | Lecture | L01 | |
| §3.1.3 | Uncorrelated does not imply independent | Covered | Lecture | L01 | Brief |
| §§3.1.4–3.1.5 | Correlation/causation; Simpson's paradox | Deferred | — | L01 | |
| §3.2.1 | Multivariate Gaussian: definition | Covered | Lecture | L01 | |
| §3.2.2 | Mahalanobis distance | Covered | Lecture | L01 | |
| §§3.2.3–3.2.4 | MVN marginals/conditionals; 2d conditioning | Covered | Lecture | L01 | Applied again in notebook |
| §3.2.5 | Imputing missing values | Covered | Notebook | L01 | Main notebook application |
| §§3.3.1–3.3.4 | Linear Gaussian systems: Bayes rule, derivation, scalar/vector inference | Covered | Lecture | L01 | Reapplied in notebook |
| §3.3.5 | Sensor fusion | Unreached | — | — | |
| §3.4 | Exponential family | Unreached | — | — | |
| §§4.3–4.3.1 | ERM; minimizing misclassification rate | Covered | Lecture | L01 | Brief; isolated forward reference |
| §§4.6.1–4.6.2 | Conjugate priors; Beta-binomial | Covered | Lecture | L01 | Review; isolated forward reference |

## Book 2

| Section | Material | Disposition | Method | First point | Comment |
|---|---|---|---|---|---|
| §§2.1.5–2.1.6 | Conditional probability; Bayes' rule | Covered | Lecture | L01 | Review |
| §2.2.1.1 | Bernoulli and binomial distributions | Covered | Lecture | L01 | Review |
| §2.2.4.1 | Beta distribution | Covered | Lecture | L01 | Review |
| §2.3.1.1 | Multivariate normal: definition | Covered | Lecture | L01 | |
| §2.3.1.2 | Gaussian shells | Deferred | — | L01 | Removed from revised L01 |
| §2.3.1.3 | MVN marginals and conditionals | Covered | Lecture | L01 | Applied again in notebook |
| §2.3.1.4 | Information/canonical form | Covered | Lecture | L01 | |
| §2.3.1.5 | Derivation: moment form | Covered | Lecture | L01 | Alternative residual-independence route |
| §2.3.1.6 | Derivation: information form | Deferred | — | L01 | |
| §2.3.2.1 | Linear Gaussian joint distribution | Covered | Lecture | L01 | Applied again in notebook |
| §2.3.2.2 | Posterior distribution / Bayes rule for Gaussians | Covered | Lecture | L01 | Applied again in notebook |
| §2.3.2.3 | Sensor fusion with known measurement noise | Unreached | — | — | |
| §2.3.3 | General calculus for linear Gaussian systems | Deferred | — | L01 | Gaussian-potential calculus |
| §2.4 | Exponential family | Unreached | — | — | |
| §3.2.1 | Tossing coins | Covered | Lecture | L01 | Beta-binomial review; isolated forward reference |
| §§3.4–3.4.1 | Conjugate priors; binomial model | Covered | Lecture | L01 | Review; isolated forward reference |

## Lecture 1 authoring notes

- The available draft solved L01 notebook develops Book 1 §3.2.5 and applies Gaussian conditioning and linear-Gaussian-system equations. The student notebook and actual classroom experience should be checked separately.
- No L01 delivery or student practice is recorded here; see the actual-teaching record after the first meeting.

---

## Prospective allocation

For the proposed L02–L13 topic and notebook assignments, consult the [curriculum map](../curriculum_map.typ) and the appropriate lecture scope. Do not add future lecture promises to this authored-coverage ledger. Approved changes enter this record when teaching artifacts are written or revised; classroom delivery is recorded separately in [material_lecture_actual.md](material_lecture_actual.md).
