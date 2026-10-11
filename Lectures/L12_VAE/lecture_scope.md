# L12 — VAEs: learned latent models, compression and representation limits

**Status:** Reviewed five-part scope proposal; [current agent approval and exact reviews](../course_architecture_scope/STATUS.md) are maintained by the coordinator. Instructor acceptance pending; timing and notebook implementation remain unvalidated. **Stage/mode:** Lecture Scope / BUILD. **Builder thread:** `/root/build_l03`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; input HEAD `b4f771c586e4ada258406631e48bb5c6b68671cd`. **Contract:** architecture v3, blob `54064183398bd643a895c5e38a023f793dc2d9d6`; autonomous authority in `WORK_ORDER.md`. Only this scope is owned; no slides, sections, notebook implementation, data copying or shared edits.

## Starting boundary, direct sources and alternatives

Protected L01/L02 and the ledger remain unchanged: delivered Gaussian conditioning/LGS plus the agreed, undelivered EF/moment-matching boundary. L04 supplies MI/KL but defers rate-distortion. L06 blob `326267281c6b6775ac9a33d7ed4f022a859fc49b` owns the generic ELBO/KL proof. Revised L09 blob `b6b98a1a0027e710c18aa596b79ac04ef7af248f` owns the total Gaussian pathwise gradient, diagonal Normal KL and optimization/family distinction; it only recognizes amortization. Complete L11 blob `0c564a7e5b1fd308282ab2ea6488927a44bc890a` supplies MLP construction, probability-output heads, Gaussian NLL and PyTorch practice. L12 applies those results, **not three repeated derivations**. It adds per-case latent inference, shared encoder/decoder learning and the information-rate interpretation. No HMC theory or Bayesian neural-weight inference is prerequisite. Future scopes are proposals, not delivered coverage.

**Direct B2 inspection:** December 10, 2025 online edition, local PDF/extraction identified in architecture/source register; `/tmp/pml-book2.txt` §§21.1, 21.2.1–21.2.4 (printed pp. 791–796), §21.3.1/§21.3.1.1 (pp. 797–798), §21.4 introduction/§21.4.1 (pp. 806–807), other §21.4 methods inspected to delimit omissions; §5.4.2 (pp. 248–249). B1 introduces no additional required mathematics. Use corrected signs/constants from L09 rather than faulty B2 Eqs. 10.49–10.50. Explicitly use log **variance** below: source Eq. 21.7/nearby prose ambiguously labels its exponentiated coordinate. Do not inherit the claim that restricted amortized ELBO optimization guarantees a locally optimal MLE; nonconvex optimization and variational gaps remain.

**Actual mobility source inspected:** instructor-provided `spring-2026/PS4/PS4-Questions/vae.ipynb` and `mobile-msa.csv` under the local Oke teaching directory specified in the work order. Notebook SHA-256 `f99265bf611aed7698ee16be356ef6880815d1367a1a684d33897adef38d9c07`; CSV `05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6`. Source has 349 metropolitan areas, 57 CSV columns, **19 selected complete numeric features** (checked all 349 rows), four latent dimensions, two 64-unit hidden layers per network and 300 Adam epochs. Features cover street/mobility measures, economic/employment measures, density/built area and climate. Names/Cluster are not model inputs. Imports: pandas, NumPy, Matplotlib, PyTorch, scikit-learn. No runtime, provenance license or redistribution permission was validated.

Important adaptation: source fits the scaler on all rows, separately averages MSE over 19 features and KL over four latents, and labels scaler-inverted plots as original units despite earlier log/fraction transforms. Course uses a supplied train/held-out split, train-fitted scaling, coherent event-summed losses and explicitly transformed/standardized plotting units. No original-unit claim without a complete inverse transformation. Source decoder outputs are means, not complete Gaussian observation samples. Its latent correlations/0.1-KL “active” threshold are descriptive heuristics, not identified factors or a universal collapse criterion.

| Route | Endpoint / tradeoff | Provisional disposition |
|---|---|---|
| **Compact mobility VAE** | Apply stochastic encoder/decoder and compare distortion/rate on the inspected tabular data | Selected: already PyTorch, small data and meaningful descriptive patterns; supplied preprocessing/model scaffold bounds the hour. |
| Compact MNIST VAE | Recognizable reconstruction/generation with image plots | Fallback if mobility use/redistribution cannot be cleared. Inspected pyprobml `misc/vae_mnist_pytorch.ipynb`, checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, SHA-256 `6ab2c4d9cf0c2dec6e475e073575899bc1ff856d09988ca87c8a654767e39bf0`: resized images, convolutional models, deterministic/stochastic variants and extensive plotting. Needs substantial reduction; not a second lab or validated turnkey fallback. |
| Information-first objective catalogue | IB/InfoVAE/total correlation and several regularizers | Would displace the concrete VAE learning endpoint. Derive rate decomposition and diagnose collapse only; omit the catalogue. |

