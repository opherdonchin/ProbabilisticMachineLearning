**Evidence context:** The review conclusions below concern their exact pre-2026-10-16 scope targets. Old L10/L11 sources are linked to preserved Git versions. They are not previews of the new neural scopes; use `Lectures/deep_networks_revision/feasibility_review.md` for that separate review. Completed launch/skill-patch instructions are retired.

# Source-arc reviews: cross-lecture synthesis for instructor

**2026-10-12. Status: nine same-context, source-grounded reviews; independent Codex re-review not yet run.** Source is Murphy Book 2 December 10, 2025 online edition, directly inspected in the attached PDF and compared with the current branch's actual scopes. Each standalone review distinguishes what Murphy's selected chapters are trying to accomplish from what our course proposes. The nine lecture scope texts have not been changed by these reviews. The canonical lecture-scope skill was revised separately afterward and now includes source-arc checks and a decision hierarchy; use its current version for revisions.

**Additional course-wide review (2026-10-12):** [L01 framework and cumulative-computation spine](l01_framework_course_spine_review.md), grounded in the actual delivered L01 slides, adds a separate question to all nine source-arc reviews: does each lecture make a meaningful connection to L01's task/experience/performance and joint-distribution/query framework, and does the semester develop a coherent set of modeling and computational responses without misclassifying them all as posterior approximations? This is same-context analysis, not an independent agent sign-off. The stored VS Code instructions now commission a cold independent pass.

**Working principle:** Murphy's intellectual argument is the default organizing reference, not a mandate to follow his page sequence or teach every topic. A smaller selection may preserve the essential argument. A deviation can be better for this audience and the surrounding course, but it must be identified, justified and reviewed *as an argument*, not merely accepted for being feasible or accompanied by a good notebook.

| Lecture | Source-arc classification | Priority | Smallest recommended repair |
|---|---|---|---|
| [L04](../L04_Information_Theory/source_arc_review.md) | **Justified reorganization**; somewhat weak reciprocity bridge | Medium-low | Explicit KL/belief-update → MI → coding → representation-ML relationship, without changing agreed three-bit task |
| [L05](../L05_GLM_Optimization/source_arc_review.md) | **Justified synthesis** of B2 Chs. 15 + 6 | Medium | Preserve the GLM-family generality and note loss of scientific/Bayesian coefficient inference; keep gradient/AD/SGD |
| [L06](../L06_EM/source_arc_review.md) | **Faithful selection** of B2 §6.5 | Low | Make bound-optimization idea generalized from missing Gaussian to mixture, without new lab |
| [L07](../L07_Inference/source_arc_review.md) | **Partial fidelity / structural contraction** of B2 Ch. 7 | **High** | Make method/question taxonomy and global vs local hidden structure a substantive opening; keep deep Laplace notebook |
| [L08](../L08_Structured_Inference/source_arc_review.md) | **Faithful chain method, weak generality** across Chs. 8–9 | **High** | Motivate messages from graph separators; identify chain→tree/loopy exactness difference and Gaussian-belief alternative |
| [L09](../L09_Variational_Inference/source_arc_review.md) | **Faithful selective development** of Ch. 10 | Low-medium | Keep general optimize-over-q problem and gradient/coordinate update axes visible; no extra deep VI family |
| [L10](https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/0bdda8ee9e30afb4f0bd9690d0691eda9aea9a4f/Lectures/L10_MCMC/source_arc_review.md) | **Faithful selection** of Chs. 11–12 | Medium | Frame chain construction around MC integration, move from correct transition to proposal geometry/mixing; surface HMC depth tradeoff |
| [L11](https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/0bdda8ee9e30afb4f0bd9690d0691eda9aea9a4f/Lectures/L11_Neural_Prediction/source_arc_review.md) | **Substantial source-arc contraction** of Ch. 16 | **High** | Re-center differentiable compositions and two roles of neural nets (probability model / inference network), then heteroskedastic model as full example |
| [L12](../L12_VAE/source_arc_review.md) | **Justified synthesis** of Ch. 21 + Ch. 5 | Low-medium | Make generative model/intractable integral/prior generation explicit; rate-distortion stays a diagnosis, not whole endpoint |

