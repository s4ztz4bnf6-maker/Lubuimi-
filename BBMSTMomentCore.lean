import Mathlib

namespace BBMSTMomentCore

variable {F G : Type*} [Fintype F] [Fintype G]

theorem sum_product_split (H : F × G → ℚ) :
    (∑ p : F × G, H p) = ∑ x : F, ∑ y : G, H (x, y) := by
  classical
  exact Fintype.sum_prod_type H

#print axioms sum_product_split

end BBMSTMomentCore
