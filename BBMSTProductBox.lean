import Mathlib

/-!
# Source-faithful product-box hyperplanes for BBMST

The published BBMST model uses a product box, not a finite-field affine
space. A hyperplane fixes selected coordinates to singleton values and leaves
all other coordinates unrestricted. This module formalizes that primitive
geometry only; it does not claim the global sieve estimates.
-/

universe u v

namespace BBMSTAudit

/-- A coordinate-fixing hyperplane in a dependent finite product box.
fixedCoords records the coordinates fixed to singleton values.
fixedValue stores a value for every coordinate; values outside the support
are ignored by event. -/
structure ProductBoxHyperplane
    (ι : Type u) [DecidableEq ι] (S : ι → Type v) where
  fixedCoords : Finset ι
  fixedValue : ∀ i, S i

/-- The subset of the product box specified by a coordinate-fixing
hyperplane. -/
def ProductBoxHyperplane.event
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    (H : ProductBoxHyperplane ι S) : Set (∀ i, S i) :=
  {x | ∀ i ∈ H.fixedCoords, x i = H.fixedValue i}

/-- Any point in two product-box hyperplanes forces their fixed values to
agree on every coordinate fixed by both hyperplanes. -/
theorem product_box_overlap_agreement
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    (H K : ProductBoxHyperplane ι S)
    (x : ∀ i, S i)
    (hxH : x ∈ H.event) (hxK : x ∈ K.event)
    {i : ι} (hiH : i ∈ H.fixedCoords) (hiK : i ∈ K.fixedCoords) :
    H.fixedValue i = K.fixedValue i := by
  exact (hxH i hiH).symm.trans (hxK i hiK)

/-- Conflicting singleton assignments on a shared fixed coordinate make
two product-box hyperplanes disjoint. This derives disjointness from the
actual coordinate constraints, rather than assuming a free parallelism
predicate. -/
theorem product_box_disjoint_of_conflict
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    (H K : ProductBoxHyperplane ι S)
    (hconflict : ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
      H.fixedValue i ≠ K.fixedValue i) :
    Disjoint H.event K.event := by
  rw [Set.disjoint_left]
  intro x hxH hxK
  obtain ⟨i, hiH, hiK, hne⟩ := hconflict
  have hagree := product_box_overlap_agreement H K x hxH hxK hiH hiK
  exact hne hagree

/-- In the published product-box model, parallelism is equality of the
sets of fixed coordinates. It is intentionally independent of the singleton
values assigned on those coordinates. -/
def ProductBoxHyperplane.Parallel
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    (H K : ProductBoxHyperplane ι S) : Prop :=
  H.fixedCoords = K.fixedCoords

theorem product_box_parallel_iff_fixed_coords_eq
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    (H K : ProductBoxHyperplane ι S) :
    H.Parallel K ↔ H.fixedCoords = K.fixedCoords := Iff.rfl

#print axioms product_box_overlap_agreement
#print axioms product_box_disjoint_of_conflict
#print axioms product_box_parallel_iff_fixed_coords_eq

end BBMSTAudit
