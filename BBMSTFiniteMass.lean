import Mathlib

/-!
# BBMST finite mass partition: the combinatorial layer only

This file isolates the exact finite partition identity from the source-specific
geometric estimate in the BBMST proof. It is intentionally generic: the
identity is valid for any finite set and any predicate. It does not prove the
paper's overlap/moment inequality or the global Erdős–Selfridge theorem.
-/

namespace BBMSTFiniteMassAudit

/-- A finite mass splits exactly into the mass of a selected part and its
complement. This is the division-free bookkeeping lemma needed before any
normalized conditional probabilities or ratios are introduced. -/
theorem sum_filter_partition
    {α β : Type*} [DecidableEq α] [AddCommMonoid β]
    (s : Finset α) (p : α → Prop) [DecidablePred p] (f : α → β) :
    (∑ x ∈ s.filter p, f x) +
      (∑ x ∈ s.filter (fun x => ¬ p x), f x) =
      ∑ x ∈ s, f x := by
  classical
  rw [Finset.sum_filter, Finset.sum_filter, ← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro x hx
  by_cases h : p x <;> simp [h]

/-- The partition identity remains valid for indicator weights, so it can be
used to separate a finite event from its complement without dividing by the
mass of either part. -/
theorem indicator_partition
    {α : Type*} [DecidableEq α]
    (s : Finset α) (p q : α → Prop)
    [DecidablePred p] [DecidablePred q] :
    (∑ x ∈ s.filter p, (if q x then (1 : ℚ) else 0)) +
      (∑ x ∈ s.filter (fun x => ¬ p x), (if q x then (1 : ℚ) else 0)) =
      ∑ x ∈ s, (if q x then (1 : ℚ) else 0) := by
  exact sum_filter_partition s p (fun x => if q x then (1 : ℚ) else 0)

#print axioms BBMSTFiniteMassAudit.sum_filter_partition
#print axioms BBMSTFiniteMassAudit.indicator_partition

end BBMSTFiniteMassAudit
