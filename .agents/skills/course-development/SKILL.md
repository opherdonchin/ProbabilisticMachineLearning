---
name: course-development
description: Coordinate Advanced Statistics across lectures, notebooks, recordings and authoring skills, with deferred instructor review and safe concurrent dispatch; use for "What should we do next?" or "What needs my attention?" Resume individual lectures through lecture-development.
---

# Coordinate course development

Own course-wide routing and continuity, not lecture content or instructor decisions.
Reuse [lecture-development](../lecture-development/SKILL.md) for lecture stages
and recordings, [build-teaching-notebook](../build-teaching-notebook/SKILL.md)
for new notebooks, and its worked-solution/teaching-notebook specialists for
bounded feasibility or revision work. Read a destination skill before dispatch;
do not invent a replacement pipeline. Use skill-creator when changing a skill.

## Recover the live situation

For a next-action question, assess read-only and recommend work; the question
does not authorize production, merges or changes to teaching commitments.

- Inspect Git status, HEAD, local and remote-tracking branches, and worktrees.
  Verify relevant remote heads when access permits; disclose stale/offline refs.
  Inspect branches named by the instructor, lecture registers and course records,
  and relevant sibling branches. Use `git show <ref>:<path>` and comparisons
  without switching another session's checkout or merging divergent work.
  Include relevant uncommitted/local evidence with its location and version;
  label it separately from committed evidence and do not modify another session.
- Read [course architecture](../../../course_architecture.typ), planned and
  actual curriculum maps, and [START_SCOPING](../../../Lectures/START_SCOPING.md).
  Recover approvals from lecture-local registers, owning artifacts and review
  evidence on their source branches. Check live PR state where relevant.
  Neither `main`, newest commit, an artifact's presence nor a passing review
  determines pedagogical authority. Resolve conflicting status against exact
  content and documented instructor provenance; surface unresolved conflicts.
- Cover L01–L12, their notebook handoffs and linked recordings, and active skill
  experiments. Keep prepared, approved, validated, published and taught distinct.
  Identify affected inputs, not merely lecture numbers: a later scope can rely
  on an accepted prerequisite without needing its predecessor's slides finished.
  Prospective student knowledge is conditional; actual coverage belongs only
  in `curriculum_map_actual.typ` after teaching.

## Select productive independent work

For each meaningful constraint name its owner, evidence/version, smallest repair,
affected operation and what can safely proceed. Distinguish:

- **Artifact blocker:** a defect or missing input in a particular scope, design,
  asset or notebook. Restrict its effect to work that uses that input.
- **Skill blocker:** demonstrated failure of a reusable workflow. Identify the
  skill revision, failing operation and behavioral evidence. Do not infer a
  general skill failure from one bad output, or make slide-process failures
  block unrelated scope/source review or notebook feasibility.
- **Instructor decision:** an unresolved consequential teaching choice or explicit
  hold. Preserve accepted decisions and the scope of each hold. Safe evidence
  collection is distinct from permission to advance the held production stage.
- **Branch reconciliation or runtime/access blocker:** conflicting authority,
  missing sources, packages, data or hosted validation. Keep these separate from
  pedagogical approval and workflow quality.

Recommend the most productive concurrent workstreams, normally three when enough
independent work exists. For each give exact source branch/revision, entry paths,
owner/stage/mode, bounded deliverable, readiness (`ready`, `conditional`, or
`awaiting instructor`) and the genuine dependency/acceptance gate. Separate
actions possible now from later production. Do not manufacture dependencies
from lecture order or silently override a documented serial-review preference.
Explain the smallest instructor decision needed, without re-asking settled ones.

Skill evolution is a separate workstream: use isolated candidates and exact
input/skill revisions; distinguish structural validation, behavioral testing and
instructor acceptance of the resulting teaching artifact. Reuse relevant raw
evidence; change rules only in response to demonstrated failures. Revalidate
affected uses rather than restarting every lecture when a skill changes.

## Discover ownership before dispatch

Reconcile the worktree/branch inventory with lecture registers, active task
envelopes and instructor-declared sessions. Other Codex sessions are not visible
or controllable merely because their worktrees exist; report only what their
repository evidence establishes. Distinguish observed revisions from live
uncommitted changes, and declared active work from a stale/completed assignment.
Do not dispatch duplicate work or resume another session's task unilaterally.

