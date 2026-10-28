# BBMST source-definition map: Phase A

**Scope:** source-faithful specification before Lean implementation. This document is a mapping and gap analysis, not a proof of Theorem 3.2.

## Primary source and verification standard

Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe and Marius Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15(3) (2021), 609–626. DOI: 10.2140/ant.2021.15.609. Published PDF: https://ora.ox.ac.uk/objects/uuid%3A3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s

The source text returned for Lemma 3.3 identifies equation (15) and explicitly refers back to definitions (4), (5), and (9). The exact notation and hypotheses must be transcribed from the paper itself before implementing the corresponding Lean objects. Do not treat a search-result snippet as a substitute for checking the complete definition.

## Definition map

| BBMST object | What is established from the published source available in this audit | Existing audit Lean status | Semantic gap / required correction |
|---|---|---|---|
| Coordinate sets S_i and product spaces Q_k | The paper uses finite coordinate sets and the product-space relation Q_k = Q_{k-1} × S_k. The published proof of Lemma 3.3 works with P_k, the measure on the corresponding product space. | BBMSTGeometryTest.lean has CoordinateSpace with finite nonempty S : Fin n → Finset ℚ, and a coordinate-point type. BBMSTProbabilityRecursionTest.lean has a toy finite-fiber probability/alpha model. | These are scaffolds, not yet a transcription of the paper's complete definitions, indexing conventions, measures, or hypotheses. Define the exact finite product type and probability measure from the source, and prove the recursive measure identity rather than assuming it. |
| Q_k | Product of the first k coordinate sets; equation (4) is cited in the proof of Lemma 3.3 for the recursion of P_k. | No confirmed source-faithful Q_k declaration in the current test scaffold. | Record whether the paper indexes coordinates by [k], uses a restricted product, and how points are coerced/projected between Q_k and Q_{k-1}. Make these choices explicit in Lean. |
| Hyperplane A, fixed-coordinate set F(A) | Lemma 3.3 states a bound for a Q_k-measurable hyperplane and splits F(A) = I ∪ J, with I ⊆ [a], J ⊆ [a+1,k]. Lemma 3.4 uses that intersections of hyperplanes are either empty or a hyperplane whose fixed-coordinate set is the union of the fixed-coordinate sets. | BBMSTGeometryTest.lean defines a coordinate cylinder with a fixed coordinate subset and assigned values. | A cylinder model may be useful, but must be checked against the paper's definition of “hyperplane,” including allowed fixed-coordinate sets, nontriviality, and coordinate-value constraints. The Lean object must expose a mathematically defined F(A) and support the source's intersection lemma; do not equate this automatically with arbitrary affine hyperplanes. |
| N_k | Theorem 3.2's improved estimate is conditioned on the paper's “no singletons” condition for F(N_k), stated equivalently there as {k} not in N_k in the paper's convention. The exact definition of N_k and the family operator must be transcribed from the full source before coding. | No verified source-faithful N_k declaration in the current test scaffold. | Do not replace this with a free noCodimOne : Prop field or with NotParallel defined merely by inequality of fixed-coordinate sets. Define the family from the paper's construction, then prove the no-singletons fact from its actual hypotheses if it holds. |
| B_k | A supporting lecture slide by Robert Morris records the distortion-method notation B_k as the set covered by hyperplanes with max(F(A)) = k, and alpha_k(x) = |{y in S_k : (x,y) in B_k}|/|S_k|. This is useful corroboration, but the paper remains authoritative for the exact formulation. | The probability-recursion test contains a simplified finite-fiber alpha analogue, not a proven correspondence to the source's B_k. | Transcribe the exact definition of B_k from the paper and prove the fiber formula for alpha_k from it. Verify whether the source excludes trivial hyperplanes and how the maximum of F(A) is defined. |
| alpha_k(x) | The source's second-moment argument concerns the fiber density of the set covered at stage k. The published proof of Lemma 3.4 bounds E_{k-1}[alpha_k(x)^t] by a sum over F_1,...,F_t in N_k, with coefficient terms involving the union of their fixed-coordinate sets. | Toy finite-fiber alpha bounds exist. | Need a source-level definition, proof of measurability/range, and the exact moment expansion and union-bound steps. A toy alpha lemma alone does not establish Lemma 3.4 or Theorem 3.2. |
| Theorem 3.2 moment bounds | General bound: M_k^(2) ≤ c_{k-1}(3)/|S_k|^2. Improved bound: M_k^(2) ≤ [c_{k-1}(3)-2c_{k-1}(1)+1]/|S_k|^2, under the source's no-singletons condition. Lemma 3.3 is equation (15); Lemma 3.4 supplies the moment estimate used in the proof. | BBMSTMomentBoundsInterface.lean states a conditional contract, while BBMSTMomentInequalities.lean contains separate algebraic inequalities. | These contracts are not proofs of the source's probabilistic estimates. The geometric/probability lemmas must be proved from the definitions before the conditional improved estimate can be connected. |

## Existing test scaffold: precise limits

- BBMSTGeometryTest.lean: CoordinateSpace, coordinate points, coordinate cylinders, a preliminary NotParallel predicate, and a product-distribution structure. Its NotParallel predicate is explicitly not the paper's full geometric notion.
- BBMSTProbabilityRecursionTest.lean: elementary bounds for a toy finite-fiber alpha.
- BBMSTMomentBoundsInterface.lean: a contract that accepts the general and improved bounds as fields. It does not derive them.
- BBMSTMomentInequalities.lean: algebraic inequalities independent of the source geometry.

## Phase A acceptance criteria

Before adding source-faithful Lean geometry, verify from the full paper and record page/equation/definition references for:

1. The exact definitions of Q_k, P_k, and the restriction/projection maps.
2. The exact definition of a hyperplane in Q_k, and of F(A).
3. The exact construction of N_k, B_k, and alpha_k.
4. The exact meaning and hypotheses of the no-singletons condition.
5. The statements and proof dependencies of equations (4), (5), (9), (15), Lemma 3.4, and Theorem 3.2.

Only after these have been checked should the definitions be encoded in Lean. The first formalization target should be definitional correspondence and basic lemmas (projections, intersections, fibers, and measure recursion), not the improved moment inequality.

## Audit discipline

- Keep all work on audit/bbmst-alpha-fiber-lemmas-2026-10-28; do not modify main or the upstream repository.
- Do not claim a Lean build or CI pass from this documentation-only commit.
- Do not claim that a source-faithful formalization exists until the above acceptance criteria are met.
- Do not introduce sorry, sorryAx, or new mathematical axioms to bridge missing definitions.