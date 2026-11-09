"""Exact checker for max c*x subject to A*x <= b, x >= 0; rational only."""
import json, sys
from fractions import Fraction as F

def rat(x):
    if isinstance(x, (float, bool)): raise ValueError("no floats or booleans; use integer or p/q string")
    return F(x)

def check(d):
    A=[[rat(x) for x in row] for row in d["A"]]
    b=[rat(x) for x in d["b"]]; c=[rat(x) for x in d["c"]]; y=[rat(x) for x in d["y"]]
    if not A or len(A)!=len(b) or len(y)!=len(A): raise ValueError("row dimension mismatch")
    if any(len(row)!=len(c) for row in A): raise ValueError("column dimension mismatch")
    if any(x<0 for x in y): raise ValueError("dual y must be nonnegative")
    aty=[sum((A[i][j]*y[i] for i in range(len(A))),F(0)) for j in range(len(c))]
    if any(aty[j]<c[j] for j in range(len(c))): raise ValueError("A^T y does not dominate c")
    bound=sum((b[i]*y[i] for i in range(len(b))),F(0))
    return {"dual_feasible":True,"A_transpose_y":[str(x) for x in aty],
            "upper_bound":str(bound),"scope":"single LP instance only"}
if __name__=="__main__":
    try:
        with open(sys.argv[1],encoding="utf-8") as f: print(json.dumps(check(json.load(f)),indent=2))
    except (IndexError,OSError,ValueError,KeyError,TypeError) as e:
        print("REJECTED:",e,file=sys.stderr); sys.exit(1)
