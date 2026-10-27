# BBMST next gate: exhaustive toy-model check and Lean data contract

Date: 2026-10-27

Status: finite model diagnostic and formalization specification; not Lean-checked and not a proof of the source theorem.

## 1. Data model that must be fixed before coding

Represent a finite product box as Q = S_1 × ... × S_d, with each S_i a finite type/set. Represent a coordinate cylinder (called a hyperplane in the project's combinatorial encoding) by:
- a finite set I of fixed coordinates;
- an assignment s_i ∈ S_i for each i ∈ I;
- membership x ∈ H iff x_i = s_i for every i ∈ I.

Its codimension is |I|. Parallelism is equality of fixed-coordinate sets I, as specified in the current project note. The Lean implementation must make the relationship between a support I and its assignment explicit; it must not replace it with a premise that codimension-one objects are absent.

## 2. Finite diagnostic

An exhaustive enumeration of the coordinate-cylinder model for d = 3 and |S_i| = 3 considered 1,792,000 candidate families, allowing either no cylinder or one assignment for each nonempty coordinate support. No candidate family covered all 27 points.

This is consistent with the no-cover phenomenon expected in this small model, but it is not a proof in arbitrary dimension. It also tests the specific coordinate-cylinder encoding above, not any broader geometric notion of hyperplane. If the source's definition differs, this experiment does not transfer until the definitions are reconciled.

## 3. Restriction construction to formalize

For every coordinate i with a codimension-one cylinder fixing x_i = s_i, pairwise nonparallelism ensures that there is at most one such s_i. Define S_i' = S_i without s_i; otherwise define S_i' = S_i. If |S_i| >= 3, then |S_i'| >= 2 and Q' is nonempty.

Define the restricted family by retaining precisely those original cylinders whose every fixed value belongs to its corresponding S_i'. Prove, in this order:

1. codim_one_unique_per_coordinate.
2. restricted_coordinate_card.
3. restricted_box_nonempty.
4. discarded_cylinder_disjoint: any discarded cylinder has empty intersection with Q'.
5. restricted_cover: every point of Q' remains covered, because it was covered in Q and no discarded cylinder contains it.
6. codim_preserved: a retained cylinder has the same fixed support and codimension.
7. nonparallel_preserved: equal supports after restriction would have been equal supports before restriction.

Only after these lemmas compile should the restricted family be passed to the source's strengthened estimate. Cardinality assumptions must use |S_i'|, not silently reuse |S_i|.

## 4. Moment bridge remains a separate obligation

The generic identity
Γ = Σ_i p_i α_i(1 - α_i)
and bounds p_i >= 0, 0 <= α_i <= 1 imply Γ >= 0, but do not imply a uniform positive lower bound. The example p_i = 1/d and α_i = 1/d gives Γ = (1/d)(1 - 1/d) -> 0.

The source-specific proof must derive a quantitative positive-mass interior set, or a different geometric estimate, from the original covering hypotheses. Do not assume constants ε > 0 and m > 0 merely to invoke the generic lemma Γ >= ε(1-ε)m.

## 5. Source and axiom gates

- Confirm that the source's definition of hyperplane and parallelism exactly matches the implemented structure.
- Prove the restriction/coverage lemmas in Lean with the pinned toolchain.
- Audit all normalization denominators, including rational division at zero.
- Keep sf_sieve_lt_one and sieve_criterion out of the final theorem's transitive axiom set until source-faithful proofs replace them.
- A successful finite enumeration or CI run is not a proof of the unrestricted theorem.
