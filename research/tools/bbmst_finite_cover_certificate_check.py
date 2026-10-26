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
    uncovered = []
    for x in range(period):
        if not any(x % m == r for m, r in zip(moduli, residues)):
            uncovered.append(x)
            if len(uncovered) >= 20:
                break
    return {
        "period": period,
        "cover_verified": not uncovered,
        "normalized_residues": residues,
        "first_uncovered_residues": uncovered,
        "scope": "one finite covering instance only",
        "warning": "A verified cover is a candidate witness; failure to find a cover is not an exclusion proof for other moduli or periods."
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
