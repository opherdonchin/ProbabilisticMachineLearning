# L11–L12 independent scope assessment

**Stage/mode:** Lecture Scope / feasibility-review. **Reviewer:** `/root/assess_l11_l12`, independently delegated by the coordinator on 2026-10-14. **Worktree/branch:** `/tmp/pml-l04-l12-reconciliation`, `assess-l04-l12-reconciliation-20261014`. **Baseline:** `16850fbda82ff9a4a0a665ddab52115cda14a2bf`. This report owns no scope, map, skill, notebook, section or slide changes. It is an integrated assessment, not instructor approval.

**Verdict: feasible-with-risks.** The existing mathematical endpoints are sound, and their strongest recovered revisions are worth preserving. There are two consequential scope/map discrepancies: L11 does not yet provide the map's simpler-function comparison, and L12 makes the map's required prior-generation comparison optional. A recovered, independently reviewed L11 composition/inference-role repair is absent from the current branch; it should be offered as an existing pending proposal, not rebuilt or treated as already accepted. Notebook feasibility remains conditional on substantial supplied code, new checked baselines/checkpoints, CPU timing and a student workload pilot. Mathematical confidence is high; practical and timing confidence is medium-low. No course notebook was run or implemented here.

The mobility data are more accessible than previous reviews established: a versioned public source is byte-identical to the instructor's CSV. That resolves the evidence gap about finding a portable source; final attribution, source-rights and packaging disposition still belong to authors, not to a request that the instructor approve formulas.

## Exact targets and recovered authority

Current baseline blobs checked:

| Artifact | Git blob |
|---|---|
| `course_architecture.typ` | `cb111196e44df211e39864be596233a1a3f22aba` |
| `curriculum_map.typ` | `63fb5cea0a7b0a4c908c8f803e550d087d20a412` |
| L11 scope | `629e38893497e4b2cf18e4fcf58d225177c00f88` |
| L12 scope | `22fa2d8307ef7cb621456521383b6c352dcd451a` |
| L11 same-context source-arc report | `c6b602079efd9d97e428f984e40da60519f1d183` |
| L12 same-context source-arc report | `90a98e2944ea433a90c12a9200ab328b9d63c486` |
| L11 original independent preview/readable guide | `7e157a005e002de2ca05300947e646ed9f03405e` |
| L12 original independent preview/targeted scoring check | `87f34946ebcb72f3a46ba5d0dbf06badc6d4c46e` |
| L04 prerequisite scope | `b0efb934cd9a84d19ab9779239c438c9f14d8dc3` |
| L05 prerequisite scope | `bf869a5c85c0d32a995f5c55961ad8e89d704d1e` |
| L06 prerequisite scope | `c795841dfe92182c683d2b0e0d105f921814795d` |
| L09 prerequisite scope | `89ee9f324fd0384972ff1ef52c446d6b146367d6` |

Read the current architecture, proposed/actual maps, full L11/L12 scopes, source-arc reports, independent previews, `STATUS.md`, `source_inspection.md`, relevant teaching-choice/decision records and incoming scope commitments. `curriculum_map_actual.typ` explicitly says no meeting has been taught. Older review language about a “delivered L01” is historical evidence about those reviewers' assumptions, not a present delivery claim. L11/L12 remain instructor-pending; acceptance of the course order and broad framing does not approve their detailed application choices.

The coordinator recovered commit `dd4f2c5053f29590845ae42a6331d245d773218c`. I inspected its L11/L12 scopes and raw source/Section Design reviews with `git show`, without restoring historical files into the current tree. Its strongest L11 proposal is scope blob `380d611c034f0edcc50d732b52f22732fc22f19d`; its header explicitly says instructor acceptance is pending. It adds **State/Work** treatment of composed numeric graphs and **State/Explain** treatment of the two network roles, funding five minutes by removing the required SGD-shrinkage/adaptive-penalty mechanics. A/B/E allocations become 24/33/7 rather than 22/30/12, keeping 100 substantive +12 reserve and the unchanged 60-minute lab. The short Gaussian-prior scaling derivation remains **Derive**. This is an actual capability tradeoff, not spare time obtained by deleting a merely optional example twice.

