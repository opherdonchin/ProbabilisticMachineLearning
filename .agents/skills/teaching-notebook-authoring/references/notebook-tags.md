# Teaching notebook tags

These tags support authoring the solved notebook first and generating the student self-work notebook mechanically.

## Visible structure and instructional rhythm

Use the following student-facing Markdown hierarchy:

- `#` notebook title;
- `##` main section;
- `###` material boundary with italic text: `### *Explanation to read*`, `### *Code to run*`, or `### *Questions to answer*`;
- `####` content title or numbered question.

Repeat a material boundary when the material type changes, rather than before every cell of the same type. Prefer local sequences of explanation, short supplied supporting code, then student work. Supply code only when it supports the mathematical target; keep the calculations students are meant to implement as questions.

Reserve **Explanation to read** for a coherent teaching move that students need to absorb: a mathematical argument or representation from the lecture, or a substantive technical idea about code, packages or computation. Keep implementation documentation with **Code to run**. The distinction is the instructional purpose of the block; the presence of prose alone does not make it an Explanation.

Keep supplied code cells short and coherent. Their preceding Markdown should normally be one short paragraph explaining only the non-obvious purpose, inputs, operations or output. Use the established student-knowledge baseline: avoid narrating familiar syntax, readable assignments or facts already supplied nearby. Introduce unfamiliar operations where they are used. The **Code to run** heading supplies the instruction; do not repeat “Run the code below.” Brief code comments complement the notes.

When code notes grow long, inspect the surrounding Markdown for a shared concept that deserves a consolidated **Explanation to read** before the relevant code. Draw from several cells if needed, then shorten the local code notes to what remains specific to each operation. Do not fragment a larger explanation into many code notes, relabel a long implementation description without improving it, or duplicate the consolidated explanation beside every cell. Required retrospective section summaries remain concise.

Every supplied code cell should produce concise, meaningful visible feedback: a representative value or array, an informative shape, a plot, an initialized configuration, or a confirmation of specific checks. Existing useful output is sufficient; avoid exhaustive dumps or generic success messages when a concrete result is available. Print check confirmations only after assertions pass. Do not introduce extra random draws, change computation state, or reveal answers prematurely merely to create feedback.

Supplied setup may span several short cells under one material boundary. Do not rely on hidden tags or a visible `[GIVEN]` marker to tell students what to do.

Number questions consistently within sections. Each question has exactly one unnumbered answer-content cell, including when its answer is supplied as an example. In the solved notebook, bracket that cell with solved-only Markdown headings as specified below. In the student notebook, its answer/placeholder immediately follows the question. Student-written code belongs under **Questions to answer**, not **Code to run**.

## `explanation`

Use on substantive mathematical or technical teaching, first-notebook orientation and retrospective summaries. Keep documentation of a particular supplied code cell under Code to run. Explanations are unnumbered. They remain in the student notebook; the generator removes only `solution` content.

## `run-instruction`

Use on the Markdown cell immediately preceding each supplied code cell, alongside `given`. It explains the code; the visible **Code to run** heading tells the student to run it. This is authoring metadata, not another visible material type.

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

Use on the answer-content cell belonging to an `exercise-question` when that answer should be replaced by a placeholder in the student self-work version. Solved-only boundary cells surround it; they are not additional answer-content cells.

For code cells, the generated self-work placeholder is:

```python
# answer here
```

For Markdown cells, the generated self-work placeholder is:

```markdown
- answer here
```

The solved notebook should contain the full, correct answer rather than a hint.

## `solution-boundary`

Use on separate Markdown cells immediately before and after each solved answer-content cell, including code answers. Their exact contents under the current hierarchy are `##### start answer` and `##### end answer`. The marker heading is one level deeper than ordinary notebook content headings (currently level four).

These cells visually bracket the answer without changing its Markdown/code type or splitting its content. The student generator removes both boundary cells entirely, preserving one immediate unnumbered placeholder (or retained supplied answer) per question. Do not tag boundary cells `solution`, which would turn them into extra placeholders.

## `given`

Use on supplied code and its preceding explanations, or an intentionally retained example answer. These cells remain visible in the student version. Use `explanation` for ordinary reading; both roles are preserved by the generator.

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

In the solved notebook, each question is followed by a start boundary, one corresponding answer-content cell, and an end boundary. The answer is tagged `solution`, or `given` for a deliberate `given-answer` example. After boundary removal, the generated student notebook retains one immediate answer/placeholder per question.

Do not separate a question and its answer by unrelated exposition. The solved notebook should read naturally as Q&A.

## Source-of-truth rule

The solved notebook is authoritative.

If the self-work version needs a wording or sequencing change:

1. edit the solved notebook;
2. regenerate the self-work version;
3. do not maintain independent pedagogical edits in the student copy.
