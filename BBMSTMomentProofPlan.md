# BBMST second-moment audit: source-faithful proof plan

## Main target
Before attempting the improved second-moment estimate, prove the published general estimate from the finite probability space and hyperplane family:
M_k^(2) <= c_{k-1}(3) / |S_k|^2.

## Proof decomposition
1. Define the finite product spaces, hyperplanes, and the actual stage family with explicit coordinate sets. Do not replace the geometric hypotheses by unconstrained predicates.
2. Prove the fibre-extension measure inequalities, including zero-mass fibres and endpoint cases. Keep denominators guarded by positivity hypotheses.
3. Prove the hyperplane propagation estimate corresponding to published Lemma 3.3 by induction on the stage. Separate the case where the new coordinate is not fixed from the case where it is fixed.
4. For the second moment, expand the indicator/union-bound majorant for alpha_k(x), raise it to the t-th power, and index the terms by compatible hyperplane intersections. For t=2, use the corresponding two-hyperplane expansion.
5. Bound each intersection using the propagated hyperplane estimate, then sum the finite terms and normalize by |S_k|^2.
6. Only after the general bound is derived, formalize the extra no-codimension-one condition for the concrete stage family and derive the improved numerator c_3 - 2*c_1 + 1.
7. Verify exact rational parameter certificates separately from the analytic inequalities. Any external optimizer output is a candidate certificate, not a proof until exact checks pass.

## Current interface caveat
GeneralSecondMomentBound currently packages the inequality as a field. It is a certificate interface, not a derivation. The goal is to replace or supplement it with a theorem proved from the finite probability and incidence definitions. Likewise improvedSecondMomentClaim is correctly a proposition rather than a field, but remains unproved.

## Published source
Balister, Bollobás, Morris, Sahasrabudhe, Tiba, “The Erdős–Selfridge problem with square-free moduli,” Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609.
Published Lemma 3.3 propagates hyperplane weights through stages; Lemma 3.4 bounds positive integer moments by compatible intersections. The supplemental material provides C/optimization outputs for finite parameter selection, which should be treated as candidate data and checked exactly.

## Alternative route: cylinder factorization before moment estimates

The finite-coordinate sandbox now has a normalized independent-coordinate weight system and a proved total-mass identity. The next theorem should be a cylinder factorization lemma: for a coordinate cylinder H,

    μ(H) = ∏_{i ∈ H.fixed} w_i(H.value_i).

This is stronger and more diagnostic than merely knowing that the whole product space has mass one. It isolates exactly where independence is used. For arbitrary normalized joint distributions, the factorization is false; therefore the proof must keep the product-measure hypothesis visible in the type/interface.

A robust Lean implementation should proceed by:
1. Define the cylinder event as a finite predicate on CoordinatePoint.
2. Prove the finite sum over all points with prescribed coordinates factors into the product of fixed-coordinate weights, using finite-sum/product interchange.
3. Use the coordinate normalizers on free coordinates to eliminate the unconstrained factors.
4. Separately derive the uniform-coordinate specialization used by the original counting argument.

This provides an alternative to immediately formalizing the full geometric second-moment estimate: first prove the exact local mass of each cylinder, then bound pairwise intersections through the overlap-compatibility theorem already in BBMSTGeometryTest.lean. For compatible cylinders, the intersection is another cylinder whose fixed set is the union of the fixed-coordinate sets, with consistent prescriptions on the overlap. For incompatible cylinders, its mass is zero. The second moment can then be organized by overlap patterns rather than by opaque global predicates.

This route does not itself establish the published noCodimOneAt condition. That condition must still be derived from the actual arithmetic stage family; the finite-coordinate model only supplies the combinatorial and measure-theoretic engine once the concrete family is encoded.

## 2026-10-23 research extension: cylinder-mass and compatibility expansion

### Literature lesson and boundary

The published distortion method for covering systems emphasizes stagewise control of the measure of uncovered points; the BBMST moment route additionally needs precise incidence information. These are not interchangeable: a generic union bound is too weak to recover the improved second-moment numerator. The Lean development must derive the needed geometry from the actual arithmetic stage family, rather than placing the desired conclusion in a structure field.

### Concrete finite-product lemma sequence

Let X be the finite product of nonempty coordinate domains, and let each coordinate have a normalized rational weight w_i. For a cylinder H fixing a finite coordinate set I, its event is the set of points x satisfying x_i = h_i for all i in I. The target lemma is
\[
\mu(H)=\prod_{i\in I} w_i(h_i).
\]
Proof strategy: expand the finite sum over the cylinder; factor the finite product over fixed and free coordinates; sum each free coordinate using its normalization certificate. This should be proved for the factorized distribution, not for an arbitrary normalized joint distribution.

For cylinders H and K, compatibility is agreement on I intersect J. If incompatible, the intersection is empty. If compatible, the intersection is a cylinder fixing I union J, so its mass is the product over the union. The overlap coordinates are counted once, which is exactly why the intersection mass is not generally the product of the two cylinder masses.

### Second-moment expansion

For a finite family of indicator events E_i, define Z(x) = sum_i 1_{E_i}(x). Then
\[
\mathbb E[Z^2]=\sum_i\mu(E_i)+2\sum_{i<j}\mu(E_i\cap E_j).
\]
This identity is elementary and can be formalized before any geometric estimate. The research-critical task is then to classify pairs by fixed-coordinate overlap and agreement, and to bound the compatible-pair contribution using the actual stage incidence restrictions. A generic bound such as mu(E_i intersect E_j) <= min(mu(E_i), mu(E_j)) will not yield the published improved estimate on its own.

### Codimension-one obligation

In the coordinate sandbox, codimension one means exactly one fixed coordinate. The property that a stage contains no such member must be proved from the arithmetic construction of the newly exposed family N_k. It cannot be inferred merely from a type named NoCodimensionOneAt. If the arithmetic definition admits a singleton-fixed-coordinate member, the proposed improved estimate needs either a revised hypothesis or a counterexample analysis.

### Alternative route if the geometric condition fails

First construct small finite coordinate spaces and explicit stage families, enumerate compatible pairs, and compare the exact second moment with the proposed bound. A counterexample here would diagnose whether the issue is:
1. a false general inequality,
2. an insufficient codimension hypothesis,
3. or a missing arithmetic restriction in the intended BBMST family.

Only after this diagnostic should the theorem be strengthened or the published incidence argument reconstructed in full.

### Acceptance criteria

1. Prove cylinder mass from normalized coordinate weights.
2. Prove exact intersection mass from compatibility, and zero mass for disagreement.
3. Prove the indicator second-moment identity.
4. Derive the no-codimension-one property from the actual stage definition.
5. Obtain the improved moment estimate from these lemmas, with no assumed field encoding the target inequality.
