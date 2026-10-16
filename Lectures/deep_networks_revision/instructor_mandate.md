Course Coordinator: Implement the Two-Lecture Deep Networks Revision

Decision and mandate

We have completed a substantial discussion following your analysis of the existing L11 scope and Murphy’s Chapter 16.

The instructor has decided to replace L10 (Monte Carlo and MCMC) with a second lecture on deep neural networks.

The resulting sequence is:

* L09: Variational and amortized inference — retained, potentially adjusted.
* L10: Deep Neural Networks I — new scope.
* L11: Deep Neural Networks II — substantial expansion and restructuring of the existing scope.
* L12: Variational Autoencoders — retained, potentially adjusted to take advantage of the new neural-network preparation.

L07 (Inference Overview) and L08 (Structured Exact Inference) are also retained.

This architectural decision is settled. Do not reopen the comparison between sacrificing L07, L10, and L12 as a preliminary exercise. You may raise substantive objections if implementation reveals genuine problems, but proceed on the basis of the accepted decision.

Your task is to coordinate the redesign and implementation, attending equally to the breadth of its consequences across the course and the depth and quality of the affected lectures.

1. What our discussion established

Your original L11 analysis identified a fundamental mismatch between Murphy Chapter 16 and the provisional lecture.

The existing L11 develops one important example — heteroskedastic neural regression — into a complete probabilistic prediction problem. It provides useful mathematical and computational depth but covers only a narrow portion of Murphy’s intended treatment of deep neural networks.

We concluded that this was not simply a matter of adding a few slides or a brief reference to inference networks.

The course needs a more substantial treatment of the conceptual and mathematical contributions of neural networks, especially:

* Learned compositional representations, rather than simply nonlinear functions.
* Neural computation as a flexible way to parameterize probabilistic models.
* Architectural choices as assumptions about the structure of data and its relationships.
* Convolution, recurrence, attention, and other important mechanisms for exploiting structure.
* The distinction between networks used to construct probabilistic models and networks used to approximate inference.
* How these developments connect to the methods students have already learned.

A particularly important conclusion was that neural networks should be taught in the language of our existing course goals, rather than as a largely independent deep-learning unit.

By L10, students should already understand GLMs, optimization and autodiff, latent-variable learning, graphical structure, exact inference, and VI.

The neural-network sequence should build on that foundation, showing what new modeling and computational capabilities become available through learned representations and compositional architectures.

The two lectures should have distinct, complementary intellectual purposes and practical endpoints. Their detailed division remains your responsibility.

Do not automatically assume that the existing heteroskedastic regression example should dominate the first lecture, or that the second should be an architectural survey. Evaluate how to produce two strong, cohesive lectures with substantial mathematics and meaningful notebook exercises.

2. The curricular tradeoff we accepted

We considered sacrificing L07, L10, and L12 against all four course goals.

Our decision to sacrifice L10 reflects the following judgment:

The gain: Two substantial neural-network lectures make an important addition to the students’ modeling and computational repertoire. They address a genuine gap in the current course and prepare students more effectively for modern probabilistic machine learning.

The acceptable loss: Students will receive less graduate-level instruction in Monte Carlo and MCMC algorithms, particularly Metropolis–Hastings, proposal construction, mixing, and computational efficiency.

Students have already used NUTS, PyMC, and posterior diagnostics in undergraduate Bayesian statistics. This makes sacrificing L10 more acceptable than it would be for students without such preparation.

However, their experience using sampling software must not be confused with understanding sampling algorithms.

The protected strengths: Keeping L07 preserves the overarching framework for understanding probabilistic queries and computational strategies. Keeping L12 preserves a substantial application that combines neural networks, latent-variable models, variational inference, and information theory.

We therefore expect the revised course to preserve its probabilistic intellectual architecture while substantially strengthening its treatment of modern neural modeling.

3. The most important cross-course responsibility: sampling

Removing the dedicated MCMC lecture creates a genuine gap. Your responsibility is to determine how much of that gap needs to be addressed elsewhere.

Sampling still occurs at several points in the planned course, but serves different purposes.

In L02, students generate observations from a learned Markov model.

In L03, the Ising example may involve conditional sampling, although that is not yet equivalent to a systematic treatment of MCMC.

