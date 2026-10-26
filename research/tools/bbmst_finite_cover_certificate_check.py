#!/usr/bin/env python3
"""Exact checker for finite congruence-covering certificates (not an exclusion proof)."""
import argparse
import json
import math


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
    # the mask ((1 << period) - 1) // ((1 << m) - 1), shifted by r, has
    # exactly the bits r, r+m, ..., r+(period/m-1)*m set.
    # This computes the same exact periodic coverage as scanning every x,
    # but replaces the O(period * number_of_classes) Python loop with big-int
    # bit operations. The configured period cap bounds memory consumption.
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
    uncovered = []
    while missing and len(uncovered) < 20:
        lowest_bit = missing & -missing
        uncovered.append(lowest_bit.bit_length() - 1)
        missing ^= lowest_bit

    return {
        "period": period,
        "cover_verified": coverage == full_mask,
        "normalized_residues": residues,
        "first_uncovered_residues": uncovered,
        "scope": "one finite covering instance only",
        "method": "exact_period_bitset",
        "warning": "A verified cover is a candidate witness; failure to find a cover is not an exclusion proof for other moduli or periods.",
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
