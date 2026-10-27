#!/usr/bin/env python3
"""Adversarial regression for BBMST_EXACT_PRIMAL_DUAL_CERTIFICATE_CHECKER.

Run from this directory with Python 3. Uses only exact rational strings. It
checks 100 valid diagonal LP certificates and rejects primal-infeasible,
dual-infeasible, dimension-mismatched, and objective-gap examples. This tests
the checker implementation, not any BBMST theorem or source LP.
"""
from fractions import Fraction
from BBMST_EXACT_PRIMAL_DUAL_CERTIFICATE_CHECKER import verify

def s(q: Fraction) -> str:
    return str(q.numerator) if q.denominator == 1 else f"{q.numerator}/{q.denominator}"

def valid_case(i: int):
    n = 1 + (i % 5)
    b = [Fraction(i+j+1, j+1) for j in range(n)]
    c = [Fraction(j+1, i+1) for j in range(n)]
    # Identity constraints plus a redundant non-diagonal sum constraint.
    A = [[Fraction(int(i == j)) for j in range(n)] for i in range(n)]
    A.append([Fraction(1) for _ in range(n)])
    b.append(sum(b, Fraction(0)))
    data = {"A":[[s(v) for v in row] for row in A],
            "b":[s(v) for v in b], "c":[s(v) for v in c],
            "x":[s(v) for v in b[:n]], "y":[s(v) for v in c] + ["0"]}
    assert verify(data) == (sum((u*v for u,v in zip(b[:n],c)), Fraction(0)),)*2
    return data

def must_reject(data):
    try:
        verify(data)
    except (ValueError, KeyError, IndexError, ZeroDivisionError):
        return
    raise AssertionError(f"invalid certificate accepted: {data}")

def run():
    # Empty-variable LPs can make a nominal certificate vacuously pass; reject
    # them explicitly for the nondegenerate BBMST certificate workflow.
    must_reject({"A":[[]], "b":["0"], "c":[], "x":[], "y":["0"]})
    for i in range(100):
        base = valid_case(i)
        bad_x = {**base, "x": base["x"].copy()}
        bad_x["x"][0] = s(Fraction(base["x"][0]) + 1)
        must_reject(bad_x)

        bad_y = {**base, "y": base["y"].copy()}
        bad_y["y"][0] = "0"
        must_reject(bad_y)

        bad_dims = {**base, "y": base["y"][:-1]}
        must_reject(bad_dims)

        bad_obj = {**base, "x": base["x"].copy()}
        bad_obj["x"][0] = "0"
        must_reject(bad_obj)
    return 100

if __name__ == "__main__":
    print(f"PASS: {run()} valid rational LPs with redundant non-diagonal rows; four rejection classes per case")
