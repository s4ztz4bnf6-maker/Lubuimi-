import Mathlib
import BBMSTPrefixMeasureRecursion

/-!
# Event-mass identities for the source-indexed BBMST prefix recursion

These lemmas isolate the two genuinely different one-coordinate operations:
summing over every value of a free coordinate conserves the event mass,
whereas retaining one prescribed value incurs the local distortion factor.
They are finite-prefix statements and do not yet identify the relevant
hyperplane cylinder or prove BBMST Lemma 3.3.
-/

namespace BBMSTPrefixCylinderMass

open BBMSTGeometry
open BBMSTPrefixMeasure
open BBMSTFiniteFibreUpdate

variable {n : ℕ} (C : CoordinateSystem n)

/-- Summing the next-stage mass over every value of the newly exposed
coordinate preserves the mass of any finite set of old prefixes. This is
the event-level, rather than merely total-probability, conservation law. -/
theorem sum_extensions_eq_old_event_mass
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + (j + 1) ≤ n)
    (E : Finset (PrefixPoint C (a + j) (by omega))) :
    (∑ x ∈ E, ∑ t : C.S (stageCoordinate (by omega)),
      PAt C (A := A) a ha P0 δ (j + 1) hj
        (extendPrefix C (by omega) x t)) =
    ∑ x ∈ E, PAt C (A := A) a ha P0 δ j (by omega) x := by
  classical
  let k := a + j
  have hk : k + 1 ≤ n := by omega
  have hprev : k ≤ n := by omega
  have hnonneg := PAt_nonneg (C := C) (A := A) a ha P0 δ
    hP0_nonneg hδ hδhalf
  apply Finset.sum_congr rfl
  intro x hx
  let baseMass := PAt C (A := A) a ha P0 δ j hprev x
  have hbase : 0 ≤ baseMass := hnonneg j hprev x
  let F := prefixFibreData C (A := A) (k := k) hk x baseMass hbase
  have hpoints : F.points = Finset.univ := by
    rfl
  have hlocalSum :
      (∑ t : C.S (stageCoordinate hk),
        updatedWeight F (δ (stageCoordinate hk)) t) = baseMass := by
    calc
      (∑ t : C.S (stageCoordinate hk),
          updatedWeight F (δ (stageCoordinate hk)) t) =
        ∑ t ∈ F.points,
          updatedWeight F (δ (stageCoordinate hk)) t := by
            simpa [hpoints]
      _ = F.total :=
        sum_updatedWeight_eq_total F (δ (stageCoordinate hk))
          (hδ (stageCoordinate hk)) (hδhalf (stageCoordinate hk))
      _ = baseMass := by rfl
  calc
    (∑ t : C.S (stageCoordinate hk),
        PAt C (A := A) a ha P0 δ (j + 1) hj
          (extendPrefix C hk x t)) =
      ∑ t : C.S (stageCoordinate hk),
        updatedWeight F (δ (stageCoordinate hk)) t := by
          apply Finset.sum_congr rfl
          intro t ht
          have hbase' :
              0 ≤ PAt C (A := A) a ha P0 δ j hprev
                (restrictPrefix C hk (extendPrefix C hk x t)) := by
            simpa [restrictPrefix_extendPrefix] using hbase
          have hlocal := prefixFibre_updatedWeight_eq_PAt
            (C := C) (A := A) a ha P0 δ j hj
            (extendPrefix C hk x t) hbase'
          have hlast :
              (extendPrefix C hk x t) (Fin.last k) = t :=
            extendPrefix_last C hk x t
          simpa [F, baseMass, prefixFibreData, prefixUniformFibre,
            BBMSTUniformFibreInstantiation.toFibreData,
            restrictPrefix_extendPrefix, hlast] using hlocal.symm
    _ = baseMass := hlocalSum

