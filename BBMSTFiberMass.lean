import Mathlib

/-!
# Finite fiber mass conservation

This theorem is the division-free accounting layer for the BBMST audit.
It proves only that every source element contributes its weight to exactly
one target fiber. It makes no geometric or probabilistic estimate.
-/

namespace BBMSTFiberMass

/-- Summing the weight of each fiber counts every source element exactly once. -/
theorem fiber_mass_sum
    {A B : Type*} [Fintype A] [Fintype B] [DecidableEq B]
    (f : A → B) (w : A → ℚ) :
    (∑ b : B, ∑ a : A, if f a = b then w a else 0)
      = ∑ a : A, w a := by
  classical
  rw [Finset.sum_comm]
  simp [eq_comm]

#print axioms fiber_mass_sum

end BBMSTFiberMass
