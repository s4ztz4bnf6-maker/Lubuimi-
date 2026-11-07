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

/-- The coordinate value assigned by a stage hyperplane. The fallback
value is used only for hyperplanes that do not fix the stage coordinate. -/
noncomputable def stageAssignedValue
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (H : Hyperplane C) :
    C.S (stageCoordinate (C := C) k hk hk0) := by
  classical
  let i := stageCoordinate (C := C) k hk hk0
  letI : Fintype (C.S i) := C.fintypeS i
  have hne : Nonempty (C.S i) := by
    have hcard : 0 < Fintype.card (C.S i) := by
      have := C.card_ge_two i
      omega
    exact Fintype.card_pos_iff.mp hcard
  exact if h : ∃ s, H.assignment i = some s then Classical.choose h
    else Classical.choice hne

/-- Each new stage hyperplane contributes at most one candidate value
in the new coordinate. -/
noncomputable def stageCandidateValues
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k) :
    Finset (C.S (stageCoordinate (C := C) k hk hk0)) := by
  classical
  exact (newAtStage A k).image (stageAssignedValue (C := C) A k hk hk0)

/-- Every actually covered coordinate value is contributed by a new
stage hyperplane. This is the finite union-bound interface underlying
the first step of Lemma 3.4. -/
theorem stageCoveredValues_subset_candidates
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) :
    stageCoveredValues (C := C) A k hk hk0 x ⊆
      stageCandidateValues (C := C) A k hk hk0 := by
  classical
  intro t ht
  rcases (mem_stageCoveredValues_iff (C := C) A k hk hk0 x t).mp ht with
    ⟨H, hH, hContains⟩
  let i := stageCoordinate (C := C) k hk hk0
  have hboundary := newAtStage_has_last_coordinate
    (C := C) A hk hk0 H hH
  rcases hboundary with ⟨j, hjval, hjfixed⟩
  have hji : j = i := by
    apply Fin.ext
    simp [i, stageCoordinate]
    omega
  subst j
  have hfixed : i ∈ fixedCoords H := hjfixed
  have hisSome : (H.assignment i).isSome := by
    simpa [fixedCoords] using hfixed
  obtain ⟨s, hs⟩ : ∃ s, H.assignment i = some s := by
    cases hassign : H.assignment i with
    | none => simp [hassign] at hisSome
    | some s => exact ⟨s, hassign⟩
  have hpoint := hContains i
  have hts : t = s := by
    simpa [Function.update_same, hs] using hpoint
  have hchosen :
      stageAssignedValue (C := C) A k hk hk0 H = s := by
    simp [stageAssignedValue, hs]
  apply Finset.mem_image.mpr
  refine ⟨H, hH, ?_⟩
  calc
    stageAssignedValue (C := C) A k hk hk0 H = s := hchosen
    _ = t := hts.symm

/-- The number of covered coordinate values is at most the number of
new stage hyperplanes, by the finite union bound. -/
theorem stageCoveredValues_card_le_newAtStage_card
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) :
    (stageCoveredValues (C := C) A k hk hk0 x).card ≤
      (newAtStage A k).card := by
  calc
    (stageCoveredValues (C := C) A k hk hk0 x).card
        ≤ (stageCandidateValues (C := C) A k hk hk0).card :=
      Finset.card_le_card
        (stageCoveredValues_subset_candidates (C := C) A k hk hk0 x)
    _ ≤ (newAtStage A k).card := Finset.card_image_le

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

/-- A coarse but fully geometric first-moment estimate: under any
normalized nonnegative base distribution, the mean fraction of covered
next-coordinate values is at most |N_k| / |S_k|. This is the direct
incidence-counting consequence of the fact that each new hyperplane fixes
the new coordinate to at most one value. -/
theorem actualStageFirstMoment_le_newHyperplaneRatio
    {A : Finset (Hyperplane C)} {k : ℕ}
    {hk : k ≤ n} {hk0 : 0 < k}
    (D : HyperplaneStageData (C := C) A k hk hk0) :
    uniformStageFirstMoment (toUniformFiniteStageData D) ≤
      ((newAtStage A k).card : ℚ) /
        (Fintype.card (C.S (stageCoordinate (C := C) k hk hk0)) : ℚ) := by
  classical
  let i := stageCoordinate (C := C) k hk hk0
  letI : Fintype (C.S i) := C.fintypeS i
  have hdenNat : 0 < Fintype.card (C.S i) := by
    have := C.card_ge_two i
    omega
  have hden : 0 < (Fintype.card (C.S i) : ℚ) := by
    exact_mod_cast hdenNat
  rw [actualStageFirstMoment_eq]
  calc
    (∑ x ∈ D.basePoints,
      D.baseWeight x *
        (((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ)))
      ≤ ∑ x ∈ D.basePoints,
        D.baseWeight x *
          (((newAtStage A k).card : ℚ) /
            (Fintype.card (C.S i) : ℚ)) := by
          apply Finset.sum_le_sum
          intro x hx
          have hcard :=
            stageCoveredValues_card_le_newAtStage_card
              (C := C) A k hk hk0 x
          have hcardQ :
              (stageCoveredValues (C := C) A k hk hk0 x).card
                ≤ (newAtStage A k).card := hcard
          have hfrac :
              ((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
                  (Fintype.card (C.S i) : ℚ)
                ≤ ((newAtStage A k).card : ℚ) /
                  (Fintype.card (C.S i) : ℚ) := by
            apply (div_le_div_iff_of_pos_right hden).2
            exact_mod_cast hcardQ
          exact mul_le_mul_of_nonneg_left hfrac
            (D.baseWeight_nonneg x hx)
    _ = ((newAtStage A k).card : ℚ) /
          (Fintype.card (C.S i) : ℚ) := by
          rw [← Finset.sum_mul, D.baseWeight_sum_one]
          ring

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
#print axioms stageAssignedValue
#print axioms stageCandidateValues
#print axioms stageCoveredValues_subset_candidates
#print axioms stageCoveredValues_card_le_newAtStage_card
#print axioms toUniformFiniteStageData
#print axioms actualStageFirstMoment_eq
#print axioms actualStageFirstMoment_le_newHyperplaneRatio
#print axioms actualStageSecondMoment_eq

end BBMSTHyperplaneFibreIncidence
