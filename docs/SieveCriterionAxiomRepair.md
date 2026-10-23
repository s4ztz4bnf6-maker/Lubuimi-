# Sieve-criterion axiom repair proposal

Status: audit proposal only. This is not a proof of the sieve criterion or of the Erdős–Selfridge conjecture.

## Reproduced defect

The pinned source defines `sieve_criterion` with premises `1 ≤ ca1` and `sieveSum ... δs < 1`, but it does not require the parameter list `δs` to cover the coordinates indexed by the block-size list. In the degenerate case `δs = []`, the implementation's default lookup and rational division-by-zero behavior make the computed sieve sum vanish. The current `AuditCheck.lean` constructs this witness for the actual `nonsfBlockSizes cs` list, conditional on `CS_allOdd cs`.

This is a defect in the imported axiom interface. It is not a kernel inconsistency and does not construct an odd covering system.

## Minimal interface condition to investigate

The immediate missing invariant is length alignment. The proof that obtains parameters from `sf_sieve_lt_one` uses one parameter per extracted prime, so the non-squarefree criterion should at minimum reject a parameter vector that is too short:

```lean
(hδ_length : (nonsfBlockSizes cs).length ≤ δs.length)
```

A more robust interface should expose the actual sieve hypotheses explicitly, including parameter bounds and the coefficient constraints used by the monotonicity proof. Those bounds are not a substitute for length alignment: a universally quantified bound over an empty list is vacuously true.

## Required next tests

1. Add a negative regression test showing that the empty-list witness cannot satisfy the strengthened interface whenever the block-size list is nonempty.
2. Establish from the definitions of `CoveringSystem` and `extractPrimes` that an odd covering system yields a nonempty block-size list, or handle the empty case explicitly.
3. Re-run the existing monotonicity argument against the strengthened interface.
4. Replace the axiom with a theorem derived from the exact BBMST hypotheses; do not simply strengthen the axiom and treat that as a proof.
5. Keep the pinned upstream file and any proposed patched copy distinguishable in CI.

The length condition is a necessary repair target identified by the counterexample, not a claim that it alone validates the entire theorem.
