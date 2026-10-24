# BBMST dual-overlap classification: formal target (2026-10-24)

## Structural identity

For finite-dimensional V over a finite field K, and linear maps T:V→W₁, U:V→W₂, let S=(T,U). The dual image of S* is im(T*) + im(U*). The dimension formula therefore gives

`d := rank(T)+rank(U)−rank(S) = dim(im(T*) ∩ im(U*)).`

This is the correct structural invariant for pairwise dependence. The derivation uses rank-duality for finite-dimensional spaces, the equality of the image of the dual stacked map with the sum of the two dual images, and the dimension formula for a sum of subspaces.

## Weighted second moment, with consistency handled explicitly

Let E_i be nonempty affine fibers and w_i ≥ 0. Set X = Σ_i w_i 1_(E_i). Then E[X²] = Σ_(i,j) w_i w_j μ(E_i ∩ E_j).

For each ordered pair there are two cases:
- If the joint affine system is inconsistent, its intersection mass is zero.
- If it is consistent, the exact fiber-count formula gives μ(E_i ∩ E_j) = |K|^(d_ij) μ(E_i) μ(E_j).

Thus the moment can be grouped by defect only after explicitly separating inconsistent pairs. Define M_d as the sum of w_i w_j μ(E_i) μ(E_j) over consistent ordered pairs with d_ij=d. Then E[X²] = Σ_d |K|^d M_d.

This identity is exact for the stated finite affine-fiber model.

## A useful refinement: defect is a dual intersection dimension

The primal rank formula is often awkward for classifying dependent pairs. The dual formula recasts a defect-d pair as a pair of coefficient subspaces whose intersection has dimension d. For hyperplane events, each coefficient form spans a one-dimensional subspace, so distinct nonproportional forms have zero dual intersection and defect zero; proportional forms have one-dimensional intersection, but affine consistency must still be checked separately. For higher-codimension constraints, the same viewpoint stratifies overlaps by the dimension of shared coefficient directions.

This immediately separates two distinct mechanisms:
1. **Linear dependence:** measured by the dual intersection dimension.
2. **Affine incompatibility:** a relation among coefficient forms may be violated by the offsets, making the intersection empty.

They must not be collapsed into a single “overlap” category.

## Crucial limitation

The identity does not imply that M_d decays with d, exponentially or otherwise. Such a bound must be derived from the actual BBMST family of hyperplanes and its hypotheses. It is not a consequence of square-free odd moduli alone without an additional combinatorial argument.

For a genuine hyperplane family, the first quantitative task is to count ordered pairs of coefficient forms that are proportional and then apply the affine-offset consistency test. For higher-codimension events, count pairs by the dimension of the dual intersection. Only after this classification can one evaluate whether the second moment gives a useful bound in the paper's parameter range.

## Lean implementation order

1. Define the dual constraint subspace using the exact Mathlib dual-map API for the project's version.
2. Prove the stacked-map range is the sum of the two ranges.
3. Derive the defect identity from the range-dimension theorem and the dimension formula for sum and intersection.
4. Define consistency separately from cardinality so empty fibers cannot be assigned a uniform fiber size.
5. Prove the finite weighted second-moment decomposition, with inconsistent pairs contributing zero.
6. Instantiate the generic lemmas with the paper's actual BBMST hyperplane family and prove a quantitative bound for the resulting M_d.

Open obligations `sieve_criterion` and `sf_sieve_lt_one` remain open until the published global sieve inequality is derived and proved. This document records a proof plan, not a theorem or CI result.
