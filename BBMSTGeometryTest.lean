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


/-- Coordinate-wise weights for a genuine finite product measure. Unlike
`ProductDistribution` above, this object does not permit an arbitrary
normalized joint weight: its joint weight is explicitly defined as a product
of coordinate weights. Normalization of the resulting joint measure is a
separate theorem and is not inferred from pointwise factorization alone. -/
structure CoordinateWeightSystem {n : ℕ} (space : CoordinateSpace n) where
  weight : ∀ i : Fin n, CoordinateValue space i → ℚ
  nonneg : ∀ i x, 0 ≤ weight i x
  coordinate_sum_one : ∀ i, ∑ x : CoordinateValue space i, weight i x = 1

/-- The joint point weight induced by independent coordinate weights. -/
def factorizedPointWeight {n : ℕ} {space : CoordinateSpace n}
    (w : CoordinateWeightSystem space) (x : CoordinatePoint space) : ℚ :=
  ∏ i : Fin n, w.weight i (x i)

/-- The joint weight is exactly the product of its coordinate weights.
This is the independence structure that an arbitrary normalized measure lacks. -/
theorem factorizedPointWeight_eq_prod {n : ℕ} {space : CoordinateSpace n}
    (w : CoordinateWeightSystem space) (x : CoordinatePoint space) :
    factorizedPointWeight w x = ∏ i : Fin n, w.weight i (x i) := rfl

/-- Products of nonnegative coordinate weights are nonnegative. -/
theorem factorizedPointWeight_nonneg {n : ℕ} {space : CoordinateSpace n}
    (w : CoordinateWeightSystem space) (x : CoordinatePoint space) :
    0 ≤ factorizedPointWeight w x := by
  unfold factorizedPointWeight
  exact Finset.prod_nonneg (fun i hi => w.nonneg i (x i))

#print axioms factorizedPointWeight_eq_prod
#print axioms factorizedPointWeight_nonneg

/-- The total mass of the factorized point weights is the product of the
coordinate normalizers. This is the finite product-measure normalization
identity; it does not follow from pointwise factorization alone unless the
coordinate weights are themselves normalized. -/
theorem factorizedPointWeight_total_mass {n : ℕ}
    {space : CoordinateSpace n} (w : CoordinateWeightSystem space) :
    (∑ x : CoordinatePoint space, factorizedPointWeight w x) = 1 := by
  calc
    (∑ x : CoordinatePoint space, factorizedPointWeight w x) =
        ∏ i : Fin n, ∑ y : CoordinateValue space i, w.weight i y := by
          unfold factorizedPointWeight
          rw [← Fintype.prod_sum]
    _ = 1 := by
      apply Finset.prod_eq_one
      intro i hi
      simpa using w.coordinate_sum_one i

#print axioms factorizedPointWeight_total_mass

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
  exact ∑ x ∈ Finset.univ.filter E, μ.weight x

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

/-- The whole finite sample space has mass one, by the distribution's
normalization certificate. -/
theorem eventMass_univ {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space) :
    eventMass μ (fun _ => True) = 1 := by
  classical
  unfold eventMass
  simpa using μ.h_sum_one



/-- Every event has mass at most one. This follows from monotonicity and
normalization, without assuming independence or a product factorization. -/
theorem eventMass_le_one {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E : CoordinatePoint space → Prop) :
    eventMass μ E ≤ 1 := by
  calc
    eventMass μ E ≤ eventMass μ (fun _ => True) :=
      eventMass_mono μ E (fun _ => True) (by intro x hx; trivial)
    _ = 1 := eventMass_univ μ

theorem eventMass_empty {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space) :
    eventMass μ (fun _ => False) = 0 := by
  classical
  unfold eventMass
  simp

