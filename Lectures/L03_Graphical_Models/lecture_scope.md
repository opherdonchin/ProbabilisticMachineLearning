# L03 — Graphical models: local interactions and global distributions

**Status:** Reviewed five-part scope proposal; [current agent approval and exact reviews](../course_architecture_scope/STATUS.md) are maintained by the coordinator. Instructor acceptance pending; timing and notebook implementation remain unvalidated. **Stage/mode:** Lecture Scope / BUILD. **Builder:** `/root/build_l03`, 2026-10-11. **Branch:** `scope-l03-l12-course-architecture`; input HEAD `906ce71dd9c8e29f3dede51ec809442a885354c9`. **Versioned upstream contract:** `Lectures/course_architecture_scope/architecture_audit.md`, cross-course contract v1, Git blob `882a9b2e76134d4952b218492a3564e117f6d6b4`. The instructor delegated batch-mode provisional choices through `Lectures/course_architecture_scope/WORK_ORDER.md`; consequential hesitations below go to the coordinator for consolidation, with no parallel human checkpoints. This file owns scope only: no sections, slides, figures, or notebook implementation.

## Starting boundary and evidence

The actual L01 `slide_deck.typ` establishes joint/marginal/conditional queries, Gaussian moment and precision coordinates, the residual-independence conditioning argument and linear Gaussian systems. Its graphs introduce modeling notation; they do not constitute delivered d-separation or MRF teaching. The protected solution `InClass/Solutions/lecture1_missing_data.ipynb` contains 80 cells: a known seven-dimensional joint Gaussian with a hidden three-coordinate block, PyMC conditional inference, an explicit LGS re-expression using `np.linalg.solve`, and comparison with the exact conditional mean/covariance. The transferable boundary is **specify a joint model, distinguish a conditional distribution from a summary, and cross-check a computation**; using a sampler did not teach its mathematical correctness. No protected artifact is edited.

L02 has no standalone `lecture_scope.md`; its agreed `section_design.md` is the operative prior commitment, not evidence of delivery. It promises exponential-family coordinates, log-partition derivatives, MLE moment matching, a maximum-entropy proof sketch, Gamma fitting, categorical counts, and Markov-chain parameter estimation through B2 §2.6.3. It stops before stationary distributions. Its development-state file has malformed repeated text/stale branch metadata and supplies no new authority. L03 assumes these agreed L02 results will be established before it is taught. In particular, `A = log Z`, sufficient statistics, and a first-order Markov chain are carried knowledge rather than new derivations. If L02 delivery falls short, return that dependency to the coordinator rather than expanding L03 silently.

The canonical ledger records delivered B2 through §2.3.2 and B1 through §3.3; later rows are proposed allocations. It defers correlation/causation and Gaussian-potential calculus, neither of which becomes an automatic L03 obligation. The current syllabi name compact DAG review, core MRFs/Ising/Potts, factor graphs and an Ising restoration candidate; broad §§4.3.7–4.3.9 preparation references must not imply live teaching of Gibbs, variational inference or MRF learning. Undergraduate DAG/PyMC familiarity supports short recall, but not assumed mastery of all collider-descendant queries. No measured L03 rehearsal or L01 section timings are available.

### Direct sources inspected and limits

