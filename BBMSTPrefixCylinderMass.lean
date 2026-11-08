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
    (E : Finset (PrefixPoint C (a + j)
      (Nat.le_trans (Nat.le_succ (a + j))
        (by simpa [Nat.add_assoc] using hj)))) :
    (∑ x ∈ E, ∑ t : C.S (stageCoordinate (by
      simpa [Nat.add_assoc] using hj)),
      PAt C (A := A) a ha P0 δ (j + 1) hj
        (extendPrefix C (by simpa [Nat.add_assoc] using hj) x t)) =
    ∑ x ∈ E, PAt C (A := A) a ha P0 δ j
      (Nat.le_trans (Nat.le_succ (a + j))
        (by simpa [Nat.add_assoc] using hj)) x := by
  classical
  let k := a + j
  have hk : k + 1 ≤ n := by simpa [k, Nat.add_assoc] using hj
  have hprev : k ≤ n := Nat.le_trans (Nat.le_succ k) hk
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
              0 ≤ PAt C (A := A) a ha P0 δ j
                (by omega)
                (restrictPrefix C (k := k) (by omega)
                  (extendPrefix C hk x t)) := by
            simpa [restrictPrefix_extendPrefix] using hbase
          have hlocal := prefixFibre_updatedWeight_eq_PAt
            (C := C) (A := A) a ha P0 δ j (by omega)
            (extendPrefix C hk x t) hbase'
          have hlast :
              (extendPrefix C hk x t) (Fin.last (a + j)) = t := by
            simpa [k] using extendPrefix_last C hk x t
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
    (E : Finset (PrefixPoint C (a + j)
      (Nat.le_trans (Nat.le_succ (a + j))
        (by simpa [Nat.add_assoc] using hj))))
    (t : C.S (stageCoordinate (by
      simpa [Nat.add_assoc] using hj))) :
    (∑ x ∈ E, PAt C (A := A) a ha P0 δ (j + 1) hj
      (extendPrefix C (by simpa [Nat.add_assoc] using hj) x t)) ≤
    ((∑ x ∈ E, PAt C (A := A) a ha P0 δ j
      (Nat.le_trans (Nat.le_succ (a + j))
        (by simpa [Nat.add_assoc] using hj)) x) /
      (Fintype.card (C.S (stageCoordinate (by
        simpa [Nat.add_assoc] using hj))) : ℚ) /
      (1 - δ (stageCoordinate (by
        simpa [Nat.add_assoc] using hj)))) := by
  classical
  let k := a + j
  have hk : k + 1 ≤ n := by simpa [k, Nat.add_assoc] using hj
  have hprev : k ≤ n := Nat.le_trans (Nat.le_succ k) hk
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

/-- The value of an extension at every old coordinate is unchanged. -/
theorem prefixIndex_castSucc
    {k : ℕ} (hk : k + 1 ≤ n) (i : Fin k) :
    prefixIndex hk (Fin.castSucc i) =
      prefixIndex (Nat.le_trans (Nat.le_succ k) hk) i := by
  apply Fin.ext
  rfl

