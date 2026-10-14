"""Teacher-only, corpus-independent check of L02's frozen first-order route.

All values are course-constructed. No samples, smoothing, external data, or
student exercises are produced. Run with the repository's uv interpreter.
"""

from fractions import Fraction as F
from itertools import product
from math import exp, inf, isclose, log


ALPHABET = ("a", "b")
# Toy transition counts, separately declared initial probabilities, and toy
# independent-character counts. These are not estimates from any source corpus.
COUNTS = ((3, 1), (2, 0))
PI = (F(2, 3), F(1, 3))
Q = (F(3, 5), F(2, 5))


def normalized_rows(counts):
    rows = []
    for j, row in enumerate(counts):
        total = sum(row)
        if total == 0:
            raise ValueError(f"row {ALPHABET[j]} unidentified: zero count total")
        rows.append(tuple(F(n, total) for n in row))
    return tuple(rows)


A = normalized_rows(COUNTS)


def transition_factors(sequence):
    return [A[ALPHABET.index(j)][ALPHABET.index(k)]
            for j, k in zip(sequence, sequence[1:])]


def multiply(factors):
    result = F(1)
    for factor in factors:
        result *= factor
    return result


def markov_joint(sequence, pi=PI):
    return multiply([pi[ALPHABET.index(sequence[0])]]
                    + transition_factors(sequence))


def conditioned_markov(sequence):
    """p(x_2:T | X_1=sequence[0]); empty suffix has probability 1."""
    return multiply(transition_factors(sequence))


def iid_joint(sequence):
    return multiply([Q[ALPHABET.index(x)] for x in sequence])


def conditioned_iid(sequence):
    """q(x_2:T | X_1=sequence[0]) for the IID joint, same fixed prefix."""
    return multiply([Q[ALPHABET.index(x)] for x in sequence[1:]])


def log_score(factors):
    # Extended-real convention: log(0)=-inf; never call math.log(0).
    return -inf if any(factor == 0 for factor in factors) else sum(
        log(float(factor)) for factor in factors)


def main():
    assert A == ((F(3, 4), F(1, 4)), (F(1), F(0)))
    assert all(sum(row) == 1 and all(x >= 0 for x in row) for row in A)
    assert sum(PI) == sum(Q) == 1
    print("teacher-only; course-constructed; alphabet=(a,b); no smoothing")
    print("counts=((3,1),(2,0)); A=((3/4,1/4),(1,0)); pi=(2/3,1/3); q=(3/5,2/5)")
    print("exact row sums: (1,1)")
    print("T strings Markov_joint IID_joint Markov_given_a Markov_given_b IID_given_a IID_given_b")
    positive, zero = 0, 0
    for length in range(1, 5):
        strings = list(product(ALPHABET, repeat=length))
        joint_m = sum(map(markov_joint, strings), F(0))
        joint_q = sum(map(iid_joint, strings), F(0))
        cond_m = [sum((conditioned_markov(s) for s in strings if s[0] == start), F(0))
                  for start in ALPHABET]
        cond_q = [sum((conditioned_iid(s) for s in strings if s[0] == start), F(0))
                  for start in ALPHABET]
        assert [joint_m, joint_q, *cond_m, *cond_q] == [F(1)] * 6
        # Exhaustive short-string oracle also checks the start convention.
        for s in strings:
            probability = markov_joint(s)
            score = log_score([PI[ALPHABET.index(s[0])]] + transition_factors(s))
            assert probability == PI[ALPHABET.index(s[0])] * conditioned_markov(s)
            assert iid_joint(s) == Q[ALPHABET.index(s[0])] * conditioned_iid(s)
            if probability == 0:
                zero += 1
                assert score == -inf
            else:
                positive += 1
                assert isclose(exp(score), float(probability), rel_tol=1e-12, abs_tol=0.0)
        print(length, len(strings), joint_m, joint_q, *cond_m, *cond_q)
    assert markov_joint("aba") == F(1, 6)
    assert conditioned_markov("aba") == F(1, 4)
    assert iid_joint("aba") == F(18, 125)
    assert conditioned_iid("aba") == F(6, 25)
    assert iid_joint("ab") == iid_joint("ba") == F(6, 25)
    assert markov_joint("ab") == F(1, 6) and markov_joint("ba") == F(1, 3)
    assert markov_joint("bb") == 0 and iid_joint("bb") == F(4, 25)
    print(f"product/log agreement: {positive} positive strings; {zero} zero strings have -inf log score")
    print("aba: Markov joint=1/6, given a=1/4; IID joint=18/125, given a=6/25")
    print("ab/ba: Markov=1/6,1/3; IID=6/25,6/25")
    print("bb: Markov=0, log=-inf; IID=4/25")
    zero_initial = (F(1), F(0))
    assert markov_joint("b", zero_initial) == 0
    assert log_score([zero_initial[1]]) == -inf
    print("separate pi=(1,0): joint b=0, log=-inf; conditioning on b is not a joint-derived conditional")
    try:
        normalized_rows(((3, 1), (0, 0)))
    except ValueError as error:
        print(f"zero-count row rejected: {error}")
    else:
        raise AssertionError("a zero-count row was silently assigned a distribution")
    # Separate sequences ab and ba have only a->b and b->a transitions.
    boundary_counts = [[0, 0], [0, 0]]
    for sequence in ("ab", "ba"):
        for j, k in zip(sequence, sequence[1:]):
            boundary_counts[ALPHABET.index(j)][ALPHABET.index(k)] += 1
    assert boundary_counts == [[0, 1], [1, 0]]
    print("boundaries: separate ab and ba yield counts=((0,1),(1,0)); no cross-boundary b->b")
    print("PASS: exact finite-length mass, declared starts, row constraints, extended-real scores, IID comparator")


if __name__ == "__main__":
    main()
