import Mathlib

/-- The 2-adic exponent used by the accelerated Syracuse map. -/
def syracuseExponent (x : ℕ) : ℕ :=
  padicValNat 2 (3 * x + 1)

/-- Accelerated Syracuse step: remove all factors of two from 3*x+1. -/
def syracuseStep (x : ℕ) : ℕ :=
  (3 * x + 1) / 2 ^ syracuseExponent x

/-- Exact scaling identity for one accelerated Syracuse step. -/
theorem syracuseStep_scaled (x : ℕ) :
    2 ^ syracuseExponent x * syracuseStep x = 3 * x + 1 := by
  unfold syracuseStep syracuseExponent
  exact Nat.mul_div_cancel' (pow_padicValNat_dvd (p := 2) (n := 3 * x + 1))