/-- Appending a coordinate leaves every old coordinate unchanged. The
index equality is made explicit before reducing the update operation. -/
theorem extendPrefix_castSucc
    {k : ℕ} (hk : k + 1 ≤ n)
    (x : PrefixPoint C k (Nat.le_trans (Nat.le_succ k) hk))
    (t : C.S (stageCoordinate hk)) (i : Fin k) :
    (extendPrefix C hk x t) (Fin.castSucc i) = x i := by
  have hidx := prefixIndex_castSucc hk i
  have hprev : k ≤ n := Nat.le_trans (Nat.le_succ k) hk
  have hne : prefixIndex hprev i ≠ stageCoordinate hk := by
    intro h
    have hv := congrArg Fin.val h
    simp [stageCoordinate, prefixIndex] at hv
    omega
  have hbase :
      (liftPrefix C hprev x) (prefixIndex hprev i) = x i := by
    have hproj :=
      congrFun (projectPrefix_liftPrefix (C := C) hprev x) i
    simpa [projectPrefix] using hproj
  change
    Function.update (liftPrefix C hprev x) (stageCoordinate hk) t
      (prefixIndex hk (Fin.castSucc i)) = x i
  -- Simplification handles the dependent transport; rw cannot form a
  -- well-typed motive because the coordinate type depends on the index.
  simpa [hidx, Function.update, hne] using hbase

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
  have hprev : k ≤ n := Nat.le_trans (Nat.le_succ k) hk
  constructor
  · intro h
    constructor
    · intro i
      have hi := h (Fin.castSucc i)
      have h_idx := prefixIndex_castSucc hk i
      rw [h_idx] at hi
      simpa only [extendPrefix_castSucc] using hi
    · have hlast := h (Fin.last k)
      have hboundary' :
          (match H.assignment (stageCoordinate hk) with
           | none => True
           | some s => t = s) := by
        simpa [stageCoordinate, extendPrefix_last] using hlast
      exact hboundary'
  · rintro ⟨hold, hboundary⟩
    intro i
    refine Fin.lastCases ?_ (fun i => ?_) i
    · have hboundary' :
          (match H.assignment (prefixIndex hk (Fin.last k)) with
           | none => True
           | some s => t = s) := by
        simpa [stageCoordinate] using hboundary
      simpa [extendPrefix_last] using hboundary'
    · have hi := hold i
      have h_idx := prefixIndex_castSucc hk i
      rw [← h_idx] at hi
      simpa only [extendPrefix_castSucc] using hi


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
    (∑ x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) H,
      ∑ t : C.S (stageCoordinate (by simpa [Nat.add_assoc] using hj)),
        PAt C (A := A) a ha P0 δ (j + 1) hj
          (extendPrefix C (by simpa [Nat.add_assoc] using hj) x t)) =
      prefixCylinderMass C (A := A) a ha P0 δ j (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) H := by
  simpa [prefixCylinderMass] using
    (sum_extensions_eq_old_event_mass (C := C)
      (A := A) a ha P0 δ hP0_nonneg hδ hδhalf j hj
      (prefixCylinder C (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) H))

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
    (s : C.S (stageCoordinate (by simpa [Nat.add_assoc] using hj))) :
    (∑ x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) H,
      PAt C (A := A) a ha P0 δ (j + 1) hj
        (extendPrefix C (by simpa [Nat.add_assoc] using hj) x s)) ≤
      (prefixCylinderMass C (A := A) a ha P0 δ j (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) H /
        (Fintype.card (C.S (stageCoordinate (by simpa [Nat.add_assoc] using hj))) : ℚ)) /
        (1 - δ (stageCoordinate (by simpa [Nat.add_assoc] using hj))) := by
  simpa [prefixCylinderMass] using
    (fixed_extension_event_mass_le (C := C)
      (A := A) a ha P0 δ hP0_nonneg hδ hδhalf j hj
      (prefixCylinder C (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) H) s)

#print axioms containsPrefix_extend_free
#print axioms containsPrefix_extend_fixed
#print axioms prefixCylinder_allExtensions_mass_eq
#print axioms prefixCylinder_fixedExtension_mass_le

#print axioms containsPrefix_extend_iff

