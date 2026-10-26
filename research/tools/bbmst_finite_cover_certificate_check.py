#!/usr/bin/env python3
"""Exact checker for finite congruence-covering certificates (not an exclusion proof)."""
import argparse
import json
import math


DENSITY_DENOMINATOR = 1_002_375


def prime_factorization(n: int) -> dict[str, int]:
    """Return the exact prime factorization by trial division."""
    factors: dict[str, int] = {}
    d = 2
    while d * d <= n:
        while n % d == 0:
            factors[str(d)] = factors.get(str(d), 0) + 1
            n //= d
        d = 3 if d == 2 else d + 2
    if n > 1:
        factors[str(n)] = factors.get(str(n), 0) + 1
    return factors


def check(data: dict, max_period: int = 2_000_000) -> dict:
    moduli = data["moduli"]
    residues = data["residues"]
    require_distinct_odd = data.get("require_distinct_odd", False)
    if not isinstance(moduli, list) or not moduli:
        raise ValueError("moduli must be a nonempty list")
    if not isinstance(residues, list) or len(residues) != len(moduli):
        raise ValueError("residues must have the same length as moduli")
    if any(isinstance(m, bool) or not isinstance(m, int) or m <= 1 for m in moduli):
        raise ValueError("every modulus must be an integer greater than 1")
    if any(isinstance(r, bool) or not isinstance(r, int) for r in residues):
        raise ValueError("every residue must be an integer")
    if isinstance(max_period, bool) or not isinstance(max_period, int) or max_period < 1:
        raise ValueError("max_period must be a positive integer")
    if require_distinct_odd:
        if len(set(moduli)) != len(moduli):
            raise ValueError("moduli must be pairwise distinct")
        if any(m % 2 == 0 for m in moduli):
            raise ValueError("all moduli must be odd")

    residues = [r % m for r, m in zip(residues, moduli)]
    period = 1
    for m in moduli:
        period = math.lcm(period, m)
        if period > max_period:
            raise ValueError(f"period exceeds configured exact-check limit {max_period}")

    # Bit i represents residue i modulo period. Since every m divides period,
    # this exact mask has bits r, r+m, ..., r+(period/m-1)*m set.
    # The period cap bounds the memory needed for the big integer bitsets.
    full_mask = (1 << period) - 1
    coverage = 0
    class_mask_cache = {}
    for m, r in zip(moduli, residues):
        base = class_mask_cache.get(m)
        if base is None:
            base = full_mask // ((1 << m) - 1)
            class_mask_cache[m] = base
        coverage |= base << r

    missing = full_mask ^ coverage
    uncovered_count = missing.bit_count()
    uncovered = []
    remaining = missing
    while remaining and len(uncovered) < 20:
        lowest_bit = remaining & -remaining
        uncovered.append(lowest_bit.bit_length() - 1)
        remaining ^= lowest_bit

    factors = prime_factorization(period)
    omega = len(factors)
    # Exact comparison: U/L >= 1/D iff D*U >= L; no floating-point arithmetic.
    density_bound_test = DENSITY_DENOMINATOR * uncovered_count >= period
    return {
        "period": period,
        "period_prime_factorization": factors,
        "distinct_prime_factor_count_omega": omega,
        "cover_verified": uncovered_count == 0,
        "covered_residue_count": period - uncovered_count,
        "uncovered_residue_count": uncovered_count,
        "uncovered_density": {
            "numerator": uncovered_count,
            "denominator": period,
            "decimal_approximation": uncovered_count / period,
        },
        "uncovered_density_at_least_1_over_1002375": density_bound_test,
        "density_threshold_test_scope": (
            "exact arithmetic for this finite periodic family only; "
            "the universal theorem requires its own proof"
        ),
        "normalized_residues": residues,
        "first_uncovered_residues": uncovered,
        "input_predicates": {
            "moduli_pairwise_distinct": len(set(moduli)) == len(moduli),
            "all_moduli_odd": all(m % 2 == 1 for m in moduli),
            "all_moduli_greater_than_one": all(m > 1 for m in moduli),
            "distinct_odd_requirement_enforced": require_distinct_odd,
        },
        "scope": "one finite covering instance only",
        "method": "exact_period_bitset",
        "warning": (
            "A verified cover is a candidate witness; failure to find a cover "
            "is not an exclusion proof for other moduli or periods. The density "
            "comparison is exact for this instance, not a proof of a universal bound."
        ),
    }


def main() -> None:
    p = argparse.ArgumentParser()
    p.add_argument("input_json")
    p.add_argument("--max-period", type=int, default=2_000_000)
    args = p.parse_args()
    try:
        with open(args.input_json, encoding="utf-8") as f:
            result = check(json.load(f), max_period=args.max_period)
        print(json.dumps(result, indent=2, sort_keys=True))
        if not result["cover_verified"]:
            raise SystemExit(1)
    except (OSError, ValueError, KeyError, TypeError, json.JSONDecodeError) as e:
        p.error(str(e))


if __name__ == "__main__":
    main()
