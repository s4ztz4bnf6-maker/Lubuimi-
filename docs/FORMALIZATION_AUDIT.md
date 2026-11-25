# Lean Formalization Audit: Degenerate Sieve Parameters

**Status:** Reproducible audit finding; mathematical conjecture not resolved.  
**Audit branch:** `audit/nonempty-delta-contrast`  
**Source under test:** `ErdosSelfridge_v17_fixed.lean`, pinned upstream commit  
`fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`  
**Test file:** [AuditCheck.lean](https://github.com/s4ztz4bnf6-maker/Lubuimi-/blob/audit/nonempty-delta-contrast/AuditCheck.lean)

## Executive summary

The current formal interfaces for `sieve_criterion` and `sf_sieve_lt_one` permit degenerate parameter choices. The audit constructs such choices using Lean-checked rational arithmetic and demonstrates that the stated premises can be met without a genuine sequence of sieve parameters.

This is evidence of a **formalization/specification gap in the axiom interfaces**. It is not a counterexample to the Erdős–Selfridge conjecture and does not establish a corrected proof.

## Reproduced findings

### 1. Degeneration of `sieve_criterion`

The axiom currently requires, among other inputs, only `1 ≤ ca1` and `sieveSum ca1 ca3 (nonsfBlockSizes cs) δs < 1`. It does not require that `δs` have the same length as the block-size list or that each used parameter be strictly positive.

The audit proves the following for the actual block-size list, under `CS_allOdd cs`:

- `δs = []`, `ca1 = 1`, `ca3 = 1` are accepted by the explicit premises.
- The recursive sieve product over an empty delta list is `1`.
- The denominator `4 * δ * (1 - δ)` vanishes when the default parameter is `δ = 0`; Lean's rational division is total, so this does not raise an exception.
- The resulting sieve terms and sum evaluate to zero, giving `0 < 1`.
- Applying the current axiom then yields `False` from the assumption `CS_allOdd cs`, without needing `sf_sieve_lt_one`.

The file also tests a nonempty list containing `δ = 0`, showing that merely requiring a nonempty list would not suffice.

### 2. Degeneration of `sf_sieve_lt_one`

Its current existential conclusion requires a sum below one, `1 ≤ ca1`, several scalar inequalities, and `0 ≤ δᵢ < 1` for indices within the delta list. With an empty delta list, the indexed condition is vacuous. For `ca1 = ca3 = 1`, the scalar inequalities hold and the sum collapses to zero. Thus the current signature does not itself enforce a nonempty, length-matched sequence of valid parameters.

This is a signature-level observation. It does not establish which stronger parameter-existence theorem follows from the cited paper.

## Reproducibility

Two GitHub Actions audit runs completed successfully:

- [Run 38540332344](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/38540332344)
- [Run 38540338670](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/38540338670)

Each run's `audit` job reported `success`. The CI result establishes that the current audit tests compile in the configured environment; it does not validate the original axioms or prove the conjecture.

## Proposed repair direction (not yet a repair)

1. Define a parameter package indexed by the block-size list, enforcing equal lengths and `0 < δᵢ < 1` at every used stage.
2. State the sieve criterion using this package and the exact moment hypotheses required by the mathematical source.
3. Re-establish the parameter-existence result under those strengthened conditions, rather than assuming the current existential axiom remains true.
4. Re-run the tests and add regression checks that reject empty, short, long, and zero-containing parameter lists.
5. Audit theorem dependencies with `#print axioms` after any proposed repair.

The experimental `ValidSieveParams` structure in `AuditCheck.lean` addresses length and strict-range invariants only. It is not connected to the upstream axioms and is not a proof of the missing mathematical statements.

## Scope and attribution

The published paper *The Erdős–Selfridge problem with square-free moduli* proves a result for square-free moduli, not the full unrestricted odd-moduli conjecture. See the [published paper](https://doi.org/10.2140/ant.2021.15.609) and [supplementary material](https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html). Any claim that the stronger Lean axioms follow from a published theorem needs a separate, exact hypothesis-by-hypothesis comparison.

**Conclusion:** The audit currently supports a reproducible finding about degenerate formal parameter interfaces. It does not prove or disprove the underlying Erdős–Selfridge conjecture.
