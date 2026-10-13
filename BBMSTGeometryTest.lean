import Mathlib

/-!
# BBMST coordinate geometry sandbox

This file is deliberately independent of the audited Erdős–Selfridge file and
its project axioms. It is a foundational model, not yet a formalization of
BBMST Theorems 3.1 or 3.2.
-/

open scoped BigOperators

/-- A finite coordinate space: each coordinate has a finite, nonempty domain. -/
structure CoordinateSpace (n : ℕ) where
  S : Fin n → Finset ℚ
  h_nonempty : ∀ i, (S i).Nonempty

/-- A point of the product Q = S₁ × ⋯ × Sₙ. -/
abbrev CoordinatePoint {n : ℕ} (space : CoordinateSpace n) :=
  ∀ i : Fin n, space.S i

/-- A coordinate hyperplane fixes a finite set of coordinates to specified
values belonging to the corresponding coordinate domains. -/
structure CoordinateHypersurface {n : ℕ} (space : CoordinateSpace n) where
  fixed : Finset (Fin n)
  value : ∀ i : Fin n, i ∈ fixed → space.S i

namespace CoordinateHypersurface

/-- The point lies on the coordinate hyperplane exactly when all its fixed
coordinates equal the prescribed values. -/
def Contains {n : ℕ} {space : CoordinateSpace n}
    (H : CoordinateHypersurface space) (x : CoordinatePoint space) : Prop :=
  ∀ i (hi : i ∈ H.fixed), x i = H.value i hi

/-- In this coordinate model, hyperplanes with the same fixed-coordinate
index set are parallel. Thus non-parallelity is inequality of those sets. -/
def NotParallel {n : ℕ} {space : CoordinateSpace n}
    (H₁ H₂ : CoordinateHypersurface space) : Prop :=
  H₁.fixed ≠ H₂.fixed

theorem contains_iff {n : ℕ} {space : CoordinateSpace n}
    (H : CoordinateHypersurface space) (x : CoordinatePoint space) :
    H.Contains x ↔ ∀ i (hi : i ∈ H.fixed), x i = H.value i hi := Iff.rfl

end CoordinateHypersurface

/-- A rational-valued weight on the finite product space, normalized to total
mass one. This is only the probability layer; BBMST's specific measures and
moment definitions still need to be encoded separately. -/
structure ProductDistribution {n : ℕ} (space : CoordinateSpace n) where
  weight : CoordinatePoint space → ℚ
  h_nonneg : ∀ x, 0 ≤ weight x
  h_sum_one : ∑ x : CoordinatePoint space, weight x = 1

namespace ProductDistribution

theorem total_mass {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space) :
    ∑ x : CoordinatePoint space, μ.weight x = 1 :=
  μ.h_sum_one

theorem weight_nonneg {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space) (x : CoordinatePoint space) :
    0 ≤ μ.weight x :=
  μ.h_nonneg x

end ProductDistribution

#print axioms CoordinateHypersurface.contains_iff
#print axioms ProductDistribution.total_mass
#print axioms ProductDistribution.weight_nonneg
