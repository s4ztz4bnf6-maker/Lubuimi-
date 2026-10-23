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

/-- The dependency edge has an explicit coordinate witness: two distinct
events are adjacent exactly when some coordinate is fixed by both. -/
theorem depends_iff_common_coordinate {m n : ℕ}
    (S : FiniteSystem m n) (H K : Fin m) :
    Depends S H K ↔ H ≠ K ∧
      ∃ i : Fin n, i ∈ S.fixed H ∧ i ∈ S.fixed K := by
  constructor
  · rintro ⟨hne, ⟨i, hi⟩⟩
    exact ⟨hne, i, hi.1, hi.2⟩
  · rintro ⟨hne, i, hiH, hiK⟩
    exact ⟨hne, ⟨i, ⟨hiH, hiK⟩⟩⟩

theorem depends_symmetric {m n : ℕ} (S : FiniteSystem m n)
    (H K : Fin m) : Depends S H K ↔ Depends S K H := by
  constructor
  · rintro ⟨hne, ⟨i, hi⟩⟩
    refine ⟨Ne.symm hne, ⟨i, ?_⟩⟩
    exact ⟨hi.2, hi.1⟩
  · rintro ⟨hne, ⟨i, hi⟩⟩
    refine ⟨Ne.symm hne, ⟨i, ?_⟩⟩
    exact ⟨hi.2, hi.1⟩

 /-- The finite neighborhood of an event in the coordinate-overlap graph. -/
def neighbors {m n : ℕ} (S : FiniteSystem m n) (H : Fin m) : Finset (Fin m) :=
  Finset.univ.filter (fun K => Depends S H K)

theorem mem_neighbors_iff {m n : ℕ} (S : FiniteSystem m n)
    (H K : Fin m) : K ∈ neighbors S H ↔ Depends S H K := by
  simp [neighbors]

/-- Adjacency is symmetric, so the coordinate-overlap relation really
defines an undirected finite graph on the event indices. -/
theorem neighbor_symm {m n : ℕ} (S : FiniteSystem m n)
    (H K : Fin m) (hK : K ∈ neighbors S H) : H ∈ neighbors S K := by
  apply mem_neighbors_iff.mpr
  exact (depends_symmetric S H K).mp (mem_neighbors_iff.mp hK)

/-- No event is its own neighbor: the graph relation excludes equal indices. -/
theorem self_not_neighbor {m n : ℕ} (S : FiniteSystem m n)
    (H : Fin m) : H ∉ neighbors S H := by
  rw [mem_neighbors_iff]
  exact fun h => h.1 rfl


/-- Every graph neighbor carries a concrete shared-coordinate witness.
This is the pointwise incidence fact needed before a double-counting
argument can compare neighbor load with support-coordinate load. -/
theorem neighbor_has_shared_coordinate {m n : ℕ}
    (S : FiniteSystem m n) (H K : Fin m)
    (hK : K ∈ neighbors S H) :
    ∃ i : Fin n, i ∈ S.fixed H ∧ i ∈ S.fixed K := by
  have hdep : Depends S H K := mem_neighbors_iff S H K |>.mp hK
  rcases (depends_iff_common_coordinate S H K).mp hdep with
    ⟨_, i, hiH, hiK⟩
  exact ⟨i, hiH, hiK⟩

#print axioms neighbor_has_shared_coordinate

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

/-- Weighted neighborhood load for an event H. This is the natural
graph-side quantity for a local-lemma argument. It is deliberately kept
separate from the coordinatewise budget: a neighbor may overlap H in more
than one coordinate, so a coordinate budget cannot be converted into this
sum without an additional source-specific counting argument. -/
def weightedNeighborLoad {m n : ℕ}
    (S : FiniteSystem m n) (B : TiltedBudget S) (H : Fin m) : ℚ :=
  ∑ K ∈ neighbors S H, B.tilt K * S.weight K

theorem weightedNeighborLoad_nonneg {m n : ℕ}
    (S : FiniteSystem m n) (B : TiltedBudget S) (H : Fin m) :
    0 ≤ weightedNeighborLoad S B H := by
  unfold weightedNeighborLoad
  apply Finset.sum_nonneg
  intro K hK
  exact mul_nonneg (B.tilt_nonneg K) (S.weight_nonneg K)


/-- Tilted mass incident to one coordinate. -/
def coordinateTiltedLoad {m n : ℕ}
    (S : FiniteSystem m n) (B : TiltedBudget S) (i : Fin n) : ℚ :=
  ∑ K : Fin m, if i ∈ S.fixed K then B.tilt K * S.weight K else 0

/-- If a separate combinatorial counting argument shows that the
neighbor load is dominated by the sum of coordinate loads on H's support,
then the coordinatewise BBMST budget gives an explicit support-size bound.
The domination premise is intentionally explicit: it is the bridge that
must be proved for the concrete source construction, not silently assumed. -/
theorem weightedNeighborLoad_le_support_budget
    {m n : ℕ} (S : FiniteSystem m n) (B : TiltedBudget S) (H : Fin m)
    (hcover : weightedNeighborLoad S B H ≤
      ∑ i ∈ S.fixed H, coordinateTiltedLoad S B i) :
    weightedNeighborLoad S B H ≤
      (S.fixed H).card * (B.eta / 2) := by
  apply le_trans hcover
  calc
    (∑ i ∈ S.fixed H, coordinateTiltedLoad S B i) ≤
        ∑ i ∈ S.fixed H, (B.eta / 2) := by
      apply Finset.sum_le_sum
      intro i hi
      have hbudget := B.coordinate_budget i
      unfold coordinateTiltedLoad
      exact le_of_lt hbudget
    _ = (S.fixed H).card * (B.eta / 2) := by
      simp [Finset.sum_const, nsmul_eq_mul]

#print axioms weightedNeighborLoad_le_support_budget

#print axioms weightedNeighborLoad_nonneg

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
