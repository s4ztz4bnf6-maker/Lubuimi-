import Mathlib
open scoped BigOperators

theorem finite_product_sum_factorization
    {I : Type*} [Fintype I]
    (X : I -> Type*) [forall i, Fintype (X i)]
    (f : forall i, X i -> Rat) :
    (sum x : (forall i, X i), prod i, f i (x i)) =
      prod i, sum y : X i, f i y := by
  classical
  rw [← Fintype.prod_sum]

#print axioms finite_product_sum_factorization
