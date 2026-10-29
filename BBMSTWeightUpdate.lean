import Mathlib
import BBMSTCoordinateStage

/-!
# Source-faithful BBMST weight update

This module encodes the two branches of the fiber sieve in Lemma 2.1
(Balister–Bollobás–Morris–Sahasrabudhe–Tiba, 2021, pp. 612–613).

The old mass at x is extended uniformly over S. The multiplier then depends
on whether alpha(x) ≤ delta or alpha(x) > delta. This is only the local
definition; normalization and distortion bounds remain separate proof goals.
-/

namespace BBMSTWeightUpdate

open BBMSTCoordinateStage

variable {X S : Type*} [Fintype X] [Fintype S]


/-- The source parameter range for a BBMST sieve stage. -/
def ValidDelta (delta : ℚ) : Prop := 0 ≤ delta ∧ delta ≤ (1 / 2 : ℚ)

/-- The exact local multiplier prescribed by Lemma 2.1. -/
noncomputable def multiplier
    (C : CoordinateStage X S) (delta : ℚ)
    (x : X) (s : S) : ℚ := by
  classical
  exact if alpha C x ≤ delta then
    if C.exceptional x s then 0 else 1 / (1 - alpha C x)
  else
    if C.exceptional x s then
      (alpha C x - delta) / (alpha C x * (1 - delta))
    else
      1 / (1 - delta)

/-- The same local update written in terms of the exceptional-fiber probability. -/
noncomputable def probabilityMultiplier
    (C : CoordinateStage X S) (delta : ℚ)
    (x : X) (s : S) : ℚ := by
  classical
  exact if exceptionalMass C x ≤ delta then
    if C.exceptional x s then 0 else 1 / (1 - exceptionalMass C x)
  else
    if C.exceptional x s then
      (exceptionalMass C x - delta) /
        (exceptionalMass C x * (1 - delta))
    else
      1 / (1 - delta)

theorem probabilityMultiplier_eq_multiplier
    (C : CoordinateStage X S) (delta : ℚ) (x : X) (s : S) :
    probabilityMultiplier C delta x s = multiplier C delta x s := by
  classical
  simp [probabilityMultiplier, multiplier, exceptionalMass_eq_alpha]

#print axioms probabilityMultiplier_eq_multiplier

/-- New point weight after uniformly extending the old weight over S and
applying the source's local multiplier. -/
noncomputable def updatedWeight
    (C : CoordinateStage X S) (w : X → ℚ) (delta : ℚ)
    (x : X) (s : S) : ℚ :=
  (w x / (Fintype.card S : ℚ)) * multiplier C delta x s

theorem one_sub_alpha_pos_of_alpha_le_delta
    (C : CoordinateStage X S) (delta : ℚ) (x : X)
    (hdelta : ValidDelta delta) (h : alpha C x ≤ delta) :
    0 < 1 - alpha C x := by
  have ha := alpha_nonneg C x
  have hhalf : alpha C x ≤ (1 / 2 : ℚ) := le_trans h hdelta.2
  linarith

theorem alpha_pos_of_delta_lt_alpha
    (C : CoordinateStage X S) (delta : ℚ) (x : X)
    (hdelta : ValidDelta delta) (h : delta < alpha C x) :
    0 < alpha C x := by
  linarith [hdelta.1]

theorem one_sub_delta_pos
    (delta : ℚ) (hdelta : ValidDelta delta) :
    0 < 1 - delta := by
  linarith [hdelta.2]

theorem multiplier_nonneg
    (C : CoordinateStage X S) (delta : ℚ) (x : X) (s : S)
    (hdelta : ValidDelta delta) :
    0 ≤ multiplier C delta x s := by
  classical
  unfold multiplier
  split_ifs with hbranch hex
  · norm_num
  · have hden : 0 < 1 - alpha C x :=
      one_sub_alpha_pos_of_alpha_le_delta C delta x hdelta hbranch
    positivity
  · have hαδ : delta < alpha C x := lt_of_not_ge hbranch
    have hα : 0 < alpha C x :=
      alpha_pos_of_delta_lt_alpha C delta x hdelta hαδ
    have hden : 0 < alpha C x * (1 - delta) :=
      mul_pos hα (one_sub_delta_pos delta hdelta)
    have hnum : 0 ≤ alpha C x - delta := sub_nonneg.mpr (le_of_lt hαδ)
    positivity
  · exact le_of_lt (by
      have hden : 0 < 1 - delta := one_sub_delta_pos delta hdelta
      positivity)

