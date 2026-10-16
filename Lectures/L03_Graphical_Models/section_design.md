# Lecture 3 section design — Graphical Models

**Status:** Proposed section organization for instructor review; not yet approved for slide-level organization.  
**Authoritative scope:** [lecture_scope.md](lecture_scope.md) on the consolidated course baseline.  
**Primary text:** Murphy, *Probabilistic Machine Learning: Advanced Topics* (Book 2), Chapter 4.  
**Intended delivery:** Approximately two hours of live lecture, followed by a separate one-hour student notebook.

This document partitions the agreed scope into **section-level contracts**. It defines section boundaries, intellectual jobs, prerequisites, mathematical treatment, examples, endpoints, and provisional live times. It is **not** a slide inventory or a notebook specification. Once these boundaries are approved, use `.agents/skills/slide-level-organization/SKILL.md` on one section at a time. Do not infer that a section heading, example, or equation here requires exactly one slide.

The scope file governs any apparent conflict. In particular, the lecture/notebook boundary at the Ising-image application must not move without an explicit upstream scope decision.

## Lecture-level frame

### Intellectual trajectory

Learned first-order Markov chain (L02) → general chain rule versus graph-based conditional-independence assumptions → DAG factorization and sparse CPDs (student network) → directed independence patterns → d-separation and Markov blankets → local interactions in undirected models → clique potentials, global normalization, and Gibbs form → undirected separation and the non-equivalence of directed/undirected CI languages → binary Ising distribution → **unsolved** image-restoration problem for the notebook.

The structural through-line is: **What restrictions on a joint distribution are represented by this graph, and what do those restrictions let us factor or infer?**

### Section closure convention

Each section must end with a **backward-looking take-home** that summarizes results established in that section. Do not use its ending to preview, tease, motivate, or hand off to the next section. When a connection is pedagogically necessary, introduce it at the **beginning of the receiving section**. References to other sections in the design are permissible only as author-facing boundaries or source/reuse notes; they must not become closing remarks or summary slides. The lecture-to-notebook boundary is documented separately and must not be turned into a forward-looking section takeaway.

### Starting assumptions

- L01 is planned to establish joint/marginal/conditional Gaussian reasoning and simple graphical notation, but not general DAG factorization, d-separation, Markov blankets, or plates.
- L02 has an *agreed design*, not necessarily a completed or delivered artifact. Its intended endpoint supplies the first-order Markov factorization, learned categorical transition distributions, and character-bigram example. Begin by recalling that model rather than assuming every L02 slide was delivered.
- Students already know undergraduate probability and Bayesian modeling and have encountered elementary DAG pictures. Do **not** assume they know d-separation or plate notation.
- Book 2 Ch. 4 is primary. Book 1 §§3.6.1–3.6.2 can inform a very short orientation, not a parallel treatment. The current syllabus-planning decisions override the old formal syllabus.

### Extent and emphasis

Plan **about 104 minutes of substantive live exposition in a 120-minute lecture window**, leaving roughly 16 minutes for questions, worked graph queries, transitions, and delivery variability. The allocations below are provisional complexity estimates, **not measured or guaranteed times**.

| Section | Live minutes (provisional) |
|---|---:|
| 1. From Markov chains to DAG factorization | 8 |
| 2. Bayesian networks in practice: the student network | 15 |
| 3. Conditional independence in directed graphs | 20 |
| 4. Reading independence from an entire DAG | 20 |
| 5. Undirected graphical models: local interactions and global normalization | 18 |
| 6. What directed and undirected graphs say about independence | 14 |
| 7. The Ising model: a probabilistic model of spatial interaction | 9 |
| **Substantive total** | **104** |

The demanding work is in Sections 3–4, where students learn genuinely new CI reasoning, and Sections 5–6, where they learn a different factorization and separation language. Protect those derivations and applications over adding more model families. L01's 61 content slides / 70 rendered pages are an extent benchmark, **not** an L03 target or a slide allocation. Re-estimate the workload from actual teaching moves at the next stage. No recording is required or assigned.

### Whole-lecture boundary

**Live:** DAG factorization; sparse conditional distributions; plate interpretation; directed CI motifs, explaining away, d-separation, Markov blankets, and I-map precision; MRF potentials and partition functions; Gibbs/energy form; undirected separation, positivity-qualified Hammersley–Clifford statement; four-cycle/collider expressivity contrast; binary Ising definition and interpretation.

**Notebook only:** choose and express image-restoration Ising prior and Gaussian noise likelihood; derive the image joint, posterior, and single-site conditional/log odds; derive and implement local MAP/ICM updates; compare and diagnose the method. The lecture may *motivate the restoration task*, but must not solve these notebook steps.

