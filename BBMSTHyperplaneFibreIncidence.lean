import Mathlib
import BBMSTGeometryStageCore
import BBMSTUniformFibreInstantiation
import BBMSTUniformStageMoment

/-!
# Hyperplane-induced uniform coordinate fibres

Unlike the abstract UniformFibre input, this module constructs its covered
set from the actual stage hyperplanes in the finite-coordinate geometry.
For a base point x and stage k, a next-coordinate value t is covered exactly
when some hyperplane entering at stage k contains x with coordinate k-1
replaced by t. Thus the covered proportion is an incidence count, not an
independent parameter.

This is a finite incidence bridge. It does not yet identify the resulting
base-point weights with the paper's recursively defined P_k.
-/

namespace BBMSTHyperplaneFibreIncidence

open BBMSTGeometry
open BBMSTUniformFibreInstantiation
open BBMSTUniformStageMoment

variable {n : ℕ} {C : CoordinateSystem n}

/-- The coordinate introduced at stage k (the k-th coordinate, in
one-based stage notation). -/
def stageCoordinate (k : ℕ) (hk : k ≤ n) (hk0 : 0 < k) : Fin n :=
  ⟨k - 1, by omega⟩

/-- Values of the new coordinate that are covered by at least one
hyperplane entering at stage k, above the old base point x. -/
noncomputable def stageCoveredValues
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) : Finset (C.S (stageCoordinate (C := C) k hk hk0)) := by
  classical
  let i := stageCoordinate (C := C) k hk hk0
  letI : Fintype (C.S i) := C.fintypeS i
  exact Finset.univ.filter fun t =>
    ∃ H ∈ newAtStage A k,
      H.Contains (Function.update x i t)

/-- Membership in the incidence set is exactly existence of a new
stage-k hyperplane containing the corresponding coordinate extension. -/
theorem mem_stageCoveredValues_iff
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C)
    (t : C.S (stageCoordinate (C := C) k hk hk0)) :
    t ∈ stageCoveredValues (C := C) A k hk hk0 x ↔
      ∃ H ∈ newAtStage A k,
        H.Contains (Function.update x
          (stageCoordinate (C := C) k hk hk0) t) := by
  classical
  simp [stageCoveredValues]

/-- The actual finite coordinate fibre induced by the stage hyperplanes.
Its covered subset is constructed from incidence, rather than supplied
as a free parameter. -/
noncomputable def stageUniformFibre
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) (baseMass : ℚ) (hbase : 0 ≤ baseMass) :
    UniformFibre (C.S (stageCoordinate (C := C) k hk hk0)) := by
  classical
  let i := stageCoordinate (C := C) k hk hk0
  letI : Fintype (C.S i) := C.fintypeS i
  refine
    { points := Finset.univ
      covered := stageCoveredValues (C := C) A k hk hk0 x
      total := baseMass
      points_nonempty := by
        have hcard : 0 < Fintype.card (C.S i) := by
          have := C.card_ge_two i
          omega
        exact Fintype.card_pos_iff.mp hcard
      covered_subset := Finset.subset_univ _
      total_nonneg := hbase }

/-- The fibre's covered proportion is the exact incidence density of
new stage-k hyperplanes above x. -/
theorem stageUniformFibre_proportion
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) (baseMass : ℚ) (hbase : 0 ≤ baseMass) :
    coveredProportion
      (stageUniformFibre (C := C) A k hk hk0 x baseMass hbase) =
      ((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
        (Fintype.card (C.S (stageCoordinate (C := C) k hk hk0)) : ℚ) := by
  rfl

/-- A finite base distribution together with the actual hyperplane-induced
coordinate fibres. The normalization is the only measure input here; the
fibre incidence itself is fixed by A and the stage geometry. -/
structure HyperplaneStageData
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k) where
  basePoints : Finset (ProductPoint C)
  baseWeight : ProductPoint C → ℚ
  baseWeight_nonneg : ∀ x ∈ basePoints, 0 ≤ baseWeight x
  baseWeight_sum_one : (∑ x ∈ basePoints, baseWeight x) = 1

/-- The actual hyperplane-incidence fibres form uniform finite-stage data. -/
noncomputable def toUniformFiniteStageData
    {A : Finset (Hyperplane C)} {k : ℕ}
    {hk : k ≤ n} {hk0 : 0 < k}
    (D : HyperplaneStageData (C := C) A k hk hk0) :
    UniformFiniteStageData
      (ι := ProductPoint C)
      (α := C.S (stageCoordinate (C := C) k hk hk0)) where
  indices := D.basePoints
  fibre := fun x =>
    stageUniformFibre (C := C) A k hk hk0 x
      (D.baseWeight x) (D.baseWeight_nonneg x)
  total_mass_one := D.baseWeight_sum_one

/-- The induced stage moment is the base-distribution average of the
actual cardinality fractions of hyperplane-covered next-coordinate values. -/
theorem actualStageFirstMoment_eq
    {A : Finset (Hyperplane C)} {k : ℕ}
    {hk : k ≤ n} {hk0 : 0 < k}
    (D : HyperplaneStageData (C := C) A k hk hk0) :
    uniformStageFirstMoment (toUniformFiniteStageData D) =
      ∑ x ∈ D.basePoints,
        D.baseWeight x *
          (((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
            (Fintype.card (C.S (stageCoordinate (C := C) k hk hk0)) : ℚ)) := by
  classical
  unfold uniformStageFirstMoment stageFirstMoment toFiniteStageData
    stageFirstMoment toFibreData
  simp [stageUniformFibre, coveredProportion, uniformWeight,
    stageCoordinate]

/-- The analogous exact second-moment incidence identity. -/
theorem actualStageSecondMoment_eq
    {A : Finset (Hyperplane C)} {k : ℕ}
    {hk : k ≤ n} {hk0 : 0 < k}
    (D : HyperplaneStageData (C := C) A k hk hk0) :
    uniformStageSecondMoment (toUniformFiniteStageData D) =
      ∑ x ∈ D.basePoints,
        D.baseWeight x *
          ((((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
            (Fintype.card (C.S (stageCoordinate (C := C) k hk hk0)) : ℚ)) ^ 2) := by
  classical
  unfold uniformStageSecondMoment stageSecondMoment toFiniteStageData
    stageSecondMoment toFibreData
  simp [stageUniformFibre, coveredProportion, uniformWeight,
    stageCoordinate]

#print axioms stageCoveredValues
#print axioms mem_stageCoveredValues_iff
#print axioms stageUniformFibre
#print axioms stageUniformFibre_proportion
#print axioms toUniformFiniteStageData
#print axioms actualStageFirstMoment_eq
#print axioms actualStageSecondMoment_eq

end BBMSTHyperplaneFibreIncidence
