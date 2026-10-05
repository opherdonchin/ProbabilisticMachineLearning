# Provisional lecture extent calibration

These are course-planning priors, not hard constraints. Revisit them as soon as actual delivery timings or rehearsals are available.

## Instructor pacing anchors

- The instructor judges the current Lecture 1 deck to be about the right live-lecture length for this course.
- The current `Lectures/L01_Probability_Statistics/slide_deck_revised.typ` contains 61 `==` content-slide headings. Recount when the deck changes.
- In comparable undergraduate teaching, the instructor reports typically covering roughly 60–80 PowerPoint slides in a three-hour lecture.
- Treat L01 as the stronger course-specific anchor and the 60–80-slide experience as a wider instructor-specific plausibility range. Do not infer a rigid slides-per-minute rate.

## L01 mathematical-density anchors

The mathematically concentrated part of L01 runs from `Gaussians: a concrete example` through the final linear-Gaussian-system summary: approximately 29 content slides.

Its main Book 2 source span is §2.3.1–§2.3.2, approximately printed pp. 22–30. The lecture deliberately omits some material in that span and supplements it with Book 1 explanations, so this is not a one-to-one source mapping. As an order-of-magnitude calibration, the current treatment corresponds to roughly:

- about **3–4 content slides per source-book page** for dense mathematical material;
- equivalently about **0.25–0.3 source-book pages per content slide**.

Do not apply this mechanically to another chapter. Use it to detect when an intended source span plus intended derivation depth would imply an implausibly large deck.

A manual source audit of the same Gaussian/LGS section suggests:

- almost every content slide contains mathematical notation or equations;
- roughly **3–4 substantial displayed formula units per content slide** on average, depending on how multi-line derivations are counted;
- derivation slides can exceed this substantially, so formula count must be interpreted together with derivation depth and reveal structure.

For the entire current L01 source there are approximately 24 explicit `course-figure(...)` / `image(...)` placements across 61 content slides, or about **0.4 explicit image/plot placements per content slide**. This excludes schema nodes, tables, cards, imported conceptual diagrams, and other Typst-native visual structure, so it is a lower bound on visual density. Figures are clustered rather than evenly distributed.

## How to use these numbers

Use the metrics as independent coarse checks:

- **slide extent:** compare total content slides with L01 and the instructor’s broader 60–80-slide experience;
- **source compression:** compare slides per source-book page only within similarly mathematical material;
- **mathematical density:** compare equation/formula density and number of full derivations, not merely total slide count;
- **visual density:** compare figure/diagram load when a lecture relies heavily on interpretation rather than derivation.

A proposed lecture can match L01’s slide count and still be much longer if its slides contain longer derivations, more interaction, or denser speaker notes. Conversely, a more visual lecture may comfortably exceed L01’s content-slide count.

## Later sharpening

As the course is taught, record stronger evidence when available:

- actual live lecture duration and where the instructor reached;
- slides actually covered versus skipped;
- timing of especially dense derivations or examples;
- pauses for questions/discussion;
- whether recording candidates were needed;
- revised slide, equation, figure, and source-page density metrics for each lecture.

Measured course data should progressively replace these provisional priors.