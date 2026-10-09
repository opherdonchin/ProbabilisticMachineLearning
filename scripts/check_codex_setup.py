#!/usr/bin/env python3
"""Check Codex skill discovery wrappers and subagent TOML configuration."""
from pathlib import Path
import tomllib

ROOT = Path(__file__).resolve().parents[1]
SKILLS = ["lecture-development","lecture-scope","section-design","slide-level-organization","slide-design","slide-authoring","build-teaching-notebook","worked-solution-authoring","teaching-notebook-authoring"]
ROLES = {"lecture_scope":"lecture-scope","section_design":"section-design","slide_organization":"slide-level-organization","slide_design":"slide-design","slide_authoring":"slide-authoring"}

def metadata(path):
    lines = path.read_text(encoding="utf-8").splitlines()
    assert lines[0] == "---", f"{path}: missing frontmatter"
    end = lines.index("---", 1)
    result = dict(line.split(": ", 1) for line in lines[1:end])
    assert result.get("name") and result.get("description"), f"{path}: invalid frontmatter"
    return result

for name in SKILLS:
    canonical = ROOT / "skills" / name / "SKILL.md"
    wrapper = ROOT / ".agents" / "skills" / name / "SKILL.md"
    assert canonical.is_file() and wrapper.is_file(), f"Missing skill: {name}"
    assert metadata(canonical) == metadata(wrapper), f"Metadata drift: {name}"
    assert f"skills/{name}/SKILL.md" in wrapper.read_text(encoding="utf-8"), f"Bad wrapper: {name}"

cfg = tomllib.loads((ROOT / ".codex" / "config.toml").read_text(encoding="utf-8"))
assert cfg["agents"]["enabled"] is True
assert 1 <= cfg["agents"]["max_concurrent_threads_per_session"] <= 6

for role, skill in ROLES.items():
    spec = tomllib.loads((ROOT / ".codex" / "agents" / f"{role}.toml").read_text(encoding="utf-8"))
    assert spec["name"] == role and spec.get("description")
    instructions = spec["developer_instructions"]
    assert f"skills/{skill}/SKILL.md" in instructions
    assert "skills/shared/backpressure.md" in instructions
    for mode in ("build", "feasibility-review", "revision"):
        assert mode in instructions, f"{role}: {mode} missing"
print(f"Codex configuration OK: {len(SKILLS)} skills and {len(ROLES)} subagent roles.")
