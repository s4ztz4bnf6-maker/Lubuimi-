import Mathlib
open scoped BigOperators

theorem finite_product_sum_factorization
    {I : Type*} [Fintype I] [DecidableEq I]
    (X : I -> Type*) [forall i, Fintype (X i)]
    [Fintype (forall i, X i)]
    (f : forall i, X i -> ℚ) :
    (∑ x : (forall i, X i), ∏ i, f i (x i)) =
      ∏ i, ∑ y : X i, f i y := by
  classical
  rw [← Fintype.prod_sum]

#print axioms finite_product_sum_factorization