**Outside lecture scope:** DAG CPT learning, extended plate examples, ancestral sampling algorithms, Bayes-ball algorithm, MRF learning/pseudolikelihood, general CRFs/Potts/Hopfield/RBM surveys, factor graphs/message passing, moralization/chordality machinery, Hammersley–Clifford proof, mean-field/Gibbs/loopy BP, ICM, and graph cuts. Do not treat merely skipped intervening Book 2 subsections as implicitly covered.

---

## Section 1 — From Markov chains to DAG factorization

**Status:** Proposed for section-boundary review; split approved in principle, pending instructor review of details.

### Purpose / role

Generalize the first-order Markov chain from L02 into the parent-based factorization of an arbitrary directed acyclic graph (DAG). Establish the essential distinction: the **probability chain rule is an identity**, whereas replacing earlier variables with a smaller parent set imposes **additional conditional-independence assumptions**. The section's complete intellectual job is the abstract factorization argument, without a worked non-chain network.

### Entry condition / transition in

Recall the learned L02 Markov chain and its first-order factorization. Ask what happens when we move from sequential variables to an arbitrary collection of dependent variables, and whether the chain rule by itself gives a compact model.

### Endpoint

Students can recover the unrestricted chain rule, write a DAG factorization for a topological ordering, and explain in words and notation what additional independence assumptions make that factorization valid. They recognize the Markov chain as a special DAG.

### Sources and example jobs

- L02 Section 8, Book 2 §§2.6 and 4.2.2.1, and Fig. 4.1: **carry forward** first-order Markov structure.
- Book 2 §4.2.1: **derive/contrast** unrestricted chain-rule and parent-based factorization.

### Assigned content and mathematical treatment

- First-order Markov factorization — **Recall + Apply**:
  \(p(x_{1:T})=p(x_1)\prod_{t=2}^{T}p(x_t\mid x_{t-1})\).
- Unrestricted probability chain rule — **State/Recover** for a topological ordering:
  \(p(x_{1:D})=\prod_{i=1}^{D}p(x_i\mid x_{1:i-1})\).
- Additional ordered Markov assumption — **Derive + Contrast**: for a DAG with \(\mathrm{pa}(i)\subseteq\{1,\ldots,i-1\}\), replace each full-prefix conditional with a parent conditional:
  \(p(x_{1:D})=\prod_{i=1}^{D}p(x_i\mid x_{\mathrm{pa}(i)})\).
  Make clear this equality requires the modeling assumption, not just the chain rule.

### Boundary / exclusions

No worked non-chain network, specific CPDs, numerical parameter counts, or plate notation. Do not begin directed CI motifs, d-separation, CPT learning, or ancestral sampling.

### Take-home

The chain rule always holds. A DAG factorization asserts extra conditional-independence structure that can make the joint distribution simpler.

**Extent:** ~8 minutes.

---

## Section 2 — Bayesian networks in practice: the student network

**Status:** Proposed for section-boundary review; detailed teaching moves proposed for instructor review.

### Purpose / role

Make the abstract DAG factorization operational using **one sustained worked example**, Murphy's five-node student network (Book 2 §4.2.2.2, Fig. 4.2). Show how a graph specifies a complete joint distribution through small, locally normalized conditional probability tables and quantify the resulting parameter economy. **Only after completing the student-network example**, introduce plate notation as a brief graphical shorthand for repeated observations. Plate notation is first taught here, **not in Section 1**.

### Entry condition / transition in

The parent-based factorization is already established abstractly. Start with Murphy's specific non-chain graph and ask what numerical distributions we must provide to define its joint probability law.

### Endpoint

Students can name the five variables and their parents, reproduce the five-factor student-network joint, read and check a CPT row, calculate a joint-assignment probability by multiplying CPT entries, and explain the network's **15 versus 47** free-parameter advantage. They can read one simple IID plate and translate it into a product over observations.

### Sources and example jobs

- Book 2 §4.2.2.2, Fig. 4.2, Eqs. 4.5–4.6: **work through** the graph, its parent sets, factorization, and concrete CPTs, following Murphy's sequence.
- Book 2 §4.2.1: **apply** the parameter-count argument to the actual network before mentioning generic asymptotic scaling.
- Book 2 §4.2.8, Fig. 4.11: **briefly interpret** a repeated-observation plate and corresponding product; do not expand to a broad lesson on plates.

### Assigned content and mathematical treatment

