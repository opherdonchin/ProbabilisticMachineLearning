# Teaching notebook tags

These tags support authoring the solved notebook first and generating the student self-work notebook mechanically.

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

Use on cells that must remain visible in the student version because they provide shared information, infrastructure, code, formulas, or conclusions needed for subsequent work.

Typical uses:

- setup and imports;
- data loading;
- plotting helpers;
- equations supplied by lecture;
- deliberately supplied code too peripheral to the learning target;
- a conclusion that subsequent questions should build on.

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
