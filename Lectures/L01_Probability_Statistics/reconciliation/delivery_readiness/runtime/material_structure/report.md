# L01 read/run/answer structure — local validation

The instructor selected visible material boundaries and requested short supplied code with full preceding Markdown explanations. This revision implements that bounded request. All 18 question and answer bodies are preserved from the source at `a21aa39`, apart from changing question headings to level four. The instructor’s introduction edits, preserved in that commit, are carried into the solved source with grammar repaired. This does not constitute acceptance of the whole notebook or lecture.

## Structure and source checks

The notebook uses `#` title, `##` sections, `###` Explanation to read / Code to run / Questions to answer, and `####` content or numbered question titles. Reading cells have `explanation` metadata; supplied code has an immediate Markdown `run-instruction`. Each numbered question retains exactly one immediate unnumbered answer. The solved notebook remains authoritative; the student copy is generated mechanically.

There are 159 cells, including 23 code cells: nine student code answers and fourteen supplied cells. Supplied cells range from one to twelve lines. The former setup and final checking blocks are split into coherent units; the normal quantile is introduced immediately before its first use. The joint-correlation display now precedes its associated questions, and the conditional display precedes the interpretation question. No numbered work or mathematical method was added or removed. In particular, the population generator check remains supplied verification, with its affine covariance identity now explained before the code.

## Checks performed

The official local command passed from a clean kernel:

```sh
IPYTHONDIR=/tmp/l01-support-ipython MPLCONFIGDIR=/tmp/l01-support-mpl UV_CACHE_DIR=/tmp/l01-exact-uv-cache uv run --locked python scripts/execute_notebook.py InClass/Solutions/lecture1_missing_data.ipynb
```

The executor reported successful execution and saved the executed copy under ignored `build/notebooks/InClass/Solutions/lecture1_missing_data.executed.ipynb`. All 23 code cells have execution counts, no error outputs occur, all numerical assertions pass, and three inline figures render. Their pixel arrays match the three inline figures captured during the preceding support-package run. No committed figure asset needed regeneration.

Structural checks compare all 18 question/answer bodies against the pre-revision source, validate both notebook schemas, verify material heading levels, immediate unnumbered answers and preceding supplied-code run explanations, and check exact mechanical derivation of the student notebook. Code outputs/counts are cleared in both source files. A separate transformation of the executed source verifies that the generator clears counts for supplied code as well as solution code; it no longer leaves stale counts after removing outputs. Markdown cells receive no execution metadata. Exact counts and hashes are in [validation.json](validation.json).

[Separate read-only pedagogical review](review.md) found no required fixes. The reviewer previously authored the package and is informed/nonblind; the coordinator authored this restructuring. It assesses action clarity, preserved mathematics, supplied explanations and local sequence, rather than instructor acceptance or measured learner time.

## Remaining limits

The additional explanations have not been timed with students. The earlier 55–75-minute estimate is not a measured duration for this revision. The package pin remains local, its public install/source links remain unavailable, and no clean hosted Colab run has occurred. The earlier [package validation](../support_package/report.md) is evidence for its recorded source and packaging behavior, not a hosted validation of this revision. Review continues one part at a time in ordinary chat; slides and Scope acceptance remain separate.