1. **Read the student graph — Work.** Identify \(I\) (intelligence), \(D\) (difficulty), \(G\) (grade), \(S\) (SAT), and \(L\) (letter). List parent sets: \(\mathrm{pa}(I)=\mathrm{pa}(D)=\varnothing\), \(\mathrm{pa}(G)=\{I,D\}\), \(\mathrm{pa}(S)=\{I\}\), \(\mathrm{pa}(L)=\{G\}\).
2. **Write the joint — Derive + Contrast.** Use Murphy Eqs. 4.5–4.6 to compare a valid unrestricted chain-rule ordering with the shorter parent-based factorization: \(p(i,d,g,s,l)=p(i)p(d)p(g\mid i,d)p(s\mid i)p(l\mid g)\). Explicitly identify the removed conditioning variables and the assumptions justifying their removal.
3. **Read the numerical CPTs — Interpret + Check.** Work from Fig. 4.2: a row of the grade CPT is indexed by a particular intelligence/difficulty combination and provides a normalized distribution over grades A/B/C. Show the normalization check for a row; identify which local table supplies each factor.
4. **Compute one concrete joint probability — Apply.** Choose one complete assignment of \((I,D,G,S,L)\), read its five probabilities from the tables, and multiply them. This is a calculation of \(p(i,d,g,s,l)\), **not** posterior inference or an explaining-away exercise.
5. **Count free parameters — Calculate + Compare.** With cardinalities \((2,2,3,2,2)\), an unrestricted joint table requires \(2\cdot2\cdot3\cdot2\cdot2-1=47\) free probabilities. The DAG requires \(1+1+2\cdot2\cdot(3-1)+2\cdot(2-1)+3\cdot(2-1)=15\). Then interpret the general comparison \(O(K^D)\) versus \(O(DK^{m+1})\) for bounded indegree \(m\), as scaling rather than an exact count.
6. **Introduce one IID plate — Recognize + Interpret.** Only after finishing the example, show Murphy Fig. 4.11 or its simplest appropriate repeated-observation plate. Explain the box and repeat count, distinguish repeated variables from shared model parameters, and write the corresponding product \(\prod_{n=1}^{N}p(x_n\mid\theta)\) (with independent observations conditional on \(\theta\)). Do not make plates part of Section 1 or pursue hierarchical plate examples.

### Boundary / exclusions

**Section 1 contains no plates and no student-network example.** In this section, treat the student graph as a **factorization and parameterization example**, not an independence-query exercise. Reserve systematic pipe/fork/collider reasoning and explaining away for Section 3, and general d-separation/Markov blankets for Section 4. No CPT parameter fitting, ancestral sampling, or extended plate models.

### Take-home

Murphy's student network replaces one 47-parameter joint table with five locally normalized tables having 15 free parameters, while still defining a complete joint distribution. Plate notation abbreviates repeated factors without changing their probabilistic meaning.

**Extent:** ~15 minutes, provisional (formerly 12); protect the worked CPT and joint-probability calculations, and keep the plate introduction brief.

---

## Section 3 — Conditional independence in directed graphs

**Status:** Proposed for instructor review; specific Murphy-backed examples identified.

### Purpose / role

Demonstrate what a DAG factorization *asserts about conditional independence*, not merely how it compresses a joint distribution. Derive the three one-path motifs from their factorizations, and make explaining away concrete by returning to the student network. This section is about **single-path reasoning**; it does not yet teach general d-separation searches across a large DAG.

### Entry condition / transition in

The student network has specified a joint distribution through small CPTs. Begin by asking which statements about dependencies those factors impose, even before the numerical CPT entries are known.

### Endpoint

Students can identify a pipe, a fork, and a collider, justify the corresponding conditional-independence claims, and interpret how conditioning on a collider changes the relation between its parents. They can point to all three motifs in the student network and understand its explaining-away example without performing a general posterior-inference algorithm.

### Sources and example jobs

- Murphy Book 2 §4.2.4.1, Fig. 4.4, Eqs. 4.18–4.24: **derive/justify** the rules for the three-node motifs. Use the motif panels, but **not** the Bayes-ball procedure.
- Murphy Fig. 4.2 and Table 4.1 (p. 151): **identify** concrete chains, forks, and colliders in the previously established student network.
- Murphy §4.2.6.1 and Fig. 4.8 (pp. 155–156): **interpret** numerical belief updates in the student model as explaining away. Note that this figure is presented in Murphy's later inference subsection; using its results here does **not** entail teaching his inference algorithms.
- Murphy §4.2.4.2 and Fig. 4.6: an **optional alternative** selection-bias illustration, **not an additional required example**.

### Assigned content and mathematical treatment

