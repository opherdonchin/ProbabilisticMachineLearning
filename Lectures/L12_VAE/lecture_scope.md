# L12 — Learning a small hidden description of each observation

**Status:** Rewritten for an instructor familiar with the course through L03–L04. The [course register](../course_architecture_scope/STATUS.md) records the exact current review and instructor-decision status. Lecture times are estimates; future notebooks have not been implemented or run.

Suppose we have 19 measurements describing each metropolitan area and want a small learned description that can approximately reconstruct them. The description is not observed. A probability model can draw a four-number hidden description and use a network to predict the 19 measurements from it. For an existing observation, another network estimates which hidden descriptions could have produced it.

This pair is a **variational autoencoder (VAE)**. The **decoder** maps a hidden description to an observation distribution. The **encoder** maps an observed case to an approximate distribution over its hidden description. We train them together, balancing reconstruction quality against a penalty that keeps encoded distributions close to a chosen prior. We then ask what a useful-looking hidden description actually tells us about the data.

**What earlier lectures supply:** L01/L02 supply Gaussian/distribution background. L04 supplies information shared between variables and directed distribution discrepancy, but defers reconstruction-versus-information tradeoffs. L06 derives the lower-bound identity. L09 derives differentiable Gaussian sampling and the diagonal Normal discrepancy formula. L11 supplies nonlinear probability outputs, Gaussian likelihood scoring and PyTorch. L12 applies those results rather than repeating three proofs. It adds shared inference for individual cases, encoder/decoder training and the interpretation of the penalty. Neither advanced sampling nor Bayesian network-weight inference is required. These future lectures are still proposals, not delivered coverage; protected L01/L02 and the ledger remain unchanged.

**Choice and cost:** Use the instructor's inspected mobility data: 349 metropolitan areas and 19 selected complete numeric features. This is small, already uses PyTorch, and supports descriptive comparisons of urban measurements. Supply preprocessing and a compact model to protect the hour. The Gaussian model is an approximation for raw bounded values and compositional shares; it does not discover identified scientific or causal factors.

If data access or redistribution cannot be settled, a narrowed handwritten-digit example is the fallback. Its inspected source is much larger, with convolutional models and several variants, so it must be reduced and reviewed rather than silently substituted. An alternative lecture centered on many information penalties would displace the concrete learning task. Teach the one penalty's information decomposition and cautious diagnostics, without an objective catalogue.

<details>
<summary>Source verification and original build record for later authors</summary>

The material below records exactly which sources were inspected. B1 and B2 mean Murphy's first and second books. Section and equation numbers identify source passages; they do not require familiarity with the surrounding chapters. These notes are for checking the later teaching material, rather than for understanding this proposal.

**Stage/mode:** Lecture Scope / BUILD. **Builder thread:** `/root/build_l03`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; input HEAD `b4f771c586e4ada258406631e48bb5c6b68671cd`. **Contract:** architecture v3, blob `54064183398bd643a895c5e38a023f793dc2d9d6`; autonomous authority in `WORK_ORDER.md`. Only this scope is owned; no slides, sections, notebook implementation, data copying or shared edits.

**Direct B2 inspection:** December 10, 2025 online edition, local PDF/extraction identified in architecture/source register; `/tmp/pml-book2.txt` §§21.1, 21.2.1–21.2.4 (printed pp. 791–796), §21.3.1/§21.3.1.1 (pp. 797–798), §21.4 introduction/§21.4.1 (pp. 806–807), other §21.4 methods inspected to delimit omissions; §5.4.2 (pp. 248–249). B1 introduces no additional required mathematics. Use corrected signs/constants from L09 rather than faulty B2 Eqs. 10.49–10.50. Explicitly use log **variance** below: source Eq. 21.7/nearby prose ambiguously labels its exponentiated coordinate. Do not inherit the claim that restricted amortized ELBO optimization guarantees a locally optimal MLE; nonconvex optimization and variational gaps remain.

**Actual mobility source inspected:** instructor-provided `spring-2026/PS4/PS4-Questions/vae.ipynb` and `mobile-msa.csv` under the local Oke teaching directory specified in the work order. Notebook SHA-256 `f99265bf611aed7698ee16be356ef6880815d1367a1a684d33897adef38d9c07`; CSV `05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6`. Source has 349 metropolitan areas, 57 CSV columns, **19 selected complete numeric features** (checked all 349 rows), four latent dimensions, two 64-unit hidden layers per network and 300 Adam epochs. Features cover street/mobility measures, economic/employment measures, density/built area and climate. Names/Cluster are not model inputs. Imports: pandas, NumPy, Matplotlib, PyTorch, scikit-learn. No runtime, provenance license or redistribution permission was validated.

