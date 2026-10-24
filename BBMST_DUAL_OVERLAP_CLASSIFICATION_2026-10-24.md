# BBMST dual-overlap classification: formal target (2026-10-24)

## Structural identity

For finite-dimensional V over a finite field K, and linear maps T:V→W₁, U:V→W₂, let S=(T,U). The dual image of S* is im(T*) + im(U*). The dimension formula therefore gives

d := rank(T)+rank(U)−rank(S) = dim(im(T*) ∩ im(U*)).

This is the correct structural invariant for pairwise dependence.

## Weighted second moment, with consistency handled explicitly

Let E_i be nonempty affine fibers and w_i ≥ 0. Set X = Σ_i w_i 1_(E_i). Then E[X²] = Σ_(i,j) w_i w_j μ(E_i ∩ E_j).

For each ordered pair there are two cases:
- If the joint affine system is inconsistent, its intersection mass is zero.
- If it is consistent, the exact fiber-count formula gives μ(E_i ∩ E_j) = |K|^(d_ij) μ(E_i) μ(E_j).

Thus the moment can be grouped by defect only after explicitly separating inconsistent pairs. Define M_d as the sum of w_i w_j μ(E_i) μ(E_j) over consistent ordered pairs with d_ij=d. Then E[X²] = Σ_d |K|^d M_d.

This identity is exact for the stated finite affine-fiber model.

## Crucial limitation

The identity does not imply that M_d decays with d, exponentially or otherwise. Such a bound must be derived from the actual BBMST family of hyperplanes and its hypotheses. It is not a consequence of square-free odd moduli alone without an additional combinatorial argument.

## Lean implementation order

1. Define the dual constraint subspace using the exact Mathlib dual-map API for the project's version.
2. Prove the stacked-map range is the sum of the two ranges.
3. Derive the defect identity from the range-dimension theorem and the dimension formula for sum and intersection.
4. Define consistency separately from cardinality so empty fibers cannot be assigned a uniform fiber size.
5. Prove the finite weighted second-moment decomposition, with inconsistent pairs contributing zero.
6. Instantiate the generic lemmas with the paper's actual BBMST hyperplane family and prove a quantitative bound for the resulting M_d.

Open obligations sieve_criterion and sf_sieve_lt_one remain open until the published global sieve inequality is derived and proved. This document records a proof plan, not a theorem or CI result.