L07 introduces Monte Carlo as a strategy for approximating integrals and describes its place among alternative inference methods.

L09 may use Monte Carlo estimates inside VI, or compare VI with a sampling-based approximation.

L12 uses stochastic latent variables and sampling within neural generative modeling.

These uses must be distinguished carefully.

In particular, generating observations from a model, estimating expectations through random samples, and constructing a Markov chain targeting an intractable posterior are different computational competencies.

We agreed that retaining at least one meaningful posterior-sampling experience could be valuable, but did not specify how or where.

Please determine:

1. Which sampling concepts and practical competencies students genuinely need to retain for the course goals.
2. Which are already well covered by undergraduate prerequisites.
3. Which can be incorporated naturally into L07, L09, or another existing lecture.
4. What would have to be displaced to make that possible.
5. Which elements of the former L10 should be explicitly acknowledged as sacrificed.

Do not solve this problem by quietly inserting an additional mini-lecture into an already crowded unit.

Nor should you try to preserve the entire MCMC lecture through fragments scattered across the course.

A modest, coherent sampling contribution with a clear pedagogical purpose may be better than superficial preservation of multiple algorithms.

4. Apply the four course goals to the implementation

The accepted goals remain the guiding framework:

1. Understand learning problems as probability distributions and queries, often requiring integration.
2. Understand how the structure of the model and query determines the mathematical computation.
3. Understand how the specifics of a problem guide choices among available modeling and computational approaches.
4. Acquire a coherent, practically useful repertoire of modern probabilistic and neural methods.

Our discussion emphasized two important refinements.

Goal 3 concerns informed method selection, not merely comparing exact inference, VI, and MCMC.

Students should learn to recognize what aspects of the problem matter when choosing a computational approach.

Goal 4 concerns the quality and coherence of the toolkit, not the number of algorithms introduced.

Evaluate methods by their distinctive capabilities, applicability, dependencies, limitations, and what students can actually do with them.

Apply these goals throughout the redesigned course.

For instance, the neural-network lectures should help students understand why one might choose a CNN, recurrent architecture, transformer, or ordinary MLP for different kinds of probabilistic modeling tasks, and the implications of that choice.

The purpose is not to memorize architectures. It is to understand the modeling and computational assumptions underlying them.

5. Redesign at two levels simultaneously

Course-level continuity and coverage

Identify all material whose disposition changes because of the new L10–L12 sequence.

Review the affected material in L05–L12, and earlier lectures where they provide relevant conceptual or computational foundations.

In particular:

* Preserve the L05 GLM-to-neural-model progression.
* Examine L07’s role in explaining Monte Carlo and selecting inference methods.
* Ensure L09 provides the variational and stochastic-optimization preparation needed later.
* Design L10 and L11 as an integrated progression, not independent surveys.
* Ensure L12 exploits the stronger neural-network foundation rather than unnecessarily repeating it.
* Determine whether the information-theoretic return in L12 becomes more powerful or changes emphasis.
* Consider whether an earlier example, such as L02’s learned character Markov model, can provide a useful recurring application for neural sequence modeling.

For displaced material, explicitly distinguish substantive preservation, reduced coverage, brief acknowledgment, optional reading, and genuine omission.

Update the material ledger and associated curriculum records accordingly.

Lecture-level intellectual depth

Every affected lecture must remain a worthwhile and internally coherent educational unit.

Do not measure successful implementation by the presence of all intended topic names.

Each lecture should establish a clear central question, develop the mathematics needed to answer it, and culminate in a meaningful application.

For the new neural-network sequence, consider the relative roles of:

* The transition from GLMs and fixed features to learned representations.
* Functional composition and the consequences of depth.
* Backpropagation and training, building on L05 rather than repeating it unnecessarily.
* Modeling choices encoded by architectural structure.
* Parameter sharing, convolution, recurrence, attention, and residual architectures.
* Probabilistic output distributions, likelihoods, and conditional density estimation.
* Neural networks as approximate inference functions.
* Preparation for amortized inference and VAEs.

These are candidate elements, not a checklist to cram into two lectures.

Make reasoned selections. Teach the chosen ideas deeply enough for the students to understand them, including their mathematical and practical consequences.

