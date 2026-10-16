# Read-only review of L01 student orientation and plotting imports

Reviewed the current solved notebook's first six Markdown cells, the package
bootstrap, supplied setup and three helper calls. This is an independent read of
the notebook revision, but not a blind review: I authored the extracted package.
No repository files were changed during this review.

## Result

The orientation meets the requested first-course-notebook purpose. It identifies
the learning task and supplied model, directs students to their own saved copy,
distinguishes code and written placeholders from supplied cells, explains cell
execution and persistent runtime state, and tells students how to restart and
check a completed notebook. The distinction between running a completed notebook
and running untouched placeholders is explicit. AI guidance requires students to
explain and check adopted code without inventing grading or disclosure rules.
Submission requirements are correctly deferred to separate instructor guidance.

The mathematical route and workload have not been expanded: all 18 numbered
question cells match the saved pre-extraction notebook exactly. The three helper
calls pass all required model quantities and the interval multiplier explicitly.
Conditional moments, risk, LGS translation, forward moments and generation remain
visible in notebook code. The source-inspection instructions are optional and do
not add a required exercise. The six introductory Markdown cells contain 849
words; reading and orientation time remain unmeasured.

## Material technical limitation before student release

The public source link and Colab installation refer to package commit
`7304c542dd1b0bfd6762ea08d2cb384ffd7d2e39`. Root reports that this revision has not
been published or approved for publication. Consequently the draft's statement
that its GitHub source is available and its first-run Colab installation cannot
yet be treated as working student distribution. This is an acknowledged release
dependency, not a request to publish. Local editable-package execution does not
resolve it; a clean hosted Colab run remains required after an accessible pinned
revision exists.

The bootstrap deliberately installs only when `course_support` is absent. Its
commit pin controls a new install, not the version of an already installed copy.
This does not affect the stated fresh-runtime Colab check, and the local
editable package is intentional. Do not describe it as verifying an existing
installed package against the pinned commit.

No further material clarity or correctness issues found within this bounded
review.
