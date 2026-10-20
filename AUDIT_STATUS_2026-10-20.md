# Erdős–Selfridge audit status — 2026-10-20

## Scope
This note records a read-only review of the existing audit branch and completed GitHub Actions evidence. No changes were made to the upstream Lean source or to the default branch.

- Audit repository: https://github.com/s4ztz4bnf6-maker/Lubuimi-
- Branch reviewed: `audit/nonempty-delta-contrast`
- Lean toolchain declared by the audit repository: `leanprover/lean4:v4.28.0`
- Mathlib requirement in `lakefile.lean`: `v4.28.0`

## CI evidence inspected

### Run 39341799024 — job `audit`
GitHub Actions job status: **completed / success**.

The job explicitly ran these steps:
- Compile audited upstream source
- Compile isolated interface tests
- Compile isolated monadic list diagnostic
- Run focused degenerate-witness tests

The logs show those commands completed without a Lean error. The log also includes these axiom dependency outputs:

- `degenerate_axiom_acceptance` depends on `sieve_criterion` (plus standard axioms).
- `erdos_selfridge` depends on `sf_sieve_lt_one` and `sieve_criterion` (plus standard axioms).
- `sieve_criterion` and `sf_sieve_lt_one` appear as named axiom dependencies in their respective audit output.

This confirms compilation of the audit tests in that run; it does **not** validate the mathematical truth of the axioms.

### Run 39341799062 — job `compile-stage-fiber`
GitHub Actions job status: **completed / success**. The explicit step `lake env lean StageFiberEquivTest.lean` completed and printed that `BBMSTAudit.stageFiberEquiv` depends on `[propext, Quot.sound]`. This is a separate BBMST test, not evidence for the Erdős–Selfridge theorem.

The generic lean-action auto-configuration reported that it would skip its automatic `lake test` and `lake lint` steps because the corresponding checks were not detected. Therefore, the successful audit evidence is specifically the explicit compile/test commands above, not a claim that every automatic test/lint target ran.

## Reproduced formalization concern

The audit file demonstrates the degenerate parameter issue for the current interface:
- an empty delta list makes `sieveProd ss [] x = 1`;
- `δs.getD k 0` supplies zero for a missing parameter;
- the quotient denominator `4 * δ * (1 - δ)` can therefore be zero;
- Lean's rational division is totalized, so the expression evaluates rather than raising an error;
- the audit constructs premises for `sieve_criterion` with an empty delta list and derives `False` under `CS_allOdd cs`.

The tests also show that merely requiring a nonempty list would not be enough: an explicit `δ = 0` is another degenerate case. The existing `GuardedSieveParams` / `GuardedSFWitness` structures are diagnostic proposals only; they do not repair the original axioms while those axioms remain directly callable.

## Mathematical interpretation

This is a formal specification/axiom-interface defect, not a counterexample to the Erdős–Selfridge conjecture. The published sieve argument cannot be imported solely by matching names or scalar inequalities: the parameter ranges, stage alignment, moment-bound hypotheses, and the codimension-one condition for the improved second-moment bound need to be justified against the paper.

## Next work items
1. Keep the upstream source and default branch unchanged while preparing a proof-obligation map for the two axioms.
2. Replace missing/defaulted stage parameters with a type carrying exact list-length alignment and the mathematically justified parameter bounds.
3. Separate the unconditional second-moment bound from the improved bound and encode the latter's geometric hypothesis.
4. Do not strengthen or replace either axiom until the required theorem has been derived from the cited paper's actual hypotheses.
5. After any source-level change, run the explicit Lean compilation steps and inspect `#print axioms`; report exact run IDs and logs.

## Integrity status
- Upstream source changed: **No**
- Default branch changed: **No**
- Audit tests compiled in run 39341799024: **Yes**
- Axiom dependencies inspected in logs: **Yes**
- Conjecture proved/disproved: **No**
