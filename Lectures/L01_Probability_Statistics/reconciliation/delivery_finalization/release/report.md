# L01 current notebook and helper release checks

Current local validation passes. Public distribution and hosted Colab validation remain outstanding. This check did not reopen the accepted notebook pedagogy, simulate learners, change course sources, upload files, publish commits or launch a remote runtime.

## Actual current checks

Baseline: `196e5e56a75f833e8a06f7077b951865487d61cd`, root worktree. `uv sync --locked` passed without dependency changes. `UV_CACHE_DIR=/tmp/l01-release-readiness/uv-cache uv run --locked python scripts/execute_notebook.py InClass/Solutions/lecture1_missing_data.ipynb` passed once through the canonical executor. That script clears execution state in a temporary notebook-directory copy and runs a fresh `python3` kernel. It saved the successful record under ignored `build/notebooks/`, also copied beside this report.

All 146 cells retain source/type/IDs; all 23 code cells have sequential execution counts 1–23, no error output and three inline PNG figures. Numerical assertions passed. The source SHA-256 is `2af949f2e4198a31a654af474bcda52ab45a901cc8a77c59e8f6f6c67ce6998a`; the executed artifact SHA-256 is `a2ae24b816e9a9040090914c7bf6d8f01a2b4c2cf77fff1354200506d44ca0bc`. `validation.json` binds complete file hashes and normalized source/output hashes; `cell-results.json` binds each code-cell result. The source/type/IDs also match the instructor-approved `e5c52f6` source.

The instructor's solved notebook remains byte-for-byte unchanged: 15 saved executed code cells, no errors, two saved PNGs. These partial saved outputs were preserved, rather than replaced by this agent's complete clean run. The student notebook also remains byte-for-byte unchanged. A scratch generation using the current `scripts/make_self_work_notebook.py` matches the student notebook's sources, types and IDs exactly. The generated copy clears every code cell's outputs/counts; the current saved student file has one executed supplied cell, which is its execution-state difference from a freshly generated template. Both source notebooks, the scratch template and the clean executed copy pass `nbformat` schema validation.

The repository interpreter is `.venv/bin/python`, Python 3.12.13; NumPy 2.0.2, SciPy 1.16.3, Matplotlib 3.10.0, ipykernel 6.31.0, nbclient 0.10.4 and nbformat 5.11.1. The package imports from the repository's editable `notebook_support/src/course_support/l01.py`. The `python3` kernelspec is available under `.venv/share/jupyter/kernels/python3`. These probes do not establish which kernel an already open IDE notebook currently selects. Pip is absent from this uv environment; the notebook imports the installed helper successfully and does not invoke its missing-package installer. Its existing restart/locked-sync guidance addresses a stale local kernel. The executor emits only the harmless sandbox warning that unwritable `~/.ipython` was replaced by a temporary directory.

## Reused package evidence

All four tracked `notebook_support/` files are byte-identical to pin `7304c542dd1b0bfd6762ea08d2cb384ffd7d2e39`. The current helper, package manifest, root manifest and uv lock hashes equal the recorded package-validation inputs. The existing successful standalone wheel was inspected and reused; its embedded `__init__.py` and `l01.py` exactly match current source. Wheel SHA-256: `1f4bb86ca71205259f51e59a42a39e5d5037486310ff16cac8cdca5e45e803c9`. It requires only NumPy >=1.26 and Matplotlib >=3.8, Python >=3.10. No wheel rebuild or package-version change is needed on these inputs. Prior wheel-build and isolated-local-Git logs are copied beside this report.

The old isolated bootstrap evidence remains evidence for its recorded earlier notebook and the identical pinned package using local Git transport. It does not establish current public HTTPS installation or a hosted run. The old generator hash differs from the current generator, so old derivation evidence was not reused: student derivation was checked afresh here.

## Anonymous public checks — 2026-10-17 06:51 UTC