/-- For a prescribed value of the newly exposed coordinate, the mass of
any finite old-prefix event is bounded by the old event mass times exactly
the one-coordinate distortion factor. -/
theorem fixed_extension_event_mass_le
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + (j + 1) ≤ n)
    (E : Finset (PrefixPoint C (a + j) (by omega)))
    (t : C.S (stageCoordinate (by omega))) :
    (∑ x ∈ E, PAt C (A := A) a ha P0 δ (j + 1) hj
      (extendPrefix C (by omega) x t)) ≤
    ((∑ x ∈ E, PAt C (A := A) a ha P0 δ j (by omega) x) /
      (Fintype.card (C.S (stageCoordinate (by omega))) : ℚ)) /
      (1 - δ (stageCoordinate (by omega))) := by
  classical
  let k := a + j
  have hk : k + 1 ≤ n := by omega
  have hprev : k ≤ n := by omega
  calc
    (∑ x ∈ E, PAt C (A := A) a ha P0 δ (j + 1) hj
        (extendPrefix C hk x t)) ≤
      ∑ x ∈ E,
        (PAt C (A := A) a ha P0 δ j hprev x /
          (Fintype.card (C.S (stageCoordinate hk)) : ℚ)) /
          (1 - δ (stageCoordinate hk)) := by
            apply Finset.sum_le_sum
            intro x hx
            have hstep :=
              PAt_succ_le_prev_div_card_mul_one_sub_delta
                (C := C) (A := A) a ha P0 δ hP0_nonneg hδ hδhalf
                j hj (extendPrefix C hk x t)
            simpa [restrictPrefix_extendPrefix] using hstep
    _ =
      ((∑ x ∈ E, PAt C (A := A) a ha P0 δ j hprev x) /
        (Fintype.card (C.S (stageCoordinate hk)) : ℚ)) /
        (1 - δ (stageCoordinate hk)) := by
          rw [← Finset.sum_div, ← Finset.sum_div]



/-- The finite set of length-k prefixes satisfying the constraints
of a given hyperplane. -/
noncomputable def prefixCylinder
    {k : ℕ} (hk : k ≤ n) (H : Hyperplane C) :
    Finset (PrefixPoint C k hk) := by
  classical
  exact Finset.univ.filter (fun x => H.ContainsPrefix hk x)

/-- Membership in the finite hyperplane cylinder is exactly prefix
containment; this is the interface used by the event-mass lemmas. -/
theorem mem_prefixCylinder
    {k : ℕ} (hk : k ≤ n) (H : Hyperplane C)
    (x : PrefixPoint C k hk) :
    x ∈ prefixCylinder C hk H ↔ H.ContainsPrefix hk x := by
  simp [prefixCylinder]

/-- The PAt mass of the finite cylinder cut out by H at prefix length k. -/
noncomputable def prefixCylinderMass
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (j : ℕ) (hj : a + j ≤ n)
    (H : Hyperplane C) : ℚ :=
  ∑ x ∈ prefixCylinder C hj H, PAt C (A := A) a ha P0 δ j hj x

#print axioms mem_prefixCylinder

/-- Exact geometric decomposition of a hyperplane cylinder when one
coordinate is appended: all old-coordinate constraints are inherited by
the restriction, and the boundary constraint is precisely the assignment
at the newly exposed coordinate. -/
theorem containsPrefix_extend_iff
    {k : ℕ} (hk : k + 1 ≤ n)
    (H : Hyperplane C)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (t : C.S (stageCoordinate hk)) :
    H.ContainsPrefix hk (extendPrefix C hk x t) ↔
      H.ContainsPrefix (Nat.le_trans (Nat.le_succ k) hk) x ∧
        (match H.assignment (stageCoordinate hk) with
         | none => True
         | some s => t = s) := by
  constructor
  · intro h
    constructor
    · intro i
      have hi := h i.castSucc
      simpa [Hyperplane.ContainsPrefix, prefixIndex, extendPrefix,
        projectPrefix, liftPrefix, stageCoordinate, Function.update] using hi
    · cases hassign : H.assignment (stageCoordinate hk) with
      | none => trivial
      | some s =>
          have hlast := h (Fin.last k)
          simpa [Hyperplane.ContainsPrefix, prefixIndex, stageCoordinate,
            hassign, extendPrefix_last] using hlast
  · rintro ⟨hold, hboundary⟩
    intro i
    refine Fin.lastCases ?_ (fun i => ?_) i
    · cases hassign : H.assignment (stageCoordinate hk) with
      | none => simp [Hyperplane.ContainsPrefix, hassign]
      | some s =>
          simp [Hyperplane.ContainsPrefix, prefixIndex, stageCoordinate,
            hassign, extendPrefix_last, hboundary]
    · have hi := hold i
      simpa [Hyperplane.ContainsPrefix, prefixIndex, extendPrefix,
        projectPrefix, liftPrefix, stageCoordinate, Function.update] using hi

#print axioms containsPrefix_extend_iff

#print axioms sum_extensions_eq_old_event_mass
#print axioms fixed_extension_event_mass_le

end BBMSTPrefixCylinderMass
