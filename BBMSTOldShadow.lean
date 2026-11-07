import Mathlib
import BBMSTGeometryStageCore

/-!
# Old-shadow geometry for BBMST stage hyperplanes

An old shadow retains precisely the coordinates strictly before the newly
exposed boundary.  Both the boundary coordinate and the entire suffix are
discarded before compatibility is tested.
-/

namespace BBMSTOldShadow

open BBMSTGeometry

variable {n : ℕ} {C : CoordinateSystem n}

/-- Restrict a partial assignment to coordinates strictly before boundary. -/
def oldShadow (boundary : Fin n) (H : Hyperplane C) : Hyperplane C :=
  ⟨fun i => if i.val < boundary.val then H.assignment i else none⟩

/-- Merge two old shadows, choosing the left assignment when present. -/
def mergeOldShadows (boundary : Fin n)
    (H H' : Hyperplane C) : Hyperplane C :=
  ⟨fun i =>
    if i.val < boundary.val then
      match H.assignment i with
      | some s => some s
      | none => H'.assignment i
    else none⟩

/-- Compatibility is tested only on the retained old coordinates. -/
def OldCompatible (boundary : Fin n)
    (H H' : Hyperplane C) : Prop :=
  ∀ i, i.val < boundary.val →
    ∀ s t, H.assignment i = some s →
      H'.assignment i = some t → s = t

/-- The merged old shadow is precisely the intersection of the two old
shadows, expressed as equality of their point predicates. -/
theorem mergeOldShadows_contains_iff
    (boundary : Fin n) (H H' : Hyperplane C)
    (hcompat : OldCompatible boundary H H')
    (x : ProductPoint C) :
    (mergeOldShadows boundary H H').Contains x ↔
      (oldShadow boundary H).Contains x ∧
      (oldShadow boundary H').Contains x := by
  classical
  constructor
  · intro hmerge
    constructor
    · intro i
      by_cases hlt : i.val < boundary.val
      · cases h1 : H.assignment i with
        | none =>
          simp [Hyperplane.Contains, oldShadow, hlt, h1]
        | some s =>
          have hm := hmerge i
          simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
            hlt, h1] using hm
      · simp [Hyperplane.Contains, oldShadow, hlt]
    · intro i
      by_cases hlt : i.val < boundary.val
      · cases h1 : H.assignment i with
        | none =>
          have hm := hmerge i
          simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
            hlt, h1] using hm
        | some s =>
          cases h2 : H'.assignment i with
          | none =>
            simp [Hyperplane.Contains, oldShadow, hlt, h2]
          | some t =>
            have hst := hcompat i hlt s t h1 h2
            subst t
            have hm := hmerge i
            simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
              hlt, h1, h2] using hm
      · simp [Hyperplane.Contains, oldShadow, hlt]
  · rintro ⟨hleft, hright⟩ i
    by_cases hlt : i.val < boundary.val
    · cases h1 : H.assignment i with
      | none =>
        have hr := hright i
        simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
          hlt, h1] using hr
      | some s =>
        have hl := hleft i
        simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
          hlt, h1] using hl
    · simp [Hyperplane.Contains, mergeOldShadows, hlt]

/-- A conflict on a retained old coordinate makes the two old shadows
disjoint. -/
theorem oldShadows_disjoint_of_conflict
    (boundary : Fin n) (H H' : Hyperplane C)
    (hconflict : ∃ i, i.val < boundary.val ∧
      ∃ s t, H.assignment i = some s ∧
        H'.assignment i = some t ∧ s ≠ t) :
    ∀ x : ProductPoint C,
      ¬ ((oldShadow boundary H).Contains x ∧
        (oldShadow boundary H').Contains x) := by
  classical
  intro x hboth
  rcases hconflict with ⟨i, hlt, s, t, hs, ht, hst⟩
  have hxs : x i = s := by
    simpa [Hyperplane.Contains, oldShadow, hlt, hs] using hboth.1 i
  have hxt : x i = t := by
    simpa [Hyperplane.Contains, oldShadow, hlt, ht] using hboth.2 i
  exact hst (hxs.symm.trans hxt)

/-- The fixed-coordinate set of the merged shadow is the union of the
fixed-coordinate sets of the two old shadows. -/
theorem fixedCoords_mergeOldShadows
    (boundary : Fin n) (H H' : Hyperplane C) :
    fixedCoords (mergeOldShadows boundary H H') =
      fixedCoords (oldShadow boundary H) ∪
        fixedCoords (oldShadow boundary H') := by
  classical
  ext i
  by_cases hlt : i.val < boundary.val
  · cases h1 : H.assignment i <;> cases h2 : H'.assignment i <;>
      simp [fixedCoords, mergeOldShadows, oldShadow, hlt, h1, h2]
  · simp [fixedCoords, mergeOldShadows, oldShadow, hlt]

/-- For a hyperplane supported in the prefix ending at the boundary and
fixing that boundary, membership in its old shadow is equivalent to
membership after some choice of the newly exposed coordinate. -/
theorem oldShadow_contains_iff_exists_boundary_extension
    (boundary : Fin n) (H : Hyperplane C)
    (hBoundary : ∃ s, H.assignment boundary = some s)
    (hInside : H.FixedInsidePrefix (boundary.val + 1))
    (x : ProductPoint C) :
    (oldShadow boundary H).Contains x ↔
      ∃ t, H.Contains (Function.update x boundary t) := by
  classical
  constructor
  · intro hshadow
    rcases hBoundary with ⟨s, hs⟩
    refine ⟨s, ?_⟩
    intro i
    by_cases hlt : i.val < boundary.val
    · cases ha : H.assignment i with
      | none => simp [Hyperplane.Contains, ha]
      | some v =>
        have hx := hshadow i
        simpa [Hyperplane.Contains, oldShadow, hlt, ha,
          Function.update] using hx
    · by_cases heq : i = boundary
      · subst i
        simp [Hyperplane.Contains, hs, Function.update]
      · have hfixed : i ∈ fixedCoords H := by
          cases ha : H.assignment i with
          | none => simp [fixedCoords, ha]
          | some v => simp [fixedCoords, ha]
        have hi := hInside i hfixed
        have hnone : H.assignment i = none := by
          cases ha : H.assignment i with
          | none => exact ha
          | some v =>
            have hval : i.val < boundary.val + 1 := hi
            have hnotlt : ¬ i.val < boundary.val := hlt
            have hneq : i.val ≠ boundary.val := by
              intro he
              exact heq (Fin.ext he)
            omega
        simp [Hyperplane.Contains, hnone]
  · rintro ⟨t, ht⟩
    intro i
    by_cases hlt : i.val < boundary.val
    · have hi := ht i
      simpa [Hyperplane.Contains, oldShadow, hlt,
        Function.update] using hi
    · simp [Hyperplane.Contains, oldShadow, hlt]

#print axioms mergeOldShadows_contains_iff
#print axioms oldShadows_disjoint_of_conflict
#print axioms fixedCoords_mergeOldShadows
#print axioms oldShadow_contains_iff_exists_boundary_extension

end BBMSTOldShadow