Important adaptation: source fits the scaler on all rows, separately averages MSE over 19 features and KL over four latents, and labels scaler-inverted plots as original units despite earlier log/fraction transforms. Course uses a supplied train/held-out split, train-fitted scaling, coherent event-summed losses and explicitly transformed/standardized plotting units. No original-unit claim without a complete inverse transformation. Source decoder outputs are means, not complete Gaussian observation samples. Its latent correlations/0.1-KL “active” threshold are descriptive heuristics, not identified factors or a universal collapse criterion.

**Original upstream version references:** L04 supplies MI/KL but defers rate-distortion. L06 blob `326267281c6b6775ac9a33d7ed4f022a859fc49b`; L09 blob `b6b98a1a0027e710c18aa596b79ac04ef7af248f`; L11 blob `0c564a7e5b1fd308282ab2ea6488927a44bc890a`.

</details>

## 1. Intellectual arc — what the lecture explains, in order

These are the lecture's main jobs, rather than final section boundaries. Later section design can split or combine them without changing the promised mathematics, outcomes or time. Explain necessary connections at the start of the receiving section. End every section with a summary of what it has taught. Notebook instructions remain a separate item. All required material is taught live; no recording is a prerequisite.

### A. Separate generating an observation from explaining an observed case — 18 minutes

Start with a hidden vector `z~N(0,I)` drawn from the prior, then a decoder likelihood `p_θ(x|z)` for the observation. The model's observation distribution averages over z. For an existing observation x, define the encoder distribution `q_φ(z|x)` to approximate the model's posterior over z.

The encoder is a computational helper, not another probability factor in the generative model. It returns a mean and log variance for each observation. Instead of optimizing a fresh distribution for every case as in L09, one shared network supplies its parameters. This shared inference is called **amortization**.

Distinguish reconstruction, which starts with a given x and draws z from its encoder, from generation, which starts with a prior draw. Distinguish decoder means from random observations: a full generated observation also includes decoder noise. A brief comparison with a **deterministic autoencoder**, which uses one fixed code and reconstruction rather than distributions, is optional. Do not train it or survey architectures.

**End summary:** The decoder defines the probability model; the encoder approximates per-case inference using a shared function. Reconstruction and prior generation start from different distributions.

### B. Define the reconstruction score and penalty in consistent units — 25 minutes

Apply L06/L09's **evidence lower bound (ELBO)** and L11's Gaussian **negative log likelihood (NLL)** to one 19-feature observation. Fix the decoder covariance at `τ²I`, with **τ²=1/2**, in standardized coordinates. Its NLL is the sum of squared feature residuals plus the constant `(d/2)log π`; it is not mean feature squared error.

The encoder-to-prior **Kullback–Leibler divergence (KL)** sums over its four latent coordinates. Sum each type of coordinate within an observation, then average observations across the batch. This keeps the relative weighting explicit. The coefficient **β** multiplies the KL penalty. At β=1 the minimized loss is negative ELBO; other β values change the objective.

Work the source-to-course normalization example in Part 4. The source separately averages feature errors and latent-coordinate KL, so the same written β does not mean the same tradeoff. Keep decoder variance fixed rather than change reconstruction units by learning it. Removing KL alone does not make a random encoder deterministic.

**End summary:** A specified likelihood fixes reconstruction units, and a specified divergence fixes penalty units. Coordinate sums followed by case averaging give β a consistent meaning.

### C. Train both networks through the random hidden draw — 22 minutes

Reuse L09's independent Gaussian noise and differentiable sample transform. If the encoder outputs mean μ and log variance ℓ, use `z=μ+exp(ℓ/2)⊙ε`. The half is necessary because sampling uses standard deviation, not variance.

Apply the already derived total sample derivative. Reconstruction derivatives update decoder parameters directly and encoder parameters through z. The analytic KL adds encoder derivatives. Keep both encoder mean and variance connected to the loss; do not detach the sampled hidden vector. Network weights are fitted points, while each case's z is random.

