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


/-!
## Explicit preimage-fibre interface

This layer derives the hypotheses of the local q-fibre counting theorem
when fibres and blocks are genuine preimages of maps. It is a reusable
formal interface for the eventual arithmetic projections and block labels.
It is **not** yet the historical APW4 instantiation: the source-specific
maps, selected sets, and block-label function must still be recovered.
-/

namespace APW4HistoricalQFibre

namespace PreimageModel

variable {G X Xq Xr H : Type*}
variable [Fintype G] [DecidableEq G]
variable [DecidableEq X] [DecidableEq Xq] [DecidableEq Xr]
variable [Fintype H] [DecidableEq H]

/-- Fibre over one label of a finite projection. -/
def fibre (π : G → X) (x : X) : Finset G :=
  Finset.univ.filter fun z => π z = x

/-- The inverse image of a selected set of projection labels. -/
def visible (π : G → X) (U : Finset X) : Finset G :=
  Finset.univ.filter fun z => π z ∈ U

/-- The block with label h under a single block-label map. -/
def block (c : G → H) (h : H) : Finset G :=
  Finset.univ.filter fun z => c z = h

/-- A fibre over a selected label is contained in the inverse image
of the selected label set. -/
theorem fibre_subset_visible
    (π : G → X) (U : Finset X) (x : X) (hx : x ∈ U) :
    fibre π x ⊆ visible π U := by
  intro z hz
  have hz' : π z = x := by
    simpa [fibre] using hz
  simp [visible, hz', hx]

/-- Distinct fibres of one block-label map are pairwise disjoint. -/
theorem block_pairwise_disjoint
    (c : G → H) :
    ∀ h₁ h₂, h₁ ≠ h₂ → Disjoint (block c h₁) (block c h₂) := by
  intro h₁ h₂ hne
  apply Finset.disjoint_left.mpr
  intro z hz₁ hz₂
  have h₁z : c z = h₁ := by simpa [block] using hz₁
  have h₂z : c z = h₂ := by simpa [block] using hz₂
  exact hne (h₁z.symm.trans h₂z)

/-- The q-fibre aggregate bound follows automatically for genuine
preimage fibres and blocks of one label map. The arithmetic projections
and selected label sets are explicit parameters; no historical
identification is asserted by this generic theorem. -/
theorem sum_M_qr_le_Gamma_qr_of_preimage_maps
    (πq : G → Xq) (πr : G → Xr)
    (Uq : Finset Xq) (Ur : Finset Xr)
    (c : G → H) (x : Xq) (y : Xr) (g : H)
    (hx : x ∈ Uq) (hy : y ∈ Ur) :
    (∑ h : H,
      M_qr (fibre πq x) (fibre πr y) (block c) g h)
      ≤
    Gamma_qr (visible πq Uq) (visible πr Ur) (block c) g := by
  exact sum_M_qr_le_Gamma_qr
    (fibre πq x) (fibre πr y)
    (visible πq Uq) (visible πr Ur) (block c) g
    (fibre_subset_visible πq Uq x hx)
    (fibre_subset_visible πr Ur y hy)
    (block_pairwise_disjoint c)

#print axioms fibre_subset_visible
#print axioms block_pairwise_disjoint
#print axioms sum_M_qr_le_Gamma_qr_of_preimage_maps

end PreimageModel

end APW4HistoricalQFibre


/-!
## Coordinate-only residue labels for the preimage model

This is a set-level coordinate representation in Fin B, not a quotient
ring homomorphism. Its divisor argument is retained only to record the
intended arithmetic context; it is not used by the coordinate map. For the
genuine reduction map ZMod N → ZMod B when B divides N, use the separate
ZModQuotientProjectionModel below. In both models the selected supports and
block-label map remain explicit because their historical APW4 definitions
are not supplied by the 17-page source manuscript.
-/

namespace APW4HistoricalQFibre

namespace ResidueCoordinateModel

/-- Canonical residue label of a point of ZMod N modulo a positive
working fibre modulus B. -/
def residueProjection
    {N B : ℕ} (hB : 0 < B) (_hdiv : B ∣ N) :
    ZMod N → Fin B :=
  fun z => ⟨z.val % B, Nat.mod_lt _ hB⟩

@[simp] theorem residueProjection_val
    {N B : ℕ} (hB : 0 < B) (hdiv : B ∣ N) (z : ZMod N) :
    (residueProjection hB hdiv z).val = z.val % B :=
  rfl

/-- Working q-fibre: the inverse image of one residue label modulo B. -/
def residueFibre
    {N B : ℕ} [Fintype (ZMod N)] [DecidableEq (ZMod N)]
    (hB : 0 < B) (hdiv : B ∣ N) (x : Fin B) :
    Finset (ZMod N) :=
  PreimageModel.fibre (residueProjection hB hdiv) x

/-- Working visible set V_q: the inverse image of the selected residue
set U_q under the same canonical residue projection. -/
def residueVisible
    {N B : ℕ} [Fintype (ZMod N)] [DecidableEq (ZMod N)]
    (hB : 0 < B) (hdiv : B ∣ N) (U : Finset (Fin B)) :
    Finset (ZMod N) :=
  PreimageModel.visible (residueProjection hB hdiv) U

/-- The local aggregate q-fibre inequality for the concrete residue
projections on ZMod N. The selected residue sets U_q,U_r and the block
label map c are explicit parameters; no source-specific identification
of C_h is assumed. -/
theorem sum_M_qr_le_Gamma_qr_of_residue_projections
    {N Bq Br : ℕ} [NeZero N] [Fintype (ZMod N)]
    [DecidableEq (ZMod N)]
    (hBq : 0 < Bq) (hdivq : Bq ∣ N)
    (hBr : 0 < Br) (hdivr : Br ∣ N)
    {H : Type*} [Fintype H] [DecidableEq H]
    (Uq : Finset (Fin Bq)) (Ur : Finset (Fin Br))
    (c : ZMod N → H)
    (x : Fin Bq) (y : Fin Br) (g : H)
    (hx : x ∈ Uq) (hy : y ∈ Ur) :
    (∑ h : H,
      M_qr (residueFibre hBq hdivq x) (residueFibre hBr hdivr y)
        (PreimageModel.block c) g h)
      ≤
    Gamma_qr (residueVisible hBq hdivq Uq) (residueVisible hBr hdivr Ur)
      (PreimageModel.block c) g := by
  exact PreimageModel.sum_M_qr_le_Gamma_qr_of_preimage_maps
    (residueProjection hBq hdivq) (residueProjection hBr hdivr)
    Uq Ur c x y g hx hy

#print axioms residueProjection_val
#print axioms sum_M_qr_le_Gamma_qr_of_residue_projections

end ResidueProjectionModel


/-!
## Genuine quotient-homomorphism specialization

Unlike the coordinate-valued residue map above, this version uses the
actual reduction homomorphisms ZMod N → ZMod B for divisors B | N.
It derives the local aggregate inequality for their inverse-image fibres.
The selected supports Uq,Ur and the common block-label map c remain explicit
inputs; their identification with the historical APW4 objects is still open.
-/

namespace ZModQuotientProjectionModel

/-- The genuine quotient ring homomorphism ZMod N → ZMod B. -/
def quotientProjection
    {N B : ℕ} [NeZero B] (hdiv : B ∣ N) :
    ZMod N →+* ZMod B :=
  ZMod.castHom hdiv (ZMod B)

/-- The inverse image of one residue modulo B under the quotient map. -/
def quotientFibre
    {N B : ℕ} [NeZero N] [NeZero B]
    [Fintype (ZMod N)] [DecidableEq (ZMod N)]
    (hdiv : B ∣ N) (x : ZMod B) : Finset (ZMod N) :=
  PreimageModel.fibre (quotientProjection hdiv) x

/-- The selected support in ZMod N, obtained as the inverse image of U. -/
def quotientVisible
    {N B : ℕ} [NeZero N] [NeZero B]
    [Fintype (ZMod N)] [DecidableEq (ZMod N)]
    (hdiv : B ∣ N) (U : Finset (ZMod B)) : Finset (ZMod N) :=
  PreimageModel.visible (quotientProjection hdiv) U

/-- The q-fibre aggregate bound for the actual quotient homomorphisms
ZMod N → ZMod Bq and ZMod N → ZMod Br. -/
theorem sum_M_qr_le_Gamma_qr_of_quotient_homs
    {N Bq Br : ℕ} [NeZero N] [NeZero Bq] [NeZero Br]
    [Fintype (ZMod N)] [DecidableEq (ZMod N)]
    (hq : Bq ∣ N) (hr : Br ∣ N)
    {H : Type*} [Fintype H] [DecidableEq H]
    (Uq : Finset (ZMod Bq)) (Ur : Finset (ZMod Br))
    (c : ZMod N → H)
    (x : ZMod Bq) (y : ZMod Br) (g : H)
    (hx : x ∈ Uq) (hy : y ∈ Ur) :
    (∑ h : H,
      M_qr (quotientFibre hq x) (quotientFibre hr y)
        (PreimageModel.block c) g h)
      ≤
    Gamma_qr (quotientVisible hq Uq) (quotientVisible hr Ur)
      (PreimageModel.block c) g := by
  classical
  exact PreimageModel.sum_M_qr_le_Gamma_qr_of_preimage_maps
    (quotientProjection hq) (quotientProjection hr)
    Uq Ur c x y g hx hy

#print axioms quotientProjection
#print axioms sum_M_qr_le_Gamma_qr_of_quotient_homs

end ZModQuotientProjectionModel


/-!
## Exact q-power quotient specialization of the historical working fibres

The working arithmetic modulus is B_q = N / q^a when q^a divides N.
This section proves the divisor fact and instantiates the actual reduction
homomorphism ZMod N → ZMod B_q. It is still conditional on the selected
support U_q and the historical block-label map c; those source objects are
not reconstructed by this arithmetic projection alone.
-/

namespace QPowerQuotientModel

/-- The working q-fibre modulus B_q = N / q^a. -/
def qFibreModulus (N q a : ℕ) : ℕ := N / q ^ a

/-- If q^a divides N, then the working modulus B_q divides N. -/
theorem qFibreModulus_dvd_N
    {N q a : ℕ} (hdiv : q ^ a ∣ N) :
    qFibreModulus N q a ∣ N := by
  refine ⟨q ^ a, ?_⟩
  exact (Nat.div_mul_cancel hdiv).symm

/-- Positivity of B_q follows from N>0 and q>0. -/
theorem qFibreModulus_pos
    {N q a : ℕ} (hN : 0 < N) (hq : 0 < q) :
    0 < qFibreModulus N q a := by
  exact Nat.div_pos hN (pow_pos hq a)

/-- The actual quotient homomorphism for B_q=N/q^a. -/
def qFibreProjection
    {N q a : ℕ} [NeZero N]
    (hN : 0 < N) (hq : 0 < q) (hdiv : q ^ a ∣ N) :
    ZMod N →+* ZMod (qFibreModulus N q a) := by
  letI : NeZero (qFibreModulus N q a) :=
    ⟨qFibreModulus_pos hN hq⟩
  exact ZMod.castHom (qFibreModulus_dvd_N hdiv)
    (ZMod (qFibreModulus N q a))

/-- The working q-fibre F_q(x), as the inverse image of x under the
actual quotient homomorphism modulo N/q^a. -/
def qFibre
    {N q a : ℕ} [NeZero N]
    [Fintype (ZMod N)] [DecidableEq (ZMod N)]
    (hN : 0 < N) (hq : 0 < q) (hdiv : q ^ a ∣ N)
    (x : ZMod (qFibreModulus N q a)) : Finset (ZMod N) :=
  PreimageModel.fibre (qFibreProjection hN hq hdiv) x

/-- The working visible set V_q, as the inverse image of U_q under
the same quotient homomorphism. -/
def qVisible
    {N q a : ℕ} [NeZero N]
    [Fintype (ZMod N)] [DecidableEq (ZMod N)]
    (hN : 0 < N) (hq : 0 < q) (hdiv : q ^ a ∣ N)
    (U : Finset (ZMod (qFibreModulus N q a))) : Finset (ZMod N) :=
  PreimageModel.visible (qFibreProjection hN hq hdiv) U

/-- The local M/Gamma inequality for the exact q-power quotient fibres
B_q=N/q^a and B_r=N/r^b. The supports and block map remain explicit. -/
theorem sum_M_qr_le_Gamma_qr_of_q_power_quotients
    {N q r a b : ℕ} [NeZero N]
    [Fintype (ZMod N)] [DecidableEq (ZMod N)]
    (hN : 0 < N) (hq : 0 < q) (hr : 0 < r)
    (hqdvd : q ^ a ∣ N) (hrdvd : r ^ b ∣ N)
    {H : Type*} [Fintype H] [DecidableEq H]
    (Uq : Finset (ZMod (qFibreModulus N q a)))
    (Ur : Finset (ZMod (qFibreModulus N r b)))
    (c : ZMod N → H)
    (x : ZMod (qFibreModulus N q a))
    (y : ZMod (qFibreModulus N r b)) (g : H)
    (hx : x ∈ Uq) (hy : y ∈ Ur) :
    (∑ h : H,
      M_qr (qFibre hN hq hqdvd x) (qFibre hN hr hrdvd y)
        (PreimageModel.block c) g h)
      ≤
    Gamma_qr (qVisible hN hq hqdvd Uq)
      (qVisible hN hr hrdvd Ur) (PreimageModel.block c) g := by
  classical
  exact PreimageModel.sum_M_qr_le_Gamma_qr_of_preimage_maps
    (qFibreProjection hN hq hqdvd)
    (qFibreProjection hN hr hrdvd)
    Uq Ur c x y g hx hy

#print axioms qFibreModulus_dvd_N
#print axioms qFibreProjection
#print axioms sum_M_qr_le_Gamma_qr_of_q_power_quotients

end QPowerQuotientModel

end APW4HistoricalQFibre
