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
The hypothesis C >= 0 is required to multiply the second inequality
without reversing its direction; no sign condition on D is needed. -/
theorem eventMass_compose_additive_error
    {n : ℕ} {space : CoordinateSpace n}
    (μ ν ρ : ProductDistribution space)
    (E : CoordinatePoint space → Prop)
    (C D η θ : ℚ)
    (hC : 0 ≤ C)
    (hfirst : eventMass μ E ≤ C * eventMass ν E + η)
    (hsecond : eventMass ν E ≤ D * eventMass ρ E + θ) :
    eventMass μ E ≤ (C * D) * eventMass ρ E + C * θ + η := by
  calc
    eventMass μ E ≤ C * eventMass ν E + η := hfirst
    _ ≤ C * (D * eventMass ρ E + θ) + η := by
      simpa [add_comm] using
        (add_le_add_right (mul_le_mul_of_nonneg_left hsecond hC) η)
    _ = (C * D) * eventMass ρ E + C * θ + η := by ring

#print axioms eventMass_compose_additive_error


/-- A stage budget represents the affine estimate
    mass_in <= factor * mass_out + error. -/
structure TransferBudget where
  factor : ℚ
  error : ℚ
deriving DecidableEq, Repr

/-- Sequential composition: first apply the inner transfer, then the outer
transfer. The earlier stage's factor scales the later additive error. -/
def TransferBudget.compose (outer inner : TransferBudget) : TransferBudget :=
  { factor := outer.factor * inner.factor
    error := outer.factor * inner.error + outer.error }

/-- Stage-budget composition is associative. This allows a long proof chain
to be grouped into blocks without changing its exact accumulated error. -/
theorem TransferBudget.compose_assoc
    (A B C : TransferBudget) :
    (A.compose B).compose C = A.compose (B.compose C) := by
  cases A
  cases B
  cases C
  simp [TransferBudget.compose, mul_assoc, mul_add, add_assoc]

#print axioms TransferBudget.compose_assoc
