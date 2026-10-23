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

/-- Exact total-mass identity for a finite product of coordinate
weights. The right side records every coordinate normalizer explicitly;
this remains true even before probability normalization is imposed. -/
theorem factorizedPointWeight_total_mass_eq_prod {n : ℕ}
    {space : CoordinateSpace n} (w : CoordinateWeightSystem space) :
    (∑ x : CoordinatePoint space, factorizedPointWeight w x) =
      ∏ i : Fin n, ∑ y : CoordinateValue space i, w.weight i y := by
  unfold factorizedPointWeight
  rw [← Fintype.prod_sum]

/-- The total mass of the factorized point weights is one when every
coordinate weight is normalized. The general product-of-normalizers identity
is proved separately above, so the normalization assumption is explicit. -/
theorem factorizedPointWeight_total_mass {n : ℕ}
    {space : CoordinateSpace n} (w : CoordinateWeightSystem space) :
    (∑ x : CoordinatePoint space, factorizedPointWeight w x) = 1 := by
  rw [factorizedPointWeight_total_mass_eq_prod]
  apply Finset.prod_eq_one
  intro i hi
  simpa using w.coordinate_sum_one i

#print axioms factorizedPointWeight_total_mass_eq_prod
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
  exact ∑ x ∈ (Finset.univ.filter E), μ.weight x

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
  -- Normalize all event masses to sums over the same finite carrier.
  -- This avoids rewriting a filtered sum as a set-valued sum.
  simp only [Finset.sum_filter]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro x hx
  by_cases he : E x
  · have hf : ¬ F x := fun hf => hdis x ⟨he, hf⟩
    simp [he, hf]
  · by_cases hf : F x <;> simp [he, hf]

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


