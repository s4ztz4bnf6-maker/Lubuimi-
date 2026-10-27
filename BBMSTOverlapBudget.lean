import Mathlib

/-!
# Finite overlap budget for a covering family

This module isolates an exact finite identity useful for the BBMST bridge:
the number of incidences at a point equals one unit for coverage plus an
overlap excess. It is bookkeeping, not the geometric estimate needed by the
Erdos-Selfridge theorem; the unresolved task is to bound the total overlap
excess using the source-specific hypotheses.
-/

namespace BBMSTOverlapBudget

/-- Indices in the finite family whose events contain a point. -/
def hits {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel (fun i => E i ·)] (x : α) : Finset ι :=
  I.filter (fun i => E i x)

/-- Incidence multiplicity at a point. -/
def incidenceCount {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel (fun i => E i ·)] (x : α) : ℕ :=
  (hits I E x).card

/-- Coverage contributes one unit exactly when at least one event hits. -/
def coverageUnit {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel (fun i => E i ·)] (x : α) : ℕ :=
  if (hits I E x).Nonempty then 1 else 0

/-- The excess incidence after paying for the first hit. -/
def overlapExcess {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel (fun i => E i ·)] (x : α) : ℕ :=
  incidenceCount I E x - coverageUnit I E x

/-- Exact pointwise decomposition: coverage plus overlap excess equals all incidences. -/
theorem incidence_eq_coverage_plus_overlap
    {ι α : Type*} [DecidableEq ι]
    (I : Finset ι) (E : ι → α → Prop) [DecidableRel (fun i => E i ·)] (x : α) :
    coverageUnit I E x + overlapExcess I E x = incidenceCount I E x := by
  let t := hits I E x
  by_cases ht : t.Nonempty
  · have hpos : 0 < t.card := Finset.card_pos.mpr ht
    simp [coverageUnit, overlapExcess, incidenceCount, hits, t, ht]
    omega
  · have hzero : t.card = 0 := by
      by_contra hne
      have hpos : 0 < t.card := Nat.pos_of_ne_zero hne
      exact ht (Finset.card_pos.mp hpos)
    simp [coverageUnit, overlapExcess, incidenceCount, hits, t, ht, hzero]

#print axioms incidence_eq_coverage_plus_overlap

end BBMSTOverlapBudget
