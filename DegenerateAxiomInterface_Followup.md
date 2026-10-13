# Follow-up: both sieve axioms admit a degenerate interface

Pinned upstream source:
- Commit: fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086
- File: ErdosSelfridge_v17_fixed.lean

## Verified code-level witness

The companion audit file `AuditCheck.lean` proves:
- `degenerate_sieveTerm`: with `δs = []` and `ca1 = ca3 = 1`, each term is zero for positive block size.
- `degenerate_sieveSum`: the complete sum is zero for any list with positive in-range block sizes.
- `degenerate_actual_sieveSum_lt_one`: this applies to the actual `nonsfBlockSizes cs) under `CS_allOdd cs`.
- `degenerate_axiom_acceptance`: the current `sieve_criterion` accepts that invalid parameter list and derives `False` from the odd-covering assumption.

## Additional interface issue in sf_sieve_lt_one

The axiom `sf_sieve_lt_one` returns a delta list with elementwise bounds, but does not require its length to equal the block-size list length. Elementwise bounds are vacuously true for the empty list. Because the implementation uses `getD` defaults and rational division by zero is totalized, the empty list can drive the implemented sum to zero rather than rejecting the input.

This means the axiom's conclusion does not certify the intended BBMST parameter construction: it can be satisfied by a degenerate list. This is a defect in the formal contract, not a mathematical disproof.

## Minimal repair requirements

1. Require a proved alignment condition such as `δs.length = ss.length` at the interface where the sieve is evaluated.
2. Prove each `δ_i` is in the actual BBMST interval, with strict denominator positivity for `4 * δ_i * (1 - δ_i)`; if endpoint values are allowed in the paper, handle them by a separately justified limiting/formula convention rather than silently relying on division by zero.
3. Replace `sf_sieve_lt_one` with a theorem that constructs parameters satisfying the valid BBMST hypotheses, not merely a sum inequality.
4. Replace `sieve_criterion` with a proof of the exclusion theorem from the source, including the exact moment bounds and all geometric hypotheses.
5. Run `#print axioms erdos_selfridge` after integration and verify that neither project axiom remains.

## Status

The source-level witness is present in `AuditCheck.lean`; Run #25 compiled the earlier audit/prototype. Run #27 is still waiting at dependency/cache installation at the last poll. The latest proof-obligation note is on the audit branch. No claim is made that the actual theorem has been repaired or that prize eligibility is established.
