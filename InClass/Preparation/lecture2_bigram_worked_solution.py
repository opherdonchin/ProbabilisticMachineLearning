"""Teacher-only L02 worked solution: fit / inspect / score / generate baby names.

Run with the course uv interpreter (NumPy 2.0.2). The default downloads one
hash-checked, immutable names file to /tmp, then works entirely in memory.
An existing copy can be supplied with --names-path; its hash is also checked.

Reference: Karpathy's makemore_part1_bigrams.ipynb, file commit
56eda75ed81390151aa72466f1b78022ad2eb574. This course implementation retains
count-based fitting, uses NumPy, and fits the UNSMOOTHED MLE. It does not copy
the reference's add-one estimator, neural model, or gradient training.

Model: '.' is the fixed start context and the terminal symbol. For a name
x_1...x_L, p(name | start='.', A) = A[.,x_1] ... A[x_L,.]. Generation stops
at the first terminal draw; no transition leaves that terminal occurrence.
The initial distribution is a point mass on the start context, not a new fit.
Each source line has equal weight: the file does not retain birth frequencies.
"""

import argparse
from collections import Counter
import hashlib
import math
from pathlib import Path
import platform
from urllib.request import urlopen

import numpy as np


DATA_COMMIT = "8f79bd0126eaef5eb82d346c9f85ae20ea1c476a"
DATA_SHA256 = "0a30b5557f192f32ab962680889aac5f6fda0f4cecf40a6d0b5694f58ea8cc4d"
DATA_URL = f"https://raw.githubusercontent.com/karpathy/makemore/{DATA_COMMIT}/names.txt"
DEFAULT_DATA_PATH = Path("/tmp/pml-l02-bigram") / f"names-{DATA_COMMIT}.txt"
SEED = 2147483647
MAX_CHARACTERS = 80


def read_names(path=None):
    """Infrastructure only: fetch/cache pinned bytes, or read a supplied copy."""
    destination = DEFAULT_DATA_PATH if path is None else Path(path)
    if destination.exists():
        raw = destination.read_bytes()
    elif path is not None:
        raise FileNotFoundError(destination)
    else:
        with urlopen(DATA_URL, timeout=30) as response:
            raw = response.read()
    digest = hashlib.sha256(raw).hexdigest()
    if digest != DATA_SHA256:
        raise ValueError(f"Data hash mismatch: expected {DATA_SHA256}, got {digest}")
    if not destination.exists():
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_bytes(raw)
    names = raw.decode("utf-8").splitlines()
    if not names or any(not name or not name.isascii() or not name.islower()
                        or not name.isalpha() for name in names):
        raise ValueError("Expected nonempty lowercase ASCII names, one per line")
    return names, destination


