import Mathlib

/-!
# Source-faithful BBMST hyperplane algebra

This module models the paper's product hyperplanes by partial coordinate
assignments. none means that a coordinate is unrestricted; some x means that
it is fixed to the value x.

The algebra here is independent of the Erdős–Selfridge sieve axioms. It formalizes
the coordinate-level geometry described by Balister–Bollobás–Morris–Sahasrabudhe–Tiba,
*The Erdős–Selfridge problem with square-free moduli*, pp. 609–610.
-/

namespace BBMSTAudit

universe u
variable {ι : Type u} [DecidableEq ι]
variable (S : ι → Type u) [∀ i, DecidableEq (S i)]

/-- A point in the product space. -/
abbrev ProductPoint := ∀ i, S i

/-- A hyperplane/cylinder: each coordinate is free or fixed to a value. -/
structure Hyperplane where
  fixed : ∀ i, Option (S i)

namespace Hyperplane

variable {S}

/-- The set of coordinates fixed by a partial assignment. -/
def fixedSet (A : Hyperplane S) : Set ι :=
  {i | ∃ x, A.fixed i = some x}

/-- Membership means agreement at every fixed coordinate. -/
def Contains (A : Hyperplane S) (p : ProductPoint S) : Prop :=
  ∀ i, match A.fixed i with
    | none => True
    | some x => p i = x

/-- Two assignments are compatible if they never prescribe different values
at the same coordinate. -/
def Compatible (A B : Hyperplane S) : Prop :=
  ∀ i, match A.fixed i, B.fixed i with
    | some x, some y => x = y
    | _, _ => True

/-- Coordinatewise union of partial assignments. If both sides fix a coordinate,
the left value is selected; compatibility guarantees it equals the right value. -/
def mergeAt {i : ι} (a b : Option (S i)) : Option (S i) :=
  match a, b with
  | none, v => v
  | v, none => v
  | some x, some _ => some x

/-- The partial assignment representing the intersection when assignments are
compatible. -/
def merge (A B : Hyperplane S) : Hyperplane S where
  fixed := fun i => mergeAt (A.fixed i) (B.fixed i)

theorem contains_iff_fixed_agreement (A : Hyperplane S) (p : ProductPoint S) :
    A.Contains p ↔ ∀ i x, A.fixed i = some x → p i = x := by
  constructor
  · intro h i x hi
    have hp := h i
    rw [hi] at hp
    exact hp
  · intro h i
    cases hAi : A.fixed i with
    | none => trivial
    | some x => exact h i x hAi

theorem incompatible_coordinate_disjoint
    (A B : Hyperplane S) (i : ι) (x y : S i)
    (hA : A.fixed i = some x) (hB : B.fixed i = some y) (hne : x ≠ y) :
    ¬ ∃ p : ProductPoint S, A.Contains p ∧ B.Contains p := by
  rintro ⟨p, hAp, hBp⟩
  have hpx : p i = x := (contains_iff_fixed_agreement A p).1 hAp i x hA
  have hpy : p i = y := (contains_iff_fixed_agreement B p).1 hBp i y hB
  exact hne (hpx.symm.trans hpy)

theorem merge_contains_iff (A B : Hyperplane S) (hcompat : A.Compatible B)
    (p : ProductPoint S) :
    (merge A B).Contains p ↔ A.Contains p ∧ B.Contains p := by
  constructor
  · intro hm
    constructor
    · intro i
      cases ha : A.fixed i with
      | none => trivial
      | some x =>
        cases hb : B.fixed i with
        | none =>
          have hi := hm i
          simpa [Contains, merge, mergeAt, ha, hb] using hi
        | some y =>
          have hi := hm i
          simpa [Contains, merge, mergeAt, ha, hb] using hi
    · intro i
      cases hb : B.fixed i with
      | none => trivial
      | some y =>
        cases ha : A.fixed i with
        | none =>
          have hi := hm i
          simpa [Contains, merge, mergeAt, ha, hb] using hi
        | some x =>
          have hxy : x = y := by
            simpa [Compatible, ha, hb] using hcompat i
          have hi := hm i
          simpa [Contains, merge, mergeAt, ha, hb, hxy] using hi
  · rintro ⟨ha, hb⟩ i
    dsimp [merge, mergeAt]
    cases hAi : A.fixed i with
    | none =>
      simpa [Contains, hAi] using hb i
    | some x =>
      cases hBi : B.fixed i with
      | none =>
        simpa [Contains, hAi, hBi] using ha i
      | some y =>
        have hxy : x = y := by
          simpa [Compatible, hAi, hBi] using hcompat i
        simpa [Contains, hAi, hBi, hxy] using ha i

theorem fixedSet_merge (A B : Hyperplane S) :
    (merge A B).fixedSet = A.fixedSet ∪ B.fixedSet := by
  ext i
  change (∃ x, mergeAt (A.fixed i) (B.fixed i) = some x) ↔
    (∃ x, A.fixed i = some x) ∨ (∃ y, B.fixed i = some y)
  cases ha : A.fixed i <;> cases hb : B.fixed i <;>
    simp [mergeAt, ha, hb]

end Hyperplane
end BBMSTAudit
