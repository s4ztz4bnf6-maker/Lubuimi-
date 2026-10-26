import Mathlib

/-!
# Source-level scalar bound for the BBMST removed-fiber mass

This file isolates the elementary scalar inequality behind the two
competing bounds in the BBMST fiber update. It is not a proof of the
geometric incidence estimate or of the global sieve theorem.
-/

namespace BBMSTAudit

/-- Normalized removed mass for a covered fraction α and threshold δ. -/
def normalizedRemovedMass (δ α : ℚ) : ℚ :=
  max 0 ((α - δ) / (1 - δ))

/-- The removed fraction never exceeds the original covered fraction. -/
theorem normalizedRemovedMass_le_alpha
    (α δ : ℚ) (hα0 : 0 ≤ α) (hα1 : α ≤ 1)
    (hδ0 : 0 < δ) (hδ1 : δ < 1) :
    normalizedRemovedMass δ α ≤ α := by
  unfold normalizedRemovedMass
  apply max_le
  · exact hα0
  · have hden : 0 < 1 - δ := by linarith
    rw [div_le_iff₀ hden]
    nlinarith [mul_nonneg hδ0 (show 0 ≤ 1 - α by linarith)]

/--
The second-moment bound for the normalized removed mass:
gδ(α) ≤ α²/(4δ(1−δ)).
The proof explicitly uses δ>0 and δ<1, so no zero-denominator convention
can make the statement vacuous.
-/
theorem normalizedRemovedMass_le_second_moment
    (α δ : ℚ) (hα0 : 0 ≤ α) (hα1 : α ≤ 1)
    (hδ0 : 0 < δ) (hδ1 : δ < 1) :
    normalizedRemovedMass δ α ≤ α ^ 2 / (4 * δ * (1 - δ)) := by
  unfold normalizedRemovedMass
  have hden1 : 0 < 1 - δ := by linarith
  have hden2 : 0 < 4 * δ * (1 - δ) := by positivity
  apply max_le
  · positivity
  · have hfrac :
        (α - δ) / (1 - δ) =
          (4 * δ * (α - δ)) / (4 * δ * (1 - δ)) := by
      field_simp [ne_of_gt hδ0, ne_of_gt hden1] <;> ring
    rw [hfrac]
    apply (div_le_div_iff₀ hden2 hden2).2
    nlinarith [sq_nonneg (α - 2 * δ)]

#print axioms normalizedRemovedMass_le_alpha
#print axioms normalizedRemovedMass_le_second_moment

end BBMSTAudit
