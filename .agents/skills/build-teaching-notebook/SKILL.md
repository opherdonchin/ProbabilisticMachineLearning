---
name: build-teaching-notebook
description: Orchestrate creation of a course teaching notebook by first producing a validated worked solution, then transforming it into solved Q&A and student self-work notebooks.
---

# Build a teaching notebook

Follow the [repository writing requirements](../../../AGENTS.md#writing-for-the-instructor-and-students). Address a mathematically mature reader who may be unfamiliar with later methods: retain precise names, decision-relevant equations and assumptions, explain the concern clearly, and give verified focused book readings when needed. Clarity must preserve the mathematical substance rather than move every important distinction into checking notes.

Use this skill when the request is end-to-end: build a new course teaching notebook from lecture material, a book section, and/or a guiding prompt.

This skill orchestrates two distinct stages. Keep them separate even when they happen in one conversation.

## Stage 1: worked solution

Load and follow:

`../worked-solution-authoring/SKILL.md`

Produce a technically correct worked example first.

Do not begin by writing student exercises. The worked example should establish:

- the intended mathematical route;
- the numerical/computational implementation;
- the figures and comparisons that matter;
- any useful manipulations;
- validation checks;
- runtime caveats.

Complete the structured handoff in:

`../worked-solution-authoring/references/handoff-template.md`

Pause conceptually at the handoff: the technical solution is now the source of truth for the next stage.

## Stage 2: teaching notebook

Load and follow:

`../teaching-notebook-authoring/SKILL.md`

Use the worked-solution handoff, the relevant lecture material, and the current student-knowledge state to produce:

1. the **solved Q&A notebook**;
2. the **student self-work notebook** generated mechanically from it.

The second stage must not silently redesign the technical solution produced in Stage 1.

## Delegated learning review

For a substantial build/revision or an explicit independent-review request,
coordinate [the notebook review process](../teaching-notebook-authoring/references/delegated-review.md)
after a coherent student version exists. Separate its author, a fresh learner
attempt with no author guidelines/answer key, and informed independent diagnosis.
The coordinator may supply the informed review only when it did not author the
candidate. Give the author the normal guidelines; give the learner only its
profile, [learner protocol](../teaching-notebook-authoring/references/learner-review.md)
and sequential student-visible material. Do not expose this orchestration skill
or the author's rationale to the blind learner.

Keep raw attempts and versioned findings. Route repairs through the author;
return consequential pedagogical changes to the instructor in chat. A simulated
learner pass does not establish student learning, human completion time, technical
correctness, hosted execution or instructor approval. Minor fixes need only the
affected checks, not a new full review cycle.

## Order of authority

When constraints conflict, use this order:

1. explicit user/instructor request;
2. relevant lecture notation and method;
3. validated worked-solution handoff;
4. current student-knowledge state;
5. teaching-notebook authoring conventions;
6. software elegance or generic pedagogical preferences.

## Why the stages are separate

The worked-solution stage asks:

> What is the correct, coherent way to solve and demonstrate this problem?

The teaching-notebook stage asks:

> How do we expose that already-correct solution as a fine-grained AI-assisted Q&A sequence?

Do not optimize both simultaneously. A pedagogically convenient route must not replace the intended method, and a technically elegant implementation must not dictate the granularity of the student questions.

## When only one stage is needed

Use only `worked-solution-authoring` when:

- exploring whether an example is worth teaching;
- comparing possible examples;
- validating a method or implementation;
- the user explicitly wants only a worked example.

Use only `teaching-notebook-authoring` when:

- a validated worked solution already exists;
- adapting an existing solved example into course pedagogy;
- revising question granularity without changing the mathematics.

## End-to-end completion criteria

A full notebook build is complete only when:

- the worked solution is validated as far as the available runtime allows;
- the handoff is explicit;
- the solved notebook reproduces the worked solution's substantive outputs;
- the solved notebook is written as fine-grained questions followed by complete answers;
- unfamiliar syntax is scaffolded according to the student-knowledge file;
- prediction/manipulation questions are used where they can be checked directly;
- the student notebook is generated from the solved notebook rather than independently authored;
- when delegated review applies, its actual learner coverage, independent informed
  findings, author response and unresolved instructor decisions are recorded;
  partial/pending review does not count as a completed full-notebook review;
- repository notebook-runtime checks have been run or any remaining hosted-Colab check is explicitly identified.
