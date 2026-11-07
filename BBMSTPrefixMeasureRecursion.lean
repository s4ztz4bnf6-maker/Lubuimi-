import Mathlib
import BBMSTGeometryStageCore
import BBMSTFiberMeasureCore

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
    (s : C.S (stageCoordinate C hk)) :
    PrefixPoint C (k + 1) hk :=
  projectPrefix hk
    (Function.update (liftPrefix C (Nat.le_trans (Nat.le_succ k) hk) x)
      (stageCoordinate C hk) s)

/-- The values of the new coordinate that are actually covered by a
hyperplane first appearing at stage k+1. -/
noncomputable def prefixCoveredValues
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) :
    Finset (C.S (stageCoordinate C hk)) := by
  classical
  letI := C.fintypeS (stageCoordinate C hk)
  exact Finset.univ.filter fun s =>
    ∃ H ∈ newAtStage A (k + 1),
      H.ContainsPrefix hk (extendPrefix C hk x s)

/-- The historical fibre-cover proportion alpha_(k+1), computed from the
hyperplane family rather than supplied as a free parameter. -/
noncomputable def prefixAlpha
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk)) : ℚ := by
  letI := C.fintypeS (stageCoordinate C hk)
  exact (prefixCoveredValues C A hk x).card /
    (Fintype.card (C.S (stageCoordinate C hk)) : ℚ)

/-- Whether a point in Q_(k+1) lies in the newly covered part of its
old-coordinate fibre. -/
noncomputable def prefixPointCovered
    {A : Finset (Hyperplane C)} {k : ℕ}
    (hk : k + 1 ≤ n)
    (x : PrefixPoint C (k + 1) hk) : Prop :=
  x (Fin.last k) ∈
    prefixCoveredValues C A hk (restrictPrefix C hk x)

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
      let k := a + j
      have hk : k + 1 ≤ n := by
        simpa [k, Nat.add_succ] using hj
      have hprev : k ≤ n := by omega
      letI := C.fintypeS (stageCoordinate C hk)
      let xprev := restrictPrefix C hk x
      let values := prefixCoveredValues C A hk xprev
      let α : ℚ := (values.card : ℚ) /
        (Fintype.card (C.S (stageCoordinate C hk)) : ℚ)
      let covered : Prop := x (Fin.last k) ∈ values
      exact
        (PAt C A a ha P0 δ j hprev xprev /
          (Fintype.card (C.S (stageCoordinate C hk)) : ℚ)) *
          (if covered then coveredMultiplier α (δ (stageCoordinate C hk))
            else uncoveredMultiplier α (δ (stageCoordinate C hk)))

end BBMSTPrefixMeasure
