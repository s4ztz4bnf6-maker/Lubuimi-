import Mathlib

namespace BBMSTMomentBridge

variable {Y : Type*} [Fintype Y] [DecidableEq Y]

/-- The overlap of two point indicators is the indicator of equality. -/
theorem sum_pair_indicator (a b : Y) :
    (∑ y : Y,
      (if a = y then (1 : ℚ) else 0) *
      (if b = y then (1 : ℚ) else 0))
      = (if a = b then 1 else 0) := by
  classical
  by_cases h : a = b <;> simp [h]

#print axioms sum_pair_indicator

/-- A weighted overlap of two point indicators. -/
theorem sum_weighted_pair_indicator (a b : Y) (u v : ℚ) :
    (∑ y : Y,
      (if a = y then u else 0) *
      (if b = y then v else 0))
      = (if a = b then u * v else 0) := by
  classical
  by_cases h : a = b
  · subst b
    simp
  · simp [h]

#print axioms sum_weighted_pair_indicator

/-- The fiberwise second moment equals the sum over pairs with equal images. -/
theorem fiber_second_moment
    {X : Type*} [Fintype X] [DecidableEq X]
    (f : X → Y) (w : X → ℚ) :
    (∑ y : Y, (∑ x : X, if f x = y then w x else 0) ^ 2)
      = ∑ x : X, ∑ x' : X,
          (if f x = f x' then w x * w x' else 0) := by
  classical
  calc
    (∑ y : Y, (∑ x : X, if f x = y then w x else 0) ^ 2)
        = ∑ y : Y, ∑ x : X, ∑ x' : X,
            (if f x = y then w x else 0) *
              (if f x' = y then w x' else 0) := by
          congr 1
          funext y
          rw [pow_two, Finset.sum_mul]
          simp_rw [Finset.mul_sum]
    _ = ∑ x : X, ∑ y : Y, ∑ x' : X,
          (if f x = y then w x else 0) *
            (if f x' = y then w x' else 0) := by
          rw [Finset.sum_comm]
    _ = ∑ x : X, ∑ x' : X, ∑ y : Y,
          (if f x = y then w x else 0) *
            (if f x' = y then w x' else 0) := by
          congr 1
          funext x
          rw [Finset.sum_comm]
    _ = ∑ x : X, ∑ x' : X,
          (if f x = f x' then w x * w x' else 0) := by
          congr 1
          funext x
          congr 1
          funext x'
          exact sum_weighted_pair_indicator (f x) (f x') (w x) (w x')

#print axioms fiber_second_moment

