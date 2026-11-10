# APW4 exact-head CI status — 10 November 2026

This append-only status record preserves the PR #79 correction: later integration failures do not retroactively invalidate already-proved APW4 mathematics. The published valuation-word cylinder theorem in PR #36 is not reopened. Mathematical proof, historical reconstruction and Lean/CI verification remain distinct.

## PR #101 — uncovered prefix recursion repair

- Updated source head: `f5aff142fcdf6c3893ef1c890f3be45a67da68aa`.
- The preceding head `3625d65285e36da383f7fcd1a322ec6612d98451` passed its Lean 4.28 audit job but failed the integrated Lean 4.35.0 build at line 407 of `BBMSTPrefixMeasureRecursion.lean`. After excluding covered membership, the remaining conditional was membership in `Finset.univ`. The failed declaration and dependent `PAt` results printed `sorryAx`.
- The updated source now supplies `hunit : y (Fin.last (a+j)) ∈ Finset.univ := Finset.mem_univ _` and rewrites both conditional branches explicitly.
- Exact workflow [42755782237](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755782237) was queued at this snapshot. No PASS is claimed until integrated-paranoid succeeds and named axiom output excludes `sorryAx`.

## PR #93 — finite residue bridge

- Head: `fbab49639954ae749d30a884a04032ee1d4d0f0e`; workflow [42754632105](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42754632105).
- The isolated audit job succeeded. Integrated-paranoid failed in the independent prefix recursion with the same unresolved uncovered-branch conditional and propagated `sorryAx). The isolated Syracuse paranoid job was still running at last poll.
- `SyracuseDyadicResidueFibre` is the generic residue-cylinder model. The separate `FibreData` wrapper is cardinality-only. The formal instantiation of the normalized prefix-tail residue and exact valuation-child equivalence remains a separate task.

## Collatz PR #48

The preceding PR #48 head `e1fb06eaa07190d8abfb3fc7368f3dc0663a5a66` passed the Lean 4.35.0 paranoid job and draft compile job. Its Lean 4.34.1 job failed because that Lake version does not recognize `lake check` (`unknown command 'check'`). Updated branch head: `5699182344be6a7950c6265551112a7a6d50e58d`; workflow [42755702331](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42755702331) queued.

Existing Collatz initial-cylinder, valuation-bound, offset and margin results remain independent results with their own prior verification evidence. Kolaz PR #39's finite-table workflow [42739986917](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42739986917) passed exact finite reproducibility tests; this is not Lean kernel verification or a global Collatz proof.

No queued or in-progress workflow is described as passed.


## Additional exact-head repair and explicit tail-residue candidate — 10 November 2026

- PR #101: the prior explicit Finset.univ proof failed because the rewrite witness did not match the dependent stage-fibre type. The new head 6bad5a25400aeae8e851a38c507141ec0e092a3a gives the witness the explicit type Finset (C.S (stageCoordinate hk)) and separates the two conditional rewrites. Exact workflow [42756335441](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756335441) is queued; no PASS is claimed.
- PR #107: new source head ba96a24de4df64513dd1a3dd801020544cc71dd0 adds an explicit normalized tail coordinate -d * (3^(k+1))⁻¹ in ZMod (2^B). It proves the odd coefficient is a unit, the normalized tail congruence has a unique solution, and the generic residue-cylinder tail is instantiated as a singleton with the exact candidate mass. It also proves the affine factorization from the prefix lift under the explicit divisibility identity defining d.
- The divisibility identity for d is still an explicit hypothesis in PR #107. Deriving it from the full prefix-residue formula, proving the full exact-child sibling partition, and mapping the result to historical APW4/BIB events remain separate obligations.
- PR #107 exact workflow [42756257770](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756257770) is queued. The new declarations are candidates, not verified PASS results.


## Superseding source-head record — 10 November 2026

PR #107 was advanced after its initial commit. Current exact source head: b5a7b83c1953927eef27b39962b044c746191066. The affine factorization proof was rewritten as an explicit three-step calc using the stated divisibility identity, avoiding a broad rewrite whose matching depended on distributivity. Exact workflow [42756547571](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756547571) is queued; no PASS is claimed for this updated head. The earlier head ba96a24de4df64513dd1a3dd801020544cc71dd0 was superseded before verification completed.


## Verification queue snapshot — 10 November 2026 (latest)

- PR #93, source head fbab49639954ae749d30a884a04032ee1d4d0f0e: syracuse-bridge-paranoid remains in progress; integrated-paranoid failed at BBMSTPrefixMeasureRecursion.lean:407 with unsolved goals and downstream sorryAx; audit succeeded. This is a failure of that integration snapshot, not a retroactive change to the separately established APW4 theorem results.
- PR #101, source head 6bad5a25400aeae8e851a38c507141ec0e092a3a: the revised dependent-stage/uncovered-branch proof is being compiled by integrated-paranoid; the audit job is queued. No result yet.
- PR #107, source head 33ff0b894391e6845a81fe1a5f472671086021ef: its prior full jobs were cancelled on the earlier source snapshot. The audit-only retry is queued; a full exact-head paranoid run is still required. The explicit residue/factorization statements remain formalization candidates until that run and the axiom audit finish.
- PR #105 documentation audit succeeded. This verifies its documentation workflow only, not Lean mathematics.
- Previously published valuation-word cylinder theorem (PR #36) and all previously proved APW4 results remain retained at their established status. No result in this queue changes those proofs.


## Latest exact-head reconciliation — 10 November 2026

- PR #101 current head remains 6bad5a25400aeae8e851a38c507141ec0e092a3a. Workflow [42756335441](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756335441): integrated-paranoid is in progress and audit is queued. No PASS yet.
- PR #107 current head is now 3534d47fcb9857109b71d1397f3976b5de35dcf1. In addition to the explicit unique tail coordinate, it now defines the prefix-tail numerator and its canonical quotient, proves the quotient multiplication identity under the exact divisibility hypothesis, and packages the lift factorization with that canonical quotient. The earlier workflow [42756547571](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756547571) was cancelled when the branch advanced; no completed verification has been returned for the current head.
- PR #105 documentation branch current head is cf918706cf242d04e70e2b4edd41750c33bf94ed. Its exact-head workflow [42756718300](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42756718300) is queued. Earlier docs-only head bbfe91e33a09a3f1325a5d6e0952c615e6c40c52 passed its audit in run 42756393394; that PASS is scoped to that earlier head.


## Dependent uncovered-branch repair — 10 November 2026

The integrated-paranoid attempt for PR #101 at prior head 6bad5a25400aeae8e851a38c507141ec0e092a3a failed at BBMSTPrefixMeasureRecursion.lean:414. The failure was a dependent-type mismatch in the universe-membership witness: the goal expected Finset.univ over C.S (prefixIndex hj (Fin.last (a+j))), while the witness was typed over C.S (stageCoordinate hk). The source has now been corrected on PR #101 at head 30dac5cf32445326aaad1b717e125c0688bea5a0 to state the exact goal type. This is a targeted repair, not a verified result; an exact-head integrated-paranoid run remains pending.

PR #93's older integrated snapshot also failed in the same recursion theorem at line 407, leaving sorryAx in downstream PAt_nonneg and PAt_sum_eq_one. PR #101 is the explicit repair line; neither failure changes the separately proved APW4 results or the published PR #36 valuation-word cylinder theorem.

PR #107's previous attempt remains cancelled at its full Lean jobs; its exact current source head is 33ff0b894391e6845a81fe1a5f472671086021ef. The explicit residue candidate is still awaiting a full exact-head run and clean named axiom audit.


## Exact-head verification mirrors started — 10 November 2026

- Draft PR #108 is a verification-only mirror of PR #101's latest source head 30dac5cf32445326aaad1b717e125c0688bea5a0. It has two queued integrated-paranoid/audit workflow attempts (42757020571 and 42756928257). Canonical mathematical repair remains PR #101; do not merge the mirror.
- Draft PR #109 is a verification-only mirror of PR #107's latest source head 33ff0b894391e6845a81fe1a5f472671086021ef. Its initial workflow attempt 42756751052 was cancelled; an audit-only retry has been queued. The Syracuse bridge paranoid job still needs a completed exact-head run. Canonical mathematical development remains PR #107; do not merge the mirror.
- These mirrors exist solely to obtain fresh exact-head CI after the original branch attempts were cancelled or completed on preceding snapshots. They add no theorem claims and do not alter the mathematical status ledger.


## APW4 dependent-stage normalization repair — latest source candidate

PR #101 has advanced to head f87657c8f02f41266a43bae1fe44f43267f0c985. The preceding exact-head run 42756335441 failed again at the uncovered branch: even with an explicit universal-membership witness, the dependent Finset membership rewrite did not match the update expression. The new repair changes the proof order instead: it identifies the proof witnesses and eliminates the dependent stage-coordinate equality before constructing and unfolding the FibreData object. The covered/uncovered split is then made only after the fibre's point type is normalized. This targets the source of the type mismatch rather than adding another local rewrite witness.

The new commit is a proof candidate. No exact-head CI run or Lean PASS has yet been returned for f87657c8f02f41266a43bae1fe44f43267f0c985. The previous failed run and its sorryAx propagation remain recorded against their own exact heads.
