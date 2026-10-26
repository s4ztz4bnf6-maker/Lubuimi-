import Mathlib

/-
Finite-mass algebra for the BBMST formalization.

This file proves only general finite-sum identities. It does not encode the
BBMST geometric hypotheses or claim the Erdős–Selfridge theorem.
-/

namespace BBMSTAudit

variable {α : Type*} [DecidableEq α]
variable (s t u : Finset α) (w : α → ℚ)

/-- A disjoint decomposition preserves the sum of arbitrary rational weights. -/
theorem mass_additive_of_disjoint (h : Disjoint s t) :
    (∑ x ∈ s ∪ t, w x) = (∑ x ∈ s, w x) + (∑ x ∈ t, w x) := by
  rw [Finset.sum_union h]

/-- The zero-weight case of finite-sum additivity, without any division. -/
theorem mass_additive_zero_of_disjoint (h : Disjoint s t)
    (hs : ∑ x ∈ s, w x = 0) (ht : ∑ x ∈ t, w x = 0) :
    (∑ x ∈ s ∪ t, w x) = 0 := by
  rw [Finset.sum_union h, hs, ht, add_zero]

/-
Mass of a finite carrier equals the sum of the masses of two disjoint
pieces when those pieces cover the carrier. No denominator or conditional
probability is introduced.
-/
theorem mass_partition (hdisj : Disjoint s t) (hcover : s ∪ t = u) :
    (∑ x ∈ u, w x) = (∑ x ∈ s, w x) + (∑ x ∈ t, w x) := by
  rw [← hcover, Finset.sum_union hdisj]


/--
Zero-mass fibers contain only zero-weight points, provided all point weights
are nonnegative. This ratio-free lemma is the safe branch for empty or
zero-mass fibers; it does not introduce conditional probabilities or divide
by the fiber mass.
-/
theorem point_weight_eq_zero_of_mass_eq_zero
    (s : Finset α) (w : α → ℚ)
    (hw : ∀ x ∈ s, 0 ≤ w x)
    (hsum : (∑ x ∈ s, w x) = 0) :
    ∀ x ∈ s, w x = 0 := by
  intro x hx
  have hle : w x ≤ ∑ y ∈ s, w y :=
    Finset.single_le_sum (fun y hy => hw y hy) hx
  rw [hsum] at hle
  linarith [hw x hx]


end BBMSTAudit
