# Course plotting support

This small package holds the three supplied L01 plotting functions. The notebook
keeps the model, covariance blocks, conditioning calculations, squared-loss risk,
linear Gaussian system translation, forward calculation and generation visible.
The helpers only draw supplied quantities. Their readable source is
[`src/course_support/l01.py`](src/course_support/l01.py).

```python
from course_support.l01 import (
    plot_joint_correlation,
    plot_hidden_uncertainty,
    plot_forward_measurements,
)
```

Every model quantity and the interval multiplier is an explicit argument. For the
two interval plots, pass `interval_quantile=norm.ppf(0.95)` from `scipy.stats` in the
notebook. The labelled central 90% intervals describe individual Gaussian
marginals; they do not claim joint 90% coverage. The functions display and return
Matplotlib figures, so a caller can inspect or save a figure if needed. They do
not change the backend or save files themselves.

## Local development

From the repository root, the course authoring environment should declare this
package as an editable local dependency:

```bash
uv add --editable ./notebook_support
uv sync --locked
```

Once that dependency is recorded in the root configuration and lock file, other
checkouts need only `uv sync --locked`. Select the repository `.venv` kernel in VS
Code. There is no need to install the full authoring environment in Colab.

## Colab distribution

The package depends only on NumPy and Matplotlib, both supplied by the course's
Colab baseline. Once a reviewed package revision is available in the public
repository, a notebook can install that exact revision:

```python
# Replace <FULL_COMMIT_SHA> with the public revision approved for the notebook.
%pip install "pml-course-support @ git+https://github.com/opherdonchin/ProbabilisticMachineLearning.git@<FULL_COMMIT_SHA>#subdirectory=notebook_support"
```

This is a distribution template, not a runnable published link: the placeholder
must be replaced by a full public commit hash. The notebook's helper source link
should use that same revision. A changing branch name would allow the package to
change under an otherwise unchanged notebook. Hosted Colab execution remains a
separate release check after the pinned revision is publicly available.

The subdirectory installation syntax follows
[pip's VCS support documentation](https://pip.pypa.io/en/stable/topics/vcs-support/).
The package uses the standard
[setuptools build backend and package discovery](https://setuptools.pypa.io/en/stable/userguide/pyproject_config.html).
