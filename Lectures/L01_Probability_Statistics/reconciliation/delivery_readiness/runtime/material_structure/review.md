# L01 material-boundary revision review

## Inputs and review status

Read-only review of `InClass/Solutions/lecture1_missing_data.ipynb` against
`/tmp/l01-before-materials-Solutions.ipynb`, using the instructor-accepted hierarchy
and the teaching-notebook-authoring skill. Root owns all repository edits. This is
an informed, nonblind review: I authored the extracted plotting package earlier;
root authored this notebook restructuring. No repository files were edited here.

## Result: passed; no required fixes

The notebook now uses one level-one title, level-two sections, level-three
material headings (`Explanation to read`, `Code to run`, `Questions to answer`),
and level-four topics/questions. The hierarchy makes the expected student action
visible before the material. Explanations establish the mathematical objects and
formulas before the corresponding student calculations. Supplied code is split
into coherent short operations; each supplied code cell immediately follows a
Markdown explanation tagged `run-instruction`. Those explanations specify what
to run, what the code does, why it is supplied, and whether to expect output.

All 18 question bodies and all 18 answer bodies are unchanged after normalizing
heading depth. Each question is immediately followed by exactly one unnumbered
solution cell. The new supplied-code prose does not create extra exercises or
require students to implement a second inference method. Numerical code is
unchanged apart from cell splitting, removal of comments now expressed in prose,
and moving `z90 = norm.ppf(0.95)` next to its explanation before its first use.
No mathematical expression from the previous Markdown was removed.

The revised boundary is particularly clear around the conditional display,
realized-error comparison, LGS consistency calculation and population generator
check. These are labelled supplied operations, with their mathematical purpose
established first. The previously code-only affine generator check now has its
block matrix and covariance identity explained before the supplied calculation.
That explanation does not add student work.

The important distinctions remain explicit: known parameters versus hidden
coordinates; a conditional distribution versus its point estimate; individual
marginal intervals versus simultaneous coverage; conditional expected model risk
versus a realized loss; observation noise versus unconditional measurement
variation; old-case reconstruction versus a new independent case; and algebraic
population identities versus empirical validation from one draw. The supplied
checks are presented as feedback on selected calculations, not evidence that the
Gaussian model fits a real task.

The added instructional prose increases the reading burden, and the revised
159-cell presentation has not been timed with students. The extra cells mostly
make existing material categories and run instructions visible; their count does
not itself establish a timing failure. No unsupported duration or grading policy
was introduced. Existing package-publication/hosted-runtime release dependencies
are outside this restructuring review and have not been reassessed here.
