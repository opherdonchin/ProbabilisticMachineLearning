# L05 scope and notebook feasibility investigation

**Status:** `feasible-with-risks`, investigation only, 2026-10-14. Independent delegated Lecture Scope `feasibility-review` by `/root/investigate_l05_l06`, with explicitly authorized conditional computational probes. No scope acceptance, Section Design, student notebook, or publication is implied. Pending proposals live here; an instructor's eventual answer belongs in [lecture_scope.md](lecture_scope.md). The course review queue should link these blocks without copying their decisions.

**Target:** worktree `/tmp/pml-l04-l12-reconciliation`, branch `assess-l04-l12-reconciliation-20261014`, starting HEAD `5e4c86ee3518958157d21d6bcb4c51bcdab3537e`. Scope blob `bf869a5c85c0d32a995f5c55961ad8e89d704d1e`; architecture `cb111196e44df211e39864be596233a1a3f22aba`; proposed map `12a341b7e8733cdf9fe8154f066648d64e6034c0`; actual map `cf143d8c5427030cf3ac6c6ad05d8ad9cd420fe3`. The actual map is empty: prepared upstream materials are conditional prerequisites, not delivered competence.

## New evidence and practical endpoint

The current proposal can support guided competence in setting up, fitting and evaluating one affine categorical classifier. It should preserve the instructor-requested Bayesian opening: changing a Gaussian observation family to Bernoulli/Poisson/categorical is a modeling choice; MLE/MAP point fitting rather than posterior integration is a separate computational choice. Neither GLMs nor autodiff invalidate hierarchical priors. The same distinction prevents L07 from being introduced as merely another optimizer.

[probe_softmax.py](notebook_feasibility/probe_softmax.py) ran from a fresh process in the isolated, locked worktree uv environment. [results.json](notebook_feasibility/results.json) records versions, data/split hashes, shapes, numerical checks, objective traces and fixed-seed alternatives. Three-class Iris uses petal length/width, a supplied stratified 105/45 split, train-only standardization, zero-initialized `W:3×2,b:3`, CPU, one stable loss, 800 fresh uniformly sampled 32-case batches and learning rate 0.15. Seeds 2027, 5 and 17 are robustness probes, not proposed extra student fits.

| Split seed | Held-out mean NLL, nats | Held-out classification error | Frequency-baseline NLL | Frequency-baseline error |
|---|---:|---:|---:|---:|
| 2027 | 0.104763 | 0.044444 | 1.098612 | 0.666667 |
| 5 | 0.138355 | 0.088889 | 1.098612 | 0.666667 |
| 17 | 0.146494 | 0.066667 | 1.098612 | 0.666667 |

The frequency baseline is fitted on training labels only; balanced training classes make it uniform. Its predicted-label tie is explicitly resolved by `argmax` choosing the first class. Its probability score remains well defined. These are outcomes of these finite runs, not an accuracy guarantee, calibration validation, or evidence of a unique finite MLE. All-class softmax contains common-score-shift redundancy.

For a batch `X:B×2` and one-hot targets `T:B×3`, the checked formulas are

$$
Z=XW^T+b,\quad P=\operatorname{softmax}(Z),\qquad
\nabla_W L=B^{-1}(P-T)^TX,\quad \nabla_b L=B^{-1}\sum_n(P_n-T_n).
$$

