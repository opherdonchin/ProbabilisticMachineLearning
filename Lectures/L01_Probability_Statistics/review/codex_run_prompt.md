# Codex orchestration prompt: run five independent L01 reviewers

Run a five-reviewer critique of Lecture 01 using genuinely separate subagents.

This is an isolation experiment. The five reports must be generated independently before any comparison or synthesis occurs.

## Target

Lecture directory:

`Lectures/L01_Probability_Statistics/`

Authoring source:

`Lectures/L01_Probability_Statistics/slide_deck.typ`

Review harness:

`Lectures/L01_Probability_Statistics/review/`

## Agent topology and reasoning level

Use exactly this agent tree:

```text
root coordinator
├── Noa reviewer
├── Amir reviewer
├── Maya reviewer
├── Eitan reviewer
└── Yael reviewer
```

The five reviewers must be direct children of the root coordinator.

Do not create any additional analytic, synthesis, or helper agents. In particular:

- reviewers must not spawn subagents of their own;
- the coordinator must not spawn a sixth critic or synthesis agent;
- no reviewer may delegate any part of its reading or report to another agent.

### Reasoning effort

The substantive review task should be run at **High reasoning effort**.

If the environment allows the coordinator and child agents to use different reasoning levels:

- run the root coordinator at **Medium** reasoning effort;
- run each of the five reviewers at **High** reasoning effort.

If child agents inherit the root agent's reasoning setting and cannot be configured independently, run the root coordinator at **High** so that all five reviewers inherit High.

Do not deliberately reduce the five reviewers to a lightweight or low-reasoning model for speed. Prefer the strongest general/agentic model available in the current Codex environment that supports the required visual/file workflow.

Do not use Extra High / XHigh merely because it is available. The goal is a careful but plausible student/consultant reading of the lecture, not maximal post-hoc reconstruction of every implication.

Run all five direct-child reviewers concurrently if the environment supports at least five concurrent subagents. If concurrency is lower, run them as five distinct isolated child contexts without changing any reviewer's inputs.

The root coordinator's role is procedural only: prepare the common lecture rendering, dispatch the five isolated reviews, collect their files, and perform the mechanical checks specified below. It must not read the lecture in order to form its own critique and must not interpret, compare, summarize, rank, or reconcile the reports.

## Step 1 — prepare one common rendered lecture

Compile the current `slide_deck.typ` to a temporary PDF specifically for this review run. Do not modify the lecture source merely to make the review easier.

If useful for visual inspection, render the temporary PDF into page images in a temporary/untracked location. All five reviewers must see the same rendered revision.

Record the current git commit SHA before starting and include it in each report header. Also record that the target was `slide_deck.typ` rendered at run time.

Do not give student reviewers access to Typst source or speaker notes. They are reviewing the lecture they would see, not the lecturer's private intentions.

## Step 2 — spawn exactly five independent subagents

Spawn exactly five direct-child subagents, following the topology and reasoning-level requirements above.

Assign one reviewer to each persona:

1. `review/personas/noa_ben_ami.md`
2. `review/personas/amir_cohen.md`
3. `review/personas/maya_shalev.md`
4. `review/personas/eitan_mizrahi.md`
5. `review/personas/yael_harari.md`

Each subagent receives only:

- the common rendered lecture or its page images;
- `review/reviewer_protocol.md`;
- its own assigned persona file;
- the exact output path assigned below.

Do NOT give a reviewer another persona file.
Do NOT give a reviewer any other reviewer's output.
Do NOT pass messages between reviewers.
Do NOT let a reviewer read `review/README.md` or this orchestration prompt if doing so would expose the identities or design of the other reviewers.
Do NOT ask reviewers to seek consensus.
Do NOT allow reviewers to spawn or consult further agents.

If the subagent framework automatically exposes the entire repository, explicitly instruct each subagent that it is forbidden to open:

- any other file under `review/personas/`;
- any existing file under `review/reports/`;
- any later synthesis of the review.

Each reviewer should read the lecture sequentially and follow the shared protocol plus its persona-specific instructions.

## Step 3 — exact outputs

Write the raw reports to:

- Noa -> `Lectures/L01_Probability_Statistics/review/reports/noa_ben_ami.md`
- Amir -> `Lectures/L01_Probability_Statistics/review/reports/amir_cohen.md`
- Maya -> `Lectures/L01_Probability_Statistics/review/reports/maya_shalev.md`
- Eitan -> `Lectures/L01_Probability_Statistics/review/reports/eitan_mizrahi.md`
- Yael -> `Lectures/L01_Probability_Statistics/review/reports/yael_harari.md`

At the top of every report include only this provenance header before the report itself:

```text
Lecture: L01 Probability & Statistics
Source: Lectures/L01_Probability_Statistics/slide_deck.typ
Git commit reviewed: <SHA>
Reviewer persona: <name>
```

Do not add a shared template beyond what the reviewer protocol/persona requests.

## Step 4 — preserve raw independence

Once a reviewer finishes, save its report exactly as produced apart from trivial Markdown cleanup needed to make the file valid.

Do not:

- rewrite for consistency;
- harmonize terminology;
- shorten one report to match another;
- add observations from another reviewer;
- remove contradictions;
- rank the reviewers;
- synthesize findings;
- produce a consensus report.

Differences, misunderstandings, unevenness, and contradictions are part of the evidence.

## Step 5 — verify only

After all five subagents have finished, verify mechanically that:

- all five report files exist;
- each names the intended persona in its provenance header;
- each names the same git commit;
- none is empty;
- no report contains obvious evidence that it discussed another reviewer's report.

Do not evaluate their substantive quality at this stage.

## Step 6 — finish

Leave the five reports in the repository working tree. Do not alter L01 itself. Do not create a synthesis unless explicitly requested in a later task.

In your final response to the human, report only:

- that the five independent reviews are complete;
- the git commit of L01 that was reviewed;
- the five report paths;
- any mechanical problem that prevented strict isolation, if one occurred.

Do not summarize the reports in that response.
