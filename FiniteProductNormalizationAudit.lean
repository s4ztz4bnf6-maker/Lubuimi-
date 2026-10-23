import Mathlib
open scoped BigOperators

/-- Sum of product weights over a finite dependent product factors into
the product of coordinate sums. -/
theorem finite_product_sum_factorization
    {I : Type*} [Fintype I] [DecidableEq I]
    (X : I → Type*) [∀ i, Fintype (X i)]
    [Fintype (∀ i, X i)]
    (f : ∀ i, X i → ℚ) :
    (∑ x : (∀ i, X i), ∏ i, f i (x i)) =
      ∏ i, ∑ y : X i, f i y := by
  classical
  rw [← Fintype.prod_sum]

/-- If every coordinate weight is normalized, the induced product weight
has total mass one. This is the finite-product normalization step needed
before calculating cylinder masses. -/
theorem finite_product_normalization
    {I : Type*} [Fintype I] [DecidableEq I]
    (X : I → Type*) [∀ i, Fintype (X i)]
    [Fintype (∀ i, X i)]
    (w : ∀ i, X i → ℚ)
    (hnorm : ∀ i, (∑ y : X i, w i y) = 1) :
    (∑ x : (∀ i, X i), ∏ i, w i (x i)) = 1 := by
  rw [finite_product_sum_factorization]
  simp [hnorm]

#print axioms finite_product_sum_factorization
#print axioms finite_product_normalization
