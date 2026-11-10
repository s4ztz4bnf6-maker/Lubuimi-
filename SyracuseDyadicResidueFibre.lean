import Mathlib
import BBMSTFiniteFibreUpdate

/-!
# Finite dyadic residue cylinders for the Syracuse tail

Author: Ta-Yoshua Lubuimi.

The mathematical input is the already-proved finite valuation-word cylinder
theorem. For a word alpha=(a_0,...,a_{k-1}), with
A=sum_j a_j, A_j=sum_{i<j} a_i and
C_k=sum_{j<k} 3^(k-1-j) 2^A_j, it gives
2^A n_k = 3^k n_0 + C_k and the unique prefix class
n_0 = (2^A-C_k) (3^k)^(-1) modulo 2^(A+1).

For a cutoff B, the already-derived tail condition is the unique class
3^(k+1)n_0 + 3C_k + 2^A = 0 modulo 2^(A+B+1). The exact next-valuation-b
child is given by
3^(k+1)n_0 + 3C_k + 2^A = 2^(A+b) modulo 2^(A+b+1).
In the common refinement, the prefix has 2^B lifts, child b has 2^(B-b)
lifts, and the tail has one lift. These are established mathematical
residue-class facts, not conjectures or cardinality-only heuristics.

This file currently formalizes the generic finite residue cylinder and its
lift structure. The remaining task in this PR is the Lean instantiation of
the parameter r with the explicit prefix/tail formulas above and the proof
that the exact valuation predicates coincide with the stated sibling
residue classes. That is a formal integration task; it does not reopen the
mathematical theorem. The historical APW4 BIB/event-incidence transport is
a separate, source-dependent question and is not asserted here.
-/

namespace SyracuseDyadicResidueFibre

open BBMSTFiniteFibreUpdate

/-- The common finite ambient fibre, represented by residues in
[0, 2^Bstar). -/
def allAtoms (Bstar : ℕ) : Finset (Fin (2 ^ Bstar)) := Finset.univ

/-- Lift a residue modulo 2^B to all of its representatives modulo
2^Bstar. The parameter hB is essential: without B ≤ Bstar, the stated
number of lifts is not correct. -/
def liftTailEmbedding (B Bstar : ℕ) (hB : B ≤ Bstar)
    (r : Fin (2 ^ B)) :
    Fin (2 ^ (Bstar - B)) ↪ Fin (2 ^ Bstar) where
  toFun q :=
    ⟨r.val + 2 ^ B * q.val, by
      have hq : q.val + 1 ≤ 2 ^ (Bstar - B) :=
        Nat.succ_le_of_lt q.isLt
      have hpow : 2 ^ B * 2 ^ (Bstar - B) = 2 ^ Bstar := by
        rw [← pow_add]
        congr 1
        omega
      calc
        r.val + 2 ^ B * q.val < 2 ^ B + 2 ^ B * q.val :=
          Nat.add_lt_add_right r.isLt _
        _ = 2 ^ B * (q.val + 1) := by ring
        _ ≤ 2 ^ B * 2 ^ (Bstar - B) :=
          Nat.mul_le_mul_left _ hq
        _ = 2 ^ Bstar := hpow⟩
  inj' := by
    intro q₁ q₂ h
    apply Fin.ext
    have hv := congrArg Fin.val h
    change r.val + 2 ^ B * q₁.val = r.val + 2 ^ B * q₂.val at hv
    have hmul :
        2 ^ B * q₁.val = 2 ^ B * q₂.val :=
      Nat.add_left_cancel hv
    exact Nat.eq_of_mul_eq_mul_left (by positivity : 0 < 2 ^ B) hmul

/-- The actual tail cylinder: all lifts of one fixed residue r modulo
2^B. -/
def tailAtoms (B Bstar : ℕ) (hB : B ≤ Bstar)
    (r : Fin (2 ^ B)) : Finset (Fin (2 ^ Bstar)) :=
  Finset.univ.map (liftTailEmbedding B Bstar hB r)

