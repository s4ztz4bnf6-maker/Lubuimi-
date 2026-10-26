# Research roadmap: source-faithful BBMST moment proof

Status: formalization plan grounded in the published proof. It does not claim that the current coordinate sandbox proves Theorems 3.1 or 3.2.

## 1. Correct source and proof architecture

Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe, and Marius Tiba, “The Erdős–Selfridge problem with square-free moduli,” Algebra & Number Theory 15 (2021), no. 3, 609–626, https://doi.org/10.2140/ant.2021.15.609; preprint https://arxiv.org/abs/1901.11465.

Do not confuse it with the same authors' “On the Erdős covering problem: the density of the uncovered set,” Inventiones Mathematicae 228 (2022), 377–414, https://doi.org/10.1007/s00222-021-01087-5. The papers are related but have different theorem architectures.

In the square-free-moduli paper, the proof's probability objects evolve by stages. Lemma 3.3 controls the measure of a measurable hyperplane inductively, with a bound of the form Pₖ(A) ≤ c(I) ν(J) for the source's fixed-coordinate decomposition F(A)=I∪J. Lemma 3.4 bounds moments of αₖ by expanding the union-bound estimate for αₖ(x) into compatible hyperplane intersections and applying the hyperplane-measure estimate to the union of fixed-coordinate sets. The published moment estimate is therefore not a generic consequence of a product-weight identity alone.

## 2. What the current Lean sandbox establishes

BBMSTGeometryTest.lean defines finite coordinate spaces, coordinate cylinders, normalized joint distributions, and a separate genuinely factorized coordinate-weight system. It proves overlap compatibility, disjointness on a conflicting shared coordinate, product normalization, and coordinatewise cylinder-sum identities.

BBMSTIntersectionMass.lean proves that an incompatible cylinder intersection has zero event mass and that an intersection is bounded by either marginal. These are sound but intentionally weaker than an exact intersection-mass factorization.

The current gap is explicit: the product of the one-coordinate cylinder sums has been evaluated, but the theorem equating that separated product with the sum of factorizedPointWeight over all points satisfying H.Contains has not yet been proved. Also, ProductDistribution allows arbitrary normalized joint weights; independence must not be inferred for that type. Use CoordinateWeightSystem for product-measure arguments.

## 3. Priority bridge lemmas

1. Cylinder mass theorem. For factorized weights, prove
   Σ x, if H.Contains x then factorizedPointWeight w x else 0
   equals the product of prescribed coordinate weights over H.fixed. This is the missing finite Fubini/reindexing bridge. Prove it first for a single cylinder, using finite dependent products and coordinate normalization.
2. Intersection mass theorem. If two cylinders agree on the overlap of their fixed-coordinate sets, their intersection is the cylinder fixing the union. Combine this set equality with the cylinder-mass theorem to derive the exact intersection formula. If they disagree at a shared coordinate, the existing zero-mass theorem applies.
3. Moment expansion. Define the finite random variable αₖ from the source's actual stage objects. Prove the t=2 identity/inequality by expanding the finite sum over ordered pairs of hyperplanes, then partition pairs into incompatible and compatible cases. Avoid assuming independence for an arbitrary ProductDistribution.
4. Lemma 3.3 induction. Represent the source's stage transition explicitly, including the 1/(1-δₖ) factor and the source-defined functions c and ν. Prove the induction step on measurable hyperplanes rather than encoding the desired bound as a field.
5. Lemma 3.4 finite moment bound. Formalize the union-bound expansion of αₖ(x) first; then lift the hyperplane measure bound to each union of fixed-coordinate sets. Only after this generic moment lemma is kernel-checked should the special improved estimate be derived.
6. No-codimension-one obligation. Define codimension one exactly as the source does for the coordinate model (a single fixed coordinate), but separately prove that the actual arithmetic stage family excludes such hyperplanes. Do not add noCodimOneAt as an unconstrained hypothesis merely to make the final theorem type-check.

## 4. Alternative architecture if dependent finite-product sums become brittle

- Separate the proof into a combinatorial cylinder layer (compatibility, union of fixed sets, disjointness) and a measure layer (point weights, normalization, event mass).
- Prove a general finite product-sum/Fubini lemma once, independent of BBMST names, then instantiate it for cylinders.
- Keep the source's Pₖ, Qₖ, αₖ, Nₖ, and c,ν notation close enough to the paper that each Lean theorem has a traceable source lemma.
- If an exact moment formula is too strong for an intermediate step, prove the source's upper bound through the union-bound expansion and compatible-intersection estimate. Do not replace a missing proof with a free assumption.
- The good/bad additive-error lemma μ(E) ≤ C ν(E)+η is a valid auxiliary tool for robustness, but it does not replace the source-specific induction or the no-codimension-one argument.

## 5. Audit acceptance criteria

- Each source-specific theorem must state its exact hypotheses and cite the corresponding source lemma/equation in comments.
- #print axioms is a kernel dependency audit, not evidence that the theorem's mathematical model matches the paper; source alignment must be checked separately.
- Any sorryAx, sorry, or hidden assumption requires investigation before a theorem is described as verified.
- Keep the general moment estimate, improved estimate, and arithmetic no-codimension-one verification as separate milestones.
