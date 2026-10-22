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

/-- A nontrivial coordinate hyperplane fixes at least one coordinate. -/
def IsNontrivial {n : ℕ} {space : CoordinateSpace n}
    (H : CoordinateHypersurface space) : Prop :=
  H.fixed.Nonempty

/-- In the finite-product coordinate model used by BBMST, parallel coordinate
hyperplanes have the same set of fixed coordinate indices. Thus distinct
fixed-coordinate sets encode non-parallel hyperplanes. This definition alone
does not prove the separate second-moment estimate. -/
def NotParallel {n : ℕ} {space : CoordinateSpace n}
    (H₁ H₂ : CoordinateHypersurface space) : Prop :=
  H₁.fixed ≠ H₂.fixed

theorem isNontrivial_iff_fixed_nonempty
    {n : ℕ} {space : CoordinateSpace n}
    (H : CoordinateHypersurface space) :
    H.IsNontrivial ↔ H.fixed.Nonempty := Iff.rfl

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
      else ⟨(space.S i).min' (space.h_nonempty i), Finset.min'_mem _ _⟩
    refine ⟨x, ?_, ?_⟩
    · intro i hi₁
      simp [x, hi₁]
    · intro i hi₂
      by_cases hi₁ : i ∈ H₁.fixed
      · have heq := hcompat i hi₁ hi₂
        simp [x, hi₁, heq]
      · simp [x, hi₁, hi₂]

#print axioms intersects_iff_agree_on_overlap

#print axioms CoordinateHypersurface.isNontrivial_iff_fixed_nonempty


/-- In the finite-product model, codimension is the number of fixed
coordinates. Thus codimension one is the concrete condition that exactly one
coordinate is fixed, matching the terminology in BBMST Theorem 3.2. -/
def HasCodimensionOne
    {n : ℕ} {space : CoordinateSpace n}
    (H : CoordinateHypersurface space) : Prop :=
  H.fixed.card = 1

/-- A stage family has no codimension-one hyperplanes if every member fixes
a number of coordinates other than one. stage H represents membership in
the actual newly exposed family N_k; the source application must prove this
property from its arithmetic configuration. -/
def NoCodimensionOneAt
    {n : ℕ} {space : CoordinateSpace n}
    (stage : CoordinateHypersurface space → Prop) : Prop :=
  ∀ H, stage H → H.fixed.card ≠ 1

theorem hasCodimensionOne_iff_card_eq_one
    {n : ℕ} {space : CoordinateSpace n}
    (H : CoordinateHypersurface space) :
    HasCodimensionOne H ↔ H.fixed.card = 1 := Iff.rfl

theorem noCodimensionOneAt_iff
    {n : ℕ} {space : CoordinateSpace n}
    (stage : CoordinateHypersurface space → Prop) :
    NoCodimensionOneAt stage ↔
      ∀ H, stage H → ¬ HasCodimensionOne H := by
  rfl

#print axioms hasCodimensionOne_iff_card_eq_one
#print axioms noCodimensionOneAt_iff


/-- If two coordinate cylinders prescribe disjoint sets of coordinates,
they are automatically compatible and hence intersect. This is a useful
special case for the compatible-intersection expansion in the BBMST moment
argument: there are no overlap constraints to check. -/
theorem intersects_of_disjoint_fixed_sets
    {n : ℕ} {space : CoordinateSpace n}
    (H₁ H₂ : CoordinateHypersurface space)
    (hdis : Disjoint H₁.fixed H₂.fixed) :
    ∃ x : CoordinatePoint space, H₁.Contains x ∧ H₂.Contains x := by
  apply (intersects_iff_agree_on_overlap H₁ H₂).2
  intro i hi₁ hi₂
  have hmem : i ∈ H₁.fixed ∩ H₂.fixed :=
    Finset.mem_inter.mpr ⟨hi₁, hi₂⟩
  exact (Finset.disjoint_left.mp hdis hi₁ hi₂).elim

#print axioms intersects_of_disjoint_fixed_sets

/-- Finite mass of an event under an arbitrary normalized nonnegative
distribution on the coordinate product. The event is filtered inside the
finite product space, so this definition does not assume coordinate
independence or a product factorization. -/
noncomputable def eventMass {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E : CoordinatePoint space → Prop) : ℚ := by
  classical
  exact ∑ x in Finset.univ.filter E, μ.weight x

/-- Event mass is nonnegative. This elementary fact is a prerequisite for
union-bound and compatible-intersection estimates in the moment argument. -/
theorem eventMass_nonneg {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E : CoordinatePoint space → Prop) :
    0 ≤ eventMass μ E := by
  classical
  unfold eventMass
  exact Finset.sum_nonneg fun x hx => μ.h_nonneg x

/-- Monotonicity of finite event mass under event inclusion. This holds for
any nonnegative distribution; no independence hypothesis is used. -/
theorem eventMass_mono {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E F : CoordinatePoint space → Prop)
    (hEF : ∀ x, E x → F x) :
    eventMass μ E ≤ eventMass μ F := by
  classical
  unfold eventMass
  apply Finset.sum_le_sum_of_subset_of_nonneg
  · intro x hx
    simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hx ⊢
    exact hEF x hx
  · intro x hx hnot
    exact μ.h_nonneg x

#print axioms eventMass_nonneg
#print axioms eventMass_mono