/-- The exceptional-fiber count is exactly alpha times the coordinate
cardinality. This is the counting identity needed to turn the source's
fractional update into finite-sum algebra. -/
theorem exceptionalFiber_card_eq_alpha_mul_card
    (C : CoordinateStage X S) (x : X) :
    ((exceptionalFiber C x).card : ℚ) =
      alpha C x * (Fintype.card S : ℚ) := by
  unfold alpha
  have hcard : (Fintype.card S : ℚ) ≠ 0 := by
    exact_mod_cast (ne_of_gt (coordinate_card_pos C))
  field_simp

open Classical in
/-- Split a finite sum over the exceptional fiber and its complement. -/
theorem sum_split_exceptional
    (C : CoordinateStage X S) (x : X) (f : S → ℚ) :
    (∑ s : S, f s) =
      (∑ s ∈ Finset.univ.filter (fun s => C.exceptional x s), f s) +
      (∑ s ∈ Finset.univ.filter (fun s => ¬ C.exceptional x s), f s) := by
  classical
  simpa using
    (Finset.sum_filter_add_sum_filter_not
      (s := Finset.univ) (p := fun s : S => C.exceptional x s) (f := f)).symm

open Classical in
/-- In the first BBMST branch, the exceptional extensions receive zero
multiplier and every nonexceptional extension receives the common factor
1 / (1 - alpha). This is the pointwise reduction used by the local-mass proof. -/
theorem multiplier_eq_first_branch
    (C : CoordinateStage X S) (delta : ℚ) (x : X)
    (h : alpha C x ≤ delta) (s : S) :
    multiplier C delta x s =
      if C.exceptional x s then 0 else 1 / (1 - alpha C x) := by
  simp [multiplier, h]

/-- The mass on one coordinate fiber after the update. The next theorem
will show that this equals the incoming mass w x. -/
noncomputable def localMass
    (C : CoordinateStage X S) (w : X → ℚ) (delta : ℚ) (x : X) : ℚ :=
  ∑ s : S, updatedWeight C w delta x s

/-- In the first branch, the updated mass on a coordinate fiber equals
the incoming mass. This is the local conservation identity for alpha <= delta. -/
theorem localMass_eq_of_alpha_le_delta
    (C : CoordinateStage X S) (w : X → ℚ) (delta : ℚ) (x : X)
    (hdelta : ValidDelta delta) (h : alpha C x ≤ delta) :
    localMass C w delta x = w x := by
  classical
  unfold localMass updatedWeight
  rw [sum_split_exceptional C x
    (fun s : S => (w x / (Fintype.card S : ℚ)) * multiplier C delta x s)]
  have hα : 1 - alpha C x ≠ 0 :=
    ne_of_gt (one_sub_alpha_pos_of_alpha_le_delta C delta x hdelta h)
  have hS : (Fintype.card S : ℚ) ≠ 0 := by
    exact_mod_cast (ne_of_gt (coordinate_card_pos C))
  have hcard := exceptionalFiber_card_eq_alpha_mul_card C x
  have hcomp :
      ((Finset.univ.filter (fun s : S => ¬ C.exceptional x s)).card : ℚ) =
        (1 - alpha C x) * (Fintype.card S : ℚ) := by
    have htotalNat :
        (Finset.univ.filter (fun s : S => ¬ C.exceptional x s)).card +
          (exceptionalFiber C x).card = Fintype.card S := by
      have htotal := Finset.card_filter_add_card_filter_not
        (s := Finset.univ) (p := fun s : S => C.exceptional x s)
      simpa [exceptionalFiber, add_comm] using htotal
    have htotal :
        ((Finset.univ.filter (fun s : S => ¬ C.exceptional x s)).card : ℚ) +
          ((exceptionalFiber C x).card : ℚ) = (Fintype.card S : ℚ) := by
      exact_mod_cast htotalNat
    rw [hcard] at htotal
    nlinarith
  have hexzero :
      (∑ s ∈ Finset.univ.filter (fun s : S => C.exceptional x s),
        (w x / (Fintype.card S : ℚ)) * multiplier C delta x s) = 0 := by
    apply Finset.sum_eq_zero
    intro s hs
    have hsx : C.exceptional x s := (Finset.mem_filter.mp hs).2
    rw [multiplier_eq_first_branch C delta x h s]
    simp [hsx]
  have hnonexceptional :
      (∑ s ∈ Finset.univ.filter (fun s : S => ¬ C.exceptional x s),
        (w x / (Fintype.card S : ℚ)) * multiplier C delta x s) =
        ((Finset.univ.filter (fun s : S => ¬ C.exceptional x s)).card : ℚ) *
          ((w x / (Fintype.card S : ℚ)) * (1 / (1 - alpha C x))) := by
    calc
      (∑ s ∈ Finset.univ.filter (fun s : S => ¬ C.exceptional x s),
          (w x / (Fintype.card S : ℚ)) * multiplier C delta x s) =
        ∑ s ∈ Finset.univ.filter (fun s : S => ¬ C.exceptional x s),
          (w x / (Fintype.card S : ℚ)) * (1 / (1 - alpha C x)) := by
            apply Finset.sum_congr rfl
            intro s hs
            have hsx : ¬ C.exceptional x s := (Finset.mem_filter.mp hs).2
            rw [multiplier_eq_first_branch C delta x h s]
            simp [hsx]
      _ = _ := by simp
  rw [hexzero, hnonexceptional, hcomp]
  field_simp
  ring


