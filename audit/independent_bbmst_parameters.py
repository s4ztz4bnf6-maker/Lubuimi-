#!/usr/bin/env python3
"""Independent exact-rational replay of BBMST Lemma 5.3 endpoint bounds.

No imports from the pinned upstream verifier. This checks the recurrence from
its displayed rational formulas, plus malformed-parameter rejection tests.
"""
from fractions import Fraction
import json

PRIMES = (13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73)
NUMERATORS = (
    199104, 204170, 219621, 224848, 222354, 232674, 231371, 235009,
    242966, 246633, 246419, 246279, 252238, 252326, 255063, 260307,
)
DELTA_DEN = 10**6
F_LIMIT = Fraction(138872, 1000)


def endpoint(initial_c1: int, numerators=NUMERATORS):
    c1 = Fraction(initial_c1)
    c3 = Fraction(9019, 1000) + Fraction(3 * initial_c1, 4)
    mu = Fraction(1)
    trace = []
    if len(numerators) != len(PRIMES):
        raise ValueError("expected exactly sixteen distortion parameters")
    for index, (p, d) in enumerate(zip(PRIMES, numerators), 1):
        if type(d) is not int:
            raise ValueError(f"parameter {index} is not an integer")
        delta = Fraction(d, DELTA_DEN)
        if not 0 < delta <= Fraction(1, 2):
            raise ValueError(f"parameter {index} is outside (0, 1/2]")
        # These are the exact rational recurrences in the lemma.
        mu -= (c3 - 2 * c1 + 1) / (4 * delta * (1 - delta) * (p - 1)**2)
        c1 *= 1 + 1 / ((1 - delta) * (p - 1))
        c3 *= 1 + 3 / ((1 - delta) * (p - 1))
        trace.append((p, delta, c1, c3, mu))
        if mu <= 0:
            return {"initial_c1": initial_c1, "positive_survival": False,
                    "f21": None, "trace_length": len(trace)}
    f21 = c3 / mu
    return {"initial_c1": initial_c1, "positive_survival": True,
            "f21": [f21.numerator, f21.denominator],
            "f21_below_138_872": f21 < F_LIMIT,
            "trace_length": len(trace)}


def main():
    results = [endpoint(1), endpoint(5)]
    assert all(x["positive_survival"] for x in results), results
    assert all(x["f21_below_138_872"] for x in results), results

    # Mutation tests: reject a zero distortion, a value beyond 1/2, a bool
    # (which Python otherwise treats as an int), and the wrong vector length.
    mutations = []
    for label, changed in (
        ("zero", (0,) + NUMERATORS[1:]),
        ("above_half", (500001,) + NUMERATORS[1:]),
        ("bool", (True,) + NUMERATORS[1:]),
        ("short_vector", NUMERATORS[:-1]),
    ):
        try:
            endpoint(1, changed)
        except (ValueError, TypeError):
            mutations.append({"mutation": label, "rejected": True})
        else:
            mutations.append({"mutation": label, "rejected": False})
    assert all(m["rejected"] for m in mutations), mutations
    print(json.dumps({
        "pass": True,
        "independent_implementation": True,
        "prime_count": len(PRIMES),
        "endpoints": results,
        "mutation_tests": mutations,
        "arithmetic": "fractions.Fraction only; no floating-point conversions",
    }, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
