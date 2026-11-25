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