Breadth in architectural understanding should not come at the expense of mathematical substance; depth in a single example should not obscure the general principle it illustrates.

6. Student notebooks and durable competencies

Reconsider the notebook progression as part of the redesign, not as an afterthought.

Each of the two neural-network lectures should have a substantial, distinct one-hour computational endpoint.

The existing heteroskedastic regression notebook is a candidate for retention or adaptation. Consider what complementary exercise would best establish the value of architectural structure and learned representations.

For example, a neural sequence model might provide a concrete contrast with earlier Markov modeling. Alternatively, convolution, attention, or a model-versus-inference comparison may support a better progression.

Choose based on educational value and feasibility rather than the attractiveness of a particular implementation.

The notebooks should build on the PyTorch competence established in L05, without introducing unnecessary software infrastructure.

The VAE notebook should benefit from the new preparation. If material previously required in L12 can now be developed in L10 or L11, consider using the recovered time for deeper investigation of the VAE’s probabilistic behavior rather than simply adding more content.

For each affected notebook, verify that the mathematical prerequisites are present, the task can realistically be completed in about an hour, and the student gains a durable computational skill.

7. Additional conceptual connection: Bayesian nonparametrics

The instructor briefly raised the possibility of relating deep networks to Bayesian nonparametric methods, particularly Chinese restaurant and related processes.

We discussed connections involving Indian buffet processes, infinitely wide neural networks, Gaussian processes, and uncertainty over model complexity.

This is not a course requirement, but may help clarify the distinction between flexible function approximation, representation learning, and Bayesian uncertainty over functions or model structures.

Evaluate it opportunistically if it genuinely improves the teaching argument.

Do not allow it to create new curricular obligations or distract from the accepted Chapter 16 objectives.

8. Your operational responsibilities

You are the Lecture Development Coordinator. Use the repository’s existing coordinator and specialist skills, approval procedures, development-state records, and backpressure mechanisms.

Proceed from the existing repository state and your previous L11 analysis. Do not begin an unnecessary new round of general curriculum exploration.

Coordinate the work in a sensible dependency order:

First, establish the revised course-wide contracts. Determine the implications of removing L10, the disposition of sampling material, and the mathematical dependencies among L07, L09, L10, L11, and L12. Update the relevant architectural and tracking artifacts.

Second, develop the lecture scopes. Design the two Chapter 16 lectures together so they form a coherent sequence. Revise affected surrounding scopes only to the extent necessary. Use the lecture-scope skill’s five-part contract and obtain the appropriate downstream feasibility checks.

Third, carry the approved scopes into detailed development. Coordinate Section Design, Slide-Level Organization, Slide Design, Slide Authoring, and student notebook development using the appropriate specialist skills.

Fourth, validate the full sequence. Check not only individual lecture quality but also the progression of mathematical ideas, practical competencies, computational tools, and learning objectives across lectures.

Preserve the repository’s conventions for Typst/Touying, figures, speaker notes, notebooks, and reviews.

Use the existing version-control and PR procedures, maintain provenance, and avoid disrupting delivered or approved material unnecessarily.

You have authority to make routine operational and implementation decisions and to commission the specialist work required to reach a complete result.

Do not repeatedly ask the instructor to reconsider settled choices. Consult the instructor when a genuinely consequential new pedagogical tradeoff arises, as required by the established workflow.

9. Success criteria

The revision is successful if it produces more than additional neural-network content.

Students should emerge with a substantially stronger understanding of what deep networks contribute to probabilistic machine learning and how architectural choices relate to model structure, computational strategy, and data characteristics.

At the same time, the course should retain its distinctive foundation in probabilistic formulation, mathematical structure, inference, and computational judgment.

The lost MCMC lecture must be accounted for honestly, with a deliberate choice about what sampling knowledge and competence survives.

The VAE lecture should become a stronger synthesis because students now have a deeper understanding of neural networks.

The revised set of lectures and notebooks should constitute a coherent toolkit rather than a sequence of individually interesting techniques.

Proceed to implementation. Treat the architectural decision as made, coordinate the necessary work across the course, and use the established development process to ensure depth, continuity, feasibility, and quality.