Recovered independent evidence is identifiable at that commit:

| Report under `Lectures/course_architecture_scope/source_arc_agent_reviews/` | Blob / finding |
|---|---|
| `L11_post.md` | `4554e72b00689eb0968a316db0278d4d695462f6`; reviewer `/root/source_late`, justified selective reorganization, feasible-with-risks; localized source-arc blocker resolved at exact revised scope |
| `L11_section.md` | `b0dae39fff99aa7240e31ed3ba773c47fa697d1d`; `/root/section_models_preview`, feasible with advisory risks, no scope blocker |
| `revision_L04_L05_L11.md` | `b6b1d819739927c3c79085021737bb5bb30dce18`; exact repair/funding and pending acceptance |
| `L12_post.md` | `053bbacb9df584c59a7787d83f66aa46f8044fa4`; justified selective synthesis, no required rewrite; generation display optional under that older contract |
| `L12_section.md` | `afcf55b81abc68839260147dc57dbeaebef5cb90`; feasible with advisory risks at L12 blob `67fdd3cd474b3bbf1e5ca7e931c169ebef737eeb` |
| `whole_course_post.md` | `ebfa6b9b9f730aaec990f96f452fca3e4f8f2c02`; repaired L05→L11→L12 chain coherent; acceptance and data/runtime validation separate |

Those reports evaluate their exact earlier versions, not today's competence-first map. The older same-context L11 recommendation for broad re-centering or depth/architecture exposition is stronger than the recovered independent reviewers found necessary. The smallest supported repair explains composition and the two probabilistic roles through the existing shared-head example; no architecture survey or second encoder lab is needed. The L12 older acceptance of an optional generation display cannot settle a newer map commitment requiring students to inspect prior generation.

## Incoming prerequisites and what must survive reconciliation

| Incoming owner | Exact reusable knowledge | Consequence for L11/L12 |
|---|---|---|
| L01/L02 | Gaussian conditioning/densities; likelihood and distribution parameterization | Reuse probability mathematics; do not assume any fitted neural-weight posterior or VAE encoder |
| L04 | Expected log scoring, directed KL; MI as joint-versus-product KL and independence criterion | L11 uses log score; L12 introduces the aggregate encoder distribution and derives the mixed finite-input/continuous-latent rate identity itself. Neither coding notebook nor a rate-distortion theorem is prerequisite |
| L05 | Affine likelihood models, branching reverse-mode AD, batch mean gradients, optimizer steps and PyTorch loop | L11 **applies** these to nonlinear shared heads; L12 reuses their software and gradients. Moving all actual gradient/shape practice out of L05 creates downstream debt |
| L06 | `log pθ(x)=F(q,θ)+KL(q∥pθ(z∣x))`, touching exact-posterior bound and the difference between EM and restricted VI | L12 **applies** the identity; it must not inherit EM's exact-step monotonicity for joint noisy encoder/decoder fitting |
| L09 | Restricted Gaussian posterior fitting, correct prior KL, full pathwise derivative under interchange conditions, PyTorch, predictive integration | L12 **applies** stochastic differentiation while changing global-weight q into per-case local-latent q. L11 recalls posterior averaging only to distinguish uncertainty objects |

L09's current notebook is a global regression-weight posterior; the revised map proposes Bayesian classification. Either likelihood can preserve the Gaussian prior KL and pathwise machinery needed downstream. Preserve the explicit scale parameterization: L09 uses log SD `ρ`, giving `s=exp ρ`; L12 uses log variance `ℓ`, giving `s=exp(ℓ/2)`. Changing L09's practical task does not justify cutting that derivation, its explicit integrand derivative or gradient checks. L12 must establish local latent/inference roles regardless of which L09 example is selected. L10/HMC is not an essential dependency for L11/L12.

## Mathematical endpoints and practical competence

**L11:** Students construct one nonlinear conditional Gaussian, verify its NLL/gradients and assess whether the additional mean/scale flexibility improves prediction. With fixed fitted weights ψ,

