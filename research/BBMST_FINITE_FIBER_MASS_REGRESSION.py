#!/usr/bin/env python3
"""Exact finite-fiber mass regression using Fraction arithmetic.

Enumerates all maps X -> Y for |X| <= 5 and |Y| <= 4, with signed rational
weights including zero. It tests sum_y sum_{f(x)=y} w(x) = sum_x w(x),
including empty fibers. This is not a BBMST theorem or Lean verification.
"""
from fractions import Fraction
from itertools import product

def run() -> int:
    cases = 0
    for n in range(6):
        X = range(n)
        for m in range(1, 5):
            Y = range(m)
            for values in product(range(m), repeat=n):
                weights = [Fraction((i % 3) - 1, i + 1) for i in X]
                total = sum(weights, Fraction(0))
                fiber_masses = [
                    sum((weights[i] for i in X if values[i] == y), Fraction(0))
                    for y in Y
                ]
                assert sum(fiber_masses, Fraction(0)) == total
                if total:
                    assert sum((mass / total for mass in fiber_masses), Fraction(0)) == 1
                cases += 1
    return cases

if __name__ == "__main__":
    print(f"PASS: {run()} finite maps; exact fractions; empty fibers and signed/zero weights")
