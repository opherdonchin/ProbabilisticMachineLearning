# Lecture slide system

This directory contains the course's slide-design and slide-authoring system.

The guidance is intentionally split by stage. Do not use this README as a
substitute for the stage-specific skill and conventions document.

## Pipeline

The full lecture-development pipeline is **Lecture Scope → Section Design →
Slide-Level Organization → Slide Design → Slide Authoring**, coordinated by
`.agents/skills/lecture-development/SKILL.md`. In coordinated work, each specialist
has **Build**, **Feasibility Review**, and **Revision** modes; the coordinator
dispatches reviews and handles instructor decisions.
`.agents/skills/shared/backpressure.md` defines issue ownership and return paths. This directory primarily documents the three downstream
slide-system stages.

| Stage | Process / authority | Course conventions | Executable layer | Persistent artifact |
| --- | --- | --- | --- | --- |
| Lecture Scope | `.agents/skills/lecture-scope/SKILL.md` | scope skill itself | — | agreed lecture scope |
| Section Design | `.agents/skills/section-design/SKILL.md` | section skill itself | — | `section_design.md` |
| Slide organization | `.agents/skills/slide-level-organization/SKILL.md` | organization skill itself | — | `slide_organization.md` |
| Slide design | `.agents/skills/slide-design/SKILL.md` | `Lectures/slide_design_conventions.md` | `Lectures/design.typ` | `slide_design.typ` |
| Slide authoring | `.agents/skills/slide-authoring/SKILL.md` | `Lectures/slide_authoring_conventions.md` | `Lectures/course.typ` | `slide_deck.typ` |
| Layout / render review | authoring skill | authoring conventions | `scripts/review_slides.py` | review report/renders |

Upstream Lecture Scope and Section Design contracts constrain all three slide stages. Each downstream stage can return **execution backpressure** to the nearest owning upstream stage; early **feasibility previews** do not authorize redesign.

## Source-of-truth hierarchy

The course-wide intellectual purpose and planned sequence are defined in [course_architecture.typ](../course_architecture.typ) and its [PDF](../course_architecture.pdf). The syllabus is a concise student-facing summary; the [architecture audit](course_architecture_scope/architecture_audit.md) tests proposals against that authority, and the material ledger records actual coverage. For each approved lecture, detailed scope and section contracts remain authoritative unless the instructor explicitly revises them.



When guidance conflicts, use this order:

1. explicit current instructor decision;
2. approved Lecture Scope and Section Design contracts;
3. approved slide organization;
4. approved lecture-local `slide_design.typ`;
5. stage-specific course conventions;
6. mature course precedent such as Lecture 1;
7. generic preferences.

The executable design and production layers define current callable APIs:

- `design.typ` for design-stage representation;
- `course.typ` for production slide implementation.

Do not infer API signatures from old prompts, historical drafts, or vendored
theme documentation.

## Pedagogical invariants across slide stages

- A section **ends on its own retrospective summary**; its last visible teaching move is not a teaser, next-section question, or "next we will" handoff. Establish required continuity at the beginning of the receiving section. Keep the lecture-level notebook assignment separate from the final section summary.
- Exact mathematical claims, model diagrams, figure/equation references and numerical worked examples require verifiable source or explicitly course-constructed provenance. Do not turn an unverified figure interpretation into a mandatory classroom calculation.
- Do not write speaker notes during lecture development.

## Slide design

Read:

- `.agents/skills/slide-design/SKILL.md`;
- `Lectures/slide_design_conventions.md`;
- `Lectures/design.typ`.

A lecture-local design normally lives at:

```text
Lectures/LXX_.../slide_design.typ
```

Each designed section begins with a design-only section-notes page followed by
the slide-design units for that section.

The design document contains real mathematics, wording, figures, and semantic
objects but deliberately abstract layout and reveal specifications.

## Slide authoring

Read:

- `.agents/skills/slide-authoring/SKILL.md`;
- `Lectures/slide_authoring_conventions.md`;
- `Lectures/course.typ`.

A production lecture normally lives at:

```text
Lectures/LXX_.../slide_deck.typ
```

Authoring lowers the approved design into exact Typst/Touying geometry and
timing without silently redesigning the explanation.

## Theme layer

The live course layer uses the vendored Ruled Page theme:

```text
Lectures/themes/ruled-page/template.typ
```

Treat vendored theme files and their `theme.md` /
`theme_design_spec.md` documentation as upstream implementation material, not
as course-authoring guidance.

Course-specific visual language and mechanics belong in `course.typ`.

The repository also contains other vendored themes used by the theme-sync
machinery. Their presence does not make them part of the live course design
system.

## Lecture-local supporting files

A lecture directory may also contain:

- generated figures;
- author-facing figure notebooks;
- standalone Typst schematics;
- source/provenance notes;
- student-facing computational notebooks;
- review artifacts or lecture-specific evaluation material.

These files may inform a design but do not override the current pipeline
artifacts.

## Validation

Mechanical checks and visual review are separate quality gates.

After editing a production lecture source, run:

```text
python scripts/check_typst_math_attachments.py <edited-file>
```

Compile both handout and presentation/reveal modes.

For targeted render review, use `scripts/review_slides.py`.

From the repository root, for example:

```powershell
uv --no-config --cache-dir tmp/uv-cache run scripts/review_slides.py Lectures/L01_Probability_Statistics/slide_deck.typ --slide "The Schur complement is the residual covariance"
```

Repeat `--slide` for multiple titles. Add `--offline` before the script path
when the tooling dependencies are already cached.

Current review PDFs, PNGs, and `report.json` are written under:

```text
build/slide-review/<lecture>/<entry>/
```

The review report is a mechanical aid, not visual approval. Inspect every
changed reveal state and the final handout state.

For bounded delegated layout review, use
`Lectures/slide_layout_review.md` with an exact allowlist and explicit
read-only or layout-only permission.

## Repository hygiene

Git history is the archive.

When slide-system guidance is superseded:

- move still-current material into the appropriate stage-specific document;
- update references;
- delete the obsolete file rather than keeping a “superseded” copy in the live
  tree.

Lecture-specific planning and review artifacts may remain when they are still
useful evidence, but they are not course-wide authority merely because they are
in the repository.

## General principle

Organization determines the teaching sequence.

Design determines the student-visible explanation.

Authoring realizes that explanation faithfully and maintainably.

The executable design and production layers should support those decisions
without becoming the source of pedagogical policy themselves.
