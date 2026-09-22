# Lecture 1 revision summary

Reviewer-facing notes on the work done to Lecture 1's Section 2 and Section 3.
This document is not lecture content and is not referenced by `slide_deck.typ`.

## Current syllabus alignment -- September 2026

The syllabus in `advanced_statistics_2027_1_syllabus.typ` is the current
source of truth. The historical revisions documented below introduced Murphy's
four task categories as an orientation, following Book 2, Chapter 1. The
current course uses that orientation selectively: Lecture 1 establishes the
prediction problem, and Lectures 6--12 develop predictive modeling through
generative and discriminative classification, regression and generalized linear
models, neural networks, calibration, out-of-distribution detection, and
selective prediction.

Accordingly, references below to a later course sequence on generation and
discovery are historical planning notes, not the current curriculum. The
prediction sequence begins with supervised learning and classification; this
pass ends at uncertainty in Book 1, Section 1.2.1.5. Estimation and the later
evaluation material remain separate follow-on work.

### Book 1 Section 1.2 alignment

The Section 2 prediction sequence now follows the terminology and order of
Book 1, Section 1.2 more closely: supervised learning; classification through
the Iris and image examples; exploratory data analysis; empirical risk
minimization; and probabilistic classification with uncertainty through
Section 1.2.1.5. The decision-tree subsection (1.2.1.3) and Figure 1.4 are
intentionally omitted. Estimation follows only after review. The reused book
figures and their attributions are documented in
`figures/book1_section12_sources.md`.

It has two parts: the first revision, which replaced the provisional
transition material with two new sections, and the second revision, which
reworked Section 3 and its figure notebook.

---

# Second revision — Section 3: two framings of the four tasks

## The problem this pass solves

The first revision gave each of Murphy's four task categories its own
canonical example in its own domain: Iris for prediction, faces for
generation, a 2D mixture for discovery, and — the weak point — an abstract
influence diagram for action.

That framing is good for breadth, but it invites a wrong inference: that
prediction *is* a labeled classification dataset, generation *is* images, and
discovery *is* a scatter of unlabeled points. Tasks would look like properties
of datasets.

So Section 3 now makes two points at once.

1. **Different task, different domain.** The four canonical examples stay, and
   action finally gets a real computational figure alongside the other three.
2. **Same dataset, different question.** One new slide asks all four questions
   of the same 100 Iris flowers, in the same two measurements, on the same
   axes — so that the only thing that changes between panels is the question.

## What changed in `slide_deck.typ`

All edits are inside Section 3 (from line ~591). Section 1, Section 2, and
every later section are untouched; `git diff` confirms this.

**Two slides added.**

- *Same flowers, four different questions* — the new centrepiece, placed
  immediately after "Four questions to ask of a fitted model" and before the
  canonical examples. A 2x2 of the four Iris panels, revealed one at a time,
  each with its question and its probabilistic object set in the deck's own
  type. Closes on "Same 100 flowers. Same two measurements. Only the question
  changed."
- *Action: where should we measure next?* — the new Murphy-derived
  active-learning figure, in the same `side-left` layout as the prediction and
  discovery slides, so action gets the same visual weight as the other three
  tasks.

**Two slides changed.**

- The old *Action: choosing what to do* is now *Beyond acquisition: actions
  with consequences*. It keeps the oil-wildcatter influence diagram, because
  it still makes a point the active-learning slide does not: the acquisition
  function came free from the posterior, but nothing in a probability model
  says what a wrong choice *costs*. That is the extra ingredient, and it is
  where the course stops. Its key points were rewritten to make the contrast
  with the preceding slide explicit rather than to restate decision theory
  from scratch.
- The section summary gained the "a task is fixed by what is observed, what is
  unknown, and what we want done — not by the dataset" line, and now names all
  four tasks rather than three.

**One subtitle changed.** The section slide subtitle is now "Four questions,
four domains — and the same four questions of one dataset".

**Unchanged on purpose.** The three "careful" slides from the first revision —
*Generative model, or generation task?*, *Careful: model type is not task
type*, and *How much distribution does prediction need?* — are byte-for-byte
as they were. They are exactly the slides that stop the new 2x2 from being
read as "prediction *is* p(y|x), generation *is* p(x|y)", so their position
after the canonical examples was kept.

## What changed in `Lectures/course.typ`

One small addition to the shared layer, rather than a one-off in the lecture
file: `course-figure` takes `show-source: true`, and a new `figure-source`
helper prints the provenance line on its own. A composite of four panels can
then name its provenance once instead of four times. Default behaviour is
unchanged, so no existing slide is affected.

