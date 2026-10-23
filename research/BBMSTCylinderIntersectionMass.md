# Research target: exact cylinder-intersection mass

Status: research specification, not a proved Lean theorem.

## Existing finite model

BBMSTGeometryTest.lean models a finite product of nonempty coordinate sets, coordinate cylinders, and normalized coordinate weights. It already has an exact criterion for cylinder intersection and the normalization identity for factorized point weights.

The next bridge is to calculate the mass of a cylinder and of an intersection under the factorized measure, rather than merely proving that an intersection is nonempty.

## Target statement

Let w_i be normalized coordinate weights and let a cylinder H fix coordinates F to values v_i. Prove mu(H) = product over i in F of w_i(v_i). For two cylinders, disagreeing prescriptions on a shared coordinate imply zero intersection mass. If they agree, prove mu(H1 intersect H2) = product over i in F1 union F2 of w_i(v_i), using the shared value on the overlap.

Derive this from the existing coordinate-weight system and finite sum/product identities. Do not assume it for arbitrary ProductDistribution; factorization is essential.

## Why this is relevant to BBMST

Balister-Bollobas-Morris-Sahasrabudhe-Tiba's distortion method preserves earlier-coordinate marginals, bounds point-mass distortion, and combines first- and second-moment loss bounds. The difficult source-specific content is control of compatible hyperplane intersections and the resulting weighted least-common-multiple sums.

The cylinder identity is a necessary bridge, not the final estimate. Next, introduce a finite family of forbidden cylinders and derive the second-moment identity with diagonal and compatible off-diagonal terms separated. Do not replace off-diagonal terms by products unless independence is proved.

## Proof plan

1. Define event mass using factorized point weights.
2. Sum over points satisfying fixed prescriptions and split fixed from free coordinates.
3. Each free coordinate contributes one because its coordinate weights sum to one.
4. Split pairs of cylinders into incompatible and compatible cases.
5. In the compatible case, combine prescription sets and apply the one-cylinder formula.
6. Expand the square of a finite sum of event indicators and expose every off-diagonal intersection term.
7. Run the focused Lean module and axiom audit. Do not call this the BBMST second-moment theorem until the paper's hypotheses and constants are reconstructed faithfully.

## Research pointer

Balister et al., On the Erdős Covering Problem: the density of the uncovered set, Inventiones Mathematicae 228 (2022), 377-414, DOI 10.1007/s00222-021-01087-5. See also Erdős covering systems, Acta Mathematica Hungarica (2020), for the distortion method.