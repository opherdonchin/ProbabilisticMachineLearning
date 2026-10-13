# Branch naming and lifecycle

This policy applies to new branches in `ProbabilisticMachineLearning`. It supplements `AGENTS.md` and does not change the instructor-approval or source-of-truth requirements for course content.

## Branch names

Use **`<type>/<scope>-<specific-outcome>`**, entirely lowercase, with hyphens separating words.

- **Types:** `feat`, `fix`, `docs`, `refactor`, `test`, `chore`, `lecture`.
- **Scope:** prefer `l01`–`l13` for an individual lecture, `course` for shared curriculum, `workflow` for agent/development processes, or `repo` for repository maintenance.
- **Outcome:** describe the artifact or change delivered, not an agent, an author, a session, a date, or generic “work.”

Examples: `lecture/l03-verify-d-separation`, `fix/l02-retrospective-summaries`, `docs/course-method-selection`, `chore/repo-branch-hygiene`, `refactor/workflow-skill-discovery`.

Avoid names such as `lecture-3-authoring`, `new-work`, `claude/task-xyz`, or `course-architecture-20261013`. Do not put dates in a name simply to distinguish attempts at the same task. For a genuine parallel experiment, use a specific alternative instead (e.g. `feat/course-vi-example-comparison`).

## Purpose, authority, and base

1. **One outcome per branch.** A branch is not a scratchpad for multiple unrelated questions. The opening PR or the branch's associated issue must state the intended outcome, target/base branch, present status, and any existing instructor decisions that it depends on.
2. **Normal base is `main`.** Use a temporary integration branch only when a multi-part project deliberately needs staged review. PRs targeting that branch must explicitly say so. Do not call a PR “merged to the course” if it only reached an integration branch.
3. **No hidden authority transfers.** A PR merge does not by itself mark a lecture scope, slide design, or notebook instructor-approved. Respect the owning artifacts and the recorded approvals.
4. **Prefer short-lived branches.** Avoid creating a fresh branch for each successive refinement of the same unfinished, unmerged artifact. Continue on its existing topic branch when possible; otherwise merge the next refinement into a declared integration branch and retire its head.
5. **Never force-push or repoint another workstream's branch for a cosmetic rename.** To rename an active remote branch, coordinate with anyone using it, recreate the branch at the identical tip, retarget PRs as needed, and remove the old name only after verification.

## Completion and cleanup

- **Merged into `main`:** delete the topic branch after confirming its head is an ancestor of `main`, or verifying squash/rebase incorporation from PR history and actual resulting file contents.
- **Merged into integration branch:** delete the topic branch only after confirming it is incorporated there, and keep the integration branch until its own work is integrated into `main` or explicitly abandoned.
- **Closed/unmerged, or dormant:** do not delete automatically. Review the branch's distinctive commits/content, its PR/issue, its last activity, and whether the work is replaced, blocked, or still pedagogically pending.
- **Before any deletion:** fetch current refs and check the exact remote tip has not changed since review. Never delete `main`, the base of an open PR, or a branch holding unmatched work without an explicit preservation decision.
- **After deletion:** prune stale remote-tracking refs locally with `git fetch --prune origin`. Local developer branches are separate and are not changed by remote deletion.

For an active branch with no PR, arrange a PR or issue that names its intent and owner. During routine course/repository reviews, flag unmerged branches that have had no activity for **14 days** for *review*, not automatic deletion. Recheck a branch's content against its intended destination before calling it stale: inactivity alone is not a reliable criterion.

## Temporary legacy exceptions

The PR-name CI check permits some pre-policy branches while they are reconciled. These are *not* templates for new names: `l02-section-titles-summaries`, `lecture-3-authoring`, `scope-l03-l12-course-architecture`, and `slide-authoring-refactor`. Remove each exception when the corresponding branch is retired or deliberately renamed.

## Enforcement

`.github/workflows/branch-name-validation.yml` checks proposed PR head names. GitHub Actions checks do not prevent direct branch creation. For hard protection against merging a nonconforming PR, configure the `Branch name validation` check as required in the GitHub branch ruleset for `main`; this setting is managed in GitHub, not by the check file itself.