/-- The candidate region is the complement of the tail residue cylinder. -/
def candidateAtoms (B Bstar : ℕ) (hB : B ≤ Bstar)
    (r : Fin (2 ^ B)) : Finset (Fin (2 ^ Bstar)) :=
  allAtoms Bstar \ tailAtoms B Bstar hB r

@[simp] theorem card_allAtoms (Bstar : ℕ) :
    (allAtoms Bstar).card = 2 ^ Bstar := by
  simp [allAtoms]

@[simp] theorem card_tailAtoms (B Bstar : ℕ)
    (hB : B ≤ Bstar) (r : Fin (2 ^ B)) :
    (tailAtoms B Bstar hB r).card = 2 ^ (Bstar - B) := by
  simp [tailAtoms]

/-- Membership in the tail is exactly the congruence condition modulo
2^B, not merely a cardinality coincidence. -/
theorem mem_tailAtoms_iff (B Bstar : ℕ)
    (hB : B ≤ Bstar) (r : Fin (2 ^ B))
    (x : Fin (2 ^ Bstar)) :
    x ∈ tailAtoms B Bstar hB r ↔
      x.val % 2 ^ B = r.val := by
  constructor
  · intro hx
    rcases Finset.mem_map.mp hx with ⟨q, hq, hqx⟩
    have hv := congrArg Fin.val hqx
    change r.val + 2 ^ B * q.val = x.val at hv
    rw [← hv]
    simp [Nat.add_mod, Nat.mul_mod, Nat.mod_eq_of_lt r.isLt]
  · intro hx
    have hpowDiv : 2 ^ (Bstar - B) * 2 ^ B = 2 ^ Bstar := by
      rw [Nat.mul_comm, ← pow_add]
      congr 1
      omega
    have hq :
        x.val / 2 ^ B < 2 ^ (Bstar - B) := by
      apply (Nat.div_lt_iff_lt_mul (by positivity : 0 < 2 ^ B)).2
      calc
        x.val < 2 ^ Bstar := x.isLt
        _ = 2 ^ (Bstar - B) * 2 ^ B := hpowDiv.symm
    let q : Fin (2 ^ (Bstar - B)) := ⟨x.val / 2 ^ B, hq⟩
    have hdecomp : x.val % 2 ^ B + 2 ^ B * (x.val / 2 ^ B) = x.val :=
      Nat.mod_add_div _ _
    have hval : r.val + 2 ^ B * q.val = x.val := by
      simpa [q, hx] using hdecomp
    apply Finset.mem_map.mpr
    refine ⟨q, Finset.mem_univ _, ?_⟩
    apply Fin.ext
    change r.val + 2 ^ B * q.val = x.val
    exact hval

@[simp] theorem card_candidateAtoms (B Bstar : ℕ)
    (hB : B ≤ Bstar) (r : Fin (2 ^ B)) :
    (candidateAtoms B Bstar hB r).card =
      2 ^ Bstar - 2 ^ (Bstar - B) := by
  unfold candidateAtoms allAtoms
  rw [Finset.card_sdiff_of_subset (Finset.subset_univ _)]
  simp [card_tailAtoms]

theorem candidate_tail_disjoint (B Bstar : ℕ)
    (hB : B ≤ Bstar) (r : Fin (2 ^ B)) :
    Disjoint (candidateAtoms B Bstar hB r)
      (tailAtoms B Bstar hB r) := by
  apply Finset.disjoint_left.mpr
  intro x hxC hxT
  exact (Finset.mem_sdiff.mp hxC).2 hxT

theorem candidate_union_tail (B Bstar : ℕ)
    (hB : B ≤ Bstar) (r : Fin (2 ^ B)) :
    candidateAtoms B Bstar hB r ∪ tailAtoms B Bstar hB r =
      allAtoms Bstar := by
  ext x
  simp [candidateAtoms, allAtoms]

