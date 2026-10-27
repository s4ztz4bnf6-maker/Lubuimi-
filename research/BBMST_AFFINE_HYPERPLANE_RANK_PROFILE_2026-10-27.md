# BBMST affine-hyperplane pair classification: rank-first interface

Date: 2026-10-27  
Status: exact finite-field lemma schema; must be matched to the paper's actual ambient space and event definitions before use in the theorem.

## Why this interface

The second-moment identity reduces the probabilistic problem to pairwise intersection masses. For affine hyperplanes, a pair should not be classified by a freely assigned predicate such as `isParallel`; it should be classified from the rank and compatibility of the actual defining linear equations.

## Exact finite-field calculation

Let (V=\mathbb F_q^d), and let
\[
H_i=\{x\in V: f_i(x)=c_i\},\qquad
H_j=\{x\in V: f_j(x)=c_j\},
\]
where (f_i,f_j:V\to\mathbb F_q) are nonzero linear functionals.

The map
\[
L:V\to\mathbb F_q^2,\quad x\mapsto(f_i(x),f_j(x))
\]
has rank (r\in\{1,2\}). The simultaneous equations have either no solutions or exactly (q^{d-r}) solutions, because every nonempty fiber of a linear map is a coset of its kernel.

- If (r=2), (L) is onto, so every pair ((c_i,c_j)) is attained and (|H_i\cap H_j|=q^{d-2}).
- If (r=1), the functionals are proportional: (f_j=\lambda f_i) for some nonzero \(\lambda\). The intersection is all of (H_i) if (c_j=\lambda c_i), and empty otherwise. Thus its size is (q^{d-1}) or (0).

For uniformly distributed (x\in V), divide these counts by (q^d): pairwise intersection probability is respectively (q^{-2}), (q^{-1}), or (0).

## What this buys us

It turns a vague pair taxonomy into a rank/compatibility calculation derived from the actual equations. The aggregate overlap sum can be split into:
1. rank-two pairs, each contributing (q^{-2});
2. compatible rank-one pairs, each contributing (q^{-1});
3. incompatible rank-one pairs, contributing (0).

The hard model-specific obligation becomes bounding the number of pairs in each class from the BBMST definitions and parameter constraints. This note does not assert those counts or the required global bound.

## Formalization / fidelity gates

- Define each hyperplane by its actual linear functional and level, not an independent Boolean parallelism flag.
- Prove the kernel-fiber cardinality lemma for a finite-dimensional vector space over a finite field.
- Derive rank-one compatibility and rank-two surjectivity from linear algebra.
- Verify that the original BBMST probability space is in fact uniform on the relevant finite vector space (or adjust the count for its actual measure).
- Only then connect the exact pair masses to the second-moment theorem and the source-specific global estimate.
