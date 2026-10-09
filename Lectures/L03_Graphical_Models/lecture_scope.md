# Lecture 3 Scope — Graphical Models

**Course:** Probabilistic Machine Learning: Advanced Topics (2027-1)  
**Status:** Agreed scope for section planning; lecture structure and slide design not specified  
**Primary text:** Murphy, *Probabilistic Machine Learning: Advanced Topics* (Book 2), Chapter 4  
**Planned format:** Approximately 2 hours of live lecture and 1 hour of in-class notebook work

**Scope-authoring constraint:** This document deliberately does **not** define lecture sections, section boundaries, section titles, individual slide topics, or topic-by-topic time allocations. The later section planner should determine that organization from the goals, dependencies, source material, and extent constraints below. Headings in this document identify scope components, **not** lecture sections.

## Starting assumptions and prior-course boundary

The actual L01 slide deck includes a Beta–Bernoulli graphical model and a brief statement that graphical models can factor complicated problems, but does not teach general DAG factorization, d-separation, Markov blankets, or plate notation. L01 teaches Gaussian conditioning, joint/marginal reasoning, and linear-Gaussian systems; its notebook applies those ideas to missing data. The L01 material ledger records Book 1 through §3.3 and Book 2 through §2.3.2 as the primary boundaries.

The agreed L02 design develops exponential-family representations, the log-partition function, moment matching, categorical MLE, and a learned Markov-chain model, with a character-bigram notebook. Treat these as the intended immediate prerequisites, but distinguish the agreed L02 design from an actually completed/delivered L02 artifact. The students also bring undergraduate probability, Bayesian modeling and some experience reading simple DAGs; **do not assume they know d-separation or plates**.

The course's guiding question remains how the structure of a joint distribution and the probabilistic query determine computational possibilities and methods. Book 2 is the curricular spine. Book 1 §§3.6.1–3.6.2 may provide brief orientation if useful, but no separate Book 1 treatment is required. The current syllabus planning decisions take precedence over the old formal syllabus.

## Intellectual arc

Begin from the first-order Markov-chain factorization already developed in L02. Use it to recover the ordinary probability chain rule, then show what is additionally assumed when the conditional for each variable only needs its graph parents. Generalize to the factorization of a directed acyclic graph (DAG), with the familiar Markov chain as a special case. The **student network** in Murphy §4.2.2.2 provides the concrete non-chain example: students should see the difference between an unrestricted joint distribution and a product of small conditional probability distributions (CPDs). This makes Murphy's quantitative argument substantive: sparsity and conditional-independence assumptions can dramatically reduce the number of parameters needed to represent a large joint distribution. Mention plate notation as a compact way to draw repeated variables, since L01 did not introduce it.

The graph is not merely a convenient picture of the factorization; it asserts conditional-independence properties. Develop how those assertions are read in a DAG: the pipe/chain, fork/common cause, and collider/v-structure; the effect of conditioning on each; explaining away; d-separation over paths; and directed Markov blankets (parents, children, and co-parents). Include the role of descendants of colliders when stating the general rule. Preserve the distinction between independences *entailed by the graph* and additional independences that may hold for special parameter values in a particular distribution. Directed edges encode conditional structure, **not necessarily causation**.

Introduce undirected graphical models positively as **models of local interactions**, particularly in spatial or relational settings where associations are reciprocal and a directional ordering is not the natural structure. Murphy's directed-versus-undirected image-lattice comparison (Figure 4.15) makes the change concrete. Formulate an undirected distribution through local clique potentials and a global partition function; relate products of potentials to Gibbs/energy form and to L02's log-partition viewpoint. In an undirected graph, conditional-independence assertions follow from ordinary graph separation, and the Markov blanket of a node consists of its neighbors. Contrast this with d-separation and directed Markov blankets. State the Hammersley–Clifford connection between positive distributions, undirected Markov properties, and clique factorization, without a theorem proof.

