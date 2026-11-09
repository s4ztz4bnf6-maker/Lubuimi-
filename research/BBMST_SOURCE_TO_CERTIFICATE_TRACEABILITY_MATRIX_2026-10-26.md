# BBMST source-to-certificate traceability matrix

Date: 2026-10-26

## Purpose
Every computational certificate must be traceable to the mathematical statement it is meant to support. A correct rational certificate for the wrong matrix is not evidence for the theorem.

## Required chain
For every finite optimization instance, record the following as a single immutable manifest:

1. **Source identity:** exact paper/version, theorem/lemma, displayed equation or algorithm, and retrieval date.
2. **Mathematical objects:** admissible moduli, residues, hyperplanes, incidence variables, normalization, and all exclusions (especially modulus 1, empty families, and degenerate hyperplanes).
3. **Encoding map:** explicit ordered list mapping each mathematical variable to a matrix column and each inequality to a source-derived row.
4. **Arithmetic model:** exact rational A, b, c; direction of each inequality; objective sense; sign restrictions; strict versus non-strict comparisons.
5. **Certificate type:** primal-dual optimality witness or Farkas infeasibility witness. These are distinct proof obligations and must not be interchanged.
6. **Checker output:** exact rational residuals, feasibility checks, objective comparison, and checker version/hash.
7. **Coverage:** a proof that all admissible cases are represented, including every branch in a branch-and-bound tree.
8. **Theorem transfer:** explicit lemma connecting the certified finite statement to the BBMST conclusion; for unbounded rank, a separate rank-transfer theorem.

## Fail-closed rule
If any manifest field is absent, the output is classified as a diagnostic or experiment, not a theorem certificate. A zero residual or successful LP solver status cannot repair missing source identity or missing coverage.

## Suggested exact manifest schema
- `source_url`, `source_version`, `theorem_id`, `equation_ids`
- `moduli_domain`, `residue_domain`, `degenerate_case_policy`
- `variable_order`, `row_order`, `matrix_A`, `vector_b`, `objective_c`
- `optimization_sense`, `constraint_sense`, `sign_constraints`
- `certificate_kind`, `certificate_vector`, `exact_checker_version`
- `branch_tree_root`, `branch_partition_lemma`, `uncovered_case_count`
- `transfer_lemma`, `rank_scope`, `strict_margin`, `error_budget`

## Mathematical boundary
This interface makes certificate provenance auditable; it does not supply the source-derived matrix, a complete tree, or a rank-transfer proof by itself. No claim is made that the square-free distinct-moduli theorem or the unrestricted Erdős-Selfridge conjecture has been proved by this artifact.