| Source | Evidence used / provenance |
|---|---|
| Protected L01 source and missing-data solution | Git blobs respectively `235b8eeb48ec9075d2bcea82b6a377c0a45b6a79`, `ab441941c8b526151a927bfbcf292bd9bc629ce5`; notebook SHA-256 `f114516ca6a9c0823c14da0a734822a8901e4fdccf237481d47d0e3a61f80a8c`. Source inspection, no execution claim. |
| L02 agreed section design | Git blob `bbf78a13db05224a839d0b2f8bda4c7a5bd0c764`; prior promises protected. |
| Ledger, syllabi, notebook audit | Inspected the 2026-10-11 architecture and candidate boundaries; future allocations remain undelivered. |
| Murphy B2, online edition December 10, 2025 | Local `book2-1.pdf` identified in the upstream contract; inspected extracted passages in `/tmp/pml-book2.txt`: §§4.2.1, 4.2.4.1–4.2.4.3, 4.3.1.1–4.3.1.2, 4.3.2.1–4.3.2.2, 4.3.4.1, 4.3.5.1, 4.3.6.1–4.3.6.2, 4.3.7–4.3.9 opening, 4.5.1, 4.6.1.1. Core printed passages pp. 149–154, 165–170, 175, 177, 179–183, 194–195, 202–204. These are selective passages, not a promise to traverse the numeric page span. |
| Murphy B1, online edition April 18, 2025 | Local `book1.pdf` identified in upstream contract; `/tmp/pml-book1.txt` §§3.6.1–3.6.2, printed pp. 99–102. Supports DAG/Markov-chain recall, not the main MRF exposition. |
| Pyprobml reference | [ising_image_denoise_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/04/ising_image_denoise_demo.ipynb), inspected locally at `/home/opher/Repositories/pyprobml/notebooks/book2/04/ising_image_denoise_demo.ipynb`; checkout `d1ea4122dcf3c2a2c02eb4e05343203b26440827`, notebook SHA-256 `3d7a54f5c851c5de2efe196f9fa6cff8c82bdeb612c02137618fa8a0fdd4696e`. One code cell implements Gibbs and mean field, downloads `letterA.csv`, and uses pandas, NumPy, Matplotlib, SciPy, tqdm and probml-utils. Not executed; neither its outputs nor runtime are validated. |

Exact source cautions affect the commitments. B2 §4.3.1.1 explicitly restricts the Hammersley–Clifford converse to positive distributions. Graphical connection does not force dependence for every parameterization; source shorthand concerning a collider or the pairwise Markov property must be read as graphical entailment, with faithfulness kept distinct. The Ising reference generates noise with standard deviation `sigma` but evaluates likelihoods with standard deviation `sqrt(sigma)`; its burn-in parameter also does not discard burn-in contributions. Its restoration methods therefore provide model/application provenance, **not** a verified worked solution for this lab. The proposed scope fixes variance notation explicitly and uses an independently constructed deterministic method. We do not reproduce source figure outcomes or assert that these code issues have been repaired/tested.

### Alternative routes and provisional selection

| Route | Endpoint and source route | Tradeoff / decision |
|---|---|---|
| **Spatial interactions → local posterior computation** | Core B2 §§4.3.1–4.3.2.1, 4.3.6.1, 4.3.8; compact §§4.2.4, 4.5.1, 4.6.1.1. Normalize a tiny Ising model, derive its local conditional, construct restoration updates. | **Selected provisionally.** Substantial advance beyond undergraduate DAGs; one coherent application, no dependence on formal VI/MCMC. Gives L08/L09/L10 a shared representation. |
| DAG reasoning → learned discrete Bayesian network | B2 §4.2, parameter estimation and an ALARM-style lab. | Useful but spends scarce time reteaching undergraduate material; MRF endpoint becomes superficial. Does not satisfy the architecture's substantive undirected commitment as well. No inspected ALARM solution is being promised. |
| Gaussian precision → sparse GMRFs | B2 §4.3.5.1 with L01 conditioning; lab on spatial Gaussian reconstruction. | Smoothest continuity with L01, but risks a second Gaussian inference lab and weak discrete/normalization novelty. Retain a short optional precision comparison, not a second primary model or lab. |
| MRF likelihood → parameter learning | B2 §§4.3.4, 4.3.9 and L02 moment matching; exact small-model learning lab. | Strong mathematical continuity, but adds a learning endpoint and expectation-computation burden before L05 optimization/L09–L10 approximate inference. Here only recognize the relation to L02, without a learning derivation. |

No route requires a new software ecosystem or required recording. The selected route wins on undirected substance and the application interface, while constraining DAG recall and postponing inference algorithms. It remains reversible pending instructor oversight.

## 1. Intellectual arc

These are **provisional conceptual macrosegments**, not Section Design boundaries. Downstream design may split or combine them while preserving depth, examples, endpoint and live budget. All transitions enter the receiving segment; each segment ends by summarizing what it established. All core treatment is **Live**.

### A. A graph records a factorization and guaranteed independences — about 14 minutes

**Transition in:** L02 learned a directed first-order Markov model from counts; L01 used a joint distribution to answer several conditional queries. Recall how a graph says what factors a model contains before asking how spatial models differ.

