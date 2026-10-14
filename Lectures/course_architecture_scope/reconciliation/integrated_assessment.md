# L04–L12 scope reconciliation: integrated assessment

**Status: assessment and recommendations, awaiting instructor decisions.** This document evaluates existing proposals; it does not replace a lecture scope, approve an exercise, or record teaching. The current request authorizes this work independently of the L01 slide experiment. The working branch is `assess-l04-l12-reconciliation-20261014`, in `/tmp/pml-l04-l12-reconciliation`, based on the existing post-architecture scoping branch. Exact source and review records follow the discussion.

## Recommendation and first decision

**Recommendation:** preserve the mathematical cores of the nine proposals and reconcile their practical endpoints selectively. Start with **L04's notebook endpoint**, because this is an explicit conflict with an instructor-selected exercise, rather than merely an unfinished proposal. I recommend a focused Iris probability-evaluation notebook, preserving the approved three-bit parity example live and using supplied exact information/coding results as comparisons. This changes the prior decision to have students construct and analyze the five-bit correcting code. It needs new approval; neither the architecture nor this assessment grants it.

The proposed Iris notebook should prioritize comparing probability forecasts by accuracy and held-out log score. A small supplied representation example can illustrate information loss; it should not become a second student implementation or a claim to estimate population mutual information reliably from a small Iris holdout. This narrower version develops evaluation competence that L05 can reuse when students fit a classifier and that L07/L09/L10 can reuse when comparing posterior predictions. The coding alternative remains mathematically strong: students construct a decoder with a conditional correction guarantee and compare information, decision error and resource rate. Its loss would be substantive, not a cosmetic change.

**Decision requested now:** should L04 prioritize that focused probabilistic-evaluation capability, or retain the selected five-bit construction as its principal student computation? A third option is a coding-led hybrid: keep encoder/decoder work, supply more of the information/noise-sweep calculation, and inspect a short supplied Iris score comparison. That gives less student ownership of both kinds of evaluation and still needs a workload pilot. Deferring the switch to pilot the selected code task is also possible. All other choices below remain queued, not questions to answer simultaneously.

## Existing material, authority, and review limits

The architecture and prospective map agree on the course objective: usable first experience with recognizable learning problems and algorithms, supported by precise probabilistic reasoning. The existing scope texts contain valuable derivations, conditions and diagnostic examples. Their weakness is often the gap between a checked mathematical example and the newer proposed application, rather than an incorrect mathematical spine.

The documented instructor choices include the thirteen-meeting order, Book 2 as primary source, the earlier L03 graphical-model/live–notebook boundary, L04's three-bit live/five-bit notebook split, and the request to begin L05/L06 from familiar hierarchical Bayesian modeling. The last request concerns framing; it does not approve all their applications or time allocations. L01–L03 have subsequently been reopened in their own reconciliation stream. Consequently their current prepared artifacts give **prospective prerequisites**, not an irrevocably frozen or delivered student state. No lecture has yet been taught; the actual curriculum map is intentionally blank.

The historical individual reviews, readability check and whole-course review concern identified older versions. They provide evidence, but do not validate the new shared classifier, Iris information exercise, or strengthened L04 student hour. Some older scope/review prose still describes L01 as delivered or invokes a deleted material ledger. Those claims conflict with the current actual map and kickoff instructions and must not become prerequisite authority. Repair that prose when its owning artifact is revised; this assessment leaves historical evidence identifiable.

Three separate Lecture Scope specialists reviewed bounded lecture groups for this assessment. Their reports are [L04–L06](reviews/L04_L06_assessment.md), [L07–L10](reviews/L07_L10_assessment.md), and [L11–L12](reviews/L11_L12_assessment.md). They are independent of the coordinator's synthesis, but were given the current architecture and existing critiques: they are informed reassessments, not blind discoveries or new Section Design previews. No notebook execution, hosted Colab check, student trial or rehearsal is claimed.

## Lecture-by-lecture assessment

The table distinguishes the current scope from an architecture/map proposal. “Derive,” “work/apply,” and “state” describe teaching depth, not additional material approved by this review.

