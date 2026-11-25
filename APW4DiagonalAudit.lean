import Mathlib

namespace APW4DiagonalAudit

variable {X D : Type*}
variable [Fintype X] [Fintype D]

/--
Finite abstract core of the APW4 diagonal-majorization argument.

The coupling condition is deliberately exposed as the hypothesis
`hCoupling`; this theorem does not establish it for the historical APW4
construction.
-/
theorem diagonal_majorization
    (w P f : X → ℝ)
    (g : X → D → ℝ)
    (b : D → ℝ)
    (B : ℝ)
    (hw : ∀ x, w x ≤ P x)
    (hP : ∀ x, 0 ≤ P x)
    (hf : ∀ x, 0 ≤ f x)
    (hCoupling : ∀ x, f x ≤ ∑ d : D, g x d)
    (hMass : ∀ d, (∑ x : X, P x * g x d) ≤ b d)
    (hGeom : (∑ d : D, b d) ≤ B) :
    (∑ x : X, w x * f x) ≤ B := by
  calc
    (∑ x : X, w x * f x)
        ≤ ∑ x : X, P x * f x := by
          apply Finset.sum_le_sum
          intro x hx
          exact mul_le_mul_of_nonneg_right (hw x) (hf x)
    _ ≤ ∑ x : X, P x * (∑ d : D, g x d) := by
          apply Finset.sum_le_sum
          intro x hx
          exact mul_le_mul_of_nonneg_left (hCoupling x) (hP x)
    _ = ∑ d : D, ∑ x : X, P x * g x d := by
          simp_rw [Finset.mul_sum]
          exact Finset.sum_comm
    _ ≤ ∑ d : D, b d := by
          apply Finset.sum_le_sum
          intro d hd
          exact hMass d
    _ ≤ B := hGeom

#print axioms diagonal_majorization

end APW4DiagonalAudit
