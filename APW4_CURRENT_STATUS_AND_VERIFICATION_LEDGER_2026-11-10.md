# APW4 / BBMST current status and verification ledger — 10 November 2026

**Research author and formalization lead:** Ta-Yoshua Lubuimi. AI tools are assistants only, not authors or independent mathematical verifiers.

## 1. Mathematical results: preserve, do not reopen

This record is append-only with respect to established mathematical results. The APW4/BBMST work already established by the author remains part of the project's mathematical record. Later Lean integration errors do not retroactively invalidate those results.

The current APW4 energy conclusion is recorded relative to its explicit mathematical premises A*, B*, and the local mass bound `m_S(x) ≤ 1`. Those premises must remain visible wherever the conditional conclusion is stated; they must not be silently dropped or represented as independently discharged unless the relevant proofs are present.

The previously established components remain separately identified: DT and HT; historical atom identification where proved; BIBW domination and weighted Hall conditions; exact diagonal/off-diagonal decomposition; CRT fibre balance; and the algebraic energy conclusion under the recorded premises. APW diagonal mass, APW off-diagonal mass, and BIB pair reserve remain distinct until an explicit index-preserving map and weight/capacity transport is proved.

## 2. Exact PR #115 result

PR [#115](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/115), exact source head `278c0c6c192e34728bace660199e1c431e96846d`, workflow [42762540736](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762540736):

- Separate `audit` job: **PASS**. It compiled `BBMSTPrefixMeasureRecursion.lean` and printed `BBMSTPrefixMeasure.prefixFibre_updatedWeight_eq_PAt` with `[propext, Classical.choice, Quot.sound]`; no `sorryAx` appears for that declaration in that separate job.
- Integrated Lean 4.35.0 `integrated-paranoid` job: **FAIL**. The compiler reported errors at `BBMSTPrefixMeasureRecursion.lean:393` and `:394`.
- In the positive branch, the tactic `(intro hnot; exact hnot hcov)` was applied to a residual equality between the uncovered and covered multipliers, not to a contradiction.
- In the negative branch, the nested `if x ∈ Finset.univ then ... else 0` was not reduced.
- The integrated error-recovery output then printed `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and dependent declarations such as `PAt_nonneg`. This is a failed integrated proof attempt, not a mathematical counterexample.

The separate audit PASS and integrated FAIL are not contradictory: they are different jobs with different compilation contexts. Only the integrated result can certify the full dependency package requested by the integration workflow.

## 3. Current repair candidate PR #116

PR [#116](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/116) is a stacked draft over PR #115. Its exact code head is `056de39c12ce417b6c7578277bf0fe9023af145f`. It changes only the proof body of `prefixFibre_updatedWeight_eq_PAt`.

The new proof explicitly establishes membership/nonmembership in `F.covered` and membership in `F.points`, then rewrites the two nested conditionals in `updatedWeight` separately. This targets the exact two failures in run 42762540736. It does not change theorem statements, definitions, hypotheses, or the established mathematical architecture.

Exact-head workflow [42805862280](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42805862280) was in progress at the latest poll:

- audit job `129794679789`: in progress;
- integrated-paranoid job `129794680288`: in progress.

**Status: OFFEN – NICHT VERIFIZIERT.** Do not merge or describe the repair as successful until both jobs finish, the integrated package compiles, named `#print axioms` outputs are inspected, and the integrated dependency scan has no `sorryAx`.

## 4. Next APW4 proof obligations

1. Close `prefixFibre_updatedWeight_eq_PAt` in the integrated package with the exact concrete covered/uncovered branch correspondence.
2. Re-run the integrated Lean 4.35.0 paranoid build and inspect the transitive dependencies of `PAt_nonneg`, the pointwise distortion bound, and all later recursion declarations.
3. Verify the prefix event-mass identities at the exact source indices and ensure free coordinates are summed by exact fibre mass conservation while fixed coordinates incur only the corresponding distortion factor.
4. Complete the dependent prefix-cylinder / hyperplane-shadow interface without substituting arbitrary coefficient families for the source-defined `c(I)`.
5. Reconcile the source-defined geometric and measure-theoretic quantities with the published BBMST definitions. Historical `A_q`, `A_r`, `W_{q,r}`, and `a_{q,t}` must not be guessed or replaced by canonical block sums.
6. Keep the three mass ledgers distinct: APW diagonal mass, APW off-diagonal mass, and BIB pair reserve. Prove an index-preserving map before any equality or domination transfer.
7. Re-run the exact theorem-level axiom audit and no-`sorryAx` scan on the final integrated target.

## 5. Separate upstream Erdős–Selfridge interface audit

The audit workflow also compiles a pinned upstream source that contains explicit project-specific axioms `sieve_criterion` and `sf_sieve_lt_one`. The recorded degenerate-parameter witness shows that those axiom interfaces cannot be treated as kernel-derived proofs of the unrestricted Erdős–Selfridge conjecture. This upstream axiom audit is a separate track; it must not be conflated with the established APW4 mathematical results or the APW4 prefix-recursion repair.

## 6. Attribution and licensing boundary

All original APW4 mathematical research, source-specific derivations, and formalization work in this repository are attributed to Ta-Yoshua Lubuimi. AI tools are assistants only.

No root `LICENSE`, `LICENSE.md`, `LICENSE-PROPRIETARY.md`, or commercial licence file was present in the inspected APW4 repository tree at the recorded source snapshot. Therefore this project status record does not invent or import a licence choice from the separate Collatz repository. No open-source or commercial reuse permission is asserted here; third-party code and Mathlib retain their own licences. Any explicit APW4 licensing notice requires a separate author-approved legal text.

---

**Release rule:** no claim that the complete integrated Lean proof is verified until the final exact source passes the integrated build, the named target declarations have the accepted transitive axiom profile, and no `sorryAx` remains in the intended dependency closure.