/-- The exact complementary mass of a dyadic residue cylinder in the
uniform ambient fibre. -/
theorem candidate_mass_eq_one_sub_two_pow
    (B Bstar : ℕ) (hB : B ≤ Bstar)
    (r : Fin (2 ^ B)) :
    ((candidateAtoms B Bstar hB r).card : ℚ) /
        ((allAtoms Bstar).card : ℚ) =
      1 - 1 / (2 : ℚ) ^ B := by
  rw [card_candidateAtoms, card_allAtoms]
  have hnat : 2 ^ (Bstar - B) ≤ 2 ^ Bstar :=
    Nat.pow_le_pow_right (by omega : 1 ≤ 2) (Nat.sub_le _ _)
  rw [Nat.cast_sub hnat]
  push_cast
  have hpow : (2 : ℚ) ^ Bstar =
      (2 : ℚ) ^ (Bstar - B) * (2 : ℚ) ^ B := by
    rw [← pow_add]
    congr 1
    omega
  rw [hpow]
  field_simp

#print axioms liftTailEmbedding
#print axioms mem_tailAtoms_iff
#print axioms card_tailAtoms
#print axioms card_candidateAtoms
#print axioms candidate_mass_eq_one_sub_two_pow

end SyracuseDyadicResidueFibre


namespace SyracuseDyadicResidueFibre

/-!
## Explicit normalized prefix-tail residue

For a fixed valuation prefix, write the initial odd integer in its
already-established prefix cylinder as
`r₀ + 2^(A+1) q`. If
`2^(A+1) d = 3^(k+1) r₀ + 3 Cₖ + 2^A`,
then the next tail condition reduces exactly to
`3^(k+1) q + d = 0` modulo `2^B`.
Since `3^(k+1)` is a unit modulo `2^B`, this determines one and only
one normalized tail coordinate. This formalizes the explicit residue
formula; the hypothesis defining d is the exact divisibility condition
supplied by the prefix-cylinder arithmetic.
-/

/-- The unique normalized tail coordinate in the finite ring ZMod (2^B). -/
def explicitTailCoordinate (B k d : ℕ) : ZMod (2 ^ B) :=
  -(d : ZMod (2 ^ B)) *
    (((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B))⁻¹)

/-- The odd coefficient 3^(k+1) is invertible modulo every dyadic modulus. -/
theorem threePow_isUnit_mod_twoPow (B k : ℕ) :
    IsUnit ((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B)) := by
  have hcop : Nat.Coprime (3 ^ (k + 1)) (2 ^ B) :=
    Nat.Coprime.pow_right B
      (Nat.Coprime.pow_left (k + 1) (by decide : Nat.Coprime 3 2))
  exact (ZMod.isUnit_iff_coprime (3 ^ (k + 1)) (2 ^ B)).2 hcop

/-- The explicit tail coordinate satisfies the normalized tail congruence. -/
theorem explicitTailCoordinate_spec (B k d : ℕ) :
    ((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B)) *
        explicitTailCoordinate B k d +
      (d : ZMod (2 ^ B)) = 0 := by
  unfold explicitTailCoordinate
  have hcop : Nat.Coprime (3 ^ (k + 1)) (2 ^ B) :=
    Nat.Coprime.pow_right B
      (Nat.Coprime.pow_left (k + 1) (by decide : Nat.Coprime 3 2))
  have hinv :
      ((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B)) *
        (((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B))⁻¹) = 1 :=
    ZMod.coe_mul_inv_eq_one _ hcop
  calc
    ((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B)) *
        (-((d : ZMod (2 ^ B))) *
          (((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B))⁻¹)) +
        (d : ZMod (2 ^ B))
      = -((d : ZMod (2 ^ B))) *
          ((((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B)) *
            (((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B))⁻¹))) +
          (d : ZMod (2 ^ B)) := by ring
    _ = 0 := by rw [hinv]; ring

