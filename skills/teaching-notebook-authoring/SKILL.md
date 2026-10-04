---
name: teaching-notebook-authoring
description: Transform a validated worked solution into a fine-grained solved Q&A teaching notebook and mechanically derive the student self-work version.
---

# Teaching-notebook authoring

Use this skill **after** a worked solution exists. Its job is not to invent a new solution. Its job is to expose the existing solution as the course's characteristic fine-grained, AI-assisted question-and-answer sequence.

Read before authoring:

- the worked-solution handoff;
- the relevant lecture material;
- `references/student-knowledge.md`;
- `references/notebook-tags.md`;
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

Fine granularity is therefore a feature, not a sign of overscaffolding.

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

### 2. Identify transitions in the solution

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

Each transition is a candidate for one or more questions.

### 3. Break transitions into locally answerable questions

Prefer questions with a narrow target.

Good examples:

- Which entries of $x$ are observed and which are missing?
- What is the shape of $\Sigma_{12}$?
- Which covariance block determines whether observing $x_2$ can update our beliefs about $x_1$?
- Which term in the conditional-mean equation is the innovation?
- If $\Sigma_{12}=0$, what should happen to the conditional mean?
- In the lecture's linear-Gaussian notation, which variable here should play the role of $z$?
- What NumPy operation can solve $AX=B$ without explicitly computing $A^{-1}$?
- Which parameter should we change if we want the observation to carry less information about the latent variable?

A question may be mathematically simple. Simplicity is appropriate when it lets students maintain continuity and successfully use AI assistance.

### 4. Teach unfamiliar syntax at fine granularity

Syntax questions are appropriate when the syntax is new and serves the method.

Examples may include:

- a NumPy block-matrix operation;
- `np.linalg.solve`;
- new scikit-learn estimator APIs;
- tensor reshaping or broadcasting;
- new PyTorch/JAX constructs;
- unfamiliar PyMC functionality such as a distribution or missing-data mechanism.

Before asking such questions, consult `references/student-knowledge.md`. Do not repeatedly quiz syntax already established as familiar.

When uncertain whether students know a construct, prefer a small introductory question or supplied example rather than assuming fluency.

### 5. Apply lecture mathematics; do not turn the notebook into a derivation exercise

The lecture normally supplies the mathematical result. The notebook should make students:

- recognize its components;
- map symbols to the current example;
- evaluate it;
- implement it;
- compare it with another formulation;
- manipulate inputs or parameters and predict consequences.

Do not require a derivation merely because one exists. A derivation belongs in the notebook only when deriving that result is itself an explicit learning objective.

### 6. Prefer prediction and intervention to generic interpretation

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

### 7. Follow the method, not a generic methodology template

Do not impose a Bayesian-workflow sequence on every notebook.

Use priors, prior predictive checks, diagnostics, posterior predictive checks, or other methodological stages only when they illuminate the machine-learning method being taught.

The default structure should follow:

- the lecture;
- the book's method sequence;
- the worked example's computational logic.

This course teaches methods. Methodological workflow appears where it reveals something important about those methods.

### 8. Keep comparable results visually comparable

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

1. read `references/student-knowledge.md`;
2. identify which required mathematical and computational constructs are already familiar;
3. identify constructs newly introduced in this lecture/notebook;
4. scaffold the new constructs at finer granularity;
5. avoid re-teaching familiar constructs unless the current use is genuinely different.

After the notebook is finalized, update the knowledge file with newly established notation, APIs, packages, and computational idioms that later notebooks may assume.

## Notebook cell pattern

The typical instructional rhythm is:

1. `exercise-question` markdown cell;
2. immediately following `solution` markdown or code cell;
3. optional `given` material needed for the next step;
4. the next question.

Use `given-answer` on a question when the answer itself should remain visible in the student version because it establishes shared information rather than testing student work.

See `references/notebook-tags.md`.

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
- Are new APIs scaffolded according to current student knowledge?
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

## Anti-patterns

Avoid:

- replacing many small questions with a few large tasks because the students are graduate students;
- generic interpretation questions used merely because "reflection" seems pedagogically desirable;
- unnecessary mathematical derivations;
- syntax quizzes for constructs students already know;
- hiding central method code in abstractions;
- imposing a prior/fit/PPC workflow when the method does not need it;
- inventing a second student-notebook narrative independent of the solved notebook;
- changing a validated worked solution just to make authoring easier.

## Completion criterion

The notebook pair is complete when the **solved notebook is a coherent, fine-grained Q&A explanation of the validated worked solution**, and the **student notebook is that same notebook with answer cells mechanically removed**.
