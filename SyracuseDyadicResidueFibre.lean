import Mathlib
import BBMSTFiniteFibreUpdate

/-!
# Finite dyadic residue cylinders for the Syracuse tail

This module is a genuine finite residue-class model, unlike an interval
chosen only to have the same cardinality. A tail is a specified residue
class modulo 2^B inside the common ambient group of residues modulo
2^Bstar. Its complement is the union of all finite refinements which leave
that tail cylinder.

The remaining Syracuse-specific obligation is to instantiate the tail
residue from the exact prefix word and prove that the child valuation
cylinders are precisely the corresponding sibling residue classes.
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
