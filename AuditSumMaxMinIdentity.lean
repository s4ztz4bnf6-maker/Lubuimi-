import Mathlib

/-!
Pure algebraic milestone for the Erdős–Selfridge / BBMST audit.
This file deliberately has no geometric or sieve assumptions.
-/

theorem sum_max_min_identity (a b : ℚ) :
    max a b + min a b = a + b := by
  rcases le_total a b with hab | hba
  · rw [max_eq_right hab, min_eq_left hab]
  · rw [max_eq_left hba, min_eq_right hba]
