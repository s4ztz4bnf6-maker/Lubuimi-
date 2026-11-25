#!/usr/bin/env python3
"""Exact finite arithmetic checks for the 315 weighted-trace lemma.

The universal subset inequality is proved by pair counting in the companion
Markdown note. This script checks its finite divisor/separation inputs and
the q-adic geometric-series arithmetic; it is not a Lean proof.
"""
from fractions import Fraction

M = 315
DIVISORS = [d for d in range(1, M + 1) if M % d == 0]
PROPER = [d for d in DIVISORS if 1 < d < M]
NONTRIVIAL = [d for d in DIVISORS if d > 1]


def run():
    assert DIVISORS == [1, 3, 5, 7, 9, 15, 21, 35, 45, 63, 105, 315]
    assert len(PROPER) == 10
    assert len(NONTRIVIAL) == 11

    split_counts = {
        t: sum(1 for d in PROPER if t % d != 0)
        for t in range(1, M)
    }
    minimum = min(split_counts.values())
    minimizers = [t for t, count in split_counts.items() if count == minimum]
    assert minimum == 3
    assert minimizers == [105, 210]

    reciprocal_sum = sum((Fraction(1, d) for d in NONTRIVIAL), Fraction(0))
    assert reciprocal_sum == Fraction(103, 105)
    old_union_bound = sum(M // d for d in NONTRIVIAL)
    assert old_union_bound == 309
    assert M - old_union_bound == 6

    exponents = [2, 1, 1]  # 315 = 3^2 * 5 * 7
    tau = 1
    for a in exponents:
        tau *= a + 1
    lam = min(tau // (a + 1) - 1 for a in exponents)
    assert tau == 12 and lam == 3

    for n in range(5, 10000):
        assert 5 * (n - 1) >= 4 * n
        trace_upper = Fraction(tau * n) - Fraction(lam + 2, 2) * (n - 1)
        assert trace_upper <= 10 * n

    # Adversarial arbitrary-U test on the first eight odd primes.
    M8 = 3 * 5 * 7 * 11 * 13 * 17 * 19 * 23
    g = M8 // (3 * 5 * 11)
    n8 = M8 // g
    assert M8 == 111546435 and g == 676039 and n8 == 165
    assert len([d for d in range(1, g + 1) if g % d == 0]) == 32
    assert 32 * n8 == 5280 and 28 * n8 == 4620
    assert Fraction(1, g) > Fraction(1, 1002375)

    for q in (11, 13, 17, 19, 23, 29, 31, 101):
        for A in range(1, 30):
            covered_upper_bound = 10 * sum(q ** (A - j) for j in range(1, A + 1))
            assert covered_upper_bound <= q ** A - 1
            assert covered_upper_bound < q ** A

    print("PASS: 10 proper divisors; minimum pair-separation count = 3")
    print("PASS: minimum attained exactly at differences 105 and 210 mod 315")
    print("PASS: old reciprocal sum = 103/105; old union bound = 309; |U| >= 6")
    print("PASS: deficit inequality for every tested n >= 5")
    print("PASS: exact finite q-adic capacity for tested q >= 11 and A <= 29")
    print("NOTE: universal subset argument is written in the Markdown note, not Lean-formalized")


if __name__ == "__main__":
    run()
