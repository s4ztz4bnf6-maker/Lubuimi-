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
  · have hα : 0 < alpha C x :=
      alpha_pos_of_delta_lt_alpha C delta x hdelta (lt_of_not_ge hbranch)
    have hden : 0 < alpha C x * (1 - delta) :=
      mul_pos hα (one_sub_delta_pos delta hdelta)
    have hnum : 0 ≤ alpha C x - delta :=
      le_of_lt (lt_of_not_ge hbranch)
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

/-- The mass on one coordinate fiber after the update. The next theorem
will show that this equals the incoming mass w x. -/
noncomputable def localMass
    (C : CoordinateStage X S) (w : X → ℚ) (delta : ℚ) (x : X) : ℚ :=
  ∑ s : S, updatedWeight C w delta x s

#print axioms one_sub_alpha_pos_of_alpha_le_delta
#print axioms alpha_pos_of_delta_lt_alpha
#print axioms one_sub_delta_pos
#print axioms multiplier_nonneg

end BBMSTWeightUpdate
