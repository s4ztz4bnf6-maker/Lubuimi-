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


## Exact child-cylinder formalization candidate — PR #107

PR #107 has advanced to source head cad354967759a89c02df1b42369898dec3406445. Beyond the unique tail coordinate and canonical quotient, the Lean module now defines the exact child-b coordinate as (2^(b-1)-d) * (3^(k+1))^(-1) modulo 2^b, proves its normalized congruence and uniqueness, and instantiates each child as a residue cylinder in the common refinement. The child cylinder has exactly 2^(B-b) lifts and an explicit membership/congruence characterization.

This is the normalized finite-fibre layer. The remaining steps are to derive the divisibility of the prefix-tail numerator from the explicit prefix residue formula, prove the complete pairwise-disjoint child-plus-tail partition, and connect these normalized congruences to the original exact valuation predicates and then to historical APW4/BIB events. No Lean PASS is claimed for cad354967759a89c02df1b42369898dec3406445; an exact-head workflow has not yet been returned.


## Latest mathematical-source deltas and verification mirrors — 10 November 2026

- Canonical PR #101 advanced to f87657c8f02f41266a43bae1fe44f43267f0c985. The dependent stage-index normalization (proof-witness equalities and stageCoordinate = prefixIndex) is now performed before constructing/unfolding the prefix fibre. The covered/uncovered split is reduced to simp [hcov] in each branch. This is a new proof candidate; exact-head integrated-paranoid and audit runs are queued, not passed.
- Canonical PR #107 advanced to 3534d47fcb9857109b71d1397f3976b5de35dcf1. It now defines the numerator N = 3^(k+1) r₀ + 3 Cₖ + 2^A and the canonical quotient d = N / 2^(A+1), proves the quotient multiplication identity from divisibility, and derives the affine prefix-tail factorization with that canonical d. The divisibility N mod 2^(A+1) = 0 remains an explicit hypothesis; it has not yet been derived from the full valuation-prefix residue theorem. This is a substantive narrowing of the formalization gap, not a completed APW4 bridge.
- Stale verification mirrors #108 and #109 were closed after their source heads moved. Current verification-only draft mirrors are #110 (exact PR #101 head) and #112 (PR #107 plus one comment-only trigger commit). Their integrated/audit/paranoid jobs are queued. Canonical mathematical branches remain PR #101 and PR #107; do not merge the mirrors.
- PR #105 documentation audit remains queued at the latest documentation head. No new PASS is claimed for any of these queued runs.


## PR #107 namespace and child-residue consolidation — latest source head

PR #107 now stands at exact source head 44d00ad20c352471795358dde2aaf24152281649. The canonical quotient and exact child-coordinate declarations are now kept inside the SyracuseDyadicResidueFibre namespace, alongside the generic tail-cylinder construction. The provenance note was also corrected to describe the actual source extension rather than calling the code commit comment-only. This head includes the unique tail coordinate, quotient/factorization under the explicit divisibility condition, unique exact child-b residues modulo 2^b, and 2^(B-b) child lift counts. The exact prefix-divisibility derivation and complete child-plus-tail partition remain open.

No completed exact-head CI result has yet been returned for 44d00ad20c352471795358dde2aaf24152281649. No Lean PASS is claimed.


## Latest workflow queue snapshot — 10 November 2026

- PR #101 current source head f87657c8f02f41266a43bae1fe44f43267f0c985: exact workflow [42757161402](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757161402), integrated-paranoid and audit both queued.
- PR #107 current source head 44d00ad20c352471795358dde2aaf24152281649: exact workflow [42757388002](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757388002), isolated Syracuse paranoid, integrated-paranoid and audit all queued.
- PR #105 current documentation head 850bff36256ca81a125c43038ce605550d5f3eea: exact workflow [42757417421](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757417421), audit queued.
- Collatz PR #48 current head 7920b26f8a230c6f9fdc144be40fb2070eba5f00: exact workflow [42756479069](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42756479069), Lean 4.34.1 build, compile-drafts and Lean 4.35.0 paranoid jobs queued.

These are queued states, not PASS results. The previously verified Collatz Lean 4.35.0 finite-cap source result remains scoped to exact commit e1fb06eaa07190d8abfb3fc7368f3dc0663a5a66 and workflow 42754461228.


## Workflow status refresh — 10 November 2026

- PR #101 head f87657c8f02f41266a43bae1fe44f43267f0c985: run [42757161402](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757161402); audit is in progress, integrated-paranoid queued.
- PR #107 head 44d00ad20c352471795358dde2aaf24152281649: run [42757388002](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757388002); audit, isolated Syracuse paranoid and integrated-paranoid queued.
- PR #105 documentation head 8866fa2600c0de9bd41becefda77d157fc8f6465: run [42757470737](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757470737), audit queued.
- Collatz PR #48 documentation/workflow head cbe9f19b9ba1bd4bad290b1cbc56da2881c238b8: run [42757504798](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42757504798), all three jobs queued.

No queued or in-progress job is a PASS. The previously recorded Collatz Lean 4.35.0 paranoid PASS remains scoped to its exact source head and run.


## Exact-head status reconciliation — 10 November 2026 (follow-up)

**APW4 PR #101** remains open on branch `repair/apw4-prefix-uncovered-change-2026-11-10`, exact head `f87657c8f02f41266a43bae1fe44f43267f0c985`.

