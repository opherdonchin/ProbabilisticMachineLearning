# What the source inspection tells us

We read the textbooks and the candidate worked examples to check what they actually contain. We did not run their notebooks or test the proposed student adaptations. A reference is a starting point, not a ready-to-teach course lab.

The most useful findings are these. Murphy's image program uses methods that would need later mathematics, so L03 uses a simpler pixel-update method. The three-bit check code detects a single changed bit but cannot always correct it. The Gaussian missing-data program hides the learning updates that our students need to understand. Several other reference programs use software we are not requiring, or include more than one hour of work.

Some source claims also need care. A Gaussian posterior shortcut need not agree closely with a numerical reference. A noise standard deviation is not its variance. Two printed variational formulas have a sign/constant error; the course uses independently checked formulas. None of these is a choice the instructor needs to resolve—the authors must use the correct calculation.

The detailed record below lets authors reproduce the source checks. Long hashes are file identifiers: they show exactly which file was inspected. Local paths identify source inputs, not files students should be expected to find on their computers. Textbook excerpts are not copied into the repository. Inspection date: 2026-10-11.

## Textbooks

Book 2: December 10, 2025 online edition, confirmed by local PDF metadata/TOC and [official edition page](https://probml.github.io/pml-book/book2.html). Book 1 local MIT Press edition; subsection claims checked directly by builders. Extracted text is in /tmp solely for this run.

## Notebook inspection

pyprobml local HEAD: d1ea4122dcf3c2a2c02eb4e05343203b26440827
| Source | SHA256 inspected | Source-level limitations |
|---|---|---|
| [pyprobml book2/04/ising_image_denoise_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/04/ising_image_denoise_demo.ipynb) | `3d7a54f5c851c5de2efe196f9fa6cff8c82bdeb612c02137618fa8a0fdd4696e` | Uses sampling and distribution approximations that are taught later; the course instead improves one pixel at a time. |
| [pyprobml book2/05/error_correcting_code_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/05/error_correcting_code_demo.ipynb) | `b557bf8b97488541d1f11b88a6b92ad172b0f4d7501de8c92fe00f634ba04cd1` | The selected exercise lists the eight possible received words and computes message probabilities; it does not implement the source’s full message algorithm. |
| [pyprobml book2/opt/gauss_imputation_em_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/opt/gauss_imputation_em_demo.ipynb) | `302a3b8f3608a5edf526f033d811bb71831c96925c671cabf59baa84adf991fc` | The fitting helper hides the update. Students need to see expected values and products, including uncertainty about missing values. |
| [pyprobml book2/10/linreg_bayes_svi_hmc.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb) | `415b81857e37701258718392c3c05db9a903f768ab59a54b03f438f211c204a1` | Uses an additional library, economic data and a sampling comparison. The selected course exercise has a known exact answer and does not require an untaught sampler. |
| [pyprobml book2/12/mcmc_gmm_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb) | `22212380c2b54b9326454efe65a47853eb90e5150928f29e2ab4c8467e1f42e4` | Uses software outside the course requirement. The course needs a small NumPy implementation with the same accept/reject mathematics. |
| [pyprobml book1/13/mlp_1d_regression_hetero_tfp.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb) | `1e685b9e50518ab79a7448d6bfdcc27803596ae58a7ab1de9e1fbee7aeef37a6` | Uses TensorFlow Probability. The course needs a PyTorch version predicting a Gaussian mean and positive noise scale. |
| [pyprobml misc/vae_mnist_pytorch.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/vae_mnist_pytorch.ipynb) | `6ab2c4d9cf0c2dec6e475e073575899bc1ff856d09988ca87c8a654767e39bf0` | Uses a larger convolutional image model and multiple training cases; it is too much to adopt unchanged as an hour’s task. |
| [Reference batra-iris.ipynb](https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb) | `40a2d3387ffcbc14f599cf55bdfb91cb996e8886b9fa2e0cc1fe3f8f1f6aebb7` | Downloaded and read. Keep only the three-class Iris example, rather than the additional spiral and polynomial experiments. |
| [Reference berkeley-laplace.html](https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/) | `539be24de77588d434e7a52de238194cfafa8938f7bfe8590fba6eab36496c63` | Downloaded and read. Keep the scalar grid-versus-Gaussian comparison; the other approximations and larger example are outside L07. |

## Oke instructor materials located

PS2-Questions/CEE790A-PS2.tex inspected: Kalman website-session forecasting refers to PS2-Kalman-filter-forecasting and Kaggle/Forecastegy. Exact named solved notebook was not found in the local instructor solution directory; no reliability claim. HMM course-constructed fallback avoids data/platform dependency. No student submissions inspected.
PS4-Questions/CEE790A-PS4.tex, vae.ipynb and mobile-msa.csv are available locally. Source has 349 metropolitan statistical areas (MSAs), 19 selected variables, four latent dimensions, two 64-unit hidden layers and 300 training epochs. Its training score averages squared reconstruction error over features and a distribution-discrepancy penalty over hidden dimensions separately. These different averages change the meaning of the penalty weight, beta. Convert both parts to the course convention before comparing runs. Transforming all data together and showing correlations do not establish performance on new data, causal interpretation or uniquely meaningful hidden coordinates. Data redistribution and runtime remain unverified.
- `PS4/PS4-Questions/vae.ipynb` SHA256 `f99265bf611aed7698ee16be356ef6880815d1367a1a684d33897adef38d9c07`.
- `PS4/PS4-Questions/mobile-msa.csv` SHA256 `05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6`.
- `PS2/PS2-Questions/CEE790A-PS2.tex` SHA256 `838540ec8b1ff0d0718b34820046dfb69bfb1de44f74d3bfcb1be0f27c13da2e`.
- `PS4/PS4-Questions/CEE790A-PS4.tex` SHA256 `d89b8956b1d7e1d223df62a42c127ea3f6513bc6a0ec6f39ec92ddff310ecdba`.

## Exact mathematical checks for authors

- B2 §15.1.3 Eq. 15.35 differentiates the **log likelihood** (observed minus predicted); NLL reverses the sign and restores dispersion. Positive-semidefinite Hessian does not by itself imply a unique finite MLE: design rank and separation matter. Do not inherit the source paragraph's stronger uniqueness wording.
- B2 §10.2.1 printed p. 448 (PDF page 482) was rendered and visually inspected: Eqs. 10.49–10.50 contain a plus-KL sign and omit the Gaussian KL constant respectively; these are present in the PDF, not merely text-extraction artifacts. The scope must independently use ELBO = expected log likelihood **minus** KL and diagonal Normal KL = one half sum(mu² + sigma² − 1 − log sigma²). These are independently corrected mathematical expressions, with source discrepancies explicitly documented; no erroneous source formula is adopted as a teaching commitment.

- Berkeley scalar logistic reference source inspection: stored grid mean about 2.778 versus Laplace center about 2.523 contradicts close-agreement prose. L07 uses model/method provenance only, not a numerical accuracy guarantee. A finite grid is a truncation/discretization benchmark requiring domain, tail and resolution checks.

- L08 builder inspected pyprobml `notebooks/misc/casino_hmm.ipynb` SHA256 `975e90d6d095eed5e087121acd9094f57a176e270d76c6ebdbfcf6d312a18ed1`: JAX/Dynamax reference hides inference; proposed lab exposes NumPy forward/backward. No execution or code-port reliability claim.

- L11 builder checked the heteroskedastic reference: source noise is SD `s(x)=0.25+g(x)^2`, so variance is `s(x)^2`, not the same quadratic function. Future PyTorch heads/NLL must explicitly distinguish SD, variance and log variance. Source uses two Adam fits/500 epochs and a larger backbone; that is not a timed course-lab contract.

## Textbook file identifiers

Book 2 PDF SHA256: `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`.
Book 1 PDF SHA256: `89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf` (April 18, 2025 online edition as inspected by the builders).

In the formula checks above, NLL means negative log likelihood, MLE means maximum-likelihood estimate, and ELBO means evidence lower bound—the tractable probability bound explained in L06. KL is Kullback–Leibler discrepancy between distributions. These names are source lookup terms; the scopes explain their mathematical roles before using them.

## Recovered agreement as an authoritative input — 2026-10-12

The batch source inspection missed the existing instructor-agreed L03 scope on `lecture-3-authoring`. The instructor identified it in the current discussion; the coordinator fetched and inspected source commit `8007d42b2871181a6966ab4d55417c10af9b5544`, scope blob `0656648fd43374997469174a845418a802b3aefe`, together with its register and proposed section design. The restored scope, not the batch model choice alone, now owns the live/notebook boundary. Source/code correctness cautions above remain checking evidence, not additional required student tasks. The accepted scope’s secondary ICM reference is a candidate, not newly verified or adopted code.
