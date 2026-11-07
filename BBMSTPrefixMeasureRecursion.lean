import Mathlib
import BBMSTGeometryStageCore
import BBMSTFiberMeasureCore
import BBMSTUniformFibreInstantiation

/-!
# Source-indexed BBMST prefix measure recursion

This module defines the actual stage measure on the prefix spaces Q_(a+j).
The initial measure is an input on Q_a; each later point receives the
uniformly extended old point mass divided by the new coordinate size and
multiplied by the source's zero-safe covered/uncovered factor.

The file deliberately separates the definition from the normalization and
Lemma 2.1 proofs. No arbitrary fibre distribution is used to define alpha:
the covered values are computed from the geometric family newAtStage.
-/

namespace BBMSTPrefixMeasure

open BBMSTGeometry
open BBMSTFiberMeasureCore

variable {n : ℕ} (C : CoordinateSystem n)

/-- Every prefix product is finite. -/
noncomputable instance instFintypePrefixPoint {k : ℕ} (hk : k ≤ n) :
    Fintype (PrefixPoint C k hk) := by
  classical
  letI : ∀ i : Fin k, Fintype (C.S (prefixIndex hk i)) :=
    fun i => C.fintypeS (prefixIndex hk i)
  infer_instance

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

/-- Lifting and then restricting recovers the original prefix. -/
theorem projectPrefix_liftPrefix {k : ℕ} (hk : k ≤ n)
    (x : PrefixPoint C k hk) :
    projectPrefix hk (liftPrefix C hk x) = x := by
  funext j
  simp [projectPrefix, liftPrefix, prefixIndex, j.isLt]

/-- The coordinate introduced after a prefix of length k. -/
def stageCoordinate {k : ℕ} (hk : k + 1 ≤ n) : Fin n :=
  ⟨k, by omega⟩

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

/-- The historical fibre-cover proportion alpha_(k+1), computed from the
hyperplane family rather than supplied as a free parameter. -/
noncomputable def prefixAlpha
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) : ℚ := by
  letI := C.fintypeS (stageCoordinate hk)
  exact (prefixCoveredValues C (A := A) hk x).card /
    (Fintype.card (C.S (stageCoordinate hk)) : ℚ)

/-- Whether a point in Q_(k+1) lies in the newly covered part of its
old-coordinate fibre. -/
noncomputable def prefixPointCovered
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C (k + 1) hk) : Prop :=
  x (Fin.last k) ∈
    prefixCoveredValues C (A := A) hk (restrictPrefix C hk x)

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
      have hk : k + 1 ≤ n := by
        simpa only [k, Nat.add_succ] using hj
      have hprev : k ≤ n := by omega
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
    Function.update]


/-- Restricting an appended prefix recovers the original prefix. -/
theorem restrictPrefix_extendPrefix
    {k : ℕ} (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (s : C.S (stageCoordinate hk)) :
    restrictPrefix C hk (extendPrefix C hk x s) = x := by
  funext i
  simp [restrictPrefix, extendPrefix, projectPrefix, liftPrefix,
    prefixIndex, stageCoordinate, Function.update, i.isLt] <;> omega


/-- Restricting a prefix and appending its last coordinate recovers it. -/
theorem extendPrefix_restrictPrefix
    {k : ℕ} (hk : k + 1 ≤ n)
    (y : PrefixPoint C (k + 1) hk) :
    extendPrefix C hk (restrictPrefix C hk y) (y (Fin.last k)) = y := by
  funext i
  by_cases hi : i.val < k
  · simp [extendPrefix, restrictPrefix, projectPrefix, liftPrefix,
      prefixIndex, stageCoordinate, Function.update, hi]
  · have hiEq : i.val = k := by omega
    have hlast : i = Fin.last k := Fin.ext hiEq
    subst i
    simp [extendPrefix, restrictPrefix, projectPrefix, liftPrefix,
      prefixIndex, stageCoordinate, Function.update]

/-- The recursive covered predicate is exactly the existence of a
new-stage hyperplane containing the extended prefix. -/
theorem prefixPointCovered_iff
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (y : PrefixPoint C (k + 1) hk) :
    prefixPointCovered C (A := A) hk y ↔
      ∃ H ∈ newAtStage A (k + 1), H.ContainsPrefix hk y := by
  classical
  simp [prefixPointCovered, prefixCoveredValues,
    extendPrefix_restrictPrefix]

#print axioms extendPrefix_restrictPrefix
#print axioms prefixPointCovered_iff


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
      points_nonempty := ?_
      covered_subset := Finset.subset_univ _
      total_nonneg := hbase }
  exact ⟨Classical.choice (Fintype.card_pos_iff.mp hcard), Finset.mem_univ _⟩

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

/-- The abstract fibre proportion is definitionally the geometric
cardinality fraction prefixAlpha. -/
theorem prefixFibreData_proportion
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (baseMass : ℚ) (hbase : 0 ≤ baseMass) :
    (prefixFibreData C (A := A) hk x baseMass hbase).proportion =
      prefixAlpha C (A := A) hk x := by
  simp [prefixFibreData, prefixUniformFibre,
    BBMSTUniformFibreInstantiation.toFibreData,
    BBMSTUniformFibreInstantiation.coveredProportion,
    prefixAlpha]


/-- A length-(k+1) prefix is equivalent to its length-k restriction
together with its final coordinate. -/
noncomputable def prefixExtensionEquiv
    {k : ℕ} (hk : k + 1 ≤ n) :
    PrefixPoint C (k + 1) hk ≃
      (Σ x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk),
        C.S (stageCoordinate hk)) where
  toFun y := ⟨restrictPrefix C hk y, y (Fin.last k)⟩
  invFun p := extendPrefix C hk p.1 p.2
  left_inv y := extendPrefix_restrictPrefix C hk y
  right_inv p := by
    rcases p with ⟨x, s⟩
    simp [restrictPrefix_extendPrefix]

#print axioms prefixExtensionEquiv


/-- Reindexing the sum over length-(k+1) prefixes by the exact
restriction/final-coordinate equivalence. -/
theorem sum_prefix_eq_sum_extensions
    {k : ℕ} (hk : k + 1 ≤ n)
    (f : PrefixPoint C (k + 1) hk → ℚ) :
    (∑ y : PrefixPoint C (k + 1) hk, f y) =
      ∑ x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk),
        ∑ t : C.S (stageCoordinate hk),
          f (extendPrefix C hk x t) := by
  classical
  letI := C.fintypeS (stageCoordinate hk)
  let e := prefixExtensionEquiv C hk
  calc
    (∑ y : PrefixPoint C (k + 1) hk, f y) =
        ∑ p : Σ x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk),
            C.S (stageCoordinate hk),
          f (extendPrefix C hk p.1 p.2) := by
            apply Fintype.sum_equiv e
            intro y
            simp [e, extendPrefix_restrictPrefix]
    _ = ∑ x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk),
          ∑ t : C.S (stageCoordinate hk),
            f (extendPrefix C hk x t) := by
          exact Fintype.sum_sigma (fun x t => f (extendPrefix C hk x t))

#print axioms sum_prefix_eq_sum_extensions


end BBMSTPrefixMeasure
