# L01 substantive explanations and short code notes

Implements the instructor’s 2026-10-17 distinction: Explanation to read owns a coherent mathematical or technical teaching move; Code to run owns brief documentation of supplied operations. When notes become long, consolidate the shared idea across cells into an explanation before the relevant code. This is a bounded authoring revision, not acceptance of the full notebook, lecture Scope or release readiness.

## Result and preservation

The canonical solved source now has 146 cells / 23 code cells and the same 18 immediate unnumbered question/answer pairs. All question and answer cells and all code cells, including their order, are exactly preserved relative to `42efbbc`. The student notebook is mechanically regenerated. The preceding parameter-paragraph edit was committed before this revision, and the instructor’s AI-use guidance remains intact.

Removed implementation-only explanation boundaries around plotting setup, the fixed case and evaluation displays. Each supplied code cell has short preceding notes, now 15–38 words excluding headings. The fixed-case note identifies which values are evidence and which are evaluation references; seed/version provenance remains in the supplied code and worked-solution handoff. The fresh-generation seed is discussed at that activity.

Consolidated block/vector representation and matrix assembly into one technical explanation before setup. Numerical comparison APIs and tolerance interpretation are taught together before their first use. Covariance-property and affine-generator explanations now precede the final supplied checking sequence. Expected versus realized loss is explained with the squared-loss identity. Required retrospective summaries remain concise; they are not padded to satisfy a length threshold. No new student exercise, algorithm or independent verification competency is added.

The existing authoring skill and style/tag reference now record the general distinction, brevity discipline, student-knowledge baseline and cross-cell consolidation rule. No new style document is introduced.

## Validation

The canonical locked local executor passed from a clean kernel; [raw output](execution.txt) records the result. All 23 code cells executed, all numerical assertions pass, no error output occurs and three inline figures render. Pixel arrays match the previous support-package inline figures exactly. The executed notebook remains under ignored `build/notebooks/`.

Structural checks validate both schemas, exact mechanical student derivation, unique cell IDs, heading hierarchy, immediate unnumbered answers, preserved Q&A and all code, preceding supplied-code notes and retained case provenance. [validation.json](validation.json) records source hashes and counts. The coordinator authored and reviewed this consolidation; no separate review was commissioned. The earlier [structure review](../material_structure/report.md) is evidence for its exact prior source, rather than an independent review of this version.

A separate comparison helper initially used system Python, which lacks NumPy; it was rerun successfully with repository uv. This was a helper invocation error, not an error in the notebook execution. No environment or dependency change was needed.

Public package availability, a fresh hosted Colab run, instructor acceptance and learner timing remain pending. Local execution does not establish those gates.
