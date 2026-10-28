import Mathlib

/-!
# BBMST Theorem 3.2: separated second-moment bound interface

This file separates the two estimates stated in the published BBMST
Theorem 3.2:

* the general estimate using c₃;
* the improved estimate using c₃ - 2*c₁ + 1, only when the relevant
  stage has no codimension-one hyperplane.

This is an interface for the source-to-Lean bridge, not a proof of the
BBMST moment estimates. The actual probability-space construction must
supply the fields of `MomentBoundEvidence`; no project-specific axiom is
introduced here. In particular, the improved estimate cannot be selected
without an explicit proof of `noCodimOne`.
-/

namespace BBMSTAudit

/-- Moment quantities and the geometric side condition at one stage. -/
structure MomentBoundEvidence where
  c1 : ℚ
  c3 : ℚ
  blockSize : ℚ
  secondMoment : ℚ
  blockSize_pos : 0 < blockSize
  /-- The general second-moment estimate from Theorem 3.2. -/
  general_bound :
    secondMoment ≤ c3 / blockSize ^ 2
  /-- The source-specific geometric condition for the improved estimate. -/
  noCodimOne : Prop
  /-- The improved estimate is available only under the geometric condition. -/
  improved_bound :
    noCodimOne →
      secondMoment ≤ (c3 - 2 * c1 + 1) / blockSize ^ 2

/-- The unconditional estimate: it needs no codimension-one hypothesis. -/
theorem second_moment_general_bound (e : MomentBoundEvidence) :
    e.secondMoment ≤ e.c3 / e.blockSize ^ 2 :=
  e.general_bound

/-- The improved estimate is only callable with a proof of the source condition. -/
theorem second_moment_improved_bound (e : MomentBoundEvidence)
    (hgeom : e.noCodimOne) :
    e.secondMoment ≤ (e.c3 - 2 * e.c1 + 1) / e.blockSize ^ 2 :=
  e.improved_bound hgeom

/--
A caller that has not established the geometric condition can always use
the general estimate. This theorem deliberately does not attempt to infer
the geometric condition from unrelated hypotheses.
-/
theorem second_moment_fallback (e : MomentBoundEvidence) :
    e.secondMoment ≤ e.c3 / e.blockSize ^ 2 :=
  second_moment_general_bound e

#print axioms second_moment_general_bound
#print axioms second_moment_improved_bound
#print axioms second_moment_fallback

end BBMSTAudit
