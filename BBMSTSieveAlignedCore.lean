import Mathlib

/-!
# Source-safe BBMST sieve parameter core

This module formalizes only the representation and denominator-safety layer.
It does NOT prove the BBMST moment estimates, the square-free numerical
certificate, or the Erdős–Selfridge theorem.

The stage count is indexed by Fin n, so block sizes and distortion parameters
cannot have different lengths. The zero-distortion case uses the first-moment
bound and never evaluates the second-moment quotient.
-/

namespace BBMSTSieveAlignedCore

/-- Exactly aligned stage data with the source interval for distortion. -/
structure StageParameters (n : ℕ) where
  blockSize : Fin n → ℚ
  distortion : Fin n → ℚ
  blockSize_pos : ∀ i, 0 < blockSize i
  distortion_nonneg : ∀ i, 0 ≤ distortion i
  distortion_le_half : ∀ i, distortion i ≤ (1 / 2 : ℚ)

/-- The denominator in the second-moment contribution. -/
def secondMomentDenominator (δ : ℚ) : ℚ :=
  4 * δ * (1 - δ)

/-- A positive distortion parameter makes the second-moment denominator
strictly positive. -/
theorem secondMomentDenominator_pos {δ : ℚ}
    (hδ : 0 < δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    0 < secondMomentDenominator δ := by
  unfold secondMomentDenominator
  have hδlt : δ < 1 := by linarith
  have hcompl : 0 < 1 - δ := by linarith
  positivity

/-- The denominator is zero at zero distortion; this is why the quotient
branch must not be evaluated there. -/
theorem secondMomentDenominator_zero :
    secondMomentDenominator 0 = 0 := by
  norm_num [secondMomentDenominator]

/-- A stage contribution with the mathematically required zero branch:
at δ = 0 use only the first-moment estimate; for δ ≠ 0 use the minimum
of the first- and second-moment estimates. -/
def safeStageContribution (δ firstMoment secondMoment : ℚ) : ℚ :=
  if h : δ = 0 then firstMoment
  else min firstMoment (secondMoment / secondMomentDenominator δ)

/-- The zero-distortion branch is exactly the first-moment bound. -/
theorem safeStageContribution_zero (firstMoment secondMoment : ℚ) :
    safeStageContribution 0 firstMoment secondMoment = firstMoment := by
  simp [safeStageContribution]

/-- Every stage contribution is bounded above by its first-moment bound. -/
theorem safeStageContribution_le_first
    (δ firstMoment secondMoment : ℚ) :
    safeStageContribution δ firstMoment secondMoment ≤ firstMoment := by
  unfold safeStageContribution
  split
  · exact le_rfl
  · exact min_le_left _ _

/-- The aligned representation exposes a positive denominator for every
nonzero stage distortion. -/
theorem stage_denominator_pos {n : ℕ}
    (P : StageParameters n) (i : Fin n)
    (hδ : 0 < P.distortion i) :
    0 < secondMomentDenominator (P.distortion i) :=
  secondMomentDenominator_pos hδ (P.distortion_le_half i)

/-! Axiom audit for the foundational declarations in this module. -/
#print axioms secondMomentDenominator_pos
#print axioms secondMomentDenominator_zero
#print axioms safeStageContribution_zero
#print axioms safeStageContribution_le_first
#print axioms stage_denominator_pos

end BBMSTSieveAlignedCore