**Question/purpose:** What can a graph legitimately tell us about a probability distribution?

**Sources:** B2 §§4.2.1, 4.2.4.1–4.2.4.3; B1 §§3.6.1–3.6.2 as scaffolding.

**Core:** Apply familiar DAG product factorization. Recall chain/fork blocking and collider opening (including a conditioned descendant) without a full Bayes-ball algorithm. Work one positive noisy-collider example to distinguish guaranteed independence from generic dependence. State I-map inclusion `I(G) ⊆ I(p)` and why an edge or open path permits rather than universally guarantees dependence. Distinguish probabilistic DAG arrows from an automatically justified causal interpretation. Review only; no student-network CPT catalogue, parameter-learning derivation or causal calculus.

**Retrospective summary:** A DAG specifies normalized conditional factors; d-separation supplies valid CI claims for every compatible model, whereas additional numerical independences need not be visible in the graph.

### B. Symmetric local scores require global normalization — about 22 minutes

**Transition in:** A temporal ordering suited L02's chain; adjacent pixels have no similarly privileged parent direction. Introduce spatial compatibility factors as a different way to construct a joint distribution.

**Question/purpose:** How can unnormalized local preferences define a valid global probability model?

**Sources:** B2 §§4.3.1.1–4.3.1.2, 4.3.2.1; §4.3.4.1 as a brief L02 connection.

**Core:** Define clique and maximal clique, nonnegative potentials and a finite positive normalized joint. Potentials are scores, not individually normalized CPDs. Derive product-to-energy form; energy may have either sign and is only defined up to an additive constant. Work a four-node square Ising model through all 16 states grouped by interaction score to obtain `Z(J)`. Explain `J > 0` as agreement preference and identify unary fields. Reuse L02's exponential-family coordinates: node/edge statistics and `A = log Z`; do not repeat maximum-entropy/moment derivations. State the positive-distribution Hammersley–Clifford equivalence, without proof. Exact enumeration demonstrates global cost `2^n` for brute force, not a universal lower bound on every graph's inference.

**Retrospective summary:** Multiplying local compatibility scores produces an unnormalized joint; the partition function normalizes it globally, and the Ising exponential family makes interaction strength and state probabilities explicit.

### C. Factor cancellation makes local conditionals tractable — about 27 minutes

**Transition in:** Computing `Z` is already a global task on a tiny square. Ask what can be computed when all variables except one are held fixed.

**Question/purpose:** Which variables influence a node's full conditional, and why can that conditional be evaluated without the global partition function?

**Sources:** B2 §4.3.6.1 and §4.3.2.1; contrast §§4.2.4.3, 4.5.1. Local-conditional algebra is course-derived from the source factorization.

**Core:** State global graph separation and the local/pairwise Markov properties; retain the positivity qualification on their converse equivalence. Work separator queries on the specified four-cycle. Derive full-conditional cancellation for factors containing a node, then derive the binary Ising conditional/log odds from its unary and incident edge terms. Compare undirected neighbors with a DAG's parent/child/coparent blanket at recognition depth. Use the recalled collider to show why removing arrows generally changes CI semantics; do not develop ancestral moralization as an algorithm. Connected endpoints can be marginally dependent while being conditionally independent across a separator.

**Retrospective summary:** In a positive MRF, graphical separation encodes CI; fixing a node's neighbors cancels every irrelevant factor and leaves a locally normalized conditional even when the global normalizer is costly.

### D. Image restoration turns local evidence into a coordinate decision — about 21 minutes

**Transition in:** The local Ising conditional combines a field with neighboring spins. Observed noisy pixels contribute exactly such a field, connecting the model to L01's hidden-state/measurement viewpoint.

**Question/purpose:** How can we build and improve a candidate clean image without claiming exact posterior inference?

**Sources:** B2 §4.3.8, Eq. 4.117 and the Gaussian observation model; inspected Pyprobml application. The update rule and tiny counterexample are explicitly course-constructed.

