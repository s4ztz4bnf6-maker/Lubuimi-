import Mathlib

/-!
# BBMST restriction transport: finite cover survives deletion

This file formalizes the set-theoretic core of the source's codimension-one
reduction. The generic transport theorem is exact, but does not by itself
encode the geometric source theorem. The coordinate-product identity below
connects deletion of one coordinate value to restriction of the product.
-/

namespace BBMSTRestrictionTransport

/-- Points in the restricted domain avoid every removed member. -/
def Avoids {α : Type} [DecidableEq α]
    (x : α) (removed : Finset (Finset α)) : Prop :=
  ∀ H ∈ removed, x ∉ H

/-- Restrict a finite domain to points avoiding all removed sets. -/
noncomputable def restrictDomain {α : Type} [DecidableEq α]
    (Q : Finset α) (removed : Finset (Finset α)) : Finset α := by
  classical
  exact Q.filter (fun x => Avoids x removed)

/-- Keep only cover members that were not removed. -/
noncomputable def survivingCover {α : Type} [DecidableEq α]
    (cover removed : Finset (Finset α)) : Finset (Finset α) := by
  classical
  exact cover.filter (fun H => H ∉ removed)

/--
Exact restriction-and-cover transport: if the cover covers Q, then the members
not in removed still cover the restricted domain consisting of points that
avoid every removed member. No geometric side condition is hidden in the
statement.
-/
theorem surviving_cover_covers_restricted_domain
    {α : Type} [DecidableEq α]
    (Q : Finset α) (cover removed : Finset (Finset α))
    (hcover : ∀ x ∈ Q, ∃ H ∈ cover, x ∈ H) :
    ∀ x ∈ restrictDomain Q removed,
      ∃ H ∈ survivingCover cover removed, x ∈ H := by
  classical
  intro x hx
  change x ∈ Q.filter (fun y => Avoids y removed) at hx
  have hxQ : x ∈ Q := (Finset.mem_filter.mp hx).1
  have hxAvoid : Avoids x removed := (Finset.mem_filter.mp hx).2
  obtain ⟨H, hHcover, hxH⟩ := hcover x hxQ
  have hHnot : H ∉ removed := by
    intro hHremoved
    exact (hxAvoid H hHremoved) hxH
  refine ⟨H, ?_, hxH⟩
  change H ∈ cover.filter (fun K => K ∉ removed)
  exact Finset.mem_filter.mpr ⟨hHcover, hHnot⟩

/--
Deleting at most one value from a coordinate set of size at least three
leaves at least two values. This is the cardinality margin needed by the
source's codimension-one reduction.
-/
theorem card_erase_ge_two
    {α : Type} [DecidableEq α]
    (S : Finset α) (a : α) (hcard : 3 ≤ S.card) :
    2 ≤ (S.erase a).card := by
  classical
  by_cases ha : a ∈ S
  · rw [Finset.card_erase_of_mem ha]
    omega
  · simp [ha]
    omega

/--
Finite coordinate product represented as a finite set of functions. Each
coordinate i is constrained to lie in S i.
-/
noncomputable def coordinateProduct {n : ℕ} {α : Type} [Fintype α]
    (S : Fin n → Finset α) : Finset (Fin n → α) := by
  classical
  exact Finset.univ.filter (fun x => ∀ i, x i ∈ S i)

 /--
The coordinate hyperplane at value c, intersected with the finite product Q.
If c is not in S i, this set is empty.
-/
noncomputable def coordinateHyperplane {n : ℕ} {α : Type} [Fintype α]
    (S : Fin n → Finset α) (i : Fin n) (c : α) :
    Finset (Fin n → α) := by
  classical
  exact (coordinateProduct S).filter (fun x => x i = c)

/-- Membership in a coordinate hyperplane is product membership plus one
fixed-coordinate equation. -/
theorem mem_coordinateHyperplane
    {n : ℕ} {α : Type} [Fintype α]
    (S : Fin n → Finset α) (i : Fin n) (c : α) (x : Fin n → α) :
    x ∈ coordinateHyperplane S i c ↔
      x ∈ coordinateProduct S ∧ x i = c := by
  classical
  simp [coordinateHyperplane]

/--
Deleting c from exactly coordinate i is the same as restricting the original
coordinate product to points whose i-th coordinate is not c.
This is the explicit product-level identity needed before transporting a
cover across the codimension-one reduction.
-/
theorem coordinate_erase_restriction
    {n : ℕ} {α : Type} [Fintype α] [DecidableEq α]
    (S : Fin n → Finset α) (i : Fin n) (c : α) (x : Fin n → α) :
    x ∈ coordinateProduct (fun j => if j = i then (S j).erase c else S j) ↔
      x ∈ coordinateProduct S ∧ x i ≠ c := by
  classical
  simp only [coordinateProduct, Finset.mem_filter, Finset.mem_univ, true_and]
  constructor
  · intro hx
    constructor
    · intro j
      by_cases hji : j = i
      · subst j
        have hi : x i ∈ (S i).erase c := by simpa using hx i
        exact Finset.mem_of_mem_erase hi
      · simpa [hji] using hx j
    · have hi := hx i
      simpa using hi
  · rintro ⟨hx, hne⟩
    intro j
    by_cases hji : j = i
    · subst j
      exact Finset.mem_erase.mpr ⟨Ne.symm hne, hx i⟩
    · simpa [hji] using hx j

theorem coordinate_erase_eq_complement_hyperplane
    {n : ℕ} {α : Type} [Fintype α] [DecidableEq α]
    (S : Fin n → Finset α) (i : Fin n) (c : α) :
    coordinateProduct (fun j => if j = i then (S j).erase c else S j) =
      (coordinateProduct S).filter (fun x => x ∉ coordinateHyperplane S i c) := by
  classical
  ext x
  rw [coordinate_erase_restriction]
  simp [mem_coordinateHyperplane]

#print axioms surviving_cover_covers_restricted_domain
#print axioms card_erase_ge_two
#print axioms coordinate_erase_restriction

end BBMSTRestrictionTransport
