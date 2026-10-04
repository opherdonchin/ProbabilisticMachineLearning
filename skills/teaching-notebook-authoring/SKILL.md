---
name: teaching-notebook-authoring
description: Transform a validated worked solution into a fine-grained solved Q&A teaching notebook and mechanically derive the student self-work version.
---

# Teaching-notebook authoring

Use this skill **after** a worked solution exists. Its job is not to invent a new solution. Its job is to expose the existing solution as the course's characteristic fine-grained, AI-assisted question-and-answer sequence.

Read before authoring:

- the worked-solution handoff;
- the relevant lecture material;
- `skills/teaching-notebook-authoring/references/student-knowledge.md`;
- `skills/teaching-notebook-authoring/references/notebook-tags.md`;
- the root `AGENTS.md` for runtime and notebook-format rules.

## Pedagogical model

The solved notebook is authored **first as questions followed immediately by complete answers**. The student self-work notebook is then produced from that solved notebook by removing designated solution cells.

This is not an incidental format. It is the core pedagogy.

Students should be able to:

1. read a small, local question;
2. paste that question into an AI chat if they need help;
3. receive an answer that is likely to be usable in the notebook;
4. copy or adapt the answer with little difficulty;
5. understand what the answer does in the immediate context;
6. continue to the next question without losing the overall mathematical thread.

Fine granularity is therefore a feature, not a sign of overscaffolding. But fine granularity does **not** mean turning every line of setup or every syntax atom into a separate exercise.

## What changes from the Short Bayes Course

Preserve the Q&A-first and fine-grained structure, but change the **subject of the questions**.

This course is about coherent understanding of machine-learning methods within a probabilistic framework. Questions should therefore focus on:

- the lecture's equations and representations;
- identifying the role and shape of mathematical objects;
- mapping lecture notation into computation;
- applying a supplied equation to concrete quantities;
- identifying which term or parameter controls a behavior;
- predicting the consequence of a manipulation;
- choosing a manipulation to obtain a desired consequence;
- connecting two equivalent formulations of the same method;
- new computational syntax or libraries when they are genuinely unfamiliar.

Do not spend notebook time quizzing routine PyMC syntax that students already know.

## Required knowledge report before authoring

Before writing the notebook, produce a brief notebook-specific knowledge report with exactly these categories:

### Assume familiar

Concepts and APIs that may be used without explicit scaffolding.

### Previously encountered — scaffold when needed

Concepts and APIs students have seen before but should not yet be expected to use fluently without support.

### New in this lecture/notebook

Concepts, notation, APIs, packages, or computational idioms that need explicit introduction.

Use `skills/teaching-notebook-authoring/references/student-knowledge.md` as the source of truth, together with the current lecture material. Do not infer arbitrary familiarity from professional convention.

This report is an authoring contract: question granularity should visibly reflect it.

## Author the solved notebook first

### 1. Preserve the worked solution

Treat the validated worked solution as authoritative for:

- the mathematical route;
- model definition;
- numerical example;
- comparison methods;
- important outputs;
- deliberate manipulations.

You may reorder a small step when necessary for pedagogical continuity, but do not silently substitute a different method because it creates easier exercises.

At the end, the solved Q&A notebook should reproduce the worked solution's substantive results.

### 2. Separate setup from student work

Do **not** mechanically convert every element of the worked solution into a question.

Before writing numbered questions, identify material that is merely infrastructure or a deliberately chosen example construction. Typical examples include:

- imports and runtime setup;
- random seeds;
- data loading or simulation code;
- arbitrary numerical parameter choices used to define the example;
- plotting helpers and formatting;
- a nonstandard covariance construction chosen only to create a useful synthetic example;
- boilerplate needed to put the notebook in a known state.

When such material is not itself a learning objective, provide it as one coherent **given setup block** rather than decomposing it into many exercises.

A given setup block may contain:

- explanatory Markdown;
- mathematical definitions;
- code that students simply run;
- the resulting dataset or model state.