## 1. Intellectual arc

Provisional conceptual macrosegments, not section boundaries. Downstream may split/combine while preserving depth, endpoints and budget. Transitions begin receiving segments; every resulting section closes retrospectively. All core content is **Live**; no required recording.

### A. A generative decoder and an inference encoder have different jobs — 18 minutes

**Transition in:** L11's MLP predicted distribution parameters from known inputs; L09 fitted a posterior for one fixed dataset. Now a latent input is unobserved and each new case needs posterior inference.

**Purpose/sources:** B2 §§21.1, 21.2.1, selected §21.2.3; identify model versus inference roles.

**Core:** Define `z~N(0,I)` and decoder likelihood `p_theta(x|z)`, hence a marginal by integrating z. Define `q_phi(z|x)` as an approximation to the model's posterior; its encoder is not another factor in the generative joint. Contrast per-case variational parameter optimization with a shared encoder producing mean/log-variance from x. Distinguish reconstruction via q, generation via the prior, and decoder means from random observations. Brief deterministic-autoencoder comparison is optional; no autoencoder training or architecture survey.

**Retrospective summary:** The decoder defines a latent-variable probability model; the encoder amortizes approximate posterior inference, and reconstruction and prior generation condition on different latent distributions.

### B. A likelihood fixes reconstruction and KL scaling — 25 minutes

**Transition in:** Both networks need one objective with a precise probabilistic meaning. Apply L06/L09's bound to each observation and L11's Gaussian NLL to its reconstructed feature vector.

**Purpose/sources:** B2 §§21.2.2, 21.3.1 and §10.2.1.1 as carried support; establish the actual tabular objective.

**Core:** Fix standardized-space decoder covariance `tau² I`, **tau²=1/2**. Reconstruction NLL is summed squared residual plus the fixed `d/2 log pi` constant, not mean feature MSE. Apply diagonal Normal KL with latent dimensions summed. Average per-observation terms over a batch. At beta=1 the minimized loss is negative ELBO; beta changes the weighted objective. Work the source-to-course normalization comparison. Keep fixed variance rather than quietly fitting a scale that changes the distortion units. Removing the KL penalty alone does not make a stochastic encoder a deterministic autoencoder.

**Retrospective summary:** Reconstruction is a specified likelihood score and rate is a specified KL; event sums followed by observation averaging make beta's tradeoff interpretable and distinguish it from arbitrary array-wise means.

### C. Joint training reuses a pathwise derivative through both networks — 22 minutes

**Transition in:** L09 exposed differentiable Gaussian samples and L11 exposed network outputs. Connect them through the decoder without treating the latent draw as a detached constant.

**Purpose/sources:** B2 §21.2.2, reusing L09/L11 primary mathematics.

**Core:** Encoder returns `mu_phi(x), ell_phi(x)=log variance`; `z=mu+exp(ell/2)⊙epsilon`. Apply the already-derived total pathwise derivative. Reconstruction gradients reach decoder parameters directly and encoder parameters through z; analytic KL gradients reach the encoder. Model weights are fitted points, while z is a random per-case latent. A one-sample reconstruction estimate plus exact KL is unbiased for the selected per-case objective under inherited regularity; noisy SGD need not increase the ELBO each step. Software/model skeleton is supplied, not taught as a second backpropagation course. Compare separate per-case VI with amortization's shared parameters; optimization/approximation/amortization limitations are recognized, without three new gap derivations.

**Retrospective summary:** One differentiable latent transform connects inference and generation; the shared loss updates both fitted networks while preserving the distinction between random latent states and point-estimated weights.

### D. Rate controls input information and prior mismatch — 23 minutes

**Transition in:** Beta multiplies average per-case KL. L04's MI identifies input–code dependence, so determine exactly how that dependence relates to the penalized quantity.

**Purpose/sources:** B2 §5.4.2, §§21.2.4/21.3.1; derive the information connection without supervised IB.

**Core:** Define the empirical mixture `q_phi(z)=N^{-1}sum_n q_phi(z|x_n)` and joint `p_D(x)q_phi(z|x)`. Define distortion D as expected reconstruction NLL and rate R as average KL to the prior. Derive `R=I_q(X;Z)+KL(q_phi(z)||p(z))` by inserting aggregate q into the log ratio. Hence R is an upper bound on MI, not MI itself. Work the input-independent shifted-Normal example: positive R can be pure prior mismatch. Interpret `D+beta R` as a restricted model-family rate/distortion tradeoff, not a certified Shannon-optimal coding curve or actual file-compression implementation. Finite noisy fits need not lie on a monotone optimal frontier. No empirical MI estimator or aggregate-mixture KL computation is required in the lab.