**Core:** Define a binary clean image `z` and Gaussian observations `y`, with standard deviation `sigma` and variance `sigma^2`. Derive the posterior score, the evidence field `y_i/sigma^2`, and the updated local conditional. Distinguish posterior marginal, joint MAP, and a single-coordinate conditional maximizer. Establish sequential coordinate MAP/ICM: pick the better local spin, keep the current value on a tie; each actual change improves posterior score. Work the four-node all-negative fixed-point counterexample against the exact global MAP. Thus deterministic updates need no MCMC stationarity or variational objective, and cannot be described as posterior samples, marginal estimates or guaranteed global MAP.

**Retrospective summary:** Local likelihood evidence and spatial agreement define a posterior energy; coordinate maximization improves it monotonically but may stop at a locally stable configuration with lower probability than the global MAP.

### E. A factor graph makes the model's local computations explicit — about 16 minutes

**Transition in:** Restoration used only the factors touching the updated variable. A common representation can expose these scopes for both directed CPDs and undirected potentials.

**Question/purpose:** What representation preserves the actual product rather than only an adjacency diagram?

**Sources:** B2 §4.6.1.1; optional comparison §4.3.5.1, reusing L01 precision form. B2 §4.3.2.2 supports one brief Potts generalization.

**Core:** Work the binary square's unary/edge factor graph and convert a familiar chain's CPDs into factors. Factors may involve more than two variables; a factor graph is not a claim of independence obtained by treating it as an ordinary variable-only MRF. Recognize Potts agreement factors as a multistate generalization, with no second calculation. Optional within this allocation: a five-minute worked Gaussian precision comparison illustrating a structural zero despite nonzero marginal covariance. Close with retrospective synthesis of factorization, normalization and local conditioning; no message-passing recursion, algorithm zoo or notebook instructions in the ending.

**Retrospective summary:** Variable–factor incidence records which arguments each factor uses; directed CPDs and undirected compatibility scores share a product representation while retaining their distinct normalization and CI meanings.

### Extent and first cut

The substantive estimate is **100 minutes** (14 + 22 + 27 + 21 + 16), including transitions, worked calculations and retrospective summaries; add **12 minutes of reserve** for questions/slippage: **112 minutes total** within the 100–120-minute envelope. The lab is a separate 60 minutes. Confidence is moderate-to-low until downstream design/rehearsal; verdict is **tight but plausible**, driven by new normalization/CI semantics and two linked local-conditional/posterior derivations. Reserve is not extra elective content.

The first cut is the **optional five-minute Gaussian precision worked comparison**. Its removal preserves the binary endpoint and yields about 107 minutes including reserve; retain only recognition that familiar precision structure is related. Next, shorten DAG recall by four minutes if a prerequisite check confirms students can handle the collider/descendant caveat; do not remove the caveat or compensate by accelerating the central conditional derivation. No required content is moved to a recording; no recording is prerequisite. Further overload requires a Scope-owned reduction, not silent loss of a required example. Hammersley–Clifford proof, moralization procedures, GMRF learning and physics phase transitions are excluded rather than hypothetical recording obligations.

Mathematical novelty estimate: **11–13 retained new object/result families**, approximately 10–14 intermediate derivation blocks, 16–24 carried equation appearances, 7–10 conceptual visual/schema groups, and 14–18 substantive source-page equivalents. DAG factorization, Gaussian likelihood, Bayes' rule and `A = log Z` are carry-forward, not new results. Five macrosegments give the calibration warning `S_hat ≈ 25–31` from the provisional formula in `timing-calibration.md`; this is an uncertain relative extent signal, **not** a slide-count target or outline. Fewer new families than L01's 29-slide mathematical core (~22 families) does not license fast delivery: graph semantics, enumeration and new modeling distinctions need interpretation. The 61-content-slide whole-L01 anchor and instructor judgment are pacing priors, not measured teaching rates.

## 2. Mathematical spine