Under L09's regularity conditions, one reconstruction draw plus exact KL is an unbiased estimate of the selected per-case objective. Noisy SGD does not guarantee improvement at every step. Software/model skeletons are supplied rather than introducing a second backpropagation course.

Explain three possible limitations plainly: the chosen approximate distribution may be too restrictive; fitting may be unfinished; one shared encoder may be less flexible than optimizing every case separately. Recognize these without deriving three additional gap identities.

**End summary:** Differentiable sampling connects the two fitted networks. One loss updates both while keeping random hidden values distinct from point-estimated weights.

### D. Explain what the penalty says about information — 23 minutes

Let **distortion D** mean expected reconstruction NLL: how poorly the decoder predicts an observation when its hidden code is drawn from that observation's encoder. Let **rate R** mean average encoder-to-prior KL. These are names for the two terms we trade off, not claims about actual file compression.

Average all observation-specific encoder distributions to obtain the **aggregate** encoded distribution `q_φ(z)`. Derive that R equals two nonnegative parts: the information shared between observations and their hidden codes, plus the divergence between the aggregate distribution and the prior. The shared-information term is **mutual information (MI)** from L04.

Consequently R bounds that information from above but is not generally equal to it. Work the shifted-Normal example in Part 4: every observation uses the same code distribution, so the code contains no input information, yet R is positive because the aggregate differs from the prior.

Interpret `D+βR` as a reconstruction/penalty tradeoff within the chosen model family. It is not the Shannon-optimal rate–distortion curve from information theory, and we do not implement a file codec. Noisy finite fits need not lie on a monotone optimal frontier. Do not add a mutual-information estimator or numerical aggregate-mixture KL calculation to the lab.

**End summary:** The average KL pays for both input information and prior mismatch. Changing β trades this quantity against reconstruction score, without identifying an exact information content or optimal code.

### E. Check whether the model uses its hidden description — 12 minutes

In the ideal **posterior collapse** case the decoder ignores z. The model's posterior then equals the prior, and the encoder can use that same prior for every observation: its rate and input information are zero.

In a fitted model, inspect KL contributions by latent coordinate, how encoder outputs vary across inputs, and whether changing z changes the decoder, alongside reconstruction quality. Small KL alone can also reflect unfinished fitting; it is not a universal collapse test. Mention slowly increasing the KL weight during training, called **KL annealing**, as a possible repair, without implementing a second schedule or promising a cure.

Correlations between hidden coordinates and measured features, and plots changing one hidden coordinate, describe this fit. They do not establish unique or causal factors. Coordinate signs and order can change without changing the model; a worked sign-flip example is optional. More general **nonidentifiability** means multiple different hidden descriptions can explain the same observations.

**End summary:** A model can stop using its code, and useful-looking coordinates need not be unique or causal. Diagnose behavior and interpret patterns within the model and fitting limits.

### Time estimate and what to shorten first

The estimate is **100 substantive plus 12 reserve =112 live minutes**, with a separate 60-minute lab. It is tight and unmeasured, with medium-low confidence. The new chain connects model/inference roles, a consistently scaled joint objective, and information/diagnostic interpretation. Earlier bound, Gaussian likelihood, sample-derivative and network proofs are reused.

First remove the optional deterministic-autoencoder comparison and worked sign-flip illustration, saving about five minutes for roughly 107 live minutes. Keep their basic role/identification cautions, objective normalization, joint-gradient roles and the fact that rate is not identical to mutual information. Do not silently move core material to recording.

For later authors, `K=5`, `P≈9–12`, `E_new≈11–14`, `E_carry≈16–24`, `E_deriv≈7–11`, `V≈6–8` count main parts, substantive pages, new equation families, repeated support, algebra blocks and visual groups. The rough model predicts 22–28 content-slide equivalents; this is not a target or measured VAE teaching rate. L01's 61-slide judgment is only an anchor. Recheck actual explanations when designing sections.

## 2. Mathematical spine — the results students will use

Use θ for decoder weights, φ for encoder weights, and z for the random four-coordinate hidden description. The 19 observed coordinates and four hidden coordinates are different dimensions: `d=19`, `k=4`. `ℓ=log s²` is encoder log **variance**, while τ² is fixed decoder observation variance. The term “event axes” below means the coordinates belonging to one observation or one hidden vector, which we sum before averaging cases.

