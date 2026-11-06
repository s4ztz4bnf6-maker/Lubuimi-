import Mathlib

namespace BBMSTAudit

/--
Algebraic factorization for two independent finite coordinate blocks.
This is only the disjoint-block algebraic kernel; it does not identify
BBMST events or justify factorization when coordinate supports overlap.
-/
theorem disjoint_block_sum_factorization
    {α β : Type*} [Fintype α] [Fintype β]
    (f : α → ℚ) (g : β → ℚ) :
    (∑ a : α, f a) * (∑ b : β, g b)
      = ∑ a : α, ∑ b : β, f a * g b := by
  simp_rw [Finset.sum_mul]
  simp [Finset.mul_sum, mul_comm, mul_left_comm, mul_assoc]

#print axioms BBMSTAudit.disjoint_block_sum_factorization

end BBMSTAudit
