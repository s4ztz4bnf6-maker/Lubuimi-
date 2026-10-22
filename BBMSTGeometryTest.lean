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


/-- If two coordinate cylinders contain the same point, their prescribed
values agree on every coordinate fixed by both cylinders. This is the basic
compatibility condition for a nonempty intersection in this finite model. -/
theorem agree_on_overlap_of_common_point
    {n : ℕ} {space : CoordinateSpace n}
    (H₁ H₂ : CoordinateHypersurface space)
    (x : CoordinatePoint space)
    (h₁ : H₁.Contains x) (h₂ : H₂.Contains x)
    (i : Fin n) (hi₁ : i ∈ H₁.fixed) (hi₂ : i ∈ H₂.fixed) :
    H₁.value i hi₁ = H₂.value i hi₂ := by
  calc
    H₁.value i hi₁ = x i := (h₁ i hi₁).symm
    _ = H₂.value i hi₂ := h₂ i hi₂

/-- A disagreement on a shared fixed coordinate rules out an intersection.
This is a concrete finite-coordinate incidence lemma, not the BBMST
codimension-one theorem. -/
theorem disjoint_of_disagreeing_overlap
    {n : ℕ} {space : CoordinateSpace n}
    (H₁ H₂ : CoordinateHypersurface space)
    (i : Fin n) (hi₁ : i ∈ H₁.fixed) (hi₂ : i ∈ H₂.fixed)
    (hdis : H₁.value i hi₁ ≠ H₂.value i hi₂) :
    ¬ ∃ x : CoordinatePoint space, H₁.Contains x ∧ H₂.Contains x := by
  rintro ⟨x, hx₁, hx₂⟩
  exact hdis (agree_on_overlap_of_common_point H₁ H₂ x hx₁ hx₂ i hi₁ hi₂)

#print axioms agree_on_overlap_of_common_point
#print axioms disjoint_of_disagreeing_overlap

#print axioms CoordinateHypersurface.contains_iff
#print axioms ProductDistribution.total_mass
#print axioms ProductDistribution.weight_nonneg


/-- Two cylinders intersect exactly when all prescriptions on their shared
fixed coordinates agree. The reverse direction uses nonemptiness of each
coordinate domain to fill all unconstrained coordinates. This is an exact
intersection criterion for this finite-coordinate model, not yet a theorem
about BBMST hyperplanes. -/
theorem intersects_iff_agree_on_overlap
    {n : ℕ} {space : CoordinateSpace n}
    (H₁ H₂ : CoordinateHypersurface space) :
    (∃ x : CoordinatePoint space, H₁.Contains x ∧ H₂.Contains x) ↔
      ∀ i (hi₁ : i ∈ H₁.fixed) (hi₂ : i ∈ H₂.fixed),
        H₁.value i hi₁ = H₂.value i hi₂ := by
  constructor
  · rintro ⟨x, hx₁, hx₂⟩ i hi₁ hi₂
    exact agree_on_overlap_of_common_point H₁ H₂ x hx₁ hx₂ i hi₁ hi₂
  · intro hcompat
    classical
    let x : CoordinatePoint space := fun i =>
      if hi₁ : i ∈ H₁.fixed then H₁.value i hi₁
      else if hi₂ : i ∈ H₂.fixed then H₂.value i hi₂
      else Classical.choice (space.h_nonempty i)
    refine ⟨x, ?_, ?_⟩
    · intro i hi₁
      simp [x, hi₁]
    · intro i hi₂
      by_cases hi₁ : i ∈ H₁.fixed
      · have heq := hcompat i hi₁ hi₂
        simp [x, hi₁, heq]
      · simp [x, hi₁, hi₂]

#print axioms intersects_iff_agree_on_overlap