| Object/result | Treatment and delivery | Role and explicit limit |
|---|---|---|
| DAG factorization `p(x) = product_i p(x_i | x_pa(i))`; chain/fork/collider rules; I-map `I(G) ⊆ I(p)` | **Apply/Work** familiar motifs; **State** I-map and collider-descendant criterion; **Live**, A | Calibration of legitimate CI claims. Do not derive a complete d-separation algorithm or assume every open path forces dependence. |
| MRF `p(z) = Z^{-1} product_c psi_c(z_c)`, `Z = sum_z product_c psi_c(z_c)` | **State + Work**, **Live**, B | Local potentials versus a globally normalized distribution. Positive finite examples avoid support pathologies; nonnegative factors are permitted more generally when the normalizer exists. |
| Energy `E(z) = -sum_c log psi_c(z_c)` for positive factors; `p ∝ exp(-E)` | **Derive**, **Live**, B | Log transforms make multiplicative compatibility additive; no requirement `E > 0`. |
| Positive Hammersley–Clifford equivalence: graph-Markov distribution iff clique factorization; global/local/pairwise CI equivalence under positivity | **State**, **Live**, B/C | A qualified representation theorem, not a proof endpoint; factorization's forward CI implications are distinguished from converse hypotheses. |
| Ising score `S(z) = sum_i h_i z_i + sum_{(i,j) in E} J_ij z_i z_j`, `z_i in {-1,+1}`, `E = -S` | **Work**, **Live**, B | Each undirected edge counted once. Match source unary/edge exponential potentials; recognize sufficient statistics using L02. |
| Four-cycle zero-field normalizer `Z(J) = 2 exp(4J) + 12 + 2 exp(-4J)` | **Work** grouped exact enumeration, **Live**, B; **Apply**, Notebook | Concrete normalization beyond CPDs, no general Ising closed-form derivation. |
| Global separation; `z_i independent of z_{V\({i} union N(i))} | z_{N(i)}`; nonadjacent pair CI given the rest | **State + Work**, **Live**, C | Read specified separators correctly; graph entailment is a sufficient CI guarantee for a compatible distribution, not an unqualified claim of faithfulness. |
| `p(z_i | z_-i) ∝ product_{c: i in c} psi_c(z_c)` | **Derive**, **Live**, C | Cancel common factors and `Z`; normalize over the states of one node. This is the reusable lab capability. |
| `H_i = h_i + sum_{j in N(i)} J_ij z_j`; log odds `log[p(+1|rest)/p(-1|rest)] = 2H_i`; `p(z_i=+1|rest)=sigmoid(2H_i)` | **Derive + Work**, **Live**, C | Two-state local normalization; do not confuse a conditional with a marginal. Sigmoid is familiar Bernoulli algebra, not new GLM training. |
| `y_i | z_i ~ Normal(z_i, sigma^2)`; posterior `S(z;y)=sum_edges J_ij z_i z_j + sum_i(h_i+y_i/sigma^2)z_i`, up to a constant | **Derive**, **Live**, D | Expand `(y_i-z_i)^2`, use `z_i^2=1`. Known `J,h,sigma`; no parameter learning. Posterior has its own `Z(y)`, distinct from the prior's `Z`. |
| Sequential update `z_i ← argmax_{s in {-1,+1}} s H_i(y)`; score change for a flip `ΔS = -2 z_i H_i(y)` | **Derive/Work** monotonicity and counterexample, **Live**, D; **Apply**, Notebook | Select `+1` when field positive, `-1` when negative, preserve current value at zero. Strict score increase for actual flips on a finite state space implies termination if run until no changes; a sweep cap only guarantees the improvements achieved so far. No global optimality theorem. |
| Variable–factor incidence for `f(z)=product_a f_a(z_scope(a))` | **State + Work**, **Live**, E | Unified product semantics supporting later L08 algorithms; no sum-product or max-product derivation now. |
| Potts `psi_ij(k,l)=exp(J_P 1[k=l])` | **Mention**, **Live**, E | Multistate extension only; B2's binary agreement parameter satisfies `J_P=2J_Ising` up to constant factors. Not substantive Potts coverage. |
| Gaussian structural zero `Lambda_ij=0 ⇒ X_i independent of X_j | X_-ij` | **Optional Work**, **Live**, E | Reuse L01 quadratic form; five-minute comparison is the first cut. No Gaussian partition-function formula or sparse estimation. |

The critical dependency is product model → normalization/energy → local cancellation → Ising conditional → Gaussian evidence field → coordinate update and its limit. This entire chain stays live. L08 consumes factor scopes; L09 and L10 may reuse the Ising full conditional without inheriting an obligation to reteach its derivation. L06 can rely on the distinction between hidden variables and known parameters, rather than L03 teaching EM.

