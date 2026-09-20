# Lecture 1 continuation and Lecture 2 implementation note

## Major changes

- Continued Lecture 1 after `Classes of machine learning problems` with task
  taxonomy, moments, categorical and multinomial models, softmax, the empirical
  distribution, covariance, multivariate Gaussian conditioning, missing-value
  conditioning, and linear Gaussian systems.
- Added section-marker and summary slides for every new Lecture 1 section.
- Added the standalone Lecture 2 deck at
  `L02_Likelihood_Exponential_Families/slide_deck.typ`.
- Lecture 2 covers likelihood and negative log likelihood, MLE examples, ERM,
  regularization and MAP, exponential-family form, log-partition derivatives,
  sufficient statistics, moment matching, and a Dirichlet-Multinomial reserve
  bridge.

## Visual implementation

The new content uses editable native Typst equations, tables, and compact
course schematics. No external raster or generated figure assets were added.
Existing Lecture 1 figures and the shared course theme remain unchanged.

## Sources used

- `L01_Probability_Statistics/lecture_01_02_coverage_spec.typ` for the
  required sequence, equations, coverage boundaries, and reserve material.
- Existing Lecture 1 slides through `Classes of machine learning problems` for
  the visual system, title treatment, figure provenance, and spacing.
- The course theme in `course.typ` and `themes/ruled-page/template.typ`.

## Validation

Both slide decks were compiled with TinyMist after the changes. Representative
slides from each new section were rendered and visually checked for clipping,
equation size, footer collisions, and adherence to the no-explanatory-prose
constraint.
