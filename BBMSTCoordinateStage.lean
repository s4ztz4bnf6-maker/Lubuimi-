import Mathlib

/-!
# Concrete finite coordinate stages for the BBMST construction

This module models the combinatorial data of one coordinate stage.
It deliberately does not assume a mass-preservation identity or a geometric
incidence estimate: those must be derived from the paper's actual weight
construction and hypotheses.
-/

namespace BBMSTCoordinateStage

/-- A finite coordinate stage consists of a prior-coordinate space X,
a nonempty set S of possible new coordinates, and the exceptional
extensions B x s removed at the current stage. -/
structure CoordinateStage (X S : Type*) [Fintype X] [Fintype S] where
  exceptional : X → S → Prop
  nonempty_coordinates : Nonempty S

variable {X S : Type*} [Fintype X] [Fintype S]

/-- The exceptional extensions over a fixed prior coordinate. -/
noncomputable def exceptionalFiber
    (C : CoordinateStage X S) (x : X) : Finset S := by
  classical
  exact Finset.univ.filter (fun s => C.exceptional x s)

/-- The exceptional-fiber fraction alpha(x), derived from the actual
finite set of exceptional extensions rather than supplied as a free value. -/
noncomputable def alpha
    (C : CoordinateStage X S) (x : X) : ℚ :=
  (exceptionalFiber C x).card / Fintype.card S

/-- Membership in the exceptional fiber is exactly the stage's exceptional
extension predicate. -/
theorem mem_exceptionalFiber_iff
    (C : CoordinateStage X S) (x : X) (s : S) :
    s ∈ exceptionalFiber C x ↔ C.exceptional x s := by
  classical
  simp [exceptionalFiber]

/-- The coordinate space really is nonempty, so its cardinality is positive;
this is the denominator guard needed before using alpha in inequalities. -/
theorem coordinate_card_pos (C : CoordinateStage X S) :
    0 < Fintype.card S :=
  Fintype.card_pos_iff.mpr C.nonempty_coordinates

/-- The exceptional fiber is a subset of the full coordinate space. -/
theorem exceptionalFiber_card_le
    (C : CoordinateStage X S) (x : X) :
    (exceptionalFiber C x).card ≤ Fintype.card S := by
  classical
  apply Finset.card_le_card
  intro s hs
  exact Finset.mem_univ s

/-- The derived exceptional fraction is nonnegative. -/
theorem alpha_nonneg (C : CoordinateStage X S) (x : X) :
    0 ≤ alpha C x := by
  unfold alpha
  positivity

/-- The derived exceptional fraction cannot exceed one. -/
theorem alpha_le_one (C : CoordinateStage X S) (x : X) :
    alpha C x ≤ 1 := by
  unfold alpha
  have hcard : (exceptionalFiber C x).card ≤ Fintype.card S :=
    exceptionalFiber_card_le C x
  have hden : 0 < (Fintype.card S : ℚ) := by
    exact_mod_cast coordinate_card_pos C
  rw [div_le_one hden]
  exact_mod_cast hcard

#print axioms mem_exceptionalFiber_iff
#print axioms coordinate_card_pos
#print axioms exceptionalFiber_card_le
#print axioms alpha_nonneg
#print axioms alpha_le_one

end BBMSTCoordinateStage
