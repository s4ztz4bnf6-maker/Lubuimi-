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
      · have hm := hmerge i
        cases h1 : H.assignment i with
        | none =>
          cases h2 : H'.assignment i with
          | none =>
            simpa [Hyperplane.Contains, mergeOldShadows, oldShadow, hb,
              h1, h2]
          | some t =>
            have hm' : x i = t := by
              simpa [Hyperplane.Contains, mergeOldShadows, hb, h1, h2] using hm
            simpa [Hyperplane.Contains, oldShadow, hb, h1, h2] using hm'
        | some s =>
          have hm' : x i = s := by
            simpa [Hyperplane.Contains, mergeOldShadows, hb, h1] using hm
          simpa [Hyperplane.Contains, oldShadow, hb, h1] using hm'
    · intro i
      by_cases hb : i = boundary
      · subst i
        simp [Hyperplane.Contains, oldShadow]
      · have hm := hmerge i
        cases h1 : H.assignment i with
        | none =>
          cases h2 : H'.assignment i with
          | none =>
            simpa [Hyperplane.Contains, mergeOldShadows, oldShadow, hb,
              h1, h2]
          | some t =>
            have hm' : x i = t := by
              simpa [Hyperplane.Contains, mergeOldShadows, hb, h1, h2] using hm
            simpa [Hyperplane.Contains, oldShadow, hb, h1, h2] using hm'
        | some s =>
          have hm' : x i = s := by
            simpa [Hyperplane.Contains, mergeOldShadows, hb, h1] using hm
          have hst : H'.assignment i = some s := by
            cases h2 : H'.assignment i with
            | none =>
              simp [Hyperplane.Contains, oldShadow, hb, h2] at hm'
              exact False.elim (by
                have hh := hmerge i
                simp [Hyperplane.Contains, mergeOldShadows, hb, h1, h2] at hh)
            | some t =>
              have hEq := hcompat i hb s t h1 h2
              subst t
              exact h2
          simpa [Hyperplane.Contains, oldShadow, hb, hst] using hm'
  · rintro ⟨hleft, hright⟩ i
    by_cases hb : i = boundary
    · subst i
      simp [Hyperplane.Contains, mergeOldShadows]
    · cases h1 : H.assignment i with
      | none =>
        cases h2 : H'.assignment i with
        | none =>
          simp [Hyperplane.Contains, mergeOldShadows, hb, h1, h2]
        | some t =>
          have ht : x i = t := by
            simpa [Hyperplane.Contains, oldShadow, hb, h2] using hright i
          simpa [Hyperplane.Contains, mergeOldShadows, hb, h1, h2] using ht
      | some s =>
        have hs : x i = s := by
          simpa [Hyperplane.Contains, oldShadow, hb, h1] using hleft i
        simpa [Hyperplane.Contains, mergeOldShadows, hb, h1] using hs

#print axioms mergeOldShadows_contains_iff

end BBMSTOldShadow
