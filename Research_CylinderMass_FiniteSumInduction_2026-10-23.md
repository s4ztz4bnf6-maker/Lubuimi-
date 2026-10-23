# Research continuation: cylinder mass by finite-sum induction

Date: 2026-10-23

## Target identity

For a finite coordinate space X_i, normalized nonnegative weights w_i, and a cylinder H fixing a finite set F of coordinates to values v_i, the product distribution satisfies
mu(H) = sum_{x in product_i X_i} (product_i w_i(x_i)) 1_H(x)
      = product_{i in F} w_i(v_i).

The existing coordinatewise identity
product_i cylinderCoordinateSum(w,H,i)
  = product_{i in F} w_i(v_i)
only evaluates a factored expression. It does not, by itself, prove that the original eventMass sum equals that expression. The missing theorem must connect the original finite sum to the factored one.

## A proof route with a smaller trusted interface

Avoid trying to rewrite nested sums in one large simp/rw step. Prove a general finite-product summation lemma first:

For finite types I and finite coordinate types X_i, define
W(x) = product_{i : I} w_i(x_i).
For coordinate predicates P_i, establish by induction on the finite index type (or by Finset induction on a coordinate subset) that
sum_{x : (i : I) -> X_i} W(x) * product_{i : I} indicator(P_i(x_i))
= product_{i : I} (sum_{y : X_i} w_i(y) * indicator(P_i(y))).

Then instantiate P_i as equality to v_i on fixed coordinates and True on free coordinates. For fixed coordinates, the inner sum collapses to w_i(v_i); for free coordinates it equals one by coordinate_sum_one. This directly proves the cylinder mass identity from the actual eventMass definition.

Implementation detail: CoordinateValue space i is dependent on i, so the formal theorem must use the existing dependent function type CoordinatePoint space and Lean's finite Fintype/Finset.univ sums, rather than silently treating the product as a non-dependent Cartesian power.

## Required follow-up lemmas

1. A sum/product interchange lemma over CoordinatePoint space, with all dependent coordinate types explicit.
2. An indicator/equality lemma for each fixed coordinate.
3. The cylinder identity stated directly using eventMass μ H.Contains.
4. Only then: intersection mass. For compatible cylinders, combine fixed-coordinate constraints over F union G, counting each coordinate once; for disagreement on an overlap, prove the intersection event is empty and hence has mass zero.

## Why this is mathematically safer

The proof depends only on finite sum algebra and normalization. It makes no geometric distortion claim and assumes no independence beyond the explicitly defined product distribution. The source-specific BBMST work remains separate: the actual stage measures, hyperplane family, Lemma 3.3 induction, Lemma 3.4 minimal-cover dichotomy, and the resulting moment bounds must still be proved from the paper's hypotheses.

Reference: Balister, Bollobás, Morris, Sahasrabudhe and Tiba, “The Erdős–Selfridge problem with square-free moduli,” Algebra & Number Theory 15 (2021), 609–650, DOI 10.2140/ant.2021.15.609.