Before launch, record an envelope in the owning task report or coordination
index: ID, stage/mode, base commit, input versions, branch/worktree, owner,
dependencies, exact allowed write paths, expected deliverable and acceptance
gate. Compare intended repository-relative writes across all known assignments:
separate worktrees isolate working files but do not resolve competing ownership
of the same future artifact. Reserve shared skills, architecture, maps and
production APIs explicitly; one owner writes each. If an external write scope
is unknown, exclude its affected area conservatively or obtain a handoff rather
than assuming it is free. Disjoint evidence reports can proceed without that
handoff. Recheck reservations before follow-ups and integration.

## Dispatch only within authorization

When the instructor authorizes execution, delegate bounded tasks through the
existing skills and [backpressure contract](../shared/backpressure.md). Pass
stage/mode, source and target branches, exact input versions, artifact ownership,
constraints, deliverable and review/approval gates. Use an isolated worktree for
each writing assignment; never assign concurrent edits to the same file. One owner
coordinates shared skill edits and course-level decisions. Read-only reviews can
run concurrently. Report whether reviews were independent and whether delegation
actually ran; proposals and feasibility reviews do not authorize production.
Route findings to the nearest owning stage and invalidate only affected work.
Merging, publishing and lecture production require applicable authorization.

Collect actual agent results and bind them to the returned revision and allowed
diff. Verify the write boundary before accepting a handoff; an out-of-scope edit
is not authorized merely because it is useful. Distinguish completed evidence,
open advisory checks, technical blockers and instructor choices. Continue or
dispatch already authorized independent work while dependent tasks wait; do not
run extra variants merely to avoid a real decision or count an unrun task as
progress. Preserve identifiable raw findings in the owning report, not a second
course-level task history.

## Defer instructor review

Under deferred review, agents return questions to the coordinator, not directly
to the instructor. As results arrive, record each unresolved instructor-owned
item in its owning proposal/review artifact: stable ID, precise question, serious
options, recommendation with tradeoff, evidence revision, priority/reason, owner,
exact dependent work and independent work that can continue. Technical correctness
repairs and advisory risks are author-owned, not questions requiring approval.
Index unresolved items by pointer in the lightweight coordination state; reuse
existing lecture/group queues and avoid duplicating their questions. Preserve
accepted decisions and never treat silence as an answer.

Do not interrupt the instructor as questions arrive. When asked "What needs my
attention?", reconcile the indexed queues, select the highest-priority unresolved
item by dependency reach, readiness, delivery urgency and rework risk, and present
**one** question with its options, recommendation, evidence and effect. Do not
ask a batch or work through a fixed lecture order. A requested completion report
may list queued IDs/status without demanding answers. New priorities can reorder
review; they do not change teaching commitments.

When the instructor answers, record the exact decision/provenance in its owning
scope, section contract or skill decision record, then update the queue pointer
and only affected downstream status. An answer limited to an example or endpoint
does not approve the whole artifact. Recheck input versions and write ownership;
resume newly unblocked work within existing authorization, with no automatic
merge or production implied. If another session owns the destination, retain a
pending owner handoff rather than editing it concurrently. If implementation
permission is missing, mark `decision resolved; execution awaits authorization`.
Do not manufacture an instructor answer to test this transition.

During an active instructor-review session, present the next ready decision
while authorized work from the previous answer runs. Wait for results only when
they materially determine that next decision; routine recording, authoring,
validation and commits must not make the instructor wait. Outside an active
review session, continue collecting questions under deferred review.

## Persist only missing coordination information

Existing lecture `development_state.md` files own lecture status and approvals;
owning artifacts and Git retain decisions and evidence. Do not copy architecture,
curriculum, all lecture statuses or completed task histories into a new register.

Only when authorized ongoing cross-course work creates information with no
existing owner, use a compact `Lectures/course_development_state.md`: active
assignment → branch/worktree and input revision → owner → owning state/evidence
path and exact write reservation, plus deferred-review pointers and unresolved
cross-course dependencies/shared-skill decisions with provenance. Reuse a suitable
existing workflow index instead when available.
Create no placeholder register for a read-only assessment. Reconcile pointers
on resume, remove resolved assignments, and return decisions to their owning
artifacts. The two curriculum maps remain the sole course-wide material ledgers.