/-- Finite event mass is additive on disjoint events. This is the measure
identity needed to turn compatible-intersection information into exact
second-moment expansions; it uses only finite summation, not independence. -/
theorem eventMass_union_of_disjoint {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E F : CoordinatePoint space → Prop)
    (hdis : ∀ x, ¬ (E x ∧ F x)) :
    eventMass μ (fun x => E x ∨ F x) = eventMass μ E + eventMass μ F := by
  classical
  unfold eventMass
  have hdisj : Disjoint (Finset.univ.filter E) (Finset.univ.filter F) := by
    apply Finset.disjoint_left.mpr
    intro x hxE hxF
    simp only [Finset.mem_filter, Finset.mem_univ, true_and] at hxE hxF
    exact hdis x ⟨hxE, hxF⟩
  simpa only [Finset.filter_or, Finset.sum_union hdisj]

#print axioms eventMass_union_of_disjoint

/-- Finite union bound: the mass of a union is at most the sum of the
masses. Split the union into E and the disjoint remainder F \\ E; this
uses only nonnegativity and finite additivity, not independence. -/
theorem eventMass_union_le_add {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E F : CoordinatePoint space → Prop) :
    eventMass μ (fun x => E x ∨ F x) ≤ eventMass μ E + eventMass μ F := by
  have hrewrite :
      eventMass μ (fun x => E x ∨ F x) =
        eventMass μ (fun x => E x ∨ (F x ∧ ¬ E x)) := by
    congr 1
    funext x
    by_cases hE : E x <;> simp [hE]
  rw [hrewrite]
  have hdis :
      ∀ x, ¬ (E x ∧ (fun y => F y ∧ ¬ E y) x) := by
    intro x hx
    exact hx.2.2 hx.1
  rw [eventMass_union_of_disjoint μ E (fun x => F x ∧ ¬ E x) hdis]
  have hsub :
      eventMass μ (fun x => F x ∧ ¬ E x) ≤ eventMass μ F :=
    eventMass_mono μ (fun x => F x ∧ ¬ E x) F (by
      intro x hx
      exact hx.1)
  linarith

#print axioms eventMass_union_le_add

/-- Intersections cannot have more mass than either constituent event.
These bounds are the elementary outer estimates used before the sharper
compatible-hyperplane moment estimates in the published BBMST argument. -/
theorem eventMass_inter_le_left {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E F : CoordinatePoint space → Prop) :
    eventMass μ (fun x => E x ∧ F x) ≤ eventMass μ E :=
  eventMass_mono μ (fun x => E x ∧ F x) E (by
    intro x hx
    exact hx.1)

/-- Symmetric right-hand version of the intersection mass bound. -/
theorem eventMass_inter_le_right {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E F : CoordinatePoint space → Prop) :
    eventMass μ (fun x => E x ∧ F x) ≤ eventMass μ F :=
  eventMass_mono μ (fun x => E x ∧ F x) F (by
    intro x hx
    exact hx.2)

#print axioms eventMass_inter_le_left
#print axioms eventMass_inter_le_right


/-- Complement mass is exactly one minus event mass. Together with
nonnegativity, monotonicity, and disjoint additivity, this gives the basic
finite probability algebra used by the sieve argument. -/
theorem eventMass_complement {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E : CoordinatePoint space → Prop) :
    eventMass μ (fun x => ¬ E x) = 1 - eventMass μ E := by
  have hdis :
      ∀ x, ¬ (E x ∧ (fun y => ¬ E y) x) := by
    intro x hx
    exact hx.2 hx.1
  have hunion :
      eventMass μ (fun x => E x ∨ (¬ E x)) =
        eventMass μ E + eventMass μ (fun x => ¬ E x) :=
    eventMass_union_of_disjoint μ E (fun x => ¬ E x) hdis
  have hall :
      eventMass μ (fun _ => True) =
        eventMass μ E + eventMass μ (fun x => ¬ E x) := by
    calc
      eventMass μ (fun _ => True) =
          eventMass μ (fun x => E x ∨ ¬ E x) := by
            congr 1
            funext x
            by_cases hE : E x <;> simp [hE]
      _ = eventMass μ E + eventMass μ (fun x => ¬ E x) := hunion
  rw [eventMass_univ] at hall
  linarith

#print axioms eventMass_complement


