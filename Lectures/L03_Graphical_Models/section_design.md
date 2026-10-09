# Lecture 3 section design — Graphical Models

**Status:** Proposed section organization for instructor review; not yet approved for slide-level organization.  
**Authoritative scope:** [lecture_scope.md](lecture_scope.md) on `lecture-3-authoring`.  
**Primary text:** Murphy, *Probabilistic Machine Learning: Advanced Topics* (Book 2), Chapter 4.  
**Intended delivery:** Approximately two hours of live lecture, followed by a separate one-hour student notebook.

This document partitions the agreed scope into **section-level contracts**. It defines section boundaries, intellectual jobs, prerequisites, mathematical treatment, examples, endpoints, and provisional live times. It is **not** a slide inventory or a notebook specification. Once these boundaries are approved, use `skills/slide-level-organization/SKILL.md` on one section at a time. Do not infer that a section heading, example, or equation here requires exactly one slide.

The scope file governs any apparent conflict. In particular, the lecture/notebook boundary at the Ising-image application must not move without an explicit upstream scope decision.

## Lecture-level frame

### Intellectual trajectory

Learned first-order Markov chain (L02) → general chain rule versus graph-based conditional-independence assumptions → DAG factorization and sparse CPDs (student network) → directed independence patterns → d-separation and Markov blankets → local interactions in undirected models → clique potentials, global normalization, and Gibbs form → undirected separation and the non-equivalence of directed/undirected CI languages → binary Ising distribution → **unsolved** image-restoration problem for the notebook.

The structural through-line is: **What restrictions on a joint distribution are represented by this graph, and what do those restrictions let us factor or infer?**

### Starting assumptions

- L01 actually taught joint/marginal/conditional Gaussian reasoning and simple graphical notation, but not general DAG factorization, d-separation, Markov blankets, or plates.
- L02 has an *agreed design*, not necessarily a completed or delivered artifact. Its intended endpoint supplies the first-order Markov factorization, learned categorical transition distributions, and character-bigram example. Begin by recalling that model rather than assuming every L02 slide was delivered.
- Students already know undergraduate probability and Bayesian modeling and have encountered elementary DAG pictures. Do **not** assume they know d-separation or plate notation.
- Book 2 Ch. 4 is primary. Book 1 §§3.6.1–3.6.2 can inform a very short orientation, not a parallel treatment. The current syllabus-planning decisions override the old formal syllabus.

### Extent and emphasis

Plan **about 100 minutes of substantive live exposition in a 120-minute lecture window**, leaving roughly 20 minutes for questions, worked graph queries, transitions, and delivery variability. The allocations below are provisional complexity estimates, **not measured or guaranteed times**.

| Section | Live minutes (provisional) |
|---|---:|
| 1. From Markov chains to Bayesian networks | 19 |
| 2. Conditional independence in directed graphs | 20 |
| 3. Reading independence from an entire DAG | 20 |
| 4. Undirected graphical models: local interactions and global normalization | 18 |
| 5. What directed and undirected graphs say about independence | 14 |
| 6. The Ising model: a probabilistic model of spatial interaction | 9 |
| **Substantive total** | **100** |

The demanding work is in Sections 2–3, where students learn genuinely new CI reasoning, and Sections 4–5, where they learn a different factorization and separation language. Protect those derivations and applications over adding more model families. L01's 61 content slides / 70 rendered pages are an extent benchmark, **not** an L03 target or a slide allocation. Re-estimate the workload from actual teaching moves at the next stage. No recording is required or assigned.

### Whole-lecture boundary

**Live:** DAG factorization; sparse conditional distributions; plate interpretation; directed CI motifs, explaining away, d-separation, Markov blankets, and I-map precision; MRF potentials and partition functions; Gibbs/energy form; undirected separation, positivity-qualified Hammersley–Clifford statement; four-cycle/collider expressivity contrast; binary Ising definition and interpretation.

**Notebook only:** choose and express image-restoration Ising prior and Gaussian noise likelihood; derive the image joint, posterior, and single-site conditional/log odds; derive and implement local MAP/ICM updates; compare and diagnose the method. The lecture may *motivate the restoration task*, but must not solve these notebook steps.

**Outside lecture scope:** DAG CPT learning, extended plate examples, ancestral sampling algorithms, Bayes-ball algorithm, MRF learning/pseudolikelihood, general CRFs/Potts/Hopfield/RBM surveys, factor graphs/message passing, moralization/chordality machinery, Hammersley–Clifford proof, mean-field/Gibbs/loopy BP, ICM, and graph cuts. Do not treat merely skipped intervening Book 2 subsections as implicitly covered.

---

