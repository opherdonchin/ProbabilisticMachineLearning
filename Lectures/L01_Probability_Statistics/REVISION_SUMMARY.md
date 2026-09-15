# Lecture 1 revision summary: two new sections after "A familiar modeling language"

This document summarizes the work done to replace the provisional transition
material in Lecture 1 with two polished new sections, for reviewer reference.
It is not lecture content and is not referenced by `slide_deck.typ`.

## What was done

### 1. Style research (no file changes)

Before writing anything, I read `slide_deck.typ`'s completed first section
("A familiar modeling language"), `course.typ`, the authoring standards doc,
and `Syllabus.md`, and rendered the existing deck to see the first section
visually. That governed every layout choice below: `content-block` with
`top`/`side-left` layouts, `twocol`/`triad`, `key-points`, `#note`,
`#speaker-note` on every substantive slide, and terse fragment-style bullets
rather than paragraphs.

### 2. Toolchain fix (environment only, not a content change)

No locally installed `typst` matched what `course.typ` needs: 0.13.x lacks
default-parameter cross-references the theme uses, and 0.14.x changed the
`path()` builtin's signature, breaking every figure include. **Typst 0.15.1**
compiles the deck cleanly with zero warnings. This isn't recorded anywhere in
the repo (no `.tool-versions` or similar) — worth adding if others hit the
same issue.

### 3. `slide_deck.typ`: replaced the provisional section with two new ones

The old provisional section ("From Bayesian Statistics to Machine Learning",
~10 loosely-organized slides) is gone. In its place, immediately after
"Summary: A familiar modeling language":

**Section 2 — "From inference to machine-learning problems"**
(*Same probabilistic language, different organizing questions*)
1. The posterior was the destination
2. A new case arrives
3. Familiar regression notation, two different roles (dependent/independent
   vs. input/output)
4. What carries over
5. What changes
6. A model is not a task (fletcher diagram: one joint model → three
   different query conditionals)
7. Summary, ending on "So what do we actually want learned probabilistic
   models to do?"

**Section 3 — "What do we use learned models for?"**
(*Prediction, generation, discovery — and where this course stops*)
1. Four questions to ask of a fitted model (2×2 grid teaser)
2. Prediction — Bayesian logistic regression on Iris (own figure)
3. Generation — VAE samples on faces (own figure)
4. Discovery — Gaussian-mixture clustering (own figure)
5. "Generative model ≠ generation task" callout (`#definition(label:
   [Careful])`)
6. "Careful: model type is not task type" — discriminative/generative vs.
   the task axis, with the classical-generative-classifier-solves-prediction
   example
7. "How much distribution does prediction need?" — loss-functional framing
   vs. sampling framing, with the "boundary can get thin" nuance in a
   `#note`, not overstated
8. Action — oil-wildcatter influence diagram (fletcher), explicitly marked
   out of scope (Murphy Part VI, course stops at Ch. 33)
9. Summary

Two slides elsewhere in the deck were removed as directly superseded
(duplicated the new material and used an oversimplified task↔conditional
mapping the brief specifically warned against):
- "A model is a joint distribution plus a question" (old grammar section)
- "Prediction, generation, discovery" triad (old "Looking forward" section,
  whose subtitle was also updated since it no longer covers those three
  tasks)

One authoring bug caught and fixed during review: a stray `\,` in a math
block rendered as a literal comma instead of the intended product spacing.

Nothing else in the deck was touched — Section 1 and the rest of the
existing sections (grammar, fast reactivation, coin-model recap, exponential
families, multivariate Gaussian, comparing distributions, reserve slides)
are byte-for-byte as they were, apart from the one subtitle edit noted above.

### 4. New figure notebook

`Lectures/L01_Probability_Statistics/task_examples_figures.ipynb` — separate
from `coin_model.ipynb`, with a provenance table at the top naming the
Murphy figure, the original ProbML notebook, and what was reproduced vs.
adapted for each figure. Generates, into `figures/`:

- `task_examples_figures__prediction_iris_logistic.svg` — Bayesian logistic
  regression (MAP fit + Laplace approximation) on Iris petal
  length/width, versicolor vs. virginica; posterior fan of decision
  boundaries plus predictive-probability heatmap. Reproduces the structure
  of Murphy Fig. 15.8 / `logreg_iris_bayes_2d.ipynb` directly.
