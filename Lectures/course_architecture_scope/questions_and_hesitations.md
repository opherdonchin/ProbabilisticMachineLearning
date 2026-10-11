# Teaching choices for instructor review

This file explains the choices in the proposed course. It assumes familiarity with probability and the material through lectures 3–4. You do not need to know Murphy's later chapters to read it.

The instructor has agreed to the simpler image-restoration method in L03 and chosen the lighter coding example in L04. Those decisions are recorded below. The remaining choices are still proposals. The instructor has paused further decisions while the documents are rewritten; nothing here asks for an immediate answer. [Review records and exact versions](STATUS.md) are available separately.

## L03 — Restore an image by improving one pixel at a time

**Decision agreed:** Use the simpler method, even though it differs from Murphy's algorithm.

Imagine a noisy black-and-white image. We give a proposed clean image a score that rewards agreement with the observations and agreement between neighboring pixels. Students work out how to update one pixel while holding its neighbors fixed. Repeating this operation gives an accessible connection between the graph, the probability model and an actual computation.

The limitation is easy to state: the algorithm can get stuck at an image where no single-pixel change helps, even though changing several pixels would produce a better image. A tiny example demonstrates this. We therefore describe the output as an improved candidate image, rather than claiming it is the best possible image or a description of all posterior uncertainty.

Murphy's methods use sampling or approximate probability distributions. Their mathematical explanation belongs later in the course. The simpler choice keeps L03 focused on understanding how a graph makes local calculations possible. [L03 scope](../L03_Graphical_Models/lecture_scope.md).

## L04 — Add one check bit to a two-bit message

**Decision selected:** Use the lighter example. Reference a stronger error-correcting code rather than making it the required exercise.

Suppose we want to send two bits. We append a third bit that says whether the first two differ. The receiver can check whether the three received bits satisfy this rule. If exactly one bit changes during transmission, the check fails. This detects the error, but does not tell us which bit changed: several original messages can explain the same received result.

Students can still calculate the probability of each possible message and make a best guess. Ties and mistaken guesses are part of the lesson. The example illustrates the difference between detecting a problem, extracting useful information and guaranteeing a correct decision. The stronger five-bit construction can correct any single-bit error, but costs more transmission and more classroom explanation.

We will keep the lighter model mathematically honest: it is a valid model with a limited guarantee, rather than an incorrect claim of guaranteed correction. This choice reduces the calculation from 32 possible received strings to eight. [L04 scope](../L04_Information_Theory/lecture_scope.md).

## L05 — Learn both a model and the machinery for fitting it

**Important teaching choice still open:** Is this combined first encounter manageable?

Linear regression predicts a numerical outcome. Logistic regression predicts the probability of a yes/no outcome. A Poisson model predicts a count. L05 explains how these share a common structure, called a generalized linear model, and how to change the model's parameters to improve its fit.

Students also encounter automatic differentiation: software follows a calculation and computes its derivatives. PyTorch is the new library used for this. The notebook fits a model that assigns probabilities to the three Iris flower species. Students compare a hand-calculated derivative with the software's answer, then make repeated parameter updates.

**Current proposal:** Keep one common derivation and one complete example of automatic differentiation. Provide the data preparation and plotting code. Do not require students to learn a large software framework or derive the same result separately for each distribution.

**Tradeoff:** This supports the neural-network lectures later, but combines new mathematics and new software in one meeting. We estimate 115 minutes of lecture, including time for questions, plus a 60-minute notebook; neither has been timed with students. Extra model examples and optional penalty calculations should be removed first if the lecture is too full. Separating the topics into two meetings would require replacing another lecture. [L05 scope](../L05_GLM_Optimization/lecture_scope.md).

## L06 — Learn a distribution when some measurements are missing

**Choice still open:** Use missing measurements, or use medical-image tissue classification?

In L01, students inferred missing measurements when the Gaussian model was already known. L06 asks a harder question: how do we estimate the model itself from incomplete records?

The proposed method alternates between estimating the missing quantities using the current model and updating the model using those estimates. This is expectation-maximization, usually called EM. Importantly, we must retain uncertainty about a missing value. Simply filling every blank with a best guess gives the wrong calculation for learning the covariance.