Nonzero random parameters in float64 avoid a check that passes only at symmetric initialization. The maximum manual/autograd discrepancy was `1.11×10⁻¹⁶`; repeated backward on a fresh graph without clearing doubled the gradient to the same tolerance. Adding 123 to every class logit preserved loss to `10⁻¹²`. The training route uses float32 predictors and integer labels. [PyTorch's CrossEntropyLoss documentation](https://docs.pytorch.org/docs/2.14/generated/torch.nn.CrossEntropyLoss.html) confirms the logits/target conventions; [SGD documentation](https://docs.pytorch.org/docs/2.14/generated/torch.optim.SGD.html) confirms separate clearing, differentiation and update operations. Documentation was inspected on 2026-10-14; the executed versions are recorded in JSON.

After imports, each fit took about 0.10 seconds locally. A supplied full-batch alternative at the same 800 updates produced NLL 0.104043 and error 0.044444. It processes 84,000 example visits versus 25,600 for batches of 32; equal updates are not equal passes or equal compute. Iris is too small to establish a useful minibatch scaling advantage. A larger-learning-rate diagnostic (`η=10`) had lower final training NLL but worse held-out NLL 0.168418. It supports separating objective, optimizer and predictive performance; it does not establish a universal learning-rate rule. No training trace is promised monotonic for stochastic updates.

## Prerequisites and burden of a first PyTorch hour

The [cumulative knowledge record](../../.agents/skills/teaching-notebook-authoring/references/student-knowledge.md) has only course-entry/L01 transitions. L02–L04 proposals cannot silently promote API fluency.

| Knowledge state | Mathematics/software relevant here | Feasibility consequence |
|---|---|---|
| Assume familiar | Conditional probability, priors/likelihood/posterior, basic regression, calculus, elementary NumPy indexing and `@` | Explain the new model/target distinction at mathematical level; avoid generic Python review. |
| Previously encountered; scaffold | Matrix/covariance shapes and conditional Gaussian reasoning; planned L02 exponential-family moments/categorical coordinates and L04 log-score interpretation | Explicitly check `W` versus `W.T`, batch/class axes, mean versus summed loss, and nats. Verify future upstream delivery before freezing downstream design. |
| New | PyTorch floating versus integer dtypes, `requires_grad`, computational graph, `.grad`, `backward`, `zero_grad`, optimizer update, gradient-free evaluation; batching/softmax axis conventions | These operations must be introduced. A PyMC sampling call does not establish tensor training fluency. |

The mathematical student actions remain one forward/loss calculation, one analytic batch gradient, a matched autograd check, the clearing/backward/update cycle and held-out interpretation. Supply data loading/splits/standardization, seeds, parameter construction, indices, plotting, evaluation wrappers and the loop container. Do not add `Dataset`/`DataLoader`, custom `nn.Module`, GPU placement, multiple loss APIs or an independent manual-training implementation. Bare affine tensors expose the approved mathematics without new class boilerplate. L11 must teach neural layer/model construction itself; L09 must teach gradients of parameter-dependent random expectations itself.

The current budget `12+10+15+12+6+5=60` leaves five debugging minutes and a removable six-minute batch comparison. A coding inventory suggests roughly 10–15 meaningful student expressions in the core route, depending on how the matched gradient check is scaffolded; this is not an empirically measured workload. The compute run cannot validate 12 minutes of first-tensor onboarding. The required learner pilot and live rehearsal remain outstanding. Use the already-declared optional cuts before proposing removal of a family, class, gradient check, or complete reverse graph. Dropping an explicitly optional comparison is author-owned; changing a required endpoint is instructor-owned.

## Source and prior-decision reconciliation

Read current [source-arc review](source_arc_review.md), [raw earlier preview](../course_architecture_scope/reviews/L05_review.md), [integrated assessment](../course_architecture_scope/reconciliation/integrated_assessment.md) and its [L04–L06 review](../course_architecture_scope/reconciliation/reviews/L04_L06_assessment.md). Directly inspected Murphy Book 2, *Advanced Topics*, December 10, 2025 edition, §§15.1–15.1.3 **Introduction / Some popular GLMs / Link functions / Maximum likelihood estimation**, printed pp. 591–595; §15.3.2 **Multinomial logistic regression**, pp. 611–612. Look for how the link determines a conditional mean and how predictive fitting differs from scientific inference about coefficients. Book 2 SHA-256 `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`; the local PDF and `/tmp/pml-book2.txt` agree with the edition footer. The scope's fixed-dispersion/sign correction and noncanonical warning remain necessary.

Historical commit `dd4f2c5053f29590845ae42a6331d245d773218c` contains an already-reviewed coefficient-meaning proposal, scope blob `09dad99478cf9738de1c981780f3b38087ec650b`. Raw evidence remains in Git at `Lectures/course_architecture_scope/source_arc_agent_reviews/L05_post.md` (blob `ae92385e3e7dfb71e0131a70846dc2365554db29`) and `L05_section.md` (`6ad7eaeefa6db6d89d379723eaff5f983aaf229c`). Those reviews were inspected directly. The proposal's earlier opening must not replace the current instructor-requested Bayesian framing; its preview is not current-target acceptance or student timing evidence.

<a id="l05-coefficient-meaning"></a>
## Pending L05-COEFFICIENT-MEANING — conditional interpretation depth

**Owner/status:** Lecture Scope/instructor; awaiting decision only for the proposed added emphasis.

**Question:** Should L05 explicitly state/explain what a one-unit predictor change means in its three canonical families, while retaining the current Bayesian opening and computational endpoint?

**Options:** (A) add the short conditional meanings—Gaussian mean shift `w_j`, Bernoulli odds ratio `exp(w_j)`, Poisson mean ratio `exp(w_j)`—within the existing comparison; (B) retain the present support/link/variance comparison without requiring those interpretations. A full coefficient-uncertainty/testing module would be a larger separate change and is not recommended inside the current envelope.

**Recommendation:** A, at **state/explain** depth. For example `logit μ=xᵀw` gives an odds multiplier, not a probability multiplier; holding other covariates fixed is a model relation, not causality. Fund its estimated 2–3 minutes by optional probit/MAP/repeated family numerics, counting those minutes only once. This preserves useful scientific interpretation without claiming intervals or significance tests.

**Evidence:** source paragraphs and recovered exact review records above; [current spine](lecture_scope.md#2-mathematical-spine) and [source-arc concern](source_arc_review.md#3-fidelity-losses-and-conceptual-tension). No new notebook fit or API is needed.

**Exactly awaiting decision:** change to L05's promised interpretation depth, live optional-time accounting and contract; required downstream explanations of those coefficient meanings. **Completed independent work:** source verification, numerical core fit/gradient checks and burden inventory. **Still safe:** conditional rehearsal estimates, prerequisite checks, computational correctness work and later-lecture investigations. No L06–L12 investigation depends on this answer.

<a id="l05-evaluation-priority"></a>
## Pending L05-EVALUATION-PRIORITY — evaluate against a meaningful baseline

**Owner/status:** Lecture Scope/instructor; awaiting decision only for required lab comparison emphasis.

**Question:** Should the L05 handoff explicitly require comparing its fitted classifier with supplied training-class-frequency predictions, giving onboarding/evaluation priority over the optional alternate-batch-size activity?

**Options:** (A) one checked three-class fit plus held-out frequency-baseline comparison, with alternate batching optional if time survives; (B) preserve the present handoff wording and let the future author fit a baseline within interpretation time without elevating it to an explicit required comparison; (C) require both comparisons, retaining the current five-minute reserve but increasing workload risk.

**Recommendation:** A. The baseline gives task competence already promised by architecture/map; a second batch size mainly compares fitting mechanics. Preserve the analytic/software gradient check and full training cycle. No claim of extra live time or a validated 60-minute hour follows.

**Evidence:** probe results show substantial improvement against the supplied baseline; full-batch versus minibatch produces similar test scores on this tiny task. The current scope's 12-minute interpretation allocation and six-minute optional comparison provide a bounded place to make the tradeoff visible.

**Exactly awaiting decision:** whether baseline comparison is required in the scope's lab contract, and whether alternate batching receives any required time. **Completed independent work:** both conditional computational routes and baseline scoring. **Still safe:** checked implementation, software onboarding inventory, learner-pilot planning, other lectures. If a first-time-learner pilot later cannot fit even A, return that measured pressure to Scope; do not now infer permission to delete a required derivation or student action.

## Remaining gates and safe continuation

Author repairs: keep matched parameter/batch/loss scaling, logits-only loss, train-only preprocessing and frequency baseline provenance; supply the exposed update scaffold. Instructor choices: the two blocks above plus eventual current-scope acceptance; no answer has been inferred. Downstream gates: upstream actual-delivery reconciliation, Section Design preview on any accepted changed target, live rehearsal, first-time-PyTorch learner pilot, then worked-solution and Q&A authoring and clean local/hosted Colab validation. This probe is not a notebook and has no Colab-compatibility claim.

The assigned independent numerical, software, source and conditional-workload investigations are complete. Further scope-neutral source checks remain possible if new pressure appears; immediate remaining empirical gates need a human learner/instructor or hosted environment. L06 and later investigations should continue independently of these pending choices.