| Lecture | Existing mathematical contribution and incoming prerequisites | Intended practical competence and consequential reconciliation |
|---|---|---|
| **L04 information theory** | Derive finite entropy/cross-entropy/KL and MI identities; sketch data processing; work parity ambiguity and compare error/information/rate. Requires Bayes, finite sums, conditional independence and L02 sufficient-statistic interpretation. | Existing selection: construct the five-bit code, verify distance three, decode and analyze a finite channel. Map proposal: compare Iris forecasts and representations. This is the first instructor decision. The five-bit workload and the new evaluation exercise both remain unpiloted. |
| **L05 GLMs, AD, SGD** | Derive the canonical response-family gradient, work the vector softmax gradient and one reverse-mode graph, derive unbiased minibatch gradient at fixed weights; state convexity qualifications. Requires L02 exponential families/log-partition moments and elementary matrix calculus. | Fit and score a three-class Iris softmax model and check a hand derivative against autograd. Preserve the hierarchy → response-family → point-fitting distinction. First PyTorch use makes the hour tight. The scope needs the map's concrete supplied comparison baseline; do not add a second full fit or use Iris's small size to claim minibatching saves computation. |
| **L06 EM** | Derive the ELBO/KL identity and exact touching-bound improvement argument; work Gaussian expected vectors/outer products and parameter updates; state ignorable-missingness conditions; mention mixture responsibilities. Requires L01 conditioning and L02 sufficient statistics/moment fitting, plus L04 KL nonnegativity. | Fit unknown Gaussian parameters from incomplete measurements, evaluate observed likelihood and reconstruction separately. Current scope uses synthetic data, oracle and mean-only-update diagnostics; the map proposes a recognizable measurement dataset and complete-case/mean-imputation baselines. Those serve different jobs. Preserve the covariance diagnostic while supplying one practical baseline and deciding the data source. A second mixture/MRI fit remains an alternative, not an extra lab. |
| **L07 Laplace** | Derive scalar quadratic construction/normalization and logistic curvature; state the multivariate formula and regime; work quadrature/tail checks and prediction. Requires L05 binary likelihood and point optimization, L01 Gaussian precision; curvature is new. | Existing notebook: checked one-coefficient posterior. Map: a small binary classifier, point versus posterior-averaged prediction, with scalar quadrature as diagnostic. Use the scalar restriction inside a shared model rather than two independent implementations. Preserve real query checks while deciding how much inference-method orientation belongs live. Recovered reviewed orientation proposals are useful evidence, not approved replacements. |
| **L08 exact messages** | Derive forward/backward recurrences, normalization/evidence and dense-chain cost; work marginal decisions versus path MAP; state Viterbi and apply a brief Kalman comparison. Requires L02 transitions, L03 factorization/CI, L01 Gaussian conditioning; EM/HMM parameter learning is not required. | Run exact filtering/smoothing on a prepared sequence and interpret uncertain transitions, checking tiny enumeration. Current casino task is credible as a controlled sequence problem. A behavioral/sensor dataset needs actual provenance and model parameters; renaming simulated dice does not supply it. HMM versus previously preferred Kalman forecasting remains an instructor tradeoff. Keep one main solver and do not promise general graph inference. |
| **L09 VI** | Reuse L06 bound; derive diagonal-Gaussian reverse-KL geometry and total pathwise derivative; work same-target coordinate updates at bounded depth; state score-function contrast and amortization. Requires L05 AD/SGD and L01 Gaussian algebra; prepares L12 differentiable latent draws. | Current exact Gaussian-regression task separates family and optimizer error. Map adds diagonal-Gaussian VI on the L07 classifier. Preserve the exact diagnostic as supplied checking material and constrain the application to one scaffolded fit. Comparing diagonal VI against full-covariance Laplace changes both family and fitting criterion; the explanation must identify both. |
| **L10 MC/MCMC** | Derive independent-average variance, detailed-balance invariance, general Hastings correction and stationary covariance-sum error; work Gibbs cancellation; state ergodic/CLT conditions and recognize HMC. Requires probability/expectations and new chain theory; L02 does not establish stationarity. | Existing bimodal target exposes slow exploration; map adds posterior predictions on the shared classifier. Supply the driver, diagnostics and cross-method outputs, retaining student work on acceptance, rejected stays and query estimates. A logistic posterior with proper Gaussian prior has one mode, so the multimodal stress test remains indispensable. Full HMC would be a replacement depth decision, not a software convenience. |
| **L11 neural conditionals** | Work nonlinear composition and a Gaussian mean/positive-scale model; derive likelihood/scale gradients and prior-penalty scaling; apply AD; state conditional-noise versus parameter-uncertainty distinction. Requires L05 fitting and L04 scoring, with L09 useful for uncertainty contrasts. | Complete/train one heteroskedastic predictor and compare held-out NLL/MSE/interval behavior. Current supplied fixed-scale nonlinear baseline tests the scale head; it does not test whether nonlinear means improve on a GLM. Supply that simpler baseline too. Recovered source-arc proposals explicitly connect neural model parameterization with inference-network parameterization, protecting the L12 bridge without an architecture survey. Any funded emphasis change still needs acceptance. |
| **L12 VAE** | Apply L06/L09 ELBO/pathwise results and L11 Gaussian likelihood; derive event-sum scaling and rate/MI decomposition; work encoder/decoder roles; state collapse and nonidentifiability limits. Requires actual access to those earlier results, not just their names in a map. | Complete one compact VAE fit, evaluate reconstruction/rate and supplied tradeoffs, inspect codes, and distinguish prior generation from reconstruction. The map requires generation; the scope's notebook currently permits cutting that comparison first. Protect one supplied prior-generation comparison by replacing a secondary traversal. Public source research reduces the mobility-data access gap, while attribution, transformations, support and CPU feasibility remain author work. |

