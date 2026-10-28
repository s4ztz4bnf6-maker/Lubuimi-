# BBMST second-moment bridge: exact overlap budget (2026-10-27)

## Scope

This note isolates an exact generic inequality that can be formalized independently of the BBMST theorem. It does not claim that the paper's model satisfies the required rank counts or that this bound is strong enough for the global sieve criterion.

## Setup

Let \(V=\mathbb F_q^d\) with uniform measure. Let \(H_1,\ldots,H_m\) be affine hyperplanes defined by nonzero linear functionals. Set
\[
S(x)=\sum_{i=1}^m \mathbf 1_{H_i}(x),\qquad
U=\{x:S(x)>0\}.
\]
Each hyperplane has measure \(q^{-1}\), so \(\mathbb E S=m/q\).

Classify unordered pairs from their actual equations:
- \(R_2\): pairs whose two defining functionals have rank two;
- \(C_1\): rank-one pairs whose level equations are compatible;
- \(I_1\): rank-one pairs whose level equations are incompatible.

Then
\[
\mathbb E S^2=\frac m q+\frac{2R_2}{q^2}+\frac{2C_1}{q},
\]
because a rank-two pair intersects in a codimension-two affine subspace, a compatible rank-one pair is the same hyperplane, and an incompatible rank-one pair has empty intersection. Also
\[
\mathbb P(U)\geq \frac{(\mathbb E S)^2}{\mathbb E S^2}
=\frac{m^2/q^2}{m/q+2R_2/q^2+2C_1/q}.
\]
The inequality follows from Cauchy–Schwarz applied to \(S\mathbf 1_U\): \(\mathbb E S=\mathbb E(S\mathbf 1_U)\leq (\mathbb E S^2)^{1/2}\mathbb P(U)^{1/2}\).

## The useful threshold form

To prove \(\mathbb P(U)>\theta\), it is sufficient to prove the entirely explicit overlap-budget inequality
\[
\frac{m^2}{q^2}>
\theta\left(\frac m q+\frac{2R_2}{q^2}+\frac{2C_1}{q}\right).
\]
Equivalently, after multiplying by \(q^2\),
\[
m^2>\theta\bigl(mq+2R_2+2qC_1\bigr).
\]
This is a clean separation of the proof obligations: linear algebra computes each pair mass; combinatorics bounds \(R_2\) and \(C_1\); the second-moment inequality converts that budget into a union-probability lower bound.

## Audit conditions before applying to BBMST

1. The source model must use a uniform finite vector space, or its actual measure must be inserted explicitly.
2. Every event must really be an affine hyperplane under the source definitions.
3. The pair classes must be derived from equations; no free parallelism or compatibility assumptions.
4. Check whether repeated/equal hyperplanes are allowed in the indexing family; if so, they belong in \(C_1\) and must not be silently discarded.
5. The resulting lower bound must be compared with the exact threshold required by the original sieve criterion. A valid second-moment bound may still be too weak.

## Lean target

Formalize first a finite probability-space lemma:
\[
\mathbb P(S>0)\,\mathbb E(S^2)\geq (\mathbb E S)^2
\]
for a nonnegative finitely supported function \(S\). Then specialize to indicator sums and only afterward import the rank-count identities. This avoids mixing generic measure algebra with the BBMST-specific geometry.