/-- The normalized tail congruence has exactly one solution modulo 2^B. -/
theorem explicitTailCoordinate_unique (B k d : ℕ)
    (q : ZMod (2 ^ B)) :
    ((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B)) * q +
        (d : ZMod (2 ^ B)) = 0
      ↔ q = explicitTailCoordinate B k d := by
  constructor
  · intro h
    have hmul :
        ((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B)) * q =
          -((d : ZMod (2 ^ B))) :=
      (eq_neg_iff_add_eq_zero).2 h
    have hcop : Nat.Coprime (3 ^ (k + 1)) (2 ^ B) :=
      Nat.Coprime.pow_right B
        (Nat.Coprime.pow_left (k + 1) (by decide : Nat.Coprime 3 2))
    have hinv :
        ((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B)) *
          (((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B))⁻¹) = 1 :=
      ZMod.coe_mul_inv_eq_one _ hcop
    have hinv' :
        (((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B))⁻¹) *
          ((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B)) = 1 := by
      simpa [mul_comm] using hinv
    calc
      q = 1 * q := by simp
      _ = ((((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B))⁻¹) *
            ((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B))) * q := by rw [hinv']
      _ = (((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B))⁻¹) *
            (((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B)) * q) := by ring
      _ = (((3 ^ (k + 1) : ℕ) : ZMod (2 ^ B))⁻¹) *
            (-((d : ZMod (2 ^ B)))) := by rw [hmul]
      _ = explicitTailCoordinate B k d := by
        unfold explicitTailCoordinate
        ring
  · intro h
    rw [h]
    exact explicitTailCoordinate_spec B k d

/-- Finite representative of the explicit normalized tail coordinate. -/
def explicitTailCoordinateFin (B k d : ℕ) : Fin (2 ^ B) :=
  ⟨(explicitTailCoordinate B k d).val,
    (explicitTailCoordinate B k d).isLt⟩

/-- The generic residue cylinder from the first part of this file is now
instantiated by the explicit normalized prefix-tail residue. -/
theorem explicitTailAtoms_mem_iff (B k d : ℕ)
    (x : Fin (2 ^ B)) :
    x ∈ tailAtoms B B (Nat.le_refl B)
        (explicitTailCoordinateFin B k d)
      ↔ x.val = (explicitTailCoordinateFin B k d).val := by
  rw [mem_tailAtoms_iff]
  constructor
  · intro h
    simpa [Nat.mod_eq_of_lt x.isLt] using h
  · intro h
    simpa [h, Nat.mod_eq_of_lt x.isLt]

/-- The explicit tail cylinder is a singleton in the normalized
common-refinement coordinate. -/
theorem explicitTailAtoms_card (B k d : ℕ) :
    (tailAtoms B B (Nat.le_refl B)
      (explicitTailCoordinateFin B k d)).card = 1 := by
  simpa [explicitTailCoordinateFin] using
    (card_tailAtoms B B (Nat.le_refl B)
      (explicitTailCoordinateFin B k d))

/-- If the prefix-tail numerator is divisible by 2^(A+1), its quotient d
makes the original affine tail expression factor exactly through the
normalized coordinate q. -/
theorem prefixTail_lift_factorization
    (A k r₀ Cₖ d q : ℕ)
    (hdiv :
      2 ^ (A + 1) * d =
        3 ^ (k + 1) * r₀ + 3 * Cₖ + 2 ^ A) :
    3 ^ (k + 1) * (r₀ + 2 ^ (A + 1) * q) +
        3 * Cₖ + 2 ^ A =
      2 ^ (A + 1) * (3 ^ (k + 1) * q + d) := by
  rw [Nat.mul_add, hdiv]
  ring

/-- The explicit tail coordinate has the exact complementary candidate
mass in the finite normalized prefix fibre. -/
theorem explicitCandidate_mass (B k d : ℕ) :
    ((candidateAtoms B B (Nat.le_refl B)
        (explicitTailCoordinateFin B k d)).card : ℚ) /
      ((allAtoms B).card : ℚ) =
        1 - 1 / (2 : ℚ) ^ B := by
  exact candidate_mass_eq_one_sub_two_pow B B
    (Nat.le_refl B) (explicitTailCoordinateFin B k d)

#print axioms threePow_isUnit_mod_twoPow
#print axioms explicitTailCoordinate_spec
#print axioms explicitTailCoordinate_unique
#print axioms explicitTailAtoms_mem_iff
#print axioms explicitTailAtoms_card
#print axioms prefixTail_lift_factorization
#print axioms explicitCandidate_mass

end SyracuseDyadicResidueFibre
