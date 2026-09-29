#let navy = rgb("#173A5E")
#let blue = rgb("#2F6690")
#let pale-blue = rgb("#EEF4F8")
#let pale-gray = rgb("#F5F6F7")
#let rule = rgb("#D8DEE4")
#let muted = rgb("#59636E")

#set page(
  paper: "a4",
  margin: (x: 23mm, top: 19mm, bottom: 20mm),
  numbering: "1",
)
#set text(font: "Libertinus Serif", size: 10pt, lang: "en", fill: black)
#set par(justify: true, leading: 0.62em, spacing: 0.72em)
#set list(indent: 1.25em, body-indent: 0.55em, spacing: 0.32em)
#set enum(indent: 1.25em, body-indent: 0.55em, spacing: 0.32em)
#set heading(numbering: none)

#show heading.where(level: 1): it => block(
  above: 1.25em,
  below: 0.48em,
  breakable: false,
)[
  #text(font: "Noto Sans", size: 14pt, weight: "bold", fill: navy)[#it.body]
]

#show heading.where(level: 2): it => block(
  above: 0.95em,
  below: 0.26em,
  breakable: false,
)[
  #text(font: "Noto Sans", size: 10.7pt, weight: "bold", fill: navy)[#it.body]
]

#let label(body) = text(font: "Noto Sans", size: 8.7pt, weight: "bold", fill: muted, body)

#let lecture(number, date, title, topics, book1, book2) = block(
  breakable: false,
  above: 0.28em,
  below: 0.95em,
)[
  #grid(
    columns: (1fr, auto),
    gutter: 8pt,
    align: (left, right),
    [#text(font: "Noto Sans", size: 10.8pt, weight: "bold", fill: navy)[Lecture #number]],
    [#text(font: "Noto Sans", size: 8.8pt, fill: muted)[#date]],
  )
  #text(font: "Noto Sans", size: 10.2pt, weight: "semibold", fill: blue)[#title]
  #v(3pt)
  #grid(
    columns: (18mm, 1fr),
    column-gutter: 5pt,
    row-gutter: 3pt,
    align: (left, left),
    [#label[Topics]], [#topics],
    [#label[Book 1]], [#book1],
    [#label[Book 2]], [#book2],
  )
]

#align(center)[
  #text(font: "Noto Sans", size: 21pt, weight: "bold", fill: navy)[Advanced Statistics 2027-1]

  #v(3pt)
  #text(font: "Noto Sans", size: 13pt, weight: "medium", fill: blue)[Probabilistic Machine Learning]

  #v(6pt)
  #text(size: 9.5pt, fill: muted)[Course number: TBD]
]

#v(1.1em)

#grid(
  columns: (30mm, 1fr),
  column-gutter: 7pt,
  row-gutter: 3pt,
  [#label[Lecturer]], [Opher Donchin],
  [#label[Tutorials]], [None],
  [#label[Communication]], [By e-mail],
  [#label[Office hours]], [By appointment],
)

= Syllabus

An introduction to machine learning from a probabilistic and theoretically driven perspective. The course follows the approach of the undergraduate statistics course (367-1-4361 Statistical Computation and Analysis), placing probabilistic modeling and Bayesian uncertainty propagation at the center. The focus is on how methods relate to each other and to the underlying model of the data.Conceptual development is accompanied by practical work in which students fit models, examine their predictions, diagnose common failures, and interpret uncertainty.

Topics include probability and statistical foundations; graphical models and Bayesian decision theory; entropy, KL divergence, and mutual information; automatic differentiation and stochastic optimization; generative and discriminative classification; logistic regression; ridge and lasso regression; splines and generalized additive models; generalized linear models; multilayer perceptrons; backpropagation; neural-network training and regularization; Bayesian neural networks; convolutional neural networks; calibration; out-of-distribution detection; and selective prediction.

Practical work will use Python within Colab, principally NumPy, SciPy, scikit-learn, PyMC, ArviZ, and PyTorch. Each weekly meeting combines a two-hour lecture with approximately one hour of notebook-based guided or independent work.

= Additional materials

1. Kevin P. Murphy, _Probabilistic Machine Learning: An Introduction_, MIT Press, 2022 (Book 1). #link("https://probml.github.io/pml-book/book1.html")[Online edition].
2. Kevin P. Murphy, _Probabilistic Machine Learning: Advanced Topics_, MIT Press, 2023 (Book 2). #link("https://probml.github.io/pml-book/book2.html")[Online edition].
3. Course slides, notebooks, exercises, project guidance, and supplementary readings will be distributed through the course site and the #link("https://github.com/opherdonchin/ProbabilisticMachineLearning")[public course repository].

The schedule identifies the sections used to prepare and support each lecture; it does not imply that every derivation or example in those sections will be presented in class.

= Prerequisites

There are no formal prerequisites. A background in mathematical probability, Bayesian statistics, linear algebra, regression, and Python programming will be helpful. Students who have not taken 367-1-4361 Statistical Computation and Analysis, or equivalent coursework, should consult the instructor before registering. Mathematical material will be refreshed and extended when it is needed in the course.

= Course requirements and grading

The course grade is based on four components:

#table(
  columns: (1fr, 34mm),
  inset: (x: 8pt, y: 6pt),
  stroke: 0.5pt + rule,
  align: (left, center),
  table.header(
    table.cell(fill: navy)[#text(font: "Noto Sans", weight: "bold", fill: white)[Component]],
    table.cell(fill: navy)[#text(font: "Noto Sans", weight: "bold", fill: white)[Contribution]],
  ),
  table.cell(fill: white)[AI-based tutoring], table.cell(fill: white)[10%],
  table.cell(fill: pale-blue)[Notebook submission], table.cell(fill: pale-blue)[10%],
  table.cell(fill: white)[Project presentation], table.cell(fill: white)[30%],
  table.cell(fill: pale-blue)[Final exam], table.cell(fill: pale-blue)[50%],
)


= Schedule

#lecture(
  1,
  [21.10.2026],
  [Probability and statistics review and extension],
  [Machine-learning tasks; probabilistic modeling; statistics and estimators; moments; MLE and MAP; Gaussian and multivariate Gaussian models; conditioning and linear Gaussian systems.],
  [Ch. 1; §§2.1--2.6, 3.1--3.3, 4.1--4.2 and 4.6.],
  [Ch. 1; §2.3.],
)

#lecture(
  2,
  [28.10.2026],
  [Graphical models and Bayesian decision theory],
  [Factorization and conditional independence; plate notation; graphical models as probabilistic abstractions; loss, utility, classification and probabilistic prediction.],
  [§§5.1--5.1.6.],
  [§§4.1, 4.2.1, 4.2.4, 4.2.8 and selected material from §4.5.1.],
)

#lecture(
  3,
  [04.11.2026],
  [Information theory for probabilistic prediction],
  [Entropy, cross-entropy, perplexity, KL divergence, forward and reverse KL, mutual information, sufficient statistics, and connections to likelihood and Bayesian inference.],
  [§§6.1.1--6.1.5, 6.2.1--6.2.2, 6.2.5--6.2.6, 6.3.1--6.3.4 and 6.3.8--6.3.9.],
  [§§2.7.1--2.7.2, 5.1.3, 5.1.6--5.1.8 and 5.3.3--5.3.4.],
)

#lecture(
  4,
  [11.11.2026],
  [Mathematical preparation for optimization],
  [Eigendecomposition and SVD as geometric tools; gradients, Jacobians and Hessians; computation graphs; local, global, convex and nonconvex optimization.],
  [§§7.4.1--7.4.4, 7.5.1--7.5.3, 7.8 and 8.1.],
  [§§6.2--6.2.2.],
)

#lecture(
  5,
  [18.11.2026],
  [Gradient-based model fitting],
  [First-order methods, learning rates, momentum, Newton's method as a conceptual contrast, stochastic gradient descent, automatic differentiation, and optimization of finite-sum objectives.],
  [§§8.2, 8.3.1 and 8.4.],
  [§§6.3.1--6.3.3.],
)

#lecture(
  6,
  [25.11.2026],
  [Generative classification],
  [Gaussian discriminant analysis; linear and quadratic decision boundaries; naive Bayes; generative versus discriminative modeling; missing features; scoring and calibration.],
  [§§9.1--9.2.5 and 9.3--9.4.],
  [§§14.1--14.2.2.],
)

#lecture(
  7,
  [02.12.2026],
  [Discriminative classification and Bayesian logistic regression],
  [Binary and multinomial logistic regression; MLE and MAP; standardization; class imbalance; priors; posterior approximation and posterior predictive probabilities.],
  [§§10.1--10.2.4, 10.2.7--10.2.8, 10.3.1--10.3.5 and 10.5.],
  [§§15.3.3--15.3.7.],
)

