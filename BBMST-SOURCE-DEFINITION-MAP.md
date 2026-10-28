# BBMST source-definition map: Phase A

**Scope:** source-faithful specification before Lean implementation. This document is a mapping and gap analysis, not a proof of Theorem 3.2.

## Primary source and verification standard

Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe and Marius Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15(3) (2021), 609–626. DOI: 10.2140/ant.2021.15.609. Published PDF: https://ora.ox.ac.uk/objects/uuid%3A3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s

The published source text on p. 612 gives the setup for the hyperplane family, \(\mathcal F\), \(\mathcal F_k\), \(\mathcal A_k\), \(R_k\), \(\mathcal N_k\), and \(B_k\) explicitly. Lemma 3.3 on p. 616 states equation (15) and refers to equations (4), (5), (9), and (10). The table below records only the parts verified in the accessible published text; further implementation should check the complete definitions and preceding page for the underlying hyperplane definition.

## Definition map

| BBMST object | What is established from the published source available in this audit | Existing audit Lean status | Semantic gap / required correction |
|---|---|---|---|
| Coordinate sets S_i and product spaces Q_k | The paper uses finite coordinate sets and the product-space relation Q_k = Q_{k-1} × S_k. The published proof of Lemma 3.3 works with P_k, the measure on the corresponding product space. | BBMSTGeometryTest.lean has CoordinateSpace with finite nonempty S : Fin n → Finset ℚ, and a coordinate-point type. BBMSTProbabilityRecursionTest.lean has a toy finite-fiber probability/alpha model. | These are scaffolds, not yet a transcription of the paper's complete definitions, indexing conventions, measures, or hypotheses. Define the exact finite product type and probability measure from the source, and prove the recursive measure identity rather than assuming it. |
| Q_k | Product of the first k coordinate sets; equation (4) is cited in the proof of Lemma 3.3 for the recursion of P_k. | No confirmed source-faithful Q_k declaration in the current test scaffold. | Record whether the paper indexes coordinates by [k], uses a restricted product, and how points are coerced/projected between Q_k and Q_{k-1}. Make these choices explicit in Lean. |
| N_k | On p. 612 the paper defines F_k = {F in F : F ⊆ [k]}, A_k = {A_F : F in F_k}, and N_k = F_k \ F_{k-1}; thus N_k consists exactly of the new fixed-coordinate sets contained in [k], i.e. sets containing k. Theorem 3.2's improved estimate uses the no-singletons condition for F(N_k), expressed in the paper's convention as {k} not in N_k. | No verified source-faithful N_k declaration in the current test scaffold. | Implement N_k as a set difference of the source-defined families, not as a free parameter. Then encode the exact singleton-exclusion hypothesis and prove any use of it from the relevant structural assumptions; do not assume it follows automatically for every collection. |
| N_k | Theorem 3.2's improved estimate is conditioned on the paper's “no singletons” condition for F(N_k), stated equivalently there as {k} not in N_k in the paper's convention. The exact definition of N_k and the family operator must be transcribed from the full source before coding. | No verified source-faithful N_k declaration in the current test scaffold. | Do not replace this with a free noCodimOne : Prop field or with NotParallel defined merely by inequality of fixed-coordinate sets. Define the family from the paper's construction, then prove the no-singletons fact from its actual hypotheses if it holds. |
| B_k | Equation (1), p. 612, defines B_k = ⋃_{F∈N_k} A_F, the union of hyperplanes exposed at stage k, and the paper states R_k = R_{k-1} \ B_k. It then identifies sets measurable with respect to the first k coordinates as subsets of Q_k = S_1 × ⋯ × S_k (via extension by the remaining coordinates). | The probability-recursion test contains a simplified finite-fiber alpha analogue, not a proven correspondence to the source's B_k. | Implement B_k as the actual union indexed by source-defined N_k and A_F. Prove the relationship to R_k and the restriction/projection identities instead of using an unrelated toy set. |
| alpha_k(x) | Lemma 3.4, p. 616, and its proof use alpha_k(x) = (1/|S_k|) Σ_{y∈S_k} 1[(x,y)∈B_k], and bound it by the corresponding sum of indicators over F∈N_k. For each x and F, a y with (x,y)∈A_F exists iff x∈A_F^[k−1], and if it exists it is unique. The lemma then bounds the t-th moment by a sum over F_1,...,F_t∈N_k using the union of their fixed-coordinate sets. | Toy finite-fiber alpha bounds exist. | Formalize the exact indicator/fiber formula, uniqueness, and the intersection-to-union argument; then prove the source's moment bound. The toy alpha lemma alone does not establish Lemma 3.4 or Theorem 3.2. |
| Theorem 3.2 moment bounds | General bound: M_k^(2) ≤ c_{k-1}(3)/|S_k|^2. Improved bound: M_k^(2) ≤ [c_{k-1}(3)-2c_{k-1}(1)+1]/|S_k|^2, under the source's no-singletons condition. Lemma 3.3 is equation (15); Lemma 3.4 supplies the moment estimate used in the proof. | BBMSTMomentBoundsInterface.lean states a conditional contract, while BBMSTMomentInequalities.lean contains separate algebraic inequalities. | These contracts are not proofs of the source's probabilistic estimates. The geometric/probability lemmas must be proved from the definitions before the conditional improved estimate can be connected. |

## Existing test scaffold: precise limits

- BBMSTGeometryTest.lean: CoordinateSpace, coordinate points, coordinate cylinders, a preliminary NotParallel predicate, and a product-distribution structure. Its NotParallel predicate is explicitly not the paper's full geometric notion.
- BBMSTProbabilityRecursionTest.lean: elementary bounds for a toy finite-fiber alpha.
- BBMSTMomentBoundsInterface.lean: a contract that accepts the general and improved bounds as fields. It does not derive them.
- BBMSTMomentInequalities.lean: algebraic inequalities independent of the source geometry.

