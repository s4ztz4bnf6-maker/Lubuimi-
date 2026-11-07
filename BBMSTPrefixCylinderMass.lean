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


/-- In the free-coordinate case, the next cylinder contains exactly all
extensions of the old cylinder. -/
theorem containsPrefix_extend_free
    {k : ℕ} (hk : k + 1 ≤ n)
    (H : Hyperplane C)
    (hfree : H.assignment (stageCoordinate hk) = none)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (t : C.S (stageCoordinate hk)) :
    H.ContainsPrefix hk (extendPrefix C hk x t) ↔
      H.ContainsPrefix (Nat.le_trans (Nat.le_succ k) hk) x := by
  rw [containsPrefix_extend_iff]
  simp [hfree]

/-- In the fixed-coordinate case, the next cylinder is the single
prescribed extension of the old cylinder. -/
theorem containsPrefix_extend_fixed
    {k : ℕ} (hk : k + 1 ≤ n)
    (H : Hyperplane C) (s : C.S (stageCoordinate hk))
    (hfixed : H.assignment (stageCoordinate hk) = some s)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (t : C.S (stageCoordinate hk)) :
    H.ContainsPrefix hk (extendPrefix C hk x t) ↔
      H.ContainsPrefix (Nat.le_trans (Nat.le_succ k) hk) x ∧ t = s := by
  rw [containsPrefix_extend_iff]
  simp [hfixed]

/-- The total mass of all extensions of the old hyperplane cylinder is
exactly its old mass. In the free-coordinate case these are precisely the
points of the next cylinder, by containsPrefix_extend_free. -/
theorem prefixCylinder_allExtensions_mass_eq
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + (j + 1) ≤ n)
    (H : Hyperplane C) :
    (∑ x ∈ prefixCylinder C (by omega) H,
      ∑ t : C.S (stageCoordinate (by omega)),
        PAt C (A := A) a ha P0 δ (j + 1) hj
          (extendPrefix C (by omega) x t)) =
      prefixCylinderMass C (A := A) a ha P0 δ j (by omega) H := by
  simpa [prefixCylinderMass] using
    (sum_extensions_eq_old_event_mass (C := C)
      (A := A) a ha P0 δ hP0_nonneg hδ hδhalf j hj
      (prefixCylinder C (by omega) H))

/-- The mass of the prescribed section of a hyperplane cylinder is bounded
by the old cylinder mass with exactly one distortion factor. In the fixed
case this section is precisely the next cylinder. -/
theorem prefixCylinder_fixedExtension_mass_le
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + (j + 1) ≤ n)
    (H : Hyperplane C)
    (s : C.S (stageCoordinate (by omega))) :
    (∑ x ∈ prefixCylinder C (by omega) H,
      PAt C (A := A) a ha P0 δ (j + 1) hj
        (extendPrefix C (by omega) x s)) ≤
      (prefixCylinderMass C (A := A) a ha P0 δ j (by omega) H /
        (Fintype.card (C.S (stageCoordinate (by omega))) : ℚ)) /
        (1 - δ (stageCoordinate (by omega))) := by
  simpa [prefixCylinderMass] using
    (fixed_extension_event_mass_le (C := C)
      (A := A) a ha P0 δ hP0_nonneg hδ hδhalf j hj
      (prefixCylinder C (by omega) H) s)

#print axioms containsPrefix_extend_free
#print axioms containsPrefix_extend_fixed
#print axioms prefixCylinder_allExtensions_mass_eq
#print axioms prefixCylinder_fixedExtension_mass_le

#print axioms containsPrefix_extend_iff

#print axioms sum_extensions_eq_old_event_mass
#print axioms fixed_extension_event_mass_le

end BBMSTPrefixCylinderMass


/-- Restricting the next cylinder to a free boundary coordinate gives
exactly the old cylinder times the new coordinate. This is the cylinder-
level restriction of prefixExtensionEquiv. -/
noncomputable def prefixCylinderExtensionEquivFree
    {k : ℕ} (hk : k + 1 ≤ n)
    (H : Hyperplane C)
    (hfree : H.assignment (stageCoordinate hk) = none) :
    {y : PrefixPoint C (k + 1) hk //
        y ∈ prefixCylinder C hk H} ≃
      (Σ x : {x : PrefixPoint C k
          (Nat.le_trans (Nat.le_succ k) hk) //
          x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk) H},
        C.S (stageCoordinate hk)) where
  toFun y := by
    have hy : H.ContainsPrefix hk y.1 :=
      (mem_prefixCylinder C hk H y.1).mp y.2
    have hy' : H.ContainsPrefix hk
        (extendPrefix C hk (restrictPrefix C hk y.1)
          (y.1 (Fin.last k))) := by
      simpa [extendPrefix_restrictPrefix] using hy
    have hold : H.ContainsPrefix
        (Nat.le_trans (Nat.le_succ k) hk)
        (restrictPrefix C hk y.1) :=
      (containsPrefix_extend_free C hk H hfree
        (restrictPrefix C hk y.1) (y.1 (Fin.last k))).mp hy'
    exact ⟨⟨restrictPrefix C hk y.1,
      (mem_prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk)
        H (restrictPrefix C hk y.1)).mpr hold⟩,
      y.1 (Fin.last k)⟩
  invFun p := by
    rcases p with ⟨x, t⟩
    exact ⟨extendPrefix C hk x.1 t,
      (mem_prefixCylinder C hk H (extendPrefix C hk x.1 t)).mpr
        ((containsPrefix_extend_free C hk H hfree x.1 t).mpr
          ((mem_prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk)
            H x.1).mp x.2))⟩
  left_inv y := by
    apply Subtype.ext
    exact extendPrefix_restrictPrefix C hk y.1
  right_inv p := by
    rcases p with ⟨⟨x, hx⟩, t⟩
    apply Sigma.ext
    · apply Subtype.ext
      exact restrictPrefix_extendPrefix C hk x t
    · exact extendPrefix_last C hk x t

