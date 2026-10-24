import Mathlib

namespace BBMSTAudit

/--
The scalar normalization identity underlying the fiber update in
Balister–Bollobás–Morris–Sahasrabudhe–Tiba, Lemma 2.1.

Here α is the covered fraction of one fiber and δ is the allowed threshold.
For α ≤ δ, covered points receive weight zero and uncovered points are
rescaled by 1/(1-α). For α > δ, the covered and uncovered multipliers are
(α-δ)/(α(1-δ)) and 1/(1-δ), respectively.

The bounds 0 ≤ α ≤ 1 and 0 ≤ δ ≤ 1/2 ensure every denominator used on its
active branch is nonzero. This proves only scalar fiber normalization;
the finite product-space geometry and global sieve theorem remain separate.
-/
theorem fiber_update_preserves_mass
    (α δ : ℚ)
    (hα0 : 0 ≤ α) (hα1 : α ≤ 1)
    (hδ0 : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    (if α ≤ δ then
        α * 0 + (1 - α) * (1 / (1 - α)
      )
      else
        α * ((α - δ) / (α * (1 - δ))) +
          (1 - α) * (1 / (1 - δ))) = 1 := by
  by_cases h : α ≤ δ
  · have hden : 1 - α ≠ 0 := by
      have hαδ : α ≤ (1 / 2 : ℚ) := le_trans h hδhalf
      linarith
    simp only [if_pos h, mul_zero, zero_add]
    field_simp
  · have hα : α ≠ 0 := by
      have hδpos : δ < α := lt_of_not_ge h
      linarith
    have hden : 1 - δ ≠ 0 := by
      linarith
    simp only [if_neg h]
    field_simp
    ring

#print axioms fiber_update_preserves_mass

/--
On the active branch α > δ, the covered-fiber multiplier is nonnegative.
This is a genuine side condition for interpreting the scalar update as a
nonnegative weight update; mass normalization alone does not establish it.
-/
theorem fiber_update_covered_multiplier_nonnegative
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    0 ≤ (α - δ) / (α * (1 - δ)) := by
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  apply div_nonneg
  · exact sub_nonneg.mpr (le_of_lt hactive)
  · exact mul_nonneg (le_of_lt hαpos) (le_of_lt (sub_pos.mpr hδlt))

/--
On the active branch α > δ, the uncovered-fiber multiplier is strictly
positive. Together with the preceding lemma this verifies the sign conditions
for the two multipliers used by the update, independently of normalization.
-/
theorem fiber_update_uncovered_multiplier_pos
    (δ : ℚ)
    (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    0 < 1 / (1 - δ) := by
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  apply div_pos
  · norm_num
  · exact sub_pos.mpr hδlt

#print axioms fiber_update_covered_multiplier_nonnegative
#print axioms fiber_update_uncovered_multiplier_pos

/--
On the active branch, the covered-fiber multiplier is at most the
uncovered-fiber multiplier. This comparison is distinct from normalization:
it says that the reweighting never assigns more weight per covered point
than per uncovered point.
-/
theorem fiber_update_covered_multiplier_le_uncovered_multiplier
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    (α - δ) / (α * (1 - δ)) ≤ 1 / (1 - δ) := by
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  have hden : 0 ≤ α * (1 - δ) :=
    mul_nonneg (le_of_lt hαpos) (le_of_lt (sub_pos.mpr hδlt))
  calc
    (α - δ) / (α * (1 - δ))
        ≤ α / (α * (1 - δ)) :=
          div_le_div_of_nonneg_right (sub_le_self α hδ0) hden
    _ = 1 / (1 - δ) := by
      field_simp [ne_of_gt hαpos, ne_of_gt (sub_pos.mpr hδlt)]

/--
Exact quantitative gap between the uncovered and covered multipliers.
The loss per covered point is δ/(α(1-δ)); hence the comparison above is
strict exactly when δ > 0. This is stronger than merely knowing the ordering
of the two weights and can be used in a later quantitative contraction
argument. It remains a scalar identity, not the global BBMST sieve estimate.
-/
theorem fiber_update_multiplier_gap
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    1 / (1 - δ) -
        (α - δ) / (α * (1 - δ)) =
      δ / (α * (1 - δ)) := by
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  field_simp [ne_of_gt hαpos, ne_of_gt (sub_pos.mpr hδlt)]
  ring

/-- The gap is strictly positive when the threshold is positive. -/
theorem fiber_update_multiplier_gap_pos
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 < δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    0 < 1 / (1 - δ) -
        (α - δ) / (α * (1 - δ)) := by
  rw [fiber_update_multiplier_gap α δ hα0 (le_of_lt hδ0) hδhalf hactive]
  have hαpos : 0 < α := lt_of_le_of_lt (le_of_lt hδ0) hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  exact div_pos hδ0
    (mul_pos hαpos (sub_pos.mpr hδlt))

#print axioms fiber_update_multiplier_gap
#print axioms fiber_update_multiplier_gap_pos

/--
Exact edge-case characterization: under the active-branch hypotheses and
δ ≥ 0, the multiplier gap is strictly positive if and only if δ is positive.
In particular δ = 0 gives no strict contraction from this update alone.
-/
theorem fiber_update_multiplier_gap_pos_iff
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    (0 < 1 / (1 - δ) -
        (α - δ) / (α * (1 - δ))) ↔ 0 < δ := by
  constructor
  · intro hgap
    by_contra hnot
    have hδeq : δ = 0 := by linarith
    rw [fiber_update_multiplier_gap α δ hα0 hδ0 hδhalf hactive] at hgap
    simp [hδeq] at hgap
  · intro hδpos
    exact fiber_update_multiplier_gap_pos α δ hα0
      hδpos hδhalf hactive

#print axioms fiber_update_multiplier_gap_pos_iff


/--
Quantitative strengthening: if the covered fraction is at most one, then
the active-branch multiplier gap is at least δ. Indeed α(1-δ) ≤ 1, so
δ/(α(1-δ)) ≥ δ. This bound makes the loss uniform in α once the threshold
δ is fixed.
-/
theorem fiber_update_multiplier_gap_ge_threshold
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hα1 : α ≤ 1)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    δ ≤ 1 / (1 - δ) -
        (α - δ) / (α * (1 - δ)) := by
  rw [fiber_update_multiplier_gap α δ hα0 hδ0 hδhalf hactive]
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  have hdenpos : 0 < α * (1 - δ) :=
    mul_pos hαpos (sub_pos.mpr hδlt)
  have hdenle : α * (1 - δ) ≤ 1 := by
    have hfactor : 0 ≤ 1 - δ := le_of_lt (sub_pos.mpr hδlt)
    have hprod : 0 ≤ (1 - α) * (1 - δ) :=
      mul_nonneg (sub_nonneg.mpr hα1) hfactor
    nlinarith
  rw [le_div_iff₀ hdenpos]
  nlinarith [mul_nonneg hδ0 (sub_nonneg.mpr hdenle)]

#print axioms fiber_update_multiplier_gap_ge_threshold


/--
The covered-fraction-weighted gap is independent of α:
α times the per-point multiplier gap equals δ/(1-δ).
This converts a pointwise gap into an aggregate fiber-level quantity,
and makes explicit that the α-dependence cancels after weighting by the
covered mass. This is still a scalar identity, not a geometric sieve bound.
-/
theorem fiber_update_covered_mass_weighted_gap
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    α * (1 / (1 - δ) -
        (α - δ) / (α * (1 - δ))) =
      δ / (1 - δ) := by
  rw [fiber_update_multiplier_gap α δ hα0 hδ0 hδhalf hactive]
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  field_simp [ne_of_gt hαpos, ne_of_gt (sub_pos.mpr hδlt)]

#print axioms fiber_update_covered_mass_weighted_gap


/--
Aggregate quantitative loss: on the active branch, the covered-mass-weighted
gap is at least δ. The exact value is δ/(1-δ), so the bound is uniform in α.
This remains a scalar inequality; geometric independence and the global sieve
criterion are not established by it.
-/
theorem fiber_update_covered_mass_weighted_gap_ge_threshold
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    δ ≤ α * (1 / (1 - δ) -
        (α - δ) / (α * (1 - δ))) := by
  rw [fiber_update_covered_mass_weighted_gap
    α δ hα0 hδ0 hδhalf hactive]
  have hden : 0 < 1 - δ := by linarith
  rw [le_div_iff₀ hden]
  nlinarith [sq_nonneg δ]

#print axioms fiber_update_covered_mass_weighted_gap_ge_threshold



/-!
## Concrete affine-event geometry

The next bridge beyond scalar fiber weights is to encode coverage events as
actual solution sets of linear equations. The lemmas below do not assume an
abstract predicate for parallelism: the relation between the linear forms is
stated pointwise, and disjointness follows from the equations themselves.
This is a first geometric component, not yet the full finite-field counting
or global BBMST overlap estimate.
-/

/-- If two linear forms are pointwise scalar multiples, an intersection of
their affine level sets forces the same scalar relation between the offsets. -/
theorem affine_overlap_forces_offset_relation
    {K V : Type*} [Field K] [AddCommGroup V] [Module K V]
    (L₁ L₂ : V →ₗ[K] K) (c b₁ b₂ : K)
    (hscaled : ∀ x, L₂ x = c * L₁ x)
    (x : V) (hx₁ : L₁ x = b₁) (hx₂ : L₂ x = b₂) :
    b₂ = c * b₁ := by
  calc
    b₂ = L₂ x := hx₂.symm
    _ = c * L₁ x := hscaled x
    _ = c * b₁ := by rw [hx₁]

/-- Parallel affine level sets with incompatible offsets are disjoint.
This is a genuine geometric statement about the event sets, derived directly
from their defining equations rather than from a free parallelism predicate. -/
theorem affine_events_disjoint_of_scaled_forms
    {K V : Type*} [Field K] [AddCommGroup V] [Module K V]
    (L₁ L₂ : V →ₗ[K] K) (c b₁ b₂ : K)
    (hscaled : ∀ x, L₂ x = c * L₁ x)
    (hoffset : b₂ ≠ c * b₁) :
    Disjoint {x : V | L₁ x = b₁} {x : V | L₂ x = b₂} := by
  apply Set.disjoint_left.mpr
  intro x hx₁ hx₂
  apply hoffset
  exact affine_overlap_forces_offset_relation L₁ L₂ c b₁ b₂
    hscaled x hx₁ hx₂

#print axioms affine_overlap_forces_offset_relation
#print axioms affine_events_disjoint_of_scaled_forms

end BBMSTAudit


/-!
## Linear-dependence consistency obstruction

For a family of affine equations, every linear dependence among the
coefficient forms imposes the same dependence among their offsets whenever
the affine system has a common point. This is a concrete necessary
consistency condition for intersections of many affine events. It does not
yet count solutions or establish the global BBMST sieve inequality.
-/

/-- A common point of affine level sets must respect every finite linear
relation among their defining linear forms. -/
theorem affine_intersection_respects_linear_relation
    {ι K V : Type*} [Field K] [AddCommGroup V] [Module K V]
    (L : ι → V →ₗ[K] K) (b c : ι → K)
    (s : Finset ι) (x : V)
    (hx : ∀ i ∈ s, L i x = b i)
    (hrel : ∑ i ∈ s, c i • L i = 0) :
    ∑ i ∈ s, c i * b i = 0 := by
  calc
    ∑ i ∈ s, c i * b i = ∑ i ∈ s, c i * L i x := by
      apply Finset.sum_congr rfl
      intro i hi
      rw [hx i hi]
    _ = (∑ i ∈ s, c i • L i) x := by
      simp [smul_eq_mul]
    _ = 0 := by
      rw [hrel]
      simp

#print axioms affine_intersection_respects_linear_relation


/--
If a finite family of affine equations has a linear dependence among its
coefficient forms but the offsets violate the same dependence, its common
solution set is empty. This packages the consistency obstruction as a direct
intersection-exclusion theorem.
-/
theorem affine_intersection_empty_of_inconsistent_linear_relation
    {ι K V : Type*} [Field K] [AddCommGroup V] [Module K V]
    (L : ι → V →ₗ[K] K) (b c : ι → K)
    (s : Finset ι)
    (hrel : ∑ i ∈ s, c i • L i = 0)
    (hbad : ∑ i ∈ s, c i * b i ≠ 0) :
    {x : V | ∀ i ∈ s, L i x = b i} = ∅ := by
  ext x
  simp only [Set.mem_setOf_eq, Set.mem_empty_iff_false]
  constructor
  · intro hx
    apply hbad
    exact affine_intersection_respects_linear_relation L b c s x hx hrel
  · intro hx
    exact False.elim hx

#print axioms affine_intersection_empty_of_inconsistent_linear_relation


/--
A nonempty affine fiber of a linear map is equivalent to its kernel.
The equivalence is translation by a chosen solution; hence every nonempty
fiber has exactly the same cardinality as the kernel whenever these types
are finite. This isolates the affine-to-linear reduction needed before
applying rank-nullity to finite-field solution counts.
-/
def affineFiberEquivKernel
    {K V W : Type*} [Field K]
    [AddCommGroup V] [Module K V]
    [AddCommGroup W] [Module K W]
    (T : V →ₗ[K] W) (b : W) (x0 : V)
    (hx0 : T x0 = b) :
    {x : V // T x = b} ≃ {v : V // T v = 0} where
  toFun x := ⟨x.1 - x0, by
    rw [map_sub, x.2, hx0, sub_self]⟩
  invFun v := ⟨v.1 + x0, by
    rw [map_add, v.2, hx0, zero_add]⟩
  left_inv x := by
    apply Subtype.ext
    simp
  right_inv v := by
    apply Subtype.ext
    simp

#print axioms affineFiberEquivKernel


theorem affineFiber_card_eq_kernel_card
    {K V W : Type*} [Field K]
    [AddCommGroup V] [Module K V]
    [AddCommGroup W] [Module K W]
    (T : V →ₗ[K] W) (b : W) (x0 : V)
    (hx0 : T x0 = b) :
    Nat.card {x : V // T x = b} =
      Nat.card {v : V // T v = 0} :=
  Nat.card_congr (affineFiberEquivKernel T b x0 hx0)

#print axioms affineFiber_card_eq_kernel_card


/--
The homogeneous fiber is the carrier of the linear-map kernel, expressed as
an explicit equivalence so that finite-dimensional cardinality theorems apply.
-/
def homogeneousFiberEquivKernelSubmodule
    {K V W : Type*} [Field K]
    [AddCommGroup V] [Module K V]
    [AddCommGroup W] [Module K W]
    (T : V →ₗ[K] W) :
    {v : V // T v = 0} ≃ ↥(LinearMap.ker T) where
  toFun v := ⟨v.1, LinearMap.mem_ker.mpr v.2⟩
  invFun v := ⟨v.1, LinearMap.mem_ker.mp v.2⟩
  left_inv v := by
    apply Subtype.ext
    rfl
  right_inv v := by
    apply Subtype.ext
    rfl

/--
Exact finite-field count for a consistent affine fiber: its cardinality is
q raised to the dimension of the kernel. This is the finite-dimensional
linear-algebra bridge needed before converting affine intersections into
probabilities. It is not by itself the BBMST global sieve theorem.
-/
theorem affineFiber_card_eq_field_card_pow_finrank_ker
    {K V W : Type*} [Field K] [Fintype K] [Fintype V] [Fintype W]
    [AddCommGroup V] [Module K V]
    [AddCommGroup W] [Module K W]
    (T : V →ₗ[K] W) (b : W) (x0 : V)
    (hx0 : T x0 = b)
    [Fintype {x : V // T x = b}]
    [Fintype {v : V // T v = 0}] :
    Fintype.card {x : V // T x = b} =
      Fintype.card K ^ Module.finrank K (LinearMap.ker T) := by
  classical
  have hfiber :
      Fintype.card {x : V // T x = b} =
        Fintype.card {v : V // T v = 0} :=
    Fintype.card_congr (affineFiberEquivKernel T b x0 hx0)
  have hker :
      Fintype.card {v : V // T v = 0} =
        Fintype.card (↥(LinearMap.ker T)) :=
    Fintype.card_congr (homogeneousFiberEquivKernelSubmodule T)
  rw [hfiber, hker]
  exact Module.card_eq_pow_finrank

#print axioms homogeneousFiberEquivKernelSubmodule
#print axioms affineFiber_card_eq_field_card_pow_finrank_ker


/--
Rank-nullity form of the affine-fiber count: over a finite field, a
consistent system T x = b has exactly q^(dim V - rank T) solutions.
This is the exact finite-field cardinality needed to turn affine-event
intersections into probabilities. It still does not establish the global
BBMST overlap or sieve estimate.
-/
theorem affineFiber_card_eq_field_card_pow_finrank_sub_range
    {K V W : Type*} [Field K] [Fintype K] [Fintype V] [Fintype W]
    [AddCommGroup V] [Module K V]
    [AddCommGroup W] [Module K W]
    (T : V →ₗ[K] W) (b : W) (x0 : V)
    (hx0 : T x0 = b)
    [Fintype {x : V // T x = b}] :
    Fintype.card {x : V // T x = b} =
      Fintype.card K ^
        (Module.finrank K V - Module.finrank K (LinearMap.range T)) := by
  classical
  letI : Fintype {v : V // T v = 0} := Fintype.ofFinite _
  rw [affineFiber_card_eq_field_card_pow_finrank_ker T b x0 hx0]
  have hdim := T.finrank_range_add_finrank_ker
  have hker :
      Module.finrank K (LinearMap.ker T) =
        Module.finrank K V - Module.finrank K (LinearMap.range T) := by
    omega
  rw [hker]

#print axioms affineFiber_card_eq_field_card_pow_finrank_sub_range


namespace BBMSTAudit

/--
The multiplier gap, weighted by the covered fraction, is independent of that
fraction: on the active branch α > δ, the aggregate covered-fiber weight
deficit is exactly δ/(1-δ). This isolates the part of the scalar update that
could feed a later global contraction estimate; it does not itself bound
intersections of distinct affine events.
-/
theorem fiber_update_weighted_multiplier_gap
    (α δ : ℚ)
    (hα0 : 0 ≤ α)
    (hδ0 : 0 ≤ δ)
    (hδhalf : δ ≤ (1 / 2 : ℚ))
    (hactive : δ < α) :
    α * (1 / (1 - δ) -
        (α - δ) / (α * (1 - δ))) = δ / (1 - δ) := by
  rw [fiber_update_multiplier_gap α δ hα0 hδ0 hδhalf hactive]
  have hαpos : 0 < α := lt_of_le_of_lt hδ0 hactive
  have hδlt : δ < 1 := lt_of_le_of_lt hδhalf (by norm_num)
  field_simp [ne_of_gt hαpos, ne_of_gt (sub_pos.mpr hδlt)]
  <;> ring

#print axioms fiber_update_weighted_multiplier_gap

end BBMSTAudit
