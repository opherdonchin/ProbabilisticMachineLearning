# Rule-guided mathematical slide design: Gaussian conditioning

**Status:** Experimental authoring brief, not a course skill, approved slide design, or change to the production workflow.  
**Audience:** Local Codex working in the Advanced Statistics / ProbabilisticMachineLearning repository.  
**Goal:** Produce a stronger *initial* exposition of the proof of the Gaussian conditioning formulas, using explicit design rules and targeted instructor consultation rather than an additional generic reviewer.

## 1. Purpose and boundaries

The problem is not simply whether an expert can reconstruct a correct proof from the slides. It is whether the slides make the important mathematical reasoning *available to students as the argument unfolds*, without needless notation, clutter, or hidden operations.

This experiment tests **rule-guided production**, not the ability of another agent to approve or reject an existing deck. A human instructor is available: meaningful teaching choices can be discussed with them rather than decided automatically. The aim is an improved first design plus a record of *which rules produced which decisions*.

**Target mathematical material.** The course distinguishes the live residual/independence derivation from a separate recorded full block-elimination proof. Preserve that boundary. The recording is intended to establish the complete factorization of the normalized joint Gaussian density, including the block-elimination identity, covariance/Schur-complement conditions, and normalizing constants; splitting the exponent alone is not sufficient. Consult the current authoritative local scope and development records, which may be more recent than the repository's default branch. Do not silently treat proposed, unapproved details as instructor commitments.

**Mathematical endpoint (an invariant, not a slide script).** For a positive-definite partitioned covariance, the recording must justify the conditional Gaussian with mean $\mu_1+\Sigma_{12}\Sigma_{22}^{-1}(x_2-\mu_2)$ and covariance $S=\Sigma_{11}-\Sigma_{12}\Sigma_{22}^{-1}\Sigma_{21}$. In a block-elimination route, the quadratic separates into $r^T S^{-1}r+u^T\Sigma_{22}^{-1}u$, where $u=x_2-\mu_2$ and $r=x_1-\mu_1-\Sigma_{12}\Sigma_{22}^{-1}u$. The determinant identity $\det\Sigma=\det S\det\Sigma_{22}$ allows the *entire normalized density* to factor. These are proof obligations, not instructions to put all this notation on the first slide.

**What remains flexible for an experimental candidate:** presentation order *within* the agreed mathematical purpose, allocation of space and emphasis, slide boundaries, labels, supporting schematics, and reveal structure. The existing deck is a baseline, not a specification to reproduce. The existing course theme and source-of-truth hierarchy remain relevant. A candidate may propose changes to an upstream slide sequence, but must identify them explicitly rather than silently modifying approved artifacts.

## 2. Numbered mathematical exposition rules

Apply the rules as **design heuristics requiring evidence**, not as a mechanical scoring checklist. A rule can be inapplicable or conflict with another; a deliberate exception with a mathematical/pedagogical reason is preferable to formal compliance that weakens the presentation. The source codes in brackets are mapped to references in §5. Mathematical examples below illustrate the rules; they do not prescribe exact slides.

### R01 — Present the mathematical query before new machinery

Start the development by making the target question intelligible: given a *joint* Gaussian and an observed block, what is the *conditional distribution* of the other block? Show the role of the known joint parameters and the unknown conditional law. Avoid introducing a transformation matrix or an additional parameterization before its purpose is apparent. **Check:** Can the student identify the quantity being derived from the first substantive state? [M, C, S]

### R02 — Give every major transformation a job

Organize the proof as a connected sequence of mathematical tasks (for example, eliminate dependence between blocks; separate a quadratic; split the normalizer; identify the conditional density). Do not organize merely by textbook paragraph or one displayed equation per slide. Each teaching move should make a different contribution to the proof. **Check:** Can the student explain why this step is needed for the stated target? [C, S]

### R03 — Make assumptions and mathematical domains visible at their first consequential use

