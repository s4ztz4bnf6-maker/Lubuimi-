import BBMSTGeometryTest

/-!
# Exact zero-mass transfer for incompatible coordinate cylinders

This module connects the geometric incidence criterion to the probability
layer. It proves that a shared-coordinate disagreement forces not only an
empty intersection, but exactly zero event mass under every normalized
nonnegative distribution. No independence assumption is needed.
-/

open scoped BigOperators

theorem eventMass_cylinder_inter_zero_of_disagreeing_overlap
    {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (H₁ H₂ : CoordinateHypersurface space)
    (i : Fin n) (hi₁ : i ∈ H₁.fixed) (hi₂ : i ∈ H₂.fixed)
    (hdis : H₁.value i hi₁ ≠ H₂.value i hi₂) :
    eventMass μ (fun x => H₁.Contains x ∧ H₂.Contains x) = 0 := by
  have hfalse :
      ∀ x, (H₁.Contains x ∧ H₂.Contains x) → False := by
    intro x hx
    exact
      (disjoint_of_disagreeing_overlap H₁ H₂ i hi₁ hi₂ hdis)
        ⟨x, hx.1, hx.2⟩
  have hle :
      eventMass μ (fun x => H₁.Contains x ∧ H₂.Contains x) ≤
        eventMass μ (fun _ => False) :=
    eventMass_mono μ _ _ hfalse
  rw [eventMass_empty] at hle
  exact le_antisymm hle (eventMass_nonneg μ _)


/-- The mass of an intersection is bounded by either marginal, without any
independence hypothesis. This is the basic safe estimate for the second-moment
stage when exact factorization has not yet been established. -/
theorem eventMass_intersection_le_marginals
    {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E F : CoordinatePoint space → Prop) :
    eventMass μ (fun x => E x ∧ F x) ≤ eventMass μ E ∧
      eventMass μ (fun x => E x ∧ F x) ≤ eventMass μ F := by
  constructor
  · apply eventMass_mono μ (fun x => E x ∧ F x) E
    intro x hx
    exact hx.1
  · apply eventMass_mono μ (fun x => E x ∧ F x) F
    intro x hx
    exact hx.2

#print axioms eventMass_intersection_le_marginals
#print axioms eventMass_cylinder_inter_zero_of_disagreeing_overlap
