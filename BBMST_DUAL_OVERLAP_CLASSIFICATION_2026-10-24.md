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


## Source-fidelity correction after re-reading the published BBMST paper

The published geometric model is **not** a vector space over a finite field with affine-linear hyperplanes. It is a product box `Q = S₁ × ··· × Sₙ` of arbitrary finite sets, and a hyperplane is a product set in which each coordinate is either the whole `Sᵢ` or a singleton. Its combinatorial support is `F(A)`, the set of fixed coordinates; two hyperplanes are parallel exactly when their fixed-coordinate sets agree. The Chinese-remainder correspondence is used for square-free odd moduli.

Therefore the dual-space/rank-defect identity above is a valid auxiliary theorem for a different, linear-algebraic model, but it is **not itself a faithful formalization of the BBMST hyperplane model**. It must not be treated as the missing bridge to Theorem 3.1 or Theorem 3.2. The source-faithful core should instead formalize the finite product space, `F(A)`, the families `F_k`, `N_k`, the uncovered sets `R_k`, the removed sets `B_k`, the conditional fibre fractions `α_k`, and the reweighted measures `P_k`.

The paper's actual proof interfaces are:

- Lemma 2.1: `P_k(S) = P_{k-1}(S)` for `Q_{k-1}`-measurable `S`; `P_k(S) ≤ P_{k-1}(S)/(1-δ_k)` for arbitrary `S`; and `P_k(S) ≤ P_{k-1}(S)` when `S ⊆ B_k`.
- Theorem 3.1: non-covering follows if `Σ_k min(M_k^(1), M_k^(2)/(4δ_k(1-δ_k))) < 1`.
- Theorem 3.2: moment bounds use the source-defined generating function `c_k(x)` and its values at `1` and `3`; the refined second-moment bound (13) has the explicit hypothesis that no hyperplane in `N_k` has codimension one.

This also sharpens the implementation warning: a scalar normalization lemma for one fibre is necessary but does not prove the measure-preservation statement for all `Q_{k-1}`-measurable sets, nor the global moment bounds. In particular, codimension-one removal and the precise conditional hypothesis of equation (13) must be represented rather than replaced by free predicates or assumptions.

## Revised implementation order

1. Define finite product spaces and coordinatewise hyperplanes without importing finite-field linearity.
2. Define `fixedCoords`, parallelism, `F_k`, `N_k`, `R_k`, and `B_k` exactly as in the paper.
3. Define the stagewise probability measure update with the paper's `max`/`min` branches, handling the `α = 0`, `α = 1`, and `δ = 0` edges explicitly.
4. Prove the three parts of Lemma 2.1 for actual finite-set sums.
5. Define `α_k`, `M_k^(1)`, `M_k^(2)`, and `c_k`; prove Theorem 3.1 and Theorem 3.2 with the exact hypotheses.
6. Only then specialize to the prime-coordinate box and formalize the arithmetic progression/CRT correspondence and the finite exceptional-prime computations.

The rank-defect note above remains useful as a separate investigation of affine linear constraints, but the source-faithful route to the Erdős–Selfridge theorem must proceed through the product-space sieve. No global sieve theorem is claimed by this correction.


## Independent source trail discovered (not a Lean proof)

The current Erdős Problems library has a detailed reconstruction of the published BBMST square-free proof and its full dependency chain: https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli . It records the precise roles of Lemma 2.1, Theorems 3.1 and 3.2, Lemmas 3.3–3.4, Lemmas 5.3–5.4, and Corollary 5.2, plus exact finite certificates and the extension beyond square-free moduli at primes above 73. Its evidence checker uses exact integer/rational arithmetic, but this is **not a Lean kernel proof** and does not discharge our Lean axioms.

The related upstream formalization by axxen95 (`ErdosSelfridge_v17_fixed.lean`, Mathlib v4.28.0) has two explicit axioms: `sieve_criterion` and `sf_sieve_lt_one`. Its monotonicity chain is formalized, but the source-level criterion and square-free parameter-existence/computation remain imported. That makes the axiom boundary precise: the remaining work is not the already-proved monotonicity lemma; it is to replace those two assumptions with source-faithful proofs, including the actual moment bounds and exact finite parameter certificate. The imported assumptions must be checked against the published theorem's hypotheses, not merely trusted because they are described as BBMST results.

This independent reconstruction gives us a sharper attack plan than the affine-rank detour: reproduce the published product-space sieve in Lean, use the source's exact rational certificates for finite numerical stages, and only then prove the prime-power monotonicity extension. The rank-defect identity remains an auxiliary result, not the central route.
