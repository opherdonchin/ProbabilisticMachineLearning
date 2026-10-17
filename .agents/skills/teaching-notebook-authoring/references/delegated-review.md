# Delegated notebook review

Use for requested independent review and substantial teaching-notebook builds or
revisions. A typo or output-format fix does not require a new full walkthrough.
Reuse the existing worked-solution, authoring and runtime workflows. This adds
separation of perspectives, not a second notebook-production pipeline.

The precedent is the [L01 slide learner protocol](../../../../Lectures/L01_Probability_Statistics/review/reviewer_protocol.md):
sequential experience, a particular person's knowledge and temperament, no
author rationale or anticipated criticism, and diagnosis after the experience.
A notebook additionally permits observable attempted answers and code execution.

## Roles and information boundaries

| Role | Receives | Owns |
|---|---|---|
| Author | Approved mathematical contract, validated worked solution, knowledge baseline, authoring guidelines and instructor decisions | Solved source, generated student version, allocation of explanation/code/questions and revisions |
| Blind learner | One profile, learner protocol, sequential student-visible packets and permitted resources | Its own answers, code/output record and experience account; no course-source edits |
| Informed referee | Contract, knowledge baseline, guidelines, frozen notebook pair, learner records and relevant technical evidence | Independent diagnosis of correctness, scaffolding and learning opportunities; no notebook edits |
| Coordinator | Inputs, versions and all returned evidence | Dispatch, adjudication, repair routing and instructor-facing decisions |

The author and informed referee must be different agents. The coordinator can
act as informed referee only if it did not author the candidate. Otherwise
delegate the informed review too. The learner remains blind through its final
account; do not turn it into the informed referee by revealing the answer key.
No agent should edit source it is reviewing. The author remains the sole source
editor, and must accommodate unrelated concurrent changes rather than revert them.

Launch separate learner/referee agents with fresh contexts (`fork_turns: none`
where available). Give exact artifact versions, file access allowlists and output
ownership. Do not forward the instructor conversation or the author's suspected
issues. Issue-specific rechecks may be seeded, but label them accordingly.
Context/file discipline is procedural blinding, not a security sandbox or a way
to erase a model's mathematical competence. Report inherited context or accidental
answer access and narrow the independence claim. When delegation is unavailable,
disclose a same-agent review; do not claim independent validation.

## Prepare a bounded candidate

Freeze the solved and mechanically generated student sources; record hashes or
Git blob IDs. Keep the validated worked solution and authoring rationale outside
the learner packet. Use a temporary or ignored review workspace for attempts;
do not let a learner overwrite the course notebook.

Record packet-to-cell mappings and packet hashes, identifying any transformations
made for review. Bind required helper/data resources to versions or snapshots;
for live documentation, preserve the actual consulted passage/version. This
keeps the attempt tied to what was supplied even if the working tree changes.

The profile specifies course-entry knowledge, what has been encountered in the
preceding lecture, mathematical/coding fluency, aptitude and ordinary habits of
attention, confidence and help-seeking. Derive knowledge from actual course
records. Do not equate having attended a lecture with fluent mastery, lower the
mathematical level arbitrarily, or encode expected notebook faults in the profile.
Prefer choosing the profile before looking at candidate-specific criticisms;
if the coordinator already knows them, disclose that and ground the profile in
the course baseline rather than tailoring it to a suspected fault. Start with
one plausible target student; add a contrasting profile only when it addresses
a meaningful uncertainty. Do not manufacture a panel or aggregate approval score.

State the actual resource/help policy and runtime. Approved AI use is part of the
student experience, not cheating. Separate what the learner produces, what help
supplies and what the learner can then explain. Preserve actual help requests
and replies or a referenced raw transcript, not only a summary of their use.