$$
p_\psi(y\mid x)=N(y;\mu_\psi(x),\sigma_\psi(x)^2),\quad
\sigma_\psi(x)=\sigma_{\min}+\operatorname{softplus}(a_\sigma(x)),
$$

$$
\ell=\tfrac12\log(2\pi)+\log\sigma+\frac{(y-\mu)^2}{2\sigma^2},\quad
\partial_\mu\ell=(\mu-y)/\sigma^2,\quad
\partial_{a_\sigma}\ell=\left(\sigma^{-1}-(y-\mu)^2\sigma^{-3}\right)\operatorname{sigmoid}(a_\sigma).
$$

The full likelihood/mean-scale argument is **Derive/Work**; AD/training is **Apply**; prior scaling is a short **Derive**. A positive floor bounds scale away from zero but does not establish generalization. ReLU's convention at zero must be identified as an AD convention, since the ordinary derivative there does not exist.

The practical query is a predictive distribution for a future response. Held-out NLL rewards both mean fit and appropriate width; MSE asks about conditional mean accuracy. A fixed-scale nonlinear comparator isolates the value of varying scale. An affine Gaussian comparator would isolate the value of the nonlinear mean. The scope currently supplies the former only, whereas the map asks for both fixed-scale and simpler-function baselines. Known-law synthetic data with hundreds of noisy observations are a defensible first practical model encounter here: students can see when noise regions are mishandled, instead of merely verifying three algebraic points. It need not be replaced with a new real-data pipeline to satisfy the architecture.

The validity regime is a useful Gaussian conditional approximation with enough relevant observations and a train/held-out split suited to the intended interpolation task. Computational payoff is flexible differentiable evaluation/training of one compact model, **not** cheaper fitting than an affine model. Extra nonconvex optimization and statistical complexity must earn their cost in held-out performance. Learned scale can absorb mean misspecification. The stated interval describes model-relative observation spread, not a confidence interval for the mean and not a guarantee of empirical coverage. A full posterior over weights would instead yield

$$
\operatorname{Var}(Y_*\mid x_*,\mathcal D)
=E[\sigma_\psi(x_*)^2\mid\mathcal D]
+\operatorname{Var}[\mu_\psi(x_*)\mid\mathcal D].
$$

The point fit does not compute the second term. The Gaussian prior penalty `‖w‖²/(2Nτ²)` for a mean NLL produces a MAP point, not that posterior. No Bayesian neural-network inference is needed to teach this distinction correctly.

**L12:** Students assemble and check one sampled VAE loss, run bounded joint updates, and judge reconstruction, prior generation and a supplied β tradeoff. Model and inference distribution are separate:

$$
p_\theta(x,z)=N(z;0,I)N(x;d_\theta(z),\tau^2I),\qquad
q_\phi(z\mid x)=N(\mu_\phi(x),\operatorname{diag}(e^{\ell_\phi(x)})).
$$

At `d=19`, `k=4`, `τ²=1/2`, event sums followed by case averaging give

$$
L_\beta=E_{p_D}E_q[\|X-d_\theta(Z)\|^2+(19/2)\log\pi]
+\beta E_{p_D}\frac12\sum_{j=1}^4(\mu_j^2+e^{\ell_j}-1-\ell_j).
$$

β=1 is negative ELBO, not exact negative log likelihood; β≠1 changes the criterion. Reconstruction derivatives reach θ directly and φ through `z=μ+exp(ℓ/2)⊙ε`; exact KL contributes φ derivatives. One draw gives an unbiased objective/gradient estimator under the stated regularity assumptions at fixed parameters, not monotone training or guaranteed MLE. Held-out distortion must average event-summed Gaussian NLL over q draws; decoding `μ(x)` is generally another quantity. Prepared comparison fits must share split, train-only transformations, likelihood variance, constants and observation weighting.

L12 newly **derives** the rate identity. Under the finite empirical input distribution and support-compatible finite terms, insert the aggregate `q(z)=E_{p_D}q(z∣X)` into the logarithmic ratio to get

$$
R=E_{p_D}\operatorname{KL}(q(Z\mid X)\Vert p(Z))
=I_q(X;Z)+\operatorname{KL}(q(Z)\Vert p(Z)).
$$

