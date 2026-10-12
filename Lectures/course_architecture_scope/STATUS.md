# Current course proposal and review status

The current writing standard is clear mathematical exposition for an instructor who is comfortable with probability, calculus, linear algebra and Bayesian reasoning but may be unfamiliar with later methods. The teaching-choice report now states the decision-relevant equations, assumptions and treatment depths, explains alternatives and gives focused, verified book readings.

The ten lecture scopes and their reviewed mathematical commitments are unchanged in this communication revision. L03's simpler restoration and L04's three-bit parity example remain selected; later choices remain proposals.

## What the instructor has agreed

- The existing 13-meeting course order, with Book 2 as the main source.
- L03: use the simpler one-pixel-at-a-time image improvement, even though it differs from Murphy's algorithm.
- L04: use the lighter three-bit parity example and refer to stronger correction separately. The code detects a single-bit change but cannot always locate/correct it.
- Pause the remaining questions while the proposal is made understandable. This is not acceptance of every detail in L03/L04 or of later lectures.

## What is ready and what is still being checked

The questions and course overview now expose the mathematical distinctions behind their teaching choices, rather than describing only practical activities. The five course records retain precise method names and the existing mathematical/notebook endpoints. AGENTS.md and all nine skills now require clarity with mathematical substance; important equations need not be relegated to appendices. Selective reading directions specify what background to study, without assuming familiarity with entire chapters.

The existing review of the ten scope texts remains valid because those files are byte-unchanged. The independent precision/source review by `/root/precision_review` passed: feasible with risks, with no material mathematical or source blocker. Its dated addendum in the [revision review record](reviews/readability_revision_review.md) checks formulas, assumptions, verified focused readings, teaching-depth equivalence and clarity. Current report hash: `5cea2abe56c021133da534d3230930245e1824a5`. It identifies the question file `7c8b69e00b9d12185faba73b2df8a7aeda6bb0ac`, overview `f3e3d72677929370e9a19b1c2798f1492f3eeb06`, all other inspected inputs and unchanged scope hashes. No new instructor approval is implied.

[Start with the teaching choices](questions_and_hesitations.md). [How the course fits together](architecture_audit.md) explains the progression and practical losses. [Notebook responsibilities](../notebook_reference_audit.md) separates student tasks from author-supplied programs and correctness checks. Exact review evidence is listed below so it need not interrupt those explanations.

## Limits that still matter

Time plans have not been rehearsed or tried with students. Future notebooks have not been executed locally or in Google Colab. Supplied data handling, helpers and prepared fits remain work for authors, not completed course assets. L01/L02's established files and the delivered ledger remain unchanged. No slides, student notebooks or recordings are produced in this revision. L13 remains projects. The branch is not merged or released to students.

## Exact file and agent record

**Branch:** `scope-l03-l12-course-architecture`. **Instructor architecture/main:** `b78a7650bb09ae851e412089d98525f7b71275d9`. **Current communication revision starts from:** `4b886903925c25dc52434c962789c367db3d6ec6`.
**Reviewed scope content commit:** `8e83e48a5d4553be90ca3fd074bc8906bf209429` contains the current ten scope texts and their targeted review. **Current communication content commit:** `09e1dfd47cd54fcc77c80b825127f3ffe2fb7d02` contains the clear mathematical discussion, focused readings, synchronized descriptions, writing instructions and independent precision/source evidence. The registry-only closure revision can be resolved with `git log -1 --format=%H -- Lectures/course_architecture_scope/STATUS.md`, since a commit cannot contain its own SHA.
**Remote delivery authority:** the instructor explicitly authorized pushing this proposal branch to `origin` (`https://github.com/opherdonchin/ProbabilisticMachineLearning.git`). No merge or student release was authorized.

The long identifiers below are Git file hashes: each identifies the exact text, so a review cannot silently be applied to a changed file. The original report remains verbatim inside each review file after a coordinator-written reading guide. A guide is not a review by another agent. [Completed revision check](reviews/readability_revision_review.md) was written by the actual independent reviewer. Its earlier review Git file hash was `92b36de1c873bb61cf78f2642e9bd62cd308420f`; the L04 report with the independent targeted addition is `d0716eb0c02cd99505b422783878e1ae63e1d35c`. All prior reports are preserved verbatim as contiguous records behind their reading guides. The new report lists every exact final scope hash and inspected input, independently confirmed before/after; the current communication revision leaves all ten checked scope texts unchanged. The forthcoming dated addendum identifies revised explanatory inputs separately.