`p_D` gives each observed case equal weight, so the aggregate q is the average of its per-case encoder distributions. D and R are expected reconstruction score and average KL respectively. Natural logarithms give nats; dividing by `log 2` gives bits, but no literal codelength is claimed. The rate identity needs finite, support-compatible integrable terms. It does not require taking KL between discrete empirical observations and a continuous observation density.

The Gaussian model lives in preprocessed, standardized coordinates. It does not exactly respect all raw count/percentage supports. The standard Normal KL and sample transform use the corrected expressions from L09, rather than the book's sign/constant errors. Restricted shared-inference fitting and nonconvex optimization do not guarantee exact maximum likelihood; the table's MLE abbreviation means maximum likelihood estimate.

In the table, **Derive** means work through the calculation; **Work** means carry out an example; **State** means give the result without proving it; **Apply** means use a result established earlier. These depths are unchanged by the wording revision.

| Object/result | Depth, delivery and role |
|---|---|
| `p_theta(x,z)=N(z\|0,I) N(x\|d_theta(z),tau² I)`; `p_theta(x)=integral p_theta(x,z)dz` | **State/Motivate**, Live A. Likelihood in preprocessed standardized coordinates; not an exact support-respecting model for all raw percentages/counts. |
| `q_phi(z\|x)=N(mu_phi(x),diag(exp ell_phi(x)))` | **State + Work shapes**, Live A/C; amortized rather than one freely optimized q per row. |
| `F(x)=E_q log p_theta(x\|z)−KL(q_phi(z\|x)\|\|p(z))` | **Apply**, Live B; generic identity L06-owned. Restricted q/nonconvex training does not guarantee exact MLE. |
| `−log p_theta(x\|z)=\|\|x−d_theta(z)\|\|²/(2tau²)+(d/2)log(2pi tau²)` | **Apply/Work**, Live B; L11-owned Gaussian NLL. At tau²=1/2 coefficient is one. |
| `r(x)=(1/2)sum_j[mu_j²+exp ell_j−1−ell_j]`; `L_beta=batch mean_n[E reconstruction NLL+beta r(x_n)]` | **Apply + Work**, Live B. Sum latent and observed event dimensions separately, then average observations; beta=1 standard negative ELBO. |
| `z=mu_phi(x)+exp(ell_phi(x)/2)⊙epsilon`, `epsilon~N(0,I)` | **Apply**, Live C; L09-owned derivation/interchange conditions. No fresh change-of-variables proof. |
| Reconstruction gradient to theta; chain through z to phi; `partial r/partial mu=mu`, `partial r/partial ell=(exp ell−1)/2` | **Work bounded application**, Live C; no full network reverse traversal. Keep gradients through both encoder mean and variance. |
| `D=E_pD E_q[-log p_theta(X\|Z)]`; `R=E_pD KL(q_phi(Z\|X)\|\|p(Z))` | **State/Interpret**, Live D. Nats under natural logs; divide by log2 for bits, without literal codelength claims. |
| `q_phi(z)=E_pD q_phi(z\|X)`; `R=I_q(X;Z)+KL(q_phi(Z)\|\|p(Z))≥I_q(X;Z)` | **Derive**, Live D; insert aggregate mixture into the density ratio. Finite/support-integrable quantities assumed; no KL between empirical point masses and continuous data densities is required. |
| Collapse: `p_theta(x\|z)=p_theta(x)` implies `p_theta(z\|x)=p(z)`; q=p for all x gives R=I=0 | **Work/Explain**, Live E. Near-zero fitted rates are diagnostics, not an automatic theorem about decoder use. |
| Latent sign/permutation reparameterization | **State**, optional **Work**, Live E; preserves isotropic prior and diagonal family. General nonidentifiability **State**, no proof of nonlinear impossibility theorem. |

## 3. Notebook handoff — what students do and what is supplied

**Student endpoint:** Complete a correctly scaled sampled loss, perform one bounded joint-training run, then interpret reconstruction, KL and supplied β comparisons. Use the instructor's inspected mobility notebook/data as the anchor. The smaller course model has `19→32` encoder hidden features, four means/four log variances, and a `4→32→19` decoder producing unconstrained observation means. This reduction from the source's two 64-unit layers has not yet been timed.

