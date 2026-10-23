import Mathlib

namespace BBMSTAudit

/--
Finite weighted conditioning identity.

For each shared-coordinate assignment c, the residual coordinate blocks
are represented by independent finite index types α and β. The identity
expands the conditional product into a sum over the two residual blocks.
It is algebraic only: a probability-space application must separately prove
that its fiber weights and conditional masses match the BBMST definitions.
-/
theorem finite_weighted_fiber_expansion
    {α β γ : Type*} [Fintype α] [Fintype β] [Fintype γ]
    (w : γ → ℚ) (f : γ → α → ℚ) (g : γ → β → ℚ) :
    (∑ c : γ, w c * ((∑ a : α, f c a) * (∑ b : β, g c b)))
      = ∑ c : γ, ∑ a : α, ∑ b : β, w c * (f c a * g c b) := by
  classical
  calc
    (∑ c : γ, w c * ((∑ a : α, f c a) * (∑ b : β, g c b)))
        = ∑ c : γ, (w c * (∑ a : α, f c a)) * (∑ b : β, g c b) := by
          simp_rw [mul_assoc]
    _ = ∑ c : γ, (∑ a : α, w c * f c a) * (∑ b : β, g c b) := by
          simp_rw [Finset.mul_sum]
    _ = ∑ c : γ, ∑ a : α, (w c * f c a) * (∑ b : β, g c b) := by
          simp_rw [Finset.sum_mul]
    _ = ∑ c : γ, ∑ a : α, ∑ b : β, (w c * f c a) * g c b := by
          simp_rw [Finset.mul_sum]
    _ = ∑ c : γ, ∑ a : α, ∑ b : β, w c * (f c a * g c b) := by
          simp_rw [mul_assoc]

#print axioms BBMSTAudit.finite_weighted_fiber_expansion

end BBMSTAudit
