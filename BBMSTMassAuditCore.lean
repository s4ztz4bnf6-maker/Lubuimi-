import Mathlib

/-
Finite-mass algebra for the BBMST formalization.

This file proves only general finite-sum identities. It does not encode the
BBMST geometric hypotheses or claim the Erdős–Selfridge theorem.
-/

namespace BBMSTAudit

variable {α : Type*} [DecidableEq α]
variable (s t u : Finset α) (w : α → ℚ)

/-- A disjoint decomposition preserves the sum of arbitrary rational weights. -/
theorem mass_additive_of_disjoint (h : Disjoint s t) :
    (∑ x ∈ s ∪ t, w x) = (∑ x ∈ s, w x) + (∑ x ∈ t, w x) := by
  rw [Finset.sum_union h]

/-- The zero-weight case of finite-sum additivity, without any division. -/
theorem mass_additive_zero_of_disjoint (h : Disjoint s t)
    (hs : ∑ x ∈ s, w x = 0) (ht : ∑ x ∈ t, w x = 0) :
    (∑ x ∈ s ∪ t, w x) = 0 := by
  rw [Finset.sum_union h, hs, ht, add_zero]

/-
Mass of a finite carrier equals the sum of the masses of two disjoint
pieces when those pieces cover the carrier. No denominator or conditional
probability is introduced.
-/
theorem mass_partition (hdisj : Disjoint s t) (hcover : s ∪ t = u) :
    (∑ x ∈ u, w x) = (∑ x ∈ s, w x) + (∑ x ∈ t, w x) := by
  rw [← hcover, Finset.sum_union hdisj]


/--
Zero-mass fibers contain only zero-weight points, provided all point weights
are nonnegative. This ratio-free lemma is the safe branch for empty or
zero-mass fibers; it does not introduce conditional probabilities or divide
by the fiber mass.
-/
theorem point_weight_eq_zero_of_mass_eq_zero
    (s : Finset α) (w : α → ℚ)
    (hw : ∀ x ∈ s, 0 ≤ w x)
    (hsum : (∑ x ∈ s, w x) = 0) :
    ∀ x ∈ s, w x = 0 := by
  intro x hx
  have hle : w x ≤ ∑ y ∈ s, w y :=
    Finset.single_le_sum (fun y hy => hw y hy) hx
  rw [hsum] at hle
  linarith [hw x hx]


end BBMSTAudit


namespace BBMSTAudit

variable {α : Type*} [DecidableEq α]

/--
A strictly positive finite mass cannot be carried entirely by zero-weight
points. This is the ratio-free existence step needed before selecting a
positive-mass fiber; it avoids conditional probabilities and division by
a possibly zero denominator.
-/
theorem exists_positive_weight_of_positive_mass
    (s : Finset α) (w : α → ℚ)
    (hw : ∀ x ∈ s, 0 ≤ w x)
    (hs : 0 < ∑ x ∈ s, w x) :
    ∃ x ∈ s, 0 < w x := by
  by_contra h
  have hnot : ∀ x ∈ s, ¬ 0 < w x := by
    intro x hx
    intro hpos
    exact h ⟨x, hx, hpos⟩
  have hzero : ∀ x ∈ s, w x = 0 := by
    intro x hx
    have hle : w x ≤ 0 := le_of_not_gt (hnot x hx)
    linarith [hw x hx]
  have hsum : (∑ x ∈ s, w x) = 0 := by
    apply Finset.sum_eq_zero
    intro x hx
    exact hzero x hx
  linarith

#print axioms exists_positive_weight_of_positive_mass


end BBMSTAudit


namespace BBMSTAudit

variable {α : Type*} [DecidableEq α]

/--
For a finite carrier with nonnegative point weights, positive total mass is
equivalent to the existence of a positive-weight point. This packages both
directions into one interface for later fiber arguments and keeps the proof
division-free.
-/
theorem mass_pos_iff_exists_positive_weight
    (s : Finset α) (w : α → ℚ)
    (hw : ∀ x ∈ s, 0 ≤ w x) :
    0 < ∑ x ∈ s, w x ↔ ∃ x ∈ s, 0 < w x := by
  constructor
  · exact exists_positive_weight_of_positive_mass s w hw
  · rintro ⟨x, hx, hpos⟩
    have hle : w x ≤ ∑ y ∈ s, w y :=
      Finset.single_le_sum (fun y hy => hw y hy) hx
    linarith

#print axioms mass_pos_iff_exists_positive_weight

end BBMSTAudit


/-! ## Typed BBMST stage parameters and safe quotient branch

The published sieve uses stage parameters in the range 0 ≤ δₖ ≤ 1/2.
A function indexed by Fin n makes stage alignment intrinsic, unlike a list
whose missing entries can be silently replaced by getD defaults. The
positive-denominator lemma justifies the quotient branch only when δₖ > 0;
the δₖ = 0 case must be handled separately in the sieve definition.
-/

namespace BBMSTAudit

/-- Stage-aligned parameters in the source interval [0, 1/2]. -/
structure IndexedStageParameters (n : ℕ) where
  delta : Fin n → ℚ
  nonneg : ∀ i, 0 ≤ delta i
  le_half : ∀ i, delta i ≤ (1 : ℚ) / 2

/-- The denominator in the second-moment quotient is positive on the
positive-parameter branch. -/
theorem bbmst_second_moment_denominator_pos
    (δ : ℚ) (hδ : 0 < δ) (hupper : δ ≤ (1 : ℚ) / 2) :
    0 < 4 * δ * (1 - δ) := by
  have hone : 0 < 1 - δ := by linarith
  positivity

/--
Source-faithful case split: within 0 ≤ δ ≤ 1/2, either δ is exactly zero
and must be handled by the zero branch, or the quotient denominator is
strictly positive. This prevents the δ = 0 / division-by-zero case from
being silently treated as an ordinary second-moment quotient.
-/
theorem bbmst_second_moment_denominator_cases
    (δ : ℚ) (hδ : 0 ≤ δ) (hupper : δ ≤ (1 : ℚ) / 2) :
    δ = 0 ∨ 0 < 4 * δ * (1 - δ) := by
  by_cases hzero : δ = 0
  · exact Or.inl hzero
  · right
    have hpos : 0 < δ := lt_of_le_of_ne hδ (Ne.symm hzero)
    exact bbmst_second_moment_denominator_pos δ hpos hupper

/-- Every indexed source parameter lies in the published interval. -/
theorem indexed_stage_parameter_range
    {n : ℕ} (p : IndexedStageParameters n) (i : Fin n) :
    0 ≤ p.delta i ∧ p.delta i ≤ (1 : ℚ) / 2 :=
  ⟨p.nonneg i, p.le_half i⟩

/-- The source interval permits δ = 0, but that case cannot enter a
quotient whose denominator is 4δ(1-δ). -/
theorem zero_parameter_denominator_zero :
    4 * (0 : ℚ) * (1 - 0) = 0 := by norm_num

#print axioms bbmst_second_moment_denominator_pos
#print axioms bbmst_second_moment_denominator_cases
#print axioms indexed_stage_parameter_range
#print axioms zero_parameter_denominator_zero

end BBMSTAudit
