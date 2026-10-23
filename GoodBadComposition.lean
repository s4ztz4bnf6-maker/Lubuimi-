import BBMSTGeometryTest

/-!
# Composition law for additive-error event-mass transfer

This file proves the exact error recurrence for composing two transfer
estimates. The additive errors are not simply added: the second error is
multiplied by the first stage's distortion constant.
-/

open scoped BigOperators

/-- Compose two event-mass bounds with multiplicative distortion and
additive exceptional mass. If
mu(E) <= C * nu(E) + eta and nu(E) <= D * rho(E) + theta, then
mu(E) <= (C * D) * rho(E) + C * theta + eta.
The hypotheses C,D >= 0 are explicit because multiplying inequalities
by a negative constant would reverse their direction. -/
theorem eventMass_compose_additive_error
    {n : ℕ} {space : CoordinateSpace n}
    (μ ν ρ : ProductDistribution space)
    (E : CoordinatePoint space → Prop)
    (C D η θ : ℚ)
    (hC : 0 ≤ C) (hD : 0 ≤ D)
    (hfirst : eventMass μ E ≤ C * eventMass ν E + η)
    (hsecond : eventMass ν E ≤ D * eventMass ρ E + θ) :
    eventMass μ E ≤ (C * D) * eventMass ρ E + C * θ + η := by
  calc
    eventMass μ E ≤ C * eventMass ν E + η := hfirst
    _ ≤ C * (D * eventMass ρ E + θ) + η :=
      add_le_add_right (mul_le_mul_of_nonneg_left hsecond hC) η
    _ = (C * D) * eventMass ρ E + C * θ + η := by ring

#print axioms eventMass_compose_additive_error
