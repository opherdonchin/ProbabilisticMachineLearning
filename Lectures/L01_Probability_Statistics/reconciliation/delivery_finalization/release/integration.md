# Integration and local review copies

The specialist’s raw report, findings, validation and HTTP records are retained without rewriting their claims. `retained-evidence.json` lists the files actually copied here; the original capture manifest also hashes the unretained full HTML pages, old public solved notebook, successful execution copy and wheel. Those large or duplicate artifacts remain in `/tmp/l01-release-readiness/` or ignored build output. Current source notebooks and the pinned package remain canonical; superseded public notebook bodies are not current repository material.

The prepared, **unpublished** local distribution copies are:

- [Clean student template](../../../../../build/l01-release/lecture1_missing_data.ipynb), mechanically generated from the accepted source, with empty code outputs/counts.
- [Complete locally executed solution](../../../../../build/l01-release/Solutions/lecture1_missing_data.ipynb), all 23 code cells passing with three plots.
- [Local package wheel](../../../../../build/l01-release/pml_course_support-0.1.0-py3-none-any.whl), identical to the previously checked package.
- [Candidate file hashes](../../../../../build/l01-release/manifest.json).

These are local checking/distribution copies, not publication or hosted evidence. The instructor’s canonical notebooks and saved outputs are unchanged. No remote branch was created or updated. Publish through the existing branch workflow only after explicit export authorization; publishing the branch and merging into `main` are distinct actions. Public URL and clean hosted checks in the raw report remain necessary.