/-- Finite-union bound for an arbitrary family of events. This is the
inductive interface needed to turn stagewise distortion estimates into a
global bound on the mass removed by a finite sieve. Overlaps are allowed:
the proof uses the two-event union bound rather than assuming disjointness. -/
theorem eventMass_finset_union_le_sum
    {ι : Type*} [DecidableEq ι]
    {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (s : Finset ι)
    (E : ι → CoordinatePoint space → Prop) :
    eventMass μ (fun x => ∃ i ∈ s, E i x) ≤
      ∑ i ∈ s, eventMass μ (E i) := by
  classical
  induction s using Finset.induction_on with
  | empty =>
      simp [eventMass]
  | @insert i s hi ih =>
      have hunion :
          (fun x => ∃ j ∈ insert i s, E j x) =
            (fun x => E i x ∨ ∃ j ∈ s, E j x) := by
        funext x
        simp [hi]
      rw [hunion]
      calc
        eventMass μ (fun x => E i x ∨ ∃ j ∈ s, E j x)
            ≤ eventMass μ (E i) +
                eventMass μ (fun x => ∃ j ∈ s, E j x) :=
              eventMass_union_le_add μ (E i) _
        _ ≤ eventMass μ (E i) + ∑ j ∈ s, eventMass μ (E j) := by
              linarith
        _ = ∑ j ∈ insert i s, eventMass μ (E j) := by
              simp [hi, Finset.sum_insert]

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


/-- Quantitative uncovered-mass certificate for a finite family of forbidden
events. If the sum of their masses is below one, the complement has positive
mass. This is the exact finite union-to-survival bridge; the BBMST-specific
work still lies in proving useful stagewise bounds for those event masses
under the distorted measures. -/
theorem eventMass_uncovered_ge_one_sub_sum
    {ι : Type*} [DecidableEq ι]
    {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (s : Finset ι)
    (E : ι → CoordinatePoint space → Prop) :
    1 - (∑ i ∈ s, eventMass μ (E i)) ≤
      eventMass μ (fun x => ∀ i ∈ s, ¬ E i x) := by
  have hUnion := eventMass_finset_union_le_sum μ s E
  have hComplement := eventMass_complement μ (fun x => ∃ i ∈ s, E i x)
  have hSame :
      (fun x => ¬ (∃ i ∈ s, E i x)) =
        (fun x => ∀ i ∈ s, ¬ E i x) := by
    funext x
    simp
  rw [hSame] at hComplement
  rw [hComplement]
  linarith

#print axioms eventMass_uncovered_ge_one_sub_sum


/-- Strict positivity form of the finite survival certificate. This is the
usable noncoverage interface: once a source-faithful argument proves that the
sum of forbidden-event masses is strictly below one, a point outside their
union exists because the surviving event has positive mass. This lemma does
not supply that BBMST-specific strict bound. -/
theorem eventMass_uncovered_pos_of_sum_lt_one
    {ι : Type*} [DecidableEq ι]
    {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (s : Finset ι)
    (E : ι → CoordinatePoint space → Prop)
    (hsum : (∑ i ∈ s, eventMass μ (E i)) < 1) :
    0 < eventMass μ (fun x => ∀ i ∈ s, ¬ E i x) := by
  have h := eventMass_uncovered_ge_one_sub_sum μ s E
  linarith

#print axioms eventMass_uncovered_pos_of_sum_lt_one


/-- Positive event mass implies that the event has a witness in the finite sample space. -/
theorem exists_point_of_eventMass_pos
    {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space) (E : CoordinatePoint space → Prop)
    (hpos : 0 < eventMass μ E) : ∃ x, E x := by
  classical
  by_contra hnone
  have hfalse : ∀ x : CoordinatePoint space, ¬ E x := by
    simpa only [not_exists] using hnone
  have heq : E = (fun _ : CoordinatePoint space => False) := by
    funext x
    exact propext (iff_false_intro (hfalse x))
  rw [heq, eventMass_empty] at hpos
  exact (lt_irrefl 0 hpos)

#print axioms exists_point_of_eventMass_pos


/-- A strict finite union-mass bound yields a point outside every forbidden
event. This is the existential form needed by a covering-system argument. -/
theorem exists_point_avoiding_events
    {ι : Type*} [DecidableEq ι]
    {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (s : Finset ι)
    (E : ι → CoordinatePoint space → Prop)
    (hsum : (∑ i ∈ s, eventMass μ (E i)) < 1) :
    ∃ x : CoordinatePoint space, ∀ i ∈ s, ¬ E i x := by
  have hpos := eventMass_uncovered_pos_of_sum_lt_one μ s E hsum
  exact exists_point_of_eventMass_pos μ
    (fun x => ∀ i ∈ s, ¬ E i x) hpos

#print axioms exists_point_avoiding_events


/-- Distortion-transfer principle for finite event mass. If a new normalized
weight is pointwise bounded by a constant multiple of an old weight, then
every event inherits the same multiplicative bound. This isolates one
quantitative obligation in the BBMST distortion method; it does not assume
independence and does not itself construct a useful distortion. -/
theorem eventMass_le_const_mul_of_pointwise
    {n : ℕ} {space : CoordinateSpace n}
    (μ ν : ProductDistribution space) (E : CoordinatePoint space → Prop)
    (C : ℚ) (hC : 0 ≤ C)
    (hdom : ∀ x, μ.weight x ≤ C * ν.weight x) :
    eventMass μ E ≤ C * eventMass ν E := by
  classical
  unfold eventMass
  calc
    (∑ x ∈ Finset.univ.filter E, μ.weight x) ≤
        ∑ x ∈ Finset.univ.filter E, C * ν.weight x := by
      apply Finset.sum_le_sum
      intro x hx
      exact hdom x
    _ = C * (∑ x ∈ Finset.univ.filter E, ν.weight x) := by
      rw [Finset.mul_sum]


/-- If an event has no witnesses, its mass is zero. This bridges a finite
incidence contradiction to the weighted probability layer without any
independence assumption. -/
theorem eventMass_zero_of_forall_not
    {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (E : CoordinatePoint space → Prop)
    (hE : ∀ x, ¬ E x) :
    eventMass μ E = 0 := by
  classical
  unfold eventMass
  have hempty : Finset.univ.filter E = ∅ := by
    ext x
    simp [hE x]
  rw [hempty]
  simp

#print axioms eventMass_zero_of_forall_not


/-- A disagreement on a shared fixed coordinate makes the intersection
event have zero mass under every normalized nonnegative distribution. This
connects exact coordinate incompatibility to the measure layer. -/
theorem eventMass_intersection_zero_of_disagreeing_overlap
    {n : ℕ} {space : CoordinateSpace n}
    (μ : ProductDistribution space)
    (H₁ H₂ : CoordinateHypersurface space)
    (i : Fin n) (hi₁ : i ∈ H₁.fixed) (hi₂ : i ∈ H₂.fixed)
    (hdis : H₁.value i hi₁ ≠ H₂.value i hi₂) :
    eventMass μ (fun x => H₁.Contains x ∧ H₂.Contains x) = 0 := by
  apply eventMass_zero_of_forall_not μ
  intro x hx
  exact (disjoint_of_disagreeing_overlap H₁ H₂ i hi₁ hi₂ hdis)
    ⟨x, hx.1, hx.2⟩

#print axioms eventMass_intersection_zero_of_disagreeing_overlap


/-- Two-sided event-mass transfer under a pointwise relative distortion
bound. This packages the quantitative obligation behind a distortion
argument: if every point weight changes by at most an epsilon fraction of
the reference weight, every event mass changes by the same relative factor.
No independence hypothesis is used here; the estimate is purely pointwise. -/
theorem eventMass_between_of_pointwise_distortion
    {n : ℕ} {space : CoordinateSpace n}
    (μ ν : ProductDistribution space)
    (E : CoordinatePoint space → Prop)
    (ε : ℚ) (hε : 0 ≤ ε)
    (hlower : ∀ x, (1 - ε) * ν.weight x ≤ μ.weight x)
    (hupper : ∀ x, μ.weight x ≤ (1 + ε) * ν.weight x) :
    (1 - ε) * eventMass ν E ≤ eventMass μ E ∧
      eventMass μ E ≤ (1 + ε) * eventMass ν E := by
  constructor
  · classical
    unfold eventMass
    calc
      (1 - ε) * (∑ x ∈ Finset.univ.filter E, ν.weight x) =
          ∑ x ∈ Finset.univ.filter E, (1 - ε) * ν.weight x := by
            rw [Finset.mul_sum]
      _ ≤ ∑ x ∈ Finset.univ.filter E, μ.weight x := by
            apply Finset.sum_le_sum
            intro x hx
            exact hlower x
  · exact eventMass_le_const_mul_of_pointwise μ ν E (1 + ε)
      (by linarith) hupper

#print axioms eventMass_between_of_pointwise_distortion

/-- Composing two pointwise domination bounds composes their constants.
This is the elementary multiplicative step needed to assemble local
distortion estimates without assuming independence. The quantitative work
remains to construct useful bounds C and D in the BBMST model. -/
theorem eventMass_le_composed_pointwise_distortion
    {n : ℕ} {space : CoordinateSpace n}
    (μ middle ν : ProductDistribution space)
    (E : CoordinatePoint space → Prop)
    (C D : ℚ) (hC : 0 ≤ C) (hD : 0 ≤ D)
    (hMuMiddle : ∀ x, μ.weight x ≤ C * middle.weight x)
    (hMiddleNu : ∀ x, middle.weight x ≤ D * ν.weight x) :
    eventMass μ E ≤ (C * D) * eventMass ν E := by
  apply eventMass_le_const_mul_of_pointwise μ ν E (C * D)
    (mul_nonneg hC hD)
  intro x
  calc
    μ.weight x ≤ C * middle.weight x := hMuMiddle x
    _ ≤ C * (D * ν.weight x) :=
      mul_le_mul_of_nonneg_left (hMiddleNu x) hC
    _ = (C * D) * ν.weight x := by ring

#print axioms eventMass_le_composed_pointwise_distortion

/-- Two-sided distortion bounds compose with multiplicative constants.
This makes the quantitative dependency explicit: if each stage controls
point weights above and below, the corresponding event-mass bounds compose
without any independence assumption. The remaining BBMST problem is to
derive sharp stage constants from the source geometry. -/
theorem eventMass_between_composed_pointwise_bounds
    {n : ℕ} {space : CoordinateSpace n}
    (μ middle ν : ProductDistribution space)
    (Evt : CoordinatePoint space → Prop)
    (C D E F : ℚ)
    (hC : 0 ≤ C) (hD : 0 ≤ D)
    (hE : 0 ≤ E) (hF : 0 ≤ F)
    (hMuMiddleLower : ∀ x, C * middle.weight x ≤ μ.weight x)
    (hMuMiddleUpper : ∀ x, μ.weight x ≤ D * middle.weight x)
    (hMiddleNuLower : ∀ x, E * ν.weight x ≤ middle.weight x)
    (hMiddleNuUpper : ∀ x, middle.weight x ≤ F * ν.weight x) :
    (C * E) * eventMass ν Evt ≤ eventMass μ Evt ∧
      eventMass μ Evt ≤ (D * F) * eventMass ν Evt := by
  constructor
  · classical
    unfold eventMass
    calc
      (C * E) * (∑ x ∈ Finset.univ.filter Evt, ν.weight x) =
          ∑ x ∈ Finset.univ.filter Evt, (C * E) * ν.weight x := by
            rw [Finset.mul_sum]
      _ ≤ ∑ x ∈ Finset.univ.filter Evt, μ.weight x := by
            apply Finset.sum_le_sum
            intro x hx
            calc
              (C * E) * ν.weight x = C * (E * ν.weight x) := by ring
              _ ≤ C * middle.weight x :=
                mul_le_mul_of_nonneg_left (hMiddleNuLower x) hC
              _ ≤ μ.weight x := hMuMiddleLower x
  · apply eventMass_le_const_mul_of_pointwise μ ν Evt (D * F)
      (mul_nonneg hD hF)
    intro x
    calc
      μ.weight x ≤ D * middle.weight x := hMuMiddleUpper x
      _ ≤ D * (F * ν.weight x) :=
        mul_le_mul_of_nonneg_left (hMiddleNuUpper x) hD
      _ = (D * F) * ν.weight x := by ring

#print axioms eventMass_between_composed_pointwise_bounds

/-- Exact pointwise splitting of a product weight into prescribed and free
coordinates on a cylinder. The cylinder-mass identity follows by summing
the free-coordinate factors using coordinate normalization. -/
theorem factorizedPointWeight_split_on_cylinder
    {n : ℕ} {space : CoordinateSpace n}
    (w : CoordinateWeightSystem space)
    (H : CoordinateHypersurface space)
    (x : CoordinatePoint space)
    (hx : H.Contains x) :
    factorizedPointWeight w x =
      (∏ i : Fin n, if hi : i ∈ H.fixed then
        w.weight i (H.value i hi) else 1) *
      (∏ i : Fin n, if hi : i ∈ H.fixed then
        1 else w.weight i (x i)) := by
  unfold factorizedPointWeight
  rw [← Finset.prod_mul_distrib]
  apply Finset.prod_congr rfl
  intro i hi
  by_cases hfix : i ∈ H.fixed
  · simp [hfix, hx i hfix]
  · simp [hfix]

#print axioms factorizedPointWeight_split_on_cylinder


/-- One-coordinate contribution to the cylinder sum. A fixed coordinate
collapses to the weight of its prescribed value; a free coordinate collapses
to one by normalization. -/
def cylinderCoordinateSum {n : ℕ} {space : CoordinateSpace n}
    (w : CoordinateWeightSystem space)
    (H : CoordinateHypersurface space) (i : Fin n) : ℚ :=
  if hi : i ∈ H.fixed then
    ∑ y : CoordinateValue space i,
      w.weight i y * (if y = H.value i hi then 1 else 0)
  else
    ∑ y : CoordinateValue space i, w.weight i y

/-- Exact evaluation of a coordinate sum: prescribed coordinates contribute
their prescribed weight, while free coordinates contribute one. This is the
coordinatewise algebraic core of the cylinder-mass formula. -/
theorem cylinderCoordinateSum_eq {n : ℕ} {space : CoordinateSpace n}
    (w : CoordinateWeightSystem space)
    (H : CoordinateHypersurface space) (i : Fin n) :
    cylinderCoordinateSum w H i =
      if hi : i ∈ H.fixed then w.weight i (H.value i hi) else 1 := by
  classical
  unfold cylinderCoordinateSum
  by_cases hfix : i ∈ H.fixed
  · simp only [dif_pos hfix]
    rw [Finset.sum_eq_single (H.value i hfix)]
    · simp
    · intro y hy hne
      simp [hne]
    · intro hnot
      exact (hnot (Finset.mem_univ _)).elim
  · simp only [dif_neg hfix]
    exact w.coordinate_sum_one i

/-- After separating coordinates, the product of all one-coordinate sums
is exactly the product over the fixed coordinates. This theorem isolates the
free-coordinate cancellation step. The remaining bridge to eventMass is
to prove that summing the original point weights over H.Contains equals
this separated coordinate sum; no such bridge is asserted here. -/
theorem cylinderCoordinateSums_product_eq {n : ℕ}
    {space : CoordinateSpace n} (w : CoordinateWeightSystem space)
    (H : CoordinateHypersurface space) :
    (∏ i : Fin n, cylinderCoordinateSum w H i) =
      ∏ i : Fin n, if hi : i ∈ H.fixed then
        w.weight i (H.value i hi) else 1 := by
  apply Finset.prod_congr rfl
  intro i hi
  exact cylinderCoordinateSum_eq w H i

#print axioms cylinderCoordinateSum_eq
#print axioms cylinderCoordinateSums_product_eq


/-!
## Good/bad-state transfer lemma

This lemma formalizes the proposed alternative to a uniform pointwise
distortion bound. On good states we compare weights pointwise; the total
mass of bad states is paid as an additive error. It is a generic finite
inequality, not yet a source-specific BBMST estimate.
-/

/-- Additive-error transfer when pointwise domination is available only on
a good subset. The bad-state mass is charged once, independently of the
event being tested. -/
theorem eventMass_le_good_bad_transfer
    {n : ℕ} {space : CoordinateSpace n}
    (μ ν : ProductDistribution space)
    (E G : CoordinatePoint space → Prop)
    (C η : ℚ) (hC : 0 ≤ C) (hη : 0 ≤ η)
    (hgood : ∀ x, G x → μ.weight x ≤ C * ν.weight x)
    (hbad : eventMass μ (fun x => ¬ G x) ≤ η) :
    eventMass μ E ≤ C * eventMass ν E + η := by
  classical
  have hsplit :
      eventMass μ E =
        eventMass μ (fun x => E x ∧ G x) +
          eventMass μ (fun x => E x ∧ ¬ G x) := by
    unfold eventMass
    simp only [Finset.sum_filter]
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro x hx
    by_cases he : E x <;> by_cases hg : G x <;> simp [he, hg]
  have hgood_inter :
      eventMass μ (fun x => E x ∧ G x) ≤
        C * eventMass ν (fun x => E x ∧ G x) := by
    unfold eventMass
    calc
      (∑ x ∈ Finset.univ.filter (fun x => E x ∧ G x), μ.weight x) ≤
          ∑ x ∈ Finset.univ.filter (fun x => E x ∧ G x), C * ν.weight x := by
        apply Finset.sum_le_sum
        intro x hx
        exact hgood x (Finset.mem_filter.mp hx).2.2
      _ = C * (∑ x ∈ Finset.univ.filter (fun x => E x ∧ G x), ν.weight x) := by
        rw [Finset.mul_sum]
  have hgoodmass :
      eventMass μ (fun x => E x ∧ G x) ≤ C * eventMass ν E :=
    le_trans hgood_inter
      (mul_le_mul_of_nonneg_left
        (eventMass_mono ν (fun x => E x ∧ G x) E
          (by intro x hx; exact hx.1)) hC)
  have hbadmass :
      eventMass μ (fun x => E x ∧ ¬ G x) ≤ η := by
    apply le_trans
      (eventMass_mono μ (fun x => E x ∧ ¬ G x) (fun x => ¬ G x) ?_)
      hbad
    intro x hx
    exact hx.2
  rw [hsplit]
  linarith

#print axioms eventMass_le_good_bad_transfer
