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

## Branch naming and lifecycle

- For new work, use `<type>/<scope>-<specific-outcome>` branch names (for example,
  `lecture/l03-verify-d-separation` or `fix/l02-retrospective-summaries`).
  Do not name branches after an agent, a date, or a vague stage such as “authoring.”
- Read `docs/branch-management.md` before creating, renaming, merging, or
  deleting branches. Record the intended base, outcome, and approval state in
  the associated PR or issue. Do not conflate a merge into an integration
  branch with a merge into `main`.
- Delete completed branch heads after verifying incorporation; review unmerged
  branches individually before retiring them. Never discard unique work merely
  because it is old or has been replaced in a later plan.
## Writing for the instructor and students

- Write for a mathematically mature instructor: probability, calculus, linear
  algebra and Bayesian reasoning are available, while the later course methods
  and Murphy's organization may be unfamiliar. Do not confuse unfamiliarity with
  a method with a need to lower the mathematical level of the discussion.
- State the mathematical issue and its teaching consequence in clear connected
  prose. Use the correct method names and technical terms, explaining their role
  when first needed. Preserve distinctions between objectives, distributions,
  algorithms and guarantees rather than replacing them with generic descriptions.
- Include decision-relevant equations, assumptions and counterexamples in the main
  explanation when they make the concern precise. Define notation and explain
  what the equation establishes. Long derivations, implementation details and Git
  identifiers can follow as checking material; important mathematics should not
  be hidden merely to make the document look simple.
- Explain what is proposed at derive/prove, work/apply, state or mention depth;
  what students will actually practise; what the competing choice adds or loses;
  and why the difference affects time, prerequisites or the course endpoint.
  These are teaching decisions. Formula correctness and software validation
  remain author/reviewer responsibilities rather than instructor approval tasks.
- When a concern requires unfamiliar background, provide a focused reading route:
  verified book/edition, section numbers and titles, and what to look for there.
  Prefer the relevant passage to a whole-chapter list. Flag pertinent source
  errors. Give enough context to understand the stakes now, while being honest
  about what reading is needed to assess the mathematics in detail.
- Keep mathematical meaning precise. A simpler example may have a weaker
  guarantee, which must be stated: error detection is not guaranteed correction,
  an invariant chain need not mix quickly, and a variational penalty need not
  equal mutual information. Explain such distinctions rather than just naming
  them or presenting an unexplained catalogue of exclusions.
- Before handing over work, check both clarity and substance. Can the reader
  identify the exact mathematical objects, the concern and the teaching tradeoff?
  Are the equations/conditions needed to judge it visible? Have terms been
  explained without removing the issue that made the decision consequential?
- This rule applies to all course and notebook skills, including specialists.
  Student material must still follow the knowledge established at that point in
  the course. Preserve identifiable raw review evidence and exact source records;
  readable summaries complement them and do not replace their mathematical claims.

## Course-wide intellectual authority

`course_architecture.typ` is the single authoritative statement of the course's intellectual framework, rationale, and planned lecture progression. `curriculum_map.typ` owns proposed topic allocation, Book 1/2 readings and notebook examples; lecture scopes own approved detailed commitments. `curriculum_map_actual.typ` mirrors that plan and records substantive lecture and notebook activity only after each class. The two maps are the only course-wide material tracking documents. Start from the family of learning problems (task, available experience, data structure *and scale*, required performance), then identify the probabilistic model, its queries, and the computation appropriate to it. **The course's educational objective is working competence with machine-learning problems and specific algorithms; probabilistic coherence and mathematical depth serve that practical and transferable judgment rather than displace it.** Each proposed lecture must connect its reusable mathematical argument to a recognizable learning problem and a bounded application/evaluation exercise. Do not mistake a checked toy derivation for practical familiarity, or a notebook that runs for understanding of its assumptions. For each technical move, distinguish *validity regime* (when it answers the task well enough), *computational payoff* (time/memory and repeated-query scaling versus alternatives), and *task-relevant error* (what the approximation or algorithm fails to preserve). Exact inference, a posterior distributional proxy, and a sampling estimate of a target expectation are not interchangeable. Laplace and Gaussian VI can have the same output family while fitting it by different mathematical criteria; drawing samples is not the distinction. Do not turn a worked example or a chosen notebook into the lecture's intellectual purpose. The student syllabus summarizes the architecture; `Lectures/course_architecture_scope/architecture_audit.md` evaluates proposed scopes against it rather than independently defining course philosophy. Actual teaching must be recorded separately from prepared materials. Instructor-approved lecture scopes remain the record of what was agreed; the instructor may explicitly reopen future commitments. When architecture proposals change them, document the difference and seek appropriate feasibility review before implementing new scope or notebook work. Do not silently rewrite historical facts or claim a proposal is delivered.