| Scope | Current readable file hash | Readability author | Earlier substantive file hash | Original independent review |
|---|---|---|---|---|
| [L03](../L03_Graphical_Models/lecture_scope.md) | `cccc6f319d5d1046b14efb4078ba55a37e414268` | `/root/readable_early` | `f4ab82808c1cc6b4b32c38588c6c2e969483b036` | [Raw report and reading guide](reviews/L03_review.md) |
| [L04](../L04_Information_Theory/lecture_scope.md) | `2299ca6e5a0ab901da3fbb8e85cfb5546910f1c4` | `/root/readable_early` | `6b008770631926f61e51d838a126651c2200466e` | [Raw report and reading guide](reviews/L04_review.md) |
| [L05](../L05_GLM_Optimization/lecture_scope.md) | `84629e7171a371676ac6dbf1e3fabd34de907b95` | `/root/readable_early` | `6f7200e2383a2136687fe03cbb8b35b67f76d696` | [Raw report and reading guide](reviews/L05_review.md) |
| [L06](../L06_EM/lecture_scope.md) | `b492462f2f2e9602b6ef917d0f47a52f23f1bdab` | `/root/readable_early` | `c29aefd80dbd192a6a4da4b79e5e299df343875a` | [Raw report and reading guide](reviews/L06_review.md) |
| [L07](../L07_Inference/lecture_scope.md) | `99de6f1ea4292d5006bbe70184a480fe231a1e5a` | `/root/readable_early` | `80eacfd8c3e7e3bb4eb00d9bb23ccdb1c2ddcb0a` | [Raw report and reading guide](reviews/L07_review.md) |
| [L08](../L08_Structured_Inference/lecture_scope.md) | `1c92cf00a125c33b1142cbd0696a1221a766ea36` | `/root/readable_late` | `4ae9853bf48899edeab65a1c2b503dfad0c1f990` | [Raw report and reading guide](reviews/L08_review.md) |
| [L09](../L09_Variational_Inference/lecture_scope.md) | `dd7665143dbbcd5af443e6ca54c1a6a4baa9f3fa` | `/root/readable_late` | `7072832dfbf350454d66a0440abea8201bf530e0` | [Raw report and reading guide](reviews/L09_review.md) |
| [L10](../L10_MCMC/lecture_scope.md) | `884a24c67187557546c74d0e3935f08fc67edd93` | `/root/readable_late` | `55359f7aeeeb5eb838915386ca5222981f8236c5` | [Raw report and reading guide](reviews/L10_review.md) |
| [L11](../L11_Neural_Prediction/lecture_scope.md) | `f76ea83091b02831b7c5959e02ebe8f8ab55fc25` | `/root/readable_late` | `c9c3298efa4e11a0baedaa6bd06d72aba64ee86d` | [Raw report and reading guide](reviews/L11_review.md) |
| [L12](../L12_VAE/lecture_scope.md) | `67fdd3cd474b3bbf1e5ca7e931c169ebef737eeb` | `/root/readable_late` | `ae38514fa2daf5502c411a3c5528cfa6a2becbdc` | [Raw report and reading guide](reviews/L12_review.md) |

Original builders: `/root/build_l03` built L03/L06/L09/L12; `/root/build_l04` built L04/L07/L10; `/root/build_l05` built L05/L08; `/root/build_l11` built L11. Original independent Section Design reviewers were `/root/review_l03` for L03/L04/L08; `/root/review_l05` for L05/L06/L07/L09; `/root/review_l10` for L10; `/root/review_l11` for L11/L12 and targeted L09/L12 repairs. The separate course reviewer was `/root/course_adversary`, who first read the proposal before coordinator justifications. Exact targets/checkpoints and limits are preserved in the reports.

Earlier smallest repairs corrected an overpromise of full Hamiltonian theory and clarified expected reconstruction scoring. The independent check confirmed that the readability revision preserves them. L04's earlier guarantee applies only to the old five-bit code. The new targeted check verifies the actual lighter task without reusing that guarantee.

## Completion checks

| Check | Current state |
|---|---|
| Ten five-part readable scopes | Completed and independently checked |
| Instructor decisions L03/L04 reflected consistently | Passed; choices reflected without blanket instructor acceptance |
| Readability and unchanged mathematics in other scopes | Passed; independent reviewer found no demonstrated blocker |
| Current three-bit L04 example and finite calculations | Passed; direct source and exact finite-table calculations |
| Current mathematical discussion, readings and formal descriptions | Passed: independent precision/source check; no scope commitment changed |
| All nine skills and coordinator writing rule | Updated; repository setup checker passed |
| Syllabi, dates, links and protected content | Passed: [current validation](validation.md), no broken local links |
| Current communication commit / branch update | Completed content commit `09e1dfd47cd54fcc77c80b825127f3ffe2fb7d02`; registry-only closure records the final branch state |
| Further instructor teaching decisions | Paused at instructor request; no inferred answers |

**Next step:** instructor oversight of the clear mathematical discussion; all communication, source and mechanical checks are complete. No reviewed scope or teaching commitment changes. Further instructor review can resume with L05 when the instructor chooses. No later production stage begins merely because this rewrite passes review.

### Current execution evidence

The `/root/readable_early` scope specialist revised the teaching-choice report and verified its focused readings. The configured `/root/readable_late` writer returned `Selected model is at capacity` without edits. Following `.codex/README.md`, `/root/balanced_course_overview` used the accessible equivalent `gpt-6-sol` at high effort to revise only the overview. A separate `/root/precision_review` with the same accessible model checks the current communication independently in Section Design feasibility-review mode. No profile or model configuration file was changed, and no independence is inferred from a failed launch.