/-- A geometric incidence relation represents equality of fibers exactly.
This is an interface only: the caller must prove the equivalence from the
actual geometric definitions; no geometric estimate is assumed here. -/
theorem fiber_second_moment_incidence
    {X : Type*} [Fintype X] [DecidableEq X]
    (f : X → Y) (w : X → ℚ)
    (incident : X → X → Prop) [DecidableRel incident]
    (h_incident : ∀ x x' : X, incident x x' ↔ f x = f x') :
    (∑ y : Y, (∑ x : X, if f x = y then w x else 0) ^ 2)
      = ∑ x : X, ∑ x' : X,
          (if incident x x' then w x * w x' else 0) := by
  classical
  rw [fiber_second_moment]
  apply Finset.sum_congr rfl
  intro x hx
  apply Finset.sum_congr rfl
  intro x' hx'
  simp [h_incident x x']

#print axioms fiber_second_moment_incidence


/-- Stage data with aligned block sizes and sieve parameters.  The common
index type prevents a missing delta from being silently replaced by a default. -/
structure StageParameters (n : Nat) where
  blockSize : Fin n → ℚ
  delta : Fin n → ℚ
  blockSize_pos : ∀ i, 0 < blockSize i
  delta_nonneg : ∀ i, 0 ≤ delta i
  delta_le_half : ∀ i, delta i ≤ (1 / 2 : ℚ)

/-- In the positive-delta branch, the second-moment denominator is strictly
positive.  The proof uses the explicit range 0 < delta ≤ 1/2. -/
theorem secondMomentDenominator_pos {n : Nat}
    (p : StageParameters n) (i : Fin n) (hδ : 0 < p.delta i) :
    0 < 4 * p.delta i * (1 - p.delta i) := by
  have htail : 0 < 1 - p.delta i := by
    have hhalf := p.delta_le_half i
    linarith
  have hfour : 0 < (4 : ℚ) := by norm_num
  exact mul_pos (mul_pos hfour hδ) htail

/-- A guarded stage contribution: at delta = 0, use only the first-moment
bound; the quotient is selected only when delta is positive. -/
def safeStageContribution (m1 m2 delta : ℚ) : ℚ :=
  if 0 < delta then min m1 (m2 / (4 * delta * (1 - delta))) else m1

theorem safeStageContribution_zero (m1 m2 : ℚ) :
    safeStageContribution m1 m2 0 = m1 := by
  simp [safeStageContribution]

theorem safeStageContribution_positive (m1 m2 delta : ℚ) (hδ : 0 < delta) :
    safeStageContribution m1 m2 delta =
      min m1 (m2 / (4 * delta * (1 - delta))) := by
  simp [safeStageContribution, hδ]


/-- The guarded contribution never exceeds the first-moment bound.
This remains true at delta = 0, where the quotient branch is not used. -/
theorem safeStageContribution_le_firstMoment (m1 m2 delta : ℚ) :
    safeStageContribution m1 m2 delta ≤ m1 := by
  by_cases hδ : 0 < delta
  · simp only [safeStageContribution, if_pos hδ]
    exact min_le_left _ _
  · simp [safeStageContribution, hδ]

/-- If both moment bounds are nonnegative and delta is in the admissible
range, the guarded contribution is nonnegative. -/
theorem safeStageContribution_nonneg
    (m1 m2 delta : ℚ) (hm1 : 0 ≤ m1) (hm2 : 0 ≤ m2)
    (hδhalf : delta ≤ (1 / 2 : ℚ)) :
    0 ≤ safeStageContribution m1 m2 delta := by
  by_cases hδ : 0 < delta
  · have hden : 0 < 4 * delta * (1 - delta) := by
      have htail : 0 < 1 - delta := by linarith
      have hfour : 0 < (4 : ℚ) := by norm_num
      exact mul_pos (mul_pos hfour hδ) htail
    have hquot : 0 ≤ m2 / (4 * delta * (1 - delta)) :=
      div_nonneg hm2 (le_of_lt hden)
    simp only [safeStageContribution, if_pos hδ]
    exact le_min hm1 hquot
  · simpa [safeStageContribution, hδ] using hm1


/-- Expand the cube of a finite sum into ordered triples. -/
theorem sum_cube_expand {X : Type*} [Fintype X] (g : X → ℚ) :
    (∑ x : X, g x) ^ 3 =
      ∑ x : X, ∑ x' : X, ∑ x'' : X,
        (g x * g x') * g x'' := by
  classical
  calc
    (∑ x : X, g x) ^ 3 =
        ((∑ x : X, g x) ^ 2) * (∑ x : X, g x) := by
          rw [pow_succ]
    _ = (∑ x : X, ∑ x' : X, g x * g x') *
          (∑ x : X, g x) := by
          rw [pow_two, Finset.sum_mul]
          simp_rw [Finset.mul_sum]
    _ = ∑ x : X, ∑ x' : X, ∑ x'' : X,
          (g x * g x') * g x'' := by
          rw [Finset.sum_mul]
          simp_rw [Finset.mul_sum]

/-- Expand the fourth power of a finite sum into ordered quadruples. -/
theorem sum_fourth_expand {X : Type*} [Fintype X] (g : X → ℚ) :
    (∑ x : X, g x) ^ 4 =
      ∑ x : X, ∑ x' : X, ∑ x'' : X, ∑ x''' : X,
        ((g x * g x') * g x'') * g x''' := by
  classical
  calc
    (∑ x : X, g x) ^ 4 =
        ((∑ x : X, g x) ^ 3) * (∑ x : X, g x) := by
          rw [pow_succ]
    _ = (∑ x : X, ∑ x' : X, ∑ x'' : X,
          (g x * g x') * g x'') * (∑ x : X, g x) := by
          rw [sum_cube_expand]
    _ = ∑ x : X, ∑ x' : X, ∑ x'' : X, ∑ x''' : X,
          ((g x * g x') * g x'') * g x''' := by
          rw [Finset.sum_mul]
          simp_rw [Finset.mul_sum]

/-- Four weighted point indicators have a common nonzero term exactly
when all four points agree. -/
theorem sum_weighted_quad_indicator (a b c d : Y) (u v w z : ℚ) :
    (∑ y : Y,
      (if a = y then u else 0) *
      (if b = y then v else 0) *
      (if c = y then w else 0) *
      (if d = y then z else 0)) =
      (if a = b ∧ b = c ∧ c = d then
        ((u * v) * w) * z else 0) := by
  classical
  by_cases h : a = b ∧ b = c ∧ c = d
  · rcases h with ⟨hab, hbc, hcd⟩
    subst b
    subst c
    subst d
    simp
  · have hterm (y : Y) :
        (if a = y then u else 0) *
        (if b = y then v else 0) *
        (if c = y then w else 0) *
        (if d = y then z else 0) = 0 := by
      by_cases hay : a = y
      · subst y
        by_cases hba : b = a
        · by_cases hca : c = a
          · by_cases hda : d = a
            · exact (h ⟨hba.symm, hba.trans hca.symm,
                hca.trans hda.symm⟩).elim
            · simp [hda]
          · simp [hca]
        · simp [hba]
      · simp [hay]
    simp [hterm, h]

/-- Fourth fibre moment identity. The fourth moment of fibre masses is
exactly the weighted count of ordered quadruples lying in one common fibre.
This is an identity only; geometric or CRT bounds must still control the
compatible quadruple intersections. -/
theorem fiber_fourth_moment
    {X : Type*} [Fintype X] [DecidableEq X]
    (f : X → Y) (w : X → ℚ) :
    (∑ y : Y, (∑ x : X, if f x = y then w x else 0) ^ 4) =
      ∑ x : X, ∑ x' : X, ∑ x'' : X, ∑ x''' : X,
        (if f x = f x' ∧ f x' = f x'' ∧ f x'' = f x''' then
          ((w x * w x') * w x'') * w x''' else 0) := by
  classical
  calc
    (∑ y : Y, (∑ x : X, if f x = y then w x else 0) ^ 4)
        = ∑ y : Y, ∑ x : X, ∑ x' : X, ∑ x'' : X, ∑ x''' : X,
            (((if f x = y then w x else 0) *
              (if f x' = y then w x' else 0)) *
              (if f x'' = y then w x'' else 0)) *
              (if f x''' = y then w x''' else 0) := by
          congr 1
          funext y
          exact sum_fourth_expand
            (fun x : X => if f x = y then w x else 0)
    _ = ∑ x : X, ∑ y : Y, ∑ x' : X, ∑ x'' : X, ∑ x''' : X,
            (((if f x = y then w x else 0) *
              (if f x' = y then w x' else 0)) *
              (if f x'' = y then w x'' else 0)) *
              (if f x''' = y then w x''' else 0) := by
          rw [Finset.sum_comm]
    _ = ∑ x : X, ∑ x' : X, ∑ y : Y, ∑ x'' : X, ∑ x''' : X,
            (((if f x = y then w x else 0) *
              (if f x' = y then w x' else 0)) *
              (if f x'' = y then w x'' else 0)) *
              (if f x''' = y then w x''' else 0) := by
          congr 1
          funext x
          rw [Finset.sum_comm]
    _ = ∑ x : X, ∑ x' : X, ∑ x'' : X, ∑ y : Y, ∑ x''' : X,
            (((if f x = y then w x else 0) *
              (if f x' = y then w x' else 0)) *
              (if f x'' = y then w x'' else 0)) *
              (if f x''' = y then w x''' else 0) := by
          congr 1
          funext x
          congr 1
          funext x'
          rw [Finset.sum_comm]
    _ = ∑ x : X, ∑ x' : X, ∑ x'' : X, ∑ x''' : X, ∑ y : Y,
            (((if f x = y then w x else 0) *
              (if f x' = y then w x' else 0)) *
              (if f x'' = y then w x'' else 0)) *
              (if f x''' = y then w x''' else 0) := by
          congr 1
          funext x
          congr 1
          funext x'
          congr 1
          funext x''
          rw [Finset.sum_comm]
    _ = ∑ x : X, ∑ x' : X, ∑ x'' : X, ∑ x''' : X,
          (if f x = f x' ∧ f x' = f x'' ∧ f x'' = f x''' then
            ((w x * w x') * w x'') * w x''' else 0) := by
          congr 1
          funext x
          congr 1
          funext x'
          congr 1
          funext x''
          congr 1
          funext x'''
          exact sum_weighted_quad_indicator
            (f x) (f x') (f x'') (f x''')
            (w x) (w x') (w x'') (w x''')

#print axioms sum_cube_expand
#print axioms sum_fourth_expand
#print axioms sum_weighted_quad_indicator
#print axioms fiber_fourth_moment

#print axioms secondMomentDenominator_pos
#print axioms safeStageContribution_zero
#print axioms safeStageContribution_positive
#print axioms safeStageContribution_le_firstMoment
#print axioms safeStageContribution_nonneg

end BBMSTMomentBridge
