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
  Finset.univ.filter (fun i => x ∈ congruenceSet N m a i)

/-- The pointwise ordered BIB collision count. -/
def pointBIBCount (x : ZMod N) : ℕ :=
  (supportAt N m a x).card *
    ((supportAt N m a x).card - 1)

/-- The total BIB reserve on the actual CRT congruence family. -/
def bibReserve : ℕ :=
  ∑ x : ZMod N, pointBIBCount N m a x

/-- Ordered distinct-index collisions, counted directly from the support. -/
def orderedBIBPairs : ℕ :=
  ∑ x : ZMod N,
    ∑ i ∈ supportAt N m a x,
      ((supportAt N m a x).erase i).card

/-- Membership in the historical CRT set is exactly its congruence predicate. -/
theorem mem_congruenceSet_iff (i : I) (x : ZMod N) :
    x ∈ congruenceSet N m a i ↔
      x.val % m i = a i % m i := by
  simp [congruenceSet]

/-- The exact support records precisely which original congruences contain x. -/
theorem mem_supportAt_iff (i : I) (x : ZMod N) :
    i ∈ supportAt N m a x ↔
      x.val % m i = a i % m i := by
  simp [supportAt, congruenceSet]

/-- The historical BIB reserve equals the number of ordered distinct-index
collisions in the CRT incidence family. -/
theorem historical_bib_collision_identity :
    bibReserve N m a =
      orderedBIBPairs N m a := by
  classical
  unfold bibReserve orderedBIBPairs pointBIBCount
  apply Finset.sum_congr rfl
  intro x hx
  let S := supportAt N m a x
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


/-- The exact support layer consists of the CRT points lying in precisely
the original congruence classes indexed by S. -/
def exactSupportLayer (S : Finset I) : Finset (ZMod N) :=
  Finset.univ.filter (fun x => supportAt N m a x = S)

/-- Cardinality of one exact support layer. -/
def exactSupportCount (S : Finset I) : ℕ :=
  ∑ x : ZMod N, if supportAt N m a x = S then 1 else 0

/-- Number of CRT points lying in every congruence indexed by T. -/
def intersectionCount (T : Finset I) : ℕ :=
  (Finset.univ.filter (fun x => T ⊆ supportAt N m a x)).card

