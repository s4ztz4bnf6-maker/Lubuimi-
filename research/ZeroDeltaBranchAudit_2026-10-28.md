# Zero-delta branch audit — 2026-10-28

## Grounded source facts

Pinned upstream source:
- Repository: `axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture`
- Commit: `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`
- File: `ErdosSelfridge_v17_fixed.lean`

The source defines:

```lean
noncomputable def sieveTerm (ca1 ca3 : ℚ) (ss δs : List ℚ) (k : Nat) : ℚ :=
  let sk := ss.getD k 1
  let δk := δs.getD k 0
  min (M1bound ca1 ss δs sk k)
      (M2bound ca1 ca3 ss δs sk k / (4 * δk * (1 - δk)))
```

The axiom `sf_sieve_lt_one` is described in the source as producing a list `δs`
and LP constants, but the visible validation hypothesis used by the main theorem
only gives `0 ≤ δs.getD i 0` and `δs.getD i 0 < 1` for indices that exist.
It does not itself encode nonemptiness or alignment of `δs` with `ss`.

## Concrete failure mode

Lean's rational division is total. In particular, the quotient with denominator
zero is not a mathematical limiting interpretation of the second-moment bound.
When `δk = 0`, the source formula can select zero via the quotient branch,
even though the first-moment bound is positive. The existing focused audit
compiled `degenerate_sieveTerm` and `degenerate_sieveSum`, demonstrating that
the current interface admits this degenerate branch. The same CI log lists
`sieve_criterion` as an unproved project axiom in the dependency chain of
`erdos_selfridge`.

## Repair candidate and limits

`SieveParameterContract.lean` introduces:
- a common `Fin n` index for block sizes and deltas;
- a positive stage count;
- the source interval `0 ≤ δ ≤ 1/2`;
- a proof that `4 * δ * (1 - δ) > 0` when `δ ≠ 0`;
- an explicit candidate branch using the first-moment bound when `δ = 0`.

This is only a representation-level contract. The zero branch has not yet been
proved equivalent to a statement in BBMST's paper, and the new structure is not
yet connected to the output of the source's LP/computational argument. It must
not be substituted into the original theorem until those obligations are
resolved.

## Next formal obligations

1. Make the sieve term's denominator case explicit and prove the branch matches
   the published sieve estimate.
2. Replace the loose list interface with a source-derived indexed parameter type.
3. Prove the existence/LP witness theorem rather than assuming `sf_sieve_lt_one`.
4. Prove the covering criterion rather than assuming `sieve_criterion`.
5. Compile the main theorem and run a transitive axiom audit. Standard Lean
   infrastructure axioms are distinct from project-specific unproved axioms.
