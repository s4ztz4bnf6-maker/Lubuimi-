import ValidatedParameters
import Mathlib.Tactic

namespace MeasureTransition

/-- Regression test: the validated interface cannot describe an empty sieve. -/
theorem no_valid_parameters_at_zero_stages :
    IsEmpty (ValidSieveParameters 0) := by
  refine ⟨fun p => ?_⟩
  exact Nat.not_lt_zero _ p.stages_nonempty

/-- Regression test: a validated stage cannot have a zero delta parameter. -/
theorem no_zero_delta_in_valid_instance
    {N : ℕ} (p : ValidSieveInstance N) (i : Fin N) :
    p.delta i ≠ 0 := by
  exact ne_of_gt (p.delta_pos i)

/-- Regression test: every validated stage has a positive block size. -/
theorem no_zero_block_size_in_valid_instance
    {N : ℕ} (p : ValidSieveInstance N) (i : Fin N) :
    p.blockSize i ≠ 0 := by
  exact ne_of_gt (p.blockSize_pos i)

#print axioms no_valid_parameters_at_zero_stages
#print axioms no_zero_delta_in_valid_instance
#print axioms no_zero_block_size_in_valid_instance

end MeasureTransition
