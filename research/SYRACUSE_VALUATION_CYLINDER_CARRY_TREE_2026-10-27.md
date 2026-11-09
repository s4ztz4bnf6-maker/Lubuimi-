# Syracuse research note: valuation cylinders and a carry-spectrum tree

Date: 2026-10-27

## Status and scope

This note turns the valuation word into an exact finite-resolution object in the 2-adic integers. It is a research architecture, not a proof of Collatz and not a claim that the coding idea is unprecedented. Its purpose is to make the obstruction measurable without assuming random bits.

## Exact inverse branch

For an odd state and a prescribed valuation a >= 1, the accelerated Syracuse step is

\[
T_a(x)=\frac{3x+1}{2^a},\qquad v_2(3x+1)=a.
\]

The inverse branch is

\[
T_a^{-1}(y)=\frac{2^a y-1}{3}.
\]

Since 3 is a unit in \(\mathbb Z_2\), this is well-defined 2-adically. If y is odd, then 2^a y - 1 is odd, so the inverse state is odd; moreover
\[
3T_a^{-1}(y)+1=2^a y
\]
shows that its valuation is exactly a whenever y is odd.

For a finite word \(w=(a_0,\ldots,a_{N-1})\), compose these inverse branches. The composition has the affine form
\[
T_{a_0}^{-1}\circ\cdots\circ T_{a_{N-1}}^{-1}(y)
=\frac{2^{A_N}y-C_N}{3^N},
\qquad A_N=\sum_{j<N}a_j,
\]
for an integer \(C_N\) determined by the word. If y and y' are odd 2-adic integers, their difference is divisible by 2, hence the corresponding starting points differ by a multiple of \(2^{A_N+1}\). Thus a fixed finite valuation word determines a single odd residue cylinder modulo \(2^{A_N+1}\), provided the affine composition is written with its corresponding integer constant. The exact sign/convention for \(C_N\) must be matched to the chosen forward recurrence in any Lean implementation.

## The proposed object: carry-spectrum tree

At depth N, label each realized valuation cylinder by

- the valuation word \(w=(a_0,\ldots,a_{N-1})\);
- its accumulated exponent \(A_N\);
- its exact endpoint log-change \(D_N=\log_2(x_N/x_0)\);
- a finite carry descriptor obtained from the corresponding residue class at precision \(A_N+1\).

Children refine a cylinder by one more valuation. This tree is exact at finite depth: no independence or entropy assumption is built in. A candidate potential may depend on the carry descriptor and the valuation prefix, but it must be proved compatible across every child and must control the real endpoint, not just 2-adic distance.

## Falsifiable Lyapunov target

A useful target is not the unproved statement that entropy decreases. It is an explicit inequality on every realized block, for example
\[
\sum_{j=i}^{i+L-1} a_j
\ge L\log_2 3 + \eta L - \varepsilon(x_i,L),
\]
with a stated \(\eta>0\) and a rigorously bounded correction \(\varepsilon\). Such a bound would imply real descent over sufficiently long blocks only if the correction is controlled with the correct sign. If a finite realized word violates a proposed bound, reject that candidate immediately.

The known exact identity remains
\[
\log_2(x_N/x_0)=N\log_2 3-A_N+
\sum_{j<N}\log_2\!\left(1+\frac{1}{3x_j}\right).
\]
It gives the correct target quantity but does not itself provide the required uniform lower bound on \(A_N\).

## Critical audit boundary

A finite valuation cylinder is a statement about congruences. Divergence \(x_n\to\infty\) is a statement about the ordinary real size of an orbit. The bridge between these is the open theorem. Neither 2-adic contraction of inverse branches nor a finite cylinder partition implies real descent by itself.

## Lean implementation plan

1. Define the inverse affine branch over \(\mathbb Q_2\) only if the project has the required Mathlib interface; otherwise start with congruences modulo powers of 2 over integers.
2. Prove the finite-word affine composition by induction, tracking the constant explicitly.
3. Prove the cylinder precision statement by congruence arithmetic, including the oddness hypothesis.
4. Keep all global drift claims out of the file until a separate universal inequality has been proved.
5. Run the pinned Lean compiler, inspect all unproved assumptions, and verify that the formal statement is the intended one.
