import Mathlib

/-!
# Piecewise-constant finite sum: isolated Mathlib 4.28.0 compile test

This module tests the exact finite-sum identity needed by the BBMST weight
construction. It is deliberately independent of the source-specific geometry
and does not claim to prove the BBMST moment bounds.
-/

namespace BBMSTPiecewiseConst

/-- Sum of two constants selected by membership in a finite subset. -/
theorem sum_piecewise_const
    {S : Type*} [Fintype S] [DecidableEq S]
    (F : Finset S) (u v : ℚ) :
    (∑ y : S, if y ∈ F then u else v)
      = (F.card : ℚ) * u
        + ((Fintype.card S - F.card : ℕ) : ℚ) * v := by
  classical
  rw [Finset.sum_ite]
  simp

#print axioms sum_piecewise_const

end BBMSTPiecewiseConst