/-- Bonferroni's first intersection lower bound. It follows from the union
bound applied to the two complements. This is a useful sanity bound for the
intersection terms in a second-moment estimate; it is not the sharper
coordinate-compatibility estimate of BBMST Theorem 3.2. -/
theorem eventMass_inter_lower_bound {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E F : CoordinatePoint space → Prop) :
    eventMass μ E + eventMass μ F - 1 ≤
      eventMass μ (fun x => E x ∧ F x) := by
  have hunion :
      eventMass μ (fun x => ¬ E x ∨ ¬ F x) ≤
        eventMass μ (fun x => ¬ E x) +
          eventMass μ (fun x => ¬ F x) :=
    eventMass_union_le_add μ (fun x => ¬ E x) (fun x => ¬ F x)
  have hcompE := eventMass_complement μ E
  have hcompF := eventMass_complement μ F
  have hcompI := eventMass_complement μ (fun x => E x ∧ F x)
  have hnotI :
      eventMass μ (fun x => ¬ (E x ∧ F x)) =
        eventMass μ (fun x => ¬ E x ∨ ¬ F x) := by
    congr 1
    funext x
    exact propext (not_and_or)
  rw [hnotI] at hcompI
  linarith

/-- The elementary upper intersection estimate can be stated as a minimum,
which is convenient when collecting pairwise terms in a finite second moment. -/
theorem eventMass_inter_le_min {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E F : CoordinatePoint space → Prop) :
    eventMass μ (fun x => E x ∧ F x) ≤ min (eventMass μ E) (eventMass μ F) := by
  exact le_min (eventMass_inter_le_left μ E F)
    (eventMass_inter_le_right μ E F)

#print axioms eventMass_inter_lower_bound
#print axioms eventMass_inter_le_min


/-- A genuinely factorized probability distribution. Unlike
`ProductDistribution`, this structure explicitly requires each point weight
to factor as a product of coordinate weights. The inherited normalization
still states that the total mass is one; no independence claim is inferred
from the shape of the sample space alone. -/
structure FactorizedProductDistribution {n : ℕ}
    (space : CoordinateSpace n) extends ProductDistribution space where
  coordinateWeight : ∀ i : Fin n, CoordinateValue space i → ℚ
  coordinateWeight_nonneg : ∀ i x, 0 ≤ coordinateWeight i x
  factorizes : ∀ x : CoordinatePoint space,
    weight x = ∏ i : Fin n, coordinateWeight i (x i)

namespace FactorizedProductDistribution

/-- The factorization law is part of the model's explicit data, not an
unstated probabilistic assumption. -/
theorem weight_eq_prod {n : ℕ} {space : CoordinateSpace n}
    (μ : FactorizedProductDistribution space) (x : CoordinatePoint space) :
    μ.toProductDistribution.weight x =
      ∏ i : Fin n, μ.coordinateWeight i (x i) :=
  μ.factorizes x

/-- Coordinate factors are nonnegative by construction. -/
theorem coordinate_weight_nonneg {n : ℕ} {space : CoordinateSpace n}
    (μ : FactorizedProductDistribution space) (i : Fin n)
    (x : CoordinateValue space i) :
    0 ≤ μ.coordinateWeight i x :=
  μ.coordinateWeight_nonneg i x

end FactorizedProductDistribution

#print axioms FactorizedProductDistribution.weight_eq_prod
#print axioms FactorizedProductDistribution.coordinate_weight_nonneg


/-- Turn normalized coordinate weights into an actual joint probability
distribution. The pointwise product law, nonnegativity, and total mass one
are all discharged from the coordinate hypotheses; callers need not assume
normalization of an arbitrary joint distribution. -/
def CoordinateWeightSystem.toProductDistribution {n : ℕ}
    {space : CoordinateSpace n} (w : CoordinateWeightSystem space) :
    ProductDistribution space where
  weight := factorizedPointWeight w
  h_nonneg := factorizedPointWeight_nonneg w
  h_sum_one := factorizedPointWeight_total_mass w

#print axioms CoordinateWeightSystem.toProductDistribution