## Reconciliation of existing lectures with revised course goals

For **L01–L03** in the 2027-1 revision, the instructor has explicitly reopened scope decisions following a major change to the course architecture. Recover prior decisions, source branches, lecture decks, design artifacts, worked solutions, and notebook pedagogy before proposing changes. Judge the architecture against the strongest existing teaching argument as well as judging existing materials against the architecture; if existing material demonstrates a better course-wide principle, propose an explicit architecture revision rather than forcing the material to fit. Make the smallest effective revision, but allow substantial restructuring when evidence and instructor decisions justify it. First reconcile and approve scopes, then return to Section Design, Slide-Level Organization, Slide Design, Slide Authoring and notebook validation, reusing effective existing work. From L04 onward, start scope work from the architecture and curriculum map while preserving documented prior choices unless expressly revised. See `Lectures/START_SCOPING.md` for the current branch, evidence inventory, and opening discussion. Do not update `curriculum_map_actual.typ` until lectures are taught.

## Course development coordination

- For course-wide priorities, concurrent lecture/notebook/skill work, or
  "What should we do next?" or "What needs my attention?", read and follow
  `.agents/skills/course-development/SKILL.md` (`$course-development`). Discover
  work and instructor approvals across relevant branches and worktrees, not
  just `main`; reconcile live files with their owning records before dispatch.
- Reuse existing lecture and notebook skills. Distinguish artifact, skill,
  instructor-decision, branch and runtime blockers; restrict each to its actual
  dependencies. A slide-process failure does not automatically block unrelated
  scope development or notebook feasibility. A next-action question authorizes
  assessment and recommendations, not lecture production or merges.
- Before dispatch, recover declared active sessions and their branch/worktree,
  owners and write scopes. Separate worktrees do not permit competing writes to
  the same future artifact. External sessions are not presumed controllable.
  Under deferred review, collect instructor questions in owning artifacts and
  index them persistently; wait only dependent work and continue independent
  authorized tasks. Present one prioritized question when review is requested.
- Keep persistent course coordination limited to active cross-course assignments
  and unresolved dependencies not already owned elsewhere. Lecture registers
  retain lecture status and approvals; architecture and curriculum maps retain
  their existing authority. Do not create duplicate task histories or ledgers.

## Lecture development coordination

- In Codex IDE/CLI, invoke `$lecture-development` for the instructor-facing
  workflow. Canonical, discoverable skill instructions live under
  `.agents/skills/` (no wrappers); five minimal Codex execution profiles,
  including their model/effort settings, live under `.codex/agents/`.
  See `.codex/README.md` for launch and a live delegation smoke test.

- For a multi-stage lecture-development task, read and follow
  `.agents/skills/lecture-development/SKILL.md`. It coordinates stages and the
  instructor interaction; it does not replace the specialist skills.
- Specialists support `build`, `feasibility-review`, and `revision` modes.
  The coordinator dispatches reviews and routes decisions when active. For a
  single-stage request, use the relevant specialist directly.
- Give a delegated specialist its exact mode, inputs, artifact versions, and
  bounded scope. Referencing a skill file does not itself spawn an agent;
  use real delegation where available, otherwise run serially and disclose
  that feasibility checks were not independent.
- Preserve decisions in their owning artifacts. Instructor approval is needed
  for consequential pedagogical changes; a feasibility review is not approval.
- In substantial multi-stage work, default to a small lecture-local committed
  `development_state.md` tracking branch/revisions, approvals with provenance,
  open decisions, review status and next owner. Reconcile it against live files
  on resuming; do not silently inherit stale or cross-branch assumptions.
  Use `.agents/skills/shared/backpressure.md` for handoff and escalation rules.

## Lecture scope development

- When deciding what a new lecture should cover before drafting slides or a
  notebook, read and follow `.agents/skills/lecture-scope/SKILL.md`.
- Also read `.agents/skills/lecture-scope/references/timing-calibration.md` when judging
  lecture extent, mathematical density, source-page compression, or possible
  recording candidates. Its current numbers are provisional priors and should
  be replaced or sharpened as actual course timing data accumulate.
- The scope process must use actual previous course artifacts and
  `curriculum_map.typ` and `curriculum_map_actual.typ`, explore alternative routes with the instructor,
  and establish an agreed intellectual arc, mathematical spine, notebook handoff,
  concrete examples, and lecture contract.
