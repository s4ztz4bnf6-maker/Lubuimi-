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


namespace BBMSTAudit

/--
Exact two-case intersection cardinality formula for finite product boxes.
Compatible prescriptions contribute the product over free coordinates;
a conflicting shared prescription contributes zero. This combines the
merge/counting argument and the incompatible edge case without introducing
an abstract overlap or parallelism hypothesis.
-/
theorem product_box_intersection_cardinality_compatible_or_zero
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H K : ProductBoxHyperplane ι S) :
    (¬ ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
        H.fixedValue i ≠ K.fixedValue i) ∧
      Fintype.card {x : (∀ i, S i) // x ∈ H.event ∩ K.event} =
        ∏ i : {i : ι // i ∉ H.fixedCoords ∪ K.fixedCoords},
          Fintype.card (S i.val) ∨
    (∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
        H.fixedValue i ≠ K.fixedValue i) ∧
      Fintype.card {x : (∀ i, S i) // x ∈ H.event ∩ K.event} = 0 := by
  classical
  by_cases hno : ¬ ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
      H.fixedValue i ≠ K.fixedValue i
  · left
    exact ⟨hno, product_box_compatible_intersection_cardinality H K hno⟩
  · right
    have hconflict : ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
        H.fixedValue i ≠ K.fixedValue i :=
      Classical.not_not.mp hno
    exact ⟨hconflict,
      product_box_incompatible_intersection_card_zero H K hconflict⟩

#print axioms product_box_intersection_cardinality_compatible_or_zero

end BBMSTAudit


namespace BBMSTAudit

/--
Finite second-moment expansion for indicator sums, before introducing any
probability measure. The identity is purely algebraic: the square of the
number of satisfied predicates counts ordered pairs satisfying both
predicates. This is the exact combinatorial core of the second-moment step.
-/
theorem indicator_sum_sq_eq_ordered_pair_sum
    {α : Type u} [DecidableEq α]
    (s : Finset α) (P : α → Prop) [DecidablePred P] :
    (∑ x ∈ s, if P x then (1 : ℚ) else 0) ^ 2 =
      ∑ x ∈ s, ∑ y ∈ s, if P x ∧ P y then (1 : ℚ) else 0 := by
  rw [pow_two, Finset.sum_mul_sum]
  apply Finset.sum_congr rfl
  intro x hx
  apply Finset.sum_congr rfl
  intro y hy
  by_cases hpx : P x <;> by_cases hpy : P y <;>
    simp [hpx, hpy]

#print axioms indicator_sum_sq_eq_ordered_pair_sum

end BBMSTAudit


namespace BBMSTAudit

/--
Finite second-moment identity for a family of events on a finite sample space.
The left side sums the squared event count over samples; the right side sums
pairwise intersection counts. This is the exact finite counting interface
needed before inserting the BBMST-specific product-box probabilities.
-/
theorem finite_second_moment_ordered_pair_identity
    {Ω : Type u} {I : Type v} [DecidableEq Ω] [DecidableEq I]
    (samples : Finset Ω) (indices : Finset I)
    (E : I → Ω → Prop) [∀ i ω, Decidable (E i ω)] :
    (∑ ω ∈ samples,
      (∑ i ∈ indices, if E i ω then (1 : ℚ) else 0) ^ 2) =
      ∑ i ∈ indices, ∑ j ∈ indices,
        ∑ ω ∈ samples, if E i ω ∧ E j ω then (1 : ℚ) else 0 := by
  classical
  calc
    (∑ ω ∈ samples,
      (∑ i ∈ indices, if E i ω then (1 : ℚ) else 0) ^ 2)
        = ∑ ω ∈ samples,
          ∑ i ∈ indices, ∑ j ∈ indices,
            if E i ω ∧ E j ω then (1 : ℚ) else 0 := by
              apply Finset.sum_congr rfl
              intro ω hω
              exact indicator_sum_sq_eq_ordered_pair_sum indices
                (fun i => E i ω)
    _ = ∑ i ∈ indices, ∑ j ∈ indices,
          ∑ ω ∈ samples, if E i ω ∧ E j ω then (1 : ℚ) else 0 := by
            rw [Finset.sum_comm (s := samples) (t := indices)
              (f := fun ω i =>
                ∑ j ∈ indices, if E i ω ∧ E j ω then (1 : ℚ) else 0)]
            apply Finset.sum_congr rfl
            intro i hi
            rw [Finset.sum_comm (s := samples) (t := indices)
              (f := fun ω j =>
                if E i ω ∧ E j ω then (1 : ℚ) else 0)]

#print axioms finite_second_moment_ordered_pair_identity

end BBMSTAudit


namespace BBMSTAudit

/--
Uniform mass of a product-box event, represented as its exact cardinality
divided by the cardinality of the ambient finite product. Each coordinate
type is inhabited because a hyperplane carries a value at every coordinate;
the ratio therefore has the intended finite-uniform-space interpretation.
-/
noncomputable def productBoxUniformMass
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H : ProductBoxHyperplane ι S) : ℚ :=
  (Fintype.card {x : (∀ i, S i) // x ∈ H.event} : ℚ) /
    (Fintype.card (∀ i, S i) : ℚ)

/--
Exact normalized mass formula for a product-box event: the numerator is the
product of the cardinalities of the free coordinate types, while the
denominator is the cardinality of the whole product. This is a finite
counting statement, not yet the BBMST global sieve estimate.
-/
theorem product_box_uniform_mass_eq_free_product_ratio
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H : ProductBoxHyperplane ι S) :
    productBoxUniformMass H =
      (∏ i : {i : ι // i ∉ H.fixedCoords},
        (Fintype.card (S i.val) : ℚ)) /
      (∏ i : ι, (Fintype.card (S i) : ℚ)) := by
  unfold productBoxUniformMass
  rw [product_box_event_card_eq_product_free_coordinate_cardinalities]
  rw [Fintype.card_pi]
  simp only [Nat.cast_prod]

#print axioms product_box_uniform_mass_eq_free_product_ratio

end BBMSTAudit


namespace BBMSTAudit

/--
Uniform mass of the intersection of two product-box events, defined by exact
finite counting in the ambient product. This definition keeps the compatible
and incompatible cases in the same probability interface.
-/
noncomputable def productBoxIntersectionUniformMass
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H K : ProductBoxHyperplane ι S) : ℚ :=
  (Fintype.card {x : (∀ i, S i) // x ∈ H.event ∩ K.event} : ℚ) /
    (Fintype.card (∀ i, S i) : ℚ)

/--
Exact normalized intersection mass for compatible constraints. The numerator
is the product of the coordinate cardinalities left free by the union of the
two supports. This explicitly accounts for overlap and does not assume
independence of the events.
-/
theorem product_box_compatible_intersection_uniform_mass
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H K : ProductBoxHyperplane ι S)
    (hno : ¬ ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
      H.fixedValue i ≠ K.fixedValue i) :
    productBoxIntersectionUniformMass H K =
      (∏ i : {i : ι // i ∉ H.fixedCoords ∪ K.fixedCoords},
        (Fintype.card (S i.val) : ℚ)) /
      (∏ i : ι, (Fintype.card (S i) : ℚ)) := by
  unfold productBoxIntersectionUniformMass
  rw [product_box_compatible_intersection_cardinality H K hno]
  rw [Fintype.card_pi]
  simp only [Nat.cast_prod]

/--
An incompatible pair has zero intersection mass. This is the exact
zero-probability branch needed before summing pairwise terms in a second
moment estimate.
-/
theorem product_box_incompatible_intersection_uniform_mass
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H K : ProductBoxHyperplane ι S)
    (hconflict : ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
      H.fixedValue i ≠ K.fixedValue i) :
    productBoxIntersectionUniformMass H K = 0 := by
  unfold productBoxIntersectionUniformMass
  rw [product_box_incompatible_intersection_card_zero H K hconflict]
  simp

#print axioms product_box_compatible_intersection_uniform_mass
#print axioms product_box_incompatible_intersection_uniform_mass

end BBMSTAudit


namespace BBMSTAudit

open Classical

/--
Unified exact intersection-mass formula. A conflicting fixed coordinate
forces zero mass; otherwise the mass is the product of the free coordinate
cardinalities divided by the ambient product cardinality. This is the
source-faithful pair kernel for the second-moment sum: it explicitly keeps
overlapping supports and incompatible assignments separate.
-/
theorem product_box_intersection_uniform_mass_compatible_or_zero
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (H K : ProductBoxHyperplane ι S) :
    productBoxIntersectionUniformMass H K =
      if hconflict : ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
        H.fixedValue i ≠ K.fixedValue i
      then 0
      else
        (∏ i : {i : ι // i ∉ H.fixedCoords ∪ K.fixedCoords},
          (Fintype.card (S i.val) : ℚ)) /
        (∏ i : ι, (Fintype.card (S i) : ℚ)) := by
  classical
  by_cases hconflict : ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
      H.fixedValue i ≠ K.fixedValue i
  · simp only [dif_pos hconflict]
    exact product_box_incompatible_intersection_uniform_mass H K hconflict
  · simp only [dif_neg hconflict]
    exact product_box_compatible_intersection_uniform_mass H K hconflict

#print axioms product_box_intersection_uniform_mass_compatible_or_zero

end BBMSTAudit


namespace BBMSTAudit

/--
Exact finite reindexing of an ordered pair-weight sum by the *overlap
support* of its two product-box constraints. Since the key is the actual
intersection of fixed-coordinate sets, this stratification preserves more
information than overlap cardinality alone. It preserves ordered-pair
multiplicity and diagonal pairs because it is a fiberwise partition of the
given finite pair set. No probability estimate or BBMST global bound is
assumed here.
-/
theorem ordered_pair_weight_sum_stratified_by_overlap_support
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (pairs : Finset (ProductBoxHyperplane ι S × ProductBoxHyperplane ι S))
    (weight : ProductBoxHyperplane ι S × ProductBoxHyperplane ι S → ℚ) :
    (∑ p ∈ pairs, weight p) =
      ∑ overlap : Finset ι,
        ∑ p ∈ pairs with
          (p.1.fixedCoords ∩ p.2.fixedCoords = overlap), weight p := by
  classical
  simpa using
    (Finset.sum_fiberwise pairs
      (fun p => p.1.fixedCoords ∩ p.2.fixedCoords) weight).symm

#print axioms ordered_pair_weight_sum_stratified_by_overlap_support

end BBMSTAudit


namespace BBMSTAudit

/--
Coarser companion to the overlap-support stratification: regroup an ordered
pair-weight sum by the *cardinality* of the shared fixed-coordinate set.
This identity is exact and preserves ordered-pair multiplicity and diagonal
terms. It is only a bookkeeping theorem; it does not assert that cardinality
alone determines intersection mass in heterogeneous product boxes.
-/
theorem ordered_pair_weight_sum_stratified_by_overlap_cardinality
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (pairs : Finset (ProductBoxHyperplane ι S × ProductBoxHyperplane ι S))
    (weight : ProductBoxHyperplane ι S × ProductBoxHyperplane ι S → ℚ) :
    (∑ p ∈ pairs, weight p) =
      ∑ r ∈ pairs.image (fun p =>
          (p.1.fixedCoords ∩ p.2.fixedCoords).card),
        ∑ p ∈ pairs with
          (p.1.fixedCoords ∩ p.2.fixedCoords).card = r, weight p := by
  classical
  exact (Finset.sum_fiberwise_of_maps_to
    (s := pairs)
    (t := pairs.image (fun p =>
      (p.1.fixedCoords ∩ p.2.fixedCoords).card))
    (g := fun p => (p.1.fixedCoords ∩ p.2.fixedCoords).card)
    (by
      intro p hp
      exact Finset.mem_image.mpr ⟨p, hp, rfl⟩)
    weight).symm
#print axioms ordered_pair_weight_sum_stratified_by_overlap_cardinality

end BBMSTAudit


namespace BBMSTAudit

/--
Second-moment pair mass regrouped by the exact shared-coordinate support.
This corollary composes the product-box intersection formula with finite
fiberwise reindexing. It is an exact identity, not a quantitative upper bound:
all compatible and incompatible ordered pairs, including the diagonal, remain
present with their true intersection masses.
-/
theorem second_moment_pair_mass_stratified_by_overlap_support
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (pairs : Finset (ProductBoxHyperplane ι S × ProductBoxHyperplane ι S)) :
    (∑ p ∈ pairs, productBoxIntersectionUniformMass p.1 p.2) =
      ∑ overlap : Finset ι,
        ∑ p ∈ pairs with
          (p.1.fixedCoords ∩ p.2.fixedCoords = overlap),
          productBoxIntersectionUniformMass p.1 p.2 := by
  simpa using
    (ordered_pair_weight_sum_stratified_by_overlap_support
      (pairs := pairs)
      (weight := fun p => productBoxIntersectionUniformMass p.1 p.2))

#print axioms second_moment_pair_mass_stratified_by_overlap_support

end BBMSTAudit


namespace BBMSTAudit

/--
Admissibility of a finite product sample space: every coordinate space has
at least one element. This hypothesis is separate from the total algebraic
definitions of event mass, because rational division by zero is defined in
Lean and does not itself certify a probability space.
-/
def ProductBoxAdmissible
    {ι : Type u} [Fintype ι] (S : ι → Type v) : Prop :=
  ∀ i, Nonempty (S i)

/-- Coordinatewise nonemptiness supplies an actual point in the dependent
product. The classical choice is only used to select one value per
coordinate; it does not assume any BBMST-specific combinatorial claim. -/
theorem product_box_nonempty_of_admissible
    {ι : Type u} [Fintype ι] {S : ι → Type v}
    (hS : ProductBoxAdmissible S) :
    Nonempty (∀ i, S i) := by
  classical
  exact ⟨fun i => Classical.choice (hS i)⟩

/-- Consequently, an admissible finite product has positive cardinality,
so its rational cardinality is a nonzero denominator for uniform counting
mass. -/
theorem product_box_card_pos_of_admissible
    {ι : Type u} [Fintype ι] {S : ι → Type v}
    [∀ i, Fintype (S i)] [Fintype (∀ i, S i)]
    (hS : ProductBoxAdmissible S) :
    0 < Fintype.card (∀ i, S i) := by
  classical
  exact Fintype.card_pos_iff.mpr (product_box_nonempty_of_admissible hS)

#print axioms product_box_nonempty_of_admissible
#print axioms product_box_card_pos_of_admissible

end BBMSTAudit


namespace BBMSTAudit

/-- The rational denominator used by uniform counting mass is nonzero on an
admissible product box. This is the exact guard needed before interpreting
the quotient as a normalized probability rather than merely a total rational
expression. -/
theorem product_box_uniform_mass_denominator_ne_zero
    {ι : Type u} [Fintype ι] {S : ι → Type v}
    [∀ i, Fintype (S i)] [Fintype (∀ i, S i)]
    (hS : ProductBoxAdmissible S) :
    (Fintype.card (∀ i, S i) : ℚ) ≠ 0 := by
  classical
  have hcard : 0 < Fintype.card (∀ i, S i) :=
    product_box_card_pos_of_admissible hS
  exact_mod_cast (Nat.ne_of_gt hcard)

/-- The uniform intersection mass has a genuinely nonzero denominator under
the product-box admissibility hypothesis. No global sieve estimate is implied. -/
theorem product_box_intersection_mass_denominator_ne_zero
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)] [Fintype (∀ i, S i)]
    (H K : ProductBoxHyperplane ι S)
    (hS : ProductBoxAdmissible S) :
    (Fintype.card (∀ i, S i) : ℚ) ≠ 0 :=
  product_box_uniform_mass_denominator_ne_zero hS

#print axioms product_box_uniform_mass_denominator_ne_zero
#print axioms product_box_intersection_mass_denominator_ne_zero

end BBMSTAudit


namespace BBMSTAudit

/--
Joint overlap/union stratification of an ordered-pair weight sum. The overlap
support alone can group pairs with different unions and hence different
intersection weights in heterogeneous product spaces. This exact refinement
retains both supports, ordered-pair multiplicity, and diagonal terms. It is
a reindexing identity only; no moment bound is inferred from it.
-/
theorem ordered_pair_weight_sum_stratified_by_overlap_and_union
    {ι : Type u} [Fintype ι] [DecidableEq ι] {S : ι → Type v}
    [∀ i, Fintype (S i)]
    (pairs : Finset (ProductBoxHyperplane ι S × ProductBoxHyperplane ι S))
    (weight : ProductBoxHyperplane ι S × ProductBoxHyperplane ι S → ℚ) :
    (∑ p ∈ pairs, weight p) =
      ∑ signature : Finset ι × Finset ι,
        ∑ p ∈ pairs with
          (p.1.fixedCoords ∩ p.2.fixedCoords,
            p.1.fixedCoords ∪ p.2.fixedCoords) = signature,
          weight p := by
  classical
  simpa using
    (Finset.sum_fiberwise pairs
      (fun p =>
        (p.1.fixedCoords ∩ p.2.fixedCoords,
          p.1.fixedCoords ∪ p.2.fixedCoords))
      weight).symm

#print axioms ordered_pair_weight_sum_stratified_by_overlap_and_union

end BBMSTAudit