#print axioms sum_extensions_eq_old_event_mass
#print axioms fixed_extension_event_mass_le


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
    · exact HEq.of_eq (extendPrefix_last C hk x t)

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
      (stageCoordinate (by simpa [Nat.add_assoc] using hj)) = none) :
    prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H =
      ∑ x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) H,
        ∑ t : C.S (stageCoordinate (by simpa [Nat.add_assoc] using hj)),
          PAt C (A := A) a ha P0 δ (j + 1) hj
            (extendPrefix C (by simpa [Nat.add_assoc] using hj) x t) := by
  classical
  let k := a + j
  have hk : k + 1 ≤ n := by simpa [k, Nat.add_assoc] using hj
  let e := prefixCylinderExtensionEquivFree C hk H hfree
  unfold prefixCylinderMass
  calc
    (∑ y ∈ prefixCylinder C hj H,
        PAt C (A := A) a ha P0 δ (j + 1) hj y) =
      ∑ y : {y : PrefixPoint C (k + 1) hk //
          y ∈ prefixCylinder C hk H},
        PAt C (A := A) a ha P0 δ (j + 1) hj y.1 := by
          rw [Finset.sum_attach]
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
              rw [← Finset.sum_attach]
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
    have hsectionEq :
        extendPrefix C hk (restrictPrefix C hk y.1) s =
          extendPrefix C hk (restrictPrefix C hk y.1) (y.1 (Fin.last k)) :=
      congrArg (extendPrefix C hk (restrictPrefix C hk y.1)) hsection.2.symm
    exact hsectionEq.trans (extendPrefix_restrictPrefix C hk y.1)
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
    (s : C.S (stageCoordinate (by simpa [Nat.add_assoc] using hj)))
    (hfixed : H.assignment (stageCoordinate (by simpa [Nat.add_assoc] using hj)) = some s) :
    prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H =
      ∑ x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) H,
        PAt C (A := A) a ha P0 δ (j + 1) hj
          (extendPrefix C (by simpa [Nat.add_assoc] using hj) x s) := by
  classical
  let k := a + j
  have hk : k + 1 ≤ n := by simpa [k, Nat.add_assoc] using hj
  let e := prefixCylinderExtensionEquivFixed C hk H s hfixed
  unfold prefixCylinderMass
  calc
    (∑ y ∈ prefixCylinder C hj H,
        PAt C (A := A) a ha P0 δ (j + 1) hj y) =
      ∑ y : {y : PrefixPoint C (k + 1) hk //
          y ∈ prefixCylinder C hk H},
        PAt C (A := A) a ha P0 δ (j + 1) hj y.1 := by
          rw [Finset.sum_attach]
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
            have hsectionEq :
                extendPrefix C hk (restrictPrefix C hk y.1) s =
                  extendPrefix C hk (restrictPrefix C hk y.1)
                    (y.1 (Fin.last k)) :=
              congrArg (extendPrefix C hk (restrictPrefix C hk y.1))
                hsection.2.symm
            rw [hsectionEq, extendPrefix_restrictPrefix]
    _ = ∑ x ∈ prefixCylinder C (Nat.le_trans (Nat.le_succ k) hk) H,
        PAt C (A := A) a ha P0 δ (j + 1) hj
          (extendPrefix C hk x s) := by
            rw [← Finset.sum_attach]
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
    (hfree : H.assignment (stageCoordinate (by simpa [Nat.add_assoc] using hj)) = none) :
    prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H =
      prefixCylinderMass C (A := A) a ha P0 δ j (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) H := by
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
    (s : C.S (stageCoordinate (by simpa [Nat.add_assoc] using hj)))
    (hfixed : H.assignment (stageCoordinate (by simpa [Nat.add_assoc] using hj)) = some s) :
    prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H ≤
      (prefixCylinderMass C (A := A) a ha P0 δ j (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) H /
        (Fintype.card (C.S (stageCoordinate (by simpa [Nat.add_assoc] using hj))) : ℚ)) /
        (1 - δ (stageCoordinate (by simpa [Nat.add_assoc] using hj))) := by
  rw [prefixCylinder_fixed_mass_reindex C a ha P0 δ j hj H s hfixed]
  exact prefixCylinder_fixedExtension_mass_le C a ha P0 δ
    hP0_nonneg hδ hδhalf j hj H s


#print axioms prefixCylinderExtensionEquivFree
#print axioms prefixCylinder_free_mass_reindex
#print axioms prefixCylinderExtensionEquivFixed
#print axioms prefixCylinder_fixed_mass_reindex
#print axioms prefixCylinder_free_mass_eq
#print axioms prefixCylinder_fixed_mass_le


/-- The mass of every finite hyperplane cylinder is nonnegative, by
nonnegativity of the actual recursively defined prefix weights. -/
theorem prefixCylinderMass_nonneg
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (j : ℕ) (hj : a + j ≤ n)
    (H : Hyperplane C) :
    0 ≤ prefixCylinderMass C (A := A) a ha P0 δ j hj H := by
  unfold prefixCylinderMass
  apply Finset.sum_nonneg
  intro x hx
  exact PAt_nonneg (C := C) (A := A) a ha P0 δ
    hP0_nonneg hδ hδhalf j hj x

/-- Product of the distortion factors only at coordinates fixed by H in
the suffix [a,a+j). Free coordinates contribute the neutral factor 1. -/
noncomputable def hyperplaneSuffixFactor
    (a : ℕ) (δ : Fin n → ℚ) (H : Hyperplane C) :
    (j : ℕ) → (hj : a + j ≤ n) → ℚ
  | 0, _ => 1
  | j + 1, hj =>
      hyperplaneSuffixFactor a δ H j (Nat.le_trans (Nat.le_succ (a + j)) (by simpa [Nat.add_assoc] using hj)) *
        (if (H.assignment (stageCoordinate (by simpa [Nat.add_assoc] using hj))).isSome
         then distortionFactor C δ (stageCoordinate (by simpa [Nat.add_assoc] using hj))
         else 1)

