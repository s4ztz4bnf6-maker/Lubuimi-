# Compatible-cylinder mass: formalization target

Status: exact proof target for the finite coordinate sandbox, not yet the source-specific BBMST theorem.

## Model

Let each coordinate i have a finite nonempty domain X_i and a normalized weight w_i:X_i→ℚ with Σ_{x∈X_i}w_i(x)=1. For a point x in the finite product, define its weight as Π_i w_i(x_i). For a cylinder H fixing coordinates F to values v_i, define μ(H) as the sum of point weights over all x satisfying those prescriptions.

## Target identity

The required theorem is μ(H)=Π_{i∈F} w_i(v_i).

Proof idea: split the product coordinates into F and its complement. On F, the cylinder predicate fixes the coordinate values; on the complement, sum independently over every possible coordinate value. Finite product-sum factorization turns the free-coordinate contribution into Π_{i∉F} Σ_{x_i∈X_i}w_i(x_i)=1. This derives the cylinder formula from the explicit factorized point weight, rather than assuming that arbitrary events are independent.

The Lean proof must establish the bijection between points satisfying H and assignments to the free coordinates, or use a proven finite-sum theorem for dependent function spaces and coordinate restrictions. The total-mass theorem alone is insufficient to justify the restricted sum.

## Pairwise intersection

For cylinders H and K:
- If prescriptions disagree on any common fixed coordinate, the intersection is empty and its mass is exactly zero.
- If they agree on all common fixed coordinates, their intersection is the cylinder fixing F∪G. Its mass is Π_{i∈F∪G}w_i(v_i), counting every fixed coordinate exactly once.

Do not compute the compatible intersection as μ(H)μ(K): that would double-count shared fixed coordinates and would silently impose a false independence assumption.

## Moment layer

For Z=Σ_j 1_{H_j}, finite algebra gives E[Z²]=Σ_j μ(H_j)+Σ_{j≠k}μ(H_j∩H_k). This identity is independent of the BBMST-specific geometric estimate. The source theorem must separately supply the hypotheses and distortion bounds that control the overlap sum. The 2020 distortion-method exposition and the 2022 Inventiones paper are useful guides, but their source-specific lemmas cannot be replaced by generic finite probability identities.

## Audit status

The current sandbox has a generic product-sum identity and a normalized factorized point-weight total-mass theorem. It also has exact incompatibility and general marginal bounds. The compatible-cylinder mass identity is the next genuine missing theorem. CI success for the generic product-sum step does not imply this restricted-sum theorem or the main BBMST result.