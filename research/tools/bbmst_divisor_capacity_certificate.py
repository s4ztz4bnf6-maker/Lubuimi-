#!/usr/bin/env python3
"""Exact divisor-density capacity for a proposed odd covering-system LCM.

If a finite covering has LCM N, every selected modulus m divides N and
m > 1. The modulus N itself is allowed, so the necessary upper-capacity
test must include N among available moduli:
    sum_{m|N, m>1} 1/m >= 1.
This is a necessary condition only, not a residue-class covering test.
"""
from __future__ import annotations
import argparse
import json
from fractions import Fraction
from math import isqrt


def divisors(n: int) -> list[int]:
    if isinstance(n, bool) or not isinstance(n, int) or n < 2:
        raise ValueError("N must be an integer at least 2")
    low, high = [], []
    for d in range(1, isqrt(n) + 1):
        if n % d == 0:
            low.append(d)
            if d * d != n:
                high.append(n // d)
    return low + high[::-1]


def capacity_certificate(n: int) -> dict:
    ds = divisors(n)
    available = [d for d in ds if d > 1]
    proper = [d for d in available if d < n]
    capacity = sum((Fraction(1, d) for d in available), Fraction(0, 1))
    proper_capacity = sum((Fraction(1, d) for d in proper), Fraction(0, 1))
    sigma = sum(ds)
    abundance = Fraction(sigma, n)
    return {
        "status": "exact_divisor_density_capacity_certificate",
        "N": n,
        "divisors": ds,
        "available_moduli_count_including_N": len(available),
        "available_moduli_including_N": available,
        "available_proper_moduli_count": len(proper),
        "available_proper_moduli": proper,
        "sigma_1_N": sigma,
        "abundancy": f"{abundance.numerator}/{abundance.denominator}",
        "reciprocal_capacity_over_all_available_moduli": {
            "numerator": capacity.numerator,
            "denominator": capacity.denominator,
            "exact": f"{capacity.numerator}/{capacity.denominator}",
            "at_least_one": capacity >= 1,
        },
        "proper_divisor_capacity_diagnostic_only": f"{proper_capacity.numerator}/{proper_capacity.denominator}",
        "necessary_condition_passes": capacity >= 1,
        "warning": (
            "The modulus N itself is included because a covering can in principle "
            "use it. This checks reciprocal-density capacity only; passing does not "
            "imply any residue-class assignment covers Z/NZ."
        ),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("N", type=int)
    args = parser.parse_args()
    try:
        print(json.dumps(capacity_certificate(args.N), indent=2, sort_keys=True))
    except ValueError as exc:
        parser.error(str(exc))


if __name__ == "__main__":
    main()
