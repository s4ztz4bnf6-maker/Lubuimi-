import Mathlib

/-!
# Product expansion over a finite powerset

This is an isolated algebraic lemma for the BBMST factorization.
It does not encode any BBMST geometric or sieve hypothesis.
-/

namespace BBMSTProductPowerset

theorem product_one_add_weight_eq_sum_powerset
    {α R : Type*}
    [DecidableEq α]
    [CommSemiring R]
    (T : Finset α)
    (w : α → R)
    (x : R) :
    (∏ j ∈ T, (1 + x * w j)) =
      ∑ J ∈ T.powerset,
        x ^ J.card * (∏ j ∈ J, w j) := by
  calc
    (∏ j ∈ T, (1 + x * w j))
        = ∏ j ∈ T, (x * w j + 1) := by
          apply Finset.prod_congr rfl
          intro j hj
          exact add_comm 1 (x * w j)
    _ = ∑ J ∈ T.powerset, ∏ j ∈ J, (x * w j) := by
          rw [Finset.prod_add_one]
    _ = ∑ J ∈ T.powerset,
          x ^ J.card * (∏ j ∈ J, w j) := by
          apply Finset.sum_congr rfl
          intro J hJ
          simp [Finset.prod_mul_distrib, mul_comm, mul_left_comm, mul_assoc]

#print axioms product_one_add_weight_eq_sum_powerset

end BBMSTProductPowerset