## Section 1 — From Markov chains to Bayesian networks

**Status:** Proposed for section-boundary review.

### Purpose / role

Transform the L02 Markov-chain factorization from a special sequence model into a general statement about representing a joint distribution through **small, locally normalized conditional distributions**. Establish the distinction between a chain-rule identity and the extra conditional-independence assumptions expressed by a DAG. Make the quantitative gain from a sparse graph tangible, not just pictorial.

### Entry condition / transition in

Recall the learned L02 Markov chain and its first-order factorization. Ask what changes when a sequence is replaced by an arbitrary collection of dependent variables, and why one should not simply store the unrestricted joint table.

### Endpoint

Students can write a DAG's parent-based factorization, identify its CPDs/CPTs, and explain why a bounded number of parents reduces parameter requirements. They can also read a simple plate as shorthand for repeated observations.

### Sources and example jobs

- L02 Section 8, Book 2 §§2.6 and 4.2.2.1, and Fig. 4.1: **carry forward** first-order Markov structure.
- Book 2 §§4.2.1–4.2.2.2, especially the **student network**, Fig. 4.2: **work through** a genuinely non-chain DAG with multiple parents and local CPDs; reuse that network later for CI.
- Book 2 §4.2.8, Fig. 4.11: **briefly interpret** one repeated-observation plate and its product factorization.

### Assigned content and mathematical treatment

- First-order Markov factorization — **Recall + Apply**:
  \(p(x_{1:T})=p(x_1)\prod_{t=2}^{T}p(x_t\mid x_{t-1})\).
- Unrestricted probability chain rule — **State/Recover** for a topological ordering, followed by the *additional* ordered Markov assumption — **Derive + Contrast**:
  \(p(x_{1:D})=\prod_{i=1}^{D}p(x_i\mid x_{1:i-1})\)
  versus \(p(x_{1:D})=\prod_{i=1}^{D}p(x_i\mid x_{\mathrm{pa}(i)})\).
- Local normalization of each CPD/CPT; student-network factorization — **Work** with the actual network.
- Sparse-graph parameter advantage — **Motivate + Compare** generic scaling \(O(K^D)\) versus \(O(DK^{m+1})\) for bounded indegree \(m\), distinguishing order-of-growth illustration from an exact parameter count.
- Plate notation — **Recognize + Interpret**, including a simple IID product; no extended plate lesson.

### Boundary / exclusions

Do not begin the systematic CI motif treatment, d-separation, CPT parameter learning, or ancestral sampling. A student-network collider may be visible in the diagram; the *effect of conditioning* on it belongs to Section 2.

### Take-home

The chain rule is always valid. A sparse DAG factorization is a **modeling restriction** that can make a large joint distribution compact and interpretable.

**Extent:** ~19 minutes.

---

## Section 2 — Conditional independence in directed graphs

**Status:** Proposed for section-boundary review.

### Purpose / role

Show that a graph's local factorization is more than a storage trick: it also implies conditional independence, and conditioning can either remove or create dependence. Build the three fundamental motifs carefully before introducing general path reasoning.

### Entry condition / transition in

Section 1 produced local CPD factorizations. Ask what those factorizations assert about dependence between variables and how observing a variable changes the answer.

### Endpoint

Students can correctly reason through pipe/chain, fork, and collider patterns, including why observing a collider can produce explaining away. They understand why marginal and conditional independence are not interchangeable.

### Sources and example jobs

- Book 2 §4.2.4, selected Figs. 4.4–4.8: **work through** small motif distributions and their conditional independence statements.
- The student network from Section 1: **revisit** as a meaningful collider / explaining-away query rather than adding an unrelated new network.

### Assigned content and mathematical treatment

- Conditional independence as \(X\perp Y\mid Z\) and a restriction on the distribution — **Recall + Apply**.
- Pipe \(X\to Z\to Y\) and fork \(X\leftarrow Z\to Y\) — **Justify/Derive** from simple factorizations why conditioning on the middle variable blocks their path.
- Collider \(X\to Z\leftarrow Y\) — **Justify/Derive** why the path is blocked without conditioning and can open when conditioning on \(Z\); make explaining away concrete through the student network or another small conditional calculation.
- Distinguish graphical structural assertions from statements based on informal causal stories — **Emphasize** that arrows encode conditional structure, not necessarily causation.

### Boundary / exclusions

Keep attention on **single-path motifs** and their worked conditionals. Section 3 generalizes these rules across multiple paths and introduces collider descendants, d-separation, and directed Markov blankets. Do not teach a full path-search algorithm or causal intervention interpretation.

### Take-home

