Cell 0, id 99684d29, type markdown

# Lecture 1 — Missing data and exact Gaussian queries

---

Cell 1, id 2613e941, type markdown

## Before you begin

---

Cell 2, id 4d7a5f53, type markdown

### *Explanation to read*

---

Cell 3, id 2c035116, type markdown

#### What you will do

Welcome to the first teaching notebook in this course. Here you turn the lecture's equations into calculations, inspect their outputs, and explain what those outputs establish.

Four coordinates of a measurement vector are recorded; three are withheld. You will compute a distribution for the hidden block, choose an estimate under squared loss, and use the same model to predict and generate measurements of a new case. The model parameters are supplied throughout.

We assume a basic knowledge of probability, matrix algebra and Python. New numerical operations are explained where you need them. You are expected to work through each question so you can understand the calculations.

---

Cell 4, id b8f0db4b, type markdown

#### Save a copy and start the runtime

In **student notebooks**, placeholders indicate where answers are expected. Save your own copy before editing; in Colab, use **File → Save a copy in Drive**. The **solved notebook** has filled-in answers to help you if you get stuck.

In Colab, connect to a standard CPU runtime. You can also clone the repository locally; in VS Code, select the course repository's `.venv` kernel. Run the supplied setup cells below before starting Question 1.1. The plotting-support cell may take a moment on its first run; it installs only the small course plotting package when needed.

A notebook mixes text cells and code cells. Select a code cell and press **Shift+Enter** to run it; its output appears below. To write a prose or mathematical answer, double-click its text cell, replace the placeholder, and press **Shift+Enter** to display it. Use `$ ... $` for inline mathematics and `$$ ... $$` for a displayed equation.

---

Cell 5, id 85e4f18e, type markdown

#### Read, run, then answer

Each section uses three kinds of material:

- **Explanation to read** develops a mathematical or technical idea that you need to understand and use.
- **Code to run** supplies setup, displays or checks, with brief notes about their purpose and output. Read those notes and run the supplied cells. You are not asked to write this code.
- **Questions to answer** asks you to do something. Each numbered question says whether to write code, mathematics or prose. Replace its one unnumbered answer cell: `# answer here` marks a code answer and “answer here” marks a written answer. In the solved reference, that same cell contains a complete answer.

Work **from top to bottom**: read the explanation, run any supporting code, then answer the questions. Later cells use variables created earlier. The runtime remembers values until you restart it. If you change an earlier calculation, rerun the cells that depend on it. Saved output alone does not show that the current code produced it.

After running code, check the requested shapes, values or plot. In written answers, explain the relevant mathematical distinction in your own words; a printed array does not answer an interpretation question.

The sections move from the known model to conditioning, squared-loss estimation, an equivalent linear Gaussian system, forward prediction and generation. Pause and ask for help if a step stops making sense.

---

Cell 6, id 14bd0cfc, type markdown

#### Using AI assistance

You may use an AI assistant to help with these questions. First identify the mathematical object you need and what is already given. When asking for help, include the question, its nearby formula, and the relevant array names/shapes; an isolated error message often omits the needed context.

I recommend against using any built-in AI or uploading the entire notebook to AI. The notebook works best if the agent has seen as much of the notebook as you have when addressing a specific question, so it is best if you work in copy / paste mode: copying material into an AI chat and then reading and typing what is appropriate or pasting back in the answer.

Ask for an explanation or a small piece of code you can check. Adapt the answer to this notebook's names, run it, and connect it to the displayed equation. If a line is unclear, ask what it computes and why its dimensions work. You should be able to explain your final answer and its assumptions, including code suggested by AI. If code fails, read the final line of the error and identify the cell that caused it before changing the model or its data.

---

Cell 7, id f65974e4, type markdown

#### What a finished notebook should contain

Keep your code, written explanations and the resulting outputs together. By the end, you should be able to explain the hidden-block distribution and its uncertainty, the estimate selected by squared loss, and how forward prediction and generation answer different questions.

Before you finish:

1. Check that every numbered question has an answer and every requested display is present.
2. Read your outputs and explanations together: shapes and uncertainty statements should agree with the equations.
3. Restart the runtime/kernel and run all cells from the beginning **after filling the answers**. Resolve errors and confirm the supplied checks pass. Running all cells in an untouched student notebook will stop when a later cell needs an answer you have not written yet.
4. Save the completed notebook with its outputs. Follow any submission instructions supplied separately by the instructor.

The supplied checks catch selected numerical mistakes. Passing them is useful feedback; your explanations are still needed to show what the calculations mean.

---

Cell 8, id fabfa591, type markdown

## Supplied plotting tools

---

Cell 9, id 62dd4938, type markdown

### *Code to run*

---

Cell 10, id 6f561548, type markdown

#### Load the plotting tools

Imports the plotting helpers; Colab installs the pinned package if needed. They display your calculations. Locally, restart the `.venv` kernel after `uv sync --locked`.

Optional: inspect the [helper source](https://github.com/opherdonchin/ProbabilisticMachineLearning/blob/7304c542dd1b0bfd6762ea08d2cb384ffd7d2e39/notebook_support/src/course_support/l01.py) or use `help(plot_hidden_uncertainty)` to read its inputs.

---

Cell 11, id f74c9e0d, type code

```python
import importlib.util

if importlib.util.find_spec("course_support") is None:
    if importlib.util.find_spec("pip") is None:
        raise RuntimeError(
            "Restart this notebook's .venv kernel. If the import still fails, "
            "run `uv sync --locked` in the repository terminal, then restart again."
        )
    %pip install --quiet "pml-course-support @ git+https://github.com/opherdonchin/ProbabilisticMachineLearning.git@7304c542dd1b0bfd6762ea08d2cb384ffd7d2e39#subdirectory=notebook_support"

from course_support.l01 import (
    plot_joint_correlation,
    plot_hidden_uncertainty,
    plot_forward_measurements,
)
print("Course plotting tools are ready.")
```

---

Cell 12, id 70dd4753, type markdown

## 0. Known model and fixed case

---

Cell 13, id 508776e2, type markdown

### *Explanation to read*

---

Cell 14, id 9d357a93, type markdown

#### The supplied joint Gaussian

Write $X=(X_1^T,X_2^T)^T$ with $X_1\in\mathbb R^3$ and $X_2\in\mathbb R^4$. We know
$$
X\sim\mathcal N\!\left(\begin{pmatrix}\mu_1\\\mu_2\end{pmatrix},
\begin{pmatrix}\Sigma_{11}&\Sigma_{12}\\\Sigma_{21}&\Sigma_{22}\end{pmatrix}\right),
\qquad \mu_1=(-0.5,0.5,1)^T,\quad\mu_2=(0,0.5,-0.5,1)^T.
$$

The joint covariance is positive definite, so its diagonal blocks and conditional covariance matrices are invertible. We check these properties at the end. For this example, we construct the covariance blocks using $J_d=\mathbf1_d\mathbf1_d^T$, $\sigma_1=1$, $\sigma_2=1.2$, $\rho_1=0.70$, $\rho_2=0.80$, $\kappa=0.90$:
$$
\Sigma_{11}=\sigma_1^2[(1-\rho_1)I_3+\rho_1J_3],\qquad
\Sigma_{22}=\sigma_2^2[(1-\rho_2)I_4+\rho_2J_4],
$$
$$
\Sigma_{12}=\kappa\sigma_1\sigma_2\sqrt{\rho_1\rho_2}\,\mathbf1_3\mathbf1_4^T,
\qquad\Sigma_{21}=\Sigma_{12}^T.
$$

---

Cell 15, id 376590ac, type markdown

#### Representing the blocks in NumPy

The mean blocks are one-dimensional arrays with shapes `(3,)` and `(4,)`. Their covariance blocks are two-dimensional arrays: for example, `Sigma12` has shape `(3,4)`. Matrix-vector multiplication with `@` maps a `(4,)` vector to a `(3,)` vector in this example. A vector does not need to be stored as a column array; `.T` transposes a matrix but leaves a one-dimensional vector's shape unchanged.

`np.block([[A, B], [C, D]])` assembles compatible matrix blocks in the same two-by-two layout as the displayed covariance. The first block row joins `Sigma11` and `Sigma12`; the second joins `Sigma21` and `Sigma22`. This gives the full `(7,7)` covariance.

---

Cell 16, id 1ac9af97, type markdown

### *Code to run*

---

Cell 17, id fb3c2e77, type markdown

#### Set the dimensions and model parameters

Defines the supplied joint Gaussian; prints the block sizes and joint mean. `mu` concatenates the hidden-block and recorded-block means, in that order. `np.set_printoptions` changes the displayed precision; calculations retain the stored precision.

---

Cell 18, id ffccfdcc, type code

```python
import numpy as np
from scipy.stats import norm

np.set_printoptions(precision=6, suppress=True)
n1, n2 = 3, 4
mu1 = np.array([-0.5, 0.5, 1.0])
mu2 = np.array([0.0, 0.5, -0.5, 1.0])
mu = np.concatenate([mu1, mu2])
sigma1, sigma2 = 1.0, 1.2
rho1, rho2, kappa = 0.70, 0.80, 0.90
print("Hidden / recorded block sizes:", n1, "/", n2)
print("Joint mean mu:", mu)
```

---

Cell 19, id e91e32f8, type markdown

#### Assemble the covariance blocks

Evaluates the covariance formulas and assembles `Sigma`; its printed shape should be `(7,7)`. `np.eye` and `np.ones` supply the identity and all-ones matrices in those formulas.

---

Cell 20, id 5789bf47, type code

```python
Sigma11 = sigma1**2 * ((1-rho1)*np.eye(n1) + rho1*np.ones((n1,n1)))
Sigma22 = sigma2**2 * ((1-rho2)*np.eye(n2) + rho2*np.ones((n2,n2)))
Sigma12 = kappa*sigma1*sigma2*np.sqrt(rho1*rho2)*np.ones((n1,n2))
Sigma21 = Sigma12.T
Sigma = np.block([[Sigma11, Sigma12], [Sigma21, Sigma22]])
print("Joint covariance Sigma shape:", Sigma.shape)
```

---

Cell 21, id f60b297d, type markdown

#### Load the case and expose only its recorded block

This supplied vector represents one simulated case; keep its values unchanged. Slicing separates the recorded coordinates, `x2_obs`, from the withheld coordinates, `x1_true`. Only `x2_obs` is printed and used for inference; the withheld values are revealed later for evaluation.

---

Cell 22, id 2d5d6faf, type code

```python
# Fixed reference case: original seed 2027 / NumPy 2.0.2 provenance.
x_complete = np.array([
    -0.9809265055186939, -0.275006600480288, 1.8920470230380393,
    -0.18413093623310994, -0.06973754657319287,
    -0.07777903828206933, 0.9191872262734604,
])
x1_true = x_complete[:n1].copy()  # Retained only for later evaluation.
x2_obs = x_complete[n1:].copy()  # This is the inference input.
print("Observed block x2_obs:", x2_obs)
```

---

Cell 23, id 69da4a79, type markdown

## 1. Read the known joint and identify the task

---

Cell 24, id f16bf34d, type markdown

### *Code to run*

---

Cell 25, id a27fa5cd, type markdown

#### Display the known correlations

Displays the known correlation matrix, with the hidden/recorded boundary after coordinate three. Locate the two within-block regions and the cross-block region. These correlations come from the supplied model parameters.

---

Cell 26, id 64649d5d, type code

```python
_ = plot_joint_correlation(Sigma, n1)
```

---

Cell 27, id b68a1c90, type markdown

### *Questions to answer*

---

Cell 28, id 396c12e0, type markdown

#### 1.1 Identify the covariance blocks — mathematics

For $X_1\in\mathbb R^3$ and $X_2\in\mathbb R^4$, state the shape of each of $\Sigma_{11},\Sigma_{12},\Sigma_{21},\Sigma_{22}$ and the full $\Sigma$. Explain which pairs of coordinates an entry of $\Sigma_{12}$ describes.

---

Cell 29, id 256ea520, type markdown

- answer here
