# CI and axiom-boundary update — 2026-10-26

## Verified current state

Repository: `s4ztz4bnf6-maker/Lubuimi-`
Branch: `audit/bbmst-fiber-incidence-2026-10-26`
Pull request: [#20](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/20)
Commit observed: `06e44dfd2afeab1f5a083a6edb5229c690f4fb6b`

GitHub Actions run `40309819898` completed successfully at 2026-10-26 10:49 UTC. The workflow compiled the division-free mass core, finite-fiber split core, the audited upstream source, and focused degenerate-witness tests.

**Important qualification:** the workflow log explicitly records the `axiom-audit` step as `skipped`. Therefore a green workflow is evidence of successful compilation and regression tests, not evidence that the global theorem is free of project-specific assumptions.

The same log reports these dependencies:

- `degenerate_axiom_acceptance`: `[propext, sieve_criterion, Classical.choice, Quot.sound]`
- `erdos_selfridge`: `[propext, sf_sieve_lt_one, sieve_criterion, Classical.choice, Quot.sound]`
- `sieve_criterion`: includes `sieve_criterion`
- `sf_sieve_lt_one`: includes `sf_sieve_lt_one`

The last two are self-named project-specific assumptions in the reported dependency lists. They remain open proof obligations; they must not be presented as proved mathematical results.

## Immediate next engineering task

1. Make the axiom-audit step mandatory in CI rather than skipped.
2. Ensure the audit fails if the final theorem's transitive axiom list contains `sieve_criterion`, `sf_sieve_lt_one`, or any other project-specific axiom.
3. Permit explicitly documented Lean foundations such as `propext`, `Classical.choice`, and `Quot.sound` according to a reviewed allowlist; do not demand a literally empty list without distinguishing standard foundations.
4. Keep the degenerate-witness test, but label it as a regression test for the implementation, not a proof of the unrestricted odd-covering theorem.
5. Only after the axiom gate is active, work on source-faithful proofs of the non-degenerate moment/overlap inequalities that discharge the sieve criterion.

## Mathematical boundary

The finite mass-conservation and fiber-partition lemmas can be valid and useful independently of the global Erdős–Selfridge theorem. Neither successful compilation nor the degenerate parameter case proves the missing source-specific sieve inequalities. The statement-fidelity audit and the proof audit remain separate from CI compilation.

## Syracuse / Collatz parallel

The same rule applies to the separate Syracuse project: local valuation and residue-class lemmas may be checked independently, but they do not establish global descent. Any continuous or 2-adic representation must be connected to a rigorously decreasing invariant in the ordinary positive-integer order. Do not merge the two project workspaces or transfer assumptions between them.
