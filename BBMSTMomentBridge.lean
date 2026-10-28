import Mathlib

namespace BBMSTMomentBridge

variable {Y : Type*} [Fintype Y] [DecidableEq Y]

/-- The overlap of two point indicators is the indicator of equality. -/
theorem sum_pair_indicator (a b : Y) :
    (∑ y : Y,
      (if a = y then (1 : ℚ) else 0) *
      (if b = y then (1 : ℚ) else 0))
      = (if a = b then 1 else 0) := by
  classical
  by_cases h : a = b <;> simp [h]

#print axioms sum_pair_indicator

/-- The fiberwise second moment equals the sum over pairs with equal images. -/
theorem fiber_second_moment
    {X : Type*} [Fintype X] [DecidableEq X]
    (f : X → Y) (w : X → ℚ) :
    (∑ y : Y, (∑ x : X, if f x = y then w x else 0) ^ 2)
      = ∑ x : X, ∑ x' : X,
          (if f x = f x' then w x * w x' else 0) := by
  classical
  calc
    (∑ y : Y, (∑ x : X, if f x = y then w x else 0) ^ 2)
        = ∑ y : Y, ∑ x : X, ∑ x' : X,
            (if f x = y then w x else 0) *
              (if f x' = y then w x' else 0) := by
          congr 1
          funext y
          rw [Finset.sum_mul]
          simp only [pow_two]
          rw [Finset.sum_mul]
          simp_rw [Finset.mul_sum]
    _ = ∑ x : X, ∑ x' : X, ∑ y : Y,
          (if f x = y then w x else 0) *
            (if f x' = y then w x' else 0) := by
          simp_rw [Finset.sum_comm]
    _ = ∑ x : X, ∑ x' : X,
          (if f x = f x' then w x * w x' else 0) := by
          congr 1
          funext x
          congr 1
          funext x'
          exact sum_pair_indicator (f x) (f x')

#print axioms fiber_second_moment

end BBMSTMomentBridge
