import Mathlib

/-!
# Exact finite-product factorization for coordinate-restricted mass

This is a general finite algebra lemma for product weights with coordinatewise
constraints. It is a building block for BBMST cylinder masses, not by itself
the BBMST moment estimate or the arithmetic hyperplane bound.
-/

open scoped BigOperators

/-- Summing a product of coordinate weights gated by independent
coordinate predicates factors into the product of the corresponding
one-coordinate restricted sums. The product structure is explicit in the
summand; this statement is false for arbitrary normalized joint measures. -/
theorem finite_product_sum_gated
    {I : Type*} [Fintype I] [DecidableEq I]
    (X : I → Type*) [∀ i, Fintype (X i)]
    (w : ∀ i, X i → ℚ)
    (P : ∀ i, X i → Prop) :
    (∑ x : (∀ i, X i), ∏ i, if P i (x i) then w i (x i) else 0) =
      ∏ i, ∑ y : X i, if P i y then w i y else 0 := by
  classical
  rw [← Fintype.prod_sum]

/-- If all coordinate predicates are true, the gated identity reduces to
the ordinary finite-product sum factorization. -/
theorem finite_product_sum_gated_true
    {I : Type*} [Fintype I] [DecidableEq I]
    (X : I → Type*) [∀ i, Fintype (X i)]
    (w : ∀ i, X i → ℚ) :
    (∑ x : (∀ i, X i), ∏ i, w i (x i)) =
      ∏ i, ∑ y : X i, w i y := by
  simpa using finite_product_sum_gated X w (fun _ _ => True)

#print axioms finite_product_sum_gated
#print axioms finite_product_sum_gated_true