open Classical in
/-- In the second branch, both classes receive their prescribed constant
multipliers: the exceptional fiber gets (alpha - delta)/(alpha*(1-delta)),
and its complement gets 1/(1-delta). -/
theorem multiplier_eq_second_branch
    (C : CoordinateStage X S) (delta : ℚ) (x : X)
    (h : delta < alpha C x) (s : S) :
    multiplier C delta x s =
      if C.exceptional x s then
        (alpha C x - delta) / (alpha C x * (1 - delta))
      else 1 / (1 - delta) := by
  classical
  simp [multiplier, not_le_of_gt h]

/-- In the second BBMST branch, the updated mass on a coordinate fiber
also equals the incoming mass. This completes local conservation for both
branches of the source multiplier. -/
theorem localMass_eq_of_delta_lt_alpha
    (C : CoordinateStage X S) (w : X → ℚ) (delta : ℚ) (x : X)
    (hdelta : ValidDelta delta) (h : delta < alpha C x) :
    localMass C w delta x = w x := by
  classical
  unfold localMass updatedWeight
  rw [sum_split_exceptional C x
    (fun s : S => (w x / (Fintype.card S : ℚ)) * multiplier C delta x s)]
  have hα : 0 < alpha C x :=
    alpha_pos_of_delta_lt_alpha C delta x hdelta h
  have hαne : alpha C x ≠ 0 := ne_of_gt hα
  have hδ : 0 < 1 - delta := one_sub_delta_pos delta hdelta
  have hδne : 1 - delta ≠ 0 := ne_of_gt hδ
  have hden : alpha C x * (1 - delta) ≠ 0 :=
    ne_of_gt (mul_pos hα hδ)
  have hS : (Fintype.card S : ℚ) ≠ 0 := by
    exact_mod_cast (ne_of_gt (coordinate_card_pos C))
  have hcard := exceptionalFiber_card_eq_alpha_mul_card C x
  have hcomp :
      ((Finset.univ.filter (fun s : S => ¬ C.exceptional x s)).card : ℚ) =
        (1 - alpha C x) * (Fintype.card S : ℚ) := by
    have htotalNat :
        (Finset.univ.filter (fun s : S => ¬ C.exceptional x s)).card +
          (exceptionalFiber C x).card = Fintype.card S := by
      have htotal := Finset.card_filter_add_card_filter_not
        (s := Finset.univ) (p := fun s : S => C.exceptional x s)
      simpa [exceptionalFiber, add_comm] using htotal
    have htotal :
        ((Finset.univ.filter (fun s : S => ¬ C.exceptional x s)).card : ℚ) +
          ((exceptionalFiber C x).card : ℚ) = (Fintype.card S : ℚ) := by
      exact_mod_cast htotalNat
    rw [hcard] at htotal
    nlinarith
  have hexceptional :
      (∑ s ∈ Finset.univ.filter (fun s : S => C.exceptional x s),
        (w x / (Fintype.card S : ℚ)) * multiplier C delta x s) =
        ((exceptionalFiber C x).card : ℚ) *
          ((w x / (Fintype.card S : ℚ)) *
            ((alpha C x - delta) / (alpha C x * (1 - delta))) ) := by
    calc
      (∑ s ∈ Finset.univ.filter (fun s : S => C.exceptional x s),
          (w x / (Fintype.card S : ℚ)) * multiplier C delta x s) =
        ∑ s ∈ Finset.univ.filter (fun s : S => C.exceptional x s),
          (w x / (Fintype.card S : ℚ)) *
            ((alpha C x - delta) / (alpha C x * (1 - delta))) := by
              apply Finset.sum_congr rfl
              intro s hs
              have hsx : C.exceptional x s := (Finset.mem_filter.mp hs).2
              rw [multiplier_eq_second_branch C delta x h s]
              simp [hsx]
      _ = _ := by simp
  have hnonexceptional :
      (∑ s ∈ Finset.univ.filter (fun s : S => ¬ C.exceptional x s),
        (w x / (Fintype.card S : ℚ)) * multiplier C delta x s) =
        ((Finset.univ.filter (fun s : S => ¬ C.exceptional x s)).card : ℚ) *
          ((w x / (Fintype.card S : ℚ)) * (1 / (1 - delta))) := by
    calc
      (∑ s ∈ Finset.univ.filter (fun s : S => ¬ C.exceptional x s),
          (w x / (Fintype.card S : ℚ)) * multiplier C delta x s) =
        ∑ s ∈ Finset.univ.filter (fun s : S => ¬ C.exceptional x s),
          (w x / (Fintype.card S : ℚ)) * (1 / (1 - delta)) := by
            apply Finset.sum_congr rfl
            intro s hs
            have hsx : ¬ C.exceptional x s := (Finset.mem_filter.mp hs).2
            rw [multiplier_eq_second_branch C delta x h s]
            simp [hsx]
      _ = _ := by simp
  have hfiltercard :
      (Finset.univ.filter (fun s : S => C.exceptional x s)).card =
        (exceptionalFiber C x).card := by
    simp [exceptionalFiber]
  rw [hexceptional, hnonexceptional, hcard, hcomp]
  field_simp [hS, hden, hδne, hαne, hfiltercard]
  <;> ring

