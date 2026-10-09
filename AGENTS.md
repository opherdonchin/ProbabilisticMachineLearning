# Repository instructions

These instructions apply to the entire repository.

## Repository history and cleanup

- Keep the working tree focused on current source, current documentation, and
  current generated artifacts. Do not keep superseded drafts, `old` copies,
  archive folders, revision summaries, or other historical source material in
  the repository merely to preserve history.
- Git history is the archive. When committed material becomes obsolete, delete
  it rather than marking it superseded or moving it to an archive location.
- If superseded work exists only as uncommitted changes and is worth preserving,
  commit it first, then delete it in a subsequent commit. This makes the history
  recoverable without leaving stale material in the current tree.
- Before deleting a file, check for current references to it and update or remove
  those references in the same change.
- Generated artifacts that no longer correspond to current source should be
  regenerated or removed; do not knowingly leave stale generated outputs beside
  updated source.

## Lecture scope development

- When deciding what a new lecture should cover before drafting slides or a
  notebook, read and follow `skills/lecture-scope/SKILL.md`.
- Also read `skills/lecture-scope/references/timing-calibration.md` when judging
  lecture extent, mathematical density, source-page compression, or possible
  recording candidates. Its current numbers are provisional priors and should
  be replaced or sharpened as actual course timing data accumulate.
- The scope process must use actual previous course artifacts and
  `Lectures/material_ledger.md`, explore alternative routes with the instructor,
  and establish an agreed intellectual arc, mathematical spine, notebook handoff,
  concrete examples, and lecture contract.
- Do not collapse scope development into slide-level or notebook drafting. Those
  are downstream authoring tasks with separate constraints.
- Before freezing the five-part Lecture Scope, use the review mode in
  `skills/section-design/SKILL.md` for a **lightweight feasibility check**.
  This preview must not generate a section partition or slide outline.

## Section design and backpressure

- After an agreed Lecture Scope and before slide organization, follow
  `skills/section-design/SKILL.md` to construct sections forward from the
  evolving student-knowledge state, with a visible global endpoint, selective
  instructor checkpoints, periodic feasibility checks, and justified backtracking.
- Maintain section purposes, entry conditions, endpoints, mathematical treatment
  constraints, boundaries, approximate extent, and carry-forward in a lecture-local
  `section_design.md`. Use the L02 file as an output reference, not a fixed outline.
- Read `skills/shared/backpressure.md` when requesting or returning upstream
  feedback. Distinguish a preliminary feasibility preview from pressure discovered
  during actual downstream execution. Return decisions to the stage that owns
  them; never silently amend a higher-level commitment.
- An instructor-approved Section Design can proceed to Slide-Level Organization.
  Mark it validated only after downstream structural backpressure has been resolved.

## Slide-level organization

- When an already-designed lecture section needs to be turned into an ordered
  sequence of slide-level teaching moves, read and follow
  `skills/slide-level-organization/SKILL.md` before detailed visual design or
  Typst implementation.
- Treat slide titles and order as the primary output. Use brief intention and
  design notes to disambiguate the teaching moves rather than prematurely
  designing finished layouts.
- The process is iterative: clarification with the instructor, a complete
  organization draft, critique/backpressure, and revision. Escalate failures of a
  section's intellectual contract to Section Design, not directly to Lecture Scope
  unless the scope itself must change. Do not silently
  change section scope, treatment depth, source coverage, endpoint, or extent;
  surface such pressure explicitly while still completing a provisional full
  organization when reasonably possible.

## Lecture slide authoring

- Follow `Lectures/README.md` when creating or editing lecture slides
- After editing a lecture `.typ` file, run
  `python scripts/check_typst_math_attachments.py <edited-file>` and fix any
  run-on math attachments introduced by the edit. Report pre-existing hits
  separately rather than silently changing unrelated slides. This focused
  source check still applies when full compile or visual review is deferred.

## Teaching notebook authoring

