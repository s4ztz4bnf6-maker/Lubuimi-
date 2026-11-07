import Mathlib

/-!
# BBMST finite-fibre measure update: zero-safe scalar core

The two multipliers are defined by the source's actual branch condition
a ≤ δ. Thus the covered multiplier never evaluates a quotient at a = 0,
and the uncovered multiplier never evaluates 1/(1-a) at a = 1.
This file proves exact fibre-mass conservation and positivity only; it does
not yet construct the full probability measure on the product box.
-/

namespace BBMSTFiberMeasureCore

/-- Weight multiplier on covered points in a fibre of covered proportion a. -/
def coveredMultiplier (a δ : ℚ) : ℚ :=
  if a ≤ δ then 0 else (a - δ) / (a * (1 - δ))

/-- Weight multiplier on uncovered points in a fibre of covered proportion a. -/
def uncoveredMultiplier (a δ : ℚ) : ℚ :=
  if a ≤ δ then 1 / (1 - a) else 1 / (1 - δ)

/-- The covered multiplier is nonnegative on the source parameter range. -/
theorem coveredMultiplier_nonneg {a δ : ℚ}
    (ha : 0 ≤ a) (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    0 ≤ coveredMultiplier a δ := by
  by_cases h : a ≤ δ
  · simp [coveredMultiplier, h]
  · have hlt : δ < a := lt_of_not_ge h
    have hnum : 0 < a - δ := sub_pos.mpr hlt
    have hden : 0 < a * (1 - δ) := by
      apply mul_pos
      · exact lt_of_le_of_lt hδ hlt
      · linarith
    simp [coveredMultiplier, h]
    exact le_of_lt (div_pos hnum hden)

/-- The uncovered multiplier is positive on the source parameter range. -/
theorem uncoveredMultiplier_pos {a δ : ℚ}
    (ha : 0 ≤ a) (ha1 : a ≤ 1)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    0 < uncoveredMultiplier a δ := by
  by_cases h : a ≤ δ
  · have hden : 0 < 1 - a := by linarith
    simp only [uncoveredMultiplier, if_pos h]
    exact one_div_pos.mpr hden
  · have hden : 0 < 1 - δ := by linarith
    simp only [uncoveredMultiplier, if_neg h]
    exact one_div_pos.mpr hden

/-- Exact conservation of the total mass in one fibre. -/
theorem fibreMultiplier_mass_one {a δ : ℚ}
    (ha : 0 ≤ a) (ha1 : a ≤ 1)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    a * coveredMultiplier a δ +
      (1 - a) * uncoveredMultiplier a δ = 1 := by
  by_cases h : a ≤ δ
  · have hden : 1 - a ≠ 0 := by
      have : a < 1 := lt_of_le_of_lt h (by linarith)
      linarith
    simp [coveredMultiplier, uncoveredMultiplier, h]
    field_simp
  · have hlt : δ < a := lt_of_not_ge h
    have ha0 : a ≠ 0 := ne_of_gt (lt_of_le_of_lt hδ hlt)
    have hδden : 1 - δ ≠ 0 := by linarith
    simp [coveredMultiplier, uncoveredMultiplier, h]
    field_simp [ha0, hδden]
    ring

/-- The update preserves the old total mass of every fibre, including
empty and fully covered fibres. -/
theorem updatedFibreMass_eq_old {w a δ : ℚ}
    (ha : 0 ≤ a) (ha1 : a ≤ 1)
    (hδ : 0 ≤ δ) (hδhalf : δ ≤ (1 / 2 : ℚ)) :
    (w * a) * coveredMultiplier a δ +
      (w * (1 - a)) * uncoveredMultiplier a δ = w := by
  calc
    (w * a) * coveredMultiplier a δ +
        (w * (1 - a)) * uncoveredMultiplier a δ
      = w * (a * coveredMultiplier a δ +
          (1 - a) * uncoveredMultiplier a δ) := by ring
    _ = w := by rw [fibreMultiplier_mass_one ha ha1 hδ hδhalf]; ring

/-- At zero distortion the uncovered multiplier is one; no zero denominator
is evaluated even when a = 0. -/
theorem uncoveredMultiplier_zero_distortion {a : ℚ}
    (ha : 0 ≤ a) (ha1 : a ≤ 1) :
    uncoveredMultiplier a 0 = 1 := by
  by_cases h : a ≤ 0
  · have ha0 : a = 0 := le_antisymm h ha
    simp [uncoveredMultiplier, ha0]
  · have hpos : 0 < a := lt_of_not_ge h
    simp [uncoveredMultiplier, h]

/-- At positive covered proportion and zero distortion, covered points keep
their original weight. -/
theorem coveredMultiplier_zero_distortion {a : ℚ}
    (ha : 0 < a) :
    coveredMultiplier a 0 = 1 := by
  have hnot : ¬ a ≤ 0 := not_le.mpr ha
  have ha0 : a ≠ 0 := ne_of_gt ha
  simp only [coveredMultiplier, if_neg hnot]
  field_simp [ha0] <;> ring

#print axioms coveredMultiplier_nonneg
#print axioms uncoveredMultiplier_pos
#print axioms fibreMultiplier_mass_one
#print axioms updatedFibreMass_eq_old
#print axioms uncoveredMultiplier_zero_distortion
#print axioms coveredMultiplier_zero_distortion

end BBMSTFiberMeasureCore