/-- The second-branch conservation statement using the actual
exceptional-fiber probability as the condition. -/
theorem localMass_eq_of_exceptionalMass_gt_delta
    (C : CoordinateStage X S) (w : X → ℚ) (delta : ℚ) (x : X)
    (hdelta : ValidDelta delta)
    (h : delta < exceptionalMass C x) :
    localMass C w delta x = w x := by
  apply localMass_eq_of_delta_lt_alpha C w delta x hdelta
  simpa [exceptionalMass_eq_alpha] using h

#print axioms localMass_eq_of_delta_lt_alpha
#print axioms localMass_eq_of_exceptionalMass_gt_delta

/-- Local conservation expressed using the actual exceptional-fiber
probability as the branch condition. The existing update rule is retained;
exceptionalMass_eq_alpha transports the condition to the source parameter. -/
theorem localMass_eq_of_exceptionalMass_le_delta
    (C : CoordinateStage X S) (w : X → ℚ) (delta : ℚ) (x : X)
    (hdelta : ValidDelta delta)
    (h : exceptionalMass C x ≤ delta) :
    localMass C w delta x = w x := by
  apply localMass_eq_of_alpha_le_delta C w delta x hdelta
  simpa [exceptionalMass_eq_alpha] using h

#print axioms localMass_eq_of_exceptionalMass_le_delta

#print axioms localMass_eq_of_alpha_le_delta

#print axioms one_sub_alpha_pos_of_alpha_le_delta
#print axioms alpha_pos_of_delta_lt_alpha
#print axioms one_sub_delta_pos
#print axioms multiplier_nonneg
#print axioms sum_split_exceptional
#print axioms multiplier_eq_first_branch

end BBMSTWeightUpdate