Release student-visible content in order, normally through one question and its
blank answer cell at a time, carrying earlier material and kernel state forward.
Remove saved outputs, answer markers and author-only metadata from packets;
retain outputs actually produced during the attempt. Include supplied examples
and explanations exactly where students would see them. Do not expose future
checks that reveal reference values before the corresponding attempt. Authorized
lecture excerpts/documentation belong in the packet when students may use them;
do not assume access to an unseen ideal lecture or use a hidden answer key as help.

Do not deliver the whole notebook in one prompt and call the experience strictly
sequential. A prefix file is acceptable only if the agent records each attempt
before reading ahead; disclose that lookahead was procedurally restricted.

## Run and preserve the attempt

Dispatch only [learner-review.md](learner-review.md), the profile and the first
packet. Release the next packet after the prior attempt is recorded, or use a
feeder with the same boundary. Preserve question/cell IDs, attempted prose/code,
actual outputs/errors, help requests and revisions. Retain initial mistakes when
later material resolves them. Track productive difficulty and successful
connections as well as confusion; a learner who struggles does not establish a
defect, and one who succeeds does not establish good teaching.

If no execution occurs, label a read-through rather than an executed attempt.
Record the source of observed outputs and whether plots/Markdown were actually
rendered or merely inspected as source. A local attempt is not a hosted Colab
pass. Simulated effort is not measured student workload or a learning outcome.

Use the existing lecture-local authoring report or review directory for a small
current manifest, raw learner record, informed findings and author response.
Identify input versions, agents, allowed resources, actual coverage, accidental
leaks and any interventions. Preserve raw evidence alongside summaries; avoid
parallel task ledgers or historical draft collections. Git retains earlier runs.

## Informed review after the learner account

Only now compare the attempts with the solved reference and learning contract.
Review whether each important step gives students worthwhile intellectual work:

- Are they formulating, translating, implementing, inspecting or judging the
  intended objects? What can their answer actually demonstrate?
- Are premises and necessary unfamiliar ideas supplied? Could manageable
  questions teach a connection now supplied in full, or would that be guessing?
- Does an explanation establish a foundation, provide a deliberate worked
  example, or unnecessarily complete the forthcoming application?
- Is a question supported retrieval/rehearsal/application, or empty copying?
  Repeating a supplied criterion in a new judgment can be useful.
- Is supplied code appropriately peripheral, or does it hide the target method?
  Does question granularity teach distinct connections at the current knowledge
  level, including when documentation or AI is used?
- Are answers mathematically correct and computations/checks meaningful? Do
  their assumptions and guarantees match the task and the worked solution?

Use content ratios and question counts only descriptively. Do not judge against
a quota, demand unaided discovery of every new concept, or copy another course's
syntax granularity. A learner may miss a substantive error; independently inspect
correctness and scope rather than outsourcing them to the persona.

For each material finding, identify the question/cell, evidence, issue and owner,
then distinguish a notebook defect, profile-specific reaction, productive
difficulty or unresolved uncertainty. Separate actual execution, a simulated
experience and expert inference. Recommend the smallest repair or justify leaving
the difficulty intact. A generic verdict such as “too much explanation” is
insufficient without showing what students should instead construct and why the
prerequisites make that reasonable.

## Author response and completion

The author responds to substantive findings with a repair, justified retention
or a concrete instructor decision. The coordinator adjudicates evidence rather
than counting reviewers' votes. Changes to mathematical route, required depth,
scope or material workload remain instructor decisions in ordinary chat.

Normally use one review and a targeted recheck after a meaningful repair. Use a
fresh blind learner when the repair changes the learning sequence; a returning
learner can check navigation or execution but already knows the answers. Do not
retest unrelated stable material or iterate until every simulated difficulty
disappears. Return unresolved pedagogical tradeoffs to the instructor.

Record authoring, independent informed review, simulated learner coverage, local
execution, hosted runtime validation and instructor acceptance separately. None
substitutes for another. The learner/referee cannot approve the lecture, infer
real student mastery or certify human timing. Existing Colab release requirements
remain unchanged.