`public-access.json` records exact URLs/statuses/body hashes; raw headers and bodies are retained. Repository HTML and `main/README.md` return 200, so the failures are not a blanket inability to reach GitHub. The pinned commit API returns 422 with “No commit found for SHA”; pinned helper blob, raw helper and raw package manifest all return 404. Current-baseline student raw and `main` student raw both return 404. The `main` solved raw returns 200 but has the old SHA-256 `f114516ca6a9c0823c14da0a734822a8901e4fdccf237481d47d0e3a61f80a8c`, not the current accepted source. Public availability is therefore an observed blocker, rather than merely an untested assumption. The web browser fetch also failed, but the direct anonymous GET responses provide the diagnostic evidence.

## Remaining release steps and runnable handoff

1. After explicit remote-export authorization, publish the pinned helper revision and the accepted notebooks through the approved branch workflow. Verify incorporation into the intended public destination; making a feature branch visible is distinct from merging into `main`. If a current `main` notebook URL is used, it must resolve to the intended current notebook rather than the older solved file. Keep the existing exact helper pin unless a technical reason requires changing it. No source correction is needed to make the currently pinned package build.
2. Recheck the exact public pin and current notebook URLs with anonymous reads. For the helper, this command must exit zero and its hash must equal `381bc6f67a4ce8df5064264f5a949baa5e4c2dfff287758b877c7d79d1ed645e`:

   ```bash
   curl --fail --location 'https://raw.githubusercontent.com/opherdonchin/ProbabilisticMachineLearning/7304c542dd1b0bfd6762ea08d2cb384ffd7d2e39/notebook_support/src/course_support/l01.py' -o /tmp/l01-helper-public.py
   sha256sum /tmp/l01-helper-public.py
   ```

3. Use the official Google Colab VS Code extension to open the current solved notebook and select a fresh hosted **2026.07 CPU** runtime. Do not preinstall the helper; Restart/Run All must exercise the exact pinned public `%pip` path and immediate import. Confirm all 23 cells complete, zero errors, three plots and reasonably sized output. Verify the displayed scientific versions. Save an executed evidence copy and a log recording runtime version, Python/package versions, helper source/pin, input source hash and execution result. Remote `/content` files remain remote until explicitly downloaded. This notebook needs only the published helper, rather than additional data-file uploads. The self-work template deliberately has incomplete answer cells and is not expected to execute end-to-end as a solution.
4. If hosted execution reveals a concrete failure, repair only that failure under the existing notebook workflow and repeat affected checks. Do not change pins speculatively. Recheck the latest rolling runtime first if 2026.07 is unavailable; change the course baseline/dependency pins only after the actual hosted run establishes the new baseline.

Local rerun, if sources change:

```bash
UV_CACHE_DIR=/tmp/l01-release-readiness/uv-cache uv sync --locked
UV_CACHE_DIR=/tmp/l01-release-readiness/uv-cache uv run --locked python scripts/execute_notebook.py InClass/Solutions/lecture1_missing_data.ipynb
UV_CACHE_DIR=/tmp/l01-release-readiness/uv-cache uv run --locked python scripts/make_self_work_notebook.py InClass/Solutions/lecture1_missing_data.ipynb /tmp/l01-release-readiness/student.generated.ipynb
```

## Smallest technical documentation fixes

Keep hosted/public checks explicitly pending and bind current readiness to the current notebook hashes. Update the current authoring report's obsolete “five executed code cells” fact to the actual preserved 15, and replace its assumption that links are unavailable with this direct anonymous evidence. Do not replace identifiable prior evidence or imply old package-validation notebook counts describe this current revision. Before eventual distribution, mechanically generate the student template to the chosen distribution destination so saved instructor execution state is not mistaken for student work; preserve the current instructor working files and outputs in the meantime.

No mathematical, exercise, package, dependency or pedagogical change is recommended by these checks. Learner timing was not tested or reopened. A successful local run is not a claim of Colab compatibility.
