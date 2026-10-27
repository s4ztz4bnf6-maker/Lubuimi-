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
    T.prod (fun j => 1 + x * w j) =
      T.powerset.sum (fun J => x ^ J.card * J.prod w) := by
  classical
  calc
    T.prod (fun j => 1 + x * w j)
        = T.prod (fun j => x * w j + 1) := by
          apply Finset.prod_congr rfl
          intro j hj
          exact add_comm 1 (x * w j)
    _ = T.powerset.sum (fun J => J.prod (fun j => x * w j)) := by
          simpa using (Finset.prod_add_one (s := T) (f := fun j => x * w j))
    _ = T.powerset.sum (fun J => x ^ J.card * J.prod w) := by
          apply Finset.sum_congr rfl
          intro J hJ
          simp [Finset.prod_mul_distrib]

#print axioms product_one_add_weight_eq_sum_powerset

end BBMSTProductPowerset