Use the **undirected four-cycle** in Murphy §4.5.1 (Figure 4.37) to establish a precise conceptual distinction: the graph A–B–C–D–A encodes the separations A ⟂ C | {B,D} and B ⟂ D | {A,C}; no DAG over the same four nodes has exactly that independence structure. Conversely, a directed collider can encode independences that an undirected graph cannot encode exactly. The point is **complementary graphical independence languages**, not that one representation is universally stronger or that the probability chain rule ever fails.

The substantive lecture endpoint is a concise **definition and interpretation of the binary Ising model**, including pairwise neighbor agreement, coupling strength/sign, and example configurations; then illustrate its application to noisy-image restoration as a motivating probabilistic task. **Do not construct the image-restoration prior/likelihood factorization, observation-noise model, posterior, local conditional, or inference algorithm live.** Those are the students' new mathematical and computational work in the notebook, not lecture material already worked through.

## Mathematical spine and treatment depth

These are mathematical obligations and their intended depth, **not** an ordered outline or a partition into teaching sections. All listed live items remain live; no recording is currently required.

| Mathematical object or result | Treatment | Delivery and boundary |
|---|---|---|
| First-order Markov factorization, p(x₁:T) = p(x₁)∏ₜ₌₂ᵀ p(xₜ∣xₜ₋₁) | Recall; apply | Live, explicitly carried forward from L02 |
| Probability chain rule vs. DAG/parent factorization, p(x₁:D) = ∏ᵢ p(xᵢ∣x_pa(i)) | Derive from the chain rule plus the ordered Markov assumption | Live; distinguish a general identity from a structural assumption |
| Locally normalized CPDs/CPTs; sparse factorization's parameter advantage | State; work the student network; motivate the scaling O(Kᴰ) vs. O(D K^(m+1)) for bounded indegree m | Live; no separate CPT-learning derivation |
| Plate notation and the factorization of repeated IID observations | Recognize; interpret one diagram and the corresponding product | Live, brief convention; not an extended plate-notation lesson |
| Directed pipe, fork, and collider conditional-independence patterns; explaining away | Derive or justify with small factorizations/conditionals; work graph queries | Live, substantial mathematical treatment; include collider-descendant qualification |
| d-separation and directed Markov blanket | State the general criteria and apply them to nontrivial graphs | Live; no full Bayes-ball algorithm or proof of equivalence of Markov properties |
| Graphical I-map interpretation | Explain that a graph entails CI constraints without asserting that all unblocked paths imply dependence | Live, concise precision rather than formal I-map theory |
| Undirected clique-potential factorization and global partition function Z | Define; explain global normalization; work a small generic potential-product example | Live; do not derive the Ising image-restoration model |
| Gibbs/energy representation, p(x) ∝ exp(−E(x)) | Relate mathematically to products of positive potentials | Live; no physical thermodynamics or optimization survey |
| Undirected graph separation and local Markov blanket | State; apply to spatial lattice or a small graph; contrast with DAG rules | Live |
| Hammersley–Clifford theorem | State with positivity qualification and interpret | Live; no proof |
| Directed/undirected independence expressivity, including collider and four-cycle | Work the CI contrast and explain why exact sparse representability differs | Live; no general graph-conversion or chordality theory |
| Binary Ising distribution, p(z∣J) ∝ exp(J ∑_(i,j)∈E zᵢzⱼ), zᵢ∈{−1,+1} | State and interpret; compare representative configurations or samples | Live; **do not** derive local site probabilities or image posterior |
| Gaussian corruption likelihood, image joint/posterior, local conditionals, and iterative conditional modes (ICM) | Construct; derive; implement; evaluate | **Notebook only**, with suitable scaffolding |

The ability to derive the simple DAG factorization, correctly reason about d-separation, and interpret MRF normalization and separation are higher priorities than introducing more model families. Avoid using the mathematical spine as a mandate for a separate presentation block for each line.