**Retrospective summary:** Average encoder-to-prior KL pays both input information and aggregate prior mismatch; beta trades this rate against reconstruction score without identifying an exact information content or optimal code.

### E. Useful latent patterns require more than a small loss — 12 minutes

**Transition in:** The rate identity explains how an encoder can forget inputs. Check what low rate and apparently meaningful latent axes actually establish.

**Purpose/sources:** B2 §21.4 introduction/§21.4.1 and §21.3.1.1; define diagnostics and interpretation limits.

**Core:** Explain the ideal collapse case: decoder ignores z, true posterior equals prior, and q can equal prior for every x. In practice inspect per-dimension rate, input variation of encoder outputs and decoder sensitivity alongside reconstruction; small KL alone can also reflect incomplete fitting and is not a universal diagnosis. KL annealing is a mentioned possible repair, not a second training implementation or guaranteed cure. Latent-feature correlations and traversals describe a fitted representation; sign/permutation ambiguity and general nonidentifiability prohibit causal/disentangled-factor guarantees. A short sign-flip equivalence is optional. Close retrospectively; lab instructions remain a separate handoff.

**Retrospective summary:** Collapse can eliminate input information while preserving a valid latent model; diagnostic patterns and latent associations must be interpreted within fitting and identification limits.

### Extent and first cut

**100 substantive + 12 reserve = 112 minutes live**, including summaries/transitions; separate 60-minute lab. **Tight, unmeasured; confidence medium-low.** Primary new chain is model/amortization → correctly scaled joint objective → information-rate decomposition/diagnostics. Generic ELBO, Normal NLL, full pathwise differentiation and MLP/AD proofs are carried support. Provisional calibration `K=5`, `P≈9–12`, `E_new≈11–14`, `E_carry≈16–24`, `E_deriv≈7–11`, `V≈6–8` gives `S_hat≈22–28`, a warning signal, not a slide target. L01's 61-content-slide judgment supplies no measured VAE teaching rate.

**First cut:** omit optional deterministic-AE comparison and worked latent sign-flip illustration (about five minutes), keeping the stated role/identification cautions. Total becomes about 107 minutes. Preserve normalization, joint-gradient roles and rate≠MI. No core material moves to recording; later extent pressure must return to Scope.

## 2. Mathematical spine

Use theta for decoder weights, phi for encoder weights, z for random latent, `ell=log s²` for encoder log variance, and fixed tau² for decoder observation variance. Input dimension d=19 and latent dimension k=4 are separate event axes.

| Object/result | Depth, delivery and role |
|---|---|
| `p_theta(x,z)=N(z|0,I) N(x|d_theta(z),tau² I)`; `p_theta(x)=integral p_theta(x,z)dz` | **State/Motivate**, Live A. Likelihood in preprocessed standardized coordinates; not an exact support-respecting model for all raw percentages/counts. |
| `q_phi(z|x)=N(mu_phi(x),diag(exp ell_phi(x)))` | **State + Work shapes**, Live A/C; amortized rather than one freely optimized q per row. |
| `F(x)=E_q log p_theta(x|z)−KL(q_phi(z|x)||p(z))` | **Apply**, Live B; generic identity L06-owned. Restricted q/nonconvex training does not guarantee exact MLE. |
| `−log p_theta(x|z)=||x−d_theta(z)||²/(2tau²)+(d/2)log(2pi tau²)` | **Apply/Work**, Live B; L11-owned Gaussian NLL. At tau²=1/2 coefficient is one. |
| `r(x)=(1/2)sum_j[mu_j²+exp ell_j−1−ell_j]`; `L_beta=batch mean_n[E reconstruction NLL+beta r(x_n)]` | **Apply + Work**, Live B. Sum latent and observed event dimensions separately, then average observations; beta=1 standard negative ELBO. |
| `z=mu_phi(x)+exp(ell_phi(x)/2)⊙epsilon`, `epsilon~N(0,I)` | **Apply**, Live C; L09-owned derivation/interchange conditions. No fresh change-of-variables proof. |
| Reconstruction gradient to theta; chain through z to phi; `partial r/partial mu=mu`, `partial r/partial ell=(exp ell−1)/2` | **Work bounded application**, Live C; no full network reverse traversal. Keep gradients through both encoder mean and variance. |
| `D=E_pD E_q[-log p_theta(X|Z)]`; `R=E_pD KL(q_phi(Z|X)||p(Z))` | **State/Interpret**, Live D. Nats under natural logs; divide by log2 for bits, without literal codelength claims. |
| `q_phi(z)=E_pD q_phi(z|X)`; `R=I_q(X;Z)+KL(q_phi(Z)||p(Z))≥I_q(X;Z)` | **Derive**, Live D; insert aggregate mixture into the density ratio. Finite/support-integrable quantities assumed; no KL between empirical point masses and continuous data densities is required. |
| Collapse: `p_theta(x|z)=p_theta(x)` implies `p_theta(z|x)=p(z)`; q=p for all x gives R=I=0 | **Work/Explain**, Live E. Near-zero fitted rates are diagnostics, not an automatic theorem about decoder use. |
| Latent sign/permutation reparameterization | **State**, optional **Work**, Live E; preserves isotropic prior and diagonal family. General nonidentifiability **State**, no proof of nonlinear impossibility theorem. |

