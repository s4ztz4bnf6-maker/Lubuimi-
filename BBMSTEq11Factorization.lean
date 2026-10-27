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
  rw [BBMSTDoubleSum.finset_double_sum_factorization]
  · apply Finset.sum_congr rfl
    intro i hi
    apply Finset.sum_congr rfl
    intro J hJ
    simp only [Finset.prod_mul_distrib]
    ring_nf
    rw [pow_add]
    ring
  · exact V.powerset
  · exact (fun J => J.prod w)
  · exact (fun J => J.card)

#print axioms bbmst_eq11_factorization

end BBMSTEq11Factorization
