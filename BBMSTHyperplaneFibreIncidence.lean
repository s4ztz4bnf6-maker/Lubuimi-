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
open BBMSTStageMomentCore

variable {n : ℕ} {C : CoordinateSystem n}

/-- Classical equality instances for the finite product and coordinate fibres. -/
noncomputable instance instDecidableEqProductPoint :
    DecidableEq (ProductPoint C) := Classical.decEq _

noncomputable instance instDecidableEqCoordinate (i : Fin n) :
    DecidableEq (C.S i) := Classical.decEq _

noncomputable instance instFintypeCoordinate (i : Fin n) :
    Fintype (C.S i) := C.fintypeS i

/-- The coordinate introduced at stage k (the k-th coordinate, in
one-based stage notation). -/
def stageCoordinate (k : ℕ) (hk : k ≤ n) (hk0 : 0 < k) : Fin n :=
  ⟨k - 1, by omega⟩

/-- Values of the new coordinate that are covered by at least one
hyperplane entering at stage k, above the old base point x. -/
noncomputable def stageCoveredValues
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) : Finset (C.S (stageCoordinate k hk hk0)) := by
  classical
  let i := stageCoordinate k hk hk0
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
    (t : C.S (stageCoordinate k hk hk0)) :
    t ∈ stageCoveredValues (C := C) A k hk hk0 x ↔
      ∃ H ∈ newAtStage A k,
        H.Contains (Function.update x
          (stageCoordinate k hk hk0) t) := by
  classical
  simp [stageCoveredValues]

/-- The actual finite coordinate fibre induced by the stage hyperplanes.
Its covered subset is constructed from incidence, rather than supplied
as a free parameter. -/
noncomputable def stageUniformFibre
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) (baseMass : ℚ) (hbase : 0 ≤ baseMass) :
    UniformFibre (C.S (stageCoordinate k hk hk0)) := by
  classical
  let i := stageCoordinate k hk hk0
  letI : Fintype (C.S i) := C.fintypeS i
  refine
    { points := Finset.univ
      covered := stageCoveredValues (C := C) A k hk hk0 x
      total := baseMass
      points_nonempty := by
        have hcard : 0 < Fintype.card (C.S i) := by
          have := C.card_ge_two i
          omega
        exact ⟨Classical.choice (Fintype.card_pos_iff.mp hcard), Finset.mem_univ _⟩
      covered_subset := Finset.subset_univ _
      total_nonneg := hbase }

/-- The covered-value set depends only on the old coordinates
(indices strictly below k-1), not on the arbitrary suffix used to represent
a full product point. This is the finite-coordinate form of the fact that
the new stage hyperplanes are measurable with respect to the old prefix
together with the newly exposed coordinate. -/
theorem stageCoveredValues_eq_of_agree_before_stage
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x y : ProductPoint C)
    (hxy : ∀ j : Fin n, j.val < k - 1 → x j = y j) :
    stageCoveredValues (C := C) A k hk hk0 x =
      stageCoveredValues (C := C) A k hk hk0 y := by
  classical
  apply Finset.ext
  intro t
  rw [mem_stageCoveredValues_iff, mem_stageCoveredValues_iff]
  constructor
  · rintro ⟨H, hH, hContains⟩
    refine ⟨H, hH, ?_⟩
    intro j
    cases hassign : H.assignment j with
    | none => simp [hassign]
    | some s =>
        have hjfixed : j ∈ fixedCoords H := by
          simp [fixedCoords, hassign]
        have hstageMem : H ∈ stageFamily A k :=
          newAtStage_subset_stageFamily A k hH
        change H ∈ A.filter
          (fun H => ∀ q ∈ fixedCoords H, q.val < k) at hstageMem
        have hjlt : j.val < k :=
          (Finset.mem_filter.mp hstageMem).2 j hjfixed
        let i := stageCoordinate k hk hk0
        have hsame : Function.update x i t j =
            Function.update y i t j := by
          by_cases hji : j = i
          · subst j
            simp
          · have hjne : j.val ≠ k - 1 := by
              intro hval
              apply hji
              apply Fin.ext
              simpa [i, stageCoordinate] using hval
            have hjlt' : j.val < k - 1 := by omega
            simp [Function.update, hji, hxy j hjlt']
        have hvalue := hContains j
        simp only [hassign] at hvalue
        exact hsame.symm.trans hvalue
  · rintro ⟨H, hH, hContains⟩
    refine ⟨H, hH, ?_⟩
    intro j
    cases hassign : H.assignment j with
    | none => simp [hassign]
    | some s =>
        have hjfixed : j ∈ fixedCoords H := by
          simp [fixedCoords, hassign]
        have hstageMem : H ∈ stageFamily A k :=
          newAtStage_subset_stageFamily A k hH
        change H ∈ A.filter
          (fun H => ∀ q ∈ fixedCoords H, q.val < k) at hstageMem
        have hjlt : j.val < k :=
          (Finset.mem_filter.mp hstageMem).2 j hjfixed
        let i := stageCoordinate k hk hk0
        have hsame : Function.update y i t j =
            Function.update x i t j := by
          by_cases hji : j = i
          · subst j
            simp
          · have hjne : j.val ≠ k - 1 := by
              intro hval
              apply hji
              apply Fin.ext
              simpa [i, stageCoordinate] using hval
            have hjlt' : j.val < k - 1 := by omega
            simp [Function.update, hji, hxy j hjlt']
        have hvalue := hContains j
        simp only [hassign] at hvalue
        exact hsame.symm.trans hvalue

/-- The coordinate value assigned by a stage hyperplane. The fallback
value is used only for hyperplanes that do not fix the stage coordinate. -/
noncomputable def stageAssignedValue
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (H : Hyperplane C) :
    C.S (stageCoordinate k hk hk0) := by
  classical
  let i := stageCoordinate k hk hk0
  letI : Fintype (C.S i) := C.fintypeS i
  have hcard : 0 < Fintype.card (C.S i) := by
    have := C.card_ge_two i
    omega
  exact (H.assignment i).getD
    (Classical.choice (Fintype.card_pos_iff.mp hcard))

/-- A new stage hyperplane is compatible with x when its old-coordinate
constraints can be satisfied above x by some value of the new coordinate.
This is the finite version of x belonging to the shadow A_F^[k-1]. -/
noncomputable def stageCompatibleHyperplanes
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) : Finset (Hyperplane C) := by
  classical
  let i := stageCoordinate k hk hk0
  exact (newAtStage A k).filter fun H =>
    ∃ t, H.Contains (Function.update x i t)

/-- Each compatible new stage hyperplane contributes at most one candidate
value in the new coordinate. -/
noncomputable def stageCandidateValues
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) :
    Finset (C.S (stageCoordinate k hk hk0)) := by
  classical
  exact (stageCompatibleHyperplanes (C := C) A k hk hk0 x).image
    (stageAssignedValue (C := C) A k hk hk0)

