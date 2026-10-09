# Codex lecture-development workflow

The instructor works with the **Lecture Development Coordinator** in a single Codex conversation. The coordinator can delegate to five specialist agent types, which each support `build`, `feasibility-review`, and `revision`.

## Start in VS Code (or Codex CLI)

1. Update this repository and open its **root** in VS Code with the Codex extension, or start Codex CLI at the root.
2. Open a **new** Codex conversation. Explicitly invoke `$lecture-development` (skills can also be discovered with `/skills`). Restart Codex if the skill is not visible.
3. Choose an available capable model and a High reasoning effort for the coordinator, such as GPT-6 Sol High; use Astra if your Codex setup offers it and you prefer it for difficult intellectual judgments.
4. Use this launch prompt:

```text
$lecture-development
Act as Lecture Development Coordinator for this repository.
Read AGENTS.md and the canonical skills/lecture-development/SKILL.md.
Check that the five specialist subagent profiles can be invoked.
Delegate bounded work and feasibility reviews using the explicit modes,
keeping the instructor conversation with you.
Do not claim independent reviews unless a separate subagent actually ran.
Do not start drafting a lecture yet. Identify the current state of the course,
then ask me which lecture and stage to start or resume.
```

## Available specialist subagents

| Agent name | Canonical skill |
| --- | --- |
| `lecture_scope` | `skills/lecture-scope/SKILL.md` |
| `section_design` | `skills/section-design/SKILL.md` |
| `slide_organization` | `skills/slide-level-organization/SKILL.md` |
| `slide_design` | `skills/slide-design/SKILL.md` |
| `slide_authoring` | `skills/slide-authoring/SKILL.md` |

The root coordinator is invoked as a **skill**, not by spawning itself as a subagent. By default, specialist subagents inherit the parent's model and reasoning effort. Edit a specific agent TOML file to override those choices later if useful; don't assume a particular model is enabled for every account.

## Delegation smoke test

After checking out the configuration, start a fresh Codex conversation and ask:

```text
$lecture-development
Spawn the slide_design specialist in feasibility-review mode.
Review Lectures/L02_Exponential_Families/slide_organization.md using
Lectures/L02_Exponential_Families/section_design.md.
Read only; do not edit files. Wait for its report.
Give me the feasibility verdict and identify the separate subagent thread.
Then stop and ask before doing any lecture-development work.
```

**Pass criteria:** an actual `slide_design` subagent thread appears, it uses the canonical skill, returns a bounded evidence-based feasibility review, and no files are changed. This runtime test cannot be done just by committing the configuration.

## Design and maintenance

- Canonical procedures remain in `skills/*/SKILL.md`. The `.agents/skills/*/SKILL.md` entries are deliberately **tiny metadata/discovery wrappers**, not copies of the instructions. Regular files avoid Windows Git symlink problems.
- Coordinator orchestration: `skills/lecture-development/SKILL.md`. Shared modes and backpressure: `skills/shared/backpressure.md`.
- Five custom TOML profiles in `.codex/agents/` are subagent definitions, not independent launchers. No separate model is hard-coded.
- Run `python scripts/check_codex_setup.py` to validate wrapper metadata and TOML structure. This is a static check, not a runtime delegation test.
- Keep consequential decisions and approval with the instructor. Never allow concurrently editing agents to modify the same artifact.

Docs: https://learn.chatgpt.com/docs/build-skills and https://learn.chatgpt.com/docs/agent-configuration/subagents.