/-- The mass of the next free-coordinate cylinder, reindexed by its exact
old-cylinder/final-coordinate equivalence. This is the missing finite
cylinder reindexing, not merely the unrestricted prefix identity. -/
theorem prefixCylinder_free_mass_reindex
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (j : ℕ) (hj : a + (j + 1) ≤ n)
    (H : Hyperplane C)
    (hfree : H.assignment
      (stageCoordinate (by omega)) = none) :
    prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H =
      ∑ x ∈ prefixCylinder C (by omega) H,
        ∑ t : C.S (stageCoordinate (by omega)),
          PAt C (A := A) a ha P0 δ (j + 1) hj
            (extendPrefix C (by omega) x t) := by
  classical
  let k := a + j
  have hk : k + 1 ≤ n := by omega
  let e := prefixCylinderExtensionEquivFree C hk H hfree
  unfold prefixCylinderMass
  calc
    (∑ y ∈ prefixCylinder C hj H,
        PAt C (A := A) a ha P0 δ (j + 1) hj y) =
      ∑ y : {y : PrefixPoint C (k + 1) hk //
          y ∈ prefixCylinder C hk H},
        PAt C (A := A) a ha P0 δ (j + 1) hj y.1 := by
          simp [k, prefixCylinder]
    _ = ∑ p :
        Σ x : {x : PrefixPoint C k
            (Nat.le_trans (Nat.le_succ k) hk) //
            x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk) H},
          C.S (stageCoordinate hk),
        PAt C (A := A) a ha P0 δ (j + 1) hj
          (extendPrefix C hk p.1.1 p.2) := by
            apply Fintype.sum_equiv e
            intro y
            change
              PAt C (A := A) a ha P0 δ (j + 1) hj y.1 =
                PAt C (A := A) a ha P0 δ (j + 1) hj
                  (extendPrefix C hk
                    (restrictPrefix C hk y.1) (y.1 (Fin.last k)))
            rw [extendPrefix_restrictPrefix]
    _ = ∑ x : {x : PrefixPoint C k
          (Nat.le_trans (Nat.le_succ k) hk) //
          x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk) H},
        ∑ t : C.S (stageCoordinate hk),
          PAt C (A := A) a ha P0 δ (j + 1) hj
            (extendPrefix C hk x.1 t) := by
              exact Fintype.sum_sigma
                (fun p :
                  Σ x : {x : PrefixPoint C k
                      (Nat.le_trans (Nat.le_succ k) hk) //
                      x ∈ prefixCylinder C
                        (Nat.le_trans (Nat.le_succ k) hk) H},
                    C.S (stageCoordinate hk) =>
                  PAt C (A := A) a ha P0 δ (j + 1) hj
                    (extendPrefix C hk p.1.1 p.2))
    _ = ∑ x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk) H,
        ∑ t : C.S (stageCoordinate hk),
          PAt C (A := A) a ha P0 δ (j + 1) hj
            (extendPrefix C hk x t) := by
              simp


/-- If the newly exposed coordinate is fixed to s, the next cylinder is
the graph of the constant section x ↦ extendPrefix x s over the old
cylinder. -/
noncomputable def prefixCylinderExtensionEquivFixed
    {k : ℕ} (hk : k + 1 ≤ n)
    (H : Hyperplane C) (s : C.S (stageCoordinate hk))
    (hfixed : H.assignment (stageCoordinate hk) = some s) :
    {y : PrefixPoint C (k + 1) hk //
        y ∈ prefixCylinder C hk H} ≃
      {x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk) //
        x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk) H} where
  toFun y := by
    have hy : H.ContainsPrefix hk y.1 :=
      (mem_prefixCylinder C hk H y.1).mp y.2
    have hy' : H.ContainsPrefix hk
        (extendPrefix C hk (restrictPrefix C hk y.1)
          (y.1 (Fin.last k))) := by
      simpa [extendPrefix_restrictPrefix] using hy
    have hsection :=
      (containsPrefix_extend_fixed C hk H s hfixed
        (restrictPrefix C hk y.1) (y.1 (Fin.last k))).mp hy'
    exact ⟨restrictPrefix C hk y.1,
      (mem_prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk)
        H (restrictPrefix C hk y.1)).mpr hsection.1⟩
  invFun x := by
    exact ⟨extendPrefix C hk x.1 s,
      (mem_prefixCylinder C hk H (extendPrefix C hk x.1 s)).mpr
        ((containsPrefix_extend_fixed C hk H s hfixed x.1 s).mpr
          ⟨(mem_prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk)
              H x.1).mp x.2, rfl⟩)⟩
  left_inv y := by
    apply Subtype.ext
    have hy : H.ContainsPrefix hk y.1 :=
      (mem_prefixCylinder C hk H y.1).mp y.2
    have hsection :=
      (containsPrefix_extend_fixed C hk H s hfixed
        (restrictPrefix C hk y.1) (y.1 (Fin.last k))).mp
        (by simpa [extendPrefix_restrictPrefix] using hy)
    rw [← hsection.2]
    exact extendPrefix_restrictPrefix C hk y.1
  right_inv x := by
    apply Subtype.ext
    exact restrictPrefix_extendPrefix C hk x.1 s

