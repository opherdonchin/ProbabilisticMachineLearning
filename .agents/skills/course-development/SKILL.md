---
name: course-development
description: Coordinate Advanced Statistics across lectures, notebooks, recordings and authoring-skill development; use for course-wide priorities, concurrent work and "What should we do next?" Resume individual lectures through lecture-development.
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

## Dispatch only within authorization

When the instructor authorizes execution, delegate bounded tasks through the
existing skills and [backpressure contract](../shared/backpressure.md). Pass
stage/mode, source and target branches, exact input versions, artifact ownership,
constraints, deliverable and review/approval gates. Use isolated worktrees for
divergent writing; never assign concurrent edits to the same file. One owner
coordinates shared skill edits and course-level decisions. Read-only reviews can
run concurrently. Report whether reviews were independent and whether delegation
actually ran; proposals and feasibility reviews do not authorize production.
Route findings to the nearest owning stage and invalidate only affected work.
Merging, publishing and lecture production require applicable authorization.

## Persist only missing coordination information

Existing lecture `development_state.md` files own lecture status and approvals;
owning artifacts and Git retain decisions and evidence. Do not copy architecture,
curriculum, all lecture statuses or completed task histories into a new register.

Only when authorized ongoing cross-course work creates information with no
existing owner, use a compact `Lectures/course_development_state.md`: active
assignment → branch/worktree and input revision → owner → owning state/evidence
path, plus unresolved cross-course dependencies or shared-skill decisions with
provenance. Reuse a suitable existing workflow index instead when available.
Create no placeholder register for a read-only assessment. Reconcile pointers
on resume, remove resolved assignments, and return decisions to their owning
artifacts. The two curriculum maps remain the sole course-wide material ledgers.
