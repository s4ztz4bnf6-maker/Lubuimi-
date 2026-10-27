import Mathlib

/-!
# BBMST scalar moment core

This file proves only the scalar inequality used in the removed-fiber estimate.
It does not formalize the evolving measure, the geometric hypotheses, or the
global sieve theorem. Those remain separate proof obligations.
-/

namespace BBMSTAudit

/-- The normalized removed fraction appearing in the BBMST stage update. -/
def normalizedRemovedMass (α δ : ℚ) : ℚ :=
  max 0 ((α - δ) / (1 - δ))

/-- The normalized removed fraction is at most the original fiber fraction. -/
theorem normalizedRemovedMass_le_alpha
    (α δ : ℚ)
    (hα_nonneg : 0 ≤ α) (hα_le_one : α ≤ 1)
    (hδ_pos : 0 < δ) (hδ_lt_one : δ < 1) :
    normalizedRemovedMass α δ ≤ α := by
  unfold normalizedRemovedMass
  have hden : 0 < 1 - δ := by linarith
  by_cases h : α ≤ δ
  · have hquot : (α - δ) / (1 - δ) ≤ 0 := by
      apply div_nonpos_of_nonpos_of_nonneg
      · linarith
      · linarith
    rw [max_eq_left hquot]
    exact hα_nonneg
  · have hδα : δ < α := lt_of_not_ge h
    have hquot : 0 ≤ (α - δ) / (1 - δ) :=
      le_of_lt (div_pos (by linarith) hden)
    rw [max_eq_right hquot]
    apply (div_le_iff₀ hden).2
    nlinarith [mul_nonneg hδ_pos (sub_nonneg.mpr hα_le_one)]

/--
Second-moment scalar bound:
  max(0, (α-δ)/(1-δ)) ≤ α²/(4δ(1-δ)).
The proof is split at α=δ, so endpoint behavior is explicit.
-/
theorem normalizedRemovedMass_le_secondMoment
    (α δ : ℚ)
    (hα_nonneg : 0 ≤ α) (hα_le_one : α ≤ 1)
    (hδ_pos : 0 < δ) (hδ_lt_one : δ < 1) :
    normalizedRemovedMass α δ ≤ α ^ 2 / (4 * δ * (1 - δ)) := by
  unfold normalizedRemovedMass
  have hden₁ : 0 < 1 - δ := by linarith
  have hden₂ : 0 < 4 * δ * (1 - δ) := by positivity
  by_cases h : α ≤ δ
  · have hquot : (α - δ) / (1 - δ) ≤ 0 := by
      apply div_nonpos_of_nonpos_of_nonneg
      · linarith
      · linarith
    rw [max_eq_left hquot]
    exact div_nonneg (sq_nonneg α) (le_of_lt hden₂)
  · have hδα : δ < α := lt_of_not_ge h
    have hquot : 0 ≤ (α - δ) / (1 - δ) :=
      le_of_lt (div_pos (by linarith) hden₁)
    rw [max_eq_right hquot]
    have hcore : 4 * δ * (α - δ) ≤ α ^ 2 := by
      nlinarith [sq_nonneg (α - 2 * δ)]
    apply (div_le_div_iff₀ hden₁ hden₂).2
    have hmul := mul_le_mul_of_nonneg_right hcore (le_of_lt hden₁)
    nlinarith

#print axioms BBMSTAudit.normalizedRemovedMass_le_alpha
#print axioms BBMSTAudit.normalizedRemovedMass_le_secondMoment

end BBMSTAudit
