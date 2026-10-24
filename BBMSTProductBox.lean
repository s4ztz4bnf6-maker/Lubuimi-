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

/-- Exact overlap classification: two product-box hyperplanes intersect if
and only if their singleton assignments never conflict on a coordinate fixed
by both. The construction uses H's assigned values as defaults on free
coordinates, so no separate nonemptiness hypothesis on the coordinate types
is needed. -/
theorem product_box_events_intersect_iff_no_conflict
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    (H K : ProductBoxHyperplane ι S) :
    (H.event ∩ K.event).Nonempty ↔
      ¬ ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
        H.fixedValue i ≠ K.fixedValue i := by
  constructor
  · rintro ⟨x, hx⟩ hconflict
    obtain ⟨i, hiH, hiK, hne⟩ := hconflict
    have hagree :=
      product_box_overlap_agreement H K x hx.1 hx.2 hiH hiK
    exact hne hagree
  · intro hno
    classical
    let x : ∀ i, S i := fun i =>
      if hiH : i ∈ H.fixedCoords then H.fixedValue i
      else if hiK : i ∈ K.fixedCoords then K.fixedValue i
      else H.fixedValue i
    refine ⟨x, ?_⟩
    constructor
    · intro i hiH
      simp [x, hiH]
    · intro i hiK
      dsimp [x]
      by_cases hiH : i ∈ H.fixedCoords
      · have hEq : H.fixedValue i = K.fixedValue i := by
          by_contra hne
          exact hno ⟨i, hiH, hiK, hne⟩
        simp [hiH, hEq]
      · simp [hiH, hiK]

#print axioms product_box_overlap_agreement
#print axioms product_box_disjoint_of_conflict
#print axioms product_box_parallel_iff_fixed_coords_eq
#print axioms product_box_events_intersect_iff_no_conflict


/-- Disjointness is exactly the existence of a conflicting singleton
assignment on a shared fixed coordinate. This is the dual form of the
intersection criterion and gives the later sieve argument a direct
disjointness test without an independent parallelism axiom. -/
theorem product_box_events_disjoint_iff_conflict
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    (H K : ProductBoxHyperplane ι S) :
    Disjoint H.event K.event ↔
      ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
        H.fixedValue i ≠ K.fixedValue i := by
  constructor
  · intro hdisj
    by_contra hno
    have hinter :
        (H.event ∩ K.event).Nonempty :=
      (product_box_events_intersect_iff_no_conflict H K).2 hno
    rcases hinter with ⟨x, hx⟩
    exact (Set.disjoint_left.mp hdisj) x hx.1 hx.2
  · exact product_box_disjoint_of_conflict H K

#print axioms product_box_events_disjoint_iff_conflict


end BBMSTAudit
