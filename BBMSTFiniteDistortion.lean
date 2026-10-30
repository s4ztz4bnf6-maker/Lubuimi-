import Mathlib

/-!
# BBMST finite distortion: exact scalar fibre normalization

This module isolates the interior scalar calculation in equations (2)--(3)
of Balister--Bollobás--Morris--Sahasrabudhe--Tiba (2021), Lemma 2.1.
It is deliberately independent of the abstract sieve-stage interfaces.

The endpoint fibres are kept separate: when alpha = 0 or alpha = 1,
one of the two fibre branches is empty.  This first milestone proves the
normalization identity on nonempty two-branch fibres (0 < alpha < 1).
No geometric hyperplane or global BBMST theorem is claimed here.
-/

namespace BBMSTFiniteDistortion

/-- The multiplier on the removed part of a fibre, exactly as in (3). -/
def removedMultiplier (a d : ℚ) : ℚ :=
  max 0 ((a - d) / (a * (1 - d)))

/-- The multiplier on the complement of a fibre, exactly as in (3). -/
def retainedMultiplier (a d : ℚ) : ℚ :=
  min (1 / (1 - a)) (1 / (1 - d))

/-- Interior scalar normalization: the two weighted fibre branches sum to one.
The hypotheses are precisely the interior part of the source parameter range. -/
theorem fibre_normalization_interior
    (a d : ℚ) (ha0 : 0 < a) (ha1 : a < 1)
    (hd0 : 0 ≤ d) (hd1 : d ≤ 1 / 2) :
    a * removedMultiplier a d +
      (1 - a) * retainedMultiplier a d = 1 := by
  have h1a : 0 < 1 - a := by linarith
  have h1d : 0 < 1 - d := by linarith
  by_cases had : a ≤ d
  · have hremoved : (a - d) / (a * (1 - d)) ≤ 0 := by
      apply div_nonpos_of_nonpos_of_nonneg
      · linarith
      · exact le_of_lt (mul_pos ha0 h1d)
    have hretained :
        1 / (1 - a) ≤ 1 / (1 - d) := by
      rw [div_le_div_iff₀ h1a h1d]
      nlinarith
    simp [removedMultiplier, retainedMultiplier,
      max_eq_left hremoved, min_eq_left hretained]
    field_simp
    ring
  · have hda : d < a := lt_of_not_ge had
    have hremoved : 0 ≤ (a - d) / (a * (1 - d)) := by
      apply div_nonneg
      · linarith
      · exact le_of_lt (mul_pos ha0 h1d)
    have hretained :
        1 / (1 - d) ≤ 1 / (1 - a) := by
      rw [div_le_div_iff₀ h1d h1a]
      nlinarith
    simp [removedMultiplier, retainedMultiplier,
      max_eq_right hremoved, min_eq_right hretained]
    field_simp
    ring

#print axioms fibre_normalization_interior

end BBMSTFiniteDistortion


/-- Endpoint normalization when the removed part of a fibre is empty. -/
theorem fibre_normalization_zero
    (d : ℚ) (hd0 : 0 ≤ d) (hd1 : d ≤ 1 / 2) :
    (0 : ℚ) * removedMultiplier 0 d +
      (1 - 0) * retainedMultiplier 0 d = 1 := by
  have h1d : 0 < 1 - d := by linarith
  have hbound : 1 ≤ 1 / (1 - d) := by
    rw [le_div_iff₀ h1d]
    nlinarith
  have hfirst : (1 : ℚ) / (1 - 0) = 1 := by norm_num
  have hmin :
      min (1 / (1 - 0)) (1 / (1 - d)) = 1 := by
    rw [hfirst, min_eq_left hbound]
  simp [removedMultiplier, retainedMultiplier, hmin]

/-- Endpoint normalization when the retained part of a fibre is empty.
The retained multiplier's totalized value is immaterial because its weight is zero. -/
theorem fibre_normalization_one
    (d : ℚ) (hd0 : 0 ≤ d) (hd1 : d ≤ 1 / 2) :
    (1 : ℚ) * removedMultiplier 1 d +
      (1 - 1) * retainedMultiplier 1 d = 1 := by
  have h1d : 1 - d ≠ 0 := ne_of_gt (by linarith)
  have hratio : (1 - d) / (1 * (1 - d)) = 1 := by
    field_simp
  simp [removedMultiplier, retainedMultiplier, hratio]
