---
name: teaching-notebook-authoring
description: Transform a validated worked solution into a fine-grained solved Q&A teaching notebook and mechanically derive the student self-work version.
---

# Teaching-notebook authoring

Follow the [repository writing requirements](../../../AGENTS.md#writing-for-the-instructor-and-students). Address a mathematically mature reader who may be unfamiliar with later methods: retain precise names, decision-relevant equations and assumptions, explain the concern clearly, and give verified focused book readings when needed. Clarity must preserve the mathematical substance rather than move every important distinction into checking notes.

Use this skill **after** a worked solution exists. Its job is not to invent a new solution. Its job is to expose the existing solution as the course's characteristic fine-grained, AI-assisted question-and-answer sequence.

Read before authoring:

- the worked-solution handoff;
- the relevant lecture material;
- `.agents/skills/teaching-notebook-authoring/references/student-knowledge.md`;
- `.agents/skills/teaching-notebook-authoring/references/notebook-tags.md`;
- the root `AGENTS.md` for runtime and notebook-format rules.

## Pedagogical model

The solved notebook is authored **first as questions followed immediately by complete answers**, with start/end markers inside each answer cell. The student self-work notebook is then produced by replacing designated solutions, including their markers, with placeholders. Both notebooks retain the same cell count, types and order.

This is not an incidental format. It is the core pedagogy.

Students should be able to:

1. read a small, local question;
2. paste that question into an AI chat if they need help;
3. receive an answer that is likely to be usable in the notebook;
4. copy or adapt the answer with little difficulty;
5. understand what the answer does in the immediate context;
6. continue to the next question without losing the overall mathematical thread.

Fine granularity is therefore a feature, not a sign of overscaffolding. But fine granularity means **small coherent conceptual or computational units**, not one question per algebraic step, output, or syntax atom.

## What changes from the Short Bayes Course

Preserve the Q&A-first and fine-grained structure, but change the **subject of the questions**.

This course develops working competence in machine-learning problems and methods
through a coherent probabilistic understanding. Questions should therefore focus on:

- the lecture's equations and representations;
- identifying the role and shape of mathematical objects;
- mapping lecture notation into computation;
- applying a supplied equation to concrete quantities;
- identifying which term or parameter controls a behavior;
- connecting a lecture-level task schema to the specific computational problem;
- predicting the consequence of a manipulation when that prediction tests an important mechanism;
- connecting two equivalent formulations of the same method;
- new computational syntax or libraries when they are genuinely unfamiliar.

Do not spend notebook time quizzing routine PyMC syntax that students already know.

## Choose what students should construct

Allocate intellectual work before choosing a material heading. For each coherent
step, identify the capability students should acquire and the connection they
should make themselves: formulation, mathematical representation, implementation,
inspection or judgment.

- Supply the premises: data, deliberately chosen assumptions, definitions,
  conventions and lecture results. Ask students to make consequential connections
  from them. Do not ask them to guess an unstated author choice.
- Use scaffolded questions when students can reach a useful result from their
  current knowledge, visible information and permitted documentation/AI help.
  Questions can teach unfamiliar material through manageable intermediate
  relationships; unfamiliarity alone is not a reason to explain the answer first.
- Use a coherent explanation or worked example when students need a new idea,
  representation or technique before attempting a meaningful application. Supply
  enough foundation without routinely performing that application for them.
- Supply code peripheral to the intended capability. Keep central method
  calculations as student work where appropriate. Supplied code can also be an
  object students inspect, explain or modify; difficulty and line count do not
  determine its role.
- Give each scaffolded question a distinct instructional purpose. Separating
  meaning from implementation can help; separating every assignment need not.
  Retrieval, rehearsal and applying supplied evaluation criteria are legitimate
  purposes. An answer supported by preceding explanation is not automatically
  redundant.

Record a short rationale for these choices in the existing authoring report,
grouped by learning step rather than by every cell. Identify what is supplied,
what students construct, the prerequisite support and what their answer reveals.
Question count and category percentages are descriptive checks, not targets.
Do not optimize them by relabeling exposition or inventing extra exercises.
Preserve the agreed mathematical route and instructor-owned scope decisions.

For a requested delegated review or a substantial notebook build/revision, use
[the delegated review process](references/delegated-review.md). Keep the author's
guidelines separate from the learner's brief; the blind learner receives only
[the learner protocol](references/learner-review.md), a knowledge/personality
profile and sequential student-visible material. Never give that learner this
skill, the authoring report, anticipated faults or the solved reference.

## Required knowledge report before authoring

Before writing the notebook, produce a brief notebook-specific knowledge report with exactly these categories:

### Assume familiar

Concepts and APIs that may be used without explicit scaffolding.

### Previously encountered — scaffold when needed

Concepts and APIs students have seen before but should not yet be expected to use fluently without support.

### New in this lecture/notebook

Concepts, notation, APIs, packages, or computational idioms that need explicit introduction.

Use `.agents/skills/teaching-notebook-authoring/references/student-knowledge.md` as the source of truth, together with the current lecture material. Do not infer arbitrary familiarity from professional convention.

The report is an authoring contract: question granularity should visibly reflect it.

When a library has changed since the students' previous course, explicitly record the old familiar concept and the new current representation/API separately. Do not treat an old API as evidence that the new one is familiar.

## Verify current APIs before authoring

For fast-moving packages such as PyMC, ArviZ, scikit-learn, PyTorch, or JAX:

1. identify the course-target package version or current runtime;
2. verify relevant behavior against the official documentation for that version;
3. prefer current native APIs over remembered older idioms;
4. note meaningful version drift in the knowledge report;
5. do not build exercises around behavior that has only been assumed from memory.

If official documentation and an API reference disagree, prefer a current worked example/source implementation or verify by running the course environment before final publication.

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

A given setup block may contain explanatory Markdown, mathematical definitions, code students simply run, and the resulting data/model state.

It is often better to begin the numbered work **after** the relevant state has already been constructed.

It is also valid to provide a block of code first and then ask questions about what specific lines or objects do. Use this when the learning objective is to read and understand a construction rather than reproduce it from scratch.

### 3. Every question must be fully specified from visible context

A student should never have to guess an arbitrary modeling or setup choice that exists only in the author's head or in the worked solution.

Before asking a question, check that all information needed to answer it is either contained in the question itself or visibly established in immediately preceding notebook material.

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
- modify or extend existing code;
- consult supplied documentation;
- predict a result before a supplied cell is run;
- inspect a supplied result;
- simply run a given cell.

Do not place an unexplained code block after an answer if it is unclear whether that code is part of the answer, a given cell, or a separate task.

### 5. Use coherent local units, not atomic microsteps

A single question may contain several tightly coupled actions when they form one natural operation.

Good examples:

- calculate a covariance and then normalize it to the corresponding correlation;
- construct a covariance matrix, print its shape, and check that the shape matches the mathematical dimensions;
- call a summary function and identify the requested quantities in its output;
- add one model component and inspect the resulting model state.

Do not split these into separate questions merely because each action could be numbered independently.

The useful test is: **would separating the steps teach a distinct concept?** If not, keep them together.

### 6. Anchor specialized problems to the lecture's framing

When a notebook instantiates a task form introduced in lecture, state the task, variables and distribution explicitly before asking for the special case. A label such as “the lecture’s discovery schema” does not supply that explanation.

For example, if the lecture defines probabilistic task forms such as prediction or discovery, either:

- refer to the relevant slide/section by title and reproduce the needed mathematical schema; or
- provide the relevant generic distributions directly in the notebook.

Then ask the student to map the current variables into that schema.

Do not jump directly to a specialized target such as $p(x_1\mid x_2)$ if recognizing the task form is itself part of the intended connection to the lecture.

### 7. Identify transitions in the solution

Read the worked solution from top to bottom and mark transitions such as:

- introducing a mathematical object;
- partitioning or reshaping it;
- selecting an equation;
- mapping symbols to variables;
- computing a new quantity;
- introducing unfamiliar syntax;
- performing a manipulation;
- comparing two routes.

Each transition is a candidate for one or more questions, but not every implementation line deserves its own question.

### 8. Prefer concrete mathematical referents

Use concrete quantities, objects and operations in explanations and solved answers as well as questions. Give the reader the mathematical referent instead of relying on author shorthand; use the editorial pass below.

Prefer:

- $\operatorname{Cov}(X_{11},X_{21})$;
- the shape of $\Sigma_{12}$;
- the exact equation for $\Omega$;
- which variable is $z$ and which is $y$;
- the code that evaluates a specified matrix expression.

Avoid vague prompts about "the covariance", "the relationship", or "what this means" unless a more specific question is impossible.

### 9. Fine-grained does not mean syntax-fragmented

Do not normally split a single small coding action into:

1. identify a function;
2. then call the same function.

When an API name is useful support, give it in the question and ask the student to use it:

> Using `np.block`, construct $\Sigma$ from the four covariance blocks, print its shape, and check that the result has the dimensions expected from the block structure.

Split API identification from implementation only when selecting the API is itself an explicit learning objective.

### 10. Make unfamiliar API behavior discoverable

Students should not be expected to infer library-specific behavior from a function name.

When a question asks about unfamiliar behavior — for example how PyMC treats missing values or what object `pm.sample` returns — use one of these patterns:

1. provide a direct official-documentation link and ask students to answer from that documentation;
2. provide the relevant behavior under **Explanation to read**, then ask students to apply it;
3. provide a minimal example and ask them to inspect its result.

Prefer official package documentation over generic web search results.

If the behavior changed since the students' previous course, make that change explicit.

### 11. Scaffold unfamiliar code structure, not only unfamiliar function names

A programming idiom can be unfamiliar even when every individual function is familiar.

Examples include:

- extending an existing PyMC model in a later `with model:` block;
- using coordinates/dimensions in a new way;
- working with an `xarray.DataTree` instead of the older `InferenceData` representation;
- selecting variables from a labeled multidimensional object.

When such a structure is required, provide enough initial code or a minimal example to establish the idiom, state what can be extended or modified, and then ask the student to add the task-specific component.

### 12. Prefer native library operations over manual plumbing

Before writing custom extraction, reshaping, summaries, diagnostics, or plotting code, check whether the current library provides a native operation that expresses the intended task clearly.

Examples include:

- `arviz_base.extract` for combining posterior sample dimensions or extracting variables;
- `arviz_stats.summary` for posterior means, SDs, intervals, ESS, and R-hat;
- current ArviZ plotting functions for standard posterior displays.

Use native operations by default when they make the statistical operation clearer and reduce incidental array manipulation.

Use manual NumPy/xarray code only when that manipulation is itself part of the lesson or when no suitable native API exists.

### 13. Provide background before questioning an author-created construction

If the worked solution uses a construction that is not already part of the lecture — for example a custom covariance model used to generate synthetic data — explain the construction before asking students to calculate with it.

The explanation should establish what the parameters mean, the relevant mathematical formula, which variables or blocks it defines, and any necessary constraints.

Do not ask students to reverse-engineer an arbitrary setup choice from code unless reading that code is itself the objective.

### 14. Apply lecture mathematics; do not turn the notebook into a derivation exercise

The lecture normally supplies the mathematical result. The notebook should make students recognize its components, map symbols to the current example, evaluate it, implement it, and connect it to other formulations.

Do not require a derivation merely because one exists. A derivation belongs in the notebook only when deriving that result is itself an explicit learning objective.

Short algebraic reasoning needed to apply a result, such as identifying the
matrix equation to pass to a linear solver, can be scaffolded student work.
Distinguish that application from assigning a new theorem proof.

### 15. Manage notation changes explicitly

When two equivalent formulations use different notation, do not oscillate casually between them.

At each transition:

1. state which notation is currently active;
2. establish an explicit mapping between the two systems, either supplied or
   through a bounded question before downstream calculations require it;
3. keep a block of calculations within one notation where possible;
4. translate back only when there is a specific reason.

For example, when moving from a partitioned Gaussian $(x_1,x_2)$ to an LGS $(z,y)$, give a mapping such as

$$
z=x_1,\qquad y=x_2,\qquad \mu_z=\mu_1,\qquad \Sigma_z=\Sigma_{11}.
$$

Then derive/identify the LGS quantities in one coherent section rather than repeatedly switching names sentence by sentence.

### 16. Use prediction selectively

Avoid generic interpretation prompts such as "Interpret this plot" or "Discuss the posterior".

A prediction question is useful when it tests an important mechanism and the next computation gives immediate feedback, for example:

- setting cross-covariance to zero should remove the mean update;
- increasing observation noise should widen a posterior;
- removing a feature should change a specified score term.

Do **not** insert prediction questions merely because a result is about to be computed. If seeing the numerical result directly is clearer and no important misconception is being tested, just compute and inspect it.

Prediction is a tool, not a required notebook rhythm.

### 17. Follow the method, not a generic methodology template

Do not impose a Bayesian-workflow sequence on every notebook.

Use priors, prior predictive checks, diagnostics, posterior predictive checks, or other methodological stages only when they illuminate the machine-learning method being taught.

The default structure should follow the lecture, the book's method sequence, and the worked example's computational logic.

### 18. Keep comparable results visually comparable

If two approaches answer the same question, use the same graphical grammar for both and add a direct comparison only when it materially helps.

Use consistent variable ordering, interval type/probability, axis limits, point-estimate convention, and plot geometry.

Do not add comparison calculations or displays simply because they are possible; each should answer a clear question in the notebook.

## Student-knowledge tracking

Student knowledge is cumulative and must affect question design.

At the start of authoring:

1. read `.agents/skills/teaching-notebook-authoring/references/student-knowledge.md`;
2. produce the required three-category knowledge report;
3. identify required constructs that are already familiar;
4. identify previously encountered constructs that still need scaffolding;
5. identify constructs newly introduced in this lecture/notebook;
6. identify any relevant version drift since the prior course;
7. scaffold the latter categories at appropriate granularity;
8. avoid re-teaching familiar constructs unless the current use is genuinely different.

After the notebook is finalized, produce a **knowledge-state change report** with:

- items newly introduced that should now move to "previously encountered — scaffold when needed";
- any items deliberately promoted to "assume familiar";
- items whose status should not change.

Do **not** automatically promote a construct to "assume familiar" merely because it appeared once.

Then update `.agents/skills/teaching-notebook-authoring/references/student-knowledge.md` as a separate final authoring step.

## Notebook cell pattern

The typical instructional rhythm is:

1. **Explanation to read**, where a substantive teaching move is needed, develops a coherent mathematical or technical idea;
2. **Code to run**, where needed, supplies short supporting cells with brief preceding implementation notes; the material heading supplies the run instruction;
3. **Questions to answer** contains numbered `exercise-question` cells, each paired with one unnumbered `solution` Markdown or code cell; in the solved source, `##### *start answer*` and `##### *end answer*` stay inside that same answer cell as Markdown headings or Python comments;
4. repeat for the next coherent step.

Use `#` for the notebook title, `##` for sections, `###` for those three material boundaries and `####` for content titles and numbered questions. Repeat a boundary when the material type changes; consecutive questions may share one. Keep student-written code within Questions to answer. Do not supply a target calculation merely to fill the supporting-code step. Substantial setup may precede the numbered questions.

Keep implementation documentation under Code to run. Explain non-obvious meaning, assumptions and behavior using the student-knowledge baseline; avoid narrating familiar syntax or repeating readable assignments. Introduce unfamiliar operations at their point of use. If code notes become long, examine several neighboring cells for a common idea and consolidate it into a substantive Explanation to read before the code, leaving short local notes. Do not make every Markdown paragraph a separate Explanation or pad retrospective summaries to make them long.

Use `given-answer` when an answer should remain visible in the student version because it establishes shared information rather than testing student work.

In authoring reports and dry runs, visibly mark such answers as **[GIVEN]** even when notebook tags are not shown.

See `.agents/skills/teaching-notebook-authoring/references/notebook-tags.md`.

## Generating the self-work version

The solved notebook is the source of truth.

Generate the self-work notebook mechanically with `scripts/make_self_work_notebook.py` unless there is a specific reason not to.

The transformation should:

- preserve questions exactly;
- preserve the number, type, order and IDs of cells; answer markers belong inside answer cells, so no marker cells need removal;
- preserve `given` cells;
- preserve cells associated with `given-answer` questions;
- replace `solution` code cells with `# answer here`;
- replace `solution` markdown cells with `- answer here`;
- clear outputs and execution counts in the student version by default;
- preserve setup, data, helper, and other non-solution cells.

Do not independently rewrite or simplify the student version after generating it. If the student notebook is awkward, fix the solved notebook and regenerate.

## Student-facing prose review

Use selected guidance from Google’s **Technical Writing One**, adapted to the course’s mathematical level and notebook conventions:

- **Write for the knowledge gap.** Use the cumulative student-knowledge file to decide what needs explanation. Supply the missing concept without repeating familiar mathematics or syntax. [Audience](https://developers.google.com/tech-writing/one/audience).
- **Define and name consistently.** Introduce unfamiliar terms and acronyms through their mathematical objects or code behavior. Make pronouns and references such as “this model” unambiguous. Keep names consistent across prose, equations and code; explain deliberate notation changes. [Words](https://developers.google.com/tech-writing/one/words).
- **Name the operation.** Prefer a concrete subject and a precise verb: what is conditioned on, averaged, minimized or compared? Replace labels such as “supplied infrastructure” with the actual setup being supplied. [Clear sentences](https://developers.google.com/tech-writing/one/clear-sentences).
- **Give each paragraph a purpose.** Its opening should orient the reader to the idea or task. Keep related reasoning together and move unrelated implementation details to their appropriate code notes. [Paragraphs](https://developers.google.com/tech-writing/one/paragraphs).
- **Remove unneeded words.** Cut repeated instructions and code narration; retain the assumptions, equations and distinctions needed for correctness. Use concise sentences where they clarify the reasoning, without imposing word counts or padding brief code notes. [Short sentences](https://developers.google.com/tech-writing/one/short-sentences).

These are adapted professional writing practices. Google [reports substantial internal use](https://developers.googleblog.com/teaching-the-art-of-great-documentation/) of the courses; that is evidence of adoption, not a controlled evaluation of this notebook’s learning outcomes. Course-specific mathematical and pedagogical requirements retain authority.

After drafting, read the student version from the beginning with solutions hidden. At each explanation or question, identify the object being discussed, the information currently available, and what the student should understand or do. Resolve vague references, undefined notation and unnecessary background. Check solved answers for the same clarity, then verify that edits preserve mathematical conditions and meaning.

When learner feedback is available, use a short [paraphrase check](https://digital.gov/guides/plain-language/test/paraphrase-testing): ask the learner to explain a passage and what they would do next in their own words. Revise misunderstandings in the text. Do not treat an author’s or automated reviewer’s assertion of clarity as an observed learner result. This is a useful feedback method, not an additional approval gate. Keyword scans may flag candidates; editorial judgment remains necessary.

## Validation

Before considering the pair complete, check the following.

### Solved notebook

- Does it run top to bottom under repository runtime rules?
- Does it reproduce the worked solution's substantive results and figures?
- Does each question immediately precede exactly one answer-content cell, with start/end markers inside that cell in the solved version?
- Is every question answerable from information visible before the answer cell?
- Is the expected student action clear?
- Does each Explanation to read make a coherent teaching move rather than document a supplied cell?
- Are Code to run notes brief, with any larger shared idea consolidated before the relevant code?
- Does each supplied code cell show a concise, meaningful result or specific check confirmation, without extra random draws or premature answers?
- Does prose respect the student-knowledge baseline rather than narrate obvious syntax?
- Has the student-facing prose review resolved opaque labels, undefined terms and ambiguous references while preserving mathematical meaning?
- Has non-instructional setup been bundled rather than pointlessly decomposed?
- Are tightly coupled actions kept together when separating them would teach nothing new?
- Are specialized probability targets anchored to the lecture's task framing where appropriate?
- Are unfamiliar APIs either documented, demonstrated, or explicitly given?
- Were fast-moving APIs checked against the current course environment/documentation?
- Are native library operations used in preference to unnecessary manual plumbing?
- Are notation changes explicitly mapped and locally consistent?
- Are prediction questions used only when they test an important mechanism?
- Are comparable methods displayed comparably without redundant comparison work?

### Student notebook

- Was it generated from the solved notebook rather than independently authored?
- Are all designated solutions, including their inline markers, replaced by placeholders without changing cell count, types or order?
- Are all questions and supplied material preserved?
- Can a student work linearly from top to bottom?
- Would pasting an individual question into an AI chat normally produce enough context for a useful answer?
- Are answer placeholders of the appropriate type present?
- Is it always clear which supplied code should simply be run and which code the student is expected to write or extend?
- If a question depends on external documentation, is the exact documentation source supplied?

## Anti-patterns

Avoid:

- replacing many small questions with a few large tasks merely because the students are graduate students;
- splitting one coherent operation into several numbered microsteps that teach no distinct concepts;
- asking a question before the notebook supplies the facts needed to answer it;
- using the answer cell to reveal setup assumptions that should have appeared before the question;
- decomposing arbitrary setup into exercises merely because it appears in the worked solution;
- splitting "which function?" and "now call the function" when one task-specific coding question suffices;
- asking students to infer undocumented library behavior;
- relying on obsolete APIs because students used them in an earlier course;
- manually reshaping/summarizing posterior objects when a clear current ArviZ/PyMC operation exists and the reshaping itself is not the lesson;
- ambiguous code blocks whose status as given code or student work is unclear;
- casually switching back and forth between two notational systems;
- generic interpretation questions used merely because "reflection" seems pedagogically desirable;
- prediction questions inserted mechanically before every result;
- unnecessary mathematical derivations;
- hiding central method code in abstractions;
- imposing a prior/fit/PPC workflow when the method does not need it;
- inventing a second student-notebook narrative independent of the solved notebook;
- changing a validated worked solution just to make authoring easier.

## Completion criterion

The notebook pair is complete when the **solved notebook is a coherent,
fine-grained Q&A explanation of the validated worked solution**, the **student
notebook is that same notebook with solution contents mechanically replaced by
placeholders**, and the authoring record includes explicit before/after
knowledge-state reports. When delegated review applies, also record its actual
learner coverage, independent informed findings, author response and disposition
of consequential decisions. A partial or pending review is reported as such;
it cannot satisfy a requested full-notebook review. Runtime/publication and
instructor-acceptance requirements remain separate.