## 3. Notebook handoff — a scaffolded 60-minute restoration lab

**Anchor:** B2 §4.3.8's Ising prior and Gaussian observation model, with the inspected Pyprobml demonstration as an application reference. **Provisional selected endpoint:** implement and check a local conditional/score calculation, then use supplied deterministic coordinate-update infrastructure to restore a small noisy binary image. This is a course adaptation and needs a newly validated worked solution before teaching; the reference notebook is not the student notebook.

The lecture supplies all probabilistic and update mathematics, including evidence-field scaling, neighbor dependence, marginal-versus-conditional-versus-MAP distinctions and the fixed-point counterexample. No definite recording, Gibbs convergence, stationary distributions, ELBO or mean-field derivation is prerequisite. Existing skills: NumPy arrays, slicing, arithmetic and a supplied plotting interface from L01/L02. New durable skill: **translate factor scopes into a correct local calculation and verify it against an exactly normalized tiny model**. SciPy stable sigmoid/log normalization may be supplied; NumPy/Matplotlib are sufficient for the core. No JAX, PyTorch, probabilistic-library inference call or new package ecosystem is required.

The computational work extends the lecture from a hand-worked square to a finite open-boundary image. Supply enumeration scaffolding, image construction/noise and plotting, edge handling, stopping/bookkeeping and the sequential sweep driver. Students own the local field/conditional calculation and its numerical cross-check; do not ask them to implement every helper, a sampler and a variational solver. Use a course-constructed small geometric binary image with a fixed seed, avoiding unverified external-data downloads. Its exact size, pixel pattern, seed and chosen display settings are downstream worked-solution decisions; they must be explicit and validated there, not attributed to Murphy's letter-A example.

| Approximate lab budget | Work and intended endpoint |
|---|---|
| 10 min | Supplied 16-state square enumeration: verify normalized probabilities and recover one local conditional by division. |
| 15 min | Implement local field/conditional and compare with enumeration; check sign and `sigma^2` scaling. |
| 20 min | Run supplied sequential ICM sweeps on noisy image; inspect posterior-score trace and reconstruction against known truth. |
| 10 min | Change one coupling/noise setting and compare threshold-only reconstruction (`J=0`) with spatial restoration. Run the tiny supplied adverse initialization to identify local stability versus exact MAP. |
| 5 min | Consolidate the local-computation skill and limits of the restored image. |

The single completion result is a verified local computation supporting a restoration with interpretable evidence/smoothness tradeoff and an explicit local-optimum limitation. Pixel error is an illustrative comparison, not a guarantee of improvement for every `J`, image or observation. Parameter sweeps are scaffolded comparisons, not hyperparameter estimation. Default image dimensions/settings require later timing checks; the reference's network access, optional dependency installs and output behavior are excluded from the lab contract. **No runtime/Colab readiness is claimed**: later worked-solution/notebook authoring must satisfy clean local uv and hosted Colab checks independently. If coding extent grows, supply more infrastructure before sacrificing mathematical interpretation.

## 4. Concrete examples and provenance

1. **Positive noisy collider — Work/Compare, Live, A/C.** Course-constructed graph `A → C ← B`, optionally `C → D` solely to recognize descendant activation. `A,B` are independent Bernoulli(1/2); set `p(C=1|A=B=0)=0.1`, otherwise `0.9`. All conditional entries are positive. Marginal independence follows from the source DAG factorization; conditioning on `C=1` produces dependence for these specified parameters. For example `p(A=1|C=1)=9/14`, `p(A=B=1|C=1)=9/28`, unequal to `(9/14)^2`. B2 §§4.2.4.1–4.2.4.2 supplies the phenomenon; these numbers and the optional descendant node are course choices, not Murphy's student/sprinkler CPTs. No numerical CPT is promised for D. Reuse the same graph to contrast arrow deletion with valid CI entailments; no second elaborate DAG.

