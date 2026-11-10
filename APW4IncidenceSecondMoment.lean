import Mathlib

/-!
Verification note: this module is an explicit conditional algebraic
checkpoint. Its hypotheses are supplied as theorem arguments; this file
does not claim to derive the historical APW4 incidence hypotheses.
The dedicated APW4 canonical/paranoid workflows are required to verify
this module as part of the library roots.
-/


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
T ≥ r m₀, T² ≤ τ (T + μ m₀ (m₀ - 1)), τ ≤ 2r, m₀ ≥ 1,
and r² > τ μ. This is the exact rational bound in equation (6) of the
finite-incidence note. The condition μ < r from H2 is not needed here.
-/
theorem incidence_bound_from_second_moment
    (T r μ τ m₀ : ℝ)
    (hr : 0 ≤ r)
    (hT : r * m₀ ≤ T)
    (hTau : τ ≤ 2 * r)
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
