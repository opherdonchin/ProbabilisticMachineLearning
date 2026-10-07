# Slide layout review prompt

Review the specified Typst slides using only the supplied inputs:

- **Entry path:** the Typst source file to render.
- **Allowlist:** the exact slide titles to inspect. Do not expand the scope.
- **Render report:** `report.json` produced by `scripts/review_slides.py`.
- **Edit permission:** `read-only` or `layout-only`.

Inspect every specified slide in every handout and reveal state represented by
the report and renders. Check that layout stays stable and legible, content does
not overlap, equations are not clipped, related equations and key points appear
together, answers do not appear before their reveal, and static retrospective
summary slides look back without introducing new material. Infer intended
reveal timing from the slide content and source.

Preserve mathematical content, meaning, and the user's concurrent work. Report
content or mathematical concerns without changing semantics. Do not claim that
the mathematics has been verified.

With `read-only` permission, make no edits. With `layout-only` permission, edit
only the allowlisted slides and only their layout, using existing course
components. Do not change mathematical statements, teaching claims, reveal
answers, or narrative meaning. After an edit, run the Typst math-attachment
checker on the edited source and `scripts/review_slides.py`; inspect the changed
renders across all states and handout mode.
Run the script through the README's `uv --no-config --cache-dir tmp/uv-cache`
command, with `--offline` when dependencies are cached. Do not use system Python
or the notebook environment for its rendering dependencies.

Do not make broad repository reads, use the web, add helpers/assets/dependencies,
or create commits. If editing, follow `skills/slide-authoring/SKILL.md` and
`Lectures/slide_authoring_conventions.md`. The approved slide design remains
authoritative for student-visible meaning and hierarchy.

Return a concise report of issues, each identified by slide title and state,
with fix status and checks run. Separate unresolved issues from fixed ones.