It is often better to begin the numbered work **after** the relevant state has already been constructed.

It is also valid to provide a block of code first and then ask questions about what specific lines or objects do. Use this when the learning objective is to read and understand a construction rather than reproduce it from scratch.

### 3. Every question must be fully specified from visible context

A student should never have to guess an arbitrary modeling or setup choice that exists only in the author's head or in the worked solution.

Before asking a question, check that all information needed to answer it is either:

- contained in the question itself; or
- visibly established in immediately preceding notebook material.

Bad example:

> What are the dimensions of $x_1$ and $x_2$?

when the notebook has never specified how many components belong to either block.

Better:

> The setup defines $x_1=(x_{11},x_{12},x_{13})^T$ and $x_2=(x_{21},x_{22},x_{23},x_{24})^T$. What are the shapes of $\Sigma_{12}$ and $\Sigma_{21}$?

Do not rely on follow-up prose or an answer cell to supply facts the student needed in order to understand the original question.

### 4. Make the expected student action unambiguous

For every instructional item, it should be clear whether the student is expected to:

- answer in prose or mathematics;
- write and run code;
- modify existing code;
- predict a result before a supplied cell is run;
- inspect a supplied result;
- simply run a given cell.

Do not place an unexplained code block after an answer if it is unclear whether that code is part of the answer, a given cell, or a separate task.

When a question expects code, say so explicitly, e.g.:

> Using `np.block`, construct the full covariance matrix $\Sigma$ from the four blocks already defined.

Then the answer cell should contain the runnable code.

### 5. Identify transitions in the solution

Read the worked solution from top to bottom and mark transitions such as:

- introducing a mathematical object;
- partitioning or reshaping it;
- selecting an equation;
- mapping symbols to variables;
- computing a new quantity;
- introducing unfamiliar syntax;
- making a prediction;
- performing a manipulation;
- comparing two routes.

Each transition is a candidate for one or more questions, but not every implementation line deserves its own question.

### 6. Break transitions into locally answerable questions

Prefer questions with a narrow target.

Good examples:

- The setup defines $x_1\in\mathbb R^3$ and $x_2\in\mathbb R^4$. What is the shape of $\Sigma_{12}$?
- Using the covariance definition above, calculate $\operatorname{Cov}(X_{11},X_{21})$ for the supplied parameter values.
- Which covariance block determines whether observing $x_2$ can shift our mean prediction for $x_1$?
- Which term in the conditional-mean equation is the innovation?
- If $\Sigma_{12}=0$, what should happen to the conditional mean?
- In the lecture's linear-Gaussian notation, which variable here should play the role of $z$?
- Using `np.linalg.solve`, implement the matrix expression $W=\Sigma_{21}\Sigma_{11}^{-1}$ without explicitly forming an inverse.
- Which parameter should we change if we want the observation to carry less information about the latent variable?

A question may be mathematically simple. Simplicity is appropriate when it lets students maintain continuity and successfully use AI assistance.

However, prefer **concrete mathematical referents** over vague prompts. Ask for $\operatorname{Cov}(X_{11},X_{21})$, a matrix shape, a specific term, or a specific predicted change rather than asking broadly about "the covariance" or "the relationship between the groups."

### 7. Fine-grained does not mean syntax-fragmented

Do not normally split a single small coding action into questions such as:

1. What NumPy function should we use?
2. Now use that function to construct the matrix.

Instead, when the API name itself is useful support, give it in the question and ask the student to use it:

> Using `np.block`, construct
> $$
> \Sigma=\begin{pmatrix}\Sigma_{11}&\Sigma_{12}\\\Sigma_{21}&\Sigma_{22}\end{pmatrix}.
> $$

This mirrors the productive Short Course pattern: provide enough API information that the student or an AI can generate the relevant code, while leaving the task-specific construction to the student.

Split API identification from implementation only when recognizing or selecting the API is itself an explicit learning objective.

### 8. Teach unfamiliar syntax at the right granularity

