# Teaching notebook tags

These tags support authoring the solved notebook first and generating the student self-work notebook mechanically.

## Visible structure and instructional rhythm

Use the following student-facing Markdown hierarchy:

- `#` notebook title;
- `##` main section;
- `###` material boundary: **Explanation to read**, **Code to run**, or **Questions to answer**;
- `####` content title or numbered question.

Repeat a material boundary when the material type changes, rather than before every cell of the same type. Prefer local sequences of explanation, short supplied supporting code, then student work. Supply code only when it supports the mathematical target; keep the calculations students are meant to implement as questions.

Keep supplied code cells short and coherent. Explain their purpose, inputs, operations and expected output in preceding Markdown, with an explicit **Run the code cell below** instruction. Brief code comments complement that explanation. Supplied setup may span several short cells under one material boundary. Do not rely on hidden tags or a visible `[GIVEN]` marker to tell students what to do.

Number questions consistently within sections. Each question has exactly one immediate unnumbered answer cell, including when its answer is supplied as an example. Student-written code belongs under **Questions to answer**, not **Code to run**.

## `explanation`

Use on ordinary reading cells: mathematical background, interpretation, introductory guidance and retrospective summaries. Explanations are unnumbered. They remain in the student notebook; the generator removes only `solution` content.

## `run-instruction`

Use on the Markdown cell immediately preceding each supplied code cell, alongside `given`. It explains the code and explicitly tells the student to run it. This is authoring metadata, not another visible material type.

## `section`

Use on Markdown cells that define the main instructional sections.

Purpose:

- preserves a stable narrative structure;
- makes solved/student notebooks easy to compare;
- may support later tooling.

## `exercise-question`

Use on every student-facing question.

A good exercise question should normally:

- have one locally clear target;
- contain enough immediate context that a student can paste it into an AI chat and obtain a useful answer;
- advance the notebook by one conceptual or computational step;
- use the lecture's notation and vocabulary.

Questions may be simple. Granularity is deliberate.

## `solution`

Use on the answer cell immediately following an `exercise-question` when that answer should be removed from the student self-work version.

For code cells, the generated self-work placeholder is:

```python
# answer here
```

For Markdown cells, the generated self-work placeholder is:

```markdown
- answer here
```

The solved notebook should contain the full, correct answer rather than a hint.

## `given`

Use on supplied code and its run instructions, or an intentionally retained example answer. These cells remain visible in the student version. Use `explanation` for ordinary reading; both roles are preserved by the generator.

Typical uses:

- setup and imports;
- data loading;
- plotting helpers;
- deliberately supplied code too peripheral to the learning target;
- an example answer intentionally retained for students.

Do not tag something `given` merely because it is difficult. Use the course learning goal to decide whether students should produce it themselves.

## `given-answer`

Use on an `exercise-question` when the question is pedagogically useful but its answer should also remain visible in the student version.

This pattern is useful when:

- posing the question makes the conceptual transition explicit;
- the answer establishes shared information rather than serving as assessed student work;
- later questions depend on everyone having the same answer immediately.

Normally follow such a question with a `given` answer cell rather than a `solution` cell.

## Pairing rule

Unless there is a deliberate `given-answer` pattern, every `exercise-question` should be followed immediately by its corresponding `solution` cell.

Do not separate a question and its answer by unrelated exposition. The solved notebook should read naturally as Q&A.

## Source-of-truth rule

The solved notebook is authoritative.

If the self-work version needs a wording or sequencing change:

1. edit the solved notebook;
2. regenerate the self-work version;
3. do not maintain independent pedagogical edits in the student copy.
