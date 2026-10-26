# BBMST audit: degenerate sieve parameters and repair obligations

Date: 2026-10-26

## Finding under audit

In the pinned upstream source, the axiom sieve_criterion accepts a list δs : List ℚ, parameters ca1 ca3, the lower bound 1 ≤ ca1, and a strict sieve-sum bound. Its signature does not itself impose the parameter admissibility conditions stated by the separate sf_sieve_lt_one axiom, nor does it require δs to be nonempty.

The audit constructs the candidate edge case δs = [], ca1 = ca3 = 1. The upstream sieve definitions appear to make the product over the empty parameter list equal to 1 and the quotient term with zero denominator equal to 0 under Lean's rational division convention. If the concrete test compiles, the sieve sum is 0 and hence less than 1. Applying sieve_criterion would then derive False from any cs and h_odd.

This is a formalization defect conditional on the source-level test compiling, not a mathematical counterexample to the BBMST theorem. At this writing the relevant GitHub Actions run has not reached the focused test step, so the test result is not yet certified.

## Repair obligations

A repair must not merely add an arbitrary nonemptiness condition. It must recover the hypotheses actually used by the source proof:

- admissibility and range conditions for every delta parameter;
- positivity/nonzero denominator conditions where rational division is used;
- the relationship between the actual block sizes and the source theorem's probabilistic/combinatorial objects;
- the exact theorem conclusion and all side conditions from the cited BBMST argument.

The current axiomatic boundary should be treated as untrusted until these obligations are checked against the paper and the upstream proof. The expected foundation axioms of Lean/Mathlib (for example classical choice or quotient soundness) are not the same as a project-specific axiom that assumes the central sieve result.

## CI sequence

The audit workflow now explicitly emits the two core modules as .olean files before compiling the upstream source and running AuditCheck.lean. This addresses the earlier module-resolution failure. The latest run is still installing/restoring Mathlib dependencies; no result from the degenerate-witness test should be claimed until the workflow reports that step's outcome.
