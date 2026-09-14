"""Execute a course notebook cleanly and save a reviewable executed copy.

The default runs in a temporary copy of the notebook directory so that a
compatibility check cannot rewrite generated course assets. Pass --in-place
only when the notebook is meant to regenerate those assets.
"""

from __future__ import annotations

import argparse
import asyncio
import shutil
import sys
import tempfile
from pathlib import Path

import nbformat
from nbclient import NotebookClient


REPOSITORY_ROOT = Path(__file__).resolve().parents[1]

if sys.platform == "win32":
    asyncio.set_event_loop_policy(asyncio.WindowsSelectorEventLoopPolicy())


def arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser()
    parser.add_argument("notebook", type=Path)
    parser.add_argument("--in-place", action="store_true")
    parser.add_argument("--timeout", type=int, default=600)
    parser.add_argument(
        "--expect-file",
        action="append",
        default=[],
        type=Path,
        help="Require a non-empty file relative to the notebook directory",
    )
    return parser.parse_args()


def repository_path(path: Path) -> Path:
    resolved = path.resolve() if path.is_absolute() else (REPOSITORY_ROOT / path).resolve()
    try:
        resolved.relative_to(REPOSITORY_ROOT)
    except ValueError as error:
        raise SystemExit(f"Notebook must be inside {REPOSITORY_ROOT}: {resolved}") from error
    if not resolved.is_file():
        raise SystemExit(f"Notebook does not exist: {resolved}")
    return resolved


def execute(notebook_path: Path, *, timeout: int) -> nbformat.NotebookNode:
    notebook = nbformat.read(notebook_path, as_version=4)

    # A compatibility check must not inherit stale output or execution state.
    for cell in notebook.cells:
        if cell.cell_type == "code":
            cell.outputs = []
            cell.execution_count = None

    client = NotebookClient(
        notebook,
        timeout=timeout,
        kernel_name="python3",
        resources={"metadata": {"path": str(notebook_path.parent)}},
    )
    client.execute()
    return notebook


def output_path(source: Path) -> Path:
    relative = source.relative_to(REPOSITORY_ROOT)
    return (
        REPOSITORY_ROOT
        / "build"
        / "notebooks"
        / relative.parent
        / f"{source.stem}.executed.ipynb"
    )


def check_expected_files(notebook_directory: Path, expected_files: list[Path]) -> None:
    missing = [
        path
        for path in expected_files
        if not (notebook_directory / path).is_file()
        or (notebook_directory / path).stat().st_size == 0
    ]
    if missing:
        rendered = ", ".join(str(path) for path in missing)
        raise SystemExit(f"Notebook did not create expected non-empty files: {rendered}")


def main() -> None:
    args = arguments()
    source = repository_path(args.notebook)
    destination = output_path(source)

    if args.in_place:
        executed = execute(source, timeout=args.timeout)
        check_expected_files(source.parent, args.expect_file)
    else:
        with tempfile.TemporaryDirectory(prefix="pml-notebook-") as temporary:
            copied_directory = Path(temporary) / source.parent.name
            shutil.copytree(
                source.parent,
                copied_directory,
                ignore=shutil.ignore_patterns(
                    ".ipynb_checkpoints", "__pycache__", "output"
                ),
            )
            copied_notebook = copied_directory / source.name
            executed = execute(copied_notebook, timeout=args.timeout)
            check_expected_files(copied_directory, args.expect_file)

    destination.parent.mkdir(parents=True, exist_ok=True)
    nbformat.write(executed, destination)
    print(f"Executed {source.relative_to(REPOSITORY_ROOT)}")
    print(f"Saved clean execution record to {destination.relative_to(REPOSITORY_ROOT)}")


if __name__ == "__main__":
    main()
