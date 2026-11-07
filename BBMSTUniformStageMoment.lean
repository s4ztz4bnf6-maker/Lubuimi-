import Mathlib
import BBMSTStageMomentCore
import BBMSTUniformFibreInstantiation

/-!
# Uniform finite-stage moment bounds

This module composes the source-counting fibre construction with the
zero-safe finite-stage moment estimate. The stage observable is not an
arbitrary parameter: it is the actual cardinality fraction of the covered
values in the next coordinate, under uniform extension of the old
base-point mass.
-/

namespace BBMSTUniformStageMoment

open BBMSTFiniteFibreUpdate
open BBMSTUniformFibreInstantiation
open BBMSTStageMomentCore

variable {ι α : Type*} [DecidableEq ι] [DecidableEq α]

/-- A finite family of uniformly extended coordinate fibres. -/
structure UniformFiniteStageData where
  indices : Finset ι
  fibre : ι → UniformFibre α
  /-- The old measure on the stage base is a probability measure. -/
  total_mass_one : (∑ i ∈ indices, (fibre i).total) = 1

/-- The generic stage data obtained by deriving each fibre's mass and
covered proportion from its uniform counting definition. -/
def toFiniteStageData (S : UniformFiniteStageData (ι := ι) (α := α)) :
    FiniteStageData (ι := ι) (α := α) where
  indices := S.indices
  fibre := fun i => toFibreData (S.fibre i)
  total_mass_one := S.total_mass_one

/-- The uniform old base-point weights are normalized to total mass one. -/
theorem uniformStageTotalMass_eq_one
    (S : UniformFiniteStageData (ι := ι) (α := α)) :
    (∑ i ∈ S.indices, (S.fibre i).total) = 1 :=
  S.total_mass_one

/-- The stage first moment is exactly the weighted average of the
cardinality fractions |covered_i| / |points_i|. -/
def uniformStageFirstMoment
    (S : UniformFiniteStageData (ι := ι) (α := α)) : ℚ :=
  stageFirstMoment (toFiniteStageData S)

/-- The stage second moment is exactly the weighted average of the squares
of the cardinality fractions |covered_i| / |points_i|. -/
def uniformStageSecondMoment
    (S : UniformFiniteStageData (ι := ι) (α := α)) : ℚ :=
  stageSecondMoment (toFiniteStageData S)

/-- The actual removed mass in the uniform-coordinate stage. -/
def uniformStageRemovedMass
    (S : UniformFiniteStageData (ι := ι) (α := α)) (δ : ℚ) : ℚ :=
  stageRemovedMass (toFiniteStageData S) δ

/-- The zero-safe BBMST Theorem 3.1 moment bound for a finite family of
uniform coordinate fibres. At zero distortion it uses only the first
moment; at positive distortion it uses the minimum of the first and
second moment bounds. -/
theorem uniformStageRemovedMass_le_zeroSafeMomentBound
    (S : UniformFiniteStageData (ι := ι) (α := α)) (δ : ℚ)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    uniformStageRemovedMass S δ ≤
      if δ = 0 then uniformStageFirstMoment S
      else min (uniformStageFirstMoment S)
        (uniformStageSecondMoment S / (4 * δ * (1 - δ))) := by
  simpa [uniformStageRemovedMass, uniformStageFirstMoment,
    uniformStageSecondMoment, stageZeroSafeMomentBound,
    toFiniteStageData] using
    stageRemovedMass_le_zeroSafeMomentBound
      (toFiniteStageData S) δ hδ hδhalf

#print axioms toFiniteStageData
#print axioms uniformStageTotalMass_eq_one
#print axioms uniformStageFirstMoment
#print axioms uniformStageSecondMoment
#print axioms uniformStageRemovedMass
#print axioms uniformStageRemovedMass_le_zeroSafeMomentBound

end BBMSTUniformStageMoment
