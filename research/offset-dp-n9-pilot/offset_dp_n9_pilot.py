#!/usr/bin/env python3
"""Guarded n=9 endpoint pilot for the exact offset DP.

Operational limits are safety controls, not mathematical bounds. A run that
hits any limit is RESOURCE_LIMIT and is never interpreted as a negative result.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import platform
import resource
import sys
import time
from pathlib import Path

# Reuse the audited exact-DP primitives from the parent PR #162 directory.
sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "offset-dp"))
from offset_dp_audit import direct_validate, modulo9_pair_filter

N = 9
ENDPOINT_PAIRS = ((6, 7), (8, 9), (10, 11), (12, 13))
SIGNS = (-1, 1)
MAX_STATES_PER_LAYER = 100_000
MAX_TRANSITIONS = 5_000_000
MAX_SECONDS_PER_RUN = 30.0
MAX_RSS_MIB = 256.0
MAX_TOTAL_SECONDS = 300.0


def rss_mib() -> float:
    """ru_maxrss is KiB on Linux and bytes on macOS."""
    value = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
    return value / (1024.0 * 1024.0 if sys.platform == "darwin" else 1024.0)


def dp_fixed_guarded(n: int, C: int, D: int, sign: int, *,
                     max_states: int = MAX_STATES_PER_LAYER,
                     max_transitions: int = MAX_TRANSITIONS,
                     max_seconds: float = MAX_SECONDS_PER_RUN,
                     max_rss_mib: float = MAX_RSS_MIB,
                     global_deadline: float | None = None) -> dict:
    started = time.monotonic()
    deadline = started + max_seconds
    if global_deadline is not None:
        deadline = min(deadline, global_deadline)
    ok, filter_checked = modulo9_pair_filter(n, C, D)
    counts: list[int] = []
    transitions = 0
    filter_rejections = 0
    witness = None

    def result(status: str, reason: str | None = None) -> dict:
        return {
            "n": n, "C": C, "D": D, "sign": sign,
            "status": status, "reason": reason,
            "states_per_layer": counts, "transitions": transitions,
            "filter_checked": filter_checked,
            "filter_rejections": filter_rejections,
            "elapsed_seconds": time.monotonic() - started,
            "max_rss_mib": rss_mib(), "witness": witness,
        }

    if not ok:
        return result("COMPLETED_NO_WITNESS", "modulo9_filter_rejects_endpoint_pair")

    p1 = 2 ** (n - 1) * (2**D - 2**C)
    if (p1 - sign) % 3:
        return result("COMPLETED_NO_WITNESS", "modulo3_prefix_congruence")
    states = {(C, D, p1): ((C,), (D,))}
    counts.append(len(states))

    for k in range(1, n):
        coeff = 3**k * 2 ** (n - 1 - k)
        nxt = {}
        for (a, b, p), (apath, bpath) in states.items():
            for aa in range(a + 1):
                for bb in range(b + 1):
                    if transitions >= max_transitions:
                        return result("RESOURCE_LIMIT", "max_transitions")
                    transitions += 1
                    if transitions % 256 == 0 and time.monotonic() >= deadline:
                        return result("RESOURCE_LIMIT", "time_limit")
                    if transitions % 4096 == 0 and rss_mib() >= max_rss_mib:
                        return result("RESOURCE_LIMIT", "rss_limit")
                    pp = p + coeff * (2**bb - 2**aa)
                    if (pp - sign) % (3 ** (k + 1)):
                        filter_rejections += 1
                        continue
                    key = (aa, bb, pp)
                    if key not in nxt:
                        if len(nxt) >= max_states:
                            return result("RESOURCE_LIMIT", "max_states_per_layer")
                        nxt[key] = (apath + (aa,), bpath + (bb,))
        states = nxt
        counts.append(len(states))
        if not states:
            break
        if time.monotonic() >= deadline:
            return result("RESOURCE_LIMIT", "time_limit")
        if rss_mib() >= max_rss_mib:
            return result("RESOURCE_LIMIT", "rss_limit")

    for (a, b, p), (apath, bpath) in states.items():
        if p == sign:
            c = tuple(reversed(apath))
            d = tuple(reversed(bpath))
            checked = direct_validate(n, c, d, sign)
            witness = {
                "c": list(c), "d": list(d),
                "e": list(checked["e"]), "f": list(checked["f"]),
                "T_e": checked["T_e"], "T_f": checked["T_f"],
                "signed_difference": checked["signed_difference"],
            }
            return result("WITNESS_FOUND")
    return result("COMPLETED_NO_WITNESS")


def run_pilot() -> dict:
    started_wall = time.time()
    started = time.monotonic()
    global_deadline = started + MAX_TOTAL_SECONDS
    runs = []
    for C, D in ENDPOINT_PAIRS:
        for sign in SIGNS:
            if time.monotonic() >= global_deadline:
                runs.append({
                    "n": N, "C": C, "D": D, "sign": sign,
                    "status": "RESOURCE_LIMIT", "reason": "global_time_limit",
                    "states_per_layer": [], "transitions": 0,
                    "filter_checked": 0, "filter_rejections": 0,
                    "elapsed_seconds": 0.0, "max_rss_mib": rss_mib(),
                    "witness": None,
                })
            else:
                runs.append(dp_fixed_guarded(
                    N, C, D, sign, global_deadline=global_deadline
                ))
    elapsed = time.monotonic() - started
    statuses = [r["status"] for r in runs]
    if "RESOURCE_LIMIT" in statuses:
        overall = "RESOURCE_LIMIT"
    elif "WITNESS_FOUND" in statuses:
        overall = "COMPLETED_WITH_WITNESS"
    else:
        overall = "COMPLETED_NO_WITNESS"
    return {
        "metadata": {
            "python": sys.version, "platform": platform.platform(),
            "source_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            "pid": os.getpid(), "started_unix": started_wall,
        },
        "problem": {
            "n": N, "endpoint_pairs": [list(x) for x in ENDPOINT_PAIRS],
            "signs": list(SIGNS),
        },
        "limits": {
            "max_states_per_layer": MAX_STATES_PER_LAYER,
            "max_transitions_per_run": MAX_TRANSITIONS,
            "max_seconds_per_run": MAX_SECONDS_PER_RUN,
            "max_rss_mib": MAX_RSS_MIB,
            "max_total_seconds": MAX_TOTAL_SECONDS,
        },
        "overall_status": overall, "elapsed_seconds": elapsed,
        "runs": runs,
    }


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default="offset_dp_n9_pilot_report.json")
    args = parser.parse_args()
    report = run_pilot()
    Path(args.output).write_text(json.dumps(report, indent=2), encoding="utf-8")
    print(json.dumps({
        "overall_status": report["overall_status"],
        "elapsed_seconds": report["elapsed_seconds"],
        "run_statuses": [r["status"] for r in report["runs"]],
        "report": args.output,
    }, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
