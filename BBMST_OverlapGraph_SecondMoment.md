# Research note: overlap-sensitive second moments for BBMST

Status: strategy note; no new theorem is claimed until the Lean audit compiles it.

## Literature-grounded constraint

Balister–Bollobás–Morris–Sahasrabudhe–Tiba's distortion method for covering systems is not simply a pairwise-independence argument. Its strength comes from tracking how conditioning/distortion changes the weight of later events. The 2020 exposition explicitly frames the method in terms of distortion and hyperplanes; the 2022 Inventiones paper obtains strong uncovered-density bounds and also demonstrates that a crude reciprocal-modulus statistic alone is not enough in the unrestricted setting.

References:
- https://doi.org/10.1007/s10474-020-01048-z
- https://doi.org/10.1007/s00222-021-01087-5

The formalization should therefore avoid replacing the source's distortion estimates with a generic independence axiom or a bare sum of marginal probabilities.

## Exact finite probability layer

Let the sample space be a finite product X = ∏ᵢ Xᵢ, with coordinate weights wᵢ and product weight w(x) = ∏ᵢ wᵢ(xᵢ). For a cylinder H fixing coordinates F to values vᵢ, finite product-sum factorization gives

  mass(H) = (∏ᵢ∈F wᵢ(vᵢ)) · (∏ᵢ∉F mass(Xᵢ)).

If each coordinate law is normalized, the second factor is 1. This should be derived from a finite product-sum identity and coordinate normalization, not assumed as a theorem about arbitrary events.

For two cylinders H and K:
1. If they prescribe different values at a shared fixed coordinate, H ∩ K is empty, so its mass is exactly zero.
2. If their prescriptions agree on the overlap, the intersection is a cylinder on the union of the fixed-coordinate sets; shared coordinates are counted once.
3. For arbitrary events, only the always-valid inequalities mass(H ∩ K) ≤ min(mass(H), mass(K)) are available absent additional structure.

## Proposed innovation: overlap graph / cluster correction

Construct a graph whose vertices are the source hyperplanes/events and whose edges record a nontrivial coordinate overlap. Label each edge with the overlap type (compatible, incompatible, or source-defined parallel/intersection geometry). Then decompose the second moment

  E[Z²] = Σᵢ mass(Hᵢ) + Σᵢ≠ⱼ mass(Hᵢ ∩ Hⱼ)

by edge type, rather than treating every pair alike. Incompatible edges vanish exactly. Compatible edges use the source's intersection mass. Pairs with no shared fixed coordinates may factor only after the product law and event definitions prove that factorization.

This representation is useful because any later distortion bound can be attached to the precise overlap class where it is needed. It also gives a regression target: changing the geometry layer must not silently change the probability formula.

## Proof obligations before claiming a BBMST result

- Compile the generic finite product-sum identity independently.
- Prove the cylinder mass formula from normalized coordinate weights.
- Prove compatible-cylinder intersection mass and contradictory-cylinder zero mass.
- Derive, rather than postulate, every distortion inequality needed by the BBMST source.
- Keep the finite parameter assumptions explicit and test degenerate cases (empty fixed set, contradictory witnesses, and boundary values).
- Run `#print axioms` on the exported theorem and reject any `sorryAx` dependency.

This is a formalization architecture, not a proof of the BBMST theorem itself.