Conditioning blocks pipes and forks but can open colliders. This reversal is why reading CI from a DAG takes more than simply following connected edges.

**Extent:** ~20 minutes.

---

## Section 3 — Reading independence from an entire DAG

**Status:** Proposed for section-boundary review.

### Purpose / role

Generalize the three local motif rules into a rigorous, usable criterion for graphs with multiple paths. Develop directed Markov blankets as a particularly useful consequence, and state precisely what conclusions graph structure does and does not license.

### Entry condition / transition in

Section 2 handled one path at a time. Now ask whether two nodes are independent when *several* paths might connect them, with observed variables occurring at different places along those paths.

### Endpoint

Students can apply d-separation to nontrivial DAG queries; handle descendants of colliders; construct the directed Markov blanket of a node; and distinguish independence **entailed by a graph** from possible extra independences of a special parameterized distribution.

### Sources and example jobs

- Book 2 §4.2.4, selected multi-node illustrations including Figs. 4.4–4.8: **work** at least one multi-path CI query.
- The student network: **reuse where useful** to reason about a blanket or collider-descendant query without requiring a fresh complex model.

### Assigned content and mathematical treatment

- General d-separation rule — **State + Apply** to paths: a path is blocked if an observed non-collider lies on it, or if a collider on it has neither itself nor any descendant observed. Two node sets are d-separated when **every** connecting path is blocked.
- At least one nontrivial graph query with multiple paths and explicit conditioned sets — **Work**, not merely recognize a diagram.
- Directed Markov blanket — **State + Derive/Justify + Apply**: parents, children, and other parents of the node's children (co-parents).
- Graphical I-map interpretation — **Explain concisely**: d-separation guarantees CI in a distribution Markov with respect to the DAG; an unblocked path does **not** logically guarantee dependence for every parameter setting.

### Boundary / exclusions

No full Bayes-ball algorithm, Markov-property equivalence proofs, causal graph identification, or generic model-inference procedure. Do not pre-empt the undirected separation rule before students have seen undirected factorization.

### Take-home

D-separation turns a DAG into a language for **guaranteed** conditional independences; the directed Markov blanket identifies the local neighborhood needed to screen off a node from the rest.

**Extent:** ~20 minutes.

---

## Section 4 — Undirected graphical models: local interactions and global normalization

**Status:** Proposed for section-boundary review.

### Purpose / role

Introduce undirected graphs **positively**, as natural models for local, reciprocal relationships in spatial or relational systems. Establish the mathematical contrast with DAGs: products of unnormalized local interaction potentials require a **global** partition function. Reconnect the resulting Gibbs form to L02's log-partition viewpoint.

### Entry condition / transition in

Directed factorization works well when we can describe each variable conditionally on graph parents. For neighboring pixels or symmetric local interactions, ask how to specify a joint distribution **without choosing a directional ordering**.

### Endpoint

Students can read an MRF as a graph of local interactions, build and interpret a small product of clique potentials, recognize the partition function as global normalization, and translate a positive potential product into Gibbs/energy form.

### Sources and example jobs

- Book 2 §4.3 introduction, especially Fig. 4.15: **compare** directed and undirected image lattices to motivate why local interactions deserve their own graphical language.
- Book 2 §4.3.1: **work** a small generic clique/pairwise-potential example. Keep this separate from the image-restoration model students must construct.
- Book 2 §4.3.2.1 supplies context for the eventual Ising specialization, but the Ising definition itself is reserved for Section 6.

### Assigned content and mathematical treatment

- Undirected edges as local interactions rather than parent–child dependence — **Motivate** via an image lattice or comparable spatial setting.
- Clique potentials and global normalization — **Define + Work**:
  \(p(x)=Z^{-1}\prod_{c\in\mathcal C}\psi_c(x_c)\),
  \(Z=\sum_x\prod_{c\in\mathcal C}\psi_c(x_c)\) in the discrete case.
- Compare locally normalized directed CPDs with globally normalized undirected potentials — **Explain explicitly**: a potential need not integrate/sum to one on its own.
- Gibbs/energy form — **Derive/Interpret** for positive potentials:
  \(p(x)=Z^{-1}\exp[-E(x)]\), with \(E(x)=-\sum_c\log\psi_c(x_c)\).
- Relate \(\log Z\) to normalization/log-partition language from L02 — **Brief conceptual bridge**.

### Boundary / exclusions

Use an **abstract local-potential example**, not a worked Ising-image prior/likelihood factorization. Defer MRF CI/separation and Hammersley–Clifford until Section 5. No physical-thermodynamics detour, learning, or inference algorithms.

### Take-home

Undirected models describe local interactions through **potentials**, but their probability distribution is normalized **globally**.

