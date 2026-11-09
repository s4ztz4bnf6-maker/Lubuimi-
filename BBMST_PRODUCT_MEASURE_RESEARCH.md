# Product probability model: audit findings and implementation target

## Current model limitation

In `BBMSTGeometryTest.lean`, `ProductDistribution` stores a nonnegative weight
on the finite product space and assumes total mass one. This is a normalized
probability distribution on a product-shaped sample space, but it does **not**
enforce coordinate independence or factorization. Consequently, existing
event-mass lemmas are elementary finite probability identities, not a formal
reconstruction of the BBMST product-measure argument.

## Literature adaptation

Balister, Bollobás, Morris, Sahasrabudhe and Tiba, *The Erdős–Selfridge problem
with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626, develops
coordinate measures and bounds the measure of hyperplanes, then controls moments
of the random variable α_k. In the proof, the key estimates are not just the
generic union bound: Lemma 3.3 bounds hyperplane mass through the coordinate
functions c(I) and ν(J), and Lemma 3.4 bounds moments by summing over tuples of
newly exposed hyperplanes. The published proof then uses these bounds in the
second-moment estimate.

## Formalization plan

1. Keep `ProductDistribution` as the general-distribution baseline; do not silently
   reinterpret it as independent.
2. Add a separate factorized distribution structure with coordinate weights,
   a pointwise factorization equation, and explicit normalization evidence.
3. Prove that events determined by disjoint coordinate sets are independent for
   this factorized structure. State all finite-product and nonemptiness hypotheses.
4. Formalize the coordinate projection of a hyperplane and prove the source-style
   recursive mass bound corresponding to Lemma 3.3.
5. Define α_k as a finite average of indicators for newly exposed hyperplanes;
   prove the tuple expansion/bound corresponding to Lemma 3.4.
6. Derive the second-moment estimate and identify exactly where the source's
   hypotheses on the hyperplane family are used.
7. Only after that, connect the geometric model to the arithmetic covering-system
   data and prove the required no-codimension-one property from the construction.
   Never postulate it as a free axiom.

## Acceptance criteria

- Lean kernel compilation and `#print axioms` for factorization, independence,
  hyperplane mass bounds and moment bounds.
- Include a counterexample showing that total mass one alone does not imply
  independence; this protects the model boundary.
- No claim that the current geometry sandbox already proves BBMST Theorem 3.1 or 3.2.
