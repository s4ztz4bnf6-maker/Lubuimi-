import BBMSTMassAuditCore

namespace BBMSTAudit

/-- For nonnegative rational weights, a finite carrier has zero mass exactly when every point has zero weight. -/
theorem mass_eq_zero_iff_forall_point_weights_eq_zero
    {α : Type*} [DecidableEq α]
    (s : Finset α) (w : α → ℚ)
    (hw : ∀ x ∈ s, 0 ≤ w x) :
    (∑ x ∈ s, w x) = 0 ↔ ∀ x ∈ s, w x = 0 := by
  constructor
  · intro hsum
    exact point_weight_eq_zero_of_mass_eq_zero s w hw hsum
  · intro hzero
    apply Finset.sum_eq_zero
    intro x hx
    exact hzero x hx

#print axioms mass_eq_zero_iff_forall_point_weights_eq_zero

end BBMSTAudit