/-- Every actually covered coordinate value is contributed by a new
stage hyperplane. This is the finite union-bound interface underlying
the first step of Lemma 3.4. -/
theorem stageCoveredValues_subset_candidates
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) :
    stageCoveredValues (C := C) A k hk hk0 x ⊆
      stageCandidateValues (C := C) A k hk hk0 x := by
  classical
  intro t ht
  rcases (mem_stageCoveredValues_iff (C := C) A k hk hk0 x t).mp ht with
    ⟨H, hH, hContains⟩
  let i := stageCoordinate k hk hk0
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
    | some s => exact ⟨s, rfl⟩
  have hpoint := hContains i
  have hpoint' : Function.update x i t i = s := by
    simpa only [hs] using hpoint
  have hts : t = s := by
    simpa [i, Function.update] using hpoint'
  have hchosen :
      stageAssignedValue (C := C) A k hk hk0 H = s := by
    simp [stageAssignedValue, i, hs]
  have hCompatible :
      H ∈ stageCompatibleHyperplanes (C := C) A k hk hk0 x := by
    apply Finset.mem_filter.mpr
    exact ⟨hH, ⟨t, hContains⟩⟩
  apply Finset.mem_image.mpr
  refine ⟨H, hCompatible, ?_⟩
  calc
    stageAssignedValue (C := C) A k hk hk0 H = s := hchosen
    _ = t := hts.symm

/-- The number of covered coordinate values is at most the number of
new stage hyperplanes, by the finite union bound. -/
theorem stageCoveredValues_card_le_compatible_card
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) :
    (stageCoveredValues (C := C) A k hk hk0 x).card ≤
      (stageCompatibleHyperplanes (C := C) A k hk hk0 x).card := by
  calc
    (stageCoveredValues (C := C) A k hk hk0 x).card
        ≤ (stageCandidateValues (C := C) A k hk hk0 x).card :=
      Finset.card_le_card
        (stageCoveredValues_subset_candidates (C := C) A k hk hk0 x)
    _ ≤ (stageCompatibleHyperplanes (C := C) A k hk hk0 x).card :=
      Finset.card_image_le

theorem stageCompatibleHyperplanes_card_le_newAtStage_card
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) :
    (stageCompatibleHyperplanes (C := C) A k hk hk0 x).card ≤
      (newAtStage A k).card := by
  classical
  unfold stageCompatibleHyperplanes
  exact Finset.card_le_card (Finset.filter_subset _ _)