These are nine bounded encounters, not nine independent programming projects. The 110–115-minute live envelopes and 60-minute student hours are planning estimates. Their reserve is already allocated; later authors cannot fund additions by cutting an optional task already excluded from the required hour. Current timing calibration is a provisional L01-based prior, not measured evidence for stochastic differentiation or VAE training.

## Cross-lecture mathematical dependencies that must remain visible

### L04 → evaluation throughout the course, and information in L12

For a true conditional label law \(p_*(y\mid x)\) and a forecast \(q(y\mid x)\), expected negative log score is

$$
\mathbb E_{p_*}[-\log q(Y\mid X)]
=H_{p_*}(Y\mid X)+\mathbb E_{p_*(x)}\operatorname{KL}(p_*(\cdot\mid x)\|q(\cdot\mid x)).
$$

This course-derived conditional version of Murphy's cross-entropy identity explains strict propriety when the score is finite: the true conditional distribution minimizes expected score. Held-out mean log score estimates that criterion; it does not establish calibration from a small sample. Accuracy evaluates an argmax decision and can remain unchanged when confidence changes dramatically. This distinction gives L05 and L07/L09/L10 a common performance language without pretending that empirical evaluation reveals the true posterior.

Mutual information needs an explicit joint law. For a representation \(Z\) obtained from \(X\) without new label information, \(Y\perp Z\mid X\) gives \(I(Y;Z)\leq I(Y;X)\). It does not guarantee usefulness for every task. On a finite sample, assigning each observation its own bin makes its label deterministic in the empirical table, yielding \(\widehat I(Y;Z)=\widehat H(Y)\) even when the representation generalizes badly. Thus a proposed Iris representation comparison needs fixed training-defined bins and a descriptive finite-sample interpretation, or a supplied exact finite-law diagnostic. A full MI estimator/calibration study is not free prerequisite work.

L12 then derives, under its chosen data law \(q(x)\) and encoder joint \(q(x)q_\phi(z\mid x)\),

$$
R=\mathbb E_{q(x)}\operatorname{KL}(q_\phi(z\mid x)\|p(z))
=I_q(X;Z)+\operatorname{KL}(q_\phi(z)\|p(z)).
$$

The average prior penalty can be positive even when every input has the same encoded distribution and \(I_q(X;Z)=0\). Preserve this derivation; do not describe changing \(\beta\) as directly controlling an exactly measured information content.

### L01/L02/L04 → L06 → L09 → L12: one identity, different computations

With fixed parameter \(\theta\), observed data \(o\) and latent variables \(z\),

$$
\log p_\theta(o)=\mathcal F(q,\theta)
+\operatorname{KL}(q(z)\|p_\theta(z\mid o)),
\qquad
\mathcal F=\mathbb E_q[\log p_\theta(o,z)]+H(q).
$$

L06 derives this identity. Exact EM chooses \(q_t=p_{\theta_t}(z\mid o)\), then improves \(\mathcal F(q_t,\theta)\) in \(\theta\), so observed likelihood cannot decrease. It does not return a posterior over \(\theta\). Gaussian EM specifically needs

$$
\mathbb E[xx^\top\mid o,\theta_t]
=\mathbb E[x\mid o,\theta_t]\mathbb E[x\mid o,\theta_t]^\top
+\operatorname{Cov}(x\mid o,\theta_t).
$$

