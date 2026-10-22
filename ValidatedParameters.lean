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

end MeasureTransition
