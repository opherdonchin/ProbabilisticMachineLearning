# Current course proposal and review status

## Current focus: recover the existing L03 agreement

The instructor identified `lecture-3-authoring` as the location of the already agreed L03 scope. That scope has been restored on this proposal branch. The batch run had missed the agreement and replaced its graphical-model argument with a lecture organized around image restoration. No fresh choice of L03 route is needed.

The live lecture runs from L02’s Markov chain through DAG factorization and directed independence, then undirected models and Ising interpretation. The image prior, Gaussian likelihood, posterior, local conditional and simpler restoration algorithm remain new student notebook work. The [L03 register](../L03_Graphical_Models/development_state.md) identifies exact authority and stage status; read the [scope](../L03_Graphical_Models/lecture_scope.md) with its [questions](questions_and_hesitations.md). The instructor chooses where to stop for discussion; there is no automatic question-by-question sequence.

## What is agreed and what remains proposed

- The 13-meeting course order, Book 2 as the main source, and the existing L03 scope are instructor-agreed. Its future-opportunity lecture labels were maintained without changing teaching commitments.
- L04’s lecture retains the two-bit message with one parity bit (detection, no guaranteed correction). The instructor **subsequently selected a five-bit correcting code for the notebook**, preserving a genuine new computation: verify distance three, one-error decoding, and MAP error/MI/rate for a 4×32 model. **The revised student task has not undergone a new independent feasibility review or runtime pilot.**
- Other detailed scope choices remain proposals. The remaining nine scope texts are unchanged in this repair.
- The complete seven-section L03 design remains proposed on its authoring branch. Its unresolved exact-example checks are not scope blockers or approved teaching commitments.

The syllabi, future material ledger, notebook audit, architecture explanation and teaching-choice report now reflect the restored L03 boundary. L01/L02 source material and delivered coverage remain protected. New workflow checks require recovery of prior agreements across relevant branches before building, comparison of prior-course/source/proposed arguments, and review of whether a route is justified as well as teachable. A newer workflow template does not authorize rewriting an accepted scope.

## Review evidence and its limits

Actual independent agents `/root/l03_arc_diagnosis` and `/root/scope_method_diagnosis` inspected the accepted scope and branch register. The dated correction in [L03 review evidence](reviews/L03_review.md) distinguishes the missed agreement from the general argument/review weakness. Its earlier diagnosis used incomplete authoritative inputs and is qualified explicitly, not silently reused. The targeted exact-file reconciliation review passed with advisory risks and no reconciliation blocker; current report blob `c7a74f74335d44f2e47821909150a9e051f9a3c5`.

Earlier individual and whole-course reports remain raw evidence about their stated versions. In particular, passing reviews of batch L03 do not apply to the restored scope. The earlier mathematical-clarity review remains relevant to the nine unchanged scopes; changed L03 explanations require the new targeted check. Feasibility is not instructor approval, implementation validation or measured teaching time.

Lecture timing and the demanding L03 notebook hour remain estimates. Future notebooks are unwritten/unrun; no clean local or hosted Colab checks, student trials or rehearsal occurred. No slide production or student release is implied.

## Exact authority and current scope registry

**Proposal branch:** `scope-l03-l12-course-architecture`. **Reconciliation baseline:** `2499e988706005b12c62f0d2bfb037f47b7c0c9e`. **Accepted L03 source:** fetched `origin/lecture-3-authoring` at `8007d42b2871181a6966ab4d55417c10af9b5544`, scope blob `0656648fd43374997469174a845418a802b3aefe`. **Architecture/main baseline:** `b78a7650bb09ae851e412089d98525f7b71275d9`.

The instructor authorized pushing this proposal branch to origin. No merge is authorized or performed. Resolve the final delivery commit with `git log -1 --format=%H -- Lectures/course_architecture_scope/STATUS.md`; a commit cannot contain its own hash. File hashes below identify exact content. Original L03 review rows are historical targets, while its appended reconciliation review targets the restored text.