1. **State the CI query — Recall + Apply.** Write \(X\perp Z\mid Y\) as \(p(x,z\mid y)=p(x\mid y)p(z\mid y)\), when the conditionals are defined. Say that the claim concerns the *distribution*, not a visual correlation judgment.
2. **Pipe \(X\to Y\to Z\) — Derive.** From \(p(x,y,z)=p(x)p(y\mid x)p(z\mid y)\), condition on \(Y\) and cancel terms to obtain \(X\perp Z\mid Y\) (Murphy 4.18–4.19). In the student network use \(D\to G\to L\): \(D\perp L\mid G\).
3. **Fork \(X\leftarrow Y\to Z\) — Derive.** From \(p(x,y,z)=p(y)p(x\mid y)p(z\mid y)\), obtain \(X\perp Z\mid Y\) (4.20–4.21). In the student network use \(G\leftarrow I\to S\): \(G\perp S\mid I\).
4. **Collider \(X\to Y\leftarrow Z\) — Derive + Contrast.** The roots factor as \(p(x)p(z)\), so \(X\perp Z\), but after conditioning on the common child \(p(x,z\mid y)\propto p(x)p(z)p(y\mid x,z)\) generally does not factor (4.22–4.24). In the student network use \(D\to G\leftarrow I\): \(D\perp I\) but not in general \(D\perp I\mid G\).
5. **Numerical explaining away — Read + Interpret.** Use Murphy Fig. 4.8: with \(G=C\), \(p(I=\mathrm{High}\mid G=C)=0.08\) and \(p(D=\mathrm{Hard}\mid G=C)=0.63\); after also observing \(S=\mathrm{Good}\), these become \(0.58\) and \(0.76\), respectively. Explain how new evidence favoring high intelligence changes the preferred explanation of the poor grade. Read these posterior results rather than teach a posterior-marginal inference algorithm.
6. **Conceptual precision — State.** Directed arrows represent the chosen conditional structure; the patterns alone do not authorize causal-intervention claims. In particular, the collider is a *graphical* explanation for conditional dependence.

### Boundary / exclusions

Do not teach multi-path d-separation, descendant-of-collider rules, Bayes-ball mechanics or its boundary conditions (Murphy Fig. 4.5), Markov blankets, formal I-map definitions, or inference algorithms. Do not add Fig. 4.6's Gaussian selection-bias example unless it *replaces* rather than supplements the student explaining-away example.

### Take-home

Conditioning blocks the path through a pipe or fork, but can open the path through a collider. The student network exhibits all three motifs, and the observed grade and SAT score make explaining away numerically tangible.

**Extent:** ~20 minutes, provisional; one worked algebraic argument per motif plus one interpretation of the student-network posterior results.
---

## Section 4 — Reading independence from an entire DAG

**Status:** Proposed for instructor review; now includes named multi-path and Markov-blanket calculations.

### Purpose / role

Extend the single-path motifs to **whole-graph** conditional-independence queries. Teach the general d-separation rule, including observed descendants of colliders; then use the directed Markov blanket to show how a node's full conditional can depend on only a small neighborhood. Finish by distinguishing independences **guaranteed** by the graph from extra ones possible at special parameter settings.

### Entry condition / transition in

The three motifs are known. Begin with a concrete question that cannot be answered by inspecting just one local motif: do *all* paths between two nodes become blocked by a given evidence set?

### Endpoint

Students can check all paths in a moderately sized DAG, correctly handle an observed collider descendant, derive the directed blanket as parents + children + co-parents, and state the I-map direction \(I(G)\subseteq I(p)\) without treating an active path as a guarantee of actual dependence.

### Sources and example jobs

- Murphy §4.2.4.1, Eq. 4.17 and Fig. 4.5(c): **state/apply** general d-separation and explain the collider-descendant exception. Exclude Bayes-ball traversal rules, despite Murphy using them to motivate the pictures.
- Murphy Fig. 4.23(a) (p. 180): **work one multi-path query** on a DAG larger than the student network. This graph occurs later in the book but is an appropriate concrete source example for the earlier definition.
- Murphy Fig. 4.2 and Table 4.1: **reuse** the student network for the observed-descendant query and a blanket calculation.
- Murphy §4.2.4.3, Fig. 4.7, Eqs. 4.26 and 4.31–4.32: **derive/justify** the directed Markov blanket, emphasizing cancellation of factors outside the target neighborhood.
- Murphy §4.2.4 introductory paragraph (p. 149): **state concisely** the graphical I-map relation.

### Assigned content and mathematical treatment

