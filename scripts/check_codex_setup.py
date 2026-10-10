#!/usr/bin/env python3
"""Validate canonical Agent Skills and thin Codex specialist profiles.

Static validation only: this cannot establish model availability or live
subagent launching in a particular account/client.
"""
from pathlib import Path
import tomllib

ROOT = Path(__file__).resolve().parents[1]
SKILLS_DIR = ROOT / ".agents" / "skills"
SKILLS = (
    "lecture-development", "lecture-scope", "section-design",
    "slide-level-organization", "slide-design", "slide-authoring",
    "build-teaching-notebook", "worked-solution-authoring",
    "teaching-notebook-authoring",
)
ROLES = {
    "lecture_scope": ("lecture-scope", "gpt-6.1-sol", "high"),
    "section_design": ("section-design", "gpt-6.1-sol", "high"),
    "slide_organization": ("slide-level-organization", "gpt-6.1-sol", "medium"),
    "slide_design": ("slide-design", "gpt-6.1-sol", "high"),
    "slide_authoring": ("slide-authoring", "gpt-6-luna", "high"),
}

def skill_frontmatter(path):
    lines = path.read_text(encoding="utf-8").splitlines()
    assert lines and lines[0] == "---", f"{path}: missing YAML frontmatter"
    end = lines.index("---", 1)
    return dict(line.split(": ", 1) for line in lines[1:end])

assert not (ROOT / "skills").exists(), "Legacy skills/ root must be removed"
assert SKILLS_DIR.is_dir()
assert (SKILLS_DIR / "shared" / "backpressure.md").is_file()
assert set(p.name for p in SKILLS_DIR.glob("*/SKILL.md")) == set(SKILLS)

for name in SKILLS:
    path = SKILLS_DIR / name / "SKILL.md"
    assert path.is_file(), f"Missing canonical skill: {name}"
    meta = skill_frontmatter(path)
    assert meta.get("name") == name and meta.get("description"), f"Bad skill metadata: {name}"
    assert "Codex discovery wrapper" not in path.read_text(encoding="utf-8"), f"Wrapper remains: {name}"

# Supporting reference documents must travel with their canonical skills.
for path in (
    "lecture-scope/references/timing-calibration.md",
    "teaching-notebook-authoring/references/missing-data-example.md",
    "teaching-notebook-authoring/references/notebook-tags.md",
    "teaching-notebook-authoring/references/student-knowledge.md",
    "worked-solution-authoring/references/handoff-template.md",
):
    assert (SKILLS_DIR / path).is_file(), f"Missing skill reference: {path}"

cfg = tomllib.loads((ROOT / ".codex" / "config.toml").read_text(encoding="utf-8"))
assert cfg["agents"]["enabled"] is True
assert 1 <= cfg["agents"]["max_concurrent_threads_per_session"] <= 6

actual_roles = set(p.stem for p in (ROOT / ".codex" / "agents").glob("*.toml"))
assert actual_roles == set(ROLES), f"Unexpected agent roles: {actual_roles ^ set(ROLES)}"

for role, (skill, model, effort) in ROLES.items():
    file = ROOT / ".codex" / "agents" / f"{role}.toml"
    data = tomllib.loads(file.read_text(encoding="utf-8"))
    assert data.get("name") == role and data.get("description"), f"Bad agent profile: {role}"
    assert data.get("model") == model, f"Unexpected model for {role}"
    assert data.get("model_reasoning_effort") == effort, f"Unexpected effort for {role}"
    instructions = data.get("developer_instructions", "")
    assert f".agents/skills/{skill}/SKILL.md" in instructions, f"Agent lacks canonical skill: {role}"
    assert ".agents/skills/shared/backpressure.md" in instructions, f"Agent lacks backpressure: {role}"
    assert "AGENTS.md" in instructions

print(f"Validated {len(SKILLS)} canonical skills and {len(ROLES)} Codex profiles.")
