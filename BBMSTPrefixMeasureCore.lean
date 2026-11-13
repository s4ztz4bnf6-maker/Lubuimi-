import Mathlib
import BBMSTGeometryStageCore
import BBMSTFiberMeasureCore
import BBMSTFiniteFibreUpdate
import BBMSTUniformFibreInstantiation

/-!
# Independent BBMST prefix measure core

The declaration source line references used for this extraction refer to
BBMSTPrefixMeasureRecursion.lean at the extraction base commit. They are
source locations in the original module, not line numbers in this file.
-/

namespace BBMSTPrefixMeasure

open BBMSTGeometry
open BBMSTFiberMeasureCore

variable {n : ℕ} (C : CoordinateSystem n)

/-- The coordinate system supplies finite coordinate types. -/
noncomputable instance instFintypeCoordinate (i : Fin n) : Fintype (C.S i) :=
  C.fintypeS i

/-- Classical equality on each finite coordinate type, needed for its Finset fibre. -/
noncomputable instance instDecidableEqCoordinate (i : Fin n) :
    DecidableEq (C.S i) := Classical.decEq _

/-- A fixed default value in each coordinate, used only to lift a prefix
to the full product. The cardinality hypothesis guarantees it exists. -/
noncomputable def coordinateDefault (i : Fin n) : C.S i := by
  letI := C.fintypeS i
  have hcard : 0 < Fintype.card (C.S i) := by
    have h := C.card_ge_two i
    omega
  exact Classical.choice (Fintype.card_pos_iff.mp hcard)

/-- Extend a prefix to the full product by filling every later coordinate
with its fixed default value. -/
noncomputable def liftPrefix {k : ℕ} (hk : k ≤ n)
    (x : PrefixPoint C k hk) : ProductPoint C :=
  fun i =>
    if h : i.val < k then
      let j : Fin k := ⟨i.val, h⟩
      Eq.mp (congrArg C.S (Fin.ext rfl)) (x j)
    else
      coordinateDefault C i

/-- The coordinate introduced after a prefix of length k. -/
def stageCoordinate {k : ℕ} (hk : k + 1 ≤ n) : Fin n :=
  prefixIndex hk (Fin.last k)

/-- The new coordinate is independent of the proof witness for the
prefix bound. This named transport lemma aligns dependent fibre indices. -/
theorem stageCoordinate_eq_of_bound
    {k : ℕ} (h₁ h₂ : k + 1 ≤ n) :
    stageCoordinate h₁ = stageCoordinate h₂ := by
  apply Fin.ext
  rfl

/-- Canonical proof of the next-prefix bound, shared by the recursive
measure definition and its pointwise fibre update theorem. -/
theorem nextPrefixBound
    (a j : ℕ) (hj : a + (j + 1) ≤ n) :
    a + j + 1 ≤ n := by
  omega

/-- Canonical proof of the predecessor-prefix bound, shared by the recursive
measure definition and its pointwise fibre update theorem. -/
theorem previousPrefixBound
    (a j : ℕ) (hj : a + (j + 1) ≤ n) :
    a + j ≤ n := by
  omega

/-- Restrict a prefix of length k+1 to its first k coordinates. -/
noncomputable def restrictPrefix {k : ℕ} (hk : k + 1 ≤ n)
    (x : PrefixPoint C (k + 1) hk) :
    PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk) :=
  projectPrefix (Nat.le_trans (Nat.le_succ k) hk) (liftPrefix C hk x)

/-- Append one coordinate to a prefix. This is defined by lifting to the
full product, updating exactly the new coordinate, and projecting back. -/
noncomputable def extendPrefix {k : ℕ} (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (s : C.S (stageCoordinate hk)) :
    PrefixPoint C (k + 1) hk :=
  projectPrefix hk
    (Function.update (liftPrefix C (Nat.le_trans (Nat.le_succ k) hk) x)
      (stageCoordinate hk) s)

/-- The values of the new coordinate that are actually covered by a
hyperplane first appearing at stage k+1. -/
noncomputable def prefixCoveredValues
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) :
    Finset (C.S (stageCoordinate hk)) := by
  classical
  letI := C.fintypeS (stageCoordinate hk)
  exact Finset.univ.filter fun s =>
    ∃ H ∈ newAtStage A (k + 1),
      H.ContainsPrefix hk (extendPrefix C hk x s)