- Do not collapse scope development into slide-level or notebook drafting. Those
  are downstream authoring tasks with separate constraints.
- Before freezing the five-part Lecture Scope, use the review mode in
  `.agents/skills/section-design/SKILL.md` for a **lightweight feasibility check**.
  This preview must not generate a section partition or slide outline.

## Cross-stage instructional invariants

- Each live lecture section **ends with a retrospective summary of what it taught**. Never end with a handoff, teaser, future-looking question, or "next we will" statement. Put essential connections at the *beginning of the receiving section*. The notebook handoff is a separate lecture-level item, not the last section's summary.
- **Recordings are one continuous section, with no section-heading or section-summary slides** (instructor decision, 2026-10-17). After the recording title, use an orientation slide contrasting what comes **From the lecture** with what is **To prove here** (or equivalent precise headings), with important starting conditions in key points. End on the mathematical conclusion, not an added recap. This recording-specific rule overrides the general section-summary requirement in specialist skills. Use `L01`, `L02`, etc. for lecture identifiers and `L01-R01`, `L01-R02`, etc. for linked recordings.
- Mathematical development must show the target, the operation on the preceding expression, and the local reason that licenses it. Connect each preparatory step to the target when it appears; a stack of formulas followed by a final explanation does not meet this requirement. Give separate displayed formula rows generous vertical clearance, including in recall boxes; do not rely on inline-math line breaks or reduce spacing to fit more content.
- Preserve mathematical meaning and epistemic/source provenance. Verify exact examples, edges, numbers, figure/equation attributions and graphical CI claims against the actual source before making them required commitments; identify course-constructed examples rather than attributing them to Murphy. Flag unverifiable claims as provisional.
- Carry these invariants through Scope, Section Design, Slide Organization, Slide Design, Slide Authoring and any coordinator review, rather than relying on one stage to remember them.

## Section design and backpressure

- After an agreed Lecture Scope and before slide organization, follow
  `.agents/skills/section-design/SKILL.md` to construct sections forward from the
  evolving student-knowledge state, with a visible global endpoint, selective
  instructor checkpoints, periodic feasibility checks, and justified backtracking.
- Maintain section purposes, entry conditions, endpoints, mathematical treatment
  constraints, boundaries, approximate extent, and carry-forward in a lecture-local
  `section_design.md`. Use the L02 file as an output reference, not a fixed outline.
- Read `.agents/skills/shared/backpressure.md` when requesting or returning upstream
  feedback. Distinguish a preliminary feasibility preview from pressure discovered
  during actual downstream execution. Return decisions to the stage that owns
  them; never silently amend a higher-level commitment.
- An instructor-approved Section Design can proceed to Slide-Level Organization.
  Mark it validated only after downstream structural backpressure has been resolved.

## Slide-level organization

- When an already-designed lecture section needs to be turned into an ordered
  sequence of slide-level teaching moves, read and follow
  `.agents/skills/slide-level-organization/SKILL.md` before detailed visual design or
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

## Slide design

- After slide-level organization is approved, read and follow
  `.agents/skills/slide-design/SKILL.md`.
- Use `Lectures/slide_design_conventions.md` for course-wide design
  conventions and `Lectures/design.typ` for the executable constrained design
  language.
- The normal persistent artifact is lecture-local `slide_design.typ`.
- Preserve approved organization and section scope unless explicit backpressure
  is accepted.

## Lecture slide authoring

- After slide design is approved, read and follow
  `.agents/skills/slide-authoring/SKILL.md`.
- Use `Lectures/slide_authoring_conventions.md` for course-wide production
  conventions and `Lectures/course.typ` for the live production API.
- Treat approved `slide_design.typ` as the student-visible design source of
  truth. Do not silently redesign while lowering it to `slide_deck.typ`.
- Do not write speaker notes during lecture development.

## Teaching notebook authoring

- For an end-to-end new teaching notebook, read and follow
  `.agents/skills/build-teaching-notebook/SKILL.md`. It deliberately separates creation
  of a technically correct worked solution from pedagogical decomposition into
  solved Q&A and student self-work notebooks.
- If only the worked computational example is being developed or validated,
  follow `.agents/skills/worked-solution-authoring/SKILL.md`.
- If a validated worked solution already exists and the task is to turn it into
  course pedagogy, follow `.agents/skills/teaching-notebook-authoring/SKILL.md` and its
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
