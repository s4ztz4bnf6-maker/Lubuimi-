import Mathlib
open scoped BigOperators

/-- Exact finite product-sum factorization for a dependent finite family.
The index type is specialized to Fin n, matching the concrete coordinate
model used in the geometry audit and avoiding an unnecessarily general
rewrite interface. -/
theorem finite_product_sum_factorization
    {n : ℕ}
    (X : Fin n → Type*) [∀ i, Fintype (X i)]
    [Fintype (∀ i, X i)]
    (f : ∀ i, X i → ℚ) :
    (∑ x : (∀ i, X i), ∏ i, f i (x i)) =
      ∏ i, ∑ y : X i, f i y := by
  classical
  rw [Fintype.prod_sum]

#print axioms finite_product_sum_factorization
