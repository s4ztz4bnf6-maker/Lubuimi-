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
        simp [x, hiH, hiK, hEq]
      · simp [x, hiH, hiK]

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
    exact (Set.disjoint_left.mp hdisj) hx.1 hx.2
  · exact product_box_disjoint_of_conflict H K

#print axioms product_box_events_disjoint_iff_conflict


end BBMSTAudit


namespace BBMSTAudit

/-- Merge two compatible product-box hyperplanes by taking the union of
their fixed-coordinate sets. On shared fixed coordinates the two values
agree, so choosing H's value there and K's value elsewhere is canonical
up to irrelevant values outside the fixed-coordinate support. -/
def ProductBoxHyperplane.merge
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    (H K : ProductBoxHyperplane ι S) : ProductBoxHyperplane ι S where
  fixedCoords := H.fixedCoords ∪ K.fixedCoords
  fixedValue := fun i =>
    if i ∈ H.fixedCoords then H.fixedValue i else K.fixedValue i

/-- If two hyperplanes have no conflicting shared assignment, their
intersection is exactly the event of the merged constraint system. This is
the structural bridge from the set-theoretic overlap classification to
finite product-cardinality and probability calculations. -/
theorem product_box_intersection_eq_merge_event
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    (H K : ProductBoxHyperplane ι S)
    (hno : ¬ ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
      H.fixedValue i ≠ K.fixedValue i) :
    H.event ∩ K.event = (H.merge K).event := by
  ext x
  constructor
  · intro hx
    intro i hi
    rcases Finset.mem_union.mp hi with hiH | hiK
    · simp [ProductBoxHyperplane.merge, hiH, hx.1 i hiH]
    · by_cases hiH : i ∈ H.fixedCoords
      · have hEq : H.fixedValue i = K.fixedValue i := by
          by_contra hne
          exact hno ⟨i, hiH, hiK, hne⟩
        simp [ProductBoxHyperplane.merge, hiH, hx.1 i hiH, hEq]
      · simp [ProductBoxHyperplane.merge, hiH, hx.2 i hiK]
  · intro hx
    constructor
    · intro i hiH
      have hi : i ∈ H.fixedCoords ∪ K.fixedCoords :=
        Finset.mem_union.mpr (Or.inl hiH)
      have h := hx i hi
      simpa [ProductBoxHyperplane.merge, hiH] using h
    · intro i hiK
      have hi : i ∈ H.fixedCoords ∪ K.fixedCoords :=
        Finset.mem_union.mpr (Or.inr hiK)
      have h := hx i hi
      by_cases hiH : i ∈ H.fixedCoords
      · have hEq : H.fixedValue i = K.fixedValue i := by
          by_contra hne
          exact hno ⟨i, hiH, hiK, hne⟩
        simpa [ProductBoxHyperplane.merge, hiH, hEq] using h
      · simpa [ProductBoxHyperplane.merge, hiH] using h

#print axioms product_box_intersection_eq_merge_event


end BBMSTAudit


namespace BBMSTAudit

/--
The number of coordinates constrained by the merged hyperplane is the sum
of the two support sizes minus the number of shared constrained coordinates.
This is the exact combinatorial identity behind the overlap correction in
the product-box intersection probability; it does not assume independence.
-/
theorem product_box_fixed_coordinate_cardinality_union
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    (H K : ProductBoxHyperplane ι S) :
    (H.fixedCoords ∪ K.fixedCoords).card +
      (H.fixedCoords ∩ K.fixedCoords).card =
        H.fixedCoords.card + K.fixedCoords.card := by
  simpa using Finset.card_union_add_card_inter H.fixedCoords K.fixedCoords

#print axioms product_box_fixed_coordinate_cardinality_union

end BBMSTAudit


namespace BBMSTAudit

/--
Exact overlap-weight identity for a finite product box.

The product of coordinate cardinalities on the union of two fixed-coordinate
sets, multiplied by the product on their intersection, equals the product
of the two individual support weights. This is the multiplicative analogue
of the support-cardinality identity above. It isolates the overlap factor
that appears when comparing the mass of a merged constraint system with
the two individual constraint systems; it does not assume event independence
and does not yet assert a probability formula.
-/
theorem product_box_overlap_weight_identity
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H K : ProductBoxHyperplane ι S) :
    Finset.prod (H.fixedCoords ∪ K.fixedCoords)
        (fun i => (Fintype.card (S i) : ℚ)) *
      Finset.prod (H.fixedCoords ∩ K.fixedCoords)
        (fun i => (Fintype.card (S i) : ℚ)) =
      Finset.prod H.fixedCoords
        (fun i => (Fintype.card (S i) : ℚ)) *
      Finset.prod K.fixedCoords
        (fun i => (Fintype.card (S i) : ℚ)) := by
  exact Finset.prod_union_inter

#print axioms product_box_overlap_weight_identity

end BBMSTAudit


namespace BBMSTAudit