/-- Cylinder-mass induction with the exact BBMST suffix factor: each
coordinate free in H preserves mass, and each coordinate fixed by H
contributes exactly 1/(|S_i|(1-δ_i)). No factor is charged to a free
coordinate. This is the central multi-stage measure estimate needed for
Lemma 3.3. -/
theorem prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor
    {A : Finset (Hyperplane C)}
    (a : ℕ) (ha : a ≤ n)
    (P0 : PrefixPoint C a ha → ℚ) (δ : Fin n → ℚ)
    (hP0_nonneg : ∀ x, 0 ≤ P0 x)
    (hδ : ∀ i, 0 ≤ δ i)
    (hδhalf : ∀ i, δ i ≤ (1 / 2 : ℚ))
    (H : Hyperplane C) :
    ∀ (j : ℕ) (hj : a + j ≤ n),
      prefixCylinderMass C (A := A) a ha P0 δ j hj H ≤
        prefixCylinderMass C (A := A) a ha P0 δ 0 ha H *
          hyperplaneSuffixFactor C a δ H j hj := by
  intro j
  induction j with
  | zero =>
      intro hj
      simp [hyperplaneSuffixFactor]
  | succ j ih =>
      intro hj
      let k := a + j
      have hk : k + 1 ≤ n := by simpa [k, Nat.add_assoc] using hj
      have hprev : k ≤ n := Nat.le_trans (Nat.le_succ k) hk
      let i := stageCoordinate hk
      have hmass_nonneg :
          0 ≤ prefixCylinderMass C (A := A) a ha P0 δ j hprev H :=
        prefixCylinderMass_nonneg C a ha P0 δ
          hP0_nonneg hδ hδhalf j hprev H
      have hcardpos :
          0 < (Fintype.card (C.S i) : ℚ) := by
        have hcard := C.card_ge_two i
        exact_mod_cast (lt_of_lt_of_le (by decide : 0 < 2) hcard)
      have hdenpos : 0 < 1 - δ i := by
        linarith [hδhalf i]
      have hfactorpos : 0 < distortionFactor C δ i := by
        unfold distortionFactor
        exact one_div_pos.mpr (mul_pos hcardpos hdenpos)
      cases hassign : H.assignment i with
      | none =>
          have hstep :
              prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H =
                prefixCylinderMass C (A := A) a ha P0 δ j hprev H :=
            prefixCylinder_free_mass_eq C a ha P0 δ
              hP0_nonneg hδ hδhalf j hj H (by simpa [i, hassign])
          rw [hstep]
          simpa [hyperplaneSuffixFactor, k, hk, i, hassign] using
            (ih hprev)
      | some s =>
          have hstep :
              prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H ≤
                ((prefixCylinderMass C (A := A) a ha P0 δ j hprev H /
                  (Fintype.card (C.S i) : ℚ)) / (1 - δ i)) :=
            prefixCylinder_fixed_mass_le C a ha P0 δ
              hP0_nonneg hδ hδhalf j hj H s (by simpa [i, hassign])
          have hstep' :
              prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H ≤
                prefixCylinderMass C (A := A) a ha P0 δ j hprev H *
                  distortionFactor C δ i := by
            calc
              prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H ≤
                  (prefixCylinderMass C (A := A) a ha P0 δ j hprev H /
                    (Fintype.card (C.S i) : ℚ)) / (1 - δ i) := hstep
              _ = prefixCylinderMass C (A := A) a ha P0 δ j hprev H *
                    distortionFactor C δ i := by
                      unfold distortionFactor
                      field_simp [ne_of_gt hcardpos, ne_of_gt hdenpos]
                      <;> ring
          calc
            prefixCylinderMass C (A := A) a ha P0 δ (j + 1) hj H ≤
                prefixCylinderMass C (A := A) a ha P0 δ j hprev H *
                  distortionFactor C δ i := hstep'
            _ ≤
                (prefixCylinderMass C (A := A) a ha P0 δ 0 ha H *
                  hyperplaneSuffixFactor C a δ H j hprev) *
                    distortionFactor C δ i := by
                      exact mul_le_mul_of_nonneg_right (ih hprev)
                        (le_of_lt hfactorpos)
            _ =
                prefixCylinderMass C (A := A) a ha P0 δ 0 ha H *
                  hyperplaneSuffixFactor C a δ H (j + 1) hj := by
                    simp [hyperplaneSuffixFactor, k, hk, i, hassign]
                    <;> ring

#print axioms prefixCylinderMass_nonneg
#print axioms hyperplaneSuffixFactor
#print axioms prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor


end BBMSTPrefixCylinderMass