Mean-only filling deletes the second term and changes the sufficient-statistic update. L09 instead fixes the target model and optimizes a restricted distribution \(q\); family and optimizer error remain even when its objective improves. L12 jointly fits a generative model and a shared per-input encoder. Its global network weights are fitted points; the local code is random. A fresh full ELBO proof in each lecture would waste time, while treating these algorithms as interchangeable would erase their different targets and guarantees.

L09's pathwise derivative must retain both sample-map and direct objective dependence:

$$
\nabla_\psi\mathbb E_{\epsilon}[f(g_\psi(\epsilon),\psi)]
=\mathbb E_{\epsilon}[J_{g_\psi}^{\top}\nabla_z f+\nabla_\psi f],
$$

under conditions permitting differentiation under expectation. L12 applies it to \(z=\mu+\exp(\ell/2)\odot\epsilon\), where \(\ell\) is log variance. The distinction between variance and standard deviation is a correctness responsibility, not an instructor choice. The December 2025 Book 2 §10.2.1 sign/constant errors recorded in the source evidence must remain flagged: use expected log likelihood **minus** prior KL and the complete diagonal-Normal KL, including the \(-1\) term.

### L05 → L07/L09/L10: a shared classifier, with controlled comparisons

The prospective common model can be written

$$
y_n\mid w,x_n\sim\operatorname{Bernoulli}(\sigma(x_n^\top w)),
\quad w\sim N(0,\Sigma_0),\quad \Sigma_0\succ0,
\qquad g_x(w)=\sigma(x^\top w).
$$

All methods can answer the same predictive query \(\mathbb E[g_x(w)\mid D]\). Laplace fits \(N(\hat w,H^{-1})\) using mode and curvature; VI fits a chosen family by reverse KL/ELBO; MH estimates the target expectation by a dependent average. Drawing from a proxy is available to either Laplace or VI and does not distinguish them.

Here \(H(w)=\Sigma_0^{-1}+X^\top W(w)X\succ0\), so the posterior is strictly log-concave and has a unique mode. A classifier comparison can reveal concentration, dependence, prediction error and finite sampling cost; it cannot reveal missed posterior modes. Keep L10's bimodal stress test as supplied diagnostic material. Likewise diagonal VI versus full-covariance Laplace confounds family with criterion. Supply a comparison in the same family, or explicitly attribute their difference to both changes. For an exact correlated Gaussian with precision \(\Lambda\), reverse-KL diagonal VI has variance \(1/\Lambda_{jj}\), which generally differs from marginal variance \((\Lambda^{-1})_{jj}\); this diagnostic should survive any application switch.

The application remains deliberately small. Its purpose is first use and comparative judgment; it does not prove a speed advantage at realistic dimension. Computational discussion must separately explain Hessian/storage costs, VI gradient/family costs and MCMC mixing/query error. A checked scalar restriction supplies a quadrature reference for that restricted posterior, not an exact reference for a different multivariate model. Fix model, prior, data split, preprocessing, query and reference accuracy before interpreting cross-method differences.

A limited independent scratch calculation in the L07–L10 report tested a two-parameter Iris classifier with deterministic integration and Gaussian VI fitting. Refined numerical comparisons found all held-out mean log scores within about 0.001 nats per case, despite different errors relative to reference probabilities; the point predictor scored slightly better on this particular split. This supports tractability of supplied comparisons, not a claim of useful stochastic-VI training, MCMC convergence or student-hour feasibility. Agreement on a task score is legitimate: it can show that several methods meet the task's needs. Do not choose data/test cases merely to manufacture a dramatic method ranking, or interpret a slightly better empirical score as proof of a more accurate posterior.

### L03 → L08: exact structure is a distinct alternative

An HMM factorization allows histories with the same boundary state to share a partial sum. Dense finite-state forward/backward work is \(O(TK^2)\), compared with enumerating \(K^T\) histories. This is exact inference for the specified model, up to numerical arithmetic; its payoff is directly present even in a modest sequence. It is not a fitted posterior-family proxy or an MCMC estimate. Unknown HMM parameters, general tree/loopy algorithms and large-state inference are outside the selected implementation. The brief Gaussian/Kalman comparison uses L01 conditioning but does not deliver the previously preferred forecasting application. Book 2 §9.2.6.2's claim that a unique path MAP must agree with pointwise smoothed modes is false; the existing untied counterexample must remain. Whole-history success and expected timewise errors require different decisions even when their computations are exact.

