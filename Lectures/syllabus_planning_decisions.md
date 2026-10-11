# Current syllabus planning decisions — Advanced Statistics 2027-1

**Instructor acceptance:** 13-meeting Book-2-first architecture, 2026-10-11, main merge PR #8 / b78a7650bb09ae851e412089d98525f7b71275d9. **Detailed scopes:** agent-approved / instructor-pending under the explicit autonomous WORK_ORDER; this is not instructor acceptance or a student-facing syllabus release.

The architecture preserves L01 delivered Gaussian/LGS coverage, L02 agreed exponential families/Markov learning, L04 information theory, L05 substantive unified GLMs/AD/SGD, L06 EM, L07–L10 inference, L11 neural conditional prediction, L12 VAE and L13 projects. No protected prior lecture was rewritten. Every resulting section ends retrospectively; notebook handoffs stay separate.

## Agent provisional resolutions

| Owner | Resolution / consequence |
|---|---|
| L03 | Positive Ising/local computation and deterministic ICM restoration; no early formal Gibbs/VI or exact-MAP claim. |
| L04 | One verified course five-bit error-correcting channel; MI/DPI substantive, source-code bounds stated, rate–distortion owned L12. |
| L05 | One common canonical GLM gradient, separate vector softmax application, complete reverse graph and first PyTorch Iris fit; family comparison protected. |
| L06 | Missing-Gaussian EM and uncertainty-preserving second moments; generic bound/monotonicity primary owner. MRI/full GMM fit displaced. |
| L07 | One fixed scalar logistic grid/Laplace comparison with domain/spacing checks; no later algorithm implementation. |
| L08 | HMM scaled forward/backward primary; compact Kalman application, no forecasting lab or second full sequence method. |
| L09 | One diagonal Gaussian pathwise fit with exact known-noise reference; controlled data instead of Pyro/unknown-noise GDP/HMC. CAVI bounded, amortization recognized. |
| L10 | MH correctness and proposal/start/query mixing; Gibbs bounded and HMC mechanics recognized, full HMC theory omitted. |
| L11 | Nonlinear mean/SD likelihood, conditional noise versus weight uncertainty and scaled Gaussian-prior/L2 connection; no architecture/BNN/calibration survey. |
| L12 | Compact mobility VAE, correctly normalized objective and rate=MI+aggregate KL; descriptive patterns, not guaranteed causal/disentangled factors. |

## Authority, evidence and oversight

[Scope/review registry](course_architecture_scope/STATUS.md) records actual builder/reviewer threads and exact Git blobs. [Whole-course audit](course_architecture_scope/architecture_audit.md) owns the source matrix, prerequisites, novelty/duplication and notebooks. [Raw adversarial report](course_architecture_scope/reviews/course_architecture_review.md) is independently authored. [Questions and hesitations](course_architecture_scope/questions_and_hesitations.md) records provisional choices, alternatives and costs for instructor oversight. Historical alternative drafts live in Git history, not the current tree.

[syllabus_plan.typ](../syllabus_plan.typ), [formal syllabus](../advanced_statistics_2027_1_syllabus.typ), [material ledger](material_ledger.md) and [notebook audit](notebook_reference_audit.md) describe the same reviewed proposal. Source ranges mean selected treatment, not every subsection. Delivered ledger entries remain unchanged; future allocation stays undelivered in actual accounting. No optional item becomes a formal required outcome by citation alone.

Every future lecture/lab budget is estimated, not rehearsed or piloted. No required recording, slide/figure/student notebook production or runtime-compatible claim was introduced. PyTorch is the sole new required ecosystem, starting L05; source Pyro/JAX/TFP are not adopted. Actual L02 delivery, prepared helpers/checkpoints, mobility portable access and clean local uv/hosted Colab checks remain downstream gates. Human acceptance is required before advancing this proposal to production or main; no merge or ready-to-merge PR is authorized here.
