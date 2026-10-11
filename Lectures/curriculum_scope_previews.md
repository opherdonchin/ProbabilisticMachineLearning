# Initial scope briefs and feasibility reviews: revised L04–L12

**PROVISIONAL — no instructor approval.** Prepared 2026-10-11 against the proposed split branch. This is a **rapid, incomplete scope-design pass followed by same-context feasibility assessment**, not a formally approved five-part lecture scope or an independent subagent review.

**Basis:** [lecture-scope skill](../.agents/skills/lecture-scope/SKILL.md), [shared review/backpressure procedure](../.agents/skills/shared/backpressure.md), [timing calibration](../.agents/skills/lecture-scope/references/timing-calibration.md), [coverage ledger](material_ledger.md), Book 2 and the provisional syllabus. The scope skill already supports review of an instructor's preliminary brief; no change to the skill is required. Each lesson is ~100–120 live lecture minutes plus a distinct 60-minute student notebook. Estimates below are unmeasured. L01 is delivered; L02 has agreed scope but is not marked delivered; L03 is still tentative.

## L04 — Information theory: dependence and communication

### Rapid five-part brief
- **Intellectual arc:** entropy/KL as information measures; MI as dependence; data processing constrains communication and representation; a noisy channel and parity check make this computational. Source coding motivates entropy, but does not compete with channel decoding for the worked endpoint.
- **Mathematical spine:** entropy/cross-entropy/KL (Motivate and Work; Book 2 §§5.1–5.2); I(X;Y) = D_KL(p(x,y) || p(x)p(y)) = H(Y)-H(Y|X) (derive one identity and work a small example; §5.3); data processing (proof sketch); a finite parity code, noise model and posterior MAP decoding (Work; §5.5). Source coding (§5.4.1) State/Explain; rate-distortion (§5.4.2) Mention; classical IB (§5.6) defer to an optional comparison in L12.
- **Notebook handoff:** implement finite parity-code noisy transmission; enumerate probabilities, calculate MI, posterior decode and plot error versus flip probability, using NumPy. Murphy's error_correcting_code_demo notebook provides the textbook example but the actual student version is not validated. Alternative is source coding, not both.
- **Examples:** discrete message → redundant codeword → noisy observation → posterior decoding; a brief feature-processing DPI example.
- **Contract:** one substantive coding application; MI/data-processing mathematics; no full source-coding theorem, variational MI bound, full IB derivation or bits-back. **Time: tight**, ~100–110 live minutes plus 60-minute lab.

### Same-context lecture-scope feasibility review
**Verdict: feasible-with-risks, medium-low confidence.** **Scope/advisory:** §§5.1–5.5 overfull if both source and channel coding developed: select one operational coding path; restrict source coding to a conceptual comparison. **Scope/advisory:** conditional MI, sufficient statistics, DPI and rate-distortion all at depth would overwhelm channel example: select MI + DPI as core. **Notebook/downstream:** check the referenced notebook and time a full clean NumPy run. No actual L03 delivery artifact yet establishes a precise prior boundary.

## L05 — Learning probabilistic models: GLMs and optimization

### Rapid five-part brief
- **Intellectual arc:** L02 established exponential families. Make their natural parameter depend on predictors and compare Gaussian/Bernoulli/Poisson GLMs; derive why likelihood gradients compare observed and predicted sufficient statistics; work multinomial softmax and introduce AD/SGD as the computational way to fit the model. L06 then asks what to do when observations contain hidden variables.
- **Mathematical spine:** scalar canonical-link GLM with eta_n = w^T x_n, mean mu_n = A'(eta_n), canonical link ell(mu_n)=eta_n (Derive/Motivate, Book 2 §15.1); Gaussian identity, binomial-logit, Poisson-log as comparative cases (§15.1.1); §15.1.2 noncanonical links as Mention, not full development; log-likelihood derivative sum_n x_n(y_n-mu_n)/sigma^2 for this specified scalar family (§15.1.3, Derive), reversing sign for NLL; multinomial softmax (Work, §15.3.2); differentiable objective, computational chain and reverse-mode AD (Work one compact graph, §6.2); minibatch stochastic gradient (§§6.3.1–6.3.2, Motivate/Apply). Brief MLE/MAP and log-score connection (Book 2 §§14.1.2, 14.2.1). Do not pretend the scalar gradient is already the full multiclass matrix result.
- **Notebook handoff:** actual three-class Iris categorical GLM using PyTorch autograd/visible SGD optimizer and held-out log loss. The worked Batra notebook is a candidate reference, not yet tested in course runtime. One new software library only; no separate Poisson notebook.
- **Examples:** compare Gaussian/Bernoulli/Poisson means and links in one parallel representation; derive the **single general canonical gradient**; apply to multinomial Iris fitting in the lab.
- **Contract:** students leave understanding **why these are all GLMs**, why their likelihood gradient has an interpretable form, and how an automatic differentiation / SGD loop fits a conditional probability model. Skip three separate full gradient derivations, Hessian/IRLS, full Bayesian GLM inference, specialized sparse priors, natural gradient, score-function/reparameterization gradients, §§6.6–6.9. **Time: tight/high risk**, ~105–115 live minutes plus 60-minute lab.

