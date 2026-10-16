# Selected L01 squared-loss sequence

Status: bounded Organization revision, 2026-10-16; coherent proposal for Design/Authoring and instructor review. No production promotion or approval claimed. Ownership: this scratch directory only.

Basis: live `slide_deck.typ` at current delivery basis (predecessor original handout p63; loss insertion pp64–65; sensor successor p66); `reconciliation/slide_judgment/result.md`; exact `production/risk_variants_handout.pdf` setup p2, shared decomposition p3, decision p7 and corresponding source/rendered PNGs. Earlier A/B contract's open preference questions are resolved. This contract selects only those pages' teaching relationships and preserves accepted live proof depth.

## Local placement and prerequisites

Retain the existing Linear Gaussian systems section, its title slide and retrospective summary. This is an internal replacement cluster, not a new section. Actual p63, **Inference often combines conditioning and summarizing**, establishes the conditional Gaussian distribution, distinguishes it from its mean summary and shows E[z|y]=∫z p(z|y) dz. It does not establish optimality. Keep its authentic final state and reveals in proposal evidence; the older experiment's simplified predecessor is not equivalent evidence of the live transition.

Given an observation y, choose deterministic a∈R^d to reconstruct random z∈R^d. All norms below are Euclidean. Finite conditional second moment E[||z||²|y]<∞ is the proof's validity condition (where these conditional moments exist). This must be student-visible in setup, not appear only after being used. Conditional on y, a and m=E[z|y] are fixed; z and r=z−m remain random. No Gaussian assumption enters the general proof.

## Ordered teaching moves

1. **Choose a reconstruction by its conditional squared-error risk.**
   Intention: turn the already available mean summary into a decision problem, define the criterion and center its error before averaging. Preserve the selected p2 named groups, `Squared-error risk` and `Centered error`, supporting the intact expansion. Required mathematics: L(a,z)=||z−a||²; R(a|y)=E[L(a,z)|y]; m=E[z|y]; r=z−m; z−a=r+(m−a); ||z−a||²=||r||²+2rᵀ(m−a)+||m−a||². State the finite-moment condition and fixed/random distinction. Design direction: criterion first, then centering, then expansion; keep prior mathematics available. The goal is choosing a by its conditional expected loss; the algebra is pointwise and the averaging proof has not happened yet.

2. **Centering separates residual uncertainty from estimation error.**
   Intention: derive the conditional-risk decomposition by averaging the setup expansion. Retain selected shared p3's complete proof. Recall only the previous intact expansion; the expectations are new work. Required warrants: E[r|y]=E[z|y]−m=0; E[rᵀ(m−a)|y]=E[r|y]ᵀ(m−a)=0 because m−a is fixed; V=Cov[z|y]; E[||r||²|y]=Σ(j=1,…,d) E[r_j²|y]=tr V. Conclude intact R(a|y)=tr V+||m−a||². Design direction: averaging operation ties the two evaluations to the conclusion; neither definition alone proves an expectation identity. Preserve separate intermediate/final interpretations where the original shared reveals use them. Do not introduce the optimizer before the next move.

3. **The posterior mean minimizes squared-error risk.**
   Intention: read the established decomposition as a minimization argument and then apply it to the conditional Gaussian already taught. Retain selected p7's intact identity, annotation `independent of a` attached to tr V and `nonnegative; zero iff a=m` attached to ||m−a||². These warrants establish the unique minimizing action a*(y)=m=E[z|y] and minimum risk min_a R(a|y)=tr V. Keep the consequences visibly related and attained at the same action. Subordinate application: for the conditional Gaussian, a*(y)=μ_(z|y), min_a R(a|y)=tr Σ_(z|y). Preserve minimum/action correspondence between general and Gaussian rows. Gaussianity supplies posterior parameter names, not an assumption for mean optimality. Model conditional expected loss is not an empirical or external-data performance guarantee.

## Successor and retrospective closure

Return directly to authentic original p66, **Sensor fusion combines measurements according to their uncertainty**, followed by original p67, **The same model can also predict measurements**. Sensor fusion applies conditioning then mean summarization to two measurements; the selected loss result now supplies that summary's squared-loss justification. Do not add a new handoff slide or preload the sensor example into the proof. Sensor assumptions/illustration qualifications are outside this Organization revision and remain with the coordinator and their owning stages.

Preserve the existing section-ending **Summary: Linear Gaussian systems** and its retrospective job; no section bookend or new result is inserted here. The local proof's retainable takeaways are the intact risk decomposition, unique mean action, and residual covariance trace; no summary rewrite is commissioned.

## Checks, uncertainty and upstream requests

The titles recover criterion → decomposition → decision; each slide has a distinct job. Setup supplies all notation and the expansion used on decomposition; decomposition establishes the exact result recalled on decision. The selected named setup and relation-based decision have no mathematical or sequencing conflict. Three slides remain the current Organization choice because the averaging argument and optimization are distinct; it is not an instructor-imposed count.

No Scope or Section Design change request. No further preference question is needed. Finite-moment visibility is an author/design fidelity condition preserving existing accepted mathematics. The replacement adds one handout slide versus the current two-slide insertion; it does not establish a live-time estimate. The historical 2–4 minute estimate remains unmeasured. Design/Authoring must return the coherent selected sequence, all meaningful reveals and authentic immediate neighbors for review; instructor acceptance remains outstanding. This source/render reconciliation is Organization's own check, not independent downstream validation.