- Run [42755782237](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42755782237) belongs to the earlier `f5aff142` source and failed. Its error was at `BBMSTPrefixMeasureRecursion.lean:411:23`; the report showed `sorryAx` propagated into `PAt_nonneg` and `PAt_sum_eq_one`.
- Run [42757047779](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757047779), associated with the current `f87657c8` head, has audit = success while integrated-paranoid is still in progress at this check.
- Run [42757161402](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757161402), also associated with `f87657c8`, has audit = in progress and integrated-paranoid = queued at this check.

No integrated Lean-4.35 PASS and no clean dependent-theorem axiom audit are claimed yet for PR #101. The earlier `f5aff142` failure remains attached only to that exact source.

**APW4 PR #107** remains open on branch `bridge/syracuse-explicit-tail-residue-2026-11-10`, exact head `44d00ad20c352471795358dde2aaf24152281649`. Run [42757388002](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757388002) was queued at this check. No PASS is claimed for this head.

This ledger update changes documentation only. It does not alter any mathematical theorem status, the PR source branches, or the previously established independent APW4 results.


## Exact-head reconciliation — 10 November 2026, 04:50 UTC

This entry supersedes the earlier queue snapshot above for the exact PR heads named here. It is an append-only verification record; it does not revise the established mathematical status of APW4.

### PR #101 — prefix recursion

- Canonical branch: `repair/apw4-prefix-uncovered-change-2026-11-10`.
- Exact source head: `f87657c8f02f41266a43bae1fe44f43267f0c985`.
- Run [42757161402](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757161402): audit job [129634085319](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757161402) succeeded; integrated-paranoid job [129634085692](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757161402) failed.
- The integrated log identifies two remaining goals in `BBMSTPrefixMeasureRecursion.lean` at lines 393–394. Both are dependent membership/conditional-reduction goals: the proof's `hcov` is stated over `prefixCoveredValues`, while `updatedWeight` branches over `F.covered` and then `F.points`. The `simp [hcov]` calls do not normalize these two decisions to the same proposition.
- The log also prints `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and propagates it into `PAt_nonneg`, `PAt_sum_eq_one`, `PAt_le_initial_mul_distortionProduct`, and `PAt_succ_le_prev_div_card_mul_one_sub_delta`.
- Status: **NOT VERIFIED — exact-head integrated-paranoid failure**. The next repair must explicitly transport endpoint membership to `F.covered` and separately reduce the covered and uncovered branches. No source repair is claimed in this record.

### PR #107 — explicit Syracuse tail/child residues

- Canonical branch: `bridge/syracuse-explicit-tail-residue-2026-11-10`.
- Exact source head: `44d00ad20c352471795358dde2aaf24152281649`.
- Run [42757388002](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42757388002): `syracuse-bridge-paranoid` failed; `integrated-paranoid` failed; the isolated audit job was still in progress at the last poll.
- Exact compiler errors: `SyracuseDyadicResidueFibre.lean:276:35` and `:485:36` cannot project `.isLt` from the dependent `ZMod.val` representation; line `:290` has an unsolved `mpr` equality. The named tail/child atom membership and cardinality declarations consequently report `sorryAx`.
- The normalized congruence existence/uniqueness and affine factorization declarations shown in the same log have the reported standard profile (or `[propext]` for the factorization); that positive evidence is declaration-scoped and does not clear the failed atom/cardinality declarations.
- Status: **NOT VERIFIED — exact-head bridge and integrated failures**. The arithmetic statements are not refuted by these representation errors.

### Collatz PR #48

- Exact source head: `cbe9f19b9ba1bd4bad290b1cbc56da2881c238b8`.
- Run [42757504798](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42757504798): Lean 4.35 paranoid, draft compilation, and Lean 4.34 kernel jobs were all queued at the last poll. No PASS is claimed for this run.

### Mathematical and publication boundary

The established APW4 results recorded in the main proof dossier — DT, HT, historical atom identification, BIBW dominance, weighted Hall conditions, exact energy decomposition, CRT fibre balance, and the global energy inequality — remain established at their previously recorded mathematical status. The failures above are formal integration results attached only to the exact Lean source heads. PR #107 is a separate Syracuse formal bridge, not a new premise of the APW4 energy theorem.

The finalized manuscript PDF is not silently rewritten by this CI ledger. This append-only record is the current repository-side verification addendum; the author's publication copy remains under the author's control.


### PR #101 targeted follow-up — 10 November 2026, 04:55 UTC

- New exact source head: `dbbeaf7a14ebcceb8abf97b6a9113d84a024c54c` on `repair/apw4-prefix-uncovered-change-2026-11-10`.
- The preceding exact log for head `f87657c8f02f41266a43bae1fe44f43267f0c985` shows the positive branch goal as an implication whose antecedent is precisely the negation of the active branch hypothesis. The candidate replaces that branch's `simp [hcov]` with explicit contradiction elimination: `intro hnot; exact (hnot hcov).elim`. The uncovered branch remains unchanged and is still a proof obligation.
- Exact-head workflows [42758799252](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42758799252) (push) and [42758803063](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42758803063) (pull_request) were queued at the latest poll. No result is inferred from queue state.
- Status: **PROOF CANDIDATE — NOT VERIFIED**. Await both exact-head jobs, inspect the remaining branch goals, then check declaration-scoped `#print axioms` for the recursion identity and dependent `PAt` results. The previously established APW4 mathematical results are unchanged.
