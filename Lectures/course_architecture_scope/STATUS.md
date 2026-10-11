# L03–L12 autonomous scoping — execution status

**Branch:** `scope-l03-l12-course-architecture`
**Instructor architecture/base:** `b78a7650bb09ae851e412089d98525f7b71275d9` (main/PR #8). **Starting HEAD:** `906ce71dd9c8e29f3dede51ec809442a885354c9`.
**Stage:** ten full scopes independently reviewed; Waves A/B/C reconciled; separate adversarial global gate pending. Scope/header finalization and formal-output synchronization are not yet complete.
**Authority:** instructor WORK_ORDER delegation dated2026-10-11; agent-approved never means instructor-approved. This course-local register is the batch development-state index; scopes own curriculum commitments.

## Per-lecture gate and exact artifact identities

Every row is **agent-approved / instructor-pending, subject to the open global gate**. Each reviewer is an actual separately launched section_design thread, distinct from its lecture_scope builder. All initial verdicts feasible-with-risks. Timing/implementation risks remain bounded and unvalidated.
| Lecture / scope | Exact current scope Git blob | Builder thread | Independent reviewer thread / raw evidence | Exact current review Git blob |
|---|---|---|---|---|
| [L03](../L03_Graphical_Models/lecture_scope.md) | `f4dab507f90618362c2e04c1c3791c8139f7de56` | `/root/build_l03` | `/root/review_l03`; [raw review](reviews/L03_review.md) | `d1935f9d91363357c932deabc46788225f587a5a` |
| [L04](../L04_Information_Theory/lecture_scope.md) | `242ee28d251d583004daa25379b6a0f8cb44d622` | `/root/build_l04` | `/root/review_l03`; [raw review](reviews/L04_review.md) | `45e733979a2e29e50182f2ee8205cf4b158d4194` |
| [L05](../L05_GLM_Optimization/lecture_scope.md) | `736943b90f24826e29955115896929742f2961f5` | `/root/build_l05` | `/root/review_l05`; [raw review](reviews/L05_review.md) | `de0ba605f50bc1997eba1cf98738e7e36ac4be40` |
| [L06](../L06_EM/lecture_scope.md) | `326267281c6b6775ac9a33d7ed4f022a859fc49b` | `/root/build_l03` | `/root/review_l05`; [raw review](reviews/L06_review.md) | `206d3a72ea2d7f3f8406b429f1a485d157019b61` |
| [L07](../L07_Inference/lecture_scope.md) | `f12fba8de7339675d09a771c5f956c8ed93649d8` | `/root/build_l04` | `/root/review_l05`; [raw review](reviews/L07_review.md) | `71cb04ec9c9b9c65acb3254620f4792b4e03498b` |
| [L08](../L08_Structured_Inference/lecture_scope.md) | `b7a2de325c364bcde8230c33aaba2a5cd6b8596a` | `/root/build_l05` | `/root/review_l03`; [raw review](reviews/L08_review.md) | `ccdb82afd3899c3bdeb974cdaaf6c3a119169aab` |
| [L09](../L09_Variational_Inference/lecture_scope.md) | `b6b98a1a0027e710c18aa596b79ac04ef7af248f` | `/root/build_l03` | `/root/review_l05 + targeted review_l11`; [raw review](reviews/L09_review.md) | `240e3f31d1d156804c06c835ba7129c13183d472` |
| [L10](../L10_MCMC/lecture_scope.md) | `9503b32aef49e7090792ea7e38d3acfb808a973b` | `/root/build_l04` | `/root/review_l10`; [raw review](reviews/L10_review.md) | `681b5d1d2c85cecd41b21e06bb2a53949684a276` |
| [L11](../L11_Neural_Prediction/lecture_scope.md) | `0c564a7e5b1fd308282ab2ea6488927a44bc890a` | `/root/build_l11` | `/root/review_l11`; [raw review](reviews/L11_review.md) | `455baa985337507aa54b69be9f047766a92b1968` |
| [L12](../L12_VAE/lecture_scope.md) | `fe07f77461bbded7e6a17be6050b204133994072` | `/root/build_l03` | `/root/review_l11`; [raw review](reviews/L12_review.md) | `3bf9b82a83c6ae8ca7f25ec6ddaeb45a06b6b354` |

L09 initial review targeted a8080351116f51a34eddd3e5dc06d65f7025722e; authorized one-row HMC ownership repair is b6b98a1a0027e710c18aa596b79ac04ef7af248f, independently targeted-rechecked by /root/review_l11. All original raw review bytes were preserved. L11 input cited the original L09 version; reviewer confirmed unchanged relevant handoff in the repaired file.

## Source contract revisions and checkpoints

Contractv1 blob882a9b2e76134d4952b218492a3564e117f6d6b4 (374bc6d source checkpoint); Wave A contractv2 blob12ae5e1608eb2d74c6c70ba857eb5a75ff2114c1 (791e71b); Wave B contractv3 blob54064183398bd643a895c5e38a023f793dc2d9d6 (9b62b6c). Current architecture audit replaces the build contract after all scope authors stopped editing. Historical content is recoverable from Git, not duplicate draft files.

## Global gates

| Gate | State / evidence |
|---|---|
| Repository/main/protected boundary | Passed; clean start and origin pull, actual L01/L02 inspected/protected |
| Ten full five-part scopes | Passed; links/hashes above |
| Ten independent previews | Passed, feasible-with-risks; raw evidence above |
| Wave reconciliation / smallest repair | Passed; HMC repair independently rechecked |
| Separate adversarial course review | Pending; reviews/course_architecture_review.md |
| Formal syllabus/plan/ledger/notebook audit/decisions | Pending after adversarial gate |
| Consolidated human questions | Partial current report; final synthesis pending |
| Typst/links/dates/protected-content validation | Pending final outputs |
| Final coherent proposal commit | Pending |

## Accepted decisions, limits and next owner

The instructor accepted the13-meeting architecture and delegated reversible provisional scope choices, not these detailed scopes. Protected L01 delivered ledger/source and L02 agreed contracts are unchanged. No required recording, slide or notebook implementation is introduced. Reviewer preview/arithmetic is not teaching rehearsal, student-lab timing, clean uv execution or hosted Colab validation.
Actual usage-limit failures interrupted L09 review/L10 build. Both distinct threads resumed after the instructor reported upgrade, checked existing files and completed actual work. No gate was inferred from an interrupted turn. No more than three threads including coordinator ran concurrently.
**Next owner:** a fresh independent adversarial reviewer reads all ten scopes and factual allocation/dependencies before coordinator justifications. Resolve real blockers at owning scopes, then synchronize formal artifacts, finalize metadata/revision bindings and commit. No merge, ready-to-merge PR or student publication authorized.
