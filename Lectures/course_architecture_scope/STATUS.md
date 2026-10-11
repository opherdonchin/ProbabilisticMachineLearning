# L03–L12 autonomous scoping — execution status

**Branch:** scope-l03-l12-course-architecture
**Base:** main, after instructor-selected curriculum merged in PR #8 (b78a7650bb09ae851e412089d98525f7b71275d9)
**Operating contract:** [WORK_ORDER.md](WORK_ORDER.md)
**Status:** RUNNING. Branch refreshed from origin; initial working tree clean. Starting HEAD 906ce71dd9c8e29f3dede51ec809442a885354c9; main/base b78a7650bb09ae851e412089d98525f7b71275d9. Source-ownership contract and inspection register committed at 374bc6d. Distinct configured lecture_scope builders /root/build_l03 and /root/build_l04 launched successfully. No scope approval yet. This course-local STATUS serves as the batch development-state index; lecture contracts remain their owning artifacts.

## Core authority

Instructor delegated this review-batch autonomy on 2026-10-11: coordinator may generate, revise, review and internally approve feasible L03–L12 scopes without interim human intervention, subject to a later human review. Agent-approved is never recorded as instructor-approved. The delivered L01 material and agreed L02 contracts are protected.

## Per-lecture register

| Lecture | Focus | Scope author / revision | Independent review / revision | Gate | Principal unresolved handoff |
|---|---|---|---|---|---|
| L03 | Graphical models | /root/build_l03, blob f4dab507f90618362c2e04c1c3791c8139f7de56 | /root/review_l03; reviews/L03_review.md targets f4dab507, feasible-with-risks | Agent-approved / instructor-pending; global audit pending | Ising image denoising versus unavailable later MCMC machinery |
| L04 | Information theory | /root/build_l04, blob 242ee28d251d583004daa25379b6a0f8cb44d622 | /root/review_l03; L04_review.md targets 242ee28d, feasible-with-risks | Agent-approved / instructor-pending; global audit pending | Choose one substantive source- or channel-coding lab |
| L05 | GLMs and optimization | /root/build_l05 blob736943b90f24826e29955115896929742f2961f5 | /root/review_l05; L05_review.md targets736943b9, feasible-with-risks | Agent-approved / instructor-pending; global audit pending | Source precision and combined GLM-gradient/AD/SGD load |
| L06 | Latent-variable EM | /root/build_l03 blob326267281c6b6775ac9a33d7ed4f022a859fc49b | /root/review_l05; L06_review.md targets32626728, feasible-with-risks | Agent-approved / instructor-pending; global audit pending | Gaussian expected-moment lab |
| L07 | Inference overview | /root/build_l04 blobf12fba8de7339675d09a771c5f956c8ed93649d8 | /root/review_l05; L07_review.md targetsf12fba8d, feasible-with-risks | Agent-approved / instructor-pending; global audit pending | One Laplace benchmark versus full Ch. 7 breadth |
| L08 | Message passing / filtering | /root/build_l05 blobb7a2de325c364bcde8230c33aaba2a5cd6b8596a | /root/review_l03; L08_review.md targetsb7a2de32, feasible-with-risks | Agent-approved / instructor-pending; global audit pending | HMM primary; Kalman compact |
| L09 | Variational inference | /root/build_l03 blobb6b98a1a0027e710c18aa596b79ac04ef7af248f (HMC deferment repair) | /root/review_l05 initiala8080351 passed; targeted repair check queued | Repair gate pending | Which stochastic expectation gradient, and amortization extent |
| L10 | MC / MCMC | /root/build_l04 blob9503b32aef49e7090792ea7e38d3acfb808a973b | /root/review_l10; L10_review.md feasible-with-risks | Individually feasible; Wave C gate pending | Multimodal MH lab; avoid routine PyMC repetition |
| L11 | Probabilistic neural networks | /root/build_l11 blob0c564a7e5b1fd308282ab2ea6488927a44bc890a | /root/review_l11 running | Pending | Heteroskedastic PyTorch training vs architecture breadth |
| L12 | VAEs | /root/build_l03 building | Queued | Pending | Mobility data vs MNIST and rate-distortion depth |

The table is a progress register, not a declaration that any provisional source references are already taught. At each review milestone fill in the exact committed SHA or blob SHA of the scope inspected, actual reviewer agent/thread, verdict and remaining risks. The coordinator owns this file and updates it serially.

## Global gates

| Gate | State | Evidence path |
|---|---|---|
| Reconcile latest actual course materials | Passed | Protected L01 actual deck/imputation notebook, L02 section contract; malformed/stale L02 state excluded |
| Map main book concepts to primary/omitted lectures | Provisional v1 | architecture_audit.md blob 882a9b2e76134d4952b218492a3564e117f6d6b4 |
| Ten complete five-part scopes | Pending | lecture-local lecture_scope.md files |
| Ten separate independent feasibility reviews | Pending | reviews/L03_review.md through L12_review.md |
| Targeted repairs and agent approvals | Pending | above register and reviews |
| Independent whole-course adversarial review | Pending | reviews/course_architecture_review.md |
| Single coherent syllabus plan/formal syllabus/ledger/notebook audit | Pending | root and Lectures files |
| Instructor questions and hesitations, organized | Seed only | questions_and_hesitations.md |
| Mechanical Typst/links/numbering/source consistency | Pending | architecture_audit.md |
| Final committed branch proposal | Pending | this register + scope files |

## Next action

Wave A closed: all three independent reviews passed with bounded risks, source/dependency/budget reconciliation complete in architecture_audit.md v2. Wave B closed: all three reviewed and reconciled in contractv3. Wave C: L09/L10 first independent previews complete; L09 allocation repair awaits targeted check; L11 complete/reviewing, L12 building; global adversarial gate remains pending. Keep at most three active threads including coordinator. Source access available; no launch blocker. No slides/notebook production or merge authorized.

## Delegation interruption reconciled

L09 reviewer /root/review_l05 and L10 builder /root/build_l04 hit an actual usage-limit error. After instructor reported upgrade, both distinct threads resumed successfully: L10 confirmed its complete saved scope and exact hash; L09 rechecked the target and continued actual review. No review or approval was inferred from an interrupted turn.