**Current proposal:** Make this the single worked application and notebook. It builds directly on L01, so the new difficulty is the learning method. Briefly explain how the same idea assigns observations to possible groups.

**Alternative and cost:** Use a mixture of Gaussians to separate types of tissue in an MRI image. That gives a stronger biomedical application but adds data preparation and group-assignment calculations. It should replace the missing-data lab, rather than become a second required lab. [L06 scope](../L06_EM/lecture_scope.md).

## L07 — Check how much a convenient posterior approximation loses

**Choice still open:** Keep a small example where the answer can be checked thoroughly?

A posterior may be awkward to integrate. One shortcut replaces its shape near its highest point by a Gaussian; this is the Laplace approximation. It can be useful without being accurate everywhere.

**Current proposal:** Use a logistic model with just one unknown parameter. Students calculate the posterior on a fine grid and compare it with the Gaussian shortcut. They check both parameter summaries and predictions. They also widen the grid and make its spacing finer, because a numerical comparison is only convincing if the reference calculation is itself reliable.

**Tradeoff:** The small model makes errors visible and keeps the lesson focused. It does not show how the shortcut behaves in a large real-data problem. A bigger example would need a less easily checked reference and more code. [L07 scope](../L07_Inference/lecture_scope.md).

## L08 — Infer hidden categories or forecast a continuous time series?

**Important teaching choice still open:** Which should be the main sequence application?

One example is a sequence of die rolls where the die sometimes changes from fair to loaded. We see the rolls but not which die was used. A hidden Markov model represents this: a hidden state changes over time and produces observations. Students calculate the probability of each hidden state using observations before and after that time. Reusing intermediate calculations avoids listing every possible history.

A different example follows a continuously changing quantity, such as website traffic. A Kalman filter repeatedly predicts its next value and updates that prediction when a noisy measurement arrives. This builds on Gaussian conditioning from L01.

**Current proposal:** Teach the discrete hidden-state calculation in depth and make it the notebook. Explain the Gaussian filtering connection briefly.

**Alternative and cost:** Make Kalman forecasting the main application and shorten the discrete example. This is a coherent alternative, but it changes the mathematics students practise. The current proposal does not deliver the previously preferred forecasting lab. Teaching and implementing both fully would exceed the hour available. The forecasting questions and data were located; the named worked solution was not found. [L08 scope](../L08_Structured_Inference/lecture_scope.md).

## L06–L11 — Small checkable examples or more real-data applications?

**Shared teaching choice still open:** Are we comfortable with the amount of deliberately simple data?

The proposed examples make it possible to tell whether the mathematics and code are right. For instance, in L09 we know the exact regression posterior and can see what a simpler approximation misses. L11 uses simulated data whose noise level is known, so we can assess the model's learned uncertainty.

The cost is less exposure to messy applications. The current course gives up the MRI lab, the Kalman forecasting lab and a regression application using economic data. L12 retains a real metropolitan-mobility dataset.

**Current proposal:** Keep the small checkable examples as the main progression. If one real-data application is especially important, replace the corresponding notebook and review its workload. Adding all discarded applications would require more time or removing methods elsewhere. This is a choice about the experience we want students to have, rather than a question about whether the algorithms are valid.

## L09 — Fit a simple distribution to approximate a difficult posterior

**Choice still open:** Use a regression case with a known answer?

Variational inference approximates a posterior by fitting a simpler probability distribution. Here we restrict that approximation to a Gaussian with independent coordinates. This makes calculations easier, but it cannot reproduce posterior correlations.

**Current proposal:** Use a regression model whose exact posterior is available. Students fit the simpler distribution and distinguish two failures: the fitting algorithm might not have reached its target, or the chosen distribution might be incapable of representing the answer. PyTorch computes derivatives through the random-sample calculation; the lecture explains why that is legitimate.

**Alternative and cost:** Real economic data with an unknown noise level would be more realistic, but the answer becomes harder to check. Comparing against a sampling method before L10 would also require teaching that method early. [L09 scope](../L09_Variational_Inference/lecture_scope.md).

## L10 — Show why correct sampling can still give poor estimates

