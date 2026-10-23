import Mathlib

/-!
# Source-faithful statement of the BBMST local-lemma budget

This file formalizes the exponentially tilted coordinate-budget hypothesis
associated with Lemma 3.5 in Balister et al., "The Erdős–Selfridge problem
with square-free moduli" (Algebra & Number Theory 15 (2021), 609–626).

It derives a finite incidence bound from that hypothesis. It intentionally
does not claim the lemma's no-cover conclusion: the probabilistic local-lemma
bridge and the arithmetic identification of the hyperplane family remain
separate obligations.
-/

open scoped BigOperators

namespace BBMSTSourceLocalLemma

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

/-- The exact exponential tilt in the source's coordinate budget. -/
def tiltedMass {m n : ℕ} (D : BudgetData m n) (H : Fin m) : ℝ :=
  Real.exp (D.eta * ((D.fixed H).card : ℝ)) * D.mass H

theorem tiltedMass_nonneg {m n : ℕ} (D : BudgetData m n) (H : Fin m) :
    0 ≤ tiltedMass D H := by
  unfold tiltedMass
  exact mul_nonneg (le_of_lt (Real.exp_pos _)) (D.mass_nonneg H)

/-- Two events are adjacent when they are distinct and share a constrained
coordinate. -/
def Depends {m n : ℕ} (D : BudgetData m n) (H K : Fin m) : Prop :=
  H ≠ K ∧ ∃ i : Fin n, i ∈ D.fixed H ∧ i ∈ D.fixed K

noncomputable def neighbors {m n : ℕ} (D : BudgetData m n) (H : Fin m) :
    Finset (Fin m) := by
  classical
  exact Finset.univ.filter (fun K => Depends D H K)

theorem mem_neighbors_iff {m n : ℕ} (D : BudgetData m n)
    (H K : Fin m) : K ∈ neighbors D H ↔ Depends D H K := by
  classical
  simp [neighbors]

theorem neighbor_has_shared_coordinate {m n : ℕ}
    (D : BudgetData m n) (H K : Fin m) (hK : K ∈ neighbors D H) :
    ∃ i : Fin n, i ∈ D.fixed H ∧ i ∈ D.fixed K := by
  have hdep := (mem_neighbors_iff D H K).mp hK
  exact hdep.2

/-- The source-weighted load at coordinate i. -/
def coordinateLoad {m n : ℕ} (D : BudgetData m n) (i : Fin n) : ℝ :=
  ∑ H : Fin m, if i ∈ D.fixed H then tiltedMass D H else 0

theorem coordinateLoad_nonneg {m n : ℕ} (D : BudgetData m n) (i : Fin n) :
    0 ≤ coordinateLoad D i := by
  unfold coordinateLoad
  apply Finset.sum_nonneg
  intro H hH
  by_cases hmem : i ∈ D.fixed H
  · simp [hmem]
    exact tiltedMass_nonneg D H
  · simp [hmem]

theorem source_budget_at_coordinate {m n : ℕ}
    (D : BudgetData m n) (i : Fin n) :
    coordinateLoad D i < D.eta / 2 := by
  simpa [coordinateLoad, tiltedMass] using D.source_coordinate_budget i

/-- Sum of tilted masses in the finite dependency neighborhood. -/
noncomputable def neighborLoad {m n : ℕ}
    (D : BudgetData m n) (H : Fin m) : ℝ :=
  ∑ K ∈ neighbors D H, tiltedMass D K

/-- Exact finite-incidence bound: each neighbor's tilted mass is counted at
least once among the coordinates fixed by H. Multiple shared coordinates
only increase the support-coordinate sum. -/
theorem neighborLoad_le_support_coordinate_load
    {m n : ℕ} (D : BudgetData m n) (H : Fin m) :
    neighborLoad D H ≤ ∑ i ∈ D.fixed H, coordinateLoad D i := by
  classical
  unfold neighborLoad
  calc
    (∑ K ∈ neighbors D H, tiltedMass D K) ≤
        ∑ K ∈ neighbors D H,
          ∑ i ∈ D.fixed H,
            (if i ∈ D.fixed K then tiltedMass D K else 0) := by
      apply Finset.sum_le_sum
      intro K hK
      obtain ⟨i, hiH, hiK⟩ := neighbor_has_shared_coordinate D H K hK
      calc
        tiltedMass D K =
            (if i ∈ D.fixed K then tiltedMass D K else 0) := by simp [hiK]
        _ ≤ ∑ i' ∈ D.fixed H,
              (if i' ∈ D.fixed K then tiltedMass D K else 0) := by
          apply Finset.single_le_sum
          · intro i' hi'
            by_cases hmem : i' ∈ D.fixed K
            · simp [hmem]
              exact tiltedMass_nonneg D K
            · simp [hmem]
          · exact hiH
    _ ≤ ∑ K : Fin m,
          ∑ i ∈ D.fixed H,
            (if i ∈ D.fixed K then tiltedMass D K else 0) := by
      apply Finset.sum_le_sum_of_subset_of_nonneg
      · exact Finset.subset_univ _
      · intro K hKmem hKnot
        apply Finset.sum_nonneg
        intro i hi
        by_cases hmem : i ∈ D.fixed K
        · simp [hmem]
          exact tiltedMass_nonneg D K
        · simp [hmem]
    _ = ∑ i ∈ D.fixed H, coordinateLoad D i := by
      rw [Finset.sum_comm]
      apply Finset.sum_congr rfl
      intro i hi
      rfl

/-- The source's coordinate budget implies a support-size bound on the
weighted dependency neighborhood. This is a combinatorial consequence of
the premise, not yet the local-lemma no-cover conclusion. -/
theorem neighborLoad_le_support_budget
    {m n : ℕ} (D : BudgetData m n) (H : Fin m) :
    neighborLoad D H ≤ (D.fixed H).card * (D.eta / 2) := by
  apply le_trans (neighborLoad_le_support_coordinate_load D H)
  calc
    (∑ i ∈ D.fixed H, coordinateLoad D i) ≤
        ∑ i ∈ D.fixed H, (D.eta / 2) := by
      apply Finset.sum_le_sum
      intro i hi
      exact le_of_lt (source_budget_at_coordinate D i)
    _ = (D.fixed H).card * (D.eta / 2) := by
      simp [Finset.sum_const, nsmul_eq_mul]

theorem source_eta_range {m n : ℕ} (D : BudgetData m n) :
    0 < D.eta ∧ D.eta < (1 : ℝ) / 5 :=
  ⟨D.eta_pos, D.eta_lt_one_fifth⟩

#print axioms tiltedMass_nonneg
#print axioms source_budget_at_coordinate
#print axioms neighborLoad_le_support_coordinate_load
#print axioms neighborLoad_le_support_budget
#print axioms source_eta_range

end BBMSTSourceLocalLemma