/-- The fibre's covered proportion is the exact incidence density of
new stage-k hyperplanes above x. -/
theorem stageUniformFibre_proportion
    (A : Finset (Hyperplane C)) (k : ℕ)
    (hk : k ≤ n) (hk0 : 0 < k)
    (x : ProductPoint C) (baseMass : ℚ) (hbase : 0 ≤ baseMass) :
    coveredProportion
      (stageUniformFibre (C := C) A k hk hk0 x baseMass hbase) =
      ((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
        (Fintype.card (C.S (stageCoordinate k hk hk0)) : ℚ) := by
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
      (α := C.S (stageCoordinate k hk hk0)) := by
  classical
  let F : ProductPoint C →
      UniformFibre (C.S (stageCoordinate k hk hk0)) :=
    fun x =>
      let w := if x ∈ D.basePoints then D.baseWeight x else 0
      stageUniformFibre (C := C) A k hk hk0 x w (by
        dsimp [w]
        split_ifs with hx
        · exact D.baseWeight_nonneg x hx
        · norm_num)
  refine
    { indices := D.basePoints
      fibre := F
      total_mass_one := ?_ }
  calc
    (∑ x ∈ D.basePoints, (F x).total)
        = ∑ x ∈ D.basePoints, D.baseWeight x := by
            apply Finset.sum_congr rfl
            intro x hx
            simp [F, stageUniformFibre, hx]
    _ = 1 := D.baseWeight_sum_one

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
            (Fintype.card (C.S (stageCoordinate k hk hk0)) : ℚ)) := by
  classical
  simp [uniformStageFirstMoment, toFiniteStageData, toFibreData,
    toUniformFiniteStageData, stageFirstMoment, stageUniformFibre,
    coveredProportion, uniformWeight, stageCoordinate, Finset.card_univ]

/-- The first moment is bounded by the expected number of new
hyperplanes whose old-coordinate shadow contains the base point, divided
by the size of the new coordinate. This is the precise union-bound
intermediate in the proof of Lemma 3.4. -/
theorem actualStageFirstMoment_le_compatibleRatio
    {A : Finset (Hyperplane C)} {k : ℕ}
    {hk : k ≤ n} {hk0 : 0 < k}
    (D : HyperplaneStageData (C := C) A k hk hk0) :
    uniformStageFirstMoment (toUniformFiniteStageData D) ≤
      ∑ x ∈ D.basePoints,
        D.baseWeight x *
          (((stageCompatibleHyperplanes (C := C) A k hk hk0 x).card : ℚ) /
            (Fintype.card (C.S (stageCoordinate k hk hk0)) : ℚ)) := by
  classical
  let i := stageCoordinate k hk hk0
  letI : Fintype (C.S i) := C.fintypeS i
  have hdenNat : 0 < Fintype.card (C.S i) := by
    have := C.card_ge_two i
    omega
  have hden : 0 < (Fintype.card (C.S i) : ℚ) := by
    exact_mod_cast hdenNat
  rw [actualStageFirstMoment_eq]
  apply Finset.sum_le_sum
  intro x hx
  have hcard :=
    stageCoveredValues_card_le_compatible_card
      (C := C) A k hk hk0 x
  have hfrac :
      ((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ)
        ≤ ((stageCompatibleHyperplanes (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ) := by
    apply (div_le_div_iff_of_pos_right hden).2
    exact_mod_cast hcard
  exact mul_le_mul_of_nonneg_left hfrac
    (D.baseWeight_nonneg x hx)

/-- The classical coarse consequence follows by bounding every compatible
subfamily by all of N_k and using that the base weights sum to one. -/
theorem actualStageFirstMoment_le_newHyperplaneRatio
    {A : Finset (Hyperplane C)} {k : ℕ}
    {hk : k ≤ n} {hk0 : 0 < k}
    (D : HyperplaneStageData (C := C) A k hk hk0) :
    uniformStageFirstMoment (toUniformFiniteStageData D) ≤
      ((newAtStage A k).card : ℚ) /
        (Fintype.card (C.S (stageCoordinate k hk hk0)) : ℚ) := by
  classical
  let i := stageCoordinate k hk hk0
  letI : Fintype (C.S i) := C.fintypeS i
  have hdenNat : 0 < Fintype.card (C.S i) := by
    have := C.card_ge_two i
    omega
  have hden : 0 < (Fintype.card (C.S i) : ℚ) := by
    exact_mod_cast hdenNat
  calc
    uniformStageFirstMoment (toUniformFiniteStageData D)
      ≤ ∑ x ∈ D.basePoints,
          D.baseWeight x *
            (((stageCompatibleHyperplanes (C := C) A k hk hk0 x).card : ℚ) /
              (Fintype.card (C.S i) : ℚ)) :=
        actualStageFirstMoment_le_compatibleRatio D
    _ ≤ ∑ x ∈ D.basePoints,
          D.baseWeight x *
            (((newAtStage A k).card : ℚ) /
              (Fintype.card (C.S i) : ℚ)) := by
        apply Finset.sum_le_sum
        intro x hx
        have hcard :=
          stageCompatibleHyperplanes_card_le_newAtStage_card
            (C := C) A k hk hk0 x
        have hfrac :
            ((stageCompatibleHyperplanes (C := C) A k hk hk0 x).card : ℚ) /
                (Fintype.card (C.S i) : ℚ)
              ≤ ((newAtStage A k).card : ℚ) /
                (Fintype.card (C.S i) : ℚ) := by
          apply (div_le_div_iff_of_pos_right hden).2
          exact_mod_cast hcard
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
            (Fintype.card (C.S (stageCoordinate k hk hk0)) : ℚ)) ^ 2) := by
  classical
  simp [uniformStageSecondMoment, toFiniteStageData, toFibreData,
    toUniformFiniteStageData, stageSecondMoment, stageUniformFibre,
    coveredProportion, uniformWeight, stageCoordinate, Finset.card_univ]

/-- The second moment is bounded by the second moment of the number
of new hyperplanes whose old-coordinate shadows contain the base point,
divided by |S_k|. This is the t=2 union-bound step before the intersection
weights of Lemma 3.4 are inserted. -/
theorem actualStageSecondMoment_le_compatibleSquareAverage
    {A : Finset (Hyperplane C)} {k : ℕ}
    {hk : k ≤ n} {hk0 : 0 < k}
    (D : HyperplaneStageData (C := C) A k hk hk0) :
    uniformStageSecondMoment (toUniformFiniteStageData D) ≤
      ∑ x ∈ D.basePoints,
        D.baseWeight x *
          ((((stageCompatibleHyperplanes (C := C) A k hk hk0 x).card : ℚ) /
            (Fintype.card (C.S (stageCoordinate k hk hk0)) : ℚ)) ^ 2) := by
  classical
  let i := stageCoordinate k hk hk0
  letI : Fintype (C.S i) := C.fintypeS i
  have hdenNat : 0 < Fintype.card (C.S i) := by
    have := C.card_ge_two i
    omega
  have hden : 0 < (Fintype.card (C.S i) : ℚ) := by
    exact_mod_cast hdenNat
  rw [actualStageSecondMoment_eq]
  apply Finset.sum_le_sum
  intro x hx
  have hcard :=
    stageCoveredValues_card_le_compatible_card
      (C := C) A k hk hk0 x
  have hfrac :
      ((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ)
        ≤ ((stageCompatibleHyperplanes (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ) := by
    apply (div_le_div_iff_of_pos_right hden).2
    exact_mod_cast hcard
  have hleft0 :
      0 ≤ ((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
        (Fintype.card (C.S i) : ℚ) :=
    div_nonneg (Nat.cast_nonneg _) (le_of_lt hden)
  have hright0 :
      0 ≤ ((stageCompatibleHyperplanes (C := C) A k hk hk0 x).card : ℚ) /
        (Fintype.card (C.S i) : ℚ) :=
    div_nonneg (Nat.cast_nonneg _) (le_of_lt hden)
  have hsub :
      0 ≤ ((stageCompatibleHyperplanes (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ) -
        ((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ) := sub_nonneg.mpr hfrac
  have hadd :
      0 ≤ ((stageCompatibleHyperplanes (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ) +
        ((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ) := add_nonneg hright0 hleft0
  have hprod := mul_nonneg hsub hadd
  have hsq :
      (((stageCoveredValues (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ)) ^ 2
        ≤ (((stageCompatibleHyperplanes (C := C) A k hk hk0 x).card : ℚ) /
          (Fintype.card (C.S i) : ℚ)) ^ 2 := by
    nlinarith [hprod]
  exact mul_le_mul_of_nonneg_left hsq
    (D.baseWeight_nonneg x hx)

#print axioms stageCoveredValues
#print axioms mem_stageCoveredValues_iff
#print axioms stageCoveredValues_eq_of_agree_before_stage
#print axioms stageUniformFibre
#print axioms stageUniformFibre_proportion
#print axioms stageAssignedValue
#print axioms stageCandidateValues
#print axioms stageCoveredValues_subset_candidates
#print axioms stageCoveredValues_card_le_compatible_card
#print axioms stageCompatibleHyperplanes_card_le_newAtStage_card
#print axioms toUniformFiniteStageData
#print axioms actualStageFirstMoment_eq
#print axioms actualStageFirstMoment_le_compatibleRatio
#print axioms actualStageFirstMoment_le_newHyperplaneRatio
#print axioms actualStageSecondMoment_eq
#print axioms actualStageSecondMoment_le_compatibleSquareAverage

end BBMSTHyperplaneFibreIncidence
