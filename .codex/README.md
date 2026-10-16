# Codex lecture-development workflow

The instructor works with the **Lecture Development Coordinator** in one Codex conversation. The coordinator delegates bounded work or independent feasibility reviews to five specialist subagents, preserving instructor decisions across stages.

## Where things live

| Location | Authority |
| --- | --- |
| `.agents/skills/<name>/SKILL.md` | **Single canonical source** for each skill: procedure, modes, stage boundaries, review rules, supporting references |
| `.agents/skills/shared/backpressure.md` | Shared protocol referenced by the canonical skills |
| `.codex/agents/<role>.toml` | Thin **Codex-specific launch profiles**: name, one-line description, model, reasoning effort, and pointer to the canonical skill |
| `.codex/config.toml` | Subagent runtime/concurrency settings |
| `AGENTS.md` | Repository-wide instructions and cross-stage invariants |

There are **no metadata wrappers** and no duplicate copies of skills in a separate `skills/` root. Skills are portable; Codex launch profiles are not. These paths are part of the repository contract.

## Model and reasoning settings

The five specialist profiles currently pin models and effort. These are **execution defaults, not pedagogical instructions**, and can be changed in one TOML file without modifying the skill:

| Agent | Model | Effort | Reason |
| --- | --- | --- | --- |
| `lecture_scope` | `gpt-6.1-sol` | `high` | Lecture-level intellectual and mathematical decisions |
| `section_design` | `gpt-6.1-sol` | `high` | Prerequisite reasoning and section contracts |
| `slide_organization` | `gpt-6.1-sol` | `medium` | Sequential teaching-move organization |
| `slide_design` | `gpt-6.1-sol` | `high` | Accurate mathematical and visual explanation |
| `slide_authoring` | `gpt-6-luna` | `high` | Lower-cost production implementation and mechanical checking |

**Important:** account/workspace availability varies. If Codex rejects a pinned model or reasoning effort, edit only the affected `.codex/agents/<role>.toml` or choose an accessible equivalent. The static configuration check does **not** prove model entitlement or runtime availability. The coordinator's own model is chosen in the Codex interface.

## Start in VS Code or Codex CLI

1. Update this repository, open its **root** in VS Code with the Codex extension, or start Codex CLI at the root.
2. Open a **new** Codex conversation. Invoke `$lecture-development` (also discoverable through `/skills`). Restart Codex if the new skill is not visible.
3. Choose a capable available model/high reasoning effort for the coordinator.
4. Use this initial prompt:

```text
$lecture-development
Act as Lecture Development Coordinator for this repository.
Read AGENTS.md, .agents/skills/lecture-development/SKILL.md,
and .agents/skills/shared/backpressure.md.
Check that specialist subagents can be launched.
Keep the instructor conversation with you. Delegate only bounded work
or feasibility reviews with explicit modes, artifacts and versions.
Never claim an independent review unless a separate subagent ran.
First identify the current course stage and ask which lecture to resume.
```

## Read-only subagent smoke test

In a fresh Codex conversation:

```text
$lecture-development
Spawn the slide_design custom subagent in feasibility-review mode.
Review Lectures/L02_Exponential_Families/slide_organization.md using
Lectures/L02_Exponential_Families/section_design.md.
Use .agents/skills/slide-design/SKILL.md and shared backpressure rules.
Read only; do not edit files. Wait for its report.
Give me its feasibility verdict and identify the separate subagent thread.
Then stop and ask before making any lecture-development changes.
```

**Pass criteria:** a separate `slide_design` subagent launches using its configured model and skill, returns a bounded evidence-based report, and makes **no file changes**. This is not established by static or Typst CI checks.

## Validation and maintenance

- Run `python scripts/check_codex_setup.py` to validate canonical skills, references, model/effort keys and TOML shape. CI runs this script.
- Avoid duplicating agent rules in the TOML files. They identify the appropriate `SKILL.md` and enforce only a minimal delegation boundary.
- If model choices should become dynamic later, change the profile strategy then. Do not put model names inside the skill instructions.
- Preserve instructor approvals in lecture-local development state and never edit the same artifact concurrently in separate agents.

Documentation: [Codex subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents), [Agent Skills](https://agentskills.io/), [VS Code skill locations](https://code.visualstudio.com/docs/agent-customization/agent-skills).
