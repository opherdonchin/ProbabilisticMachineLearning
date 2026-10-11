# Source inspection register

Inspected source only, 2026-10-11. No notebook execution or Colab validation. Absolute local paths identify inspected inputs, not portable course dependencies. Textbook source excerpts are not copied into the repository. PDF SHA256: B2 `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf`; B1 `89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf` (April 18, 2025 online edition as inspected by builders).

## Textbooks

Book 2: December 10, 2025 online edition, confirmed by local PDF metadata/TOC and [official edition page](https://probml.github.io/pml-book/book2.html). Book 1 local MIT Press edition; subsection claims checked directly by builders. Extracted text is in /tmp solely for this run.

## Notebook inspection

pyprobml local HEAD: d1ea4122dcf3c2a2c02eb4e05343203b26440827
| Source | SHA256 inspected | Source-level limitations |
|---|---|---|
| [pyprobml book2/04/ising_image_denoise_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/04/ising_image_denoise_demo.ipynb) | `3d7a54f5c851c5de2efe196f9fa6cff8c82bdeb612c02137618fa8a0fdd4696e` | Gibbs/mean-field cannot be prerequisites in L03; course adaptation uses coordinate MAP. |
| [pyprobml book2/05/error_correcting_code_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/05/error_correcting_code_demo.ipynb) | `b557bf8b97488541d1f11b88a6b92ad172b0f4d7501de8c92fe00f634ba04cd1` | Adapt finite enumeration, not full message passing. |
| [pyprobml book2/opt/gauss_imputation_em_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/opt/gauss_imputation_em_demo.ipynb) | `302a3b8f3608a5edf526f033d811bb71831c96925c671cabf59baa84adf991fc` | EM hidden in probml_utils.gauss_fit_em; expose expected second moments. |
| [pyprobml book2/10/linreg_bayes_svi_hmc.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/10/linreg_bayes_svi_hmc.ipynb) | `415b81857e37701258718392c3c05db9a903f768ab59a54b03f438f211c204a1` | Pyro plus NUTS/VI, real external GDP data. Do not require Pyro or pre-L10 HMC. |
| [pyprobml book2/12/mcmc_gmm_demo.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book2/12/mcmc_gmm_demo.ipynb) | `22212380c2b54b9326454efe65a47853eb90e5150928f29e2ab4c8467e1f42e4` | JAX/TFP imports; NumPy port required, proposal mathematics retained. |
| [pyprobml book1/13/mlp_1d_regression_hetero_tfp.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/book1/13/mlp_1d_regression_hetero_tfp.ipynb) | `1e685b9e50518ab79a7448d6bfdcc27803596ae58a7ab1de9e1fbee7aeef37a6` | TFP implementation; port conditional Normal to PyTorch. |
| [pyprobml misc/vae_mnist_pytorch.ipynb](https://github.com/probml/pyprobml/blob/d1ea4122dcf3c2a2c02eb4e05343203b26440827/notebooks/misc/vae_mnist_pytorch.ipynb) | `6ab2c4d9cf0c2dec6e475e073575899bc1ff856d09988ca87c8a654767e39bf0` | Large CNN/multiple training cases; not a 60-minute turnkey lab. |
| [Reference batra-iris.ipynb](https://github.com/nipunbatra/pytorch-basics/blob/main/notebooks/04-softmax-regression.ipynb) | `40a2d3387ffcbc14f599cf55bdfb91cb996e8886b9fa2e0cc1fe3f8f1f6aebb7` | Downloaded and inspected; includes longer softmax/spiral/polynomial catalogue. Extract Iris only. |
| [Reference berkeley-laplace.html](https://stat238.berkeley.edu/spring-2026/codelecturethirtysix238spring2026/) | `539be24de77588d434e7a52de238194cfafa8938f7bfe8590fba6eab36496c63` | Downloaded and inspected; VI/Laplace/MH scalar plus frogs example. Extract scalar grid/Laplace only. |

## Oke instructor materials located

PS2-Questions/CEE790A-PS2.tex inspected: Kalman website-session forecasting refers to PS2-Kalman-filter-forecasting and Kaggle/Forecastegy. Exact named solved notebook was not found in the local instructor solution directory; no reliability claim. HMM course-constructed fallback avoids data/platform dependency. No student submissions inspected.
PS4-Questions/CEE790A-PS4.tex, vae.ipynb and mobile-msa.csv are available locally. Source has 349 MSAs, 19 selected variables, four latent dimensions, two 64-unit hidden layers and 300 training epochs. Its loss separately averages MSE over features and KL over latent dimensions; beta is not immediately comparable to a per-observation summed ELBO. Normalize explicitly before a course adaptation. Full-data scaling and descriptive correlation plots are not evidence of held-out prediction, causality or identified latent factors. Data redistribution and runtime remain unverified.
- `PS4/PS4-Questions/vae.ipynb` SHA256 `f99265bf611aed7698ee16be356ef6880815d1367a1a684d33897adef38d9c07`.
- `PS4/PS4-Questions/mobile-msa.csv` SHA256 `05e02113771a0ab550a9e7a0098d099ee348820564b68bcdc6c71a28b24418d6`.
- `PS2/PS2-Questions/CEE790A-PS2.tex` SHA256 `838540ec8b1ff0d0718b34820046dfb69bfb1de44f74d3bfcb1be0f27c13da2e`.
- `PS4/PS4-Questions/CEE790A-PS4.tex` SHA256 `d89b8956b1d7e1d223df62a42c127ea3f6513bc6a0ec6f39ec92ddff310ecdba`.

## Source-reading cautions for builders/reviewers

- B2 §15.1.3 Eq. 15.35 differentiates the **log likelihood** (observed minus predicted); NLL reverses the sign and restores dispersion. Positive-semidefinite Hessian does not by itself imply a unique finite MLE: design rank and separation matter. Do not inherit the source paragraph's stronger uniqueness wording.
- B2 §10.2.1 printed p. 448 (PDF page 482) was rendered and visually inspected: Eqs. 10.49–10.50 contain a plus-KL sign and omit the Gaussian KL constant respectively; these are present in the PDF, not merely text-extraction artifacts. The scope must independently use ELBO = expected log likelihood **minus** KL and diagonal Normal KL = one half sum(mu² + sigma² − 1 − log sigma²). These are independently corrected mathematical expressions, with source discrepancies explicitly documented; no erroneous source formula is adopted as a teaching commitment.

- Berkeley scalar logistic reference source inspection: stored grid mean about 2.778 versus Laplace center about 2.523 contradicts close-agreement prose. L07 uses model/method provenance only, not a numerical accuracy guarantee. A finite grid is a truncation/discretization benchmark requiring domain, tail and resolution checks.

- L08 builder inspected pyprobml `notebooks/misc/casino_hmm.ipynb` SHA256 `975e90d6d095eed5e087121acd9094f57a176e270d76c6ebdbfcf6d312a18ed1`: JAX/Dynamax reference hides inference; proposed lab exposes NumPy forward/backward. No execution or code-port reliability claim.

- L11 builder checked the heteroskedastic reference: source noise is SD `s(x)=0.25+g(x)^2`, so variance is `s(x)^2`, not the same quadratic function. Future PyTorch heads/NLL must explicitly distinguish SD, variance and log variance. Source uses two Adam fits/500 epochs and a larger backbone; that is not a timed course-lab contract.