1. **Generalize from a motif to paths — State + Apply.** An undirected *path* through a DAG is blocked if it contains (i) a conditioned non-collider (pipe or fork), or (ii) a collider for which neither it nor any descendant is conditioned on. \(A\perp_G B\mid C\) holds only if **every** path from \(A\) to \(B\) is blocked (Murphy 4.17).
2. **Collider descendants — Work.** In the student network \(D\to G\leftarrow I\) with \(G\to L\), establish \(D\perp_G I\) but not \(D\perp_G I\mid L\): observing \(L\), a descendant of collider \(G\), opens the path. Relate this to Murphy's Fig. 4.5(c), without teaching Bayes-ball boundary conditions.
3. **A genuinely multi-path query — Work on Fig. 4.23(a).** Ask whether \(X_4\perp_G X_5\mid X_2\). Trace at least the fork \(X_4\leftarrow X_2\to X_5\), blocked by \(X_2\), and the collider \(X_4\to X_7\leftarrow X_5\), blocked while \(X_7\) and its descendants are unobserved; check the remaining paths as well. Conclude *yes*. Change the evidence to \(\{X_2,X_7\}\); the collider at \(X_7\) now opens a path, so the same CI is no longer entailed. This is a **course-selected application** to Murphy's graph, not a claim that Murphy walks through this exact two-question sequence.
4. **Directed Markov blanket — Define + Work.** State \(\mathrm{mb}(i)=\mathrm{pa}(i)\cup\mathrm{ch}(i)\cup\mathrm{copa}(i)\) (Murphy 4.26) and interpret Fig. 4.7. On the student DAG use node \(I\): its children are \(G,S\) and its co-parent is \(D\), so \(\mathrm{mb}(I)=\{D,G,S\}\); \(L\) is outside the blanket.
5. **Why the blanket works — Justify with local factors.** Holding the remaining variables fixed, show \(p(i\mid d,g,s,l)\propto p(i)\,p(g\mid i,d)\,p(s\mid i)\). The factor \(p(l\mid g)\) does not depend on \(i\) and cancels in normalization. Generalize only as far as Murphy 4.32: \(p(x_i\mid x_{-i})\propto p(x_i\mid x_{\mathrm{pa}(i)})\prod_{k\in\mathrm{ch}(i)}p(x_k\mid x_{\mathrm{pa}(k)})\).
6. **What the graph guarantees — Explain.** \(I(G)\subseteq I(p)\) means a distribution Markov with respect to \(G\) satisfies every CI assertion obtained by d-separation. An active path alone does **not** prove dependence for every legal set of CPTs; e.g., a CPT might happen not to vary with one of its displayed parents. Do not develop a formal theory of minimal/perfect I-maps.

### Boundary / exclusions

The student network's undirected skeleton is a tree, so it cannot be the **only** example of multiple alternative paths; the explicit Fig. 4.23(a) query is therefore essential. Exclude executable Bayes-ball search, moralization/ancestral-graph conversion, equivalence proofs for global/local/ordered Markov properties (Murphy §4.2.4.4), causal intervention, and any inference algorithm. The blanket factor cancellation is a property of the DAG joint, not an ICM or Gibbs-sampling procedure.

### Take-home

A DAG entails conditional independence only when **every** path is blocked, accounting for collider descendants. Its directed Markov blanket consists of parents, children, and co-parents, and graphical separation makes guarantees rather than universal claims of dependence.

**Extent:** ~20 minutes, provisional; the Fig. 4.23(a) multipath check and student-network blanket cancellation are the two required worked applications.
---

## Section 5 — Undirected graphical models: local interactions and global normalization

**Status:** Proposed for instructor review; explicit small potential example supplied.

### Purpose / role

Introduce undirected Markov random fields as a natural language for **symmetric local interactions**, particularly pixels in a spatial lattice. Show concretely how non-normalized local clique potentials define a complete joint only after multiplication and **global** normalization, then derive the equivalent Gibbs/energy representation. Treat undirected models positively rather than as a deficient kind of DAG.

### Entry condition / transition in

Open with Murphy Fig. 4.15: neighboring pixels interact, but orienting their relationships into a DAG gives a less natural notion of locality. Compare the two lattice drawings and ask how to define a joint without parent–child CPDs.

### Endpoint

Students can identify maximal cliques, form a product of nonnegative potentials, compute a discrete partition function for a small specified graph, distinguish local CPT normalization from global potential normalization, and convert a positive potential product to an energy-based form.

### Sources and example jobs

- Murphy §4.3 introduction, Fig. 4.15(a–b) (p. 165): **compare** directed versus undirected pixel lattices and the role of edge orientation.
- Murphy §4.3.1 and Eqs. 4.69–4.70 (p. 166): **define** clique potentials and partition functions. Murphy gives the general expressions rather than the specific numerical toy calculation below.
- Murphy §4.3.1.2, Eqs. 4.71–4.73: **derive** the Gibbs/energy reparameterization for strictly positive potentials.
- L02 log-partition-function work: **recall** normalization only, without repeating exponential-family theory.

### Assigned content and mathematical treatment