#lecture(
  8,
  [09.12.2026],
  [Regularized linear models and generalized linear models],
  [Ridge and lasso; sparsity and regularization paths; splines and generalized additive models; robust regression; multicollinearity; Bayesian shrinkage and variable selection; binomial and Poisson GLMs.],
  [§§11.3, 11.4.1--11.4.5, 11.5--11.6, 11.7.6--11.7.7 and 12.1--12.3.],
  [§§15.2.5--15.2.8.],
)

#lecture(
  9,
  [16.12.2026],
  [Multilayer perceptrons and backpropagation],
  [Nonlinear representations; activation functions; depth; forward and reverse differentiation; vector-Jacobian products; backpropagation and computation graphs.],
  [§§13.1--13.2.5 and 13.3.],
  [§§16.1, 16.2.1--16.2.2 and 16.3.1.],
)

#lecture(
  10,
  [23.12.2026],
  [Neural-network training, regularization and predictive uncertainty],
  [Learning rates; gradient pathologies; initialization; residual connections; early stopping; weight decay; dropout; overparameterization; MC dropout and deep ensembles as practical uncertainty methods.],
  [§§13.4.1--13.4.5, 13.5.1--13.5.5 and 13.5.7.],
  [§§17.2.1, 17.3.1 and 17.3.9--17.3.10.],
)

#lecture(
  11,
  [30.12.2026],
  [Convolutional neural networks],
  [Convolution, padding, stride and channels; pooling; normalization; residual and dropout layers; constructing and fitting a convolutional classifier.],
  [§§14.1 and 14.2.1--14.2.4.],
  [§§16.2.3--16.2.6 and 16.3.2.],
)

#lecture(
  12,
  [06.01.2027],
  [CNN architectures, image classification and uncertainty],
  [The progression from LeNet and AlexNet to Inception, ResNet and DenseNet; practical image classification; out-of-distribution inputs; selective prediction and the limits of predictive confidence.],
  [§§14.3.1--14.3.5, with particular emphasis on §14.3.4.],
  [§§17.4.6 and 19.3.2--19.3.3.],
)

#lecture(
  13,
  [13.01.2027],
  [Project presentations and course synthesis],
  [Student project presentations connecting probabilistic assumptions, computation, prediction, evaluation, uncertainty and scientific interpretation.],
  [No new sections; projects may draw on Chs. 1--14.],
  [No new sections; relevant previously assigned sections may be used.],
)