/-- Exact support layers partition each intersection count:
the points containing every index in T are precisely the disjoint union
of exact support layers indexed by S ⊇ T. This is the incidence identity
underlying the support-layer Möbius inversion. -/
theorem intersectionCount_eq_sum_exactSupportCount (T : Finset I) :
    intersectionCount N m a T =
      ∑ S : Finset I,
        if T ⊆ S then exactSupportCount N m a S else 0 := by
  classical
  unfold intersectionCount
  simp only [Finset.card_filter]
  calc
    (∑ x : ZMod N, if T ⊆ supportAt N m a x then 1 else 0) =
        ∑ x : ZMod N, ∑ S : Finset I,
          if T ⊆ S ∧ supportAt N m a x = S then 1 else 0 := by
      apply Finset.sum_congr rfl
      intro x hx
      rw [Finset.sum_eq_single (supportAt N m a x)]
      · simp
      · intro S hS hne
        have hne' : supportAt N m a x ≠ S := by
          intro h
          exact hne h.symm
        simp [hne']
      · intro h
        exact (h (Finset.mem_univ _)).elim
    _ = ∑ S : Finset I, ∑ x : ZMod N,
          if T ⊆ S ∧ supportAt N m a x = S then 1 else 0 := by
      exact Finset.sum_comm
    _ = ∑ S : Finset I,
          if T ⊆ S then
            (∑ x : ZMod N, if supportAt N m a x = S then 1 else 0)
          else 0 := by
      apply Finset.sum_congr rfl
      intro S hS
      by_cases hTS : T ⊆ S
      · simp [hTS]
      · simp [hTS]
    _ = ∑ S : Finset I,
          if T ⊆ S then exactSupportCount N m a S else 0 := by
      rfl

#print axioms intersectionCount_eq_sum_exactSupportCount

#print axioms mem_congruenceSet_iff
#print axioms mem_supportAt_iff
#print axioms historical_bib_collision_identity

end APW4HistoricalCRT


/-!
## Recovered q-fibre incidence interface (Dossier v1.6, §48)

For fixed historical labels q,r,x,y,g, the source records
P_{q,x,h} = F_q(x) ∩ C_h,
P_{r,y,g} = F_r(y) ∩ C_g,
M_{q,r}((x,h),(y,g)) = |P_{q,x,h} ∩ P_{r,y,g}|,
and Gamma_{q,r}(g) = |C_g ∩ V_q ∩ V_r|.

The definitions below isolate exactly this finite-set interface. The aggregate
bound is proved only under the explicit fibre-containment and block-disjointness
properties that must be derived from the original definitions when the actual
q,r,x,y,g data are instantiated. This is a local counting lemma, not the
weighted Hall condition or the global APW4 HT theorem.
-/

namespace APW4HistoricalQFibre

variable {G H : Type*} [DecidableEq G] [Fintype H] [DecidableEq H]

/-- The historical q-fibre slice P_{q,x,h} = F_q(x) ∩ C_h. -/
def Pq (Fq : Finset G) (C : H → Finset G) (h : H) : Finset G :=
  Fq ∩ C h

/-- The historical r-fibre slice P_{r,y,g} = F_r(y) ∩ C_g. -/
def Pr (Fr : Finset G) (C : H → Finset G) (g : H) : Finset G :=
  Fr ∩ C g

/-- The q-profile intersection count M_{q,r}((x,h),(y,g)). -/
def M_qr (Fq Fr : Finset G) (C : H → Finset G) (g h : H) : ℕ :=
  (Pq Fq C h ∩ Pr Fr C g).card

/-- The historical target capacity Gamma_{q,r}(g). -/
def Gamma_qr (Vq Vr : Finset G) (C : H → Finset G) (g : H) : ℕ :=
  (C g ∩ Vq ∩ Vr).card

/--
For fixed q,r,x,y,g, the sum of the historical M_{q,r} counts over h is
bounded by Gamma_{q,r}(g), provided the q- and r-fibres lie in V_q and V_r
and the blocks C_h are pairwise disjoint.
-/
theorem sum_M_qr_le_Gamma_qr
    (Fq Fr Vq Vr : Finset G) (C : H → Finset G) (g : H)
    (hFq : Fq ⊆ Vq) (hFr : Fr ⊆ Vr)
    (hC : ∀ h₁ h₂, h₁ ≠ h₂ → Disjoint (C h₁) (C h₂)) :
    (∑ h : H, M_qr Fq Fr C g h) ≤ Gamma_qr Vq Vr C g := by
  classical
  let E : H → Finset G := fun h => Pq Fq C h ∩ Pr Fr C g
  have hpair : (↑(Finset.univ : Finset H) : Set H).PairwiseDisjoint E := by
    intro h₁ hh₁ h₂ hh₂ hne
    apply Finset.disjoint_left.mpr
    intro z hz₁ hz₂
    simp only [E, Pq, Pr, Finset.mem_inter] at hz₁ hz₂
    exact (Finset.disjoint_left.mp (hC h₁ h₂ hne)) hz₁.1.2 hz₂.1.2
  have hsubset : Finset.univ.biUnion E ⊆ C g ∩ Vq ∩ Vr := by
    intro z hz
    rcases Finset.mem_biUnion.mp hz with ⟨h, hh, hzE⟩
    simp only [E, Pq, Pr, Finset.mem_inter] at hzE
    simp only [Finset.mem_inter]
    exact ⟨⟨hzE.2.2, hFq hzE.1.1⟩, hFr hzE.2.1⟩
  calc
    (∑ h : H, M_qr Fq Fr C g h) = ∑ h : H, (E h).card := by
      apply Finset.sum_congr rfl
      intro h hh
      rfl
    _ = (Finset.univ.biUnion E).card := by
      symm
      simpa using (Finset.card_biUnion hpair)
    _ ≤ (C g ∩ Vq ∩ Vr).card := Finset.card_le_card hsubset

#print axioms sum_M_qr_le_Gamma_qr

end APW4HistoricalQFibre