## 3. Notebook handoff — compact mobility VAE, 60 minutes

**Anchor:** actual instructor mobility notebook/data, adapted to the specified likelihood and normalization. **Required endpoint:** complete a reparameterized per-observation loss, perform one bounded joint-training run, and interpret reconstruction/rate plus a supplied beta comparison. Data/model scaffold is given. Proposed compact network: 19→32 encoder hidden features→four means/four log variances; four→32 decoder hidden features→19 unconstrained means. This course reduction from the source's two 64-unit layers is not yet timed. No CNN, learned decoder variance, four separate traversal suites or second full fit is required.

Supply feature transformations, fixed train/held-out indices, training-only standardization, batched CPU data, model skeleton, optimizer/driver, seed/configuration and plots. Preserve masks/row mapping and source provenance; external Cluster labels do not enter loss or validate recovered scientific factors. Students reuse L11 heads and L09 sample transforms, with refresh counted. One baseline beta=1 run is bounded; prepare consistently normalized beta=1/beta=4 checkpoints/summaries for comparison if multiple fits exceed time. These must be produced and verified later; source beta=4 checkpoints cannot be relabeled as the course's beta=4.

| Work including refresh/interpretation | Minutes |
|---|---:|
| Refresh PyTorch encoder/decoder shapes, sample transform and supplied data split | 10 |
| Complete event-summed reconstruction/KL loss and supplied value/gradient checks | 15 |
| One bounded driver run; inspect held-out reconstruction/rate summaries | 12 |
| Interpret supplied beta comparison, per-dimension rate and one latent-feature plot | 13 |
| One provided decoder-mean traversal or prior-versus-reconstruction comparison | 5 |
| Debugging/retrospective reserve | 5 |
| **Total** | **60** |

Durable skill: **join an inference network to a likelihood decoder through a correctly scaled stochastic objective, then interpret its compression diagnostics**. If runtime is slow, use verified prepared fit/checkpoint for interpretation after students perform and check bounded updates; do not claim their short run converged. First lab cut is the extra traversal/comparison, preserving objective checks and beta/rate interpretation. Decoder-mean profiles are labeled means; complete observation sampling would add Gaussian noise and is not a required task. Keep plots in explicitly transformed/standardized units unless full inverse transformations are supplied.

For held-out and prepared-beta comparisons, estimate distortion D by averaging event-summed Gaussian NLL over draws from `q_phi(z|x)` using the same fixed decoder variance and likelihood-constant convention, then combine batch averages weighted by observation counts. Decoding at the encoder mean may be shown separately as a labeled reconstruction visualization; it is not D. Supply the estimator helper within the existing scaffolding, with no added task, fit or time allocation.

Dataset use/redistribution permission and portable access must be settled before publication; instructor-local availability alone is insufficient. No files are copied by this scope. Later worked-solution authoring must validate source cleaning/split, objective/gradient checks, checkpoint normalization, model behavior, student timing and clean local uv plus hosted Colab. None is claimed here. If permission fails, choose the narrowed MNIST fallback through Scope review rather than silently swapping data.

## 4. Concrete examples and provenance

**Event sums and beta, Work/Live B.** Course-constructed one-row check: four-dimensional encoder mean `(1,0,0,0)`, all log variances zero, so rate `r=1/2`; a realized reconstruction residual has first two entries `(1,−2)` and other 17 entries zero, squared norm 5. At tau²=1/2 NLL is `5+(19/2)log pi≈15.874934`. One-sample loss is approximately 16.374934 at beta=1 and 17.874934 at beta=4; expected reconstruction is not asserted from this single draw. Arithmetic checked. The source array means instead give `5/19+beta_source*(1/2)/4`; multiplying by 19 makes its beta_source=4 equivalent to **course beta=19**, up to the fixed likelihood constant. Same numbers do not imply same fit.

