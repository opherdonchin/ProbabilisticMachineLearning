# L01 instructor-communication review — raw evidence

**Reviewer:** delegated Lecture Scope specialist `/root/l01_architecture_tensions`, separate from scope author `/root/l01_existing_argument`.  
**Branch:** `rescope-l01-l12-architecture-alignment-20261014`  
**Reviewed HEAD:** `7d47bd4615f8ad08a37d6cd0543658447e362f45`  
**Reviewed working-tree scope blob:** `b37da7ffa4d1982ea1da0218ab01073b0aa093b5`  
**Boundary:** Communication-only review, not formal source-arc or Section Design feasibility approval, runtime validation or student validation. Findings below target the pre-repair scope and supporting documents. Subsequent corrections are coordinator/author work and were not re-reviewed here. This preserves the exact returned review.

**Verdict: the revised scope substantially resolves the communication problem.** Reviewed working-tree blob `b37da7ffa4d1982ea1da0218ab01073b0aa093b5` at HEAD `7d47bd4615f8ad08a37d6cd0543658447e362f45`. This is an instructor-communication review, not formal source-arc or Section Design feasibility approval.

The scope now separates existing material, criticism, concrete proposals, accepted direction and unresolved choices. Its account of the residual derivation and interpreted quadratic separation matches the deck. The recommended route/proof defaults and alternatives have explicit consequences. I found no silently approved new teaching decision.

Three repairs remain:

1. **Current supporting documents contradict the withdrawal of the architecture amendment.** `lecture_scope.md:27` correctly says the L01 architecture already includes the broader tasks and operations. Yet `reconciliation/matrix.md:17–18` still presents architectural understatement and new wording as actionable recommendations; `development_state.md:27` also keeps architecture revision among likely impacts. Update the current matrix recommendation to “no amendment justified on this point; synchronize notebook description only after accepted handoff changes.” Preserve the raw historical assessment unchanged.

2. **The computational-cost paragraph lacks a clear instructional status.** `lecture_scope.md:89` introduces factorization/reuse complexity absent from the current deck, but does not identify whether this is a proposed student-visible comparison or author checking material. If teaching it is proposed, label it “state and interpret briefly within E” and place it before E’s retrospective. Otherwise move it to checking material. This resolves the ambiguity without deciding its treatment for the instructor.

3. **Reconcile version and correction ownership.** `development_state.md:23` identifies `120056e…` as the current proposal, although that is now the preceding committed version. Update the register when this revision is committed and record this bounded review accurately. In `lecture_scope.md:27`, replace “My earlier proposal” with “The earlier reconciliation recommendation”: the architecture proposal came from the delegated assessment/coordinator synthesis, whereas this scope’s author is `/root/l01_existing_argument`.

The remaining unsettled matters—measurement context, exact workload, PyMC balance, and fuller proof depth—are clearly reserved for discussion. They need decisions at their owning stages, not additional explanatory paperwork now.
