#!/usr/bin/env python3
"""Exact offset-DP audit for |T_n(e)-T_n(f)| = 1.

All arithmetic is integer-exact. Search coordinates are nondecreasing offsets
c_j=e_j-j and d_j=f_j-j. The DP runs from the fixed right endpoint backwards.
A resource-limited run must never be interpreted as an exclusion.
"""
from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import math
import os
import platform
import resource
import sys
import time
from dataclasses import asdict, dataclass
from pathlib import Path
from typing import Iterable

# Exploratory endpoint ranges fixed in the research discussion.
RANGES = {
    5: ((0, 2, 4), (1, 3, 5)),
    7: ((2, 4, 6, 8), (3, 5, 7, 9)),
    9: ((6, 8, 10, 12), (7, 9, 11, 13)),
    11: ((8, 10, 12, 14), (11, 13, 15, 17)),
}

# Immutable direct-validation fixtures: (n, c, d).
FIXTURES = (
    (5, (0, 1, 1, 2, 2), (1, 1, 1, 1, 1)),
    (7, (0, 1, 2, 2, 3, 5, 6), (1, 1, 1, 1, 1, 1, 7)),
    (9, (0, 1, 1, 1, 5, 7, 7, 7, 10), (1, 1, 1, 1, 1, 1, 1, 1, 11)),
    (11, (0, 1, 4, 4, 7, 9, 10, 11, 11, 12, 12),
     (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 15)),
)


def T_from_offsets(x: tuple[int, ...]) -> int:
    n = len(x)
    return sum(3 ** (n - 1 - j) * 2 ** (x[j] + j) for j in range(n))


def monotone_sequences(n: int, endpoint: int) -> Iterable[tuple[int, ...]]:
    """All 0 <= x[0] <= ... <= x[n-1] = endpoint, exactly once."""
    if endpoint < 0:
        return
    for prefix in itertools.combinations_with_replacement(range(endpoint + 1), n - 1):
        yield prefix + (endpoint,)


def expected_sequence_count(n: int, endpoint: int) -> int:
    return math.comb(endpoint + n - 1, n - 1)


def prefix_sums(c: tuple[int, ...], d: tuple[int, ...]) -> tuple[int, ...]:
    """P_k in reversed-offset order, k=1,...,n."""
    n = len(c)
    a = tuple(reversed(c))
    b = tuple(reversed(d))
    p = 0
    out = []
    for r in range(n):
        p += 3**r * 2**(n - 1 - r) * (2**b[r] - 2**a[r])
        out.append(p)
    return tuple(out)


def direct_validate(n: int, c: tuple[int, ...], d: tuple[int, ...],
                    expected_sign: int | None = None) -> dict:
    assert len(c) == len(d) == n
    assert all(x >= 0 for x in c + d)
    assert all(c[i] <= c[i + 1] for i in range(n - 1))
    assert all(d[i] <= d[i + 1] for i in range(n - 1))
    e = tuple(c[j] + j for j in range(n))
    f = tuple(d[j] + j for j in range(n))
    te, tf = T_from_offsets(c), T_from_offsets(d)
    signed = tf - te
    assert abs(signed) == 1
    if expected_sign is not None:
        assert signed == expected_sign
    return {
        "n": n, "c": c, "d": d, "e": e, "f": f,
        "T_e": te, "T_f": tf, "signed_difference": signed,
        "P": prefix_sums(c, d),
    }


def modulo9_pair_filter(n: int, C: int, D: int) -> tuple[bool, int]:
    """R16: exhaustive a1,b1 check; return (possible, tested_combinations)."""
    tested = 0
    lhs0 = 2 ** (n - 1) * (2**D - 2**C)
    coeff = 3 * 2 ** (n - 2)
    for a1 in range(C + 1):
        for b1 in range(D + 1):
            tested += 1
            if (lhs0 + coeff * (2**b1 - 2**a1) - 1) % 9 == 0:
                return True, tested
    return False, tested


@dataclass
class DPResult:
    n: int
    C: int
    D: int
    sign: int
    found: bool
    states_per_layer: list[int]
    transitions: int
    filter_checked: int
    witness_c: tuple[int, ...] | None = None
    witness_d: tuple[int, ...] | None = None


