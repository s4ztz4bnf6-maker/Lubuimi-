import Mathlib

namespace BBMSTMomentBridge

variable {Y : Type*} [Fintype Y]

/-- The overlap of two point indicators is the indicator of equality. -/
theorem sum_pair_indicator (a b : Y) :
    (∑ y : Y,
      (if a = y then (1 : ℚ) else 0) *
      (if b = y then (1 : ℚ) else 0))
      = (if a = b then 1 else 0) := by
  classical
  by_cases h : a = b <;> simp [h, eq_comm]

#print axioms sum_pair_indicator

end BBMSTMomentBridge
