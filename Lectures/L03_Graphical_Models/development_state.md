# L03 — current authority and development state

This register indexes accepted decisions and remaining work; the [scope](lecture_scope.md) owns the pedagogy.

## Branches, revisions and stage

- Current proposal branch: `scope-l03-l12-course-architecture`, reconciliation starts from `2499e988706005b12c62f0d2bfb037f47b7c0c9e`.
- Existing lecture authority: `origin/lecture-3-authoring`, fetched commit `8007d42b2871181a6966ab4d55417c10af9b5544`. Source scope blob `0656648fd43374997469174a845418a802b3aefe`; source register `caef6a625c8525e90ecdfe83912a43f3a462fa8a`; proposed section-design blob `2cb8c35a417e02720c9b4f0b1138c93469db7c05`.
- **Lecture Scope: instructor-agreed**, restored here as blob `2d5992a3f05d952dc21553690039fe021fd6284a`. Only optional future lecture labels were updated to current L08/L09/L10; reconciliation provenance was added.
- **Section Design: proposed, not approved as a whole**, remains on its authoring branch. Individual agreed directions do not approve all seven sections. No section design, slides or notebook implementation has been imported.
- No branch merge was performed. The instructor identified the earlier scope as the existing agreement in the current discussion, 2026-10-12.

## Accepted teaching commitments

The live lecture develops L02’s Markov chain into DAG factorization, works the student network and parameter economy, develops directed independence/d-separation/blankets, introduces undirected potentials and global normalization, compares the two independence languages, and ends with binary Ising interpretation. Plates are introduced briefly. Students are not assumed to know general d-separation already.

Image prior, Gaussian likelihood, joint/posterior, single-site conditional and ICM are **new notebook work**. Supply data, plotting, small interfaces and checks; do not pre-solve these derivations live. The simpler algorithm remains selected and is compatible with the original agreement. A successful local update is not a guarantee of a global optimum or posterior marginals.

The instructor reviews scopes with their questions and decides where to stop. The previously suggested fresh A/B route choice is withdrawn: that question had already been resolved in the earlier scope discussion.

## Diagnosis and review evidence

The batch run missed the existing agreement on another branch and generated a replacement. It also treated application feasibility as sufficient evidence for the lecture’s organizing argument. Earlier L03 reports remain identifiable evidence about the batch scope, not approval of the restored scope. Read the current correction in [L03 review evidence](../course_architecture_scope/reviews/L03_review.md).

Actual independent diagnosis: Lecture Scope `/root/l03_arc_diagnosis` and Section Design `/root/scope_method_diagnosis` inspected the authoritative branch and compared it with batch scope `cccc6f319d5d1046b14efb4078ba55a37e414268`. The independent targeted reconciliation/process review passed with advisory risks, no reconciliation blocker, against final scope `2d5992a3f05d952dc21553690039fe021fd6284a`; current report blob `c7a74f74335d44f2e47821909150a9e051f9a3c5`. New skill instructions require agreement discovery across relevant branches, argument comparison and review of both pedagogical justification and feasibility. No behavioral validation of future agents is claimed.

## Remaining risks and next owner

- **Section Design:** verify the proposed Fig.4.23(a) multipath example before approving it. The source branch records an incorrect direct `X4 → X7 ← X5` claim; its connection passes through `X6`. This blocks that exact worked example, not the agreed scope. Review specificity and extent of proposed sections4–7; validate the course-constructed potential table and its attribution.
- **Notebook author:** validate a worked instructor solution, the one-hour student task, and later clean local uv/hosted Colab runs. The recovered secondary ICM reference remains a candidate requiring source inspection before adoption. None of this is completed by restoring a scope.
- **Coordinator:** shared L03 syllabus/plan/ledger/audit promises are reconciled. Other nine scopes remain byte-unchanged. L08’s actual entry requires ordinary graphical factorization, which this scope supplies. L09/L10’s local-update comparisons draw on the L03 notebook, not live algorithm teaching; no new downstream blocker is demonstrated. At their own review, retain that delivery distinction.
- **Instructor:** continue reading L03 with its questions and choose the next substantive issue. No new route selection is required. Full Section Design approval remains outstanding on `lecture-3-authoring`.
