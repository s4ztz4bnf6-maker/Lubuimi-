import Mathlib

noncomputable section

-- Event indicators in theorem statements need classical decidability before proof elaboration.
local instance (p : Prop) : Decidable p := Classical.propDecidable p

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

-- The indicator-valued theorem statements below are outside BBMSTAudit,
-- so classical decidability must also be available in this scope.
local instance (p : Prop) : Decidable p := Classical.propDecidable p


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
  rw [BBMSTAudit.finite_square_sum_expansion]
  apply Finset.sum_congr rfl
  intro a ha
  apply Finset.sum_congr rfl
  intro b hb
  by_cases hpa : P a <;> by_cases hpb : P b <;> simp [hpa, hpb]

#print axioms finite_event_count_second_moment_expansion


/--
Weighted finite second-moment identity for an event count.

For an arbitrary rational mass function μ on a finite sample space Ω,
the weighted sum of the squared number of occurring events equals the
weighted sum of all pairwise-intersection indicators, pointwise over Ω.
No normalization or independence is assumed. To obtain a probability
statement, one must separately establish nonnegativity and total mass one
for μ and identify the events with the BBMST hyperplane family.
-/
theorem finite_weighted_event_count_second_moment
    {Ω I : Type*} [Fintype Ω] [Fintype I]
    (μ : Ω → ℚ) (E : I → Ω → Prop) :
    (∑ x : Ω, μ x * (∑ i : I, if E i x then (1 : ℚ) else 0) ^ 2)
      =
    ∑ x : Ω, μ x *
      (∑ i : I, ∑ j : I,
        if E i x ∧ E j x then (1 : ℚ) else 0) := by
  classical
  apply Finset.sum_congr rfl
  intro x hx
  rw [finite_event_count_second_moment_expansion (P := fun i => E i x)]

#print axioms finite_weighted_event_count_second_moment

/--
Reordered weighted second-moment identity.

The event-count second moment can also be summed first over ordered event
pairs and then over the sample space. This is the form needed for a genuine
second-moment argument: each inner sum is the mass of an event intersection.
The weights remain arbitrary rationals; positivity and normalization are
separate hypotheses for probabilistic conclusions.
-/
theorem finite_weighted_event_pair_intersection_sum
    {Ω I : Type*} [Fintype Ω] [Fintype I]
    (μ : Ω → ℚ) (E : I → Ω → Prop) :
    (∑ x : Ω, μ x * (∑ i : I, if E i x then (1 : ℚ) else 0) ^ 2)
      =
    ∑ i : I, ∑ j : I, ∑ x : Ω,
      μ x * (if E i x ∧ E j x then (1 : ℚ) else 0) := by
  classical
  calc
    (∑ x : Ω, μ x * (∑ i : I, if E i x then (1 : ℚ) else 0) ^ 2)
        = ∑ x : Ω, μ x *
            (∑ i : I, ∑ j : I,
              if E i x ∧ E j x then (1 : ℚ) else 0) := by
              exact finite_weighted_event_count_second_moment μ E
    _ = ∑ x : Ω, ∑ i : I, ∑ j : I,
          μ x * (if E i x ∧ E j x then (1 : ℚ) else 0) := by
            simp_rw [Finset.mul_sum]
    _ = ∑ i : I, ∑ x : Ω, ∑ j : I,
          μ x * (if E i x ∧ E j x then (1 : ℚ) else 0) := by
            rw [Finset.sum_comm]
    _ = ∑ i : I, ∑ j : I, ∑ x : Ω,
          μ x * (if E i x ∧ E j x then (1 : ℚ) else 0) := by
            apply Finset.sum_congr rfl
            intro i hi
            rw [Finset.sum_comm]

#print axioms finite_weighted_event_pair_intersection_sum

/--
First-moment counterpart to the weighted second-moment identity.
It reorders the expected event count into a sum of individual event masses.
No positivity or normalization is assumed for μ; those conditions are
required only when interpreting the identity probabilistically.
-/
theorem finite_weighted_event_count_first_moment
    {Ω I : Type*} [Fintype Ω] [Fintype I]
    (μ : Ω → ℚ) (E : I → Ω → Prop) :
    (∑ x : Ω, μ x * (∑ i : I, if E i x then (1 : ℚ) else 0))
      =
    ∑ i : I, ∑ x : Ω, μ x * (if E i x then (1 : ℚ) else 0) := by
  classical
  calc
    (∑ x : Ω, μ x * (∑ i : I, if E i x then (1 : ℚ) else 0))
        = ∑ x : Ω, ∑ i : I,
            μ x * (if E i x then (1 : ℚ) else 0) := by
              simp_rw [Finset.mul_sum]
    _ = ∑ i : I, ∑ x : Ω,
          μ x * (if E i x then (1 : ℚ) else 0) := by
            rw [Finset.sum_comm]

#print axioms finite_weighted_event_count_first_moment


namespace BBMSTAudit

/-- Finite event mass for arbitrary rational weights. Probability semantics require separate normalization. -/
noncomputable def finiteEventMass {Ω : Type*} [Fintype Ω]
    (μ : Ω → ℚ) (E : Ω → Prop) : ℚ := by
  classical
  exact ∑ x : Ω, μ x * (if E x then (1 : ℚ) else 0)