| Scope | Current scope file hash | Current source / author | Earlier substantive file hash | Original independent review |
|---|---|---|---|---|
| [L03](../L03_Graphical_Models/lecture_scope.md) | `2d5992a3f05d952dc21553690039fe021fd6284a` | Instructor-agreed `lecture-3-authoring`; coordinator restored | `f4ab82808c1cc6b4b32c38588c6c2e969483b036` | [Raw report and reading guide](reviews/L03_review.md) |
| [L04](../L04_Information_Theory/lecture_scope.md) | `c0c61c22e0152ce2fab18ac41132d2e17eeaa647` | `/root/readable_early` | `6b008770631926f61e51d838a126651c2200466e` | [Raw report and reading guide](reviews/L04_review.md) |
| [L05](../L05_GLM_Optimization/lecture_scope.md) | `84629e7171a371676ac6dbf1e3fabd34de907b95` | `/root/readable_early` | `6f7200e2383a2136687fe03cbb8b35b67f76d696` | [Raw report and reading guide](reviews/L05_review.md) |
| [L06](../L06_EM/lecture_scope.md) | `b492462f2f2e9602b6ef917d0f47a52f23f1bdab` | `/root/readable_early` | `c29aefd80dbd192a6a4da4b79e5e299df343875a` | [Raw report and reading guide](reviews/L06_review.md) |
| [L07](../L07_Inference/lecture_scope.md) | `99de6f1ea4292d5006bbe70184a480fe231a1e5a` | `/root/readable_early` | `80eacfd8c3e7e3bb4eb00d9bb23ccdb1c2ddcb0a` | [Raw report and reading guide](reviews/L07_review.md) |
| [L08](../L08_Structured_Inference/lecture_scope.md) | `1c92cf00a125c33b1142cbd0696a1221a766ea36` | `/root/readable_late` | `4ae9853bf48899edeab65a1c2b503dfad0c1f990` | [Raw report and reading guide](reviews/L08_review.md) |
| [L09](../L09_Variational_Inference/lecture_scope.md) | `dd7665143dbbcd5af443e6ca54c1a6a4baa9f3fa` | `/root/readable_late` | `7072832dfbf350454d66a0440abea8201bf530e0` | [Raw report and reading guide](reviews/L09_review.md) |
| [L10](../L10_MCMC/lecture_scope.md) | `884a24c67187557546c74d0e3935f08fc67edd93` | `/root/readable_late` | `55359f7aeeeb5eb838915386ca5222981f8236c5` | [Raw report and reading guide](reviews/L10_review.md) |
| [L11](../L11_Neural_Prediction/lecture_scope.md) | `f76ea83091b02831b7c5959e02ebe8f8ab55fc25` | `/root/readable_late` | `c9c3298efa4e11a0baedaa6bd06d72aba64ee86d` | [Raw report and reading guide](reviews/L11_review.md) |
| [L12](../L12_VAE/lecture_scope.md) | `67fdd3cd474b3bbf1e5ca7e931c169ebef737eeb` | `/root/readable_late` | `ae38514fa2daf5502c411a3c5528cfa6a2becbdc` | [Raw report and reading guide](reviews/L12_review.md) |

Original independent reviewers: `/root/review_l03` (L03/L04/L08), `/root/review_l05` (L05/L06/L07/L09), `/root/review_l10` (L10), `/root/review_l11` (L11/L12 and targeted repairs). `/root/course_adversary` reviewed the course proposal. Current mathematical-clarity evidence is retained in [readability revision review](reviews/readability_revision_review.md); its unchanged-scope findings do not certify this L03 restoration.


**L04 subsequent amendment (2026-10-12):** The earlier L04 review and readability evidence refer to the old three-bit *notebook* or its prior five-bit variant. Neither independently reviews the present split of three-bit **lecture** and five-bit **student notebook**. The full live intellectual arc is unchanged, but the stronger notebook is a consequential pending feasibility and workload check. This update is not a new agent approval; later reviewers should target current L04 scope blob `c0c61c22e0152ce2fab18ac41132d2e17eeaa647`.

## Next action

Continue the instructor-led L03 discussion from the restored scope. Section Design’s exact examples and timing, and notebook feasibility, remain work for their owning stages. No automatic revision of L04–L12 or promotion to slides begins from this repair. [Validation](validation.md) records mechanical checks and their limits.
