# BBMST / Erdős–Selfridge audit frontier (2026-10-25)

## Confirmed formal defect

In the current `AuditCheck.lean`, the degenerate choice `δs = []`, `ca1 = ca3 = 1` makes the sieve product equal to (1), while the corresponding rational quotient can collapse to (0) through Lean's totalized division convention when the denominator is (0). The file derives `degenerate_actual_sieveSum_lt_one` for the actual block-size list and then applies `sieve_criterion` to derive `False).

This is a counterexample to the current axiom interface, not a mathematical counterexample to Erdős–Selfridge. The contradiction diagnoses an under-specified premise. It does not establish the conjecture.

## Repair contract for any replacement

A repaired theorem must not accept the empty or invalid parameter witness. Before the analytic inequality is used, the formal statement must establish, from the paper's definitions and the selected finite configuration:

1. nonemptiness and valid indexing of the parameter list;
2. positivity/nonvanishing of every denominator actually divided by;
3. the required parameter range and normalization, proved rather than assumed as a convenient guard;
4. the exact source correspondence between the finite probability space, block-size data, and the quantities entering the sieve/moment bound;
5. that the final inequality is the published theorem's inequality, not a stronger-looking statement with a degenerate branch.

These are necessary safeguards, not a replacement proof of the published BBMST estimate.

## Source-faithful route

Keep the algebraic kernel independent from the difficult analytic claim. Formalize in this order:

- finite configuration and its probability measure;
- fibers/partition and mass conservation;
- the exact definition of the weights and the weighted neighborhood sum;
- denominator positivity and edge cases;
- the local arithmetic/moment inequality with all source hypotheses explicit;
- only then the global contradiction.

For the cylinder/fiber line of work, do not assume the missing local bound under another name. The concrete obligation remains to derive the bound from the published weights and overlap structure, or find a finite counterexample to the proposed bound.

## Acceptance gate

A successful build only certifies the formal declarations. A complete result additionally requires transitive axiom inspection, no `sorryAx`, no project-specific unproved axiom replacing the theorem, and a line-by-line statement-fidelity check against the pinned source. Standard Lean foundations (for example classical choice or quotient soundness) must be reported explicitly rather than confused with project-specific assumptions.
