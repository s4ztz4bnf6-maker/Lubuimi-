import BBMSTPrefixMeasureRecursion

open BBMSTGeometry
open BBMSTPrefixMeasure

namespace BBMSTBoundaryProjectionTest

/-- The stage coordinate has value k. -/
lemma stageCoordinate_val
    {n k : ℕ} {C : CoordinateSystem n}
    (hk : k + 1 ≤ n) :
    (stageCoordinate hk).val = k := by
  rfl

/-- Every hyperplane entering at stage k+1 fixes the boundary
coordinate introduced after prefix length k. -/
lemma boundaryAssignment_exists
    {n k : ℕ} {C : CoordinateSystem n}
    (A : Finset (Hyperplane C))
    (hk : k + 1 ≤ n)
    (H : Hyperplane C)
    (hH : H ∈ newAtStage A (k + 1)) :
    ∃ s : C.S (stageCoordinate hk),
      H.assignment (stageCoordinate hk) = some s := by
  classical

  obtain ⟨i, hi_val, hi_fixed⟩ :=
    newAtStage_has_last_coordinate
      (A := A)
      (hk := hk)
      (hk0 := by omega)
      H hH

  have hi_eq : i = stageCoordinate hk := by
    apply Fin.ext
    change i.val = (stageCoordinate hk).val
    rw [stageCoordinate_val]
    omega

  have hfixed :
      stageCoordinate hk ∈ fixedCoords H := by
    rw [← hi_eq]
    exact hi_fixed

  change stageCoordinate hk ∈
    Finset.univ.filter (fun i => (H.assignment i).isSome) at hfixed

  have hsome :
      (H.assignment (stageCoordinate hk)).isSome :=
    (Finset.mem_filter.mp hfixed).2

  exact Option.isSome_iff_exists.mp hsome

/-- Total boundary projection on the subtype of newly entering
hyperplanes. -/
noncomputable def boundaryProjection
    {n k : ℕ} {C : CoordinateSystem n}
    (A : Finset (Hyperplane C))
    (hk : k + 1 ≤ n)
    (H : {H : Hyperplane C // H ∈ newAtStage A (k + 1)}) :
    C.S (stageCoordinate hk) :=
  Classical.choose
    (boundaryAssignment_exists A hk H.val H.property)

/-- The projected value is exactly the assigned boundary value. -/
lemma boundaryProjection_spec
    {n k : ℕ} {C : CoordinateSystem n}
    (A : Finset (Hyperplane C))
    (hk : k + 1 ≤ n)
    (H : {H : Hyperplane C // H ∈ newAtStage A (k + 1)}) :
    H.val.assignment (stageCoordinate hk) =
      some (boundaryProjection A hk H) :=
  Classical.choose_spec
    (boundaryAssignment_exists A hk H.val H.property)

#print axioms stageCoordinate_val
#print axioms boundaryAssignment_exists
#print axioms boundaryProjection
#print axioms boundaryProjection_spec

end BBMSTBoundaryProjectionTest