/-- Nonnegative point weights induce nonnegative finite event masses. -/
theorem finiteEventMass_nonneg
    {Ω : Type*} [Fintype Ω]
    (μ : Ω → ℚ) (E : Ω → Prop)
    (hμ : ∀ x, 0 ≤ μ x) :
    0 ≤ finiteEventMass μ E := by
  classical
  unfold finiteEventMass
  apply Finset.sum_nonneg
  intro x hx
  by_cases hE : E x
  · simp [hE]
    exact hμ x
  · simp [hE]

#print axioms finiteEventMass_nonneg

end BBMSTAudit


namespace BBMSTAudit

/-- A nonnegative event mass cannot exceed the total mass of the space.
This deterministic domination lemma is the finite-measure bridge needed
before imposing the probability normalization `∑ x, μ x = 1`.
-/
theorem finiteEventMass_le_totalMass
    {Ω : Type*} [Fintype Ω]
    (μ : Ω → ℚ) (E : Ω → Prop)
    (hμ : ∀ x, 0 ≤ μ x) :
    finiteEventMass μ E ≤ ∑ x : Ω, μ x := by
  classical
  unfold finiteEventMass
  apply Finset.sum_le_sum
  intro x hx
  by_cases hE : E x
  · simp [hE]
  · simp [hE]
    exact hμ x

#print axioms finiteEventMass_le_totalMass


/--
Complement partition identity for finite event masses. Every point belongs
to exactly one of an event and its complement, so their masses add to the
total mass. This is an algebraic identity for arbitrary rational weights;
nonnegativity and normalization are separate assumptions.
-/
theorem finiteEventMass_compl_add_totalMass
    {Ω : Type*} [Fintype Ω]
    (μ : Ω → ℚ) (E : Ω → Prop) :
    finiteEventMass μ E + finiteEventMass μ (fun x => ¬ E x)
      = ∑ x : Ω, μ x := by
  classical
  unfold finiteEventMass
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro x hx
  by_cases hE : E x <;> simp [hE]

#print axioms finiteEventMass_compl_add_totalMass


/--
Under a normalized nonnegative finite mass, every event has probability in
[0,1]. This packages positivity, domination by total mass, and normalization
without assuming independence or any BBMST-specific geometry.
-/
theorem finiteEventMass_mem_unit_interval
    {Ω : Type*} [Fintype Ω]
    (μ : Ω → ℚ) (E : Ω → Prop)
    (hμ : ∀ x, 0 ≤ μ x)
    (hnorm : (∑ x : Ω, μ x) = 1) :
    0 ≤ finiteEventMass μ E ∧ finiteEventMass μ E ≤ 1 := by
  constructor
  · exact finiteEventMass_nonneg μ E hμ
  · calc
      finiteEventMass μ E ≤ ∑ x : Ω, μ x :=
        finiteEventMass_le_totalMass μ E hμ
      _ = 1 := hnorm

#print axioms finiteEventMass_mem_unit_interval



/--
Normalized complement law: for any rational point weights whose total sum
is one, an event and its complement have masses summing to one. Nonnegativity
is not needed for this algebraic identity; it is required separately for
probability bounds. This is the partition interface needed before
source-specific conditioning.
-/
theorem finiteEventMass_compl_add_one
    {Ω : Type*} [Fintype Ω]
    (μ : Ω → ℚ) (E : Ω → Prop)
    (hnorm : (∑ x : Ω, μ x) = 1) :
    finiteEventMass μ E + finiteEventMass μ (fun x => ¬ E x) = 1 := by
  rw [finiteEventMass_compl_add_totalMass]
  exact hnorm

#print axioms finiteEventMass_compl_add_one


/--
Expected event count written as a sum of the individual finite event masses.
This is the first-moment interface between indicator algebra and the finite
measure layer; probability normalization is still a separate hypothesis.
-/
theorem finiteEventMass_sum_event_count
    {Ω I : Type*} [Fintype Ω] [Fintype I]
    (μ : Ω → ℚ) (E : I → Ω → Prop) :
    (∑ x : Ω, μ x * (∑ i : I, if E i x then (1 : ℚ) else 0))
      = ∑ i : I, finiteEventMass μ (E i) := by
  rw [finite_weighted_event_count_first_moment]
  simp [finiteEventMass]

#print axioms finiteEventMass_sum_event_count

/--
Second moment of the event count as the sum of the finite masses of all
ordered pairwise intersections. This is the precise interface needed before
the BBMST geometric intersection estimates can be applied to the measure.
No independence or normalization is built into the identity.
-/
theorem finiteEventMass_pair_intersection_sum
    {Ω I : Type*} [Fintype Ω] [Fintype I]
    (μ : Ω → ℚ) (E : I → Ω → Prop) :
    (∑ x : Ω, μ x * (∑ i : I, if E i x then (1 : ℚ) else 0) ^ 2)
      = ∑ i : I, ∑ j : I,
          finiteEventMass μ (fun x => E i x ∧ E j x) := by
  rw [finite_weighted_event_pair_intersection_sum]
  simp [finiteEventMass]

#print axioms finiteEventMass_pair_intersection_sum

end BBMSTAudit