Syntax questions are appropriate when the syntax is new and serves the method.

Examples may include:

- a NumPy block-matrix operation;
- `np.linalg.solve`;
- new scikit-learn estimator APIs;
- tensor reshaping or broadcasting;
- new PyTorch/JAX constructs;
- unfamiliar PyMC functionality such as a distribution or missing-data mechanism.

Before asking such questions, consult `skills/teaching-notebook-authoring/references/student-knowledge.md`. Do not repeatedly quiz syntax already established as familiar.

For unfamiliar syntax, prefer one of these patterns:

1. **Give the API, ask for the task-specific code.**
   Example: "Use `np.linalg.solve(A, B)` to compute $A^{-1}B$ without explicitly inverting $A$. Apply it to compute $W$."

2. **Give a complete code construction, then ask what a specific line/object does.**
   Use this when the code is mostly setup and the conceptual reading is more important than reproduction.

3. **Give a minimal example, then ask students to adapt it.**

Do not assume that introducing an unfamiliar API requires a separate trivia question about its name.

### 9. Provide background before questioning an author-created construction

If the worked solution uses a construction that is not already part of the lecture — for example a custom compound-symmetry covariance model used to generate synthetic data — explain the construction before asking students to calculate with it.

The explanation should establish:

- what the parameters mean;
- the relevant mathematical formula;
- which variables or blocks it defines;
- any constraints needed for the construction.

Then questions may ask students to compute concrete quantities from it or identify consequences.

Do not ask students to reverse-engineer an arbitrary setup choice from code unless reading that code is itself the objective.

### 10. Apply lecture mathematics; do not turn the notebook into a derivation exercise

The lecture normally supplies the mathematical result. The notebook should make students:

- recognize its components;
- map symbols to the current example;
- evaluate it;
- implement it;
- compare it with another formulation;
- manipulate inputs or parameters and predict consequences.

Do not require a derivation merely because one exists. A derivation belongs in the notebook only when deriving that result is itself an explicit learning objective.

### 11. Prefer prediction and intervention to generic interpretation

Avoid generic prompts such as:

- "Interpret this plot."
- "What does this result mean?"
- "Discuss the posterior."

Such questions are often underspecified and can reward plausible prose without testing the model's mechanism.

Prefer a commitment that can be checked in the next cell:

- What do you predict will happen if we set the cross-covariance to zero?
- Which parameter must increase to make the posterior wider?
- If we remove this feature, which term in the score function disappears?
- Which manipulation should make the two clusters harder to distinguish?

Then **perform the manipulation** and show the result immediately afterward.

Questions about consequences are especially useful when the next cell provides empirical or numerical feedback.

### 12. Follow the method, not a generic methodology template

Do not impose a Bayesian-workflow sequence on every notebook.

Use priors, prior predictive checks, diagnostics, posterior predictive checks, or other methodological stages only when they illuminate the machine-learning method being taught.

The default structure should follow:

- the lecture;
- the book's method sequence;
- the worked example's computational logic.

This course teaches methods. Methodological workflow appears where it reveals something important about those methods.

### 13. Keep comparable results visually comparable

If two approaches answer the same question, use the same graphical grammar for both and add a direct comparison when useful.

For example:

- same variables and ordering;
- same interval type and probability;
- same axis limits;
- same point-estimate convention;
- same plot geometry;
- an explicit difference/comparison plot or table.

Do not make students infer agreement from two unrelated-looking displays.

## Student-knowledge tracking

Student knowledge is cumulative and must affect question design.

At the start of authoring:

1. read `skills/teaching-notebook-authoring/references/student-knowledge.md`;
2. produce the required three-category knowledge report;
3. identify which required mathematical and computational constructs are already familiar;
4. identify previously encountered constructs that still need scaffolding;
5. identify constructs newly introduced in this lecture/notebook;
6. scaffold the latter two categories at appropriate granularity;
7. avoid re-teaching familiar constructs unless the current use is genuinely different.