State or recall conditions before relying on them. In the nondegenerate Gaussian proof, `Σ ≻ 0` must be interpretable as *positive definite*, and the relevant invertibility/positivity properties of `Σ₂₂` and the Schur complement must be justified or explicitly invoked at the required depth. Make dimensions/block shapes explicit when they determine which products are valid; do not crowd slides with routine dimensions that add no understanding. **Check:** Are inverses, determinant manipulations, and Gaussian normalizers licensed by visible assumptions? [N, S, C]

### R04 — Use the smallest stable vocabulary of symbols

Reuse notation established in the live lecture and Murphy where practical. Introduce an abbreviation (`B`, `S`, `H`, `T`, `u`, `r`, etc.) only when it substantially simplifies several following operations or makes a mathematical relationship easier to recognize. Define it at first use, retain it consistently, and avoid introducing several independent abbreviations at once. **Check:** For every new symbol, can its benefit be stated? Would inlining it once be clearer? [N, M, C]

### R05 — Keep the target and relevant premises available during the derivation

Carry forward the particular definition, earlier equality, or block partition needed to read the *next* transformation without memorizing a previous slide. Make established context visually subordinate to the new reasoning. Distinguish genuinely recalled results from a conclusion that has not yet been established. **Check:** What does the student have to remember from earlier states to verify the current one? [C, M]

### R06 — Show complete mathematical relationships, not disconnected equation tiles

Keep a load-bearing equality or factorization syntactically intact and visually connected to its antecedent. Align equal signs or corresponding blocks when it makes a multi-line derivation readable. If an expression is too wide, reconsider its decomposition or slide allocation before reducing the font. **Check:** Can the viewer determine exactly which expression is transformed into which new expression? [N, C]

### R07 — Show the nonroutine operation and its local warrant

For an important equality, label the mathematical operation *where it happens*: block elimination, multiplication by a specified matrix, a cancellation, an identity for determinants, or a Gaussian-independence argument. Preserve enough algebra to verify a load-bearing step, but do not expand routine multiplication merely to look thorough. If a warrant is genuinely new reasoning, it belongs beside the proof object, not solely in an end-of-slide takeaway or an imagined spoken explanation. **Check:** Which step would an expert perform mentally that a student needs to *see* here? [N, S, C]

### R08 — Align and co-locate the objects that must be compared

Put matching blocks, terms, or expressions close enough to inspect together. If a matrix product cancels a cross term, make the source and destination of the cancellation visible in the same state; use consistent visual encoding for corresponding objects. Avoid forcing back-and-forth searches through separate slides or boxes. **Check:** Can the relevant correspondence be located without mentally redrawing the slide? [M, C]

### R09 — Signal one load-bearing relation at a time

Use restrained emphasis (alignment, brief annotation, contrast, or a temporary highlight) to locate the *current* mathematical move—especially an important cancellation, substitution, or determinant identity. Emphasis should identify a relation, not merely decorate a formula; it should not turn every line into a competing focal point. **Check:** Is the reasoning step visually findable at the moment it matters? [M, C, T]

### R10 — Segment by reasoning, not by clicks or transcription

A reveal should add a meaningful premise, operation, implication, or interpretation. Keep essential earlier expressions visible when continuity depends on them; show two objects simultaneously when their comparison is the point. Avoid both a fully populated wall of mathematics and a sequence of trivial click-by-click algebra. Ensure the completed state also works as a handout. **Check:** At each reveal, what new idea became possible to understand? [M, C, T]

### R11 — Separate mathematical objects from their interpretation without hiding the proof

The primary slide object should contain the equation, matrix, diagram, indispensable mathematical conditions, and local reasons required to follow it. Use the course's key-point region for the meaning or consequence of the result, not to repeat the visible formula or announce the instructor's plan. Do *not* remove local proof warrants in an attempt to make slides “light on text.” **Check:** Could the mathematics still be followed if the bottom takeaway were covered? [C]

### R12 — Eliminate extraneous formalism and visual material

Do not introduce auxiliary notation, tangential results, decorative diagrams, or a second proof route just because they are mathematically elegant. Each displayed object should help establish the target, explain a nonroutine step, or support an explicit comparison/interpretation. Do not make the proof more superficial in the name of simplicity. **Check:** What understanding is lost if this item is removed? [M, N, C]

