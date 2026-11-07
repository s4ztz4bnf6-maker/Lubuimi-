import Mathlib
import BBMSTFiniteFibreUpdate

/-!
# Generic finite-stage moment inequalities

These are elementary bounds for a finite nonnegative rational weight and
an observable taking values in [0,1]. They are useful ingredients for a
later BBMST stage argument, but they are NOT the paper's stage-indexed
M_k^(1), M_k^(2) estimates: no hyperplane family, fibre geometry, or
BBMST counting constants occur here.
-/

namespace BBMSTStageMomentCore

open BBMSTFiniteFibreUpdate

variable {α : Type*} [DecidableEq α]

/-- First weighted moment of a bounded observable on a finite fibre. -/
def firstMoment (F : FibreData α) (X : α → ℚ) : ℚ :=
  fibreFirstMoment F X

/-- Second weighted moment of a bounded observable on a finite fibre. -/
def secondMoment (F : FibreData α) (X : α → ℚ) : ℚ :=
  fibreSecondMoment F X

/-- A nonnegative observable has a nonnegative first weighted moment. -/
theorem firstMoment_nonneg
    (F : FibreData α) (X : α → ℚ)
    (hX : ∀ x ∈ F.points, 0 ≤ X x) :
    0 ≤ firstMoment F X := by
  unfold firstMoment fibreFirstMoment fibreMoment
  apply Finset.sum_nonneg
  intro x hx
  exact mul_nonneg (F.weight_nonneg x hx) (hX x hx)

/-- The second weighted moment is nonnegative without a sign assumption
on the observable. -/
theorem secondMoment_nonneg
    (F : FibreData α) (X : α → ℚ) :
    0 ≤ secondMoment F X := by
  unfold secondMoment fibreSecondMoment fibreMoment
  apply Finset.sum_nonneg
  intro x hx
  exact mul_nonneg (F.weight_nonneg x hx) (sq_nonneg (X x))

/-- If 0 ≤ X ≤ 1 pointwise, then X² ≤ X pointwise and hence the second
weighted moment is at most the first. -/
theorem secondMoment_le_first
    (F : FibreData α) (X : α → ℚ)
    (hX : ∀ x ∈ F.points, 0 ≤ X x ∧ X x ≤ 1) :
    secondMoment F X ≤ firstMoment F X := by
  unfold secondMoment fibreSecondMoment fibreMoment
    firstMoment fibreFirstMoment
  apply Finset.sum_le_sum
  intro x hx
  have hnonneg := F.weight_nonneg x hx
  have hbound := hX x hx
  have hsq : X x ^ 2 ≤ X x := by nlinarith
  simpa [pow_one] using
    (mul_le_mul_of_nonneg_left hsq hnonneg)

/-- If 0 ≤ X ≤ 1 pointwise, its first weighted moment is bounded by the
total fibre mass. -/
theorem firstMoment_le_total
    (F : FibreData α) (X : α → ℚ)
    (hX : ∀ x ∈ F.points, 0 ≤ X x ∧ X x ≤ 1) :
    firstMoment F X ≤ F.total := by
  rw [← F.total_mass]
  unfold firstMoment fibreFirstMoment fibreMoment
  apply Finset.sum_le_sum
  intro x hx
  have hweight := F.weight_nonneg x hx
  have hbound := (hX x hx).2
  calc
    F.weight x * X x ≤ F.weight x * 1 :=
      mul_le_mul_of_nonneg_left hbound hweight
    _ = F.weight x := by ring

/-- Combining the preceding inequalities bounds both first and second
moments by the total mass. -/
theorem secondMoment_le_total
    (F : FibreData α) (X : α → ℚ)
    (hX : ∀ x ∈ F.points, 0 ≤ X x ∧ X x ≤ 1) :
    secondMoment F X ≤ F.total :=
  le_trans (secondMoment_le_first F X hX)
    (firstMoment_le_total F X hX)

/-! Axiom checks for the finite moment inequalities. -/
#print axioms firstMoment_nonneg
#print axioms secondMoment_nonneg
#print axioms secondMoment_le_first
#print axioms firstMoment_le_total
#print axioms secondMoment_le_total

end BBMSTStageMomentCore
