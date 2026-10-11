# What we checked in the readable revision

This record describes checks of the documents, not a trial of the lectures or notebooks. The revision starts from branch commit `39446b5d0fc520a690ed612f0845203ed8d02498`. Exact final file versions and review identities are in [STATUS](STATUS.md).

## Writing and mathematical review

Two scope authors rewrote all ten lectures to explain the problem and student task before introducing unfamiliar methods. The coordinator rewrote the course explanation, teaching questions, notebook responsibilities, planning records and syllabi. All nine course skills now link to the shared writing rule in AGENTS.md; the coordinator must also check whether returned explanations can be understood from the instructor's stated background.

A separate reviewer completed the comparison against the prior scope content and returned feasible with risks, without a demonstrated blocker. The only intended change to a required example is L04: three-bit error detection and uncertain decoding replace the five-bit guaranteed-correction lab. Exact review evidence and its verdict are in the [revision report](reviews/readability_revision_review.md). Original independent reports are retained verbatim after new coordinator-written reading guides. A reading guide is not itself independent review or instructor acceptance.

## What the document checks establish

- All ten scopes retain their five required parts. Exact mathematical tables and example commitments remain available for later authors. The independent comparison checks their meaning, rather than assuming that a similar title implies unchanged content.
- All 66 tracked files in the protected L01/L02 directories and the delivered L01 solution are byte-identical to the prior branch. Formal syllabus L01/L02/L13 argument blocks and plan L01/L02 rows are unchanged. The entire delivered-ledger prefix is byte-identical. The presentation of future teaching does not claim it has already been delivered.
- Both the plan and formal syllabus have 13 numbered meetings. Dates remain weekly Wednesdays, 21 October 2026 through 13 January 2027. L13 remains projects.
- Original bytes of all ten individual reviews and the whole-course report remain as unchanged contiguous records inside the current files. New plain-language guides precede them; the original record is no longer the file's first byte. L04's new review is added separately and explicitly checks the changed three-bit task.
- Relative Markdown and Typst links in current scopes, course reports, synchronized artifacts, AGENTS.md and all nine skills are checked for file existence. The skill-policy links point to the actual AGENTS.md heading. Historical external URLs are source references, not current local dependencies.
- `python scripts/check_codex_setup.py` passed for nine canonical skills and five execution profiles. The skill-creator validator passed for the updated coordinator skill. `git diff --check` passed.
- No notebook, slide deck, SVG/PNG teaching asset, Python implementation, dependency pin or lockfile was changed. Checks and validation outputs remain in ignored `build/` or `/tmp/`.

## Syllabus compilation and reading

Typst 0.15.0 compiled both source files successfully with no warnings. The current plan has three A4 landscape pages; the formal syllabus has five A4 portrait pages. Poppler rendered all eight pages for visual inspection. No evident clipping or collision was found. The lecture number/date and title now stay together; this fixes an orphaned Lecture 13 heading without changing its content. Detailed entries may still continue across pages.

```sh
typst compile --root . syllabus_plan.typ build/typst-validation/syllabus_plan.pdf
typst compile --root . advanced_statistics_2027_1_syllabus.typ build/typst-validation/advanced_statistics_2027_1_syllabus.pdf
```

The compiler is in `/tmp/typst-0.15.0/`; no repository dependency was added. `typstyle` is unavailable, so no formatter pass is claimed. These PDFs are checking outputs, not student releases.

## What these checks do not establish

No future student notebook was executed, no hosted Colab runtime was tested, and no lecture or student task was timed. Authors still need to build the promised helpers/comparison fits, check data access and run clean local and hosted notebooks before publication. Mathematical spot checks establish small calculations, not student completion time.

The instructor agreed to the course order and two simpler choices, then paused further decisions. The readable revision does not infer acceptance of the rest of the course or permission to begin production, merge main or release material to students. Original reviews, revised review and instructor decisions are distinguished in the current register.
