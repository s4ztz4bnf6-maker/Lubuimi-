# BBMST exact-certificate input manifest

Date: 2026-10-26

## Purpose
A primal/dual rational certificate proves an optimum only for the exact LP instance supplied to the checker. This manifest records the missing bridge between a mathematical source argument, a generated finite LP, and a machine-checked certificate.

## Required immutable fields
1. `source`: paper title, authors, version/date, theorem/lemma/equation identifiers, URL or archived source hash.
2. `formal_statement`: exact Lean theorem name and fully elaborated assumptions, plus pinned Lean and Mathlib revisions.
3. `configuration_space`: finite set or index type, canonical enumeration, cardinality, and proof that the enumeration is exhaustive and duplicate-free.
4. `variable_encoding`: meaning of every variable, index-to-column map, bounds, integrality/relaxation choices, and normalization constraints.
5. `constraint_encoding`: meaning of every row, index-to-row map, coefficient-generation rule, right-hand side, and proof that all source constraints are represented.
6. `objective`: exact rational coefficients and mathematical interpretation.
7. `certificate`: primal vector and dual vector as canonical rational strings; dimensions; exact checker version and source hash.
8. `coverage`: branch-and-bound tree or finite family of cases, canonical child-generation rule, proof of no omitted branches, and terminal certificate for each leaf.
9. `transfer`: explicit theorem turning the finite LP/certificate conclusion into the target mathematical inequality, including all monotonicity, rounding, and strict-margin steps.
10. `audit`: output of the checker, transitive axiom report, statement-fidelity review, and independent-checker result if available.

## Fail-closed rules
- Missing or ambiguous field means the result is an experiment, not a theorem certificate.
- Floating-point values are never accepted as proof inputs. Decimal source outputs must be converted to rational intervals with an explicit rounding-error bound.
- A correct primal/dual pair for one LP does not establish that the LP is the right model or that it covers all configurations.
- A finite collection of certified cases does not prove a universal rank or arbitrary-modulus statement without a separate transfer theorem.
- A scalar inequality cannot replace an incidence/rank argument unless the source proves the equivalence.

## Minimal acceptance test
An independent reviewer should be able to regenerate every matrix coefficient from the frozen source and configuration data, rerun the exact rational checker, and trace the resulting inequality to the formal target statement without relying on an unrecorded script state or a generated narrative summary.

## Status
Specification only. No BBMST source LP or certificate is claimed to have passed this gate.