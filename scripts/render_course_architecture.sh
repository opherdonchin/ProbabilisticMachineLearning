#!/usr/bin/env bash
# Render the authoritative course architecture using the repository's Typst version.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"
if ! command -v typst >/dev/null 2>&1; then
  echo "Typst is required (version 0.15.0 is used in CI)." >&2
  exit 127
fi
output="${1:-course_architecture.pdf}"
typst compile --root . --creation-timestamp 0 course_architecture.typ "$output"
echo "Rendered $output from course_architecture.typ"