### L05 → L11 → L12: computation graphs and two neural roles

Reverse-mode AD differentiates numeric operations; L03's probabilistic graph asserts a joint factorization and conditional independences. A neural map may parameterize \(p_\theta(y\mid x)\), or return parameters of \(q_\phi(z\mid x)\) for inference. The second use must be explained before L12's amortized encoder becomes essential. Recovered L11 source-arc proposals already offer a bounded explanation funded by reduced optimizer/shrinkage detail; examine that offer before commissioning a new general deep-learning survey.

At fitted weights, L11's Gaussian scale models conditional observation variability. Bayesian predictive variance would additionally contain variation in the conditional mean across weight uncertainty. The fixed-weight model cannot supply that second term. L12 similarly must distinguish encoder-based reconstruction from \(z\sim p(z)\), \(x\sim p_\theta(x\mid z)\) prior generation. On transformed mobility features, plausible standardized outputs are not automatically physically valid urban measurements or causal factors.

## Consequential choices queued after L04

1. **Shared L07/L09/L10 application contract.** Recommend one fixed binary-classifier model/query with the scalar, correlated-Gaussian and bimodal checks retained as supplied diagnostics. Alternative: keep independent diagnostic notebooks and supply a lecture-level application comparison. The shared application adds transfer and credible use, but requires a coordinated worked solution/reference and an explicit family-versus-criterion comparison. This is the largest cross-lecture notebook change; do not implement each lecture independently.
2. **Accept or refine recovered L07/L08/L11 source-arc repairs.** These are previously independently reviewed *proposals*, not accepted choices. Recommend reusing their funded mathematical comparisons rather than adding unbudgeted surveys. Decide extent/emphasis from those actual offers, especially what L07's inference orientation and L11's two neural roles displace. L08's earlier broad critique is disputed by a cold review; its existing grouping argument is stronger than the old summary suggests.
3. **L08 HMM inference versus Kalman forecasting.** Recommend the bounded HMM route provisionally because its exact comparison is ready to specify and it protects the structural-inference endpoint. The real forecasting alternative gains scientific time-series practice but requires source recovery/data/model fitting and corresponding HMM cuts. Earlier preference has not been silently rescinded.
4. **Recognizable data and meaningful baselines in L06/L11.** A measurement dataset for EM adds a real fitting encounter; controlled masking and the exact moment diagnostic must survive. In L11, supplied affine and fixed-scale nonlinear baselines test different model extensions without extra student fits. Retaining controlled synthetic data is a defensible teaching choice if its practical competence and limits are explicit.
5. **L12 mobility application and generative endpoint.** Public versioned data access has now been found: [raw-data-cluster.csv at the pinned primary repository revision](https://github.com/narslab/mobile-emissions-typology/blob/049cb033a9814c0ec3df99ece5144d07688aa648/data/tidy/raw-data-cluster.csv) is byte-identical to the instructor's CSV (SHA-256 `05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6`, 349 rows and 57 columns); details are in the L11–L12 report. Recommend testing the compact mobility route before replacing it. Verify attribution/source rights, transformations, held-out splitting, CPU run and consistently normalized comparison checkpoints. Protect prior generation as a supplied output. A handwritten-digit fallback changes the application and requires scope review; no fallback switch is authorized now.

Approval of L04 is not approval of this queue. Independent source recovery, reference design and feasibility investigation can continue; scope/map amendments and notebook implementation wait for the decision that owns them. After a targeted revised scope is assembled, obtain the normal Section Design feasibility preview without making sections, then seek acceptance. The present three scope assessments do not replace that gate.

## Source records and recoverable review evidence

**Working baseline:** `16850fbda82ff9a4a0a665ddab52115cda14a2bf`, refreshed `origin/scope-l04-l12-after-architecture-20261014`; its parent architecture lineage includes PR #16 merge `730b5cbde055cc166f48f1a73dc63df190e6187b`. `origin/scope-l04-l12-reconcile-2027-1` was also refreshed and compared. Architecture/map/actual-map blobs are respectively `cb111196e44df211e39864be596233a1a3f22aba`, `63fb5cea0a7b0a4c908c8f803e550d087d20a412`, `cf143d8c5427030cf3ac6c6ad05d8ad9cd420fe3`. They match the active L01 reconciliation branch at assessment time; L01's newer workflow state is separate and was not imported.

| Scope | Baseline blob |
|---|---|
| L04 | `b0efb934cd9a84d19ab9779239c438c9f14d8dc3` |
| L05 | `bf869a5c85c0d32a995f5c55961ad8e89d704d1e` |
| L06 | `c795841dfe92182c683d2b0e0d105f921814795d` |
| L07 | `43c403d65e58e1b852517dd7b2785de1f84933e8` |
| L08 | `8c442b362e4610edc4212988074c855b00e843b3` |
| L09 | `89ee9f324fd0384972ff1ef52c446d6b146367d6` |
| L10 | `9ce5a70b8ac1e1506820134b1a01d06b976c072f` |
| L11 | `629e38893497e4b2cf18e4fcf58d225177c00f88` |
| L12 | `22fa2d8307ef7cb621456521383b6c352dcd451a` |

Historical commit `dd4f2c5053f29590845ae42a6331d245d773218c`, “Revise L04–L12 source arcs with independent course reviews,” contains six repaired scope proposals and raw `source_arc_agent_reviews/` evidence. It is recoverable locally by exact commit/reflog, but is not contained in a current named branch: the source scoping branch was reset to its remote lineage. Its workflow register expressly leaves instructor acceptance pending. Review its files with `git show dd4f2c5:<path>`; do not merge or restore superseded drafts into the current tree merely to retain them. In particular, its L04 notebook is the older three-bit task rather than the current selected five-bit extension, and its L05/L06 openings lack the current instructor-requested Bayesian framing. Those independent passes cannot be transferred wholesale to today's targets. The current group reports identify the strongest recovered offers and their exact reviewer/target records. Their past references to delivered teaching remain qualified by today's actual-map authority.

**Books:** local original PDFs in the primary workspace's `Resources/` are untracked reference inputs, not files to copy into the new worktree. Book 2 is Murphy, *Probabilistic Machine Learning: Advanced Topics*, online edition December 10, 2025, SHA-256 `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`; Book 1 is *Probabilistic Machine Learning: An Introduction*, online edition April 18, 2025, SHA-256 `89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf`. Fresh original-PDF hashes match the earlier source register. Selected passages were reassessed through the original PDFs/extracted texts; precise checking depth is disclosed in the raw reports.

Focused Book 2 preparation routes, with section titles verified in this edition:

| Decision/background | Passage and what to inspect |
|---|---|
| L04 evaluation versus coding | §5.1.6 **KL divergence and MLE**, §5.2.4 **Cross entropy and perplexity**: expectation versus empirical score. §§5.3.1–5.3.4 **Definition**, **Interpretation**, **Data processing inequality**, **Sufficient statistics**: the joint law, processing condition and what is retained. §5.5 **Error-correcting codes (channel coding)**: noisy decoding rather than classifier training. |
| EM/VI/VAE reuse | §6.5.3 **The EM algorithm** and §6.5.4 **Example: EM for an MVN with missing data**: exact posterior tightening, parameter update and second moments. §10.2.1 **Reparameterized VI**: complete sample derivative and the recorded formula corrections. |
| Inference comparisons | §§7.1–7.3 **Introduction**, **Common inference patterns**, **Exact inference algorithms**: query/unknown-variable structure and exact possibilities; §7.4.3 **Laplace (quadratic) approximation**: local curvature criterion. §10.1.1 **The variational objective**: optimize a distribution. §§12.2.1–12.2.2: Hastings correction; §12.6.3 **Effective sample size**: estimator-specific dependence. |
| Exact sequence route | §§9.2.2–9.2.3: prefix/future messages; §9.2.5: complexity; §8.2.2 **The Kalman filter**: Gaussian alternative. Inspect inference output and cost rather than assuming a second fitting lab. |
| Neural model and inference roles | §16.1 **Introduction**, §16.2.1 **Linear layers**, §16.2.2 **Nonlinearities**, §16.3.1 **Multilayer perceptrons**: numeric composition versus distributional meaning. §§21.1–21.2: latent generation, posterior obstacle and amortized training. Book 1 §13.2.4.4 **MLP for heteroskedastic regression** supplies the concrete likelihood example. |

The earlier [source inspection](../source_inspection.md), [scope registry](../STATUS.md), individual `reviews/L04_review.md` through `L12_review.md`, adjacent `source_arc_review.md` files, [source-arc index](../source_arc_review_index.md), and [whole-course review](../reviews/course_architecture_review.md) remain the identifiable raw baseline evidence. This synthesis complements them and preserves their version/authority limits.