- For an end-to-end new teaching notebook, read and follow
  `skills/build-teaching-notebook/SKILL.md`. It deliberately separates creation
  of a technically correct worked solution from pedagogical decomposition into
  solved Q&A and student self-work notebooks.
- If only the worked computational example is being developed or validated,
  follow `skills/worked-solution-authoring/SKILL.md`.
- If a validated worked solution already exists and the task is to turn it into
  course pedagogy, follow `skills/teaching-notebook-authoring/SKILL.md` and its
  references, especially the cumulative student-knowledge file.
- The solved Q&A notebook is the pedagogical source of truth. Generate the
  student self-work version from it with `scripts/make_self_work_notebook.py`
  rather than maintaining an independently edited student narrative.

## Notebook runtime policy

- Course notebooks are Colab-first. A notebook is not ready to publish until it
  passes both the local uv check and a clean run on a hosted Google Colab
  runtime.
- Use the repository uv environment for local authoring and repeatable checks.
  Do not install notebook dependencies into the system Python.
- Install or update the locked environment with `uv sync`. In automation, use
  `uv sync --locked` so an out-of-date lock file fails visibly.
- In VS Code, select `.venv/Scripts/python.exe` on Windows or
  `.venv/bin/python` on Linux/macOS as the Python interpreter and notebook
  kernel. Start a browser-based interactive session with `uv run jupyter lab`.
- Check the first lecture notebook without changing source assets with
  `uv run python scripts/execute_notebook.py Lectures/L01_Probability_Statistics/coin_model.ipynb --expect-file figures/coin_model__beta_distribution.svg --expect-file figures/coin_model__bernoulli_likelihood.svg --expect-file figures/coin_model__prior_likelihood_posterior.svg --expect-file figures/coin_model__sequential_updating.svg --expect-file figures/coin_model__posterior_predictive.svg --expect-file figures/coin_model__sampling_monte_carlo.svg`.
  The executed copy is written below `build/notebooks/`, which is ignored by
  Git.
- Regenerate L01's committed SVG figures only when intended, using
  the same command with `--in-place`. Review every resulting figure diff.
- Always execute notebooks from a clean kernel, top to bottom. Do not accept a
  pass that depends on hidden state or out-of-order execution.
- In notebook Markdown cells, write display math with `$$ ... $$`, never with
  `\\[ ... \\]`. Continue to use `$ ... $` for inline math.

## Updating the uv environment

- Inspect notebook imports first and add only direct dependencies used by course
  notebooks or the small set of tools needed to execute them.
- Prefer versions present in the current course-target Colab runtime. Record a
  new target runtime and update the explanatory comment in `pyproject.toml` when the
  course baseline changes.
- Use `uv add <package>` (with an appropriate version constraint) rather than
  installing packages directly with `pip` into `.venv`.
- Do not hand-edit `uv.lock`. After changing `pyproject.toml`, run `uv lock`,
  then run every affected notebook check. Commit `pyproject.toml` and `uv.lock`
  together.
- If a required package is not preinstalled in Colab, add a small, idempotent,
  version-pinned installation cell near the start of the notebook and add the
  same dependency to uv. Avoid reinstalling packages Colab already provides.

## Required Colab check before publishing

- Use the official Google Colab VS Code extension and select the course-target
  hosted runtime version. For the current environment, the baseline is Colab
  `2026.07` on CPU unless the notebook genuinely requires an accelerator.
- Start with a fresh hosted runtime, then use Restart/Run All. Confirm that every
  cell completes, plots render, output is reasonably sized, and no local-only
  path or undeclared package is required.
- Remember that a Colab kernel uses the remote `/content` filesystem. Upload any
  required repository files explicitly. Files written by the notebook, such as
  L01's `figures/*.svg`, are remote until downloaded or copied back into the
  repository.
- When Colab's rolling runtime changes, first test the latest runtime. Update the
  uv direct-dependency pins and lock file only after that hosted run passes.
- Do not describe a notebook as Colab-compatible based only on the uv run.