def main(names_path=None):
    names, data_path = read_names(names_path)
    print(f"Python {platform.python_version()}; NumPy {np.__version__}")
    print(f"Data: {data_path}; sha256={DATA_SHA256}")
    total_characters = sum(map(len, names))
    print(f"Names={len(names)}; letters={total_characters}; "
          f"length range={min(map(len, names))}..{max(map(len, names))}")

    # FIT. Rows are preceding symbols, columns are next symbols. '.' has two
    # roles at different occurrences: fixed start context and terminal draw.
    alphabet = "." + "".join(sorted(set("".join(names))))
    stoi = {symbol: index for index, symbol in enumerate(alphabet)}
    K = len(alphabet)
    N = np.zeros((K, K), dtype=np.int64)
    for name in names:
        sequence = "." + name + "."
        for previous, following in zip(sequence, sequence[1:]):
            N[stoi[previous], stoi[following]] += 1

    # Conditional-on-start log likelihood:
    # ell(A) = sum_{j,k} N[j,k] log A[j,k], with each row summing to one.
    # The categorical MLE is A_hat[j,k] = N[j,k]/N_j when N_j > 0.
    # A zero-count row is unidentified: leave NaN, never silently normalize it
    # to zeros or replace it by a uniform/smoothed row.
    N_j = N.sum(axis=1, keepdims=True)
    A_hat = np.full((K, K), np.nan, dtype=np.float64)
    np.divide(N, N_j, out=A_hat, where=N_j > 0)
    unidentified = [alphabet[j] for j in np.flatnonzero(N_j[:, 0] == 0)]
    if unidentified:
        raise ValueError(f"Unidentified MLE rows: {unidentified}; scoring/generation needs a declared model")
    np.testing.assert_allclose(A_hat.sum(axis=1), 1.0, rtol=0, atol=1e-14)
    assert np.all(A_hat >= 0)

    # Data checks use an independent Counter representation, not just matrix
    # sums: they include starts and ends and do not join separate source lines.
    direct_counts = Counter()
    for name in names:
        direct_counts.update(zip("." + name, name + "."))
    for j, previous in enumerate(alphabet):
        for k, following in enumerate(alphabet):
            assert N[j, k] == direct_counts[previous, following]
    assert int(N.sum()) == total_characters + len(names)
    assert int(N[0].sum()) == int(N[:, 0].sum()) == len(names)
    assert N[0, 0] == 0  # no empty names, no terminal-to-start transition
    # In the fitted matrix, expected next-symbol counts reproduce observations.
    np.testing.assert_allclose(N_j * A_hat, N, rtol=0, atol=1e-11)

    # INSPECT. Show actual count/probability pairs for the most likely outcomes
    # in three contexts, plus all row totals. Sorting breaks ties alphabetically.
    print(f"Alphabet={alphabet}; matrix shape={N.shape}; transitions={int(N.sum())}")
    print("Row totals: " + ", ".join(f"{ch}:{int(N_j[j, 0])}" for j, ch in enumerate(alphabet)))
    print("Rows = previous symbol; columns = next symbol. '.' means END in a column.")
    for previous in ".aq":
        j = stoi[previous]
        top = np.argsort(-A_hat[j], kind="stable")[:5]
        print(f"After {previous!r} (N_j={N_j[j, 0]}): " + "; ".join(
            f"{alphabet[k]!r}: count={N[j, k]}, p={A_hat[j, k]:.8f}" for k in top))

    # SCORE. Omit zero-count terms to implement 0 log 0 = 0 in the likelihood.
    positive = N > 0
    train_log_likelihood = float(np.sum(N[positive] * np.log(A_hat[positive])))
    train_mean_nll = -train_log_likelihood / int(N.sum())
    # Independent, direct per-name factorization must give the same likelihood.
    direct_log_likelihood = 0.0
    for name in names:
        for previous, following in zip("." + name, name + "."):
            direct_log_likelihood += math.log(A_hat[stoi[previous], stoi[following]])
    np.testing.assert_allclose(direct_log_likelihood, train_log_likelihood, rtol=0, atol=1e-6)
    print(f"Training log likelihood={train_log_likelihood:.10f} nats")
    print(f"Training mean negative log score={train_mean_nll:.10f} nats/transition (includes start/end)")
    print("These are in-sample fit summaries, not held-out predictive performance.")
    # The likelihood above varies A for fixed data. The scores below fix A and
    # vary the name; they include termination and do not condition on its length.
    for name in ["emma", "olivia", "andrej", "zzyzx"]:
        factors = [A_hat[stoi[p], stoi[f]] for p, f in zip("." + name, name + ".")]
        probability = math.prod(factors)
        log_score = sum(math.log(p) for p in factors) if all(p > 0 for p in factors) else -math.inf
        np.testing.assert_allclose(math.exp(log_score), probability, rtol=1e-13, atol=0)
        print(f"Name={name!r}: p={probability:.12g}; log score={log_score:.10f} nats; "
              f"mean NLL={-log_score / len(factors):.10f} nats/transition")
    # Author-owned support check using an actually unobserved letter bigram.
    # No epsilon repair: its name probability is 0 and log score is -infinity.
    j, k = np.argwhere(N[1:, 1:] == 0)[0] + 1
    zero_name = alphabet[j] + alphabet[k]
    zero_factors = [A_hat[stoi[p], stoi[f]] for p, f in zip("." + zero_name, zero_name + ".")]
    assert math.prod(zero_factors) == 0
    zero_log_score = -math.inf if any(p == 0 for p in zero_factors) else sum(map(math.log, zero_factors))
    assert zero_log_score == -math.inf
    print(f"Support check: {zero_name!r} contains unobserved {alphabet[j] + alphabet[k]!r}; p=0; log score=-inf")
    print("An out-of-alphabet character is outside this model's sample space; reject it rather than index a row.")

    # TERMINATION. Row normalization alone is insufficient for variable-length
    # names. In these actual data, every letter has a positive END probability.
    # If delta=min_j A[j,END]>0 over letters, surviving m further draws has
    # probability <=(1-delta)^m, which tends to zero. Thus termination is almost
    # sure. An absorbing-chain linear solve is a numerical cross-check only.
    end_probabilities = A_hat[1:, 0]
    delta = float(end_probabilities.min())
    assert delta > 0
    Q = A_hat[1:, 1:]
    termination_probabilities = np.linalg.solve(np.eye(K - 1) - Q, end_probabilities)
    np.testing.assert_allclose(termination_probabilities, 1.0, rtol=0, atol=1e-12)
    mass_of_finite_names = A_hat[0, 0] + A_hat[0, 1:] @ termination_probabilities
    np.testing.assert_allclose(mass_of_finite_names, 1.0, rtol=0, atol=1e-12)
    print(f"Minimum letter-to-END probability={delta:.10f}; finite-name mass={mass_of_finite_names:.15f}")

    # GENERATE. The same count-fitted rows choose the next symbol. The cap is a
    # computing guard: report a censored prefix if hit, never pretend it ended.
    # PCG64 and seed are explicit; this NumPy stream does not match Torch's.
    rng = np.random.Generator(np.random.PCG64(SEED))
    generated = []
    print(f"Generated names: PCG64 seed={SEED}; cap={MAX_CHARACTERS} letters")
    for _ in range(12):
        current = 0
        output = []
        for _ in range(MAX_CHARACTERS + 1):
            following = int(rng.choice(K, p=A_hat[current]))
            if following == 0:
                generated.append(("".join(output), True))
                print(f"  {''.join(output)!r} [END]")
                break
            if len(output) == MAX_CHARACTERS:
                generated.append(("".join(output), False))
                print(f"  {''.join(output)!r} [CENSORED: next draw was not END]")
                break
            output.append(alphabet[following])
            current = following
    print("PASS: pinned data, independent counts, boundaries, row MLE, likelihood equivalence, support and termination.")
    # Retain arrays and values for teacher inspection and independent checks.
    return dict(names=names, alphabet=alphabet, N=N, N_j=N_j, A_hat=A_hat,
                train_log_likelihood=train_log_likelihood, train_mean_nll=train_mean_nll,
                generated=generated, finite_name_mass=float(mass_of_finite_names))


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--names-path", type=Path, help="Read an existing hash-checked data copy; do not download")
    args = parser.parse_args()
    main(args.names_path)
