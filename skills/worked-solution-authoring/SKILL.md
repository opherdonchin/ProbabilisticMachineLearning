---
name: worked-solution-authoring
description: Build and validate a technically correct worked computational example from lecture material, a book section, or a guiding prompt before turning it into a teaching notebook.
---

# Worked-solution authoring

Use this skill when developing the **technical solution** that will later become a teaching notebook. The purpose of this stage is to solve the intended problem correctly and coherently, not yet to design student exercises.

## Core principle

Separate **solving the problem** from **teaching the solution**.

At this stage, optimize for mathematical correctness, alignment with the lecture, computational clarity, and useful outputs. Do not break the solution into student questions yet. Do not simplify or distort the method merely because a different route might be easier to turn into exercises.

The worked solution becomes the authoritative handoff to `../teaching-notebook-authoring/SKILL.md`.

## Inputs

Normally use all three:

1. **Relevant lecture material**
   - Use the lecture's notation, equations, terminology, and conceptual order.
   - Treat the lecture as authoritative for what method is being taught.
   - Equivalent mathematics is not automatically pedagogically equivalent: avoid changing notation or replacing the lecture method without a substantive reason.

2. **A guiding problem or prompt**
   - State what the example should demonstrate.
   - State the intended starting information and final outputs.
   - State any deliberate exclusions, such as keeping model parameters known rather than estimating them.

3. **Course context**
   - Know what students have already seen, but do not use this stage to scaffold every step.
   - The student-knowledge state becomes a primary input in the later teaching-notebook stage.

A worked solution may also be supplied directly. In that case, inspect and validate it rather than recreating it gratuitously.

## Procedure

### 1. Identify the learning target

Write a compact statement of what the worked example is meant to make concrete. Prefer one or two method-level goals.

Example:

- use Gaussian conditioning to infer a missing block of a multivariate observation;
- connect the same inference problem to the lecture's linear-Gaussian-system equations.

### 2. Fix the mathematical route

List the lecture equations and representations the example will use.

Distinguish:

- quantities given by the problem;
- quantities computed from them;
- observed variables;
- latent or missing variables;
- numerical approximations or sampling steps;
- exact analytic results.

If there are several legitimate solution routes, choose the one that best matches the lecture unless the prompt explicitly asks for a comparison.

### 3. Build the example end to end

Produce the complete computational path before adding pedagogy.

Prefer a linear, readable notebook/script flow. Do not hide the central mathematics behind helper functions merely for software elegance. Small helpers are appropriate for purely presentational work when they genuinely reduce noise.

Use current, native library functionality when it expresses the intended method clearly. Follow repository runtime rules in the root `AGENTS.md`.

### 4. Make comparable outputs genuinely comparable

When the example contains two routes to the same target, use the same quantities and plotting grammar for both.

For example, if comparing Monte Carlo inference with an exact Gaussian posterior:

- plot the same variables;
- use the same interval convention;
- use the same axis limits and visual encoding where practical;
- add a direct comparison figure or table rather than forcing the reader to compare separate plots mentally.

### 5. Validate the solution

Check, as applicable:

- shapes and dimensions;
- positive-definiteness or other model constraints;
- numerical agreement between equivalent formulations;
- exact versus Monte Carlo error;
- reproducibility under a fixed seed;
- top-to-bottom execution;
- the repository's local and Colab runtime requirements.

If the runtime available during authoring cannot execute a required package, say so explicitly. Do not fabricate a successful run. Validate the portions that can be validated and record what still requires the course runtime.

### 6. Identify useful manipulations

A strong worked example often includes one or more controlled manipulations whose consequences are predictable from the method.

Examples:

- set a cross-covariance block to zero;
- increase observation noise;
- alter a kernel length scale;
- remove a feature;
- increase a regularization parameter;
- change the number of mixture components.

Prefer manipulations that expose a method's mechanism or limitation. Do not add sensitivity analyses merely because they are easy to compute.

### 7. Produce the handoff

Create a handoff using `references/handoff-template.md`.

The handoff should contain:

- learning target;
- lecture concepts and equations used;
- starting information;
- solution sequence;
- new computational tools/APIs;
- reference implementation location;
- expected numerical/graphical outputs;
- validated equivalences or tolerances;
- useful manipulations and their predicted effects;
- deliberate exclusions;
- any unresolved runtime or technical issues.

## What this skill should not do

Do not:

- design the student self-work notebook;
- break every operation into questions;
- insert generic interpretation prompts;
- impose a Bayesian-workflow template unless the method itself requires those steps;
- derive mathematics that the lecture gives as a result unless derivation is itself the teaching target;
- replace the lecture's method with a pedagogically convenient alternative;
- assume that a technically elegant abstraction is better for teaching.

## Completion criterion

This stage is complete when there is a worked example that an instructor would be happy to execute and explain as a technically correct demonstration **even if no student exercise version were ever made**.
