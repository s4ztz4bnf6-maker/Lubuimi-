import Mathlib

set_option autoImplicit false

/-!
# Exact L = 945 CRT-compatible divisor moments

The finite divisor family is D = {3,5,7,9,15,21,27,35,45,63,105,135,189,315,945}.
This module checks its reciprocal density and the exact contributions from
pairwise-coprime pairs and triples. For pairwise-coprime moduli, CRT makes
every choice of residues compatible, so 1/(d₁⋯dₖ) is the corresponding
intersection density. This is a finite arithmetic checkpoint, not a proof
of a universal odd-covering statement or a private-mass bound.
-/

namespace OddCoveringL945MomentAudit

def divisors945 : Finset ℕ :=
  {3, 5, 7, 9, 15, 21, 27, 35, 45, 63, 105, 135, 189, 315, 945}

def divisorDensity : ℚ :=
  ∑ d ∈ divisors945, (1 : ℚ) / d

def coprimePairs : Finset (ℕ × ℕ) :=
  (divisors945.product divisors945).filter
    (fun p => p.1 < p.2 ∧ Nat.Coprime p.1 p.2)

def coprimePairDensity : ℚ :=
  ∑ p ∈ coprimePairs, (1 : ℚ) / (p.1 * p.2)

def coprimeTriples : Finset ((ℕ × ℕ) × ℕ) :=
  ((divisors945.product divisors945).product divisors945).filter
    (fun t =>
      t.1.1 < t.1.2 ∧ t.1.2 < t.2 ∧
      Nat.Coprime t.1.1 t.1.2 ∧
      Nat.Coprime t.1.1 t.2 ∧
      Nat.Coprime t.1.2 t.2)

def coprimeTripleDensity : ℚ :=
  ∑ t ∈ coprimeTriples, (1 : ℚ) / (t.1.1 * t.1.2 * t.2)

theorem divisorDensity_eq_65_over_63 :
    divisorDensity = (65 : ℚ) / 63 := by
  decide

theorem coprimePairs_card_eq_16 :
    coprimePairs.card = 16 := by
  decide

theorem coprimePairDensity_eq_74_over_315 :
    coprimePairDensity = (74 : ℚ) / 315 := by
  decide

theorem coprimeTriples_card_eq_3 :
    coprimeTriples.card = 3 := by
  decide

theorem coprimeTripleDensity_eq_13_over_945 :
    coprimeTripleDensity = (13 : ℚ) / 945 := by
  decide

#print axioms divisorDensity_eq_65_over_63
#print axioms coprimePairs_card_eq_16
#print axioms coprimePairDensity_eq_74_over_315
#print axioms coprimeTriples_card_eq_3
#print axioms coprimeTripleDensity_eq_13_over_945

end OddCoveringL945MomentAudit
