# Verification of the clear mathematical proposal — 2026-10-12

This communication revision starts from `4b886903925c25dc52434c962789c367db3d6ec6`. It strengthens the mathematical explanation and preparation readings, rather than changing the course scope. Exact target files and current review evidence are in [STATUS](STATUS.md).

## Substance and source checks

The teaching-choice report now states relevant equations, assumptions, treatment depths and alternatives. Focused readings identify actual Murphy sections and explain what to look for. The overview gives the formal connections across lectures. The syllabus, plan, future ledger and notebook descriptions retain the same reviewed mathematical and computational activities with more precise terminology. AGENTS.md, the nine skills and coordinator guidance assume a mathematically mature reader who may need background on an unfamiliar method.

The independent Section Design precision/source review passed with feasible-with-risks and no material mathematical/source blocker. It checked the revised discussion and focused readings against the actual textbooks and unchanged scopes, including two notation repairs before its final snapshot. Its dated addendum is in the [revision report](reviews/readability_revision_review.md). Mathematical exposition is checked for correctness and clarity, not certified by a new instructor decision or a student usability trial.

## Mechanical results

- All ten five-part scope files are byte-identical to the starting commit. Their exact previous independent-review targets still match; the lighter L04 model remains the already-reviewed three-bit parity example.
- All 66 tracked protected L01/L02 files and the delivered L01 solution are unchanged. The formal L01/L02/L13 argument blocks, plan L01/L02 rows and complete delivered-ledger prefix are byte-identical. Future allocations still do not advance delivered coverage.
- The plan and formal syllabus retain exactly 13 numbered meetings, weekly Wednesdays from 21 October 2026 to 13 January 2027. L13 remains projects.
- Current relative Markdown and Typst links, including all nine skill links to the shared writing policy, resolve. Original individual and whole-course review records remain unchanged contiguous evidence; the previous readability review is retained before the new append-only check.
- `python scripts/check_codex_setup.py` passed for nine skills and five profiles; the skill-creator validator passed for the coordinator skill. `git diff --check` passed.
- No notebook, teaching figure, slide deck, Python implementation, environment pin or lockfile changed. No notebook execution, hosted Colab run, student timing or lecture rehearsal occurred.

## Compilation and layout

Typst 0.15.0 compiled both current sources with exit code 0 and no warnings:

```sh
typst compile --root . syllabus_plan.typ build/typst-validation/syllabus_plan.pdf
typst compile --root . advanced_statistics_2027_1_syllabus.typ build/typst-validation/advanced_statistics_2027_1_syllabus.pdf
```

The plan has four A4 landscape pages and the formal syllabus five A4 portrait pages. Poppler rendered all nine current pages; coordinator inspection found no evident clipping or collision. Each formal lecture entry stays together, and the plan's omission table starts with its heading on a fresh page. These layout adjustments change no teaching content. Generated checking files are ignored build outputs, not student releases. `typstyle` is unavailable, so no formatter pass is claimed.

## Approval and practical limits

The instructor's L03/L04 decisions and earlier architecture acceptance are preserved. Other teaching choices await instructor oversight. Mathematical and source checks do not validate notebook scaffolding, runtime or teaching pace. Those remain future authoring obligations, including clean local uv/hosted Colab tests. No merge or student release is implied by passing this communication check.
