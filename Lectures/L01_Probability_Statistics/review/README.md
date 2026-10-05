# L01 persona review harness

This directory contains a reproducible, intentionally separated review setup for Lecture 01.

The goal is to obtain five raw readings of the same lecture from five substantially different people, not five applications of a shared pedagogical rubric.

## Design

- `reviewer_protocol.md` contains only the common mechanics of how to experience and report the lecture.
- `personas/` contains the five embodied reviewers.
- `codex_run_prompt.md` is the orchestration prompt to paste into Codex in VS Code.
- `reports/` is reserved for raw reviewer output.

The reviewers are:

1. Noa Ben-Ami — mathematically strong BME student whose probability background is stronger than her ML background.
2. Amir Cohen — practically experienced engineer/programmer returning from industry.
3. Maya Shalev — experimentally minded biomedical researcher focused on biological meaning and measurement.
4. Eitan Mizrahi — experienced, time-constrained MSc student who naturally organizes material into durable conceptual structure.
5. Dr. Yael Harari — technically literate academic-development consultant who respects difficult technical teaching but looks critically at intellectual architecture.

## Independence rule

Each reviewer must receive only:

- the rendered L01 lecture;
- `reviewer_protocol.md`;
- that reviewer's own persona file.

A reviewer must not read another persona file, another reviewer's report, or any synthesis before completing its own report. The coordinator must not normalize, reconcile, or rewrite the five reports.

## Lecture target

The review target is the current rendered form of:

- `Lectures/L01_Probability_Statistics/slide_deck.typ`

The existing `slide_deck.pdf` may be used only if it is known to reflect the current source. Prefer compiling a fresh temporary PDF before a review run. The student reviewers should experience the rendered slides, not inspect Typst source or speaker notes.

## Re-running

When L01 changes, rerun the same five reviewers against the new rendered deck. Preserve previous reports if comparisons across revisions are desired; use a dated or commit-specific subdirectory rather than overwriting them.

The review harness is deliberately plain Markdown rather than a Codex skill. The personas are experimental inputs and should remain visible and version controlled.