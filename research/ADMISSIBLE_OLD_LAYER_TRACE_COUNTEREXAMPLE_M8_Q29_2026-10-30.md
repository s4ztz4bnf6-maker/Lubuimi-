# Admissible high-rank obstruction to the naive weighted-trace lift bound

Date: 30 October 2026

## Result

The proposed universal trace inequality

\[
\sum_{d\mid M} c_d(U)\le (q-1)|U|
\]

is false even when U is the **actual old-uncovered set** for a legitimate completed old layer with one residue class for every nontrivial divisor d|M. This strengthens the earlier arbitrary-subset obstruction: the old-placement constraints alone do not rescue this particular trace strategy.

Take

\[
M=3\cdot5\cdot7\cdot11\cdot13\cdot17\cdot19\cdot23
=111546435,
\qquad q=29,
\]
and put
\[
g=7\cdot13\cdot17\cdot19\cdot23=676039.
\]

Under the CRT identification
\[
\mathbb Z/M\mathbb Z\cong
\mathbb Z/3\times\mathbb Z/5\times\mathbb Z/7\times
\mathbb Z/11\times\mathbb Z/13\times\mathbb Z/17\times
\mathbb Z/19\times\mathbb Z/23,
\]
define
\[
U=\{x: x_3\ne0,\ x_5\ne0,\ x_{11}\ne0,
\quad x_7=x_{13}=x_{17}=x_{19}=x_{23}=0\}.
\]
Therefore
\[
|U|=(3-1)(5-1)(11-1)=80.
\]

## Realizing U as the exact old-uncovered set

For each prime p|M, choose the old prime-modulus class as follows:

- modulo 3, 5, and 11, choose residue 0;
- modulo 7, 13, 17, 19, and 23, choose residue 1.

The union of these eight prime classes is exactly the complement of U. Indeed, a point lies outside U precisely when at least one of its 3-, 5-, or 11-coordinate is 0, or at least one of its five g-coordinates is nonzero.

Now choose one class for every remaining composite divisor d|M, d>1, so that it is disjoint from U:

- if d is divisible by 3, 5, or 11, choose its residue to be 0 modulo one such prime;
- otherwise d|g, and choose its residue to be 1 modulo any prime factor of d.

These choices exist by CRT and every such composite class is contained in one of the already selected prime classes. Thus adding all composite-divisor classes does not enlarge the union. The old layer has exactly one class for every nontrivial divisor d|M, all moduli distinct, and its uncovered set is exactly U.

## Trace violation

For every divisor d|g, all points of U have the same residue modulo d (the zero residue). Hence
\[
c_d(U)=80\qquad(d\mid g).
\]
Since g is a product of five distinct primes, it has 2^5=32 divisors. Consequently
\[
\sum_{d\mid M}c_d(U)\ge
\sum_{d\mid g}c_d(U)=32\cdot80=2560
>2240=28|U|=(q-1)|U|.
\]

Thus the desired trace budget fails for an admissible old placement at rank eight and q=29. The previous set-theoretic example was not an old-uncovered set; this construction removes that caveat.

## Exact scope

This is a counterexample to the **naive universal weighted-trace inequality**, not a counterexample to the Erdős–Selfridge conjecture and not a counterexample to the ProofAtlas full-p H=2 minimax theorem. It shows that the one-prime lift proof cannot be made universal merely by asserting \(\sum_{d|M}c_d(U)\le(q-1)|U|\), even after imposing the exact old-layer avoidance constraints.

A successful replacement must retain more information than the marginal maxima c_d(U): in particular, it must use the correlated placement profile across the 20 mixed shallow depth types (or a stronger state carrying equivalent joint information). The ProofAtlas v4 source explicitly identifies this universal placement minimax as open; its local DDA witness for one placement is not a universal certificate.

## Verification

The construction is an exact CRT argument. Its finite data are:
- M = 111546435;
- g = 676039;
- |U| = 80;
- number of divisors of g = 32;
- trace lower bound = 2560;
- q-threshold = 28|U| = 2240.

No floating-point arithmetic, search heuristic, or Lean claim is used. This note is a mathematical counterexample to the proposed inequality, not a Lean-kernel-verified theorem.
