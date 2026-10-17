# Delegated notebook review: workflow and bounded L01 pilot

The notebook authoring skills now distinguish authoring criteria, a blind learner
walkthrough and an independent informed referee. This implements the instructor's
request in the 2026-10-17 chat. It does not revise or approve L01 content.

## Current process

- [Authoring criteria](../../../../.agents/skills/teaching-notebook-authoring/SKILL.md):
  allocate intellectual work by intended competence, prerequisites and useful
  scaffolded connections; use category proportions descriptively, without quotas.
- [Delegated review](../../../../.agents/skills/teaching-notebook-authoring/references/delegated-review.md):
  fresh contexts, source/version boundaries, sequential attempts, informed
  diagnosis, author response and targeted recheck.
- [Learner-only protocol](../../../../.agents/skills/teaching-notebook-authoring/references/learner-review.md):
  no authoring rubric, reference answers, anticipated faults or other reviews.

The author and informed referee must be separate agents. The coordinator may
perform informed review only if it did not author the candidate. The blind
learner remains blind through its final account; it is not subsequently given
the answer key and asked to reinterpret its own experience as an expert.

## Independent process check

`/root/notebook_protocol_referee` reviewed the protocol in a fresh context,
without notebook or pilot inputs. Its [raw review and targeted recheck](protocol_referee.md)
found the process feasible and requested three small repairs: add review
disposition to completion criteria, preserve actual AI replies, and bind packet
and resource versions to the candidate. All three were incorporated and checked
by that agent. It did not author or edit the skills.

## Actual learner coverage

`/root/notebook_learner_pilot` was launched separately with `fork_turns: none`.
It received only the [profile](profile.md), [frozen learner protocol](learner_protocol.md)
and five student-visible packets released one at a time, after each preceding
answer was returned. Coverage was opening through Question 2.2 inclusive:
1.1, 1.2, 1.3, 2.1 and 2.2. The [manifest](manifest.json) binds source hashes,
cell ranges/IDs, packet hashes, resource hashes, roles and interventions.

[The final learner account](learner/final_record.md) and the individual records
preserve actual answers before key access. The learner correctly identified
covariance blocks, computed covariance/correlation, specified the conditional
query, and implemented the conditional mean/covariance. [Cumulative code](learner/cumulative_attempt.py)
and [actual execution output](learner/final_execution.log) preserve its work.
The first uv invocation failed before notebook cells ran because the tool's
default cache was read-only; the coordinator supplied a writable cache and
`--no-sync` instruction. No mathematical help was supplied. The installed helper
was importable, so public package installation was not tested.

The learner inspected its generated correlation plot. Notebook Markdown itself
was supplied as source, not experienced in a rendered notebook UI. No timing,
retention, transfer or actual human-learning result is claimed. The learner
explicitly reported immediate model competence rather than staging confusion.

## Independent informed findings and author disposition

Only after the learner's final account, the same independent referee received
its records, the notebook pair and authoring criteria. This informed stage is
intentionally not blind to the guidelines. [Its raw report](informed_referee.md)
was preserved verbatim. It inspected only the covered notebook prefix and did
not independently rerun it.

**Retain the five-question scaffolding.** The referee found sufficient foundations,
correct calculations and useful supported recognition/application. In particular,
the presence of prior explanations does not make the concrete mappings and
formula implementations empty work. Author/coordinator response: agree; there is
no case here for making these questions harder or removing support just to
increase a question-content ratio. This does not adjudicate later notebook sections.

**Clarify evaluation-reference wording at cell 21.** The fixed simulation code
visibly contains the coordinates described as withheld and later revealed.
The intended restriction is their exclusion from inference; the learner's
conditional calculation respected that restriction. Author/coordinator response:
agree with the proposed distinction. A future content revision should say the
values are retained for evaluation and compared later. No notebook wording has
been changed by this process-design task.

The referee also distinguished supported success from independent derivation,
solver selection or human competence. The learner generated some extra numerical
checks before Question 1.2; the resulting exposure is recorded, not mistaken for
an entirely unexposed numerical answer.

## Independence and scope limits

The coordinator previously authored L01 and knew the earlier discussion when
preparing the generic baseline profile. This was not independently preregistered
profile selection. Final guidance prefers choosing profiles before candidate
criticism and explicitly permits existing familiarity when disclosed; the raw
informed report refers to the stronger earlier wording. The limitation remains
visible rather than being silently edited out of the referee's account.

Fresh contexts and restricted paths provide procedural blinding, not an enforced
filesystem sandbox or proof of every access. No complete access audit was
collected. A persona does not erase the model's advanced mathematical knowledge.
The profile and canonical protocol were refined during process development;
the exact earlier learner protocol actually supplied is retained and hashed.
No AI help was used, so the later help-transcript clarification has no missing
transcript consequence for this pilot.

**Status:** workflow specified and independently checked; five-question learner
attempt completed with local execution; independent informed review and author
response recorded. Full-notebook learner/referee coverage, hosted Colab execution,
learner time and instructor acceptance are not established. The notebook files,
including the instructor's saved outputs, have identical hashes before/after.

## Raw evidence

- [Profile](profile.md), [learner protocol as supplied](learner_protocol.md),
  [packet inputs and version manifest](manifest.json).
- [Question 1.1](learner/packet_01_record.md), [1.2](learner/packet_02_record.md),
  [1.3](learner/packet_03_record.md), [2.1](learner/packet_04_record.md),
  [2.2](learner/packet_05_record.md), [final account](learner/final_record.md).
- [Initial runtime error](learner/packet_01_execution.log),
  [recovery](learner/packet_01_recovery_execution.log),
  [final cumulative execution](learner/final_execution.log),
  [inspected correlation plot](learner/packet_01_plot_1.png).
- [Independent protocol review](protocol_referee.md),
  [independent informed notebook review](informed_referee.md).

Raw records are retained without normalization; their temporary command paths
identify actual pilot events. The supplied packet files are preserved in
`packets/`, so the referenced temporary inputs can be reconstructed if needed.
Static Codex setup, skill validation and relative-link checks passed. These are
checks of process artifacts, not substitutes for executing or teaching a notebook.
