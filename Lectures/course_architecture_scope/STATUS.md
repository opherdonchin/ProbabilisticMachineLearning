# L03–L12 autonomous scoping — scope and review registry

**Branch:** `scope-l03-l12-course-architecture`. **Instructor architecture/base:** `b78a7650bb09ae851e412089d98525f7b71275d9` (main/PR #8). **Starting HEAD:** `906ce71dd9c8e29f3dede51ec809442a885354c9`.
**Authority:** instructor [WORK_ORDER](WORK_ORDER.md), 2026-10-11; agent approval is distinct from instructor approval.
**Delivery:** completed proposal branch. On 2026-10-11 the instructor explicitly authorized pushing `scope-l03-l12-course-architecture` to the configured `origin` (`https://github.com/opherdonchin/ProbabilisticMachineLearning.git`), resolving the prior automatic publication-approval rejection. This authorization covers branch publication only; no merge, ready-to-merge PR or student release is authorized.
**Stage:** all ten scopes, individual independent previews, wave reconciliation and separate adversarial cold review complete. Formal documents synchronized and independently verified; mechanical validation passed. Completed agent-approved / instructor-pending proposal; no unresolved scope, review, reconciliation or synchronization blocker. Instructor oversight is the next stage.
**Final proposal Git commit:** `54bbc5151063ecb7eec6a6d0f95cb3c34477c585` contains every final scope, raw review, synchronized course artifact, audit, human report and validation record. The following registry-only closure changes no approved content. **Final branch/registry closure commit:** resolve exactly with `git log -1 --format=%H -- Lectures/course_architecture_scope/STATUS.md`; equivalently `git rev-parse HEAD` on the delivered branch. A commit cannot embed its own SHA; this distinction records the literal content revision without mislabeling the reviewer's earlier checkpoint as the final proposal.

## Agent approval and exact artifact identities

The coordinator `/root` approves all ten scopes as **agent-approved / instructor-pending** under WORK_ORDER: complete five-part artifacts, actual independent section_design previews, no unresolved blocker, reconciled prerequisites/depths and cold course review feasible-with-risks. Approval applies to the final content blobs below, not merely a common branch HEAD. No instructor acceptance of these new scopes is claimed.

Builders are actual lecture_scope BUILD threads; reviewers are distinct actual section_design feasibility-review threads, independent of each lecture's builder. All original verdicts are feasible-with-risks. Build-input revisions in scope headers describe what authors inspected at build time; they do not replace current handoff/review provenance.

| Scope | Final approved scope Git blob | Builder thread | Independent reviewer thread / evidence | Initial full-review target blob | Current review Git blob |
|---|---|---|---|---|---|
| [L03](../L03_Graphical_Models/lecture_scope.md) | `f4ab82808c1cc6b4b32c38588c6c2e969483b036` | `/root/build_l03` | `/root/review_l03`; [raw evidence](reviews/L03_review.md) | `f4dab507f90618362c2e04c1c3791c8139f7de56` | `d1935f9d91363357c932deabc46788225f587a5a` |
| [L04](../L04_Information_Theory/lecture_scope.md) | `6b008770631926f61e51d838a126651c2200466e` | `/root/build_l04` | `/root/review_l03`; [raw evidence](reviews/L04_review.md) | `242ee28d251d583004daa25379b6a0f8cb44d622` | `45e733979a2e29e50182f2ee8205cf4b158d4194` |
| [L05](../L05_GLM_Optimization/lecture_scope.md) | `6f7200e2383a2136687fe03cbb8b35b67f76d696` | `/root/build_l05` | `/root/review_l05`; [raw evidence](reviews/L05_review.md) | `736943b90f24826e29955115896929742f2961f5` | `de0ba605f50bc1997eba1cf98738e7e36ac4be40` |
| [L06](../L06_EM/lecture_scope.md) | `c29aefd80dbd192a6a4da4b79e5e299df343875a` | `/root/build_l03` | `/root/review_l05`; [raw evidence](reviews/L06_review.md) | `326267281c6b6775ac9a33d7ed4f022a859fc49b` | `206d3a72ea2d7f3f8406b429f1a485d157019b61` |
| [L07](../L07_Inference/lecture_scope.md) | `80eacfd8c3e7e3bb4eb00d9bb23ccdb1c2ddcb0a` | `/root/build_l04` | `/root/review_l05`; [raw evidence](reviews/L07_review.md) | `f12fba8de7339675d09a771c5f956c8ed93649d8` | `71cb04ec9c9b9c65acb3254620f4792b4e03498b` |
| [L08](../L08_Structured_Inference/lecture_scope.md) | `4ae9853bf48899edeab65a1c2b503dfad0c1f990` | `/root/build_l05` | `/root/review_l03`; [raw evidence](reviews/L08_review.md) | `b7a2de325c364bcde8230c33aaba2a5cd6b8596a` | `ccdb82afd3899c3bdeb974cdaaf6c3a119169aab` |
| [L09](../L09_Variational_Inference/lecture_scope.md) | `7072832dfbf350454d66a0440abea8201bf530e0` | `/root/build_l03` | `/root/review_l05`, targeted `/root/review_l11`; [raw evidence](reviews/L09_review.md) | `a8080351116f51a34eddd3e5dc06d65f7025722e` | `240e3f31d1d156804c06c835ba7129c13183d472` |
| [L10](../L10_MCMC/lecture_scope.md) | `55359f7aeeeb5eb838915386ca5222981f8236c5` | `/root/build_l04` | `/root/review_l10`; [raw evidence](reviews/L10_review.md) | `9503b32aef49e7090792ea7e38d3acfb808a973b` | `681b5d1d2c85cecd41b21e06bb2a53949684a276` |
| [L11](../L11_Neural_Prediction/lecture_scope.md) | `c9c3298efa4e11a0baedaa6bd06d72aba64ee86d` | `/root/build_l11` | `/root/review_l11`; [raw evidence](reviews/L11_review.md) | `0c564a7e5b1fd308282ab2ea6488927a44bc890a` | `455baa985337507aa54b69be9f047766a92b1968` |
| [L12](../L12_VAE/lecture_scope.md) | `ae38514fa2daf5502c411a3c5528cfa6a2becbdc` | `/root/build_l03` | `/root/review_l11` (full and targeted); [raw evidence](reviews/L12_review.md) | `fe07f77461bbded7e6a17be6050b204133994072` | `e6beff2e2c81fd87b646288a568c4f9a09d3b896` |

### Revision mapping and preserved raw evidence

L03–L08, L10 and L11 changed only coordinator status/footer wording after their full previews; L04 also converts the superseded preliminary-input link to its historical committed URL. These are provenance corrections, not new curricular commitments. All final scope headers link here and leave original build-input provenance intact. The final whole-course synchronization check independently compares the exact revisions.

L09's original full review targeted `a8080351116f51a34eddd3e5dc06d65f7025722e`. Its single deferred-row repair `b6b98a1a0027e710c18aa596b79ac04ef7af248f` clarifies that L10 supplies HMC mechanics/recognition only and full theory is omitted. `/root/review_l11` independently targeted-rechecked it; subsequent changes are status/footer metadata. L11's builder inspected earlier L09; its independent reviewer checked both and confirmed its needed math/handoff unchanged.

L12's original full preview targeted `fe07f77461bbded7e6a17be6050b204133994072`. Original builder `/root/build_l03` added only the expected-q, event-summed, count-weighted distortion handoff at `e2dcff939358ac4321c9ee5859f919ece1e4b488`, committed in `3fae81a`. `/root/review_l11` independently rechecked the final scope `ae38514fa2daf5502c411a3c5528cfa6a2becbdc`, confirming this repair plus only coordinator metadata, unchanged fit/time budget and no blocker. Both original raw review prefixes are byte-preserved, with targeted evidence appended.

### Separate adversarial course review

Actual fresh `/root/course_adversary` (lecture_scope feasibility-review) did not build or individually review these lectures. It read all ten scopes and a factual allocation/prerequisite/budget extract before coordinator justifications or raw local reviews, persisted the cold findings, then compared reconciliation evidence. [Complete report](reviews/course_architecture_review.md): feasible-with-risks, no architectural blocker. Original targets are all frozen at checkpoint `39ba5b50a40fa2af6dbc50ba69a059d637aa990d`; the raw report lists every exact before/after blob.

C1 distortion estimation is resolved by the author-owned L12 repair and independent check. C2 scaffolding, C3 small timing margins and C4 lost applications remain explicit constraints/human questions. C5 metadata is finalized through exact mapping here. Final synchronization verification by the same independent course reviewer passed with feasible-with-risks and no blocker. Report blob including original cold pass and append-only final addendum: `dfd20d4c59864d8812d4cbd3251c99c69c0a8c49`. The addendum lists exact final scope and synchronized-document inputs and verifies unchanged scopes, safeguards, protected content and 13 dates. Its pre-closure STATUS hash is historical inspection provenance; closure only updates gate/commit evidence.

## Gate ledger

| Gate | State / owning evidence |
|---|---|
| Repository/main/protected boundary | Passed: clean start, origin pull, actual L01/L02 inspected and protected |
| Ten complete five-part scopes | Passed: final blobs above |
| Ten actual independent feasibility previews | Passed: raw evidence and original targets above |
| Waves A/B/C, minimum repairs and targeted checks | Passed: L09 HMC and L12 distortion checks; no unresolved blocker |
| Separate cold adversarial whole-course review | Passed: feasible-with-risks, raw report |
| Syllabus/plan/ledger/notebook audit/decisions synchronization | Passed: independent final synchronization addendum, exact input hashes in raw report |
| Consolidated human questions | Completed: [questions and hesitations](questions_and_hesitations.md) |
| Typst/dates/links/protected content/revision checks | Passed: [validation evidence](validation.md); both syllabi compile, references/dates/protected content checked |
| Coherent proposal content commit / registry closure | Passed: proposal `54bbc5151063ecb7eec6a6d0f95cb3c34477c585`; final registry-only closure recorded by Git as above |
| Instructor acceptance / production / merge | Pending and outside autonomous authorization |

## Allocation and residual risks

[Whole-course audit](architecture_audit.md) is the current source-ownership matrix, prerequisite graph, notebook sequence and omission record. [Source register](source_inspection.md) pins inspected textbooks/notebooks and source errors. [Notebook audit](../notebook_reference_audit.md) carries exact math/harness/scaffold constraints. [Planning decisions](../syllabus_planning_decisions.md), [plan](../../syllabus_plan.typ), [formal syllabus](../../advanced_statistics_2027_1_syllabus.typ) and [future ledger](../material_ledger.md) describe those same scopes.

L01 delivered ledger/source and L02 agreed contracts are unchanged. L02 is not recorded as delivered; its malformed/stale development_state is not inherited as new approval. No slides, figures, student notebooks, mandatory recordings or dependency changes were made. Future budgets total 1117 live minutes including 120 reserve plus 600 lab minutes: estimates, not rehearsal or runtime evidence. Greatest workload risks are L05 first PyTorch, L08 recurrences, L09 sampled objectives and L12 integration; named utilities/checkpoints are required future supplied production, not already validated deliverables.

Controlled examples sacrifice MRI, Kalman forecasting, GDP/unknown-noise VI-HMC and broader empirical modeling. SMC, advanced optimization, full HMC/VI catalogues, specialized GLMs/graphs, architecture/BNN/GP/calibration and generative surveys are explicit omissions. Mobility access/likelihood interpretation and all clean local uv/hosted Colab runs remain downstream gates. Consequential reversible choices, alternatives and costs are in the instructor report.

## Execution checkpoints and next owner

Source contract v1 `882a9b2e76134d4952b218492a3564e117f6d6b4` (374bc6d); Wave A v2 `12ae5e1608eb2d74c6c70ba857eb5a75ff2114c1` (791e71b); Wave B v3 `54064183398bd643a895c5e38a023f793dc2d9d6` (9b62b6c). These are historical build inputs in Git; the current audit supersedes the build contract. Superseded planning drafts were removed after updating current references.

Usage-limit failures interrupted L09 review/L10 build; both actual threads resumed after the instructor reported upgrade and completed the required work. No review was inferred from an interrupted turn. At most three active threads including coordinator were used concurrently.

**Next owner:** Instructor oversight of this complete proposal; acceptance before Section Design/production. All autonomous gates are complete; scope and review identities remain the exact approved blobs above. No merge, ready-to-merge PR or student publication is authorized.
