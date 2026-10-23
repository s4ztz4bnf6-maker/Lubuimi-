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

/--
Pairwise difference expansion for finite rational data. It expresses
the total squared deviation from the arithmetic mean without division,
so the identity itself remains valid even when later weights have zero
mass. This is an algebraic identity, not yet a probability variance bound.
-/
theorem finite_pairwise_square_difference
    {α : Type*} [Fintype α] (f : α → ℚ) :
    (Fintype.card α : ℚ) * (∑ a : α, f a ^ 2) - (∑ a : α, f a) ^ 2
      = (∑ a : α, ∑ b : α, (f a - f b) ^ 2) / 2 := by
  classical
  have hcard : (Fintype.card α : ℚ) = ∑ a : α, (1 : ℚ) := by
    simp
  have hsum :
      (∑ a : α, ∑ b : α, (f a - f b) ^ 2)
        = 2 * ((Fintype.card α : ℚ) * (∑ a : α, f a ^ 2) - (∑ a : α, f a) ^ 2) := by
    simp_rw [sub_sq]
    rw [hcard]
    simp [Finset.sum_sub_distrib, Finset.sum_add_distrib, Finset.sum_mul,
      Finset.mul_sum, mul_comm, mul_left_comm, mul_assoc]
  rw [hsum]
  ring

#print axioms BBMSTAudit.finite_pairwise_square_difference

/--
The pairwise squared-difference aggregate is nonnegative over the rationals.
Combined with the pairwise square-difference identity, this yields a
finite Cauchy-Schwarz-shaped inequality without introducing a probability measure.
-/
theorem finite_pairwise_square_difference_nonneg
    {α : Type*} [Fintype α] (f : α → ℚ) :
    0 ≤ ∑ a : α, ∑ b : α, (f a - f b) ^ 2 := by
  positivity

#print axioms BBMSTAudit.finite_pairwise_square_difference_nonneg

/--
Finite rational Cauchy-Schwarz inequality derived from the pairwise
squared-difference identity. This is a deterministic finite-sum lemma;
it does not itself identify a BBMST probability measure or event family.
-/
theorem finite_sum_sq_le_card_mul_sum_sq
    {α : Type*} [Fintype α] (f : α → ℚ) :
    (∑ a : α, f a) ^ 2 ≤ (Fintype.card α : ℚ) * ∑ a : α, f a ^ 2 := by
  have h := finite_pairwise_square_difference (f := f)
  have hn := finite_pairwise_square_difference_nonneg (f := f)
  linarith

#print axioms BBMSTAudit.finite_sum_sq_le_card_mul_sum_sq

/--
For a nonempty finite type, the finite Cauchy-Schwarz inequality above
can be normalized by cardinality to bound the square of the arithmetic
mean by the arithmetic mean of squares. The nonempty hypothesis makes the
normalizing denominator positive.
-/
theorem finite_mean_sq_le_mean_square
    {α : Type*} [Fintype α] [Nonempty α] (f : α → ℚ) :
    ((∑ a : α, f a) / (Fintype.card α : ℚ)) ^ 2
      ≤ (∑ a : α, f a ^ 2) / (Fintype.card α : ℚ) := by
  have hcard : (0 : ℚ) < (Fintype.card α : ℚ) := by
    exact_mod_cast (Fintype.card_pos_iff.mpr ‹Nonempty α›)
  have hcs := finite_sum_sq_le_card_mul_sum_sq (f := f)
  have hdiv := div_le_div_of_nonneg_right hcs (le_of_lt hcard)
  have hcard0 : (Fintype.card α : ℚ) ≠ 0 := ne_of_gt hcard
  field_simp
  nlinarith

#print axioms BBMSTAudit.finite_mean_sq_le_mean_square

/--
The square of a rational event indicator is the same indicator. This
connects finite counting identities to event indicators, without yet
claiming that counting measure is the BBMST probability measure.
-/
theorem finite_event_indicator_square
    {α : Type*} [Fintype α] (P : α → Prop) :
    (∑ a : α, (if P a then (1 : ℚ) else 0) ^ 2)
      = ∑ a : α, if P a then (1 : ℚ) else 0 := by
  simp

/--
The product of two rational event indicators is the indicator of their
intersection. This is the pointwise algebraic bridge needed before
summing pairwise intersections under a specified finite measure.
-/
theorem finite_event_indicator_product
    {α : Type*} (P Q : α → Prop) (a : α) :
    (if P a then (1 : ℚ) else 0) * (if Q a then (1 : ℚ) else 0)
      = if P a ∧ Q a then (1 : ℚ) else 0 := by
  by_cases hp : P a <;> by_cases hq : Q a <;> simp [hp, hq]

#print axioms BBMSTAudit.finite_event_indicator_square
#print axioms BBMSTAudit.finite_event_indicator_product


end BBMSTAudit
