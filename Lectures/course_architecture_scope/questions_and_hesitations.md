# Questions and hesitations for instructor — L03–L12

**Status:** Seed for autonomous agent review, **NOT** the final consolidated report. The coordinator must replace this with a reviewed synthesis after all ten scopes, independent per-lecture feasibility reviews, and cross-course architecture review. Do **not** use this as a pretext to interrupt the instructor mid-run.

For each genuine concern include:
- **Where / priority** (earliest lecture or spanning lectures; high/medium/low);
- **Question in human terms** (rather than internal tool jargon);
- **Relevant mathematical, source, practical and timing evidence**;
- **Options and tradeoff**, including what was provisionally selected by agents;
- **What human choice, if any, would materially change**;
- **Review provenance**, references to scope(s) and review file(s).

Group multi-lecture decisions together when a single answer should control two or more scopes. Place them near the earliest relevant lecture. Avoid ten separate copies of the same overload complaint.

## Initial candidate questions (unresolved; for reviewers to validate)

### L03: graphical-model application

Can a local Ising denoising algorithm be worked without using MCMC or mean-field methods before their formal lectures? The current plan favors explaining local conditionals and using a minimal explicit update, but a reviewer must check whether the hands-on is mathematically faithful.

### L04: information theory as computation

Should the one-hour notebook decode a noisy parity-check code (currently preferred) or build/evaluate a source-compression code? The choice determines which parts of §§5.4–5.5 receive genuine operational treatment. MI/DPI should not be sacrificed merely to claim two forms of coding.

### L05: GLM breadth versus optimization depth

Can students understand the Gaussian/Bernoulli/Poisson conditional family, the §15.1.3 canonical gradient, categorical softmax, reverse-mode autodiff and SGD within a two-hour lecture? Which mathematical derivation would be shortened first while preserving substantive GLM unification and a serious computational optimization skill?

### L06: EM notebook endpoint

Incomplete Gaussian measurements are a strong link to delivered L01; MRI tissue segmentation adds biomedical relevance and GMM clustering but may require more preprocessing. Which makes the better one-hour student exercise after the actual L05 scope?

### L07–L09: inference methods and gradient responsibilities

Which HMM/Kalman algorithm gets full worked treatment? Which gradient estimators are deeply developed in VI (score-function or reparameterization), and which derivation may be deferred to L12 without creating a missing prerequisite?

### L10–L12: methodological breadth and coding load

How much MCMC should go beyond familiar PyMC/NUTS? How much network architecture survey can coexist with a serious heteroskedastic likelihood exercise? Does VAE notebook training and mobility-data access fit the one-hour student window, and how deep should the rate-distortion/IB return be?

## Cross-cutting questions

- Are there important Book 2 topics with **no primary home** that are too valuable to omit, especially §6.4 and §§6.6–6.9, SMC, Ch. 14 evaluation, or sparse-prior GLM material? If kept, specify exactly what is displaced.
- Do L03–L12 form a continuous introduction of NumPy/SciPy, PyTorch and probabilistic inference rather than presenting new software syntax during difficult mathematics?
- Has each mathematical result one primary derivation, with later reuse explicitly distinguished from repeat coverage?
- What is the course's actual feasible derivation density given L01 experience and the early lectures' delivered artifacts?

**Coordinator duty:** Report real doubts instead of papering them over; make safe provisional choices when possible; never label an unsupported scope approved simply to finish the batch.
