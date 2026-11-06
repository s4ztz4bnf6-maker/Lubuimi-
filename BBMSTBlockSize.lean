import Mathlib

namespace BBMSTAudit

/--
The effective block size in the direct extension box is at least the
square-free block size: p^(e-1) * (p-1) >= p-1 for p >= 1 and e >= 1.
This proves the elementary monotonicity factor used in the BBMST coset
extension argument. It does not prove the sieve recurrence or the global
covering theorem.
-/
theorem effective_block_size_ge_squarefree
    (p e : ℕ) (hp : 1 ≤ p) (he : 1 ≤ e) :
    p ^ (e - 1) * (p - 1) ≥ p - 1 := by
  have hpow : 1 ≤ p ^ (e - 1) := by
    have hpos : 0 < p := by omega
    have hpowpos : 0 < p ^ (e - 1) := Nat.pow_pos hpos
    omega
  calc
    p - 1 = 1 * (p - 1) := by simp
    _ ≤ p ^ (e - 1) * (p - 1) := Nat.mul_le_mul_right (p - 1) hpow

#print axioms BBMSTAudit.effective_block_size_ge_squarefree

end BBMSTAudit