**L04 scope update (2026-10-12):** The instructor now chooses the three-bit parity example for the live lecture and the five-bit, distance-three correcting code for the notebook. The original source-arc assessment concerned a three-bit notebook; its arc conclusion remains informative, but the computational handoff has changed and must receive a targeted feasibility review. See the dated addendum to [L04](../L04_Information_Theory/source_arc_review.md).

## The consistent failure mode

L03's original batch scope illustrated **unjustified displacement**: a useful image-restoration algorithm was allowed to redefine a lecture whose accepted mathematical purpose was graphical-model representation and conditional independence. The reviews identify **related but less severe** concerns in L07, L08 and L11: a complete and correct selected method increasingly stands in for the conceptual argument of its source chapter.

This is not simply about restoring missing section numbers. For example, L08 need not implement tree belief propagation to preserve the *graphical-structure → local messages* argument; L11 need not teach attention/transformer equations to preserve *differentiable functional composition → probabilistic-model and amortized-inference roles*. Repairing the **idea that connects selected ideas** may require less material than adding another method.

## Three cross-lecture transitions requiring explicit protection

1. **L06 → L07 → L08–L10:** L06 derives a bound for latent-variable learning; L07 should organize kinds of unknowns, inferential *queries* and computational options; L08 exploits sparse joint structure, L09 optimizes an approximate posterior and L10 samples. If L07 becomes solely a Laplace lecture, the course's method-selection argument becomes implicit.
2. **L03 → L08:** L03 teaches graphical factorization/CI; L08 must show that forward/backward recursion is an instance of local computation licensed by factorization, not merely a special trick for an HMM. A short tree/loop contrast locates the limits without adding another solver.
3. **L05 → L11 → L12:** L05 builds differentiable probabilistic predictors; L11 generalizes differentiable *function architectures* and distinguishes network roles as model parameterizer versus inference map; L12 uses both roles in encoder/decoder training. Without the L11 bridge, amortization appears abruptly.

## Decision ownership and boundaries

**Protected:** Instructor-agreed L03 scope restored from lecture-3-authoring, L04 chosen three-bit parity task, L04 information-theory objective, L05 combined GLM/optimization architecture, L06 EM and general course order. These source-arc reviews are **not** new approvals to erase them.

**Require a serious arc revision:** L07, L08, L11. This can usually preserve their existing notebooks and most mathematical spines, but the *lecture-wide question, transition logic and content depths* must be reviewed before Section Design. Do not simply add “Murphy's argument” as another introductory slide.

**Primarily clarifications / explicit tradeoffs:** L04, L05, L06, L09, L10, L12. Some have substantive open choices (HMC depth, generative vs reconstruction check), but the selected overall arc is not an unjustified displacement.

**Do not confuse review with production:** Notebook scaffolds are still unimplemented and teaching times unmeasured. A source-arc pass should not rubber-stamp feasibility, but it should also not fail a good mathematical arc because a particular GPU/Colab setup is untested.

**Scope-authoring skill:** A concise [integrated revision](../../.agents/skills/lecture-scope/SKILL.md) now strengthens source-first reading, comparison of intellectual transitions and source-arc review while retaining the established workflow. The [older detailed patch proposal](https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/0bdda8ee9e30afb4f0bd9690d0691eda9aea9a4f/Lectures/course_architecture_scope/source_arc_skill_recommendations.md) is historical, not an instruction to apply. The [VS Code revision prompt](https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/0bdda8ee9e30afb4f0bd9690d0691eda9aea9a4f/Lectures/course_architecture_scope/SOURCE_ARC_REVISIONS_IN_VSCODE.md) uses the revised skill when the instructor authorizes scope revisions.

## Review provenance

These nine files were created in one ChatGPT analysis context. They are **not** independent multi-agent reviews and do not take the place of the existing independent Section Design constructibility reviews. Each reconstructs Murphy from the actual source and compares the current scope; a later fresh isolated agent review should deliberately reconstruct Murphy *before* opening either the scope or these critiques. The present course scope/review approval registry remains otherwise unchanged.
