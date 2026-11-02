#!/usr/bin/env python3
"""Exact arithmetic checks for the 2026-11-02 spine and fourth-moment examples.

This script checks finite numerical inputs only. The general CRT proofs are
given in GENERALIZED_QADIC_SPINE_AND_RANK_NINE_MOMENT_EXCLUSIONS_2026-11-02.md.
It is not a Lean proof and does not verify the general lemmas.
"""
from math import gcd, isqrt, prod


def is_prime(n: int) -> bool:
    if n < 2:
        return False
    return all(n % d for d in range(2, isqrt(n) + 1))


# Generalized spine example: eight square-free prime factors, then q >= 193.
P_SPINE = (3, 5, 13, 19, 23, 29, 89, 131)
M_SPINE = prod(P_SPINE)
TAU_SPINE = 2 ** len(P_SPINE)
SIGMA_SPINE = prod(p + 1 for p in P_SPINE)
DEFICIT_SPINE = 2 * M_SPINE - SIGMA_SPINE
Q0 = 193
S0 = TAU_SPINE - Q0
C_MIN = TAU_SPINE // 2

assert all(is_prime(p) for p in P_SPINE)
assert is_prime(Q0)
assert M_SPINE == 28_812_128_865
assert TAU_SPINE == 256
assert SIGMA_SPINE == 57_480_192_000
assert DEFICIT_SPINE == 144_065_730
assert gcd(M_SPINE, Q0) == 1
assert TAU_SPINE < 2 * (Q0 - 1)
assert C_MIN == 128
assert C_MIN >= 2 * (S0 + 1) == 128

# For every prime q in [193, 256], the spine hypotheses only improve.
for q in range(193, 257):
    if is_prime(q):
        s = TAU_SPINE - q
        assert gcd(M_SPINE, q) == 1
        assert TAU_SPINE < 2 * (q - 1)
        assert C_MIN >= 2 * (s + 1)

# Fourth-moment example: eight primes > 29 and the new prime q=29.
P_MOMENT = (31, 37, 41, 43, 47, 53, 59, 61)
M_MOMENT = prod(P_MOMENT)
SIGMA_MOMENT = prod(p + 1 for p in P_MOMENT)
B_MOMENT = 2 * M_MOMENT - SIGMA_MOMENT
T4_MOMENT = prod(p + 15 for p in P_MOMENT)
Q_MOMENT = 29
DENOM = (Q_MOMENT - 1) ** 4

assert all(is_prime(p) for p in P_MOMENT)
assert is_prime(Q_MOMENT)
assert gcd(M_MOMENT, Q_MOMENT) == 1
assert M_MOMENT == 18_128_893_780_549
assert B_MOMENT == 14_590_054_384_778
assert T4_MOMENT == 184_214_202_425_344
assert DENOM == 614_656
assert T4_MOMENT < B_MOMENT * DENOM
assert B_MOMENT * DENOM == 8_967_864_467_930_106_368

print("spine:", M_SPINE, TAU_SPINE, SIGMA_SPINE, DEFICIT_SPINE, Q0)
print("fourth moment:", M_MOMENT, B_MOMENT, T4_MOMENT, DENOM)
print("exact inequality:", T4_MOMENT, "<", B_MOMENT * DENOM)
print("all exact arithmetic checks passed")