**Extent:** ~18 minutes.

---

## Section 5 — What directed and undirected graphs say about independence

**Status:** Proposed for section-boundary review.

### Purpose / role

Teach how CI is read from an undirected graph and why this is a genuinely **different independence language** from DAG d-separation. Make the distinction exact through the undirected four-cycle and the converse directed collider example, not through broad claims that one model class is stronger.

### Entry condition / transition in

Section 4 supplied an undirected factorization and its global normalizer. Ask what independences are expressed by the absence/presence of undirected paths, and whether a DAG could always encode the same ones.

### Endpoint

Students can use ordinary undirected graph separation, identify the neighbor Markov blanket, state the positivity-qualified Hammersley–Clifford connection, and explain **both directions** of failure of exact CI representation across DAGs and undirected graphs.

### Sources and example jobs

- Book 2 §§4.3.1 (Hammersley–Clifford) and 4.3.6.1 (separation properties): **state and apply** the relevant results.
- Book 2 §4.5.1 and Fig. 4.37: **work and compare** the undirected four-cycle.
- Directed collider already studied in Section 2: **reuse** for the converse contrast.

### Assigned content and mathematical treatment

- Undirected separation — **State + Apply**: conditioning on a vertex set blocks all paths passing through it; the direct neighbors of a node form its local Markov blanket.
- Hammersley–Clifford — **State + Interpret, no proof**: for a strictly positive distribution, the undirected Markov properties and factorization over graph cliques are equivalent in the appropriate sense.
- Four-cycle \(A-B-C-D-A\) — **Work** the pair of constraints \(A\perp C\mid\{B,D\}\) and \(B\perp D\mid\{A,C\}\); explain why no DAG on these four nodes encodes **exactly** the same CI structure.
- Collider \(A\to C\leftarrow B\) — **Compare**: its pattern of independence and dependence under conditioning cannot be represented exactly by an undirected graph on those variables.
- State the representational conclusion carefully — **Interpret**: distinct CI languages, not failure of the probability chain rule, and not a universal expressivity ranking.

### Boundary / exclusions

Do not derive graph-conversion algorithms, moralization, chordality, structural-equivalence classifications, or Hammersley–Clifford proof. The comparison is about the independence structures the graphs encode, not about claiming that every compatible distribution is faithful.

### Take-home

D-separation and ordinary graph separation define **complementary graphical independence languages**. Sparse exact representations available in one language need not exist in the other.

**Extent:** ~14 minutes.

---

## Section 6 — The Ising model: a probabilistic model of spatial interaction

**Status:** Proposed for section-boundary review.

### Purpose / role

Finish with one concrete undirected family that makes local potentials, energy, and spatial neighbor agreement interpretable. Pose image restoration as the notebook's **new inference problem**, without doing that inference during the lecture.

### Entry condition / transition in

Sections 4–5 established MRF factorization, normalization, and separation. Now instantiate these ideas in a minimal binary interaction model whose parameter has an immediate interpretation.

### Endpoint

Students can recognize and interpret a binary Ising distribution, explain what positive/negative coupling encourages, and understand why it offers a plausible *structural ingredient* for image denoising. They have **not** been handed the restoration posterior or update rule.

### Sources and example jobs

- Book 2 §4.3.2.1, including selected Ising configurations/samples from Fig. 4.17: **state, interpret, and compare**.
- Book 2 §4.3.8: **briefly motivate** noisy-image restoration as a probabilistic task; the mathematical construction and computation remain in the student notebook.

### Assigned content and mathematical treatment

- Binary spins \(z_i\in\{-1,+1\}\) and pairwise-neighbor interactions — **Define**:
  \(p(z\mid J)\propto\exp\!\left(J\sum_{(i,j)\in E}z_i z_j\right)\).
  Explain this as the uniform-coupling, zero-field model; its normalizer is inherited from Section 4.
- Coupling sign and magnitude, and representative configurations — **Interpret + Compare**: \(J>0\) rewards agreement; \(J<0\) rewards disagreement; larger \(|J|\) strengthens the interaction.
- Noisy-image restoration — **Motivate as a question only**: given noisy observations and a preference for neighboring clean pixels to agree, what should be inferred, and how might one compute it?

### Boundary / exclusions

**Do not** construct a clean-image prior combined with an observation-noise model, state or derive a Gaussian likelihood for observed pixels, multiply prior and likelihood into a posterior, compute single-site conditionals/log odds, show local MAP rules, or describe ICM updates. Those are students' notebook mathematics and computation. Do not replace the endpoint with Potts/Hopfield/RBM alternatives or an inference-method survey.

### Take-home

