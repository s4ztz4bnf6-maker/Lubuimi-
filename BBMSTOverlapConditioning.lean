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

/--
Finite second-moment expansion. It expresses the square of a finite
aggregate as a sum over ordered pairs. This is the algebraic shape needed
before a BBMST second-moment estimate can be specialized to actual
hyperplane indicators and the paper's probability measure.
-/
theorem finite_square_sum_expansion
    {α : Type*} [Fintype α] (f : α → ℚ) :
    (∑ a : α, f a) ^ 2 = ∑ a : α, ∑ b : α, f a * f b := by
  classical
  rw [pow_two, Finset.sum_mul]
  simp_rw [Finset.mul_sum]

#print axioms BBMSTAudit.finite_weighted_fiber_expansion
#print axioms BBMSTAudit.finite_square_sum_expansion

/--
Weighted finite second-moment expansion. The weight can represent an
unnormalized finite mass; normalization and identification with the paper's
probability measure remain separate obligations.
-/
theorem finite_weighted_square_sum_expansion
    {α : Type*} [Fintype α] (w f : α → ℚ) :
    (∑ a : α, w a * f a) ^ 2
      = ∑ a : α, ∑ b : α, (w a * f a) * (w b * f b) := by
  simpa using
    (finite_square_sum_expansion (f := fun a : α => w a * f a))

#print axioms BBMSTAudit.finite_weighted_square_sum_expansion

end BBMSTAudit
