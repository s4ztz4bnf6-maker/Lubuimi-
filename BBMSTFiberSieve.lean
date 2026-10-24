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
    simp only [if_pos h]
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

end BBMSTAudit
