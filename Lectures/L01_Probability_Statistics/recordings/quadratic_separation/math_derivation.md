# Quadratic separation — complete provisional derivation

This checking source accompanies the provisional recording Section Design. It
provides all mathematical obligations for downstream implementation and independent
review; it is not a slide sequence or instructor approval. The accepted live
residual derivation and notebook remain independent of this recording.

## Assumptions and claim

Let $d_1,d_2\ge1$, $d=d_1+d_2$, and let $X\in\mathbb R^d$ have a nonsingular
Gaussian density with

$$
X=\begin{pmatrix}X_1\\X_2\end{pmatrix},\quad
\mu=\begin{pmatrix}\mu_1\\\mu_2\end{pmatrix},\quad
\Sigma=\begin{pmatrix}\Sigma_{11}&\Sigma_{12}\\
\Sigma_{21}&\Sigma_{22}\end{pmatrix}=\Sigma^T\succ0.
$$

Here $X_i,\mu_i\in\mathbb R^{d_i}$ and
$\Sigma_{ij}\in\mathbb R^{d_i\times d_j}$; in particular
$\Sigma_{21}=\Sigma_{12}^T$. We use the covariance-parameterized density

$$
\mathcal N_k(v;m,C)
=(2\pi)^{-k/2}(\det C)^{-1/2}
\exp\{-\tfrac12(v-m)^TC^{-1}(v-m)\},\qquad C\succ0.
$$

Define

$$
H=\Sigma_{22},\qquad B=\Sigma_{12}H^{-1},\qquad
S=\Sigma_{11}-BHB^T,
$$

where the existence of $H^{-1}$ is justified below. The claim is the pointwise
normalized equality, for every $x_1,x_2$,

$$
\mathcal N_d(x;\mu,\Sigma)
=\mathcal N_{d_1}(x_1;\mu_1+B(x_2-\mu_2),S)
 \mathcal N_{d_2}(x_2;\mu_2,H).
\tag{1}
$$

The proof establishes both the algebraic identity and the identification of the
right-hand factors as conditional and marginal densities. Gaussianity and strict
positive definiteness are the validity regime. Singular Gaussian measures are
outside this density argument; substituting a pseudoinverse alone would not
establish (1) as a Lebesgue-density equality.

## 1. Valid elimination and positive definite factors

For any nonzero $z\in\mathbb R^{d_2}$,

$$
z^THz=\begin{pmatrix}0\\z\end{pmatrix}^T
\Sigma\begin{pmatrix}0\\z\end{pmatrix}>0.
$$

Thus $H=H^T\succ0$ is invertible. Consequently $B$ is well defined and has size
$d_1\times d_2$. Since $H^{-1}$ is symmetric,

$$
BH=\Sigma_{12},\qquad HB^T=\Sigma_{21},\qquad
BHB^T=\Sigma_{12}H^{-1}\Sigma_{21}.
$$

In particular, $S=S^T$ is the Schur complement of $H$ in $\Sigma$. Write

$$
\Sigma=\begin{pmatrix}\Sigma_{11}&BH\\HB^T&H\end{pmatrix},
\qquad T=\begin{pmatrix}I_{d_1}&-B\\0&I_{d_2}\end{pmatrix}.
$$

The inverse $T^{-1}=\begin{pmatrix}I_{d_1}&B\\0&I_{d_2}\end{pmatrix}$ is verified
by multiplication in either order. Direct elimination gives

$$
T\Sigma
=\begin{pmatrix}\Sigma_{11}-BHB^T&BH-BH\\HB^T&H\end{pmatrix}
=\begin{pmatrix}S&0\\HB^T&H\end{pmatrix},
$$

and therefore

$$
D:=T\Sigma T^T
=\begin{pmatrix}S&0\\HB^T&H\end{pmatrix}
 \begin{pmatrix}I_{d_1}&0\\-B^T&I_{d_2}\end{pmatrix}
=\begin{pmatrix}S&0\\0&H\end{pmatrix}.
\tag{2}
$$

For every nonzero $w$, $T^Tw\ne0$, so
$w^TDw=(T^Tw)^T\Sigma(T^Tw)>0$. Hence $D\succ0$, and in particular
$S\succ0$ by testing $w=(a,0)^T$ for nonzero $a\in\mathbb R^{d_1}$.
Equivalently, the explicit test is

$$
a^TSa=\begin{pmatrix}a\\-B^Ta\end{pmatrix}^T
\Sigma\begin{pmatrix}a\\-B^Ta\end{pmatrix}>0.
$$

Every inverse and positive determinant used below is now justified. This step
uses strict positivity of the joint covariance, not an assumption that the two
original blocks are independent.

## 2. Inverse congruence and quadratic separation

Inverting (2) gives