**Choice still open:** Keep the simplest sampling algorithm as the main implementation?

When integrals are difficult, we can estimate them by averaging samples. A Markov-chain sampler generates each sample from the preceding one. The proposed Metropolis–Hastings algorithm proposes a move and accepts or rejects it using a probability chosen to preserve the target distribution.

A correct rule does not mean a short run has explored the distribution well. On a distribution with two separated peaks, the samples can stay in one peak for a long time. Estimates of the average or the probability of being in the other peak can then be poor.

**Current proposal:** Have students implement this rule and compare proposal sizes and starting points. Explain the principle of Hamiltonian Monte Carlo—a method that uses derivative information to make longer, directed moves—without deriving or implementing it fully.

**Alternative and cost:** A full Hamiltonian treatment would add equations of motion, a numerical integrator and its acceptance correction. It would require replacing part of the present theory and practical comparison. [L10 scope](../L10_MCMC/lecture_scope.md).

## L11 — Learn both a prediction and its observation noise

**Choice still open:** Make this the first neural-network application?

A neural network replaces a fixed linear prediction rule with a flexible nonlinear one learned from data. The proposed model outputs both a predicted mean and a positive standard deviation. It can therefore learn that observations are more variable in some regions than others.

**Current proposal:** Fit one small network and compare it with a supplied simpler model. Students evaluate predicted probabilities as well as prediction error. The intervals describe variation of observations around the fitted prediction. They do not include uncertainty about the fitted network parameters themselves.

**Alternative and cost:** A Bayesian neural network could represent parameter uncertainty too, but needs another inference problem and more computation. Image-classification architectures would offer a different practical application, but lose the direct connection to Gaussian models and the final lecture. [L11 scope](../L11_Neural_Prediction/lecture_scope.md).

## L12 — Describe mobility data using a few hidden coordinates

**Important teaching choice still open:** Is this a suitable final application, with its limitations stated clearly?

A variational autoencoder learns two connected networks. One describes each observation by a small distribution over hidden coordinates. The other uses those coordinates to predict the observation. Training balances faithful reconstruction against keeping the hidden distributions close to a chosen reference distribution.

**Current proposal:** Use 19 metropolitan-mobility measurements and four hidden coordinates. Students complete the central probability calculation and train one small model. Supplied comparison runs show what happens when we change the balance between reconstruction and the restriction on hidden coordinates.

**Limitations:** We approximate the transformed measurements by Gaussian distributions, although not all original quantities have Gaussian form. The hidden coordinates can summarize patterns, but we cannot claim they reveal unique causes or automatically correspond to meaningful independent factors. A nonzero training penalty alone does not prove they carry useful information about observations.

**Alternatives and cost:** Synthetic or openly available data may be easier to distribute but would change the practical application. Modeling each type of measurement more faithfully would add several likelihoods and more code. Data access and permission to distribute the current dataset still need checking before a student release. [L12 scope](../L12_VAE/lecture_scope.md).

## Work the authors must do, rather than questions for the instructor

The authors must keep the formulas, probability conventions and software checks correct. Among other things, they must count data and penalty terms consistently, distinguish standard deviation from variance, and compare reconstruction errors using the same definition. These are not pedagogical decisions for you to settle. Details are in the [notebook checks](../notebook_reference_audit.md) and [source records](source_inspection.md).

The lecture budgets are estimates. Future notebook authors must provide the promised setup and helper code, then check clean execution locally and in Google Colab and try the tasks within an hour. None of those notebook runs or student timing trials has been done in this scope-writing phase. L01/L02's established material remains unchanged.

## The main decisions left for later

The most consequential remaining choices are whether L05 combines too much new material, whether L08 should instead prioritize Kalman forecasting, how much realistic data we want across the course, and whether the L12 mobility application is appropriate and distributable.

The course also leaves out other substantial subjects. Examples include particle methods for tracking a changing hidden state, Bayesian neural networks that quantify uncertainty about weights, Gaussian-process prediction, and other ways of building generative models. These are worthwhile topics, but each would need to replace something in the 13-meeting plan. The [course overview](architecture_audit.md) explains the chosen progression and gives the detailed book map separately.