### Same-context lecture-scope feasibility review
**Verdict: feasible-with-risks, medium-low confidence; highest-priority independent review.** **Scope/advisory HIGH:** §15.1 generality and §6.2 autodiff could each fill a lecture. Smallest repair: one GLM likelihood-gradient derivation, one short reverse-mode graph, and *recognize* rather than fully derive three family cases; let the notebook own code mechanics. **Scope/advisory:** categorical softmax is a vector exponential family; distinguish from scalar GLM formula and work only the essential specialization. **Notebook/advisory:** time first PyTorch experience, provide fixed train/test data and a transparent full optimizer loop. **Mathematical provenance:** Book 2 §15.1.3 Eq. (15.35) gives a log-likelihood-gradient term with the data-minus-mean sign, assuming dispersion 1 in the text's immediate calculation; avoid using this sign for NLL. Main structural gain: much stronger L05→L06 observed-versus-hidden data contrast.

## L06 — EM transition and latent-variable learning

### Rapid five-part brief (predecessor changed, topic mostly unchanged)
- **Arc:** observed-label GLM likelihood optimization (L05) → unobserved assignments or missing measurements → alternating bound-based EM.
- **Mathematics:** observed/complete likelihood, latent posterior expectation, EM lower bound / monotonicity intuition, one concrete E/M calculation (Book 2 §6.5 and selected §28.2; Book 1 §§3.5, 8.7).
- **Notebook:** missing-Gaussian moments *or* MRI tissue GMM—one of these, not both.
- **Example:** one latent-variable model compared with fully observed L05 likelihood.
- **Contract:** full EM worked endpoint, ~100–110 live minutes, **tight**; not an SGD extension and not a tour of all mixtures.
**Same-context review: feasible-with-risks.** No new major topic, but do explicitly contrast latent marginalization and ordinary GLM optimization; notebook choice remains instructor-owned. This is a continuity preview rather than an independently revised full scope.

## L07–L10 — boundary and prerequisite checks (no substantial scope redesign)

- **L07 general inference:** the logistic grid-versus-Laplace lab can now carry L05's model forward without re-deriving all GLMs. **Feasible-with-risks:** Chapter 7 breadth and approximation comparisons still need selective pruning.
- **L08 structured message passing:** HMM plus Kalman remains heavy; the new order does not solve this overload. **Feasible-with-risks:** develop one full exact method, compare the other selectively.
- **L09 variational inference:** ELBO/mean-field/CAVI/black-box gradients/amortization remain demanding. The stochastic-objective gradient material from Book 2 §6.3 belongs here, but should not be appended as a free extra chapter. **Feasible-with-risks:** work one estimator in depth, motivate the other, and reserve full VAE implementation for L12.
- **L10 MC/MCMC:** lecture and multimodal MH lab shift one slot later, with no substantive mathematical change; avoid new survey scope. **Feasible-with-risks** based on inherent breadth, not the changed sequence.

These are **continuity checks** rather than new five-part scopes. Substantive edits to them would require another instructor decision and targeted review.

## L11 — Neural networks as probabilistic conditional models

### Rapid five-part brief
- **Intellectual arc:** replace the linear GLM predictor from L05 with a learned nonlinear map, maintaining an explicit conditional probability model; backprop from L05 autodiff is reused to train a heteroskedastic predictor.
- **Mathematics:** p(y|f_theta(x)) contrast with p(y|W^T x); MLP and nonlinear layers (Motivate/Work); backprop through a simple multilayer graph (Apply prior AD); normal NLL with mu_theta(x) and positive sigma_theta(x) (Derive/Work); Gaussian prior ↔ weight decay (State/Apply). Sources Book 2 Ch. 16 and selected Book 1 §§13.2–13.5. Book 2 §14.2 calibration **optional diagnostic only**; §15.2 prior taxonomy **not assigned**.
- **Notebook:** heteroskedastic neural regression in PyTorch; predict conditional mean and variance, inspect predictive intervals. Existing worked source is in TFP, so PyTorch port and timing are unverified.
- **Example:** compare linear constant-noise regression to nonlinear variable-noise output.
- **Contract:** students can build and interpret one probabilistic NN; no CNN/transformer survey at depth, no second GLM/variable-selection lecture. **Time: tight**, ~100–110 live minutes + notebook.

