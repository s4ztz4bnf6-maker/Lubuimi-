# BBMST product-sum to cylinder-mass research plan (2026-10-23)

## Status discipline
The finite product-sum identity has been added as a separate Lean module and a dedicated CI step. At the time checked, workflow run 39908203447 was queued, so the identity was not yet CI-confirmed. The existing coordinate geometry is a sandbox model, not yet a source-faithful formalization of BBMST Theorems 3.1/3.2.

## Literature connection and its limit
Balister, Bollobás, Morris, Sahasrabudhe and Tiba, Erdős covering systems, Acta Math. Hungar. 161 (2020), 540–549, present the distortion method and its hyperplane perspective. Their later On the Erdős covering problem: the density of the uncovered set, Invent. Math. 228 (2022), 377–414, gives further structural and uncovered-density results. The transferable lesson is that the useful estimate is not a naive union bound alone: one must encode how the measure is distorted as stages remove mass and control overlap/compatible intersections. The literature does not justify declaring arbitrary coordinate events independent; independence follows only from a genuine product measure.

## Current formal bridge
CoordinateWeightSystem explicitly gives coordinate weights summing to one. factorizedPointWeight_total_mass establishes normalization of the induced product weight. factorizedPointWeight_split_on_cylinder splits each point weight into fixed-coordinate and free-coordinate factors. The missing step is to sum over the cylinder and eliminate all free-coordinate sums, yielding the cylinder probability as the product of prescribed coordinate weights.

## Exact target theorem
For a cylinder H fixing a finite coordinate set F to values vᵢ, prove
P(H) = ∏_{i∈F} wᵢ(vᵢ),
where P(H) is the finite sum of the factorized point weight over all x satisfying H.Contains x. The proof should:
1. rewrite the event sum as a sum over the dependent product with fixed coordinates constrained;
2. use a finite product-sum factorization to separate fixed and free coordinates;
3. use each coordinate normalization ∑ᵧ wᵢ(y)=1 on every free coordinate;
4. preserve the exact subtype/domain constraints, so no hidden assumption that all coordinates share the same carrier is introduced.

A robust alternative if the filtered sum is awkward in Lean: define a cylinder mass through a Finset of assignments to the free coordinates, build the unique extension map from free assignments to full points, prove it is bijective onto H.Contains, and transport the sum along that equivalence. This avoids fragile rewriting of dependent filters and gives a reusable combinatorial lemma.

## Why the next bound remains difficult
The cylinder-mass formula gives exact marginals under the base product measure. It does not by itself yield BBMST's second-moment estimate: intersections depend on shared-coordinate compatibility, and the distorted stage measures may not remain simple products. The correct next separation is:
- exact geometry: characterize compatible intersections;
- base product measure: prove cylinder mass;
- distortion: prove a pointwise or Radon–Nikodym-style bound at each stage;
- moment estimate: sum only over the source-defined compatible pairs and prove the actual combinatorial inequality.
Do not use a free NoCodimensionOneAt premise as evidence that the source arithmetic configuration satisfies it; prove the premise from the encoded stage construction.

## Next CI gates
- Compile FiniteProductSumAudit.lean and inspect its axiom report.
- Prove the cylinder-mass theorem in a separate module importing both geometry and product-sum lemma.
- Test edge cases: F empty, F all coordinates, singleton coordinate domains, and zero coordinate weights.
- Only then wire the theorem into BBMSTIntersectionMass.lean.
