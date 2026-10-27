import Mathlib
import BBMSTProductPowerset
import BBMSTDoubleSum

/-!
# Algebraic form of BBMST equation (11)

This theorem proves the finite-sum/product factorization pattern with
abstract coefficients and exponents. It does not establish the geometric
definitions or hypotheses of the BBMST sieve theorem.
-/

namespace BBMSTEq11Factorization

theorem bbmst_eq11_factorization
    {α β : Type*}
    [DecidableEq β]
    (U : Finset α)
    (V : Finset β)
    (c : α → ℚ)
    (w : β → ℚ)
    (m : α → ℕ)
    (x : ℚ) :
    (U.sum (fun i => c i * x ^ m i)) *
        V.prod (fun j => 1 + x * w j)
      =
    U.sum (fun i =>
      (V.powerset.sum (fun J =>
        c i * J.prod w * x ^ (m i + J.card)))) := by
  rw [BBMSTProductPowerset.product_one_add_weight_eq_sum_powerset]
  have hdouble :=
    BBMSTDoubleSum.finset_double_sum_factorization
      U V.powerset c
      (fun J => x ^ J.card * J.prod w)
      m (fun _ => 0) x
  calc
    (U.sum (fun i => c i * x ^ m i)) *
        (V.powerset.sum (fun J => x ^ J.card * J.prod w))
      =
    U.sum (fun i =>
      V.powerset.sum (fun J =>
        c i * (x ^ J.card * J.prod w) * x ^ (m i + 0))) := by
          simpa using hdouble
    _ =
    U.sum (fun i =>
      V.powerset.sum (fun J =>
        c i * J.prod w * x ^ (m i + J.card))) := by
          apply Finset.sum_congr rfl
          intro i hi
          apply Finset.sum_congr rfl
          intro J hJ
          rw [pow_add]
          ring

#print axioms bbmst_eq11_factorization

end BBMSTEq11Factorization
