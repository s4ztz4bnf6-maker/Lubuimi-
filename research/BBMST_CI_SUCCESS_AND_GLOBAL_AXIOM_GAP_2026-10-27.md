# Audit status and remaining mathematical gap (2026-10-27)

## Verified CI status

Workflow run 40452720820 completed successfully. The following steps passed:

- division-free finite mass partition
- finite overlap budget identity
- typed BBMST parameter interface
- transitive axiom audit for the typed interface
- compilation of the audited upstream source
- focused degenerate-witness tests

The axiom report for the typed interface was:

- `BBMSTAudit.parameter_data_has_positive_coordinate`: `[propext, Classical.choice, Quot.sound]`
- `BBMSTAudit.sieve_denominator_pos`: `[propext, Classical.choice, Quot.sound]`

These are foundational dependencies, not project-specific unproved assumptions.

## Critical distinction

The same CI run reports that the global target `erdos_selfridge` still depends on:

```
[propext, sf_sieve_lt_one, sieve_criterion, Classical.choice, Quot.sound]
```

The audit also confirms that the degenerate test theorem `degenerate_axiom_acceptance` depends on `sieve_criterion`. Therefore, a successful CI run is evidence for the audited helper modules and regression tests, not a proof of the Erdős–Selfridge conjecture. The project-specific assumptions `sf_sieve_lt_one` and `sieve_criterion` remain the decisive open proof obligations.

## Mathematical bottleneck

The generic finite second-moment identity is formalized, but it does not by itself bound the source-specific pairwise intersection mass. The next theorem must derive a quantitative overlap bound from the actual BBMST hyperplane/incidence definitions and parameter hypotheses. It must not assume the sieve criterion or introduce a free geometric predicate that simply encodes the desired conclusion.

## Acceptance rule

A future result counts as a global proof only if:

1. `erdos_selfridge` has no project-specific axioms in its transitive axiom report;
2. its statement matches the intended theorem, including nondegenerate parameter hypotheses;
3. the BBMST source-to-Lean mapping proves the required geometric overlap estimate;
4. degenerate witnesses fail for mathematical reasons, not because a target theorem was assumed.

This note records the observed CI state and the remaining gap. It does not claim the global conjecture is solved.