Every input using `N(1,1)` under an `N(0,1)` prior gives `I=0` but `R=1/2`. This establishes why rate is an upper bound on input information, not its value. A small fitted rate alone does not prove that the decoder ignores z, and β changes need not produce a monotone empirical frontier. No Shannon-optimal codec, MI estimator or identified causal factor is promised.

The repeated-query benefit of amortization needs an explicit regime. At fixed learned decoder, separate K-step local optimization for M cases costs roughly `M K C_local`; a shared encoder costs `T_train + M C_enc`. Training is worth amortizing when many similar cases make that tradeoff favorable, while encoder restriction/error remains acceptable. The 349-row mobility exercise teaches this mechanism and can contrast forward evaluation with the idea of per-case optimization; it does not establish a measured speed advantage or statistically justify every nonlinear latent model. A β1/β4 comparison is a meaningful within-model tradeoff, but it cannot by itself show that a VAE is preferable to a simpler representation model. A supplied rank-four linear reconstruction comparison is an advisory alternative if useful; label its deterministic reconstruction error separately from expected VAE D and do not invent a KL rate for PCA.

## Primary source and data findings

Directly read the relevant local extractions `/tmp/pml-book2.txt` and `/tmp/pml-book1.txt`. Source PDFs identified by the coordinator are Book 2 **December 10, 2025 online edition**, SHA256 `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`, and Book 1 **April 18, 2025 online edition**, SHA256 `89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf`.

Focused reading routes are B2 §16.1 **Introduction**, p.631 (numeric graphs and modeling/inference roles); §§16.2.1–16.2.2 **Linear layers / Nonlinearities**, pp.632–633; §16.3.1 **Multilayer perceptrons**, pp.641–642; B1 §13.2.4.4 **MLP for heteroskedastic regression**, pp.433–434. For L12, B2 §§21.1–21.2.2 **Introduction / Modeling assumptions / Model fitting**, pp.791–793 (generative integral and amortization); §21.3.1 **β-VAE**, pp.797–798; §5.4.2 **Lossy compression and the rate-distortion tradeoff**, pp.248–249; §21.4 introduction/§21.4.1 **Avoiding posterior collapse / KL annealing**, pp.806–807. These selective passages support the present endpoint, not a whole-chapter promise.

Source cautions matter: B1's prose describes quadratic variance, but the inspected heteroskedastic code uses **SD** `0.25+((x+20)/80)^2`, whose square is variance. B2 Eq.21.7 has inconsistent covariance/log-scale prose: the course's explicitly defined log variance is necessary. β=0 removes the penalty but does not make a random encoder deterministic. Restricted amortized ELBO optimization is not a guarantee of a locally optimal MLE. Correct ELBO/KL signs/constants come from the independently checked L09 expressions, not B2 Eqs.10.49–10.50. No exact source figure was reproduced or independently visually certified here.

Fresh inspection of source notebooks/data confirmed:

- pyprobml heteroskedastic notebook SHA256 `1e685b9e50518ab79a7448d6bfdcc27803596ae58a7ab1de9e1fbee7aeef37a6`: TensorFlow/TFP, 1,000 inputs, larger backbone/heads, two 500-epoch fits; its softplus constant is inside the function. The 320/160-row, one-32-unit PyTorch model is a course adaptation, not executed evidence.
- Instructor `vae.ipynb` SHA256 `f99265bf611aed7698ee16be356ef6880815d1367a1a684d33897adef38d9c07`, CSV SHA256 `05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6`: 349 rows, 57 columns; all 19 selected entries numeric/finite with no missing values. Source has all-row scaler fitting, 300 Adam epochs, separate feature/latent averaging, unweighted averaging of training batch means, descriptive 0.1 “active” threshold, and scaler-only inversion after log/share transformations. Source prior draws are decoded means, not full Gaussian observation draws. None is a validated course output.
- Source means give `β_course=(19/4)β_source`, so source β4 corresponds to course β19 up to the fixed reconstruction constant. Its saved outputs/checkpoints cannot be renamed course β4. Source fits and runtime were not rerun.
- The narrowed-digit fallback source SHA256 `6ab2c4d9cf0c2dec6e475e073575899bc1ff856d09988ca87c8a654767e39bf0` uses full MNIST downloads, convolutional networks and multiple model/visualization paths. It is an alternative requiring new scope/feasibility review, not a ready replacement. No prior instructor acceptance of a dataset substitution was recovered.

