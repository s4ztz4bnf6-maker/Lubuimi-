import Mathlib

/-!
# Source-faithful statement of the BBMST local-lemma budget

This file formalizes the hypothesis of Lemma 3.5 in Balister et al.,
"The Erdős–Selfridge problem with square-free moduli" (Algebra & Number
Theory 15 (2021), 609–626), in a finite-coordinate interface.

It intentionally does not claim the lemma's no-cover conclusion: the
probabilistic local-lemma bridge and the identification of the arithmetic
hyperplane family remain separate obligations.
-/

open scoped BigOperators

namespace BBMSTSourceLocalLemma

/-- Finite-coordinate data appearing in the source's local-lemma premise.
The mass field is intended to be the uniform measure of the corresponding
nontrivial coordinate hyperplane; its provenance must be proved by the
application, not inferred from this record. -/
structure BudgetData (m n : ℕ) where
  fixed : Fin m → Finset (Fin n)
  mass : Fin m → ℝ
  mass_nonneg : ∀ H, 0 ≤ mass H
  domainSize : Fin n → ℕ
  domains_have_two_points : ∀ i, 2 ≤ domainSize i
  nontrivial : ∀ H, (fixed H).Nonempty
  eta : ℝ
  eta_pos : 0 < eta
  eta_lt_one_fifth : eta < (1 : ℝ) / 5
  source_coordinate_budget : ∀ i : Fin n,
    (∑ H : Fin m,
      if i ∈ fixed H then
        Real.exp (eta * ((fixed H).card : ℝ)) * mass H
      else 0) < eta / 2

/-- The numerical range in the source lemma is explicit, not an
unconstrained scalar passed to a generic tilt interface. -/
theorem source_eta_range {m n : ℕ} (D : BudgetData m n) :
    0 < D.eta ∧ D.eta < (1 : ℝ) / 5 :=
  ⟨D.eta_pos, D.eta_lt_one_fifth⟩

/-- Direct projection of the exact exponentially tilted source budget.
This packages the hypothesis only; it does not prove it for an arithmetic
covering system. -/
theorem source_budget_at_coordinate {m n : ℕ}
    (D : BudgetData m n) (i : Fin n) :
    (∑ H : Fin m,
      if i ∈ D.fixed H then
        Real.exp (D.eta * ((D.fixed H).card : ℝ)) * D.mass H
      else 0) < D.eta / 2 :=
  D.source_coordinate_budget i

#print axioms source_eta_range
#print axioms source_budget_at_coordinate

end BBMSTSourceLocalLemma