$$
D^{-1}=T^{-T}\Sigma^{-1}T^{-1},
\qquad
\Sigma^{-1}=T^TD^{-1}T
=T^T\begin{pmatrix}S^{-1}&0\\0&H^{-1}\end{pmatrix}T.
\tag{3}
$$

Here $T^{-T}=(T^{-1})^T$. The order of the matrices in (3) follows by
multiplication by $T^T$ on the left and $T$ on the right; no commutation is used.
For a direct checking expression, multiplying (3) out gives

$$
\Sigma^{-1}
=\begin{pmatrix}
S^{-1}&-S^{-1}B\\
-B^TS^{-1}&H^{-1}+B^TS^{-1}B
\end{pmatrix}.
\tag{4}
$$

This is the $H$-Schur-complement orientation of the partitioned inverse. It is
derived here, rather than assumed or supplemented with another orientation.

Let $u=x_2-\mu_2$ and $r=x_1-\mu_1-Bu$. Then

$$
T(x-\mu)=\begin{pmatrix}r\\u\end{pmatrix}.
$$

Substituting (3) into the quadratic form yields

$$
\begin{aligned}
(x-\mu)^T\Sigma^{-1}(x-\mu)
&=[T(x-\mu)]^TD^{-1}[T(x-\mu)]\\
&=\begin{pmatrix}r\\u\end{pmatrix}^T
  \begin{pmatrix}S^{-1}&0\\0&H^{-1}\end{pmatrix}
  \begin{pmatrix}r\\u\end{pmatrix}\\
&=r^TS^{-1}r+u^TH^{-1}u.
\end{aligned}
\tag{5}
$$

Thus the exponential in the joint Gaussian is exactly the product of the two
exponentials. This alone does not yet establish normalized density equality.

## 3. Determinants and dimensions split the normalizer

$T$ is block upper triangular with identity diagonal blocks, so $\det T=1$.
Taking determinants in (2), using multiplicativity and
$\det T^T=\det T$, gives

$$
\det D=\det T\det\Sigma\det T^T=\det\Sigma.
$$

Since $D$ is block diagonal,

$$
\boxed{\det\Sigma=\det S\det H.}
\tag{6}
$$

All three determinants are positive. Taking their positive square roots is
therefore legitimate. With $d=d_1+d_2$,

$$
\begin{aligned}
(2\pi)^{-d/2}(\det\Sigma)^{-1/2}
&=(2\pi)^{-(d_1+d_2)/2}(\det S\det H)^{-1/2}\\
&=\big[(2\pi)^{-d_1/2}(\det S)^{-1/2}\big]
  \big[(2\pi)^{-d_2/2}(\det H)^{-1/2}\big].
\end{aligned}
\tag{7}
$$

Combining (5) and (7), the joint density is

$$
\begin{aligned}
p(x_1,x_2)
={}&\underbrace{(2\pi)^{-d_1/2}(\det S)^{-1/2}
 \exp\{-\tfrac12[x_1-(\mu_1+Bu)]^TS^{-1}[x_1-(\mu_1+Bu)]\}}
 _{g_1(x_1;x_2)}\\
&\quad\times
\underbrace{(2\pi)^{-d_2/2}(\det H)^{-1/2}
 \exp\{-\tfrac12(x_2-\mu_2)^TH^{-1}(x_2-\mu_2)\}}
 _{g_2(x_2)}.
\end{aligned}
\tag{8}
$$

These are the normalized Gaussian densities on the right of (1), with dimensions
$d_1$ and $d_2$ respectively. The first is Gaussian as a function of $x_1$ for
each fixed $x_2$; it generally depends on both blocks through its mean.

## 4. Identify the probability laws without circularity

For each fixed $x_2$, $g_1(\cdot;x_2)$ has SPD covariance $S$ and hence
integrates to one over $\mathbb R^{d_1}$. Integration of (8) therefore gives

$$
p(x_2)=\int_{\mathbb R^{d_1}}p(x_1,x_2)\,dx_1
=g_2(x_2)\int_{\mathbb R^{d_1}}g_1(x_1;x_2)\,dx_1
=g_2(x_2).
$$

Moreover $g_2(x_2)>0$ for every $x_2$, so the density ratio defines the
conditional law everywhere:

$$
p(x_1\mid x_2)=\frac{p(x_1,x_2)}{p(x_2)}
=g_1(x_1;x_2)
=\mathcal N_{d_1}(x_1;\mu_1+B(x_2-\mu_2),S).
$$

This proves (1) as $p(x_1,x_2)=p(x_1\mid x_2)p(x_2)$, with the marginal and
conditional independently identified by normalization. The conditional mean
changes with $x_2$, while its covariance $S$ is constant in $x_2$. This does not
assert independence of $X_1$ and $X_2$; the residual $r$ contains the observed
deviation. The proof used no covariance-to-independence argument from the live
route.

## Author checks and interpretation boundaries