After the notebook is finalized, produce a **knowledge-state change report** with:

- items newly introduced in this notebook that should now move to "previously encountered — scaffold when needed";
- any items deliberately promoted from "previously encountered" to "assume familiar";
- items whose status should not change.

Do **not** automatically promote a construct to "assume familiar" merely because it appeared once. Promotion should be deliberate and supported by repeated use or an explicit course decision.

Then update `skills/teaching-notebook-authoring/references/student-knowledge.md` as a separate final authoring step.

## Notebook cell pattern

The typical instructional rhythm is:

1. `exercise-question` markdown cell;
2. immediately following `solution` markdown or code cell;
3. optional `given` material needed for the next step;
4. the next question.

But substantial setup may precede the numbered questions, and a supplied code block may precede questions that ask students to understand or manipulate it.

Use `given-answer` on a question when the answer itself should remain visible in the student version because it establishes shared information rather than testing student work.

In authoring reports and dry runs, visibly mark such answers as **[GIVEN]** even when notebook tags are not shown.

See `skills/teaching-notebook-authoring/references/notebook-tags.md`.

## Generating the self-work version

The solved notebook is the source of truth.

Generate the self-work notebook mechanically with `scripts/make_self_work_notebook.py` unless there is a specific reason not to.

The transformation should:

- preserve questions exactly;
- preserve `given` cells;
- preserve cells associated with `given-answer` questions;
- replace `solution` code cells with `# answer here`;
- replace `solution` markdown cells with `- answer here`;
- clear outputs and execution counts in the student version by default;
- preserve setup, data, helper, and other non-solution cells.

Do not independently rewrite or simplify the student version after generating it. If the student notebook is awkward, fix the solved notebook and regenerate.

## Validation

Before considering the pair complete:

### Solved notebook

- Does it run top to bottom under repository runtime rules?
- Does it reproduce the worked solution's substantive numerical results and figures?
- Does each question have a complete answer immediately available in the solved version?
- Does each question have a locally clear target?
- Is every question answerable from information visible before the answer cell?
- Is the expected student action clear: prose, math, code, modification, prediction, inspection, or simply running a given cell?
- Has non-instructional setup been bundled rather than pointlessly decomposed?
- Are new APIs scaffolded according to current student knowledge without syntax trivia fragmentation?
- Does the sequence follow the lecture's notation and method?
- Are manipulations preceded by explicit predictions where appropriate?
- Are comparable methods displayed comparably?

### Student notebook

- Was it generated from the solved notebook rather than independently authored?
- Are all designated solutions removed?
- Are all questions and supplied material preserved?
- Can a student work linearly from top to bottom?
- Would pasting an individual question into an AI chat normally produce enough context for a useful answer?
- Are answer placeholders of the appropriate type present?
- Is it always clear which supplied code should simply be run and which code the student is expected to write?

## Anti-patterns

Avoid:

- replacing many small questions with a few large tasks because the students are graduate students;
- asking a question before the notebook has supplied the facts needed to answer it;
- using the answer cell to reveal setup assumptions that should have appeared before the question;
- decomposing arbitrary setup into exercises merely because it appears in the worked solution;
- splitting "which function?" and "now call the function" into separate questions when one task-specific coding question would suffice;
- ambiguous code blocks whose status as given code or student work is unclear;
- generic interpretation questions used merely because "reflection" seems pedagogically desirable;
- unnecessary mathematical derivations;
- syntax quizzes for constructs students already know;
- hiding central method code in abstractions;
- imposing a prior/fit/PPC workflow when the method does not need it;
- inventing a second student-notebook narrative independent of the solved notebook;
- changing a validated worked solution just to make authoring easier.

## Completion criterion

The notebook pair is complete when the **solved notebook is a coherent, fine-grained Q&A explanation of the validated worked solution**, the **student notebook is that same notebook with answer cells mechanically removed**, and the authoring record includes explicit before/after knowledge-state reports.