### R13 — Finish the *required* proof, not just its most appealing algebra

The target is the **normalized** conditional Gaussian law, not just a suggestive decomposition of its exponent. The first-pass design must make the relationship among block elimination, the separated quadratic, determinant factorization, and the Gaussian normalizing factors legible. The proof should identify the conditional mean and covariance actually established. **Check:** Has the joint density really been shown to factor into a marginal Gaussian times a normalized conditional Gaussian? [B, C]

### R14 — Return from algebra to mathematical meaning and a diagnostic case

After a substantive result, state what it means for conditioning: how the observed deviation affects the mean and why the conditional covariance is the residual covariance. Where it genuinely helps, use a simple limiting or special case (for example, zero cross-covariance) to check the formula—not as a substitute for its proof. **Check:** Can the student connect the final formula back to the initial query and to a recognizable property of Gaussian conditioning? [C, S]

### R15 — Design for the actual lecture, not merely a correct handout

Inspect the rendered presentation at projected scale and every meaningful reveal, not only source text or the final PDF. Check equation sizes, visual hierarchy, locality of annotations, eye travel, pacing, and the amount of simultaneous symbolic material. Spoken explanation can add context but should not be the *only* place a key algebraic warrant appears. **Check:** Can a viewer follow the crucial step at presentation pace without stopping to decode the slide? [M, T, C]

## 3. Working with the instructor

**H1 — Produce a rule-driven first proposal before collecting slide-specific criticism.** Do not start by patching the known complaints about the previous Gaussian opening. Rebuild a coherent initial design from the mathematical goal, actual entry knowledge, rules, and current course conventions. Use earlier criticism later as a diagnostic comparison, not as the source of every design decision.

**H2 — Consult on consequential alternatives, not routine implementation.** If two substantially different mathematical compositions are plausible—for example, whether to display a block-elimination relationship alongside its expanded cancellation, or which part of the proof should remain as a persistent visual anchor—show the instructor a compact comparison (preferably a real render or clear sketch), explain the mathematical/pedagogical tradeoff, and give a recommendation. Ask one decision at a time. Do not request approval for typography, a symbol already settled in the course, or every reveal.

**H3 — Make the first proposal inspectable early.** Show at least the proposed full mathematical arc and representative *student-visible* states before polishing every production detail. The instructor should be able to change a major presentational choice without throwing away a finished deck. After consultation, finish the first-pass coherent candidate. Do not treat silence as acceptance.

**H4 — Preserve provenance of decisions.** Distinguish: (a) mathematical obligations already accepted by the instructor, (b) choices inferred from published/repository rules, (c) experimental authoring judgments, and (d) actual instructor responses. An author should not present its own preference as an instructor decision.

## 4. The rule-application and debugging record

Record the *consequential* choices during design, not a retrospective checklist designed to justify the output. A lightweight table or concise prose log is sufficient.

| Item | What to record |
| --- | --- |
| Slide / reveal or span | Exact location in the candidate. |
| Mathematical teaching move | What is being established or transformed. |
| Rule(s) | `R##`, including genuine tensions between rules. |
| Design action | What was shown, omitted, carried forward, aligned, highlighted, or revealed. |
| Why this should help | Specific audience-facing mechanism, not merely “improves clarity.” |
| Visible verification | What actual rendered state shows; include paths or links when available. |
| Exception / concern | Rules deliberately not applied and why; unresolved cognitive or mathematical risks. |
| Consultation | Human question, alternatives, recommendation, and decision if supplied. |

Do **not** manufacture a row for every rule on every slide. Do include decisions involving new notation, omitted or compressed algebra, nontrivial reveal design, and the determinant/normalization proof. Report explicitly if the rendered result fails to realize the design intention.

Use this record to distinguish three diagnoses when an instructor finds a problem: **rule not applied**, **rule applied but implemented ineffectively**, or **rule itself insufficient/in conflict with a more important purpose**. A fourth possibility is that the mathematical/teaching specification needs changing; return that issue to the appropriate owner instead of hiding it inside layout work.

