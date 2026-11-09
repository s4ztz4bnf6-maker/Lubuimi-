#!/usr/bin/env python3
"""Finite CRT level-vector audit for odd covering-system progressions.

Checks coordinatewise membership for Q = 3^2 * 5 * 7 = 315.
This finite computation is a regression test, not a general proof of CRT or
of the Erdős–Selfridge/BBMST theorem.
"""
from math import prod


def divisors_from_prime_powers(prime_powers):
    out = [1]
    for p, exponent in prime_powers:
        out = [old * p**j for old in out for j in range(exponent + 1)]
    return sorted(out)


def level_vector(d, prime_powers):
    levels = []
    for p, exponent in prime_powers:
        v, q = 0, d
        while q % p == 0:
            q //= p
            v += 1
        assert v <= exponent
        levels.append(v)
    return tuple(levels)


def main() -> None:
    prime_powers = [(3, 2), (5, 1), (7, 1)]
    Q = prod(p**e for p, e in prime_powers)
    divisors = divisors_from_prime_powers(prime_powers)
    odd_moduli = [d for d in divisors if d > 1 and d % 2 == 1]
    vectors = {d: level_vector(d, prime_powers) for d in divisors}
    assert len(set(vectors.values())) == len(divisors)

    checks = 0
    for d in odd_moduli:
        levels = vectors[d]
        for a in range(d):
            for x in range(Q):
                direct = (x % d == a)
                coordinatewise = all(
                    x % (p**level) == a % (p**level)
                    for (p, _), level in zip(prime_powers, levels)
                    if level > 0
                )
                assert direct == coordinatewise, (Q, d, a, x, levels)
                checks += 1

    print(f"Q={Q}; divisors={len(divisors)}; odd moduli checked={len(odd_moduli)}")
    print(f"PASS: distinct divisor level vectors ({len(divisors)} vectors)")
    print(f"PASS: {checks} exact progression/coordinate membership comparisons")
    print("SCOPE: finite regression test only; arbitrary product boxes need not be one progression")


if __name__ == "__main__":
    main()