1. **Local interactions without arrows — Compare.** Use Fig. 4.15(a–b) and neighboring pixel intensities. Explain why an undirected edge expresses a symmetric *factor scope*, not a parent–child CPD. Do not yet teach undirected separation or blankets.
2. **Maximal cliques and potentials — Define.** A clique contains mutually connected nodes. In a simple undirected chain \(A-B-C\), maximal cliques are \(\{A,B\}\) and \(\{B,C\}\), so \(p(a,b,c)=Z^{-1}\psi_{AB}(a,b)\psi_{BC}(b,c)\). The \(\psi\)'s are nonnegative factors, **not** individually normalized conditional distributions.
3. **A fully specified toy partition function — Work.** As a **course-constructed numerical example** applying Murphy 4.69–4.70 (not a numerical table from Murphy), let \(A,B,C\in\{0,1\}\) and use the matrices \(\psi_{AB}=\begin{pmatrix}2&1\\3&2\end{pmatrix}\) (rows \(a\), columns \(b\)) and \(\psi_{BC}=\begin{pmatrix}1&4\\2&1\end{pmatrix}\) (rows \(b\), columns \(c\)). Compute \(Z=\sum_{a,b,c}\psi_{AB}(a,b)\psi_{BC}(b,c)=5\cdot5+3\cdot3=34\), and then \(p(A=0,B=0,C=1)=2\cdot4/34=8/34\). Show why no local row-sum-to-one condition was used.
4. **Local versus global normalization — Contrast.** In a Bayes net, every \(p(x_i\mid x_{\mathrm{pa}(i)})\) is locally normalized. In the MRF, the *product* of arbitrary potentials needs one \(Z\), summed over all complete assignments; this becomes expensive at scale.
5. **From potentials to Gibbs energy — Derive.** For \(\psi_c>0\), set \(E_c(x_c)=-\log\psi_c(x_c)\); then \(E(x)=\sum_c E_c(x_c)\) and \(p(x)=Z^{-1}\exp[-E(x)]\) (Murphy 4.71–4.73). Interpret low energy as high probability and connect \(\log Z\) to the normalizer encountered in L02.

### Boundary / exclusions

Use the toy \(A-B-C\) product **only** to teach potentials and normalization; it is not an Ising-image prior and has no likelihood or posterior. Reserve separation/undirected blankets and the positivity-qualified Hammersley–Clifford statement for Section 6; reserve explicit Ising spins/coupling for Section 7. Do not develop CRFs, sampling, model fitting, physical thermodynamics, or inference algorithms.

### Take-home

An undirected graph encodes local interaction scopes through clique potentials, while a **single global partition function** makes their product a probability distribution. Positive potentials can equivalently be written as additive energies.

**Extent:** ~18 minutes, provisional; the 3-node toy calculation is the sole required numerical MRF worked example.
---

## Section 6 — What directed and undirected graphs say about independence

**Status:** Proposed for instructor review; explicit comparisons tied to Murphy's figures.

### Purpose / role

Define the **undirected graph-separation** rule, its neighbor Markov blanket, and the positivity-qualified connection between undirected Markov properties and clique factorization. Then demonstrate, with Murphy's specific four-cycle and directed collider, that DAG and MRF graphs have **different exact CI representation languages**; neither dominates the other.

### Entry condition / transition in

An undirected joint has been constructed using potentials. Start by asking which CI relations can be read directly from the absence of paths after conditioning, and use a spatial lattice where neighborhoods are transparent.

### Endpoint

Students can read graph separation and the neighbor blanket in a small MRF; state Hammersley–Clifford with its positivity condition but no proof; and use the *actual failed orientations* in Murphy Fig. 4.37 to explain why a four-cycle's two key separations cannot both be represented exactly by a DAG.

### Sources and example jobs

- Murphy §4.3 introduction and Fig. 4.15(b): **identify** the neighbor blanket of an interior lattice pixel.
- Murphy §4.3.6.1, Eq. 4.115 and Fig. 4.23(b): **state/apply** undirected global and local Markov properties; do not turn this into a Markov-property equivalence proof.
- Murphy §4.3.1.1, Eqs. 4.69–4.70: **state/interpret** Hammersley–Clifford and its positive-distribution requirement.
- Murphy §4.5.1, Fig. 4.37(a–c), and discussion (pp. 194–195): **work/compare** the undirected four-cycle with Murphy's two failed DAGs.
- Murphy §4.5.1's directed collider: **work** the converse counterexample.

### Assigned content and mathematical treatment

1. **Undirected separation — State + Apply.** \(A\perp_G B\mid C\) when removing observed nodes \(C\) destroys **every** path from \(A\) to \(B\). Unlike DAG d-separation, no collider exception is needed. On Fig. 4.15(b), interior pixel \(X_8\) has nearest-neighbor blanket \(\{X_3,X_7,X_9,X_{13}\}\), which screens it from all nonneighbors.
2. **The local blanket — Define + Compare.** For an MRF, \(\mathrm{mb}(i)=\mathrm{ne}(i)\) (Murphy 4.115), in contrast with a DAG's parents, children, and co-parents. If useful, use Murphy's Fig. 4.23(b) to confirm \(\mathrm{mb}(X_5)=\{X_2,X_3,X_4,X_6,X_7\}\); do not require both figures as extended worked exercises.
3. **Hammersley–Clifford — State + Interpret.** For a strictly positive joint distribution, the undirected graphical Markov properties and factorization over the graph's cliques correspond in the theorem's precise sense (Murphy 4.69–4.70). State that zero-probability configurations require caution; do not prove global/local/pairwise equivalence.
4. **Four-cycle — Work Fig. 4.37.** For \(A-B-C-D-A\), show \(A\perp_G C\mid\{B,D\}\) and \(B\perp_G D\mid\{A,C\}\). Compare Murphy's DAG (b): it also asserts the unwanted \(B\perp D\mid A\). Compare DAG (c): it asserts the unwanted \(B\perp D\) marginally. These concrete mismatches explain why neither orientation reproduces exactly the four-cycle's CI structure; state Murphy's stronger conclusion that **no** DAG on these four nodes does.
5. **Converse collider — Compare.** For \(A\to C\leftarrow B\), the DAG entails \(A\perp B\), while conditioning on \(C\) can open dependence. The undirected path \(A-C-B\) instead entails \(A\perp B\mid C\); connecting \(A\) and \(B\) directly loses the marginal independence. No undirected graph on these three variables has exactly the collider CI structure.
6. **Representation conclusion — Interpret.** Graph separation in an MRF is monotone under additional conditioning on other nodes; DAG separation need not be because of colliders. The conclusion concerns **exact sets of graph-entailed CIs**, not whether the chain rule holds or an overall ranking of model likelihood families.

