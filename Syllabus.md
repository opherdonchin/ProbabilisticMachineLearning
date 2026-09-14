# Advanced Statistics 2027-1: Syllabus Basis

Working basis for developing the course syllabus and first lecture.

## Course Frame

The course will be based primarily on Kevin Murphy's *Probabilistic Machine Learning: Advanced Topics* and on Jimi Oke's Advanced Probabilistic Machine Learning course materials.

The main intellectual goal is to present machine learning as a coherent extension of probabilistic and statistical modeling, rather than as a collection of ad hoc algorithms.

The course should build naturally on the earlier Bayesian/statistics course. Students should see prediction, generation, and discovery as connected modeling tasks with shared probabilistic foundations.

## Teaching Constraint

Each lecture should stay within a single major course unit. We should not combine material from two different major units in one lecture.

This means that some units or internal topics must be dropped or compressed.

## Chosen Course Shape

We will use a 13-meeting structure:

- 12 content lectures
- 1 integration / project presentation / synthesis meeting

The selected mapping is Choice A: drop the final Decision unit and preserve the core ML arc.

## Lecture Mapping

| Lecture | Unit | Material | Murphy book chapters |
|---|---|---|---|
| 1 | Fundamentals | Probability + Bayesian statistics | Ch. 1, *Introduction*; Ch. 2, *Probability*; Ch. 3, *Statistics* |
| 2 | Fundamentals | Graphical models + information theory | Ch. 4, *Graphical Models*; Ch. 5, *Information Theory* |
| 3 | Fundamentals | Optimization | Ch. 6, *Optimization* |
| 4 | Inference | Gaussian filtering/smoothing + message passing | Ch. 7, *Inference Algorithms: An Overview*; Ch. 8, *Gaussian Filtering and Smoothing*; Ch. 9, *Message Passing Algorithms* |
| 5 | Inference | Variational inference | Ch. 10, *Variational Inference* |
| 6 | Inference | Monte Carlo + MCMC | Ch. 11, *Monte Carlo Methods*; Ch. 12, *Markov Chain Monte Carlo* |
| 7 | Prediction | GLMs + deep neural networks | Ch. 14, *Predictive Models: An Overview*; Ch. 15, *Generalized Linear Models*; Ch. 16, *Deep Neural Networks* |
| 8 | Prediction | Bayesian neural networks + Gaussian processes | Ch. 17, *Bayesian Neural Networks*; Ch. 18, *Gaussian Processes* |
| 9 | Generation | Generative modeling overview + VAEs | Ch. 20, *Generative Models: An Overview*; Ch. 21, *Variational Autoencoders* |
| 10 | Generation | Autoregressive models + GANs | Ch. 22, *Autoregressive Models*; Ch. 23, *Normalizing Flows*; Ch. 24, *Energy-Based Models*; Ch. 25, *Diffusion Models*; Ch. 26, *Generative Adversarial Networks* |
| 11 | Discovery | Latent factor models + state-space models | Ch. 27, *Discovery Methods: An Overview*; Ch. 28, *Latent Factor Models*; Ch. 29, *State-Space Models*; Ch. 30, *Graph Learning*; Ch. 31, *Nonparametric Bayesian Models* |
| 12 | Discovery | Representation learning + interpretable ML | Ch. 32, *Representation Learning*; Ch. 33, *Interpretability* |
| 13 | Integration | Project presentations / synthesis | — |

## Major Cut

The Decision unit is dropped from the main lecture sequence:

- Decision-making under uncertainty
- Reinforcement learning

This is the cleanest cut because it preserves the central sequence:

fundamentals -> inference -> prediction -> generation -> discovery

## Course Format

The likely weekly structure is:

- 2 hours lecture
- 1 hour notebook-based self-work or guided work

Notebooks should be central. They should help students actually use ideas in code and should make the course feel concrete and relevant to MSc-level biomedical engineering work.

The course should avoid becoming a heavy weekly problem-set course. Israeli students may resist large amounts of semester work and may focus strongly on exams.

## Assessment Direction

Still open, but current direction:

- modest checked notebook/class work
- one or two practical programming projects
- possibly an exam, depending on institutional and student expectations

The practical work should not collapse into generic classifier fitting. Ideally, projects should expose different modeling purposes, such as prediction and discovery or generation.

## Lecture 1 Development

Lecture 1 should be developed first as a diagnostic artifact.

It should help clarify:

- what the students need from the previous Bayesian/statistics course
- what probability and Bayesian material must be reviewed
- what can be assumed
- what notebook format and workflow will work for the course
- how much of Oke's material can be reused directly

Lecture 1 should probably be honest about the course frame:

This is a guided attempt to understand modern probabilistic machine learning as a coherent body of material, using Murphy as the spine and notebooks as the working medium.

## Open Questions

- Exact grading breakdown
- Whether the exam is required or merely useful
- Whether there will be one project or two
- Whether notebook work is done fully in class or partially submitted afterward
- How much mathematical derivation belongs in lecture versus notebook
- How explicitly to require Murphy reading
- What biomedical datasets or examples should anchor the practical work
