# L03–L12 autonomous scoping — execution status

**Branch:** scope-l03-l12-course-architecture
**Base:** main, after instructor-selected curriculum merged in PR #8 (b78a7650bb09ae851e412089d98525f7b71275d9)
**Operating contract:** [WORK_ORDER.md](WORK_ORDER.md)
**Status:** PREPARED ONLY. No independent scope agents have been launched here, no complete new lecture scopes exist, and no review / agent approvals have been recorded. This is not a final course-architecture proposal.

## Core authority

Instructor delegated this review-batch autonomy on 2026-10-11: coordinator may generate, revise, review and internally approve feasible L03–L12 scopes without interim human intervention, subject to a later human review. Agent-approved is never recorded as instructor-approved. The delivered L01 material and agreed L02 contracts are protected.

## Per-lecture register

| Lecture | Focus | Scope author / revision | Independent review / revision | Gate | Principal unresolved handoff |
|---|---|---|---|---|---|
| L03 | Graphical models | Not started | Not run | Pending | Ising image denoising versus unavailable later MCMC machinery |
| L04 | Information theory | Not started | Not run | Pending | Choose one substantive source- or channel-coding lab |
| L05 | GLMs and optimization | Not started | Not run | Pending | Source precision and combined GLM-gradient/AD/SGD load |
| L06 | Latent-variable EM | Not started | Not run | Pending | Incomplete Gaussian or MRI-GMM lab |
| L07 | Inference overview | Not started | Not run | Pending | One Laplace benchmark versus full Ch. 7 breadth |
| L08 | Message passing / filtering | Not started | Not run | Pending | HMM vs Kalman worked core |
| L09 | Variational inference | Not started | Not run | Pending | Which stochastic expectation gradient, and amortization extent |
| L10 | MC / MCMC | Not started | Not run | Pending | Multimodal MH lab; avoid routine PyMC repetition |
| L11 | Probabilistic neural networks | Not started | Not run | Pending | Heteroskedastic PyTorch training vs architecture breadth |
| L12 | VAEs | Not started | Not run | Pending | Mobility data vs MNIST and rate-distortion depth |

The table is a progress register, not a declaration that any provisional source references are already taught. At each review milestone fill in the exact committed SHA or blob SHA of the scope inspected, actual reviewer agent/thread, verdict and remaining risks. The coordinator owns this file and updates it serially.

## Global gates

| Gate | State | Evidence path |
|---|---|---|
| Reconcile latest actual course materials | Pending | WORK_ORDER.md phase 0 |
| Map main book concepts to primary/omitted lectures | Pending | architecture_audit.md |
| Ten complete five-part scopes | Pending | lecture-local lecture_scope.md files |
| Ten separate independent feasibility reviews | Pending | reviews/L03_review.md through L12_review.md |
| Targeted repairs and agent approvals | Pending | above register and reviews |
| Independent whole-course adversarial review | Pending | reviews/course_architecture_review.md |
| Single coherent syllabus plan/formal syllabus/ledger/notebook audit | Pending | root and Lectures files |
| Instructor questions and hesitations, organized | Seed only | questions_and_hesitations.md |
| Mechanical Typst/links/numbering/source consistency | Pending | architecture_audit.md |
| Final committed branch proposal | Pending | this register + scope files |

## Resume instruction

Open the branch in a fresh VS Code Codex session and start from [RUN_IN_VSCODE.md](RUN_IN_VSCODE.md). No artifact except the initial work-order/status/questions templates should be treated as evidence of actual agent work. Do not begin slide authoring, notebook production, a course merge or a student-facing syllabus release in this phase.