### Boundary / exclusions

No chordality definitions/proofs, perfect-map taxonomy beyond the specific contrasts, graph conversion or moralization algorithms, Hammersley–Clifford proof, lattice inference, or CRFs. Keep the 14-minute allocation visible as **extent pressure**: the four-cycle diagrams and converse collider are indispensable; Eq. 4.115 and Hammersley–Clifford should be concise.

### Take-home

In an undirected graph, conditioning blocks paths by ordinary separation and a node's neighbors form its blanket. Directed and undirected graphs encode different CI structures: the collider and four-cycle show why **neither** is an exact substitute for the other.

**Extent:** ~14 minutes, provisional; prioritize Murphy Fig. 4.37's concrete failures over broad expressivity terminology.
---

## Section 7 — The Ising model: a probabilistic model of spatial interaction

**Status:** Proposed for instructor review; exact equation/figure choices and notebook exclusion identified.

### Purpose / role

Give one interpretable, concrete instance of the undirected potential/energy construction: **binary neighboring spins** with a coupling parameter. Interpret the sign and strength of interaction using selected configurations/samples. Image denoising can be mentioned as an **unsolved probabilistic task**, but the live section must end with a retrospective Ising-model summary, not a notebook solution or handoff.

### Entry condition / transition in

Start with the undirected pixel lattice and the product of neighbor potentials now familiar from Section 5. Choose binary states so that the local potentials have a simple physical and probabilistic interpretation.

### Endpoint

Students can write the zero-field uniform-coupling Ising law, interpret an individual edge's potential, compare positive/negative/zero coupling, and read the qualitative differences among Murphy's sample configurations. They have not constructed an image-restoration likelihood, posterior, or local-site update.

### Sources and example jobs

- Murphy §4.3.2.1, Eqs. 4.74–4.78: **state/derive** the equivalence between pairwise Ising potentials and an energy sum.
- Murphy Fig. 4.16 (p. 168): **interpret** the alternating pattern preferred by \(J<0\) on a square lattice.
- Murphy Fig. 4.17 (p. 168): **compare** representative samples for \(J=0.2\), \(0.4\), and \(10\) (positive association), **without** explaining the Gibbs sampler that generated them.
- Murphy §4.3.8, Fig. 4.26 and Eq. 4.117: **application provenance only**; the figure and its joint factorization must **not** be revealed as a worked lecture solution, because constructing them is student notebook work.

### Assigned content and mathematical treatment

1. **Spins and neighbors — Define.** For each site \(i\), \(z_i\in\{-1,+1\}\); edges \((i,j)\in E\) connect spatial neighbors. For uniform coupling \(J\) and no unary field, \(\psi_{ij}(z_i,z_j)=\exp(Jz_i z_j)\) (Murphy 4.75–4.76).
2. **Probability and energy — State + Interpret.** \(p(z\mid J)=Z(J)^{-1}\exp[J\sum_{(i,j)\in E}z_i z_j]\), equivalently \(E(z;J)=-J\sum_{(i,j)\in E}z_i z_j\) (4.77–4.78). Avoid rederiving the generic partition-function framework.
3. **The coupling is interpretable — Compare.** Each agreeing pair gets \(e^J\), each disagreeing pair \(e^{-J}\); the local potential ratio is \(e^{2J}\). Thus \(J>0\) favors agreement (uniform regions); \(J<0\) favors disagreement (alternating pattern on a square lattice); \(J=0\) produces independent uniform spins. Increasing \(|J|\) strengthens the preference.
4. **Read the configurations — Interpret figures.** Compare Murphy Fig. 4.17's \(J=0.2,0.4,10\) samples for increasing coherence/clumpiness; use Fig. 4.16 only briefly if needed to illustrate negative coupling. Do **not** teach the sampling algorithm, phase-transition threshold (Eq. 4.79), or temperature mechanics.
5. **Image-restoration problem statement — Mention, do not solve.** One may state that a noisy observed image and an Ising preference for neighboring *latent* clean pixels present a possible inference problem. Do **not** display Murphy Eq. 4.117's factorization, specify the Gaussian likelihood, write the posterior, compute any site conditional, or introduce ICM. These are original mathematics and code in the separate student notebook.