The instructor assignment `CEE790A-PS4.tex`, SHA256 `d89b8956b1d7e1d223df62a42c127ea3f6513bc6a0ec6f39ec92ddff310ecdba`, explicitly cites the Zhao/Oke paper DOI. The [authors' lab page](https://narslab.org/papers/zhao-typology-us-metropolitan/) identifies the 349-MSA research context. The [publisher full text available through ResearchGate](https://www.researchgate.net/publication/394021207_Typology_of_US_metropolitan_areas_illuminates_per-capita_mobile_greenhouse_gas_emissions_impacts_and_informs_mitigation_strategies) names the public research repository in its data-availability statement. The IOP direct page was denied by its robots policy; no claim about unpublished supplementary rights is inferred from that failed fetch.

Read the [primary research repository](https://github.com/narslab/mobile-emissions-typology) and its GitHub API records on 2026-10-14. At commit `049cb033a9814c0ec3df99ece5144d07688aa648`, [`data/tidy/raw-data-cluster.csv`](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/data/tidy/raw-data-cluster.csv), Git blob `2b0eb4f96c1c0bb882e1cdf52de95a5bd444d173`, is **byte-identical** to the instructor CSV above. This is stronger than matching counts or selected values. It provides a concrete versioned download route; no CSV was copied into the course repository.

The [`LICENSE`](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/LICENSE), blob `ada66575b0133cea3e85deebc7dbecca14bf1e24`, is MIT, copyright 2024 Peiyao Zhao. Its grant is phrased for software and associated documentation. The README identifies underlying OSM and governmental data sources. Record license/attribution and any source-specific obligations for the particular distributed derivative; do not equate an MIT software file or the article's open-access license with an independently verified license for every upstream dataset. The new exact-match public access evidence should replace “portable source not found” in later readiness records while preserving the old reviews as historical evidence. The teaching assignment's generic claim that increasing β remedies blurry samples is not a theorem; the course correctly evaluates the actual fitted tradeoff.

## Issues, smallest repairs and decision ownership

1. **Coordinator/Lecture Scope; blocking for declaring current L11 reconciled, advisory for assessment work — recover the funded composition/two-role choice.** Evidence: current L11 lacks the explicit graph/inference-role obligations in recovered blob `380d611…`; independent source/constructibility reviews support that repair and reject the need for broad architecture additions. **Minimum repair:** offer the existing five-minute exchange for acceptance; if selected, revise only affected L11 arc/spine/contract fields and recheck against current upstream revisions. **Consequence:** lose SGD-shrinkage/adaptive-penalty equivalence depth, retain complete Gaussian/prior/noise mathematics and one lab. Provisional assessment can continue without silently reinstating it.

2. **Coordinator/Lecture Scope; blocking for scope/map alignment — L11 simpler-function baseline.** Evidence: current map asks for fixed-scale and simpler-function baselines, while scope supplies only a nonlinear fixed-scale fit. **Minimum repair:** recommend one prepared affine-Gaussian fit/score on the same split, preserving one student fit; alternatively explicitly narrow the map to the scale-only contrast. **Consequence:** the former allows students to judge what nonlinear mean flexibility buys; the latter yields narrower practical competence. A prepared score adds interpretation work and requires a funded scope commitment; author validation is not an instructor mathematics question.

3. **Coordinator/Lecture Scope; blocking for scope/map alignment — L12 prior generation is currently removable.** Evidence: scope Part 3 puts prior-versus-reconstruction into an optional five-minute slot, cuts it first, and excludes full observation draws; architecture/map explicitly promise prior-generated cases. Older independent reviews accepted the older, narrower contract. **Minimum repair:** recommend replace the optional traversal with a required supplied display comparing reconstructions and prior-generated cases, including decoder noise when displaying observation samples. Preserve the same driver/checkpoints; remove the optional traversal rather than add another fit. **Consequence:** protects actual generative-model use; does not promise physically realistic MSAs. Instructor accepts that practical endpoint or explicitly reopens the map's generative promise.

4. **Coordinator/Lecture Scope; advisory — mobility is a defensible descriptive exemplar, not evidence that amortization or nonlinear representation is necessary at this scale.** Evidence: 349 preprocessed 19-feature cases; compact model has 1,691 parameters before choosing split. Gaussian likelihood ignores raw support/compositional constraints; β comparison addresses one model's tradeoff, not superiority to a simpler model. **Minimum repair:** retain it provisionally with explicit held-out scoring, standardized-space/support limitations and repeated-query cost explanation. A supplied linear representation comparison is an option, not a prerequisite or a new student fit. **Consequence:** realistic urban context and critique of a generative model, with no emissions-policy/causal-factor claim. Mixed likelihoods or a different dataset would be substantive replacement choices.

5. **Worked-solution/notebook owners; downstream-owned, high practical priority — CPU and hour remain unverified.** L11 has 12 minutes for local checks/run and 10 reserve; L12 has 12 for run/summaries and only five reserve. Models of approximately 130 and 1,691 parameters make CPU computation plausible, but count is not timing or training-quality evidence. **Minimum repair:** checked drivers, separate validated baselines/β1–β4 checkpoints, local finite-noise gradient checks, appropriate loss reductions, train-only preprocessing and clear fallback interpretation after bounded student updates. Validate local uv, fresh hosted Colab and the fine-grained student question sequence. **Consequence:** no second full student fit, no new API/data preparation burden, no statement of student convergence. Return workload pressure to Scope if the core still fails the hour.

6. **Publication/data owner; downstream-owned — portable access is now evidenced, final packaging attribution remains.** Evidence: exact public match and versioned URL, MIT repository license plus mixed original sources. **Minimum repair:** document data provenance/permissions/attribution for the chosen delivery, package or fetch the pinned CSV, check hosted access; do not fall back prematurely because old reviews found only local access. **Consequence:** the mobility choice need not be replaced on unsupported access assumptions. A genuine rights/access failure returns the narrowed fallback to Scope; no automatic substitution.

7. **Coordinator/Lecture Scope; advisory — protect cross-lecture mathematical ownership and time.** Evidence: L12 depends on L04 MI, L06 ELBO, L09 total Gaussian pathwise derivatives/correct KL and L11 neural likelihood/AD practice. Both lectures budget 112 live minutes and are unmeasured. **Minimum repair:** retain those upstream endpoints as current choices are reconsidered; qualify historical 70-page/61-slide calibration as an older artifact, and rely on later explanatory extent/rehearsal. **Consequence:** no additional generic ELBO/backprop/sample proof in L12, no obligation that L10 teach HMC to enable it, and no core material silently moved to recordings or L13.

## Recommended disposition to the coordinator

Keep the synthetic conditional-regression and mobility VAE proposals as the working candidates. The most useful late-course pedagogical choice is to preserve the recovered **composed function → probability model or inference map** bridge, paying for it with optimizer mechanics rather than weakening the probabilistic worked example. Its substantive alternative is retain the current narrower regression argument and let L12 introduce inference networks; a survey/BNN expansion is a larger replacement with no demonstrated feasibility benefit. This late-course choice need not precede earlier decisions about L04 performance practice or the shared L07/L09/L10 task.

Treat the affine comparator and required generation display as distinct pending practical-endpoint repairs. Do not roll them into a blanket approval of all nine lectures. Formula correctness, versioned dataset access, objective normalization, runtime checks and fairness of prepared comparisons remain author/reviewer work. The instructor chooses what practical capability and mathematical emphasis the course should deliver.

**Validation limits:** read-only source/code/CSV/Git/API checks and elementary static mathematics; no model training, notebook execution, uv/Colab validation, section construction, generated assets or student timing. This independent assessment was briefed with current scopes/review evidence and does not claim a cold source-first reconstruction before all proposal exposure. Raw earlier independent reviews remain accessible by their exact Git commit/blob records; this report complements them without rewriting their verdicts or approval provenance.