def dp_fixed(n: int, C: int, D: int, sign: int) -> DPResult:
    """Exact DP; exact partial sums are part of the state, never residue-merged."""
    ok, filter_checked = modulo9_pair_filter(n, C, D)
    if not ok:
        return DPResult(n, C, D, sign, False, [], 0, filter_checked)

    # State maps (current a, current b, exact P_k) -> reversed prefix tuples.
    p1 = 2 ** (n - 1) * (2**D - 2**C)
    if (p1 - sign) % 3:
        return DPResult(n, C, D, sign, False, [0], 0, filter_checked)
    states = {(C, D, p1): ((C,), (D,))}
    counts = [len(states)]
    transitions = 0

    for k in range(1, n):
        coeff = 3**k * 2 ** (n - 1 - k)
        nxt = {}
        for (a, b, p), (apath, bpath) in states.items():
            for aa in range(a + 1):
                for bb in range(b + 1):
                    transitions += 1
                    pp = p + coeff * (2**bb - 2**aa)
                    if (pp - sign) % (3 ** (k + 1)):
                        continue
                    key = (aa, bb, pp)
                    if key not in nxt:
                        nxt[key] = (apath + (aa,), bpath + (bb,))
        states = nxt
        counts.append(len(states))
        if not states:
            break

    for (a, b, p), (apath, bpath) in states.items():
        if p == sign:
            c = tuple(reversed(apath))
            d = tuple(reversed(bpath))
            direct_validate(n, c, d, sign)
            return DPResult(n, C, D, sign, True, counts, transitions,
                            filter_checked, c, d)
    return DPResult(n, C, D, sign, False, counts, transitions, filter_checked)


def brute_force_fixed(n: int, C: int, D: int) -> dict:
    """Independent original-T oracle for small test spaces."""
    cs = list(monotone_sequences(n, C))
    ds = list(monotone_sequences(n, D))
    hits = {-1: None, 1: None}
    pairs = 0
    for c in cs:
        tc = T_from_offsets(c)
        for d in ds:
            pairs += 1
            diff = T_from_offsets(d) - tc
            if diff in (-1, 1) and hits[diff] is None:
                hits[diff] = (c, d)
    return {"pairs": pairs, "hits": hits}


def check_r15() -> dict:
    checks = []
    for n, (Cs, Ds) in RANGES.items():
        for endpoint in sorted(set(Cs + Ds)):
            generated = sum(1 for _ in monotone_sequences(n, endpoint))
            formula = expected_sequence_count(n, endpoint)
            assert generated == formula, (n, endpoint, generated, formula)
            checks.append({"n": n, "endpoint": endpoint,
                           "generated": generated, "formula": formula})
    return {"R15": "PASS", "checks": checks}


def check_r17() -> dict:
    results = []
    for n, c, d in FIXTURES:
        result = direct_validate(n, c, d, 1)
        results.append(result)
    return {"R17": "PASS", "fixtures": results}


def run_n5_n7() -> dict:
    """Complete DP endpoint-pair searches for the declared n=5 and n=7 ranges."""
    report = {"runs": [], "started_unix": time.time()}
    for n in (5, 7):
        Cs, Ds = RANGES[n]
        for C in Cs:
            for D in Ds:
                for sign in (-1, 1):
                    result = dp_fixed(n, C, D, sign)
                    report["runs"].append(asdict(result))
    report["finished_unix"] = time.time()
    return report


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--mode", choices=("checks", "search"), default="checks")
    parser.add_argument("--output", default="offset_dp_audit_report.json")
    args = parser.parse_args()

    source = Path(__file__).read_bytes()
    meta = {
        "python": sys.version,
        "platform": platform.platform(),
        "source_sha256": hashlib.sha256(source).hexdigest(),
        "pid": os.getpid(),
    }
    report = {"metadata": meta, "R15": check_r15(), "R17": check_r17()}
    if args.mode == "search":
        report["search"] = run_n5_n7()
    report["max_rss_platform_units"] = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
    Path(args.output).write_text(json.dumps(report, indent=2), encoding="utf-8")
    print(json.dumps({"metadata": meta, "R15": "PASS", "R17": "PASS",
                      "search_included": args.mode == "search",
                      "report": args.output}, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
