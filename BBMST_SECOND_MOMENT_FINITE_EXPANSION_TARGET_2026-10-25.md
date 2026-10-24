# BBMST second moment: formal target and boundary conditions

## Exact finite identity

Let Ω be a finite probability space and let E : ι → Set Ω be a family indexed by a finite type ι. Define m(ω) = ∑ i, 1_{E i}(ω). Then, pointwise,

m(ω)^2 = ∑ i, ∑ j, 1_{E i ∩ E j}(ω).

Taking expectation gives E[m²] = ∑ i, ∑ j, P(E i ∩ E j).

This identity requires no independence assumption. It is an exact finite expansion, and is the correct Lean target before introducing BBMST-specific geometry.

## Product-box substitution

For a uniform finite product space with nonempty coordinate spaces S_t, a box fixing coordinates A has mass ∏ t∈A, (|S_t|)⁻¹. If two boxes are compatible, their intersection fixes the coordinates in A ∪ B; if they conflict, the intersection is empty. Therefore the pair sum decomposes into compatible pairs with their exact shared-coordinate weights and conflicting pairs of weight zero.

## What is not automatic

The expansion does not itself give an upper bound on the second moment. A bound requires a combinatorial estimate for the weighted count of compatible pairs, plus the exact BBMST hypotheses and normalizations for the relevant hyperplanes/fibers. An arbitrary overlap-graph degree estimate is not a substitute unless proved sufficient under those hypotheses.

## Lean implementation plan

1. Define an indicator as a 0/1-valued function or use finite sums of event indicators.
2. Prove the pointwise square expansion by finite-sum multiplication and indicator multiplication.
3. Exchange finite sums and expectation using finite-sum linearity.
4. Instantiate the result with the source's finite hyperplane family and actual measure.
5. Prove the source-specific compatible-pair bound only after verifying the published definitions and version-sensitive hypotheses.

## Audit conditions

- Empty index type and empty events must work without special informal exceptions.
- Conflicting boxes contribute exactly zero.
- Coordinate state spaces must be nonempty before uniform probabilities are inverted.
- No source-specific inequality is claimed until its constants and assumptions match the published version.
- Compile and audit the dependency closure before calling this a formal result.