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


namespace BBMSTAudit

variable {α : Type*} [DecidableEq α]

/--
A strictly positive finite mass cannot be carried entirely by zero-weight
points. This is the ratio-free existence step needed before selecting a
positive-mass fiber; it avoids conditional probabilities and division by
a possibly zero denominator.
-/
theorem exists_positive_weight_of_positive_mass
    (s : Finset α) (w : α → ℚ)
    (hw : ∀ x ∈ s, 0 ≤ w x)
    (hs : 0 < ∑ x ∈ s, w x) :
    ∃ x ∈ s, 0 < w x := by
  by_contra h
  have hnot : ∀ x ∈ s, ¬ 0 < w x := by
    intro x hx
    intro hpos
    exact h ⟨x, hx, hpos⟩
  have hzero : ∀ x ∈ s, w x = 0 := by
    intro x hx
    have hle : w x ≤ 0 := le_of_not_gt (hnot x hx)
    linarith [hw x hx]
  have hsum : (∑ x ∈ s, w x) = 0 := by
    apply Finset.sum_eq_zero
    intro x hx
    exact hzero x hx
  linarith

#print axioms exists_positive_weight_of_positive_mass


end BBMSTAudit


namespace BBMSTAudit

variable {α : Type*} [DecidableEq α]

/--
For a finite carrier with nonnegative point weights, positive total mass is
equivalent to the existence of a positive-weight point. This packages both
directions into one interface for later fiber arguments and keeps the proof
division-free.
-/
theorem mass_pos_iff_exists_positive_weight
    (s : Finset α) (w : α → ℚ)
    (hw : ∀ x ∈ s, 0 ≤ w x) :
    0 < ∑ x ∈ s, w x ↔ ∃ x ∈ s, 0 < w x := by
  constructor
  · exact exists_positive_weight_of_positive_mass s w hw
  · rintro ⟨x, hx, hpos⟩
    have hle : w x ≤ ∑ y ∈ s, w y :=
      Finset.single_le_sum (fun y hy => hw y hy) hx
    linarith

#print axioms mass_pos_iff_exists_positive_weight

end BBMSTAudit
