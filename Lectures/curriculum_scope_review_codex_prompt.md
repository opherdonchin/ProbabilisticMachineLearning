# VS Code Codex prompt: independent scope feasibility review of the revised curriculum

**Run from the repository root, on branch curriculum-l04-l06-information-review.** Use the prompt below in a *new* Codex conversation inside VS Code. This is a reviewer run, not a mandate to adopt the proposal.

---

$lecture-development

Act as Lecture Development Coordinator. Review the *proposed* 2027-1 curriculum on branch curriculum-l04-l06-information-review. In particular, test the new sequence:

- L04 information theory: MI, data processing and one computational coding application;
- L05 **learning probabilistic models: GLMs + optimization** (Murphy Book 2 §§15.1–15.1.3, §15.3.2, Ch. 6 §§6.1–6.3.2), including the common conditional exponential-family GLM family, an actual likelihood-gradient derivation, a representative Gaussian/Bernoulli/Poisson comparison, and Iris softmax/PyTorch;
- L06 latent-variable learning with EM;
- L07–L10 inference, structured message passing, VI, MCMC shifted one slot;
- L11 probabilistic neural networks, without absorbing a full GLM lecture;
- L12 VAE with beta-VAE/rate-distortion and optional IB/InfoVAE comparisons.

## First, establish the exact state

1. Confirm branch and Git HEAD, with a clean working tree. If the branch is missing, stop and ask; do not silently review main or overwrite local changes.
2. Read AGENTS.md, .codex/README.md, .agents/skills/lecture-development/SKILL.md, .agents/skills/lecture-scope/SKILL.md, .agents/skills/shared/backpressure.md and the timing-calibration reference. Read the feasibility-review contract rather than treating the skill as a one-pass scope generator.
3. Inspect syllabus_plan.typ, advanced_statistics_2027_1_syllabus.typ, Lectures/material_ledger.md, Lectures/syllabus_planning_decisions.md, Lectures/notebook_reference_audit.md and Lectures/curriculum_scope_previews.md, plus the prior comparison/audit documents. Verify the actual delivered L01 and current L02 (agreed but not necessarily delivered) from lecture artifacts. Check whether newer lecture content changes the baseline.
4. Inspect the exact cited Murphy Book 2 sections and Book 1 support. Find the actual book files locally or use the repository's documented access. Do not infer exact section contents from the syllabus alone. If source material cannot be accessed, record the limitation clearly.

## Dispatch independent specialists

Start *separate* lecture_scope custom subagent tasks in mode **feasibility-review**. Give each agent only its own target brief from Lectures/curriculum_scope_previews.md, the common syllabus/material ledger and source texts, and no other reviewer's results. Run batches respecting the configured maximum of three concurrent agent threads. In each task specify the branch HEAD SHA; reviewers must re-check it and remain read-only with respect to curricular artifacts.

Required direct-child reviews:

A. **L04 information theory** → Lectures/scope_reviews/l04_information_feasibility.md

B. **L05 GLMs + optimization** → Lectures/scope_reviews/l05_glm_optimization_feasibility.md

C. **L11 probabilistic neural networks** → Lectures/scope_reviews/l11_neural_prediction_feasibility.md

D. **L12 VAEs and rate-distortion** → Lectures/scope_reviews/l12_vae_information_feasibility.md

E. **Cross-lecture continuity / L06–L10 review** → Lectures/scope_reviews/continuity_l04_l12_feasibility.md. This reviewer should evaluate prerequisite ordering, EM, HMM/Kalman, VI gradients, MCMC, library introduction, actual later GLM loss, and whether the shifted topics remain feasible. Do NOT turn this into new scopes for L06–L10.

If all five direct-child reviews are not possible with the existing Codex configuration, run independent batches. Never falsely claim that changing a role name created an isolated reviewer; verify that actual child agents launched. Do not give each agent other raw reports.

## Reviewer task contract

For each reviewer: stage=Lecture Scope, mode=feasibility-review, target=specified proposed brief on this HEAD, review depth=graduate mathematical/technical, deadline=none, output=one Markdown report. **Do not** produce final five-part scope documents, sections, slides, notebooks, or edits to the syllabus/ledger. Reviewing an initial provisional brief is explicitly within this mode; no change to the skill is necessary.

Use the exact verdicts: feasible / feasible-with-risks / blocked. Each issue should identify owner/severity, relevant book section / prior course artifact, evidence, *minimum* proposed repair, consequences for subsequent lectures and the smallest instructor-owned decision. Distinguish actually taught mathematics from merely cited source sections. Include qualitative live-time and one-hour notebook load; avoid invented precise slide counts or timing predictions.

Specific adversarial tests:
- L04: Can MI/DPI and an operational coding *notebook* fit while retaining mathematically serious information theory? Is the source/channel boundary principled? How should coding and rate-distortion lead toward VAE without requiring full §5.6?
- L05: Can students understand scalar canonical-link GLMs, Gaussian/Bernoulli/Poisson examples, the correct sign/dispersion assumptions of Murphy Eq. 15.35, multinomial softmax, reverse-mode AD and mini-batch SGD in two live hours? What is the smallest coherent reduction if not? Does the lecture feel like one argument instead of two surveys? Is PyTorch Iris a realistic first hour?
- L11: Is it really enough to inherit L05 AD and GLM models? Is heteroskedastic NLL correctly distinguished from epistemic uncertainty? Is the remaining weight decay / scoring burden too high? What GLM value is irretrievably lost?
- L12: Are the VI/reparameterization prerequisites genuinely available from L09? Are the beta-VAE/rate-distortion connections technically accurate and scoped? Is the preferred notebook one hour?
- Whole course: L05→L06 EM transition, logistic posterior in L07, overloaded HMM/Kalman in L08, gradient estimators in L09, MCMC L10, and untouched L11/L12 scheduling. Consider cumulative cognitive and software workload, not only adjacent topics.

## Preserve independence, then synthesize

Only after all five reviewers have finished, compare their raw written reports and prepare **Lectures/scope_reviews/assessment_summary.md** as a coordinator synthesis. Do not rewrite raw reports to force agreement. Classify severity and whether the issue belongs to scope, section design, notebook, or the instructor. State whether the preliminary plan is defensible and what exact adjustments would make it so.

Run *read-only* consistency checks on the two Typst syllabi, ledger and notebook plan; if Typst is available, compile both to temporary ignored/untracked outputs without altering sources. Verify no lecture was dropped or counted twice and that syllabus dates/identities align. Treat compilation as a mechanical check, not pedagogical validation. If a reviewer discovers a mathematical error, report it explicitly; do not silently change the syllabus.

Do not merge, open a PR, modify syllabus or ledger, advance to Section Design build, or mark any scope instructor-approved. Make review reports the **only committed new files**, leaving source plans unchanged. Commit reports on the existing review branch if the tree permits; otherwise report their paths and actual working state.

Finish by presenting the instructor with: (1) a compact table of verdicts for L04, L05, L11, L12 and continuity, (2) the most consequential blocker or advisory issue per lecture with a minimal repair, (3) a truthful provenance statement identifying which separate child agents actually ran, and (4) **one instructor decision at a time**. Stop for instructor guidance before changing the curriculum.

If custom subagent launch fails because of model entitlement or a configuration issue, state the exact failure and stop; do not quietly substitute a single same-context review and call it independent.

---

**Execution note:** This workflow requests read-only curricular review, not a new edition of the lecture-scope skill. If a full five-part scope is necessary later, use the normal iterative build mode *after* the instructor decides which provisional changes to accept.
