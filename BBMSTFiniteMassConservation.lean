import Mathlib

/-!
# Finite fiber mass conservation

This lemma is deliberately independent of the BBMST geometric hypotheses.
It records the elementary partition identity that must hold before any
source-specific probability estimate is layered on top of it.
-/

theorem finite_fiber_mass_conservation
    {Ω I : Type*} [Fintype Ω] [Fintype I] [DecidableEq I]
    (f : Ω → I) (w : Ω → ℚ) :
    (∑ i : I, ∑ x : Ω, (if i = f x then w x else 0)) =
      ∑ x : Ω, w x := by
  classical
  rw [Finset.sum_comm]
  simp
