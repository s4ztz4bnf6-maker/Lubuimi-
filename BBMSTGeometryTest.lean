import Mathlib

/-!
# BBMST coordinate geometry sandbox

This file is independent of the audited Erdős–Selfridge development.
It is a finite-coordinate model, not yet a formalization of BBMST
Theorems 3.1 or 3.2.
-/

open scoped BigOperators

/-- Each coordinate has a finite, nonempty set of rational values. -/
structure CoordinateSpace (n : ℕ) where
  S : Fin n → Finset ℚ
  h_nonempty : ∀ i, (S i).Nonempty

/-- The allowed values at coordinate i, represented as a subtype. -/
abbrev CoordinateValue {n : ℕ} (space : CoordinateSpace n) (i : Fin n) :=
  {q : ℚ // q ∈ space.S i}

/-- A point in the finite product of the coordinate domains. -/
abbrev CoordinatePoint {n : ℕ} (space : CoordinateSpace n) :=
  ∀ i : Fin n, CoordinateValue space i

/-- A coordinate cylinder fixes a finite set of coordinates to allowed values. -/
structure CoordinateHypersurface {n : ℕ} (space : CoordinateSpace n) where
  fixed : Finset (Fin n)
  value : ∀ i : Fin n, i ∈ fixed → CoordinateValue space i

namespace CoordinateHypersurface

/-- A point belongs to the cylinder when it agrees on every fixed coordinate. -/
def Contains {n : ℕ} {space : CoordinateSpace n}
    (H : CoordinateHypersurface space) (x : CoordinatePoint space) : Prop :=
  ∀ i (hi : i ∈ H.fixed), x i = H.value i hi

/-- Preliminary combinatorial convention: cylinders are non-parallel when
their sets of fixed coordinates differ. This is not asserted to be the full
geometric definition used in BBMST. -/
def NotParallel {n : ℕ} {space : CoordinateSpace n}
    (H₁ H₂ : CoordinateHypersurface space) : Prop :=
  H₁.fixed ≠ H₂.fixed

theorem contains_iff {n : ℕ} {space : CoordinateSpace n}
    (H : CoordinateHypersurface space) (x : CoordinatePoint space) :
    H.Contains x ↔ ∀ i (hi : i ∈ H.fixed), x i = H.value i hi := Iff.rfl

end CoordinateHypersurface

/-- A rational probability weight on the finite product space. -/
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