2. **Four-node open square — Work through, Live, B/C and Notebook.** Course-constructed numbering: top row `1,2`, bottom row `3,4`; **exact edge set `{(1,2),(1,3),(2,4),(3,4)}`**, no diagonals or periodic wraparound, `h_i=0`, common `J`. This is a four-cycle instance of B2 §4.3.2.1, not a copied source figure. Sixteen configurations group as interaction sums `+4` (2 states), `0` (12), `-4` (2); hence the stated normalizer. At `J=0.5`, `Z≈27.0487827643`; at `J=0`, `Z=16`. The graph entails `z_1 independent of z_4 | (z_2,z_3)` and `z_2 independent of z_3 | (z_1,z_4)`; `{2}` alone does not separate 1 from 4. All node neighbors and separators are checked against this exact edge set. An independently executed 16-state arithmetic check verified the grouping and normalizer; it is not notebook execution or source attribution.

3. **Observation fields and a local optimum — Work through, Live, D; application enlarged in Notebook.** On the same square set `J=0.5`, `h_i=0`, `sigma^2=1`, `y=(0.2,0.2,0.2,0.2)`. In the all-negative state each field is `0.2-1=-0.8`, so every ICM update stays negative. Its score is `1.2`; the all-positive state has score `2.8` and is the exact global MAP (verified across all 16 states). Each flip from all-negative initially lowers the score although a coordinated switch improves it. This exact counterexample is course-constructed from the specified source model. It demonstrates an algorithmic limitation rather than an image-restoration quality claim. Use the same unary/edge scopes for the required factor graph; observed y contributes unary factors on z after conditioning.

4. **Gaussian conditional versus marginal dependence — Optional Compare/Work, Live, E.** Course-constructed zero-mean Gaussian with `Lambda=[[2,-1,0],[-1,2,-1],[0,-1,2]]`; inverse `Sigma=(1/4)[[3,2,1],[2,4,2],[1,2,3]]`. Thus `Sigma_13=1/4` but `Lambda_13=0`, illustrating `X_1 independent of X_3 | X_2`. B2 §4.3.5.1 supplies the structural-zero principle and L01 supplies Gaussian conditioning; these exact matrices are our example, not the printed AR(1) illustration. Positive definiteness follows from positive leading principal minors `2,3,4`. First cut under time pressure.

Required conceptual visual/schema groups are modest: directed motifs/collider, spatial graph, 16-state grouping, separator/neighbor scopes, conditional odds, observation-plus-prior model and its factor graph, and local/global comparison; optional Gaussian/Potts comparisons add at most two groups. No source raster figure is required and no image asset is generated at Scope stage. Source Figs. 4.15, 4.26 and 4.46–4.47 were inspected as explanatory references; their exact drawings/results are not approved asset commitments. Do not reproduce the phase-transition or mean-field restoration figures as this lecture's experimentally verified output.

## 5. Lecture contract

**Starting assumptions:** rigorous probability/conditioning, undergraduate DAG and Bayesian modeling familiarity; actual L01 Gaussian/LGS results and NumPy practice; agreed L02 exponential-family/log-partition and Markov-chain results. Graphical CI nuances receive compact recall. Formal VI, Gibbs correctness and stationary Markov-chain theory are not prerequisites.

**Central question:** How do local compatibility factors define a global probability distribution, and what can be computed locally without its global normalizer?

**Lecture endpoint:** Students can specify and normalize a tiny positive Ising MRF, read its separator/neighbor CI guarantees, derive its full conditional, attach Gaussian local evidence and justify a coordinate restoration update together with its nonglobal limitation. They can represent the product as a factor graph.

**Notebook endpoint:** A checked local conditional implementation and a scaffolded binary-image restoration, with an exact tiny-model reference and an honest distinction between coordinate optimum, joint MAP and posterior marginals. No definite required recording.

**Supported learning outcomes:** (1) distinguish normalized DAG CPDs from MRF potentials and global normalization; (2) use graphical CI with positivity/faithfulness caveats; (3) derive the Ising local conditional by factor cancellation; (4) turn Gaussian evidence into a posterior field and explain coordinate ascent's limits; (5) map variable/factor incidence to a numerical local computation.

### Allocation and bookkeeping obligations

