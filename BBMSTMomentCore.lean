import Mathlib

namespace BBMSTMomentCore

variable {F G : Type*} [Fintype F] [Fintype G]

theorem sum_product_split (H : F × G → ℚ) :
    (∑ p : F × G, H p) = ∑ x : F, ∑ y : G, H (x, y) := by
  classical
  exact Fintype.sum_prod_type H

theorem sum_pow_eq_sum_tuples
    (g : F → ℚ) (t : ℕ) :
    (∑ x : F, g x) ^ t =
      ∑ f : Fin t → F, ∏ i : Fin t, g (f i) := by
  classical
  have hprod : (∑ x : F, g x) ^ t =
      ∏ i : Fin t, ∑ x : F, g x := by simp
  rw [hprod, Fintype.prod_sum]

#print axioms sum_product_split
#print axioms sum_pow_eq_sum_tuples

end BBMSTMomentCore