## 5. Sources and provenance

These are inputs to a **course-specific synthesis**, not a claim that all fifteen rules are individually experimentally validated for advanced statistics proof slides. In particular, multimedia-learning results about signaling, contiguity and segmentation motivate a direction; their exact translation to instructor-paced Typst equation reveals is an authoring judgment to be tested.

- **[M] Multimedia learning research:** Fiorella & Mayer, *Principles for Reducing Extraneous Processing in Multimedia Learning* (coherence, signaling, spatial and temporal contiguity), Cambridge Handbook of Multimedia Learning (2021), https://doi.org/10.1017/9781108894333.019 ; Mayer & Fiorella, *Principles for Managing Essential Processing in Multimedia Learning* (segmenting, pre-training), Cambridge Handbook of Multimedia Learning (2021), https://www.cambridge.org/core/books/abs/cambridge-handbook-of-multimedia-learning/principles-for-managing-essential-processing-in-multimedia-learning/A9E77D0172F905AC957689D1771E2888 .
- **[W] Worked-explanation / learner expertise perspective:** *Ten quick tips for creating an effective lesson*, especially worked examples, concreteness fading, and expertise reversal, https://pmc.ncbi.nlm.nih.gov/articles/PMC6459472/ .
- **[N] Existing agent rule list:** *Equation and Notation Slides*, https://github.com/wdempsey/powerpoint-skills/blob/main/slides/equation-and-notation-slides/SKILL.md ; *Math Beamer*, https://github.com/VeryMath/AI4Math-Writing/blob/main/skills/math-beamer/SKILL.md . These are useful checklists, not authoritative replacements for the course pipeline.
- **[T] Existing Typst/Touying slide guidance:** https://github.com/Noi1r/typst-slide/blob/main/SKILL.md . Borrow pedagogical ideas selectively; do **not** adopt its theme, fixed pacing rules, or incompatible Touying configuration wholesale.
- **[C] Current course requirements:** `Lectures/slide_design_conventions.md`, `.agents/skills/slide-design/SKILL.md`, `Lectures/slide_authoring_conventions.md`, `.agents/skills/slide-authoring/SKILL.md`, `Lectures/README.md`, relevant L01 scope/development records, and actual previous student-visible slides. Read the live checkout rather than assume the public default branch is the current worktree.
- **[B] Mathematical source:** Kevin P. Murphy, *Probabilistic Machine Learning: Advanced Topics*, §2.3.1.3 and §2.3.1.5, especially the Gaussian conditioning formula, block-matrix inverse, Schur complement and quadratic-factorization proof. Verify all notation and identities against the available edition.
- **[S] Local synthesis:** The requirement to make the mathematical *operation* and its *warrant* visibly locatable is a specific operational interpretation of the above principles for mathematical derivations, reinforced by the course's prior slide experience; it is not attributed verbatim to any one source.

---

## 6. Copy-and-paste prompt for local Codex

> The rulebook above should be supplied to Codex in the same message or as an accessible file. The prompt below is otherwise self-contained about the task and should not depend on this ChatGPT conversation.