| Category | Material / downstream obligation |
|---|---|
| **Core/Live, deep** | B2 §§4.3.1.1–4.3.1.2, §4.3.2.1, §4.3.6.1; selected §4.3.8 model with course-derived conditional and ICM mathematics. §4.6.1.1 factor-graph representation substantive at State/Work depth, not inference algorithms. |
| **Short bridge, recognize/apply** | B2 §§4.2.1, 4.2.4.1–4.2.4.3 and §4.5.1 selected collider/blanket distinctions; §4.3.4.1 recognition of L02 family structure; B1 §§3.6.1–3.6.2 supporting recall. These are selective content, not complete section coverage. |
| **Notebook owned** | Scalable local computation and deterministic restoration; tiny enumeration as correctness check. Parameter values remain known. Primary new computational practice, not claimed Gibbs/VI coverage. |
| **Optional** | B2 §4.3.5.1 Gaussian precision comparison; Potts from §4.3.2.2 is Mention only. Neither is promised as substantive formal-syllabus coverage. |
| **Deferred to named owner** | Exact structured sums/messages and elimination concepts → L08; formal VI/mean field → L09; formal Gibbs/MCMC/MC estimation → L10. Ising gives an example they may reuse; it does not obligate later lectures to implement denoising again. |
| **Omitted by course decision** | B2 §4.2 extensive BN examples/parameter learning/plate tutorial, graph structure learning, §4.3.2 Potts physics/protein/Hopfield developments, §4.3.3 Boltzmann/RBM catalogue, §4.3.4 feature induction, §4.3.5 nonlinear GMRF/INLA, §4.3.9 MRF learning/pseudolikelihood, §4.4 CRF learning, §4.5 full conversion/label-bias/mixed-graph taxonomy, §4.6.1.2 Forney machinery and §§4.6.2 onward circuit/relational/causal extensions. Mentioned phenomena do not become deferred debts. |

**Proposed boundary:** B2 progression through core Ch. 4 and bipartite §4.6.1.1, with explicit selective omissions above; B1 §3.6 is supporting recall, not a claim that intervening B1 material was taught. Coordinator should update planned-allocation rows only after review; actual ledger dispositions remain Unreached until delivery. Formal syllabus must narrow §§4.3.7–4.3.9 from apparent sampling/inference/learning coverage to the specific model/local-computation commitment, and avoid substantive Potts/CRF promises. No shared artifact was edited by this builder.

### Consequential questions and residual risks for the coordinator

- **L03 practical-method choice — Scope owner / advisory, medium priority.** Is deterministic coordinate MAP acceptable as the first image-restoration endpoint, with stochastic and variational inference explicitly postponed? Evidence: reference methods require later theory; local ICM is fully derivable now and has the verified failure example above. Provisional choice is ICM plus exact tiny enumeration. Alternative: restrict the lab entirely to exact tiny-grid posterior inference; lower coding risk but lose the larger image outcome. Requiring formal Gibbs or mean-field now would change cross-course ownership and add unbudgeted mathematics; expose that as an instructor question rather than tacitly approving it.
- **Optional GMRF bridge — Scope owner / advisory, low priority.** Keep five minutes of precision comparison or protect extra reserve? The bridge makes L01 continuity visible but adds a second model family. Provisional inclusion is optional, explicitly first cut; removing it changes no required endpoint and incurs no later prerequisite debt.
- **Reference reliability and lab size — Notebook authoring owner / downstream-owned.** Inspected source has inconsistent noise scaling and unverified outputs. The proposed adaptation must obtain a technically validated worked solution, record its image parameters and demonstrate 60-minute student feasibility; use scaffolded infrastructure and small images. No runtime evidence exists here. Failure of the later lab timing check should reduce implementation load locally first, escalating if the mathematical endpoint must change.
- **Actual L02 delivery — Coordinator / advisory dependency risk.** `A=log Z` and elementary Markov-chain factorization are agreed, not delivered. If delivery changes, retain recognition of the Ising family's form and prioritize local normalization; return any material backfill/time cost to the owning scope. Do not rewrite L02 retrospectively.

**Next owner:** Instructor oversight of this reviewed proposal. Subsequent Section Design requires human acceptance; its execution backpressure returns to the nearest owning stage. Review and approval provenance are in the registry. No rehearsal, notebook runtime or hosted Colab validation is implied.
