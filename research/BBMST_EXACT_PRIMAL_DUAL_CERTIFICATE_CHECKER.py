#!/usr/bin/env python3
"""Exact rational primal/dual checker for a finite LP certificate.

Convention:
  maximize c^T x subject to A x <= b and x >= 0.
The supplied dual y must satisfy A^T y >= c and y >= 0, minimizing b^T y.
All matrix/vector entries and certificate values are JSON strings parsed as
fractions (e.g. "3/7") or integers. This checks one LP instance only; it does
not establish that the instance encodes every BBMST configuration.

JSON schema:
{
  "A": [["1","0"],["0","1"],["1","1"]],
  "b": ["1","2","2"], "c": ["1","1"],
  "x": ["0","2"], "y": ["0","0","1"]
}
"""
import json
import sys
from fractions import Fraction
from pathlib import Path

def q(v):
    return Fraction(str(v))

def verify(data):
    A = [[q(v) for v in row] for row in data["A"]]
    b, c = [q(v) for v in data["b"]], [q(v) for v in data["c"]]
    x, y = [q(v) for v in data["x"]], [q(v) for v in data["y"]]
    if not A or len(A) != len(b) or len(A) != len(y):
        raise ValueError("row dimension mismatch or empty matrix")
    n = len(c)
    if n == 0:
        raise ValueError("empty variable vector: degenerate certificate")
    if any(len(row) != n for row in A) or len(x) != n:
        raise ValueError("column dimension mismatch")
    if any(v < 0 for v in x) or any(v < 0 for v in y):
        raise ValueError("nonnegativity condition failed")
    Ax = [sum((aij*xj for aij, xj in zip(row, x)), Fraction(0)) for row in A]
    if any(lhs > rhs for lhs, rhs in zip(Ax, b)):
        raise ValueError("primal infeasible: A x <= b failed")
    ATy = [sum((A[i][j]*y[i] for i in range(len(A))), Fraction(0)) for j in range(n)]
    if any(lhs < rhs for lhs, rhs in zip(ATy, c)):
        raise ValueError("dual infeasible: A^T y >= c failed")
    primal = sum((cj*xj for cj, xj in zip(c, x)), Fraction(0))
    dual = sum((bi*yi for bi, yi in zip(b, y)), Fraction(0))
    if primal != dual:
        raise ValueError(f"objective gap: primal={primal}, dual={dual}")
    return primal, dual

def self_test():
    sample = {
        "A": [["1","0"],["0","1"],["1","1"]],
        "b": ["1","2","2"], "c": ["1","1"],
        "x": ["0","2"], "y": ["0","0","1"]
    }
    assert verify(sample) == (Fraction(2), Fraction(2))
    broken = dict(sample, y=["0","0","0"])
    try:
        verify(broken)
    except ValueError:
        pass
    else:
        raise AssertionError("invalid dual certificate was accepted")

if __name__ == "__main__":
    if len(sys.argv) == 1:
        self_test()
        print("PASS: exact rational self-test; valid certificate accepted, invalid dual rejected")
    elif len(sys.argv) == 2:
        optimum, dual = verify(json.loads(Path(sys.argv[1]).read_text()))
        print(f"PASS: exact primal=dual={optimum}")
    else:
        raise SystemExit(f"usage: {sys.argv[0]} [certificate.json]")