The following is a checking specialization of the existing live example, not a
new dataset or required additional recording exercise. For $d_1=d_2=1$,
$\mu=0$ and $\Sigma=\begin{pmatrix}1&0.8\\0.8&1\end{pmatrix}$,
$H=1$, $B=0.8$, $S=0.36$, and $\det\Sigma=0.36=S H$.
At the live course observation $x_2=1.5$, (5) reads

$$
x^T\Sigma^{-1}x=\frac{(x_1-1.2)^2}{0.36}+2.25,
$$

and (1) gives $\mathcal N_2((x_1,1.5)^T;0,\Sigma)
=\mathcal N_1(x_1;1.2,0.36)\mathcal N_1(1.5;0,1)$.
This recovers the live conditional variance, with the second Gaussian argument
interpreted as covariance, not standard deviation. Murphy Book 1's corresponding
example uses observation $y_2=1$, so $1.5$ is explicitly the course choice.

This recording establishes an exact distributional identity under a supplied
Gaussian model. It does not establish model adequacy, estimate parameters or
demonstrate a new computational scaling benefit. Matrix inverse notation serves
the proof; practical evaluation may use linear solves, as the notebook already
does. These mathematical checks do not constitute independent review, a measured
duration or final instructor acceptance.

## Verified source record and attribution

Checked directly by `pdftotext -layout` from the local PDFs on 2026-10-17; PDF
page numbers below are one-based file pages. Copyright/title pages and dated page
footers establish the editions/online versions. No remote source was used.

| Source | Exact verified passage | Role and limit |
|---|---|---|
| Kevin P. Murphy, *Probabilistic Machine Learning: Advanced Topics*, MIT Press, 2023; online version December 10, 2025; local `Resources/book2-1.pdf` | §2.3.1.3 “Marginals and conditionals of an MVN,” printed p. 24 / PDF p. 58, Eqs. 2.75–2.78 | Block notation and marginal/conditional destination. |
| Same Book 2 version | §2.3.1.5 “Derivation: moment form,” begins printed p. 25 / PDF p. 59; Eq. 2.89 and Schur definition Eq. 2.91 on printed p. 26 / PDF p. 60 | Relevant $H$-Schur block-inverse orientation. The source displays a second orientation and Woodbury; neither is assigned here. |
| Same Book 2 version | §2.3.1.5, printed pp. 26–27 / PDF pp. 60–61; Eqs. 2.94–2.98, 2.100–2.103 | Factorized inverse/exponent, then stated normalized factorization and conditional parameters. The explicit elimination congruence, SPD justification, determinant/dimension split and normalization-integral identification above are course completions, not separately displayed Murphy derivations. No error in the selected moment-form identity was found. |
| Murphy, *Probabilistic Machine Learning: An Introduction*, MIT Press, 2022; online version April 18, 2025; local `Resources/book1.pdf` | §3.2.3 “Marginals and conditionals of an MVN *,” printed p. 84 / PDF p. 114, Eqs. 3.26–3.28; §3.2.4 “Example: conditioning a 2d Gaussian,” printed p. 85 / PDF p. 115, Eqs. 3.29–3.32 and observation $y_2=1$ | Supporting prior-result and scalar-example context. No precision/information-form coverage is imported. The course observation $1.5$ is distinct. |

The course proof follows the mathematical route represented in Murphy's inverse
and exponent displays, but proves the needed block inverse by congruence instead
of importing a general block-inverse lemma. Its explicit normalizer completion
supplies the missing displayed justification between kernel proportionality and
normalized equality. This is an attribution distinction, not a claim that the
book's final factorization is incorrect.

**Exact inspected artifact versions.** Worktree `/tmp/pml-l01-recording`, base
revision `196e5e5` as dispatched. SHA-256 values identify inspected inputs; they
are checking provenance, not a new approval record.

| Input | SHA-256 |
|---|---|
| `Resources/book2-1.pdf` (read from canonical repository) | `54d6bfa8cc4a367bb553bea1c5127ca63696a9655b2ca1f6137a8584dccfdbaf` |
| `Resources/book1.pdf` (read from canonical repository) | `89749245bc8065d7575f990815c621a091de3facca1585168fc0369542742dcf` |
| `recording_brief.md` in this directory | `73d00c177d321f7d9d32ef406d4060dcd98ad892893c44ef743962fb6c2d739f` |
| L01 `lecture_scope.md`, especially Part 2 recording contract | `a9ede9af5d9759ebc8d2e531298f31ad77b3845633751b24f035a2ad16dd96e3` |
| L01 `slide_deck.typ`, live Gaussian block/conditioning/residual/quadratic material | `b13a173b6432f901a9f1bfad9c4aa08163f6a9b506fe01ed50e6cec07c0730cc` |
| L01 `slide_deck.pdf`, inspected text of handout pp. 46–54 for that material | `2d12a7a69f6db9aa4813f2bc07b658d4e41fd7ef655aeca2a25718b1fb758a84` |