## What changed in `task_examples_figures.ipynb`

The notebook is reorganized into two explicitly labelled families, with a
shared-helpers section before them, and an expanded provenance table at the
top that records lecture role, dataset, task, Murphy figure and chapter,
source notebook, reproduction status, and modelling assumptions for every
figure.

**Family A — different datasets for different tasks**

| Figure | Status |
|---|---|
| `__prediction_iris_logistic.svg` | Unchanged model. Axes switched from standardized units to centimetres — see "deviations" below. |
| `__generation_vae_samples.png` | Unchanged. |
| `__discovery_gmm_clusters.svg` | Unchanged code; regenerated because the RNG was restructured — see "deviations". |
| `__action_active_learning.svg` | **New.** |

**Family B — same dataset, different questions** (all new)

| Figure | What it shows |
|---|---|
| `__iris_prediction.svg` | Bayesian logistic regression: measurements to class |
| `__iris_generation.svg` | One Gaussian per species: class to plausible measurements, real flowers hollow and generated flowers filled |
| `__iris_discovery.svg` | Two-component mixture fit on `x` alone: measurements to latent grouping |
| `__iris_action.svg` | Ten labeled flowers, ninety unlabeled: predictive entropy chooses the next one to label |
| `__iris_four_questions.svg` | Combined 2x2 with in-figure titles. **Not used by the deck** — kept for handouts. |

### The new Action figure

Reproduces the **active-learning half of Murphy Fig. 34.16** (Ch. 34.7),
from `bayes_opt_vs_active_learning.ipynb`. Same target function
`f(x) = sin(10x) x`, same noise level, same two initial points, same six
greedy acquisitions, same maximum-variance acquisition rule, same two-panel
layout. Two deliberate changes, both documented in the notebook:

- The Bayesian-optimization comparison is **not** reproduced. It makes a
  different point and would make the slide too busy; the brief for this pass
  allowed leaving it out.
- The original's JAX / `tinygp` / `jaxopt` stack is replaced by an exact GP
  written in NumPy/SciPy — about forty lines — rather than adding three heavy
  dependencies for one figure.
- One addition: the *next* query is marked explicitly with a dotted line
  through both panels, because "the model chooses where to measure next" is
  the lecture's whole point, and Murphy's figure shows the end state rather
  than the pending decision.

### Reproducibility change

Every figure now draws from its own generator (`make_rng(name)`, seeded from
`BASE_SEED` plus a per-figure offset) instead of sharing one module-level
`RNG`. Cells can now be added, removed, re-ordered, or run individually
without changing any other figure. This matters concretely: the VAE cell is
the only cell needing `torch`, and it can now be skipped safely.

## Deviations from the brief, and judgement calls

Three decisions worth a reviewer's attention.

1. **The Family A prediction figure was regenerated in centimetres.** The
   brief said to retain it. The model, prior, Laplace approximation and
   posterior fan are all unchanged; only the axis units and labels differ.
   The reason is the new slide: "same flowers" loses its force if the same
   flowers appear two slides later in visibly different coordinates. If you
   would rather have the standardized axes back, it is a one-line change in
   the notebook's shared Iris cell — but then the Family B panels should
   change with it, not the other way round.

2. **The oil-wildcatter slide was kept, not cut.** The brief left this to
   judgement and warned about redundancy. Action now has three visuals
   (Iris panel, active learning, wildcatter). The wildcatter earns its place
   only because the slide was rewritten to make the contrast with the
   acquisition function its explicit subject. If Section 3 runs long in the
   room, this is the slide to drop — the boundary statement in the summary
   still carries the "Murphy continues, we stop" point.

3. **Section 3 is now thirteen content slides.** That is long for one
   section. The four-questions slide has four build steps and is meant to be
   the slow one. Worth timing against the rest of the two-hour lecture.

The user's mid-task instruction — keep panels separate for flexibility in
later placement — is why the four Iris panels are saved as four
self-contained untitled files and composed in Typst, rather than embedded as
one pre-rendered 2x2 image.

## What was NOT verified in this pass

**The notebook was not executed end-to-end.** `download.pytorch.org` is
blocked by this environment's egress policy, so `torch` could not be
installed and the two VAE cells (A2) could not run. Everything else ran
cleanly from a fresh interpreter, top to bottom, and regenerated every other
figure. The committed `generation_vae_samples.png` is the one from the first
revision, untouched.

Before this is considered final, someone with `torch` available should run:

```text
uv sync --locked
uv run python scripts/execute_notebook.py Lectures/L01_Probability_Statistics/task_examples_figures.ipynb --expect-file figures/task_examples_figures__prediction_iris_logistic.svg --expect-file figures/task_examples_figures__generation_vae_samples.png --expect-file figures/task_examples_figures__discovery_gmm_clusters.svg --expect-file figures/task_examples_figures__action_active_learning.svg --expect-file figures/task_examples_figures__iris_prediction.svg --expect-file figures/task_examples_figures__iris_generation.svg --expect-file figures/task_examples_figures__iris_discovery.svg --expect-file figures/task_examples_figures__iris_action.svg --expect-file figures/task_examples_figures__iris_four_questions.svg
```

and confirm the VAE figure still regenerates. Note that the VAE cell's
generator seed changed with the RNG restructure, so re-running it in place
will select a different eight training faces to display. That is cosmetic.

The required Colab check (AGENTS.md) has also not been run.

No new dependencies were added: the GP is NumPy/SciPy only, so
`pyproject.toml` and `uv.lock` are unchanged.

## What should be reviewed

1. **Whether the two framings land in the right order.** The 2x2 comes
   *before* the canonical examples, on the theory that it is better to
   inoculate against "task = dataset" than to correct it afterwards. The
   opposite order is defensible.
2. **The 2x2 at projector scale.** Four panels on one slide is the densest
   thing in the deck. The panels are generated at a larger base font than the
   Family A figures precisely because they are reduced further, but this is
   the slide most worth checking in the actual room.
3. **The Gaussian-per-species generation panel.** It is deliberately the
   simplest thing that makes "class in, measurement out" visible. The notebook
   and speaker note both say it is a teaching choice, not a claim about flower
   morphology. Confirm that disclaimer is where you want it.
4. **The 96% figure.** The unsupervised two-component mixture agrees with the
   true species for 96 of the 100 flowers. The speaker note says to mention
   this *after* the point lands, not before, so that discovery does not get
   read as "clustering that recovers the labels". Check you agree.
5. **Speaker notes on the new slides.** As before, these record the teaching
   move as I judged it; you know the room.

---

# First revision — two new sections after "A familiar modeling language"

This section records the earlier pass, for context.

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
(as first written; see the second revision above for its current shape)
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
8. Action — oil-wildcatter influence diagram, explicitly marked
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

### 4. New figure notebook

`task_examples_figures.ipynb` — separate from `coin_model.ipynb`, with a
provenance table at the top naming the Murphy figure, the original ProbML
notebook, and what was reproduced vs. adapted for each figure. See the second
revision above for its current structure.

### 5. Dependencies and docs

- `pyproject.toml` / `uv.lock`: added `scikit-learn` and a CPU-only `torch`
  build (via a scoped `pytorch-cpu` extra index in `[tool.uv.sources]`, so it
  doesn't affect resolution of anything else). `uv sync --locked` is
  consistent.
- `README.md`: added the execution command for the new notebook, matching
  the existing `coin_model.ipynb` documentation pattern, and a note on the
  new dependencies.

## Still outstanding from the first revision

- The pinned Typst version (0.15.1) is not recorded anywhere in the repo.
  If other contributors hit the `path()` compile error, that's why.
- The VAE substitution (Olivetti faces, small fully-connected VAE on CPU)
  stands in for Murphy's GPU-trained CelebA convolutional VAE. Confirm the
  disclosure on the slide itself is as explicit as you want it.
- The two slide removals listed above — confirm you're happy losing them
  rather than merging them into the new material some other way.

---

## Where to find things

| What | Where |
|---|---|
| Section 2 source | `slide_deck.typ`, from `#section-metadata(...)` and `= From statistics to machine-learning problems` |
| Section 3 source | `slide_deck.typ`, from `#section-metadata(...)` and `= Classes of machine learning problems` |
| Figure notebook | `task_examples_figures.ipynb` |
| Generated figures | `figures/task_examples_figures__*.{svg,png}` |
| Shared-layer change | `Lectures/course.typ` (`course-figure` `show-source`, `figure-source`) |
| Notebook execution docs | `README.md` |
| This summary | `Lectures/L01_Probability_Statistics/REVISION_SUMMARY.md` |

To re-render the deck for visual review (requires typst 0.15.1; not pinned
in the repo — see above):

```text
typst compile --root . Lectures/L01_Probability_Statistics/slide_deck.typ out/slide-{p}.png --format png --ppi 150
```
