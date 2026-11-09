# Syracuse affine block cocycle: exact composition law (2026-10-27)

## Status

Research note only. The composition identities below are elementary and exact; this note does **not** prove the Collatz conjecture and does not claim the construction is novel in the literature. The research value is to isolate a reusable block interface for formalization and counterexample search.

## State and one-step identity

For an odd Syracuse trajectory, let
\[
n_{j+1}=\frac{3n_j+1}{2^{a_j}},\qquad a_j=v_2(3n_j+1)\geq 1.
\]
For a block of length \(m\), write \(A=\sum_{j<m}a_j\). Define its correction integer \(R\) by
\[
2^A n_m=3^m n_0+R.
\]
For a realized block, \(R\geq 0\) and the recurrence gives
\[
R_0=0,\qquad R_{j+1}=3R_j+2^{A_j}.
\]

## Exact composition law

Let block P have summary \((m_1,A_1,R_1)\), and let block Q, applied after P, have summary \((m_2,A_2,R_2)\). Then the concatenated block has summary
\[
(m_1+m_2,\ A_1+A_2,\ 3^{m_2}R_1+2^{A_1}R_2).
\]
Proof: multiply the Q identity by \(2^{A_1}\), substitute the P identity, and collect terms. In particular, the correction coordinate is not additive: its weighting depends on the length of the suffix and the valuation sum of the prefix.

The law is associative because it is composition of the affine maps
\[
n\mapsto \frac{3^m n+R}{2^A}.
\]
This affine map is a block summary, but **not every formal triple** \((m,A,R)\) is necessarily realizable by a Syracuse trajectory. Any search or theorem must retain realizability constraints, including the valuation conditions.

## Descent criterion

For a realized block,
\[
n_m<n_0\quad\Longleftrightarrow\quad
(2^A-3^m)n_0>R.
\]
Thus a valuation-only estimate such as \(2^A>3^m\) is insufficient by itself: the correction term still has to fit within the margin. A sufficient uniform block certificate for all starting values in a specified class is a proved upper bound on R together with a positive lower bound on \(2^A-3^m\); the class and the realizability hypotheses must be explicit.

## Proposed next formal targets

1. Define a typed block summary in Lean and prove the composition theorem without floating-point logarithms.
2. Prove the recurrence for R by induction.
3. Prove the descent equivalence over integers/naturals with explicit positivity hypotheses.
4. Enumerate realized short valuation words and test whether candidate bounds on R compose. Computation is only a conjecture generator; any uniform bound needs a proof.
5. Audit all resulting theorem dependencies with `#print axioms`; separately verify the toolchain/kernel version.

## Failure mode this structure exposes

A block may have a favorable valuation total yet fail to yield descent because R consumes the nominal margin. The research bottleneck is therefore a *joint, composable bound* on valuation surplus and correction, not a heuristic assertion that carries behave randomly.