/-- Reindexing the mass of a fixed-coordinate cylinder by the unique
section over the old cylinder. -/
theorem prefixCylinder_fixed_mass_reindex
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (j : ℕ) (hj : a + (j + 1) ≤ n)
    (H : Hyperplane C)
    (s : C.S (stageCoordinate (by omega)))
    (hfixed : H.assignment (stageCoordinate (by omega)) = some s) :
    prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H =
      ∑ x ∈ prefixCylinder C (by omega) H,
        PAt C (A := A) a ha P0 δ (j + 1) hj
          (extendPrefix C (by omega) x s) := by
  classical
  let k := a + j
  have hk : k + 1 ≤ n := by omega
  let e := prefixCylinderExtensionEquivFixed C hk H s hfixed
  unfold prefixCylinderMass
  calc
    (∑ y ∈ prefixCylinder C hj H,
        PAt C (A := A) a ha P0 δ (j + 1) hj y) =
      ∑ y : {y : PrefixPoint C (k + 1) hk //
          y ∈ prefixCylinder C hk H},
        PAt C (A := A) a ha P0 δ (j + 1) hj y.1 := by
          simp [k, prefixCylinder]
    _ = ∑ x : {x : PrefixPoint C k
          (Nat.le_trans (Nat.le_succ k) hk) //
          x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk) H},
        PAt C (A := A) a ha P0 δ (j + 1) hj
          (extendPrefix C hk x.1 s) := by
            apply Fintype.sum_equiv e
            intro y
            change
              PAt C (A := A) a ha P0 δ (j + 1) hj y.1 =
                PAt C (A := A) a ha P0 δ (j + 1) hj
                  (extendPrefix C hk (restrictPrefix C hk y.1) s)
            have hy : H.ContainsPrefix hk y.1 :=
              (mem_prefixCylinder C hk H y.1).mp y.2
            have hsection :=
              (containsPrefix_extend_fixed C hk H s hfixed
                (restrictPrefix C hk y.1) (y.1 (Fin.last k))).mp
                (by simpa [extendPrefix_restrictPrefix] using hy)
            rw [← hsection.2, extendPrefix_restrictPrefix]
    _ = ∑ x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk) H,
        PAt C (A := A) a ha P0 δ (j + 1) hj
          (extendPrefix C hk x s) := by
            simp


/-- One-step conservation of the hyperplane-cylinder mass when the
boundary coordinate is free. -/
theorem prefixCylinder_free_mass_eq
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + (j + 1) ≤ n)
    (H : Hyperplane C)
    (hfree : H.assignment (stageCoordinate (by omega)) = none) :
    prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H =
      prefixCylinderMass C (A := A) a ha P0 δ j (by omega) H := by
  rw [prefixCylinder_free_mass_reindex C a ha P0 δ j hj H hfree]
  exact prefixCylinder_allExtensions_mass_eq C a ha P0 δ
    hP0_nonneg hδ hδhalf j hj H

/-- One-step distortion of the hyperplane-cylinder mass when the boundary
coordinate is fixed. -/
theorem prefixCylinder_fixed_mass_le
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + (j + 1) ≤ n)
    (H : Hyperplane C)
    (s : C.S (stageCoordinate (by omega)))
    (hfixed : H.assignment (stageCoordinate (by omega)) = some s) :
    prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H ≤
      (prefixCylinderMass C (A := A) a ha P0 δ j (by omega) H /
        (Fintype.card (C.S (stageCoordinate (by omega))) : ℚ)) /
        (1 - δ (stageCoordinate (by omega))) := by
  rw [prefixCylinder_fixed_mass_reindex C a ha P0 δ j hj H s hfixed]
  exact prefixCylinder_fixedExtension_mass_le C a ha P0 δ
    hP0_nonneg hδ hδhalf j hj H s


#print axioms prefixCylinderExtensionEquivFree
#print axioms prefixCylinder_free_mass_reindex
#print axioms prefixCylinderExtensionEquivFixed
#print axioms prefixCylinder_fixed_mass_reindex
#print axioms prefixCylinder_free_mass_eq
#print axioms prefixCylinder_fixed_mass_le
