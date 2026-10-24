import Mathlib

namespace BBMSTAudit

/-- Uniform mass sums to one on a nonempty finite sample space. -/
theorem uniform_mass_total
    (Ω : Type*) [Fintype Ω] [Nonempty Ω] :
    (∑ _ω : Ω, (1 : ℚ) / (Fintype.card Ω : ℚ)) = 1 := by
  have hcardNat : 0 < Fintype.card Ω := Fintype.card_pos
  have hcard : (Fintype.card Ω : ℚ) ≠ 0 := by
    exact_mod_cast (Nat.ne_of_gt hcardNat)
  simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  field_simp

#print axioms BBMSTAudit.uniform_mass_total

end BBMSTAudit
