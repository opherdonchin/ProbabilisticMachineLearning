# Proposal validation evidence — 2026-10-11

**Scope:** coordinator mechanical checks of the L03–L12 proposal on `scope-l03-l12-course-architecture`, compared with starting commit `906ce71dd9c8e29f3dede51ec809442a885354c9`. These checks complement, and do not replace, the actual independent specialist evidence in [STATUS](STATUS.md) and the [adversarial report](reviews/course_architecture_review.md). Final content/closure revisions are registered in STATUS.

## Typst and rendered output

Typst 0.15.0 compiled both current sources successfully, with exit code 0 and no compiler warnings:

```sh
typst compile --root . syllabus_plan.typ build/typst-validation/syllabus_plan.pdf
typst compile --root . advanced_statistics_2027_1_syllabus.typ build/typst-validation/advanced_statistics_2027_1_syllabus.pdf
```

The compiler was obtained in `/tmp/typst-0.15.0/`, without changing repository dependencies. `pdfinfo` reports three A4 landscape pages for the plan and four A4 portrait pages for the formal syllabus. Poppler rendered all seven pages; coordinator visual inspection found legible tables/schedules and no evident clipping or collision. Lecture entries can continue across pages under the existing breakable layout. `typstyle` is unavailable; no formatter pass is claimed. Generated PDFs/renders are validation outputs under ignored `build/` or `/tmp/`, not published student artifacts; no committed obsolete syllabus PDF remains beside updated source.

## Structure, protection and references

- Exactly ten scope files L03–L12 each contain all five numbered parts: intellectual arc, mathematical spine, notebook handoff, concrete examples and lecture contract. Ten actual raw specialist reports exist, plus the separate course report. Exact final scope/review blobs and original target mapping are in STATUS.
- Formal schedule has exactly 13 meetings, numbered 1–13, every seven days on Wednesday from 21.10.2026 to 13.01.2027. The plan likewise preserves 13 rows and L13 projects, with no new lecture debt assigned there.
- All 66 tracked files under the protected L01/L02 directories and the delivered L01 solved notebook are byte-identical to the starting commit. Formal L01, L02 and L13 lecture blocks and plan L01/L02 rows are unchanged. The delivered-ledger prefix, including actual dispositions and boundaries, is byte-identical; only future allocation was rewritten.
- Current relative Markdown and Typst `link` targets in all scopes, course-architecture reports and five synchronized artifacts were checked for filesystem existence, with zero broken targets. This checks actual links, not every plain-text historical input path or external URL. Local textbook/application provenance and legitimate online sources are recorded in the source register; no full external crawl or runtime-portability claim is made.
- Superseded preliminary scope/comparison/optimization audit/prompt files were removed after reference search. Their only remaining named reference is L04's explicitly historical GitHub URL pinned to the inspected starting commit; no current local link depends on a deleted draft. Historical reviews and build-input versions remain in Git and raw evidence.
- Original L09/L12 full-review byte prefixes were compared against their recorded original Git blobs and are exactly preserved; targeted evidence is append-only. All other original individual reviews remain unchanged. Scope metadata changes retain original author/input provenance and bind current approval to STATUS.
- `python scripts/check_codex_setup.py` passed: nine canonical skills and five Codex execution profiles. `git diff --check` passed. No slides, notebooks, SVG/PNG assets, Python implementations, environment pins or lockfile were changed in this scoping proposal.

## Content and approval limits

The coordinator reconciled source ownership, prerequisite order, one-lab endpoints, source depth and loss units through three waves. Independent reviews supply the mathematical/feasibility evidence; a fresh cold reviewer challenged the full course before reading coordinator justifications. L09 HMC-depth wording and L12 distortion scoring received owner revisions and independent targeted checks. The final separate synchronization addendum binds formal documents and metadata to final scope blobs; its exact provenance is in STATUS.

All ten approvals are **agent-approved / instructor-pending**, under WORK_ORDER. No source notebook/course adaptation was executed, and no student timing, rehearsal, clean local uv run or hosted Colab validation was performed. Checked tiny mathematical examples are scope evidence, not notebook tests. Prepared utilities/checkpoints, CPU runtime, mobility distribution access and actual L02 delivery remain downstream authoring gates. No merge or student syllabus publication occurred.
