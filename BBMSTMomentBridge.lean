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

/-- A weighted overlap of two point indicators. -/
theorem sum_weighted_pair_indicator (a b : Y) (u v : ℚ) :
    (∑ y : Y,
      (if a = y then u else 0) *
      (if b = y then v else 0))
      = (if a = b then u * v else 0) := by
  classical
  by_cases h : a = b
  · subst b
    simp
  · simp [h]

#print axioms sum_weighted_pair_indicator

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
          rw [pow_two, Finset.sum_mul]
          simp_rw [Finset.mul_sum]
    _ = ∑ x : X, ∑ y : Y, ∑ x' : X,
          (if f x = y then w x else 0) *
            (if f x' = y then w x' else 0) := by
          rw [Finset.sum_comm]
    _ = ∑ x : X, ∑ x' : X, ∑ y : Y,
          (if f x = y then w x else 0) *
            (if f x' = y then w x' else 0) := by
          congr 1
          funext x
          rw [Finset.sum_comm]
    _ = ∑ x : X, ∑ x' : X,
          (if f x = f x' then w x * w x' else 0) := by
          congr 1
          funext x
          congr 1
          funext x'
          exact sum_weighted_pair_indicator (f x) (f x') (w x) (w x')

#print axioms fiber_second_moment

/-- A geometric incidence relation represents equality of fibers exactly.
This is an interface only: the caller must prove the equivalence from the
actual geometric definitions; no geometric estimate is assumed here. -/
theorem fiber_second_moment_incidence
    {X : Type*} [Fintype X] [DecidableEq X]
    (f : X → Y) (w : X → ℚ)
    (incident : X → X → Prop) [DecidableRel incident]
    (h_incident : ∀ x x' : X, incident x x' ↔ f x = f x') :
    (∑ y : Y, (∑ x : X, if f x = y then w x else 0) ^ 2)
      = ∑ x : X, ∑ x' : X,
          (if incident x x' then w x * w x' else 0) := by
  classical
  rw [fiber_second_moment]
  apply Finset.sum_congr rfl
  intro x hx
  apply Finset.sum_congr rfl
  intro x' hx'
  simp [h_incident x x']

#print axioms fiber_second_moment_incidence

end BBMSTMomentBridge
