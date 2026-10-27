import Mathlib

/-!
# BBMST restriction transport: finite cover survives deletion

This file formalizes the set-theoretic core of the source's codimension-one
reduction. It does not yet encode coordinate cylinders or prove the full
geometric theorem. The theorem below is exact: after removing covered sets,
the surviving sets still cover every point that remains outside all removed
sets. A second lemma records the cardinality margin needed when one value is
deleted from a coordinate domain of size at least three.
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

#print axioms surviving_cover_covers_restricted_domain
#print axioms card_erase_ge_two

end BBMSTRestrictionTransport