## Notebook handoff

**Task:** Given a clean binary image and noisy observations, construct and use a probabilistic image-restoration model. The model is *not* solved in the lecture.

**Primary source:** Murphy Book 2 §4.3.8 and its Ising image example, relying on §4.3.2.1. Murphy's public `ising_image_denoise_demo.ipynb` provides an inspectable related example but uses mean-field and Gibbs methods reserved for later lectures; it also needs correctness verification and should **not** be adopted as a drop-in student solution. A separate ICM-based image-restoration example (salimandre/Markov-Random-Fields) provides another reference for a simple local-MAP approach. Prepare and validate an instructor solution before authoring the student exercise.

**Student mathematical work:** Explicitly choose and formulate the Ising prior; formulate a Gaussian observation/noise likelihood with consistent standard-deviation/variance notation; identify graphical factorization and construct the joint distribution; derive the posterior up to proportionality; derive the single-site posterior conditional or equivalent local log odds by canceling factors that do not involve the current site; and connect that result to a local MAP decision. Do not pre-provide the completed prior–likelihood–posterior derivation from the lecture.

**Student computational work:** Use provided binary-image/noisy-image data and a lightweight NumPy-based scaffold to implement or complete iterative conditional modes; compare against a pixelwise/no-spatial-prior baseline; change coupling strength and noise assumptions; evaluate behavior and at least one limitation (initialization sensitivity or a local optimum). No PyTorch, JAX, general MCMC, or mean-field VI is necessary.

**Conceptual endpoint:** Students can go from a graphical model's local factors to a concrete posterior computation and a working, imperfect restoration method; they understand the difference between a locally improving MAP algorithm, global MAP, and posterior marginal inference. For attractive binary pairwise models, global MAP may admit special exact graph-cut methods; do **not** claim that all global MAP computation is intractable.

**Feasibility:** Building a model, deriving the conditional and implementing ICM in one hour is demanding. Supply the image/data preparation, plotting, stable notation, small implementation interfaces, and verification aids rather than reducing the conceptual derivations to copy-and-paste. Preserve the four notebook design criteria: mathematical contribution, inspectable worked reference, non-repetition of the lecture, and a durable computational skill. The exact exercise scaffolding and runtime must be validated during notebook authoring.

No separate recording is a prerequisite for the notebook.

## Concrete examples and source provenance

These are **example candidates selected for their distinct jobs**, not a proposed order or allocation to sections.

| Example / source | Teaching job | Intended treatment |
|---|---|---|
| L02 first-order Markov model; Murphy Book 2 §§2.6 and 4.2.2.1, Fig. 4.1 | Reconnect the prior lecture to graph factorization | Carry forward / work |
| Murphy Book 2 §4.2.2.2, student network, Fig. 4.2 | General DAG factorization with multiple parents; CPD parameter economy; reusable collider example | Work through |
| Murphy Book 2 §4.2.4, Figs. 4.4–4.8 as applicable | Pipes, forks, colliders, explaining away and directed Markov blanket queries | Work through selected cases; not every figure |
| Murphy Book 2 §4.2.8, Fig. 4.11 (repeated observations and plate) | Introduce graphical plate shorthand not present in L01 | Brief |
| Murphy Book 2 §4.3 introduction, Fig. 4.15 (directed and undirected image lattice) | Show undirected local-interaction structure and different Markov blankets | Compare |
| Murphy Book 2 §4.5.1, Fig. 4.37 (four-cycle), plus collider comparison | Establish a precise difference in CI representational power | Work/compare, after the relevant concepts are established |
| Murphy Book 2 §4.3.2.1 Ising examples (including Fig. 4.17) and §4.3.8 image-restoration application | Show meaning of the distribution and motivate notebook inference, without solving it | Definition/interpretation and brief application only |

The section planner should select only the figures that actually earn teaching time; listing a source figure is not a commitment to reproducing every panel.

