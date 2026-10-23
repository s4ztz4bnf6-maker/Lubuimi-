# Sieve-criterion axiom repair proposal

Status: audit proposal only. This is not a proof of the sieve criterion or of the Erdős–Selfridge conjecture.

## Reproduced defect

The pinned source defines `sieve_criterion` with premises `1 ≤ ca1` and `sieveSum ... δs < 1`, but it does not require the parameter list `δs` to cover the coordinates indexed by the block-size list. In the degenerate case `δs = []`, the implementation's default lookup and rational division-by-zero behavior make the computed sieve sum vanish. The current `AuditCheck.lean` constructs this witness for the actual `nonsfBlockSizes cs` list, conditional on `CS_allOdd cs`.

This is a defect in the imported axiom interface. It is not a kernel inconsistency and does not construct an odd covering system.

## Both axiom interfaces need alignment

The defect is not confined to `sieve_criterion`. The upstream `sf_sieve_lt_one` axiom also quantifies its parameter constraints only over indices `i < δs.length`; it does not require `δs` to be as long as `primes`. Thus the empty parameter list makes those local constraints vacuously true, and the theorem's main proof can pass the same empty list into the non-squarefree criterion.

The immediate repair target is to carry a length invariant through both interfaces. For example, investigate a premise such as

```lean
(primes.length ≤ δs.length)
```

in `sf_sieve_lt_one`, and the corresponding block-size/parameter alignment condition in `sieve_criterion`. Since `sfBlockSizes` and `nonsfBlockSizes` are maps of the same extracted-prime list, prove their length correspondence from the definitions and transport the bound. Whether `≤` or exact equality is the right invariant depends on the indexing used by `sieveSum` and must be verified from its definition.

A more robust interface should expose the actual sieve hypotheses explicitly, including parameter bounds and the coefficient constraints used by the monotonicity proof. Those bounds are not a substitute for length alignment: a universally quantified bound over an empty list is vacuously true.

## Required next tests

1. Add a negative regression test showing that the empty-list witness cannot satisfy the strengthened interface whenever the block-size list is nonempty.
2. Establish from the definitions of `CoveringSystem` and `extractPrimes` that an odd covering system yields a nonempty block-size list, or handle the empty case explicitly.
3. Re-run the existing monotonicity argument against the strengthened interface.
4. Replace the axiom with a theorem derived from the exact BBMST hypotheses; do not simply strengthen the axiom and treat that as a proof.
5. Keep the pinned upstream file and any proposed patched copy distinguishable in CI.

The length condition is a necessary repair target identified by the counterexample, not a claim that it alone validates the entire theorem.
