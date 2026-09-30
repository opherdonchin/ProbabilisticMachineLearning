"""Flag likely run-on sub/superscripts in Typst math.

This is a focused source check, not a complete Typst parser. In math, a bare
script immediately followed by ``(`` or ``[`` often absorbs an argument that
was meant to follow the scripted symbol. Group the script or add a space.
"""

from __future__ import annotations

import argparse
import re
from pathlib import Path


MATH = re.compile(r"(?<!\\)\$(.*?)(?<!\\)\$", re.DOTALL)
RUN_ON = re.compile(
    r'(?P<script>[_^](?:[A-Za-z][A-Za-z0-9]*|[0-9]+|"(?:\\.|[^"\\])*"))'
    r"(?P<next>[([])"
)


def check(path: Path) -> int:
    source = path.read_text(encoding="utf-8")
    lines = source.splitlines()
    problems = 0

    for math in MATH.finditer(source):
        for run_on in RUN_ON.finditer(math.group(1)):
            offset = math.start(1) + run_on.start()
            line = source.count("\n", 0, offset) + 1
            column = offset - source.rfind("\n", 0, offset)
            snippet = run_on.group()
            print(f"{path}:{line}:{column}: possible run-on math attachment {snippet!r}")
            print(f"  {lines[line - 1].strip()}")
            problems += 1

    return problems


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("files", nargs="+", type=Path, help="Typst sources to check")
    args = parser.parse_args()

    problems = sum(check(path) for path in args.files)
    if problems:
        print(f"Found {problems} possible run-on math attachment(s).")
        return 1
    print("No possible run-on math attachments found.")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
