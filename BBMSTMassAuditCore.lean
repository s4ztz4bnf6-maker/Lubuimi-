import Mathlib

/-!
Finite-mass algebra used as infrastructure for the BBMST formalization.

This file intentionally proves only a general finite-sum identity. It does not
encode the BBMST geometric hypotheses or claim the Erdős–Selfridge theorem.
-/

namespace BBMSTAudit

variable {α : Type*} [DecidableEq α]
variable (s t : Finset α) (w : α → ℚ)

/-- A disjoint decomposition preserves the sum of arbitrary rational weights. -/
theorem mass_additive_of_disjoint (h : Disjoint s t) :
    (∑ x ∈ s ∪ t, w x) = (∑ x ∈ s, w x) + (∑ x ∈ t, w x) := by
  rw [Finset.sum_union h]

/-- The zero-weight case of finite-sum additivity, without any division. -/
theorem mass_additive_zero_of_disjoint (h : Disjoint s t)
    (hs : ∑ x ∈ s, w x = 0) (ht : ∑ x ∈ t, w x = 0) :
    (∑ x ∈ s ∪ t, w x) = 0 := by
  rw [Finset.sum_union h, hs, ht, add_zero]

end BBMSTAudit
