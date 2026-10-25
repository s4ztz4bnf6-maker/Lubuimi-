# BBMST source-faithful route: restore the filtration and moment bounds

Date: 2026-10-25

## Source anchor

The target is the square-free Erdős–Selfridge argument in Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), pp. 609–630, DOI 10.2140/ant.2021.15.609. Public source: https://par.nsf.gov/servlets/purl/10300177.

The relevant geometric model is a finite product Q = S₁ × ··· × Sₙ, with |Sᵢ| ≥ 2. A hyperplane fixes a nonempty coordinate set F(A); its other coordinates are free. The theorem's hypotheses require a collection of nontrivial hyperplanes with no two parallel, where parallel means equal fixed-coordinate sets. These properties must be derived from the actual representation, not supplied as unconstrained Boolean fields.

## Main proof architecture in the paper

The source proof is not primarily a global overlap-graph or covariance argument. Its engine is a coordinate filtration:

- Qₖ = S₁ × ··· × Sₖ.
- Fₖ consists of fixed-coordinate sets F contained in [k].
- Rₖ is the part of Q not covered by hyperplanes exposed by stage k.
- Nₖ = Fₖ minus Fₖ₋₁ and Bₖ is the union of the new hyperplanes at stage k.
- αₖ(x) is the fraction of the fibre over x ∈ Qₖ₋₁ removed by Bₖ.
- A modified measure Pₖ is chosen to preserve earlier-stage event mass while limiting the mass removed at stage k.

The key measure identities are the source's Lemma 2.1:
Pₖ(S) = Pₖ₋₁(S) for Qₖ₋₁-measurable S;
Pₖ(S) ≤ Pₖ₋₁(S)/(1−δₖ);
and Pₖ(S) ≤ Pₖ₋₁(S) for S ⊆ Bₖ.

Theorem 3.1 then bounds the removed mass using the first and second moments of αₖ:
Pₖ(Bₖ) ≤ min(Mₖ^(1), Mₖ^(2)/(4δₖ(1−δₖ))).
Theorem 3.2 supplies geometric upper bounds on these moments via the generating function cₖ₋₁(x). The strengthened second-moment bound additionally requires that no newly exposed hyperplane has codimension one; the paper handles codimension-one hyperplanes by removing them and shrinking the corresponding coordinate sets.

## Formalization plan and audit boundaries

1. Make the finite product and hyperplane representation source-faithful. Derive nontriviality and parallelism from fixed-coordinate sets.
2. Formalize the fibre-removal fraction αₖ as a finite cardinality ratio, with explicit nonempty-fibre and denominator conditions.
3. Prove normalization and the three measure identities as separate lemmas, including the edge cases δₖ = 0 and αₖ ∈ {0,1}.
4. Formalize the scalar inequality max(α−δ,0) ≤ α²/(4δ) only under δ > 0; do not silently divide by zero.
5. Prove Theorem 3.1 from the measure identities and moment definitions.
6. Prove Theorem 3.2's first- and second-moment estimates by counting fixed-coordinate sets, using the source's cₖ and ν generating functions.
7. Only after these lemmas compile should the full theorem be reconstructed. The existing exact pair-intersection/covariance identity is a useful independent combinatorial check, but it does not replace the source's geometric moment bounds.

## Why the covariance route is not enough

For product-box events E_H, E_K, the exact identity for the intersection cardinality is a useful local invariant. It does not by itself imply the required upper bounds on Mₖ^(1) and Mₖ^(2), nor the global strict inequality that leaves an uncovered point. An arbitrary overlap bound or a freely postulated no-codimension-one condition would change the theorem rather than prove it.

## Formal status

This file is a research roadmap, not a verified theorem. The current product-box CI must pass without sorryAx; the source theorem's moment bounds remain the substantive proof obligation.
