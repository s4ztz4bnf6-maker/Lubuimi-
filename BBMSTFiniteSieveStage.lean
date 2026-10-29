import Mathlib
import BBMSTMomentBridge

/-!
# Finite sieve-stage transition: first source-faithful interface

This file formalizes only the finite transition and its fiber-mass identity.
It does not yet encode the geometric hyperplanes or any BBMST estimate.
-/

namespace BBMSTFiniteSieveStage

/-- A finite stage transition from level k to level k-1.
The map is deliberately explicit: fibers are inverse images under restrict. -/
structure Transition (Qk Qprev : Type*) where
  restrict : Qk → Qprev

variable {Qk Qprev : Type*}
variable [Fintype Qk] [Fintype Qprev] [DecidableEq Qprev]

/-- The fiber over a point at the previous stage. -/
def fiber (T : Transition Qk Qprev) (y : Qprev) : Finset Qk :=
  Finset.univ.filter (fun x => T.restrict x = y)

/-- Weighted mass of one fiber. Weights are not assumed positive yet. -/
def fiberMass (T : Transition Qk Qprev) (w : Qk → ℚ) (y : Qprev) : ℚ :=
  ∑ x ∈ fiber T y, w x

/-- Fiber mass as an indicator sum, matching the finite moment bridge. -/
theorem fiberMass_indicator (T : Transition Qk Qprev) (w : Qk → ℚ)
    (y : Qprev) :
    fiberMass T w y = ∑ x : Qk, if T.restrict x = y then w x else 0 := by
  classical
  simp [fiberMass, fiber, Finset.sum_filter]

/-- Every point belongs to exactly one fiber, so total fiber mass is conserved.
This is a finite partition identity, not a probabilistic or geometric estimate. -/
theorem sum_fiberMass (T : Transition Qk Qprev) (w : Qk → ℚ) :
    (∑ y : Qprev, fiberMass T w y) = ∑ x : Qk, w x := by
  classical
  unfold fiberMass fiber
  simp only [Finset.sum_filter]
  rw [Finset.sum_comm]
  simp

/-- The sum of squared fiber masses is the weighted pair sum over equal images.
This connects the transition interface to the finite second-moment identity;
it does not yet provide any geometric incidence bound. -/
theorem fiberMass_secondMoment (T : Transition Qk Qprev) (w : Qk → ℚ) :
    (∑ y : Qprev, (fiberMass T w y) ^ 2) =
      ∑ x : Qk, ∑ x' : Qk,
        (if T.restrict x = T.restrict x' then w x * w x' else 0) := by
  classical
  simp_rw [fiberMass_indicator]
  exact BBMSTMomentBridge.fiber_second_moment T.restrict w

#print axioms fiberMass_indicator
#print axioms fiberMass_secondMoment

/-- The incidence relation induced by the transition is equality of images. -/
def sameFiber (T : Transition Qk Qprev) (x x' : Qk) : Prop :=
  T.restrict x = T.restrict x'

theorem sameFiber_iff (T : Transition Qk Qprev) (x x' : Qk) :
    sameFiber T x x' ↔ T.restrict x = T.restrict x' := Iff.rfl

#print axioms sum_fiberMass
#print axioms sameFiber_iff

end BBMSTFiniteSieveStage


/-!
## Concrete finite probability mass for a removed set

This is a definition-level finite measure interface. It proves the elementary
mass bounds needed before connecting a sieve stage to the paper's geometric
objects. It does not assert any BBMST-specific estimate.
-/

/-- A probability weight on a finite type, represented by exact rationals. -/
structure FiniteProbability (X : Type*) [Fintype X] where
  weight : X → ℚ
  weight_nonneg : ∀ x, 0 ≤ weight x
  normalized : (∑ x : X, weight x) = 1

namespace FiniteProbability

variable {X : Type*} [Fintype X] [DecidableEq X]

/-- The probability mass of a finite subset. -/
def mass (P : FiniteProbability X) (B : Finset X) : ℚ :=
  ∑ x : X, if x ∈ B then P.weight x else 0

/-- Removed mass is nonnegative. -/
theorem mass_nonneg (P : FiniteProbability X) (B : Finset X) :
    0 ≤ P.mass B := by
  unfold mass
  apply Finset.sum_nonneg
  intro x hx
  split_ifs
  · exact P.weight_nonneg x
  · norm_num

/-- The mass of any finite subset is at most the total probability mass. -/
theorem mass_le_one (P : FiniteProbability X) (B : Finset X) :
    P.mass B ≤ 1 := by
  rw [← P.normalized]
  unfold mass
  apply Finset.sum_le_sum
  intro x hx
  split_ifs with h
  · exact le_rfl
  · exact P.weight_nonneg x

/-- If a removed set has zero mass, every point in it has zero weight. -/
theorem weight_eq_zero_of_mem_of_mass_eq_zero
    (P : FiniteProbability X) (B : Finset X) (x : X)
    (hx : x ∈ B) (hm : P.mass B = 0) : P.weight x = 0 := by
  have hnonneg : ∀ y : X, 0 ≤ (if y ∈ B then P.weight y else 0) := by
    intro y
    split_ifs
    · exact P.weight_nonneg y
    · norm_num
  have hterm : (if x ∈ B then P.weight x else 0) ≤ P.mass B := by
    unfold mass
    exact Finset.single_le_sum (fun y hy => hnonneg y) (Finset.mem_univ x)
  rw [hm] at hterm
  simp only [if_pos hx] at hterm
  exact le_antisymm hterm (P.weight_nonneg x)

#print axioms weight_eq_zero_of_mem_of_mass_eq_zero

/-- The mass parameter is derived from the removed set, not supplied freely. -/
def removedMass (P : FiniteProbability X) (B : Finset X) : ℚ :=
  P.mass B

theorem removedMass_nonneg (P : FiniteProbability X) (B : Finset X) :
    0 ≤ P.removedMass B :=
  P.mass_nonneg B

theorem removedMass_le_one (P : FiniteProbability X) (B : Finset X) :
    P.removedMass B ≤ 1 :=
  P.mass_le_one B

#print axioms mass_nonneg
#print axioms mass_le_one
#print axioms removedMass_nonneg
#print axioms removedMass_le_one

end FiniteProbability