**Supplied:** feature transformations, fixed training/held-out indices, training-only standardization, batched CPU data, model skeleton, optimizer/driver, seeds/settings, plots and estimator helpers. Preserve data masks and row mapping. External Cluster labels neither enter the loss nor validate recovered scientific factors. **Students complete:** the Gaussian sample transform and event-summed reconstruction/KL loss, value/gradient checks, and interpretation. Reuse L11 output assembly and L09 sampling, with refresh time included.

Run one β=1 fit through the bounded driver. Prepare consistently normalized β=1 and β=4 checkpoints/summaries for comparison if multiple fits exceed time. These must be produced and verified later; the source's β=4 checkpoints cannot be renamed course β=4. Do not add a convolutional model, learned decoder variance, a second full student fit or extensive coordinate-traversal suites.

The 60-minute budget is: 10 minutes PyTorch/shapes/sample/data-split refresh; 15 assembling/checking the coordinate-summed objective; 12 one driver run and held-out reconstruction/rate summaries; 13 supplied β comparison, per-coordinate rate and one hidden-coordinate/feature plot; 5 a provided decoder-mean traversal or prior-versus-reconstruction comparison; 5 reserve.

For held-out and prepared-β scores, the supplied helper estimates D by drawing z from `q_φ(z|x)` and averaging the **feature-summed Gaussian NLL**, with the same fixed variance and likelihood-constant convention. Combine batch averages weighted by their numbers of observations. Decoding only at the encoder mean can make an illustrative reconstruction, but is not this expected D. This helper adds no new student task, fit or time allocation.

If training is slow, use a verified prepared checkpoint for interpretation after students perform and check bounded updates; do not call their short run converged. The first lab cut is the extra traversal/comparison, preserving objective checks and β/rate interpretation. Decoder profiles are means; sampling a full observation would add Gaussian noise and is not required. Label plots in transformed/standardized units unless a complete inverse transformation is supplied.

**Data and publication checks:** Instructor-local access does not establish redistribution permission or portable access. Resolve both before publication; this scope copies no data. Later worked-solution authoring must check cleaning/splits, objectives/gradients, checkpoint normalization, model behavior, student timing, clean local uv execution and hosted Colab. If permission fails, return the narrowed handwritten-digit fallback to Scope review rather than silently change datasets.

## 4. Concrete examples and their sources

The numerical examples make three distinctions concrete: summing versus averaging coordinates changes β's meaning; a positive KL penalty need not mean the code retains input information; and changing a code coordinate's sign need not change the model. The mobility application then supports descriptive patterns rather than claims of discovered causal urban factors. “Rate” is average encoder-to-prior KL; “distortion” is expected likelihood-based reconstruction cost. A “latent” is an unobserved quantity, here the four-number code.

**Event sums and beta, Work/Live B.** Course-constructed one-row check: four-dimensional encoder mean `(1,0,0,0)`, all log variances zero, so rate `r=1/2`; a realized reconstruction residual has first two entries `(1,−2)` and other 17 entries zero, squared norm 5. At tau²=1/2 NLL is `5+(19/2)log pi≈15.874934`. One-sample loss is approximately 16.374934 at beta=1 and 17.874934 at beta=4; expected reconstruction is not asserted from this single draw. Arithmetic checked. The source array means instead give `5/19+beta_source*(1/2)/4`; multiplying by 19 makes its beta_source=4 equivalent to **course beta=19**, up to the fixed likelihood constant. Same numbers do not imply same fit.

**Rate is not MI, Work/Live D.** Course-constructed two equally likely input labels, with identical `q(z|x)=N(1,1)` for both and prior `N(0,1)`. Then aggregate q is `N(1,1)`, `I(X;Z)=0` and `R=1/2`, entirely aggregate-to-prior mismatch. Changing every q to the prior makes both zero. This finite-input/continuous-code example verifies the decomposition without a differential entropy for empirical inputs.

**Mobility patterns, Brief Live / Work Notebook.** Actual 349×19 selected data are source-inspected; no correlation values, active dimensions, reconstruction quality or causal interpretation is promised. Provided held-out scores and latent plots must be labeled fitted descriptive patterns. Exclude unsupported “discovered urban factors” or identified disentanglement claims.

**Coordinate ambiguity, optional Work/Live E.** Flip the first latent coordinate, change encoder mean's corresponding sign and compose the decoder with the inverse sign flip. The isotropic prior and diagonal posterior family are preserved, with equivalent observation distributions/objective. This course-constructed demonstration supports the caution; it is not a proof of the full source nonidentifiability theorem.

