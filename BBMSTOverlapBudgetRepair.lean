import Mathlib

/-!
# Repair for the finite overlap-budget identity

This file isolates the repair of the failing pointwise identity. The key is to
prove that the coverage unit is bounded by the incidence count, then use
Nat.sub_add_cancel. No division and no project-specific axioms are introduced.
This is bookkeeping only; it does not establish the geometric BBMST estimate.
-/

namespace BBMSTOverlapBudgetRepair

def hits {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel E] (x : α) : Finset ι :=
  I.filter (fun i => E i x)

def incidenceCount {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel E] (x : α) : ℕ :=
  (hits I E x).card

def coverageUnit {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel E] (x : α) : ℕ :=
  if (hits I E x).Nonempty then 1 else 0

def overlapExcess {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel E] (x : α) : ℕ :=
  incidenceCount I E x - coverageUnit I E x

theorem coverageUnit_le_incidenceCount
    {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel E] (x : α) :
    coverageUnit I E x ≤ incidenceCount I E x := by
  unfold coverageUnit incidenceCount
  by_cases h : (hits I E x).Nonempty
  · simp only [if_pos h]
    exact Nat.succ_le_iff.mpr (Finset.card_pos.mpr h)
  · simp only [if_neg h]
    exact Nat.zero_le _

theorem incidence_eq_coverage_plus_overlap
    {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel E] (x : α) :
    coverageUnit I E x + overlapExcess I E x = incidenceCount I E x := by
  unfold overlapExcess
  calc
    coverageUnit I E x + (incidenceCount I E x - coverageUnit I E x) =
        (incidenceCount I E x - coverageUnit I E x) + coverageUnit I E x :=
      Nat.add_comm _ _
    _ = incidenceCount I E x :=
      Nat.sub_add_cancel (coverageUnit_le_incidenceCount I E x)

#print axioms coverageUnit_le_incidenceCount
#print axioms incidence_eq_coverage_plus_overlap

end BBMSTOverlapBudgetRepair
