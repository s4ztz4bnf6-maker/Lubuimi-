import MeasureTransition
import Mathlib.Tactic

/-!
# Validated finite sieve parameters

This module strengthens the parameter interface by requiring a positive
number of stages and strict positivity of every delta used in a second-moment
denominator. It is an interface invariant, not the source-specific construction
of suitable parameters and not a proof of the Erdős–Selfridge theorem.
-/

namespace MeasureTransition

/-- A finite, nonempty family of sieve parameters with the range conditions
needed by the algebraic denominator guards. -/
structure ValidSieveParameters (N : ℕ) extends SieveParameters N where
  stages_nonempty : 0 < N
  delta_pos : ∀ i, 0 < delta i

/-- Every second-moment denominator is strictly positive for validated data. -/
theorem valid_second_moment_denominator_pos
    {N : ℕ} (p : ValidSieveParameters N) (i : Fin N) :
    0 < 4 * p.delta i * (1 - p.delta i) := by
  exact denominator_pos_second_moment (p.delta i)
    (p.delta_pos i) (p.delta_le_half i)

/-- Valid parameter data cannot have zero stages. -/
theorem valid_parameter_stage_count_pos
    {N : ℕ} (p : ValidSieveParameters N) : 0 < N :=
  p.stages_nonempty

#print axioms valid_second_moment_denominator_pos
#print axioms valid_parameter_stage_count_pos

/-- A complete indexed sieve instance: block sizes and delta parameters share
the same Fin N index, eliminating independent list lengths and partial lookups. -/
structure ValidSieveInstance (N : ℕ) extends ValidSieveParameters N where
  blockSize : Fin N → ℚ
  blockSize_pos : ∀ i, 0 < blockSize i

/-- Every stage in a validated instance has both a positive block size and
a positive second-moment denominator. -/
theorem valid_instance_stage_guards
    {N : ℕ} (p : ValidSieveInstance N) (i : Fin N) :
    0 < p.blockSize i ∧ 0 < 4 * p.delta i * (1 - p.delta i) := by
  exact ⟨p.blockSize_pos i, valid_second_moment_denominator_pos p.toValidSieveParameters i⟩

#print axioms valid_instance_stage_guards

/-- Quantitative denominator guard: for 0 < δ ≤ 1/2, the second-moment
denominator is at least 2δ, not merely positive. -/
theorem valid_second_moment_denominator_lower_bound
    {N : ℕ} (p : ValidSieveParameters N) (i : Fin N) :
    2 * p.delta i ≤ 4 * p.delta i * (1 - p.delta i) := by
  have hδ := p.delta_pos i
  have hu := p.delta_le_half i
  nlinarith

#print axioms valid_second_moment_denominator_lower_bound

/-- Reciprocal denominator control: once the second-moment denominator is
guarded away from zero, its inverse is bounded above by 1/(2δ). This is a
quantitative stability estimate for later moment bounds, not the source
second-moment inequality itself. -/
theorem valid_second_moment_reciprocal_upper_bound
    {N : ℕ} (p : ValidSieveParameters N) (i : Fin N) :
    1 / (4 * p.delta i * (1 - p.delta i)) ≤ 1 / (2 * p.delta i) := by
  have hden := valid_second_moment_denominator_pos p i
  have htwo : 0 < 2 * p.delta i := by positivity
  have hlow := valid_second_moment_denominator_lower_bound p i
  apply (div_le_div_iff₀ hden htwo).2
  simpa using hlow

#print axioms valid_second_moment_reciprocal_upper_bound

end MeasureTransition