About 6–8 conceptual visual groups support model/inference roles, per-case versus shared parameters, event-axis scaling, joint-gradient paths, rate decomposition, and collapse/descriptive diagnostics. Source Figs. 21.1/21.4 are explanatory context, not required reproduced assets. No figures are generated.

## 5. Lecture contract — what this proposal commits to

**Starting knowledge:** Probability/information, L06's lower-bound identity, L09's Gaussian approximation and differentiable sampling, and L11's nonlinear Gaussian model/PyTorch. No advanced sampler or Bayesian network-weight inference is assumed.

**Main question:** How do two networks learn an unobserved description of each case, and what can we honestly infer from that description? **Lecture endpoint:** distinguish model from inference, assemble the scaled loss and its derivative paths, derive rate = mutual information + aggregate-prior discrepancy, and diagnose unused or ambiguous codes cautiously. **Notebook endpoint:** one checked compact mobility workflow and supplied β comparison with descriptive interpretation. The estimate is 112 live minutes plus 60 lab minutes, with no required recording.

Core sources are selected B2 §§21.1–21.2, §21.3.1, §5.4.2 and §21.4. Earlier lectures own the generic bound, Gaussian scoring and full sample-derivative proofs. Supported outcomes are role/loss/gradient distinctions, the rate identity and honest diagnostics. There is no promise of optimal compression, identified scientific factors or validated synthetic metropolitan-area generation.

**What is left out, and the lost capability:** Students do not compare many alternative information penalties or prove a supervised information-bottleneck objective. They do not build specialist VAEs for mixed data types, multiple modalities, sequences, hierarchies or discrete codebooks. They do not add importance-weighted objectives, more flexible distribution transforms, adversarial or kernel-matching losses, or several training repairs/full fits. They do not prove a general identification theorem. These extensions are not a debt transferred to the L13 project meeting.

**Choices and risks:** The provisional final application uses standardized Gaussian mobility measurements and descriptive code patterns. Raw bounded/compositional variables are only approximately modeled; support-aware likelihoods would require substantial extra teaching. Data redistribution remains unverified; access alone is insufficient. Fresh normalized checkpoints and a timed bounded CPU driver are necessary—source epochs or plots are not runtime evidence. Objective units and the rate decomposition are essential: apply optional cuts before weakening them.

**Record updates:** Narrow broad §§21.3–21.4 promises to these selected results and diagnostic limits, recording future allocations separately from delivered coverage. Neither a small loss nor a visually plausible code supplies a scientific interpretation.

<details>
<summary>Exact source allocation for checking the syllabus and material ledger</summary>

This table preserves the reviewed source boundaries. The plain-language explanation above states what the omissions mean for students. A method named as omitted is not promised elsewhere unless a receiving lecture is explicitly named.

| Allocation | Commitment / boundary |
|---|---|
| **Core/Live deep** | B2 §§21.1–21.2 model/amortization/joint objective; §21.3.1 beta tradeoff; §5.4.2 plus aggregate posterior definition for rate decomposition; §21.4 collapse diagnosis. Selective content, not all subsections. |
| **Short bridges** | Correct Normal KL/pathwise machinery L09, Gaussian NLL/MLP L11, generic ELBO L06; §21.3.1.1 identification caution; §21.4.1 annealing Mention only. |
| **Notebook owned** | Refresh, loss assembly/checks, one bounded fit, held-out reconstruction/rate and supplied beta/pattern comparison. |
| **Optional** | Deterministic-AE comparison, sign-flip illustration, extra traversals. No formal-syllabus promise. |
| **Omitted by course decision** | Full supervised IB/InfoVAE/total-correlation derivations, MMD/adversarial objectives, multimodal/semisupervised/sequential/hierarchical/VQ VAEs, IWAE/flows, free-bits/schedule implementation, identifiability theorem proof, learned mixed-type likelihood catalogue and multiple full lab fits. No debt passed to project meeting L13. |

</details>

**Next owner:** The instructor reviews the proposal's choices and explanations. Detailed section design follows acceptance. If later writing or rehearsal cannot meet the stated commitments, return the affected choice to Lecture Scope. The [registry](../course_architecture_scope/STATUS.md) holds review evidence. This document does not establish notebook runtime, Colab readiness or measured teaching time.
