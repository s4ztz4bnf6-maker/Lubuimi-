import Mathlib

/-!
# Scalar bounds for residual covered mass in the BBMST fiber update

This file isolates the scalar inequality behind the active branch of the
BBMST fiber update. It does not prove the geometric incidence estimate or
the global sieve theorem.

Terminology is important: max 0 ((α - δ) / (1 - δ)) is the *residual
covered mass* after the update, not the amount of mass removed. The
distinction matters when this scalar lemma is connected to the source proof.
-/

namespace BBMSTAudit

/-- Residual covered mass after thresholding at δ and renormalizing. -/
def normalizedResidualCoveredMass (δ α : ℚ) : ℚ :=
  max 0 ((α - δ) / (1 - δ))

/-- Residual covered mass never exceeds the original covered fraction. -/
theorem normalizedResidualCoveredMass_le_alpha
    (α δ : ℚ) (hα0 : 0 ≤ α) (hα1 : α ≤ 1)
    (hδ0 : 0 < δ) (hδ1 : δ < 1) :
    normalizedResidualCoveredMass δ α ≤ α := by
  unfold normalizedResidualCoveredMass
  apply max_le
  · exact hα0
  · have hden : 0 < 1 - δ := by linarith
    rw [div_le_iff₀ hden]
    nlinarith [mul_nonneg (le_of_lt hδ0) (show 0 ≤ 1 - α by linarith)]

/--
Second-moment bound for residual covered mass:
rδ(α) ≤ α²/(4δ(1−δ)).
The proof explicitly uses δ>0 and δ<1, so no zero-denominator convention
can make the statement vacuous.
-/
theorem normalizedResidualCoveredMass_le_second_moment
    (α δ : ℚ) (hα0 : 0 ≤ α) (hα1 : α ≤ 1)
    (hδ0 : 0 < δ) (hδ1 : δ < 1) :
    normalizedResidualCoveredMass δ α ≤ α ^ 2 / (4 * δ * (1 - δ)) := by
  unfold normalizedResidualCoveredMass
  have hden1 : 0 < 1 - δ := by linarith
  have hden2 : 0 < 4 * δ * (1 - δ) := by positivity
  apply max_le
  · positivity
  · have hfrac :
        (α - δ) / (1 - δ) =
          (4 * δ * (α - δ)) / (4 * δ * (1 - δ)) := by
      field_simp [ne_of_gt hδ0, ne_of_gt hden1] <;> ring
    rw [hfrac]
    have hnum : 4 * δ * (α - δ) ≤ α ^ 2 := by
      nlinarith [sq_nonneg (α - 2 * δ)]
    apply (div_le_div_iff₀ hden2 hden2).2
    exact hnum

#print axioms normalizedResidualCoveredMass_le_alpha
#print axioms normalizedResidualCoveredMass_le_second_moment

end BBMSTAudit