## Lecture contract

**Starting knowledge:** Bayesian probability and conditional distributions, L01 graphical-model notation and Gaussian reasoning, and L02 exponential families, categorical CPDs, and Markov-chain factorization. No prior d-separation or plate-notation mastery assumed.

**Central question:** How can graphical structure turn a large joint probability distribution into interpretable local factors, and how does it tell us which conditional independences are assumed?

**Live lecture endpoint:** Students can read and factorize a DAG, infer its core conditional-independence implications, recognize the different factorization and separation rules of an undirected graph, understand the role of local potentials and global normalization, and interpret a binary Ising distribution as a model of spatial interaction.

**Notebook endpoint:** Students construct the prior and likelihood for noisy binary-image restoration, derive and implement a local posterior-based restoration method, and diagnose its behavior.

**Learning outcomes:** Students should be able to (i) distinguish a probability-chain-rule identity from a DAG independence assumption; (ii) use d-separation and Markov blankets to reason about graphical CI; (iii) interpret plate notation; (iv) contrast CPD products with globally normalized MRF potentials, including what graph separation means; and (v) apply those ideas in an original notebook model and local inference computation.

**Recording status:** No required recording; no recording candidate assigned at scope freeze. Avoid shifting essential independence and factorization reasoning out of live teaching solely to fit a slide-count target.

**Extent constraint:** Approximately **100 minutes of planned substantive live exposition within a 120-minute lecture window**, leaving around 20 minutes for questions, graph reasoning, and delivery variability. This is a complexity-based provisional estimate, not measured timing. L01's **61 content slides / 70 rendered pages** are a course-specific density benchmark, not a requirement or a slide budget. Section planning and actual drafting must re-estimate extent based on selected examples, equation novelty, figures and derivations; no lecture section counts or slide allocations are fixed here. Preliminary feasibility: **plausible but somewhat tight** if explanations of d-separation and MRF factorization are worked carefully.

## Explicit boundaries and later connections

**Do not cover as lecture methods:** construction of the full Ising-image posterior or Gaussian noise terms; derivation of its single-site posterior conditional; ICM; mean-field VI; Gibbs sampling; loopy belief propagation; graph-cut optimization; MRF parameter learning/pseudolikelihood; CRFs; Potts/Hopfield/RBM surveys; detailed plate-model examples; ancestral sampling algorithms; DAG CPT parameter-learning derivations; moralization algorithms; factor graphs/message-passing algorithms; graph chordality proofs; or Hammersley–Clifford proof.

A short mention that directed factorization supports ancestral generation is permissible, but a substantive generative-sampling development is not part of this scope. L07 can potentially exploit sparse Gaussian or message-passing connections; L08 and L09 have particularly natural Ising returns for CAVI/mean-field and Gibbs sampling (Murphy §§10.3.2 and 12.3.3). These are **future opportunities, not obligations created by L03**.

**Prospective material-ledger implications (do not rewrite the ledger just from this scope file):** Book 2 §§4.2.1–4.2.2, 4.2.4, selected §4.2.8, §§4.3.1–4.3.2.1, and §4.3.6.1 are primary live material; §4.5.1 is a substantive isolated comparison and need not move the main boundary. Book 2 §4.3.8 is the primary notebook application, not full live coverage. Intervening MRF chapters and specialized methods are not implicitly covered by their section numbers. Book 1's curricular boundary need not change. Record actual lecture/notebook dispositions once the corresponding artifacts are completed, rather than marking planned coverage as already delivered.

**Sources of authority:** L01 actual slide deck and material ledger; agreed L02 section design; Murphy Book 2 Ch. 4 (in particular §§4.2.1–4.2.4, 4.2.8, 4.3 introduction, 4.3.1, 4.3.2.1, 4.3.6, 4.3.8, 4.5.1); current syllabus-planning decisions; and instructor decisions in the L03 scope discussion.