### Same-context lecture-scope feasibility review
**Verdict: feasible-with-risks, moderate confidence.** **Scope/advisory:** L11 used to be overburdened with displaced GLM priors and calibration. The minimal repair is already applied in this branch: weight decay/prior analogy, optional single calibration diagnostic. **Scope/advisory:** avoid substituting Ch. 16 architecture catalog for worked conditional Gaussian likelihood. **Notebook/downstream:** validate the TFP→PyTorch port and predicted variance positivity.

## L12 — VAEs: rate-distortion and amortized latent models

### Rapid five-part brief
- **Intellectual arc:** synthesize L06 latent variables, L09 VI, L11 neural probability outputs and L04 information theory; optimize a VAE with reconstruction + KL and interpret the balance.
- **Mathematics:** p_theta(x,z)=p(z)p_theta(x|z), q_phi(z|x) (Work); ELBO with reconstruction expected log likelihood and KL (Derive); Gaussian reparameterization z=mu_phi(x)+sigma_phi(x)epsilon (Work); weighted beta-VAE and rate-distortion return (Motivate, Book 2 §§5.4.2, 21.3.1); posterior collapse (Motivate/Diagnose, §21.4). Supervised IB (§5.6) and InfoVAE (§21.3.2) as *optional comparisons*, not full derivations.
- **Notebook:** small beta-VAE, reconstruction/KL versus beta and latent traversals; preferred mobility case remains contingent on data/preprocessing and student runtime; MNIST PyTorch reference is fallback.
- **Example:** one trained encoder/decoder with beta tradeoff, not a generative-model zoo.
- **Contract:** basic architecture, training objective and information-theoretic diagnosis are central. **Time: tight**, ~100–110 live minutes plus notebook.

### Same-context lecture-scope feasibility review
**Verdict: feasible-with-risks, moderate-low confidence.** **Scope/advisory:** full IB+InfoVAE+posterior collapse is overfull; core beta-VAE/rate-distortion only. **Prerequisite/advisory:** verify L09 actually covers the gradient/reparameterization math claimed as prior knowledge; if not, budget derivation in L12. **Notebook/downstream:** measure training runtime and data access for mobility; keep MNIST fallback.

## Whole-course backpressure and decisions

1. **L05 is the tightest new mathematical unit.** Review whether the explicit §15.1.3 gradient plus reverse-mode AD and the PyTorch lab genuinely fit after representing three GLM families. Do not rescue timing by quietly dropping the GLM's family interpretation.
2. **L04 coding endpoint:** error-correcting channel or source compression. The preliminary plan picks channel coding, but the instructor has not settled it.
3. **L06 lab:** Gaussian missing-data EM versus MRI GMM.
4. **L09/L12:** which stochastic gradient estimator gets a full derivation and which lecture owns the Gaussian reparameterization argument.
5. **L11 omitted GLM topics:** detailed sparse prior/selection and calibration are genuinely lost or optional; merely citing a section is not coverage.
6. **Source/runtime limitations:** No future coding notebook was executed/timed; no lecture deck for these proposed lectures was rendered; no independent specialist agent has reviewed this proposal.
7. **Scope skill process:** This rapid brief → preliminary review sequence is only an evaluation input. A complete five-part scope, downstream section-design feasibility preview, and instructor approval remain future steps.

**Overall provisional verdict:** L04, L05, L06, L11 and L12 all appear **feasible-with-risks**, with L05's mathematical load the highest concern. Later inference lectures have unchanged but significant breadth risks. This is an initial screening, **not validation or approval**.

**Next step:** Run [independent VS Code Codex reviews](curriculum_scope_review_codex_prompt.md), preferably one lecture_scope specialist per L04/L05/L11/L12 and one cross-lecture reconciliation pass. Preserve raw reports before synthesis. Do not modify the substantive syllabus based only on a review agent's suggestion.