## Phase A acceptance criteria

Before adding source-faithful Lean geometry, verify from the full paper and record page/equation/definition references for:

1. The exact definitions of the underlying hyperplanes and their fixed-coordinate sets on pp. 611–612, as well as Q_k, P_k, and restriction/projection maps.
2. The exact definition of a nontrivial hyperplane and the paper's meaning of parallelism; confirm the p. 612 indexing F ↦ A_F.
3. The p. 612 definitions of F_k, A_k, N_k and equation (1) for B_k, followed by the definition of alpha_k (equation (2)).
4. The exact meaning and hypotheses of the no-singletons condition.
5. The statements and proof dependencies of equations (4), (5), (9), (15), Lemma 3.4, and Theorem 3.2.

Only after these have been checked should the definitions be encoded in Lean. The first formalization target should be definitional correspondence and basic lemmas (projections, intersections, fibers, and measure recursion), not the improved moment inequality.

## Audit discipline

- Keep all work on audit/bbmst-alpha-fiber-lemmas-2026-10-28; do not modify main or the upstream repository.
- Do not claim a Lean build or CI pass from this documentation-only commit.
- Do not claim that a source-faithful formalization exists until the above acceptance criteria are met.
- Do not introduce sorry, sorryAx, or new mathematical axioms to bridge missing definitions.
## A1–A4: source-faithful hyperplanes and intersection algebra

### Primary definition (published paper, p. 610; Theorem 1.2 setup)

Let each coordinate set `S_i` be finite with at least two elements and let `Q = S_1 × ⋯ × S_n`. A hyperplane is a product `A = A_1 × ⋯ × A_n ⊆ Q` where each `A_i` is either the full coordinate set `S_i` or a singleton subset of `S_i`. The paper writes `A = [x_1, …, x_n]`, where each `x_i` is either an element of `S_i` or the wildcard `*`; the wildcard means the coordinate is unrestricted. The fixed-coordinate set is `F(A) = {i : x_i ∈ S_i}`. A hyperplane is nontrivial iff `F(A) ≠ ∅`. Two hyperplanes are parallel iff their fixed-coordinate sets are equal. See the published source, Section 1, pp. 609–610, immediately before Theorem 1.2.

### Intersection lemma: exact mathematical statement

Write a hyperplane as a partial assignment `x : F(A) → ⋃ᵢ S_i`, with `x(i) ∈ S_i`. For two hyperplanes `A` and `A'`:

- If there exists a coordinate `i ∈ F(A) ∩ F(A')` at which the assigned values differ, then `A ∩ A' = ∅`.
- Otherwise the assignments agree on all shared fixed coordinates; the intersection is the coordinate cylinder/hyperplane obtained by combining the assignments, and its fixed-coordinate set is `F(A) ∪ F(A')`.

**Important qualification:** the source's phrase “a hyperplane” for the intersection must be handled carefully if the intersection is the whole space (empty fixed-coordinate set) or if later arguments require a *nontrivial* hyperplane. The bare intersection statement should allow the trivial whole-space product when both fixed-coordinate sets are empty; for the paper's nontrivial input hyperplanes, their union of fixed-coordinate sets is nonempty, so a nonempty intersection remains nontrivial.

### Lean specification target (not yet implemented)

Use a finite coordinate index type and a dependent family `S : ι → Type` with finite instances and `2 ≤ Fintype.card (S i)`. Represent a hyperplane by a partial coordinate assignment, e.g. `σ : ∀ i, Option (S i)`, with `none` meaning unrestricted and `some x` meaning fixed to `x`. Define membership pointwise. Define `fixedSet σ = {i | (σ i).isSome}` and define parallelism by equality of `fixedSet`, matching the paper. Do not use the existing test file's `NotParallel` predicate as a replacement for this source definition.

Prove, from the definitions, the following lemmas before proceeding to probability:

1. `mem_inter_iff`: membership in the intersection is membership in both hyperplanes.
2. `inter_empty_of_conflicting_assignments`: conflicting values at a shared fixed coordinate imply disjointness.
3. `compatible_assignments_inter`: if assignments agree on shared fixed coordinates, the intersection is represented by their merged partial assignment.
4. `fixedSet_merge`: the merged assignment's fixed set is exactly the union of the two fixed sets.
5. `inter_eq_empty_or_merge`: the intersection is empty or equals the merged hyperplane.

These are specification targets, not claims that Lean declarations or compiled proofs already exist.

### Link to the families on p. 612

Once the hyperplane and `F(A)` definitions are fixed, the source defines `F = {F(A) : A ∈ A}` for a collection of nontrivial hyperplanes with no two parallel, then indexes the collection as `A = {A_F : F ∈ F}`. Since `F(A)` is injective on this collection by the nonparallel assumption, the notation `A_F` is well-defined. The families `F_k`, `A_k`, and `N_k` and the set `B_k` are then defined as recorded above. This dependence order is essential: do not define `N_k` independently of the source family `F`.

### Source reference

Published version: Balister et al., *Algebra & Number Theory* 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609. The definition of a hyperplane and `F(A)` appears in the geometric setup preceding Theorem 1.2 on pp. 609–610; the family definitions `F`, `F_k`, `A_k`, `N_k`, and `B_k` appear on p. 612; Lemma 3.4's intersection/moment argument appears on p. 616. Published PDF: https://ora.ox.ac.uk/objects/uuid%3A3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s.

### Audit status

This section records the source definition and a derived elementary intersection specification. No Lean code was added in this commit, and no build or CI status is claimed. In particular, this intersection lemma is not yet a proof of Lemma 3.4 or Theorem 3.2.