- `task_examples_figures__generation_vae_samples.png` — small
  fully-connected VAE trained (~10s, CPU) on scikit-learn's Olivetti faces;
  training faces vs. sampled faces. **Deliberate, documented deviation**
  from Murphy Fig. 21.2 / `celeba_vae_ae_comparison.ipynb`, which trains a
  convolutional VAE on CelebA on a GPU — substituted for a fast, dependency-
  light, reproducible lecture build. Named explicitly in the notebook and in
  the slide's speaker note; the resulting blur is a genuine property of
  pixel-wise VAE likelihoods, not a rendering artifact.
- `task_examples_figures__discovery_gmm_clusters.svg` — synthetic unlabeled
  2D data (three Gaussians, distinct covariance) vs. `GaussianMixture`
  inferred clusters with covariance ellipses. Reproduces the structure of
  Murphy Fig. 28.2 / `gmm_2d.ipynb` directly.

Deterministic seeds throughout; the notebook executes top-to-bottom cleanly
via `scripts/execute_notebook.py` (the project's existing execution harness)
and regenerates all three files.

### 5. Dependencies and docs

- `pyproject.toml` / `uv.lock`: added `scikit-learn` and a CPU-only `torch`
  build (via a scoped `pytorch-cpu` extra index in `[tool.uv.sources]`, so it
  doesn't affect resolution of anything else). `uv sync --locked` is
  consistent.
- `README.md`: added the execution command for the new notebook, matching
  the existing `coin_model.ipynb` documentation pattern, and a note on the
  new dependencies.

## What was NOT done

- The pinned Typst version (0.15.1) is not recorded anywhere in the repo.
  If other contributors hit the `path()` compile error, that's why.
- I did not touch any lecture content outside the two new sections and the
  two removed/superseded slides described above — in particular, the
  "Reserve / expansion slides" section, exponential families, and
  multivariate Gaussian sections were left completely alone, as instructed.
- No changes were made to the student-facing notebook workflow — this is
  purely an author-facing figure notebook, per the course's existing
  convention.
- I did not attempt to reproduce Murphy's CelebA VAE at its original scale
  (GPU training, full CelebA); see the documented substitution above.

## What should be reviewed

1. **The intellectual argument**, not just layout — read the two new
   sections start to finish and check they land the way you intend,
   especially:
   - Section 2's "what changes" framing (six rows) — make sure the tone
     reads as "pressure/emphasis shift," not "statistics vs. ML."
   - The two terminology-trap slides in Section 3 ("generative model ≠
     generation task" and "model type is not task type") — these are dense
     in a way the rest of the deck isn't; worth reading aloud for pacing.
   - Whether the VAE substitution (Olivetti, not CelebA) is disclosed
     clearly enough on the slide itself, or whether you want the note text
     tightened/expanded.
2. **Speaker notes** on the 16 new heading slides — I wrote what I judged as
   the teaching move for each, but you know the room; some may need
   retuning.
3. **The two slide removals** — confirm you're happy losing the old
   "A model is a joint distribution plus a question" and "Prediction,
   generation, discovery" triad slides rather than merging them into the
   new material some other way.
4. **Figure aesthetics** — all three are programmatically generated and
   functional but not hand-tuned for a projector; check font sizes / colors
   read well at lecture scale.
5. **Toolchain**: confirm 0.15.1 is an acceptable typst version to standardize
   on, and decide whether/how to record it in the repo.

## Where to find things

| What | Where |
|---|---|
| New section source | `Lectures/L01_Probability_Statistics/slide_deck.typ`, starting at `#section-slide(title: [From inference to machine-learning problems], ...)` |
| New figure notebook | `Lectures/L01_Probability_Statistics/task_examples_figures.ipynb` |
| Generated figures | `Lectures/L01_Probability_Statistics/figures/task_examples_figures__*.{svg,png}` |
| Dependency changes | `pyproject.toml`, `uv.lock` |
| Notebook execution docs | `README.md` |
| This summary | `Lectures/L01_Probability_Statistics/REVISION_SUMMARY.md` |

To re-render the deck for visual review (requires typst 0.15.1; not pinned
in the repo — see above):

```text
typst compile --root . Lectures/L01_Probability_Statistics/slide_deck.typ out/slide-{p}.png --format png --ppi 150
```

To re-execute the figure notebook:

```text
uv sync --locked
uv run python scripts/execute_notebook.py Lectures/L01_Probability_Statistics/task_examples_figures.ipynb --expect-file figures/task_examples_figures__prediction_iris_logistic.svg --expect-file figures/task_examples_figures__generation_vae_samples.png --expect-file figures/task_examples_figures__discovery_gmm_clusters.svg
```