/--
A product-box event is canonically parametrized by the coordinates it does
not fix. This equivalence is the counting bridge from the geometric event
definition to an exact finite-cardinality formula; it uses the actual fixed
coordinate support rather than an abstract independence assumption.
-/
def productBoxEventEquivFree
    {ι : Type u} [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H : ProductBoxHyperplane ι S) :
    {x : (∀ i, S i) // x ∈ H.event} ≃
      (∀ i : {i : ι // i ∉ H.fixedCoords}, S i.val) where
  toFun x i := x.val i.val
  invFun y :=
    ⟨fun i => if hi : i ∈ H.fixedCoords then H.fixedValue i
      else y ⟨i, hi⟩, by
        intro i hi
        simp [hi]⟩
  left_inv x := by
    apply Subtype.ext
    funext i
    by_cases hi : i ∈ H.fixedCoords
    · simp [hi, x.property i hi]
    · simp [hi]
  right_inv y := by
    funext i
    simp [i.property]

#print axioms productBoxEventEquivFree

/--
A global finite-instance bridge for the event subtype. It must be declared
before any theorem statement uses `Fintype.card` on that subtype: a
proof-local instance is too late for elaborating the theorem's type.
-/ 
noncomputable instance productBoxEventFintype
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H : ProductBoxHyperplane ι S) :
    Fintype {x : (∀ i, S i) // x ∈ H.event} := by
  classical
  exact Fintype.ofEquiv
    (∀ i : {i : ι // i ∉ H.fixedCoords}, S i.val)
    (productBoxEventEquivFree H).symm

/--
Exact cardinality bridge for a finite index set: the event has as many
points as assignments to the coordinates not fixed by the hyperplane.
The finite index hypothesis is essential for the ambient dependent function
space to be finite.
-/
theorem product_box_event_card_eq_free_assignments
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H : ProductBoxHyperplane ι S) :
    Fintype.card {x : (∀ i, S i) // x ∈ H.event} =
      Fintype.card (∀ i : {i : ι // i ∉ H.fixedCoords}, S i) := by
  classical
  exact Fintype.card_congr (productBoxEventEquivFree H)

#print axioms product_box_event_card_eq_free_assignments


/--
Exact product formula for the event cardinality. Together with the event/free
assignment equivalence, this exposes the coordinate-by-coordinate factors
that later probability calculations must normalize. No independence or
global sieve estimate is assumed.
-/
theorem product_box_event_card_eq_product_free_coordinate_cardinalities
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H : ProductBoxHyperplane ι S) :
    Fintype.card {x : (∀ i, S i) // x ∈ H.event} =
      ∏ i : {i : ι // i ∉ H.fixedCoords}, Fintype.card (S i.val) := by
  rw [product_box_event_card_eq_free_assignments]
  exact Fintype.card_pi

#print axioms product_box_event_card_eq_product_free_coordinate_cardinalities

end BBMSTAudit


namespace BBMSTAudit

/--
Every intersection event is finite because it is a subtype of the finite
ambient dependent product. This instance is independent of whether the two
constraints are compatible; in the incompatible case the subtype is empty.
-/ 
noncomputable instance productBoxIntersectionFintype
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H K : ProductBoxHyperplane ι S) :
    Fintype {x : (∀ i, S i) // x ∈ H.event ∩ K.event} := by
  classical
  letI : Finite {x : (∀ i, S i) // x ∈ H.event ∩ K.event} :=
    Finite.of_injective
      (fun x : {x : (∀ i, S i) // x ∈ H.event ∩ K.event} => x.val)
      (fun x y hxy => Subtype.ext hxy)
  exact Fintype.ofFinite _

/--
Exact cardinality of a compatible pairwise intersection: merge the two
coordinate constraints, then count the free coordinates. This is the finite
counting identity needed before normalizing to probabilities or estimating
second moments. Compatibility is explicit; no independence assumption is
used.
-/ 
theorem product_box_compatible_intersection_cardinality
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H K : ProductBoxHyperplane ι S)
    (hno : ¬ ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
      H.fixedValue i ≠ K.fixedValue i) :
    Fintype.card {x : (∀ i, S i) // x ∈ H.event ∩ K.event} =
      ∏ i : {i : ι // i ∉ H.fixedCoords ∪ K.fixedCoords},
        Fintype.card (S i.val) := by
  let hEq := product_box_intersection_eq_merge_event H K hno
  let e :
      {x : (∀ i, S i) // x ∈ H.event ∩ K.event} ≃
        {x : (∀ i, S i) // x ∈ (H.merge K).event} :=
    { toFun := fun x => ⟨x.val, hEq ▸ x.property⟩
      invFun := fun x => ⟨x.val, hEq.symm ▸ x.property⟩
      left_inv := by intro x; apply Subtype.ext; rfl
      right_inv := by intro x; apply Subtype.ext; rfl }
  rw [Fintype.card_congr e]
  simpa [ProductBoxHyperplane.merge] using
    (product_box_event_card_eq_product_free_coordinate_cardinalities
      (H.merge K))

#print axioms product_box_compatible_intersection_cardinality

end BBMSTAudit


namespace BBMSTAudit

/--
An explicit conflicting singleton assignment forces the finite pairwise
intersection to have cardinality zero. This closes the incompatible edge case
at the counting level, not only at the set-disjointness level.
-/
theorem product_box_incompatible_intersection_card_zero
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H K : ProductBoxHyperplane ι S)
    (hconflict : ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
      H.fixedValue i ≠ K.fixedValue i) :
    Fintype.card {x : (∀ i, S i) // x ∈ H.event ∩ K.event} = 0 := by
  classical
  let hdisj := product_box_disjoint_of_conflict H K hconflict
  let e : {x : (∀ i, S i) // x ∈ H.event ∩ K.event} ≃ Empty :=
    { toFun := fun x =>
        False.elim ((Set.disjoint_left.mp hdisj) x.property.1 x.property.2)
      invFun := fun x => nomatch x
      left_inv := by
        intro x
        exact False.elim ((Set.disjoint_left.mp hdisj) x.property.1 x.property.2)
      right_inv := by
        intro x
        cases x }
  calc
    Fintype.card {x : (∀ i, S i) // x ∈ H.event ∩ K.event}
        = Fintype.card Empty := Fintype.card_congr e
    _ = 0 := by simp

#print axioms product_box_incompatible_intersection_card_zero

end BBMSTAudit
