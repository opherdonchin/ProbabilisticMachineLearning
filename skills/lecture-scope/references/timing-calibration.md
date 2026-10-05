# Provisional lecture extent calibration

These are course-planning priors, not hard constraints. Revisit them as soon as actual delivery timings or rehearsals are available.

## Instructor pacing anchors

- The instructor judges the current Lecture 1 deck to be about the right live-lecture length for this course.
- The compiled L01 deck currently has **70 rendered pages**: 1 title page, 8 section-divider pages, and **61 content slides**.
- In comparable undergraduate teaching, the instructor reports typically covering roughly **60–80 PowerPoint slides in a three-hour lecture**.
- Treat L01 as the stronger course-specific anchor and the 60–80-slide experience as a wider instructor-specific plausibility range. Do not infer a rigid slides-per-minute rate.

### Current L01 section extent

| Section | Content slides |
|---|---:|
| A familiar modeling language | 7 |
| From statistics to machine-learning problems | 12 |
| Classes of machine learning problems | 4 |
| From datasets to learning problems | 6 |
| Probability for machine learning | 3 |
| Joint Gaussian distributions and geometry | 8 |
| Marginals and conditionals of a Gaussian | 9 |
| Linear Gaussian systems | 12 |
| **Total** | **61** |

This table is a useful calibration because section-level estimates can later be compared with actual section-level delivery times.

## Equation density: count novelty separately from repetition

Do **not** use raw displayed-equation count as a proxy for mathematical novelty or lecture extent.

L01 deliberately carries equations forward from one slide to the next so that the exposition remains locally legible. A slide may therefore contain several displayed formulas while introducing only one new mathematical idea.

For extent estimation, distinguish:

- `E_new` — a new equation/result family that students are expected to understand or retain;
- `E_carry` — an appearance of an equation/result family introduced on an earlier slide and shown again to support the next step;
- `E_deriv` — additional algebraic/derivational blocks needed to establish a result but not themselves retained as separate results.

A manual audit of the 29 content slides from `Gaussians: a concrete example` through the LGS summary gives a useful initial order-of-magnitude:

- roughly **0.8–1.2 new equation/result families per slide**;
- roughly **1–2 carried-forward equation blocks per slide**;
- derivation-heavy slides add intermediate algebra beyond both categories.

Thus the earlier estimate of roughly 3–4 displayed formula units per mathematical slide was not false as a layout count, but it was misleading as a measure of mathematical novelty.

The distinction is visible in L01 itself. For example, the scalar Gaussian update explicitly labels the previous update equations `Carry forward` before specializing them.

### Carried-forward presentation convention

The course already has a `#recall-block(...)` component with an unobtrusive `Carry forward` marker for knowledge carried from an earlier lecture or recording. The same visual language can inform a lighter-weight convention for equations carried from earlier slides in the same lecture.

Do not force every repeated equation into a labeled block. Use the marker when repetition is pedagogically deliberate and recognition of the carried result helps students understand the next transformation or specialization.

## Visual and schema density

Count **raw visual assets** separately from **visual/schema groups**.

A visual/schema group is one coherent visual composition that is likely to occupy one slide region or one whole slide, even if it contains several raw images or several schema nodes.

The current L01 source contains about two dozen explicit image/plot placements. These are highly clustered: a single slide may contain several images, such as the Iris examples or the three Gaussian-operation panels.

A manual section-level audit suggests about **29 visual/schema groups across 61 content slides**, i.e. roughly **half of the content slides contain a substantive visual or schema group**. Most selected groups occupy one slide; multiple raw images often collapse into one group.

Useful planning quantities are therefore:

- `F_available` — figures/schemas available in the scoped source material;
- `F_selected` — figures/schemas actually chosen for teaching;
- `V` — selected slide-level visual/schema groups;
- `S_visual` — slides that actually carry those groups once drafting exists.

Before slides exist, `V` is the useful predictor. After drafting, record `S_visual / V` to learn how many slide-equivalents visual material consumes in this course.

## Source-page density

The mathematically concentrated part of L01 runs from `Gaussians: a concrete example` through the final linear-Gaussian-system summary: 29 content slides.

Its main Book 2 source span is §2.3.1–§2.3.2, approximately printed pp. 22–30, but the lecture deliberately omits some material and supplements it with Book 1 explanations. Raw page-span length is therefore a weak predictor unless pages are counted only when they are **substantively traversed** by the agreed scope.

Use:

- `P` — substantive source pages, not merely the numeric span between the first and last cited page.

Do not count pages containing examples or derivations that the scope explicitly skips.

## Prototype slide-extent model

The following is a **hand-calibrated prototype**, not a learned model:

```text
E_weighted = E_new + 0.25 E_carry + 0.50 E_deriv

S_hat = 1.5 K + 0.30 P + 0.50 E_weighted + 0.50 V
```

where:

- `S_hat` = predicted content-slide count;
- `K` = number of major lecture sections/segments;
- `P` = substantive source pages;
- `E_new` = new retained equation/result families;
- `E_carry` = carried-forward equation-block appearances;
- `E_deriv` = additional derivation/algebra blocks;
- `V` = selected visual/schema groups.

The coefficients are intentionally provisional. They were chosen only to put the variables on plausible scales and to approximately reproduce L01. They have **no out-of-sample validation**.

As a rough check, a manual audit of the three mathematical L01 sections (Gaussian geometry, Gaussian marginals/conditionals, and LGS) gives approximately:

```text
K ≈ 3
P ≈ 10 substantive primary-source page-equivalents
E_new ≈ 22
E_carry ≈ 39
E_deriv ≈ 5
V ≈ 9
```

which yields `S_hat ≈ 29`, close to the actual **29 content slides**. This agreement should not be overinterpreted because both the counts and coefficients were calibrated from the same lecture.

The point of the model is not current predictive accuracy. It creates a stable set of features whose coefficients can be learned as more lectures are authored and taught.

## How to use the model during scope development

1. Estimate `K`, `P`, `E_new`, `E_carry`, `E_deriv`, and `V` from the agreed scope.
2. Compute `S_hat` only as one independent extent check.
3. Compare the result with L01's 61-content-slide whole-lecture anchor and with the instructor's broader 60–80-slide experience.
4. Independently label the scope `comfortable`, `tight`, or `overfull` based on mathematical depth and expected interaction.
5. Recompute from the actual draft. Replace estimated `E_carry`, `E_deriv`, and `V` with observed counts.
6. After teaching, record actual time and slides reached so the coefficients can eventually be fitted rather than guessed.

A slide-count model must never override obvious pedagogical facts. One difficult derivation can take longer than several visual slides.

## Timing interpretation

Until section-level timing data exist, use slide count only as a relative extent signal.

For a lecture dominated by substantial derivations, expect slower delivery than the whole-L01 average. For a visual or recap-heavy lecture, expect faster delivery.

Recording candidates remain in the live estimate until the instructor actually moves them to recording.

## Later sharpening

As the course is taught, record for each lecture and, when possible, each major section:

- actual live duration and where the instructor reached;
- content slides actually covered versus skipped;
- `P`, `E_new`, `E_carry`, `E_deriv`, and `V`;
- `F_available`, `F_selected`, and actual `S_visual`;
- timing of especially dense derivations or examples;
- pauses for questions/discussion;
- whether recording candidates were needed.

Once several lectures have measured outcomes, fit the coefficients of the extent model and test prediction error on held-out lectures rather than continuing to tune by intuition.