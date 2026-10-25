import BBMSTProductBox

/-!
# Exact product-box event cardinality

For a uniform finite product with a common finite coordinate alphabet, fixing
some coordinates leaves one independent choice at every free coordinate.
This turns the set-theoretic merge lemma into an exact counting identity.
Combined with `product_box_intersection_eq_merge_event`, it gives the exact
pair-intersection count whenever shared assignments are compatible.

This is a finite counting lemma only; it does not establish the BBMST moment
bound or the global sieve criterion.
-/

namespace BBMSTAudit

/-- The event of a coordinate-fixing product-box hyperplane has exactly
`|S|^(number of free coordinates)` elements. The equivalence explicitly
forgets fixed coordinates and reconstructs them from the hyperplane. -/
theorem product_box_event_cardinality
    {ι S : Type*} [Fintype ι] [DecidableEq ι] [Fintype S]
    (H : ProductBoxHyperplane ι (fun _ => S))
    [Fintype {x : ι → S // x ∈ H.event}] :
    Fintype.card {x : ι → S // x ∈ H.event} =
      Fintype.card S ^ Fintype.card {i : ι // i ∉ H.fixedCoords} := by
  classical
  let Free := {i : ι // i ∉ H.fixedCoords}
  let eventEquiv :
      {x : ι → S // x ∈ H.event} ≃ (Free → S) where
    toFun := fun (x : {x : ι → S // x ∈ H.event}) =>
      fun (i : Free) => x.val i.val
    invFun := fun (y : Free → S) =>
      ⟨(fun i => if hi : i ∈ H.fixedCoords then H.fixedValue i else y ⟨i, hi⟩),
        by
          intro i hi
          simp [hi]⟩
    left_inv := by
      intro x
      apply Subtype.ext
      funext i
      by_cases hi : i ∈ H.fixedCoords
      · simpa [hi] using x.property i hi
      · simp [hi]
    right_inv := by
      intro y
      funext i
      simp [i.property]
  calc
    Fintype.card {x : ι → S // x ∈ H.event}
        = Fintype.card (Free → S) := Fintype.card_congr eventEquiv
    _ = Fintype.card S ^ Fintype.card Free := Fintype.card_fun

#print axioms product_box_event_cardinality

/-- For compatible product-box constraints, the intersection count is the
count for the union of the fixed-coordinate supports. The theorem is a
direct corollary of the exact event identity and the merge lemma; no
independence assumption is made about overlapping events. -/
theorem product_box_compatible_intersection_cardinality
    {ι S : Type*} [Fintype ι] [DecidableEq ι] [Fintype S]
    (H K : ProductBoxHyperplane ι (fun _ => S))
    [Fintype {x : ι → S // x ∈ H.event ∩ K.event}]
    [Fintype {x : ι → S // x ∈ (H.merge K).event}]
    (hno : ¬ ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
      H.fixedValue i ≠ K.fixedValue i) :
    Fintype.card {x : ι → S // x ∈ H.event ∩ K.event} =
      Fintype.card S ^
        Fintype.card {i : ι // i ∉ H.fixedCoords ∪ K.fixedCoords} := by
  classical
  have hmerge :
      H.event ∩ K.event = (H.merge K).event :=
    product_box_intersection_eq_merge_event H K hno
  let e : {x : ι → S // x ∈ H.event ∩ K.event} ≃
      {x : ι → S // x ∈ (H.merge K).event} := Equiv.setCongr hmerge
  calc
    Fintype.card {x : ι → S // x ∈ H.event ∩ K.event}
        = Fintype.card {x : ι → S // x ∈ (H.merge K).event} :=
          Fintype.card_congr e
    _ = Fintype.card S ^
        Fintype.card {i : ι // i ∉ H.fixedCoords ∪ K.fixedCoords} :=
          product_box_event_cardinality (H.merge K)

#print axioms product_box_compatible_intersection_cardinality

/-- Incompatible singleton assignments have no common witness in the finite
product. This is the exact zero-overlap branch complementary to the
compatible intersection-cardinality formula above. -/
theorem product_box_incompatible_intersection_isEmpty
    {ι S : Type*} [DecidableEq ι]
    (H K : ProductBoxHyperplane ι (fun _ => S))
    (hconflict : ∃ i, i ∈ H.fixedCoords ∧ i ∈ K.fixedCoords ∧
      H.fixedValue i ≠ K.fixedValue i) :
    IsEmpty {x : ι → S // x ∈ H.event ∩ K.event} := by
  classical
  refine ⟨fun x => ?_⟩
  obtain ⟨i, hiH, hiK, hne⟩ := hconflict
  have hagree : H.fixedValue i = K.fixedValue i :=
    product_box_overlap_agreement H K x.val x.property.1 x.property.2 hiH hiK
  exact hne hagree

#print axioms product_box_incompatible_intersection_isEmpty

end BBMSTAudit