**Rate is not MI, Work/Live D.** Course-constructed two equally likely input labels, with identical `q(z|x)=N(1,1)` for both and prior `N(0,1)`. Then aggregate q is `N(1,1)`, `I(X;Z)=0` and `R=1/2`, entirely aggregate-to-prior mismatch. Changing every q to the prior makes both zero. This finite-input/continuous-code example verifies the decomposition without a differential entropy for empirical inputs.

**Mobility patterns, Brief Live / Work Notebook.** Actual 349×19 selected data are source-inspected; no correlation values, active dimensions, reconstruction quality or causal interpretation is promised. Provided held-out scores and latent plots must be labeled fitted descriptive patterns. Exclude unsupported “discovered urban factors” or identified disentanglement claims.

**Coordinate ambiguity, optional Work/Live E.** Flip the first latent coordinate, change encoder mean's corresponding sign and compose the decoder with the inverse sign flip. The isotropic prior and diagonal posterior family are preserved, with equivalent observation distributions/objective. This course-constructed demonstration supports the caution; it is not a proof of the full source nonidentifiability theorem.

About 6–8 conceptual visual groups support model/inference roles, per-case versus shared parameters, event-axis scaling, joint-gradient paths, rate decomposition, and collapse/descriptive diagnostics. Source Figs. 21.1/21.4 are explanatory context, not required reproduced assets. No figures are generated.

## 5. Lecture contract

**Start:** cumulative probability/information, L06 bound, L09 Gaussian VI/pathwise differentiation, L11 MLP/NLL/PyTorch. **Goal:** understand how jointly learned generation/inference produce a latent representation, with a precise rate/distortion meaning and interpretation limits. **Lecture endpoint:** specify VAE roles, construct correct loss and joint-gradient paths, derive rate=MI+aggregate KL, diagnose collapse cautiously. **Lab endpoint:** one checked compact mobility VAE workflow and supplied beta comparison with descriptive interpretation. **No required recording.** Estimated live112/lab60 minutes.

| Allocation | Commitment / boundary |
|---|---|
| **Core/Live deep** | B2 §§21.1–21.2 model/amortization/joint objective; §21.3.1 beta tradeoff; §5.4.2 plus aggregate posterior definition for rate decomposition; §21.4 collapse diagnosis. Selective content, not all subsections. |
| **Short bridges** | Correct Normal KL/pathwise machinery L09, Gaussian NLL/MLP L11, generic ELBO L06; §21.3.1.1 identification caution; §21.4.1 annealing Mention only. |
| **Notebook owned** | Refresh, loss assembly/checks, one bounded fit, held-out reconstruction/rate and supplied beta/pattern comparison. |
| **Optional** | Deterministic-AE comparison, sign-flip illustration, extra traversals. No formal-syllabus promise. |
| **Omitted by course decision** | Full supervised IB/InfoVAE/total-correlation derivations, MMD/adversarial objectives, multimodal/semisupervised/sequential/hierarchical/VQ VAEs, IWAE/flows, free-bits/schedule implementation, identifiability theorem proof, learned mixed-type likelihood catalogue and multiple full lab fits. No debt passed to project meeting L13. |

Coordinator narrows broad §§21.3–21.4 syllabus promises and records these proposed depths separately from delivery. Supported outcomes are model/inference distinction, coherent loss/gradient construction, information-rate identity and honest diagnostics; no compression-optimality, scientific-factor recovery or validated synthetic-MSA generation claim.

**Questions/risks:** **Scope-owned/medium:** accept standardized Gaussian mobility modeling and descriptive latent patterns as the final practical outcome? Bounded raw variables/compositional shares are only approximated; alternative support-aware likelihoods add substantial scope. **Publication owner/medium:** source access is confirmed, redistribution/license unverified; retain inspected mobility provisionally and resolve before delivery, with narrowed MNIST as fallback. **Downstream-owned:** fresh normalized checkpoints and a timed bounded CPU fit are essential; source's 300 epochs/plots are not a runtime promise. **Scope-owned/advisory:** normalization and rate decomposition are load-bearing; apply first cuts before weakening them.

**Next owner:** Instructor oversight of this reviewed proposal. Subsequent Section Design requires human acceptance; its execution backpressure returns to the nearest owning stage. Review and approval provenance are in the registry. No rehearsal, notebook runtime or hosted Colab validation is implied.