/-- The recursively defined measure P_(a+j) on Q_(a+j), extended by the
source's uniform-coordinate update at each stage. The index j counts stages
after the initial prefix a. -/
noncomputable def PAt
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ)
    (δ : Fin n → ℚ) :
    (j : ℕ) → (hj : a + j ≤ n) →
      PrefixPoint C (a + j) hj → ℚ
  | 0, hj, x => P0 x
  | j + 1, hj, x => by
      classical
      let k := a + j
      have hk : k + 1 ≤ n := nextPrefixBound a j hj
      have hprev : k ≤ n := previousPrefixBound a j hj
      letI := C.fintypeS (stageCoordinate hk)
      let xprev := restrictPrefix C hk x
      let values := prefixCoveredValues C (A := A) hk xprev
      let α : ℚ := (values.card : ℚ) /
        (Fintype.card (C.S (stageCoordinate hk)) : ℚ)
      let covered : Prop := x (Fin.last k) ∈ values
      exact
        (PAt (A := A) a ha P0 δ j hprev xprev /
          (Fintype.card (C.S (stageCoordinate hk)) : ℚ)) *
          (if covered then coveredMultiplier α (δ (stageCoordinate hk))
            else uncoveredMultiplier α (δ (stageCoordinate hk)))

/-- Appending a coordinate writes exactly that value at the new
boundary coordinate. -/
theorem extendPrefix_last
    {k : ℕ} (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (s : C.S (stageCoordinate hk)) :
    (extendPrefix C hk x s) (Fin.last k) = s := by
  simp [extendPrefix, projectPrefix, prefixIndex, stageCoordinate,
    Function.update] <;> rfl

/-- Restricting a prefix and appending its last coordinate recovers it. -/
theorem extendPrefix_restrictPrefix
    {k : ℕ} (hk : k + 1 ≤ n)
    (y : PrefixPoint C (k + 1) hk) :
    extendPrefix C hk (restrictPrefix C hk y) (y (Fin.last k)) = y := by
  funext i
  by_cases hi : i.val < k
  · have hne : i.val ≠ k := by omega
    have hle : i.val ≤ k := Nat.le_of_lt hi
    have hhi : i.val < k + 1 := i.isLt
    simp [extendPrefix, restrictPrefix, projectPrefix, liftPrefix,
      prefixIndex, stageCoordinate, Function.update, hi, hne, hle, hhi] <;> rfl
  · have hiEq : i.val = k :=
      Nat.le_antisymm (Nat.lt_succ_iff.mp i.isLt)
        (Nat.le_of_not_gt hi)
    have hlast : i = Fin.last k := Fin.ext hiEq
    subst i
    exact extendPrefix_last C hk (restrictPrefix C hk y) (y (Fin.last k))

/-- The concrete geometric prefix fibre, with all next-coordinate values
as points and the actual newly covered values as its covered subset. -/
noncomputable def prefixUniformFibre
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (baseMass : ℚ) (hbase : 0 ≤ baseMass) :
    BBMSTUniformFibreInstantiation.UniformFibre
      (C.S (stageCoordinate hk)) := by
  classical
  letI := C.fintypeS (stageCoordinate hk)
  have hcard : 0 < Fintype.card (C.S (stageCoordinate hk)) := by
    have h := C.card_ge_two (stageCoordinate hk)
    omega
  refine
    { points := Finset.univ
      covered := prefixCoveredValues C (A := A) hk x
      total := baseMass
      points_nonempty := by
        obtain ⟨s⟩ := Fintype.card_pos_iff.mp hcard
        exact ⟨s, Finset.mem_univ s⟩
      covered_subset := Finset.subset_univ _
      total_nonneg := hbase }

/-- The concrete prefix fibre converted to the weighted update interface.
Its covered set is the actual geometric prefixCoveredValues set. -/
noncomputable def prefixFibreData
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (baseMass : ℚ) (hbase : 0 ≤ baseMass) :
    BBMSTFiniteFibreUpdate.FibreData
      (C.S (stageCoordinate hk)) :=
  BBMSTUniformFibreInstantiation.toFibreData
    (prefixUniformFibre C (A := A) hk x baseMass hbase)

#print axioms coordinateDefault
#print axioms prefixCoveredValues
#print axioms PAt
#print axioms prefixUniformFibre
#print axioms prefixFibreData

end BBMSTPrefixMeasure
