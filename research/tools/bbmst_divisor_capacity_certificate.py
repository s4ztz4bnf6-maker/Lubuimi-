#!/usr/bin/env python3
"""Exact divisor-density certificates for candidate covering-system LCMs.

For a hypothetical covering whose distinct moduli all divide N and are > 1,
the sum of reciprocal moduli must be at least 1. The sum over every available
proper divisor m of N with m>1 is therefore a necessary capacity bound:
    sum_{m|N, 1<m<N} 1/m >= 1.
This tool computes that bound exactly with fractions. Passing the bound is
necessary only; it does not construct or certify a covering.
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
    available = [d for d in ds if 1 < d < n]
    capacity = sum((Fraction(1, d) for d in available), Fraction(0, 1))
    sigma = sum(ds)
    abundance = Fraction(sigma, n)
    necessary = capacity >= 1
    return {
        "status": "exact_divisor_capacity_certificate",
        "N": n,
        "divisors": ds,
        "divisor_count": len(ds),
        "available_proper_moduli_count": len(available),
        "available_proper_moduli": available,
        "sigma_1_N": sigma,
        "abundancy": f"{abundance.numerator}/{abundance.denominator}",
        "reciprocal_capacity_over_distinct_proper_moduli": {
            "numerator": capacity.numerator,
            "denominator": capacity.denominator,
            "exact": f"{capacity.numerator}/{capacity.denominator}",
            "at_least_one": necessary,
        },
        "necessary_condition_passes": necessary,
        "warning": (
            "This checks only the reciprocal-density capacity condition. "
            "Passing does not imply any residue-class assignment covers Z/NZ."
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
