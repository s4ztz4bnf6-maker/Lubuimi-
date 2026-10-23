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
  have hinner (a : α) :
      (∑ b : α, (f a - f b) ^ 2) =
        (Fintype.card α : ℚ) * f a ^ 2
          - 2 * f a * (∑ b : α, f b) + ∑ b : α, f b ^ 2 := by
    calc
      (∑ b : α, (f a - f b) ^ 2)
          = ∑ b : α, (f a ^ 2 - 2 * f a * f b + f b ^ 2) := by
              apply Finset.sum_congr rfl
              intro b hb
              ring
      _ = (Fintype.card α : ℚ) * f a ^ 2
            - 2 * f a * (∑ b : α, f b) + ∑ b : α, f b ^ 2 := by
              simp [Finset.sum_add_distrib, Finset.sum_sub_distrib,
                Finset.sum_mul, Finset.mul_sum,
                mul_comm, mul_left_comm, mul_assoc]
  have hdouble :
      (∑ a : α, ∑ b : α, (f a - f b) ^ 2) =
        (Fintype.card α : ℚ) * (∑ a : α, f a ^ 2)
          - 2 * (∑ a : α, f a) * (∑ a : α, f a)
          + (Fintype.card α : ℚ) * (∑ a : α, f a ^ 2) := by
    calc
      (∑ a : α, ∑ b : α, (f a - f b) ^ 2)
          = ∑ a : α,
              ((Fintype.card α : ℚ) * f a ^ 2
                - 2 * f a * (∑ b : α, f b) + ∑ b : α, f b ^ 2) := by
              apply Finset.sum_congr rfl
              intro a ha
              exact hinner a
      _ = (Fintype.card α : ℚ) * (∑ a : α, f a ^ 2)
            - 2 * (∑ a : α, f a) * (∑ a : α, f a)
            + (Fintype.card α : ℚ) * (∑ a : α, f a ^ 2) := by
              simp [Finset.sum_add_distrib, Finset.sum_sub_distrib,
                Finset.sum_mul, Finset.mul_sum,
                mul_comm, mul_left_comm, mul_assoc]
  rw [hdouble]
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


/--
Second-moment expansion for a finite family of events, expressed directly
as a sum of pairwise intersections. This is the exact indicator-level bridge
needed before applying source-specific BBMST intersection estimates; no
independence assumption is made.
-/
theorem finite_event_count_second_moment_expansion
    {α : Type*} [Fintype α] (P : α → Prop) :
    (∑ a : α, if P a then (1 : ℚ) else 0) ^ 2
      = ∑ a : α, ∑ b : α, if P a ∧ P b then (1 : ℚ) else 0 := by
  classical
  rw [finite_square_sum_expansion]
  apply Finset.sum_congr rfl
  intro a ha
  apply Finset.sum_congr rfl
  intro b hb
  by_cases hpa : P a <;> by_cases hpb : P b <;> simp [hpa, hpb]

#print axioms finite_event_count_second_moment_expansion