### Boundary / exclusions

Notebook-only: choosing and constructing the clean-image Ising prior and Gaussian observation likelihood, their joint/posterior, local conditional/log odds, local MAP rule, and ICM evaluation. Exclude external-field/unary-term extensions (Murphy 4.80 onward), Potts/Hopfield/RBM surveys, thermodynamic phase transitions, and Gibbs-sampling explanations.

### Take-home

The binary Ising model assigns higher probability to configurations favored by **pairwise neighbor couplings**. The sign of \(J\) selects agreement or disagreement; its magnitude controls the strength of that preference.

**Extent:** ~9 minutes, provisional; a short model definition and figure-based interpretation, not an inference-method lesson.
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
| 1 | Book 2 Fig. 4.1 | Markov chain → generic DAG factorization |
| 2 | Book 2 Figs. 4.2 and 4.11 | Student CPDs, parameter economy; compact plate |
| 3 | Book 2 Fig. 4.4, Table 4.1, Fig. 4.8 and student network | Motif factorizations and concrete numerical explaining away |
| 4 | Book 2 Figs. 4.5(c), 4.7, 4.23(a), and student network | Collider descendant, genuinely multi-path query, blanket factor cancellation |
| 5 | Book 2 Fig. 4.15 and Eqs. 4.69–4.73; course-owned 3-node example | Image lattice, explicit global normalizer, Gibbs energy |
| 6 | Book 2 Figs. 4.15(b), 4.37(a–c) and Section 3's collider | Neighbor blanket and Murphy's two failed DAGs, then converse collider |
| 7 | Book 2 Figs. 4.16–4.17; Eqs. 4.74–4.78 | Ising couplings and configurations; *unsolved* denoising task only mentioned |

Prefer few examples reused for different questions over an unconnected gallery. At slide organization, select only the figures that earn teaching time. Create/read assets under the repository authoring conventions; no assets are authorized at this section-planning stage.

## Critique, uncertainties, and backpressure

**Intellectual sequence:** The progression is dependency-respecting: students first factor DAGs, then learn local motifs, then general d-separation; MRF potentials precede MRF separation; the four-cycle contrast only occurs after both languages are established; Ising is interpreted after general energy models. The final notebook question introduces new mathematics rather than repeating the last lecture section.

**Extent pressure:** This is **plausible but tight** at ~104 substantive minutes, slightly beyond the scope's approximately 100-minute planning prior, especially with Section 3's algebra and Fig. 4.8 belief updates, Section 4's Fig. 4.23(a) multipath query and Markov-blanket cancellation, and Section 6's four-cycle comparison. Provisional choice: preserve all three and the Ising endpoint, but avoid extra graphs, proof digressions, and additional model families. If later slide organization exceeds the live budget, report the pressure explicitly; do **not** silently move the essential CI and factorization work to a recording or notebook.

**Presentation balance:** Section 1 isolates the chain-rule-versus-DAG argument without any plate notation or student-network example; Section 2 works the student network, its numerical CPTs, the exact parameter advantage, and an intentionally brief plate. Section 3 returns to the student network for numerical explaining away; Section 4 uses Murphy Fig. 4.23(a) because the student network alone has no multiple undirected paths. Section 5 includes an explicitly labeled course-constructed 3-node potential calculation, not a falsely attributed Murphy numerical example. The split creates a clearer transition but adds no new subject matter. Section 6 is dense despite a short allocation; the Hammersley–Clifford statement receives no proof so the four-cycle comparison remains substantive. Section 7 is deliberately short because the restoration derivation belongs to the notebook.

**Notation / epistemic precision:** Directed arrows need not imply causation; d-separation entails CI but graphical connection need not imply actual dependence; positivity qualifies Hammersley–Clifford; clique potentials are globally, not locally, normalized; local ICM convergence does not assert global MAP optimality.

**Open instructor decisions:** Review the seven section boundaries and relative emphasis. The ~104-minute total and section times are estimates to reassess after section-level slide organization and any actual pacing evidence; no current recording is assigned.

**Upstream scope changes requested:** None. This plan is intended to realize the frozen scope without adding or dropping major content.

**Curriculum ledgers:** `curriculum_map.typ` records planned coverage; `curriculum_map_actual.typ` records substantive activity only after teaching. No lecture has been taught.

**Reconciliation status (2026-10-16):** This recovered design is a proposal, not a new approval; L01–L03 were reopened for alignment. The later source check in [course review](reconciliation/course_review.md) verifies the direct edges into node 7 and discharges the earlier Figure 4.23 blocker. Other section-boundary/timing choices remain proposed.
