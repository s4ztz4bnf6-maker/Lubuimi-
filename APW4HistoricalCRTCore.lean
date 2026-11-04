import Mathlib

/-!
# Historical APW4 CRT incidence core

This module formalizes the recovered finite congruence-set layer:
the sets are actual residue classes in `ZMod N`, not arbitrary Finsets.
It proves the exact support membership predicate and the BIB ordered-collision
identity for this CRT family.

It does NOT invent the missing historical definitions of
`W_{q,r}`, `a_{q,t}`, `M_{q,r}`, `Gamma_{q,r}`, or the APW atom map.
Consequently it is a verified CRT/BIB foundation, not yet the full historical
APW-to-BIB coupling theorem.
-/

namespace APW4HistoricalCRT

variable {I : Type*} [Fintype I] [DecidableEq I]
variable (N : ℕ) [NeZero N]
variable (m a : I → ℕ)
variable (hm : ∀ i, 0 < m i)
variable (hdiv : ∀ i, m i ∣ N)

include hm hdiv

/-- The historical congruence class indexed by i, represented in ZMod N. -/
def congruenceSet (i : I) : Finset (ZMod N) :=
  Finset.univ.filter
    (fun x => x.val % m i = a i % m i)

/-- The exact set of congruence indices hit by a point. -/
def supportAt (x : ZMod N) : Finset I :=
  Finset.univ.filter (fun i => x ∈ congruenceSet N m a hm hdiv i)

/-- The pointwise ordered BIB collision count. -/
def pointBIBCount (x : ZMod N) : ℕ :=
  (supportAt N m a hm hdiv x).card *
    ((supportAt N m a hm hdiv x).card - 1)

/-- The total BIB reserve on the actual CRT congruence family. -/
def bibReserve : ℕ :=
  ∑ x : ZMod N, pointBIBCount N m a hm hdiv x

/-- Ordered distinct-index collisions, counted directly from the support. -/
def orderedBIBPairs : ℕ :=
  ∑ x : ZMod N,
    ∑ i ∈ supportAt N m a hm hdiv x,
      ((supportAt N m a hm hdiv x).erase i).card

/-- Membership in the historical CRT set is exactly its congruence predicate. -/
theorem mem_congruenceSet_iff (i : I) (x : ZMod N) :
    x ∈ congruenceSet N m a i ↔
      x.val % m i = a i % m i := by
  simp [congruenceSet]

/-- The exact support records precisely which original congruences contain x. -/
theorem mem_supportAt_iff (i : I) (x : ZMod N) :
    i ∈ supportAt N m a hm hdiv x ↔
      x.val % m i = a i % m i := by
  simp [supportAt, congruenceSet]

/-- The historical BIB reserve equals the number of ordered distinct-index
collisions in the CRT incidence family. -/
theorem historical_bib_collision_identity :
    bibReserve N m a hm hdiv =
      orderedBIBPairs N m a hm hdiv := by
  classical
  unfold bibReserve orderedBIBPairs pointBIBCount
  apply Finset.sum_congr rfl
  intro x hx
  let S := supportAt N m a hm hdiv x
  change S.card * (S.card - 1) =
    (∑ i ∈ S, (S.erase i).card)
  symm
  calc
    (∑ i ∈ S, (S.erase i).card)
        = ∑ i ∈ S, (S.card - 1) := by
            apply Finset.sum_congr rfl
            intro i hi
            rw [Finset.card_erase_of_mem hi]
    _ = S.card * (S.card - 1) := by
          simp [Finset.sum_const]

#print axioms mem_congruenceSet_iff
#print axioms mem_supportAt_iff
#print axioms historical_bib_collision_identity

end APW4HistoricalCRT
