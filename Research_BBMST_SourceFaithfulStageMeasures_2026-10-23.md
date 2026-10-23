# Research note: cylinder mass versus the BBMST distorted measures

Date: 2026-10-23

## Current model boundary

`BBMSTGeometryTest.lean` defines a finite coordinate product, a genuinely factorized coordinate-weight system, an exact one-coordinate cylinder sum, and the identity `cylinderCoordinateSums_product_eq`. The source file itself correctly says that the bridge from this separated coordinate expression to `eventMass` is still open.

There is a more important distinction to preserve: the cylinder identity for a **product** distribution is not, by itself, the BBMST geometric estimate. The original argument uses a sequence of measures (such as P_k and Q_k) and quantitative control of hyperplanes as coordinates are exposed. A generic normalized joint distribution need not have independent coordinates, and a product-measure calculation cannot silently be applied to a distorted intermediate measure.

## Source-faithful obligations

Balister, Bollobás, Morris, Sahasrabudhe and Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–650, DOI 10.2140/ant.2021.15.609, gives a useful proof blueprint.

- Lemma 3.3 is an induction in the stage k for a Q_k-measurable hyperplane A. If F(A)=I union J with I in the initial coordinates and J in the exposed block, the target bound is P_k(A) <= c(I) nu(J). The proof distinguishes k not in F(A) (inherit the previous-stage estimate) from k in F(A), where the one-step density distortion and the normalization by |S_k| enter.
- Lemma 3.4 is a structural dichotomy for a minimal cover: either many hyperplanes have a large projected measure, or a weighted sum over hyperplanes of larger support is large. Its output is combinatorial and is used with a local-lemma argument; it is not equivalent to a generic good/bad transfer inequality.
- The square-free-moduli hypothesis and the source's specific definitions of F(A), P_k, Q_k, c, nu, delta_k, epsilon and lambda are mathematical data, not cosmetic names. A faithful formalization must encode and prove their invariants rather than declare arbitrary coordinate hyperplanes to be the source's hyperplanes.

## Immediate Lean plan

1. Keep the product-measure cylinder identity as an independent lemma. Prove the event-mass bridge by an explicit finite sum over points, with the indicator/filter equivalent to `H.Contains`; do not call it a BBMST theorem.
2. Define the stage-indexed measures and measurable-hyperplane predicate from the pinned source definitions. State the stage transition and normalization facts as explicit hypotheses first, then prove the Lemma 3.3 induction.
3. Formalize Lemma 3.4 as a separate combinatorial theorem about a minimal cover, with its actual alternatives and constants. Do not derive it from `eventMass_le_good_bad_transfer`.
4. Only after the stage lemmas compile and their assumptions are source-faithful should the moment/covering conclusion be instantiated.

## Exact warning

The generic theorem `eventMass_le_good_bad_transfer` is useful only if its good-state pointwise bound and bad-state mass estimate have already been established for the actual measures. It does not produce those estimates. Likewise, a finite union bound proves survival only when the sum of forbidden-event masses is below one; that strict numerical inequality remains a substantive theorem to prove.

The next focused theorem is therefore not “BBMST follows from product independence.” It is the finite event-mass/filter identity for the product model, followed by a separately modeled P_k/Q_k stage-transition lemma faithful to the paper.
