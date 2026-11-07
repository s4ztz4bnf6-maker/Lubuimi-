import Mathlib
import BBMSTGeometryStageCore

/-!
# Old-shadow geometry for BBMST stage hyperplanes

The newly exposed boundary coordinate is deleted before compatibility is
tested.  The merge theorem below is the exact set-theoretic intersection
identity needed before applying the BBMST profile bound.
-/

namespace BBMSTOldShadow

open BBMSTGeometry

variable {n : ℕ} {C : CoordinateSystem n}

/-- Delete the newly exposed coordinate from a partial assignment. -/
def oldShadow (boundary : Fin n) (H : Hyperplane C) : Hyperplane C :=
  ⟨fun i => if i = boundary then none else H.assignment i⟩

/-- Merge two old shadows, choosing the left assignment when present. -/
def mergeOldShadows (boundary : Fin n)
    (H H' : Hyperplane C) : Hyperplane C :=
  ⟨fun i =>
    if i = boundary then none else
      match H.assignment i with
      | some s => some s
      | none => H'.assignment i⟩

/-- Two assignments are compatible away from the removed boundary
coordinate exactly when they never prescribe different values there. -/
def OldCompatible (boundary : Fin n)
    (H H' : Hyperplane C) : Prop :=
  ∀ i, i ≠ boundary →
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
      by_cases hb : i = boundary
      · subst i
        simp [Hyperplane.Contains, oldShadow]
      · cases h1 : H.assignment i with
        | none =>
          simp [Hyperplane.Contains, oldShadow, hb, h1]
        | some s =>
          have hm := hmerge i
          simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
            hb, h1] using hm
    · intro i
      by_cases hb : i = boundary
      · subst i
        simp [Hyperplane.Contains, oldShadow]
      · cases h1 : H.assignment i with
        | none =>
          have hm := hmerge i
          simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
            hb, h1] using hm
        | some s =>
          cases h2 : H'.assignment i with
          | none =>
            simp [Hyperplane.Contains, oldShadow, hb, h2]
          | some t =>
            have hst := hcompat i hb s t h1 h2
            subst t
            have hm := hmerge i
            simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
              hb, h1, h2] using hm
  · rintro ⟨hleft, hright⟩ i
    by_cases hb : i = boundary
    · subst i
      simp [Hyperplane.Contains, mergeOldShadows]
    · cases h1 : H.assignment i with
      | none =>
        have hr := hright i
        simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
          hb, h1] using hr
      | some s =>
        have hl := hleft i
        simpa [Hyperplane.Contains, mergeOldShadows, oldShadow,
          hb, h1] using hl


/-- A conflict on an old coordinate makes the two old shadows disjoint. -/
theorem oldShadows_disjoint_of_conflict
    (boundary : Fin n) (H H' : Hyperplane C)
    (hconflict : ∃ i, i ≠ boundary ∧
      ∃ s t, H.assignment i = some s ∧
        H'.assignment i = some t ∧ s ≠ t) :
    ∀ x : ProductPoint C,
      ¬ ((oldShadow boundary H).Contains x ∧
        (oldShadow boundary H').Contains x) := by
  classical
  intro x hboth
  rcases hconflict with ⟨i, hib, s, t, hs, ht, hst⟩
  have hxs : x i = s := by
    simpa [Hyperplane.Contains, oldShadow, hib, hs] using hboth.1 i
  have hxt : x i = t := by
    simpa [Hyperplane.Contains, oldShadow, hib, ht] using hboth.2 i
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
  by_cases hb : i = boundary
  · subst i
    simp [fixedCoords, mergeOldShadows, oldShadow]
  · cases h1 : H.assignment i <;> cases h2 : H'.assignment i <;>
      simp [fixedCoords, mergeOldShadows, oldShadow, hb, h1, h2]


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
    by_cases hib : i = boundary
    · subst i
      simp [Hyperplane.Contains, hs, Function.update]
    · cases ha : H.assignment i with
      | none =>
        simp [Hyperplane.Contains, ha]
      | some v =>
        have hfixed : i ∈ fixedCoords H := by
          simp [fixedCoords, ha]
        have hlt := hInside i hfixed
        have hval : i.val < boundary.val := by
          have hne : i.val ≠ boundary.val := by
            intro heq
            exact hib (Fin.ext heq)
          omega
        have hx := hshadow i
        simpa [Hyperplane.Contains, oldShadow, hib, ha,
          Function.update, hib] using hx
  · rintro ⟨t, ht⟩
    intro i
    by_cases hib : i = boundary
    · subst i
      simp [Hyperplane.Contains, oldShadow]
    · cases ha : H.assignment i with
      | none =>
        simp [Hyperplane.Contains, oldShadow, ha]
      | some v =>
        have hfixed : i ∈ fixedCoords H := by
          simp [fixedCoords, ha]
        have hlt := hInside i hfixed
        have hval : i.val < boundary.val := by
          have hne : i.val ≠ boundary.val := by
            intro heq
            exact hib (Fin.ext heq)
          omega
        have hx := ht i
        simpa [Hyperplane.Contains, oldShadow, hib, ha,
          Function.update, hib] using hx

#print axioms mergeOldShadows_contains_iff
#print axioms oldShadow_contains_iff_exists_boundary_extension
#print axioms oldShadows_disjoint_of_conflict
#print axioms fixedCoords_mergeOldShadows

end BBMSTOldShadow
