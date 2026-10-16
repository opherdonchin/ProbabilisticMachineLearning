# Current verification — L03 agreement restoration, 2026-10-12

The proposal branch restores L03’s existing instructor agreement, recovered from `origin/lecture-3-authoring` at `8007d42b2871181a6966ab4d55417c10af9b5544`. It does not replace that agreement with another route or approve the proposed section design. [STATUS](STATUS.md) and the [L03 register](../L03_Graphical_Models/development_state.md) identify current authority and approval boundaries.

## Content and independent review

The restored scope matches source blob `0656648fd43374997469174a845418a802b3aefe`, except optional future lecture labels updated to the current order, a labeled provenance appendix, and three formatting-only Markdown hard breaks. Final scope blob: `2d5992a3f05d952dc21553690039fe021fd6284a`. No section partition or topic-by-topic timings were added.

The independent Section Design specialist `/root/scope_method_diagnosis` checked source equality, shared live/notebook promises, actual L08 prerequisites and the scope/coordinator/review instruction changes. Verdict: **feasible with risks**, no reconciliation blocker. Its [dated correction and targeted review](reviews/L03_review.md), current report blob `c7a74f74335d44f2e47821909150a9e051f9a3c5`, explicitly qualifies earlier diagnoses based on incomplete authority. Passing batch-scope reviews are not transferred to the restored scope. Future agent behavior has not been tested.

Both syllabi, the future ledger, notebook audit, architecture explanation and teaching-choice report preserve the accepted boundary: graphical-model foundations and Ising interpretation are live; image model construction, posterior, local conditional and ICM are new notebook work. The notebook hour remains demanding; supplied helpers are requirements for future authors, not completed assets.

## Mechanical checks

- Exact normalized comparison against the accepted source passed. The other nine scope texts are byte-identical to baseline `2499e988706005b12c62f0d2bfb037f47b7c0c9e`.
- All 66 protected L01/L02 files and the prepared L01 solution are unchanged. Formal L01/L02/L13 blocks, plan L01/L02 rows and the prepared L01 coverage details are byte-identical. Planned material is not actual classroom coverage.
- Both syllabi retain 13 numbered meetings, weekly Wednesdays from 21 October 2026 to 13 January 2027. L13 remains projects.
- The local reference check passed for 137 Markdown/Typst links; original individual and whole-course review records remain unchanged contiguous evidence.
- `python scripts/check_codex_setup.py` passed for nine skills and five profiles. The skill-creator validator passed for the scope skill. `git diff --check` passed after formatting-only hard-break cleanup.
- No notebook, slide, teaching figure, Python implementation, environment pin or lockfile changed. No notebook execution, hosted Colab run, student timing or rehearsal occurred.

## Compilation and layout

Typst 0.15.0 compiled both current sources with exit code 0 and no warnings:

```sh
typst compile --root . syllabus_plan.typ build/typst-validation/syllabus_plan.pdf
typst compile --root . advanced_statistics_2027_1_syllabus.typ build/typst-validation/advanced_statistics_2027_1_syllabus.pdf
```

The plan has four A4 landscape pages; the formal syllabus has five A4 portrait pages. Poppler rendered the changed L03 page and the plan’s first two pages. Coordinator inspection found no evident clipping or collision; the formal L03 entry stays together. Build PDFs were regenerated and are ignored checking artifacts. `typstyle` is unavailable, so no formatter pass is claimed.

## Remaining work

L03 Section Design’s exact-example checks and complete approval remain outstanding on its authoring branch. In particular, the recorded Fig.4.23(a) path issue has not been reverified by this repair. Notebook authoring must validate a worked solution, exercise timing and clean local/hosted Colab runs. Other later teaching choices remain proposals for instructor review. The branch is not merged or released to students.
