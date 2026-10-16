#!/usr/bin/env python3

import argparse
import json
from pathlib import Path


def transform_cell(cell):
    tags = set(cell.get("metadata", {}).get("tags", []))

    if cell.get("cell_type") == "code":
        cell["outputs"] = []
        cell["execution_count"] = None

    if "solution" not in tags:
        return cell

    if cell.get("cell_type") == "code":
        cell["source"] = ["# answer here"]
        cell["execution_count"] = None
        cell["outputs"] = []
    elif cell.get("cell_type") == "markdown":
        cell["source"] = ["- answer here"]

    return cell


def make_self_work_notebook(source_path, output_path):
    with source_path.open("r", encoding="utf-8") as f:
        notebook = json.load(f)

    notebook["cells"] = [
        transform_cell(cell)
        for cell in notebook["cells"]
        if "solution-boundary" not in cell.get("metadata", {}).get("tags", [])
    ]

    output_path.parent.mkdir(parents=True, exist_ok=True)
    with output_path.open("w", encoding="utf-8") as f:
        json.dump(notebook, f, ensure_ascii=False, indent=1)
        f.write("\n")


def main():
    parser = argparse.ArgumentParser(
        description=(
            "Generate a student self-work notebook from a solved teaching notebook "
            "by removing solved-only answer markers, replacing cells tagged "
            "'solution' with answer placeholders, and "
            "clearing code outputs/execution counts."
        )
    )
    parser.add_argument("source", type=Path, help="Solved source notebook")
    parser.add_argument("output", type=Path, help="Student self-work notebook")
    args = parser.parse_args()

    make_self_work_notebook(args.source, args.output)


if __name__ == "__main__":
    main()
