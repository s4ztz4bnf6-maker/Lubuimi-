import Mathlib

/-!
# BBMST finite dependency interface

This file records the finite combinatorial data needed before invoking a
Lovasz-local-lemma argument. It deliberately does NOT assert a non-covering
theorem: the arithmetic source estimates must still prove the budget
hypothesis, and a theorem connecting that hypothesis to non-covering must
faithfully encode the exact source lemma.
-/

open scoped BigOperators

namespace BBMSTDependencyInterface

/-- Finite family of cylinder/hyperplane events on a finite coordinate set.
fixed H is the set of coordinates constrained by event H. -/
structure FiniteSystem (m n : ℕ) where
  fixed : Fin m → Finset (Fin n)
  weight : Fin m → ℚ
  weight_nonneg : ∀ H, 0 ≤ weight H

/-- Distinct events are dependent when their coordinate supports overlap. -/
def Depends {m n : ℕ} (S : FiniteSystem m n) (H K : Fin m) : Prop :=
  H ≠ K ∧ (S.fixed H ∩ S.fixed K).Nonempty

theorem depends_symmetric {m n : ℕ} (S : FiniteSystem m n)
    (H K : Fin m) : Depends S H K ↔ Depends S K H := by
  constructor
  · rintro ⟨hne, ⟨i, hi⟩⟩
    refine ⟨Ne.symm hne, ⟨i, ?_⟩⟩
    simpa [Finset.mem_inter] using hi.symm
  · rintro ⟨hne, ⟨i, hi⟩⟩
    refine ⟨Ne.symm hne, ⟨i, ?_⟩⟩
    simpa [Finset.mem_inter] using hi.symm

/-- The un-tilted load on coordinate i: total event weight among events
that constrain i. This is a diagnostic quantity, not the BBMST weighted
local-lemma budget by itself. -/
def coordinateLoad {m n : ℕ} (S : FiniteSystem m n) (i : Fin n) : ℚ :=
  ∑ H : Fin m, if i ∈ S.fixed H then S.weight H else 0

theorem coordinateLoad_nonneg {m n : ℕ} (S : FiniteSystem m n)
    (i : Fin n) : 0 ≤ coordinateLoad S i := by
  unfold coordinateLoad
  apply Finset.sum_nonneg
  intro H hH
  split
  · exact S.weight_nonneg H
  · exact le_rfl

/-- A source-specific tilt factor, such as an exponential penalty encoded by
a certified rational upper bound. Keeping the factor as input prevents Lean
from silently assuming the analytic estimate that the arithmetic argument
must establish. -/
structure TiltedBudget {m n : ℕ} (S : FiniteSystem m n) where
  tilt : Fin m → ℚ
  tilt_nonneg : ∀ H, 0 ≤ tilt H
  eta : ℚ
  eta_pos : 0 < eta
  coordinate_budget : ∀ i : Fin n,
    (∑ H : Fin m, if i ∈ S.fixed H then tilt H * S.weight H else 0) < eta / 2

/-- The local budget gives a strict coordinatewise bound. This lemma only
packages the supplied certificate; it does not prove that the certificate
holds for a particular arithmetic covering system. -/
theorem tilted_coordinate_budget {m n : ℕ}
    (S : FiniteSystem m n) (B : TiltedBudget S) (i : Fin n) :
    (∑ H : Fin m, if i ∈ S.fixed H then B.tilt H * S.weight H else 0)
      < B.eta / 2 :=
  B.coordinate_budget i

#print axioms depends_symmetric
#print axioms coordinateLoad_nonneg
#print axioms tilted_coordinate_budget

end BBMSTDependencyInterface