```text
I want a bounded, rule-guided experiment in mathematical slide design for the Advanced Statistics / ProbabilisticMachineLearning course. The current target is the separate recorded proof of the Gaussian conditioning formulas, not a wholesale redesign of Lecture 1.

Read the attached (or local) document "Rule-guided mathematical slide design: Gaussian conditioning" in full, particularly R01–R15, the human-consultation rules H1–H4, and the rule-application ledger. Treat those numbered rules as explicit candidate design guidance, not as an additional permanent skill or a validation rubric that guarantees good slides.

First recover the actual local state. Inspect the worktree, branch, relevant source/recording files and development records. Identify the mathematical obligation and what is accepted versus still provisional. Read the authoritative Murphy passage (Book 2, §2.3.1.5), the live conditioning material that students have already seen, and the current slide-design/authoring conventions. Keep the existing production deck and accepted scope intact. If the target local recording or essential authoritative input cannot be identified, ask one focused question rather than guessing.

The agreed high-level boundary is: the live lecture uses the residual/independence argument; the separate recording provides the full block-elimination derivation and must reach the normalized Gaussian conditional density, including the positive-definiteness/invertibility conditions, quadratic separation, and determinant/normalizer factorization. The proposed detailed route or length is not automatically an approved commitment. Preserve mathematical correctness and depth; do not replace the proof by a high-level summary.

Your job is to make a better FIRST design, not to repair a list of previously criticized details. Use the rules proactively to develop a coherent mathematical explanation of the whole selected proof. You are allowed to propose a different experimental slide organization, notation choice, or reveal sequence where it would improve exposition, while flagging divergence from accepted upstream decisions. Do not mechanically copy the old slides or overfit to the known complaints about them. Nor should you add notation, diagrams, explanations, or slides just to demonstrate that a rule was used.

Make an initial mathematical-argument map and the principal choices about which steps are visible together, which need progressive reveal, and where the proof's decisive transformations and warrants will be seen. Then produce a coherent, isolated candidate design using the existing Typst/Touying course design language, plus representative rendered student-visible states; develop the complete first-pass candidate after any necessary instructor consultation. The emphasis is the visible mathematical development and its classroom intelligibility, not visual novelty or production polish.

We have a HUMAN IN THE LOOP. Do not try to make every pedagogical tradeoff autonomously. Where a consequential design decision has two credible alternatives, give me a concrete, brief comparison (ideally a rendered pair or a small mathematical sketch), your reasoning and recommendation, and ask ONE decision at a time. Do this early enough that my choice can still shape the initial design. Otherwise use well-justified defaults and keep moving. Do not make me approve routine mechanical choices; do not treat silence as approval. If the decision affects accepted mathematical coverage or proof depth, identify it as such rather than quietly changing it.

While designing, maintain a SELECTIVE rule-application ledger: location, mathematical move, R## rule(s), precise design action, expected benefit to a student, observed rendered evidence, deliberate exceptions/conflicts, and any instructor consultation. Record consequential choices at the time they are made; do not backfill generic declarations that all rules were satisfied. In particular, track introduction of notation, visibility of matrix operations and cancellations, progressive reveals, retained mathematical anchors, and completion of the normalizing-constant argument.

Keep the experiment isolated: do not modify shared skills, conventions, the canonical lecture deck, or accepted artifacts; do not merge or publish the experiment. Avoid interfering with another session's worktree. Identify exactly what experimental files you created and where. Use the course's existing compile/math-attachment/slide-render checks on any executable Typst you produce, and inspect the meaningful presentation states and final handout. A clean compile is not evidence that the exposition is good. If full rendering is not yet practical, state what was actually inspected and what remains unverified.

For the first handoff, show:
1. The complete intended mathematical arc in a compact form and the initial candidate design / selected real renders.
2. A short rule-application ledger that lets us see how the rules affected actual design decisions (including meaningful exceptions).
3. Specific, source-grounded uncertainties or tradeoffs, with no more than ONE instructor decision requested at a time.
4. A brief note on whether the design seems to improve what mathematical operations are visible, not merely whether the proof is reconstructible by an expert. Clearly label this as the author's judgment, not instructor validation.

After I have seen the candidate, we can compare it against the baseline and diagnose shortcomings as: rule not applied, rule applied ineffectively, inadequate rule, or a problem in the mathematical teaching specification. Do not preempt that comparison by declaring success or changing the permanent workflow.
```

## 7. What would count as a useful outcome?

A useful outcome is **not** an automatic score or a favorable review. It is an instructor-inspectable first candidate in which the route from joint Gaussian to conditional law is genuinely easier to follow, along with enough provenance to explain *why* it was designed that way. It is also useful to discover that a seemingly sensible rule creates clutter, conceals a dependency, or conflicts with an important mathematical teaching choice. The ledger makes such findings actionable without committing to a new skill.
