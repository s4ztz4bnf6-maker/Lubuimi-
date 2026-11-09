import Mathlib

/-!
# APW4 / BIB finite incidence arithmetic checkpoint

This module formalizes the exact algebraic elimination step from the finite
incidence second-moment estimate recorded in
`BAB_BIB_Incidence_Bound_Lubuimi_2026-11-06.md`.

It does NOT construct the historical APW4 fibre labels, prove the incidence
hypotheses for a covering system, or transfer B(M) to APW4 energy. The
second-moment inequality is an explicit input, exactly as in that note.
-/

namespace APW4IncidenceSecondMoment

/--
Eliminate the auxiliary incidence total from
T ≥ r m₀, T² ≤ τ (T + μ m₀ (m₀ - 1)), τ ≤ 2r m₀, m₀ ≥ 1,
and r² > τ μ. The weaker size condition τ ≤ 2r m₀ suffices because
T + r m₀ - τ ≥ 2r m₀ - τ ≥ 0. The condition μ < r from H2 is not
needed here.
-/
theorem incidence_bound_from_second_moment
    (T r μ τ m₀ : ℝ)
    (hr : 0 ≤ r)
    (hT : r * m₀ ≤ T)
    (hTau : τ ≤ 2 * r * m₀)
    (hm₀ : 1 ≤ m₀)
    (hSecond :
      T ^ 2 ≤ τ * (T + μ * m₀ * (m₀ - 1)))
    (hDen : τ * μ < r ^ 2) :
    m₀ ≤ τ * (r - μ) / (r ^ 2 - τ * μ) := by
  have hTnonneg : 0 ≤ T - r * m₀ := by
    linarith
  have hFactor : 0 ≤ T + r * m₀ - τ := by
    nlinarith
  have hProduct :
      0 ≤ (T - r * m₀) * (T + r * m₀ - τ) :=
    mul_nonneg hTnonneg hFactor
  have hm₀pos : 0 < m₀ := by
    linarith
  have hMul :
      m₀ * ((r ^ 2 - τ * μ) * m₀ - τ * (r - μ)) ≤ 0 := by
    nlinarith [hProduct, hSecond]
  have hLinear :
      (r ^ 2 - τ * μ) * m₀ ≤ τ * (r - μ) := by
    by_contra h
    have hPos :
        0 < (r ^ 2 - τ * μ) * m₀ - τ * (r - μ) := by
      linarith
    have hContradiction :
        0 < m₀ * ((r ^ 2 - τ * μ) * m₀ - τ * (r - μ)) :=
      mul_pos hm₀pos hPos
    linarith
  have hDenPos : 0 < r ^ 2 - τ * μ := by
    linarith
  have hLinear' : m₀ * (r ^ 2 - τ * μ) ≤ τ * (r - μ) := by
    nlinarith [hLinear]
  exact (le_div_iff₀ hDenPos).2 hLinear'

/--
A strengthened version of the finite incidence bound. The factor argument
only needs τ ≤ 2 r m₀, not τ ≤ 2 r together with m₀ ≥ 1. In particular,
the side condition μ < r is redundant once τ μ < r² and m₀ > 0.
-/
theorem incidence_bound_from_second_moment_scaled_tau
    (T r μ τ m₀ : ℝ)
    (hT : r * m₀ ≤ T)
    (hTau : τ ≤ 2 * r * m₀)
    (hm₀ : 0 < m₀)
    (hSecond :
      T ^ 2 ≤ τ * (T + μ * m₀ * (m₀ - 1)))
    (hDen : τ * μ < r ^ 2) :
    m₀ ≤ τ * (r - μ) / (r ^ 2 - τ * μ) := by
  have hTnonneg : 0 ≤ T - r * m₀ := by
    linarith
  have hFactor : 0 ≤ T + r * m₀ - τ := by
    nlinarith
  have hProduct :
      0 ≤ (T - r * m₀) * (T + r * m₀ - τ) :=
    mul_nonneg hTnonneg hFactor
  have hMul :
      m₀ * ((r ^ 2 - τ * μ) * m₀ - τ * (r - μ)) ≤ 0 := by
    nlinarith [hProduct, hSecond]
  have hLinear :
      (r ^ 2 - τ * μ) * m₀ ≤ τ * (r - μ) := by
    by_contra h
    have hPos :
        0 < (r ^ 2 - τ * μ) * m₀ - τ * (r - μ) := by
      linarith
    have hContradiction :
        0 < m₀ * ((r ^ 2 - τ * μ) * m₀ - τ * (r - μ)) :=
      mul_pos hm₀ hPos
    linarith
  have hDenPos : 0 < r ^ 2 - τ * μ := by
    linarith
  have hLinear' : m₀ * (r ^ 2 - τ * μ) ≤ τ * (r - μ) := by
    nlinarith [hLinear]
  exact (le_div_iff₀ hDenPos).2 hLinear'

#print axioms incidence_bound_from_second_moment_scaled_tau

/--
The exact off-diagonal consequence of the APW4 energy decomposition and
the diagonal transport: a strict total-energy lower bound forces the
off-diagonal mass to exceed the BIB reserve.
-/
theorem offDiagonal_exceeds_reserve
    (E D C Dk R : ℝ)
    (hEnergy : E = D + C)
    (hDiagonal : D ≤ Dk)
    (hStrict : Dk + R < E) :
    R < C := by
  linarith

/--
The final APW4 contradiction, conditional on the separately established
strict lower bound, diagonal transport, and weighted Hall transport.
-/
theorem apw4_energy_contradiction
    (E D C Dk R : ℝ)
    (hEnergy : E = D + C)
    (hDiagonal : D ≤ Dk)
    (hHall : C ≤ R)
    (hStrict : Dk + R < E) :
    False := by
  have hOffDiagonal :
      R < C :=
    offDiagonal_exceeds_reserve E D C Dk R hEnergy hDiagonal hStrict
  linarith

#print axioms incidence_bound_from_second_moment
#print axioms offDiagonal_exceeds_reserve
#print axioms apw4_energy_contradiction

end APW4IncidenceSecondMoment