A simple binary energy model can encode a spatial preference for local agreement. **Turning it into a working restoration method is the notebook problem, not a result already derived in the lecture.**

**Extent:** ~9 minutes.

---

## Separate notebook handoff — not a lecture section

**Task:** Starting from a noisy binary image, construct and use a probabilistic restoration model.

**Preparation from lecture:** Students know undirected potentials and global normalization, the Ising interaction model, and the distinction between joint models and conditional queries. They are *not* presumed to have learned ICM or the restoration posterior.

**Student's original mathematical work:** Choose and formulate an Ising prior; formulate a Gaussian corruption likelihood with unambiguous noise SD/variance; factorize the joint; derive a posterior up to proportionality; cancel nonlocal factors to obtain the single-site posterior conditional or local log odds; connect this to a local MAP decision.

**Student's original computational work:** Use supplied clean/noisy binary-image data, plotting, and small NumPy interfaces to implement/complete ICM; compare against a no-spatial-prior pixelwise baseline; vary the coupling and assumed noise; diagnose sensitivity to initialization or local optima.

**End result:** A runnable but imperfect restoration method and a precise distinction among locally improving MAP updates, global MAP, and posterior marginals. Do **not** claim every global MAP problem is intractable: attractive binary pairwise models may admit exact graph-cut methods.

**Authoring sequence:** Validate an instructor worked solution before writing the teaching notebook. Murphy's `ising_image_denoise_demo.ipynb` is related but relies on mean-field/Gibbs methods reserved for later; do not copy it as the exercise solution. Preserve the one-hour constraint by supplying data preparation, notation, plotting, small code interfaces, and verification aids, **not** the model derivations. Follow the repository's worked-solution and teaching-notebook skills when those later stages are explicitly requested. No prerequisite recording and no PyTorch/JAX/MCMC/VI requirement.

## Example and figure shortlist for later slide organization

These are candidate **teaching functions**, not an instruction to make slides for all panels:

| Section | Candidate | Role |
|---|---|---|
| 1 | Book 2 Figs. 4.1, 4.2, and 4.11 | Sequence → general DAG; student CPDs; compact plate |
| 2–3 | Selected Book 2 Figs. 4.4–4.8, plus student network | CI motifs → multi-path queries → blanket |
| 4 | Book 2 Fig. 4.15 | Directional lattice vs undirected spatial interactions |
| 5 | Book 2 Fig. 4.37 and Section 2's collider | Exact four-cycle/collider CI-language contrasts |
| 6 | Book 2 Fig. 4.17 and brief §4.3.8 application | Ising configurations and the *unsolved* denoising motivation |

Prefer few examples reused for different questions over an unconnected gallery. At slide organization, select only the figures that earn teaching time. Create/read assets under the repository authoring conventions; no assets are authorized at this section-planning stage.

## Critique, uncertainties, and backpressure

**Intellectual sequence:** The progression is dependency-respecting: students first factor DAGs, then learn local motifs, then general d-separation; MRF potentials precede MRF separation; the four-cycle contrast only occurs after both languages are established; Ising is interpreted after general energy models. The final notebook question introduces new mathematics rather than repeating the last lecture section.

**Extent pressure:** This is **plausible but tight**, consistent with the scope estimate, especially if the Section 2 explaining-away calculation, Section 3 multipath query, and Section 5 four-cycle comparison are all worked rather than asserted. Provisional choice: preserve all three and the Ising endpoint, but avoid extra graphs, proof digressions, and additional model families. If later slide organization exceeds the live budget, report the pressure explicitly; do **not** silently move the essential CI and factorization work to a recording or notebook.

**Presentation balance:** Section 1 carries substantial material (chain rule, student network, parameter advantage, plate); its planned plate is intentionally brief. Section 5 is dense despite a short allocation; the Hammersley–Clifford statement receives no proof so the four-cycle comparison remains substantive. Section 6 is deliberately short because the restoration derivation belongs to the notebook.

**Notation / epistemic precision:** Directed arrows need not imply causation; d-separation entails CI but graphical connection need not imply actual dependence; positivity qualifies Hammersley–Clifford; clique potentials are globally, not locally, normalized; local ICM convergence does not assert global MAP optimality.

**Open instructor decisions:** Confirm six section boundaries and relative emphasis. The ~100-minute total and section times are estimates to reassess after section-level slide organization and any actual pacing evidence; no current recording is assigned.

**Upstream scope changes requested:** None. This plan is intended to realize the frozen scope without adding or dropping major content.

**Curriculum ledger:** Do not update `Lectures/material_ledger.md` merely because the section plan exists. Record actual lecture and notebook coverage when those deliverables are completed.
