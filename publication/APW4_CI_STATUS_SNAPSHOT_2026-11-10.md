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


## Follow-up: Syracuse residue-coordinate repair candidate (10 Nov 2026)

A source-level patch was committed on `bridge/syracuse-explicit-tail-residue-2026-11-10`: `bd8a7857a07f4fb32bbcfe9e2b446bd5b7403028`. In `SyracuseDyadicResidueFibre.lean`, both finite-coordinate constructors now use `ZMod.val_lt` rather than the nonexistent projection `.isLt` on a `ZMod` expression. The API was verified in Mathlib v4.35.0 at `Mathlib/Data/ZMod/Basic.lean`, theorem `ZMod.val_lt`. The commit triggered workflow run `42759029006` (queued at observation). Status: **unverified candidate**. The previous run `42757388002` failed in `SyracuseDyadicResidueFibre` at the finite-coordinate bound and membership proof; its `sorryAx`-dependent declarations remain disallowed. This bridge remains separate from APW4.

### Exact-head update — 10 November 2026 (after 04:58 UTC)

**PR #101:** the complete log of integrated run `42758803063` showed that the positive branch of `prefixFibre_updatedWeight_eq_PAt` had no remaining binder: its goal was an equality. The attempted `intro hnot` branch was therefore rejected by Lean. Exact head `0be00b2161ad8f2676779b90582f30b34083c008` replaces both branches with `simp [hcov]`. Its own workflow `42759210844` now exists; both `audit` and `integrated-paranoid` were QUEUED at the latest poll. This is an unverified candidate.

**Syracuse #107:** run `42759029006` has progressed beyond setup. `integrated-paranoid` is in the integrated Lean compilation step; `audit` has started Lean/manifest setup; `syracuse-bridge-paranoid` is QUEUED. The `ZMod.val_lt` change is still only an API/type repair candidate. The prior `sorryAx` dependencies in the explicit atom/membership/cardinality declarations remain unresolved until exact logs show otherwise.

**Collatz #48:** exact head `cbe9f19b9ba1bd4bad290b1cbc56da2881c238b8` remains on run `42757504798`; `kernel-check-lean-435-paranoid`, `compile-drafts`, and `kernel-check-lean-434` are all QUEUED. No new theorem evidence is claimed.

**New formalization route, not yet proved:** the current minimal-counterexample wrapper assumes `hminimal : ∀ j, n j < n₀ → ∃ k, n (j+k)=1`. To derive it from minimality rather than assume it, formalize the exact accelerated-step relation, prove each `n j` is odd using `a j > 0`, prove the quotient `n (j+1)` is odd and hence `a j` is the exact 2-adic valuation, and establish by deterministic recursion that the tail from `n j` is the same Syracuse orbit. Then the least-odd-counterexample premise yields the suffix return. Until these links are proved, `hminimal` remains an explicit hypothesis and the minimal-counterexample theorem is conditional.


## Syracuse #107 — integrated failure and exact follow-up (10 November 2026)

Workflow 42759029006 completed with integrated-paranoid, audit, and dedicated Syracuse-paranoid all failing. The compiler log identifies two distinct source blockers in that PR branch:

1. SyracuseDyadicResidueFibre.lean:290: in the reverse implication of explicitTailAtoms_mem_iff, the proof did not establish that the explicit finite representative is below 2^B. The failed declaration's axiom output contains sorryAx.
2. BBMSTPrefixMeasureRecursion.lean:386: the APW4 prefix recursion's final-coordinate term is indexed by prefixIndex hj (Fin.last ...), while the fibre expects stageCoordinate hk. Lean rejects the application with a dependent coordinate type mismatch. This is a distinct older proof body on the PR #107 integration branch; do not conflate it with PR #101's newer candidate.

The Syracuse membership issue has a narrow follow-up on PR #107: exact head 5139df8b55279011862084c453105a13926b03cc rewrites the representative equality and closes the modulo bound using (explicitTailCoordinateFin B k d).isLt. Its own workflow 42759653537 was QUEUED at the latest poll. No pass is claimed.

The PR #107 APW4 source mismatch remains open pending the separate PR #101 verification. PR #101 exact head 0be00b2161ad8f2676779b90582f30b34083c008 has workflow 42759210844; audit is restoring dependencies and integrated-paranoid is assembling the Lean package. Both remain in progress. No established APW4 theorem is downgraded by these integration failures.


## Exact-head progression — 10 November 2026

PR #101 exact head 0be00b2161ad8f2676779b90582f30b34083c008, workflow 42759210844: the audit has successfully completed all stages up to and including uniform-stage source moment instantiation, and is now compiling the source-indexed BBMST prefix measure recursion. The integrated-paranoid job has completed integrated package assembly, bubblewrap setup, and Mathlib cache restoration and is compiling all integrated BBMST/APW4 modules, including the full Theorem 1.2 reduction. Both remain IN_PROGRESS. The key uncovered-branch equality is now under direct compilation; no result is inferred before the step and complete run finish.


## Exact-head audit/integration discrepancy and follow-up — 10 November 2026

Run 42759210844 has completed: audit SUCCESS; integrated-paranoid FAILURE. The audit's direct Lean compilation of `BBMSTPrefixMeasureRecursion.lean` printed the following named declarations with `[propext, Classical.choice, Quot.sound]`: `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, `PAt_succ_le_prev_div_card_mul_one_sub_delta`, and `PAt_sum_eq_one`. In contrast, the integrated-paranoid log for the same reported head has unsolved goals in `prefixFibre_updatedWeight_eq_PAt` at lines 393–394 and failure recovery prints `sorryAx` for this theorem and dependent declarations. Do not collapse these distinct job results into a single pass. The discrepancy must be investigated; integrated-paranoid remains the decisive gate for the integrated theorem.

The exact remaining goals show that the `updatedWeight` side is not reducing its `F.covered` membership in lockstep with the recursive `PAt` covered predicate. The residual expressions include an `if` over the fibre's `Finset.univ` points and the wrong covered/uncovered multiplier branch. Thus the prior `simp [hcov]` was not sufficient to transport the predicate across the fibre record's definition and dependent coordinate witnesses.

Follow-up exact head `31cc94993fdcb481cea919ca762a29c568948a7a` on PR #101 now cases on `y (Fin.last k) ∈ F.covered`, then explicitly transports that membership/nonmembership to `prefixCoveredValues` before simplifying the update and recursive sides. Its exact-head workflow is 42760198290, QUEUED at this snapshot. No pass is claimed for this candidate.


## 10 November 2026 — PR #107 audit result and APW4 dependency separation

Exact-head PR #107 run `42759653537` (commit `5139df8b55279011862084c453105a13926b03cc`) directly compiled `SyracuseDyadicResidueFibre.lean`. The focused log prints `explicitTailAtoms_mem_iff`, `explicitTailAtoms_card`, and `explicitCandidate_mass` with axiom profile `[propext, Classical.choice, Quot.sound]`; no `sorryAx` appears in that module's focused output. The audit job as a whole failed later in `AuditCheck.lean` while compiling the APW4 dependency `BBMSTPrefixMeasureRecursion.lean:386:2`, with `dsimp made no progress`. Its recovery output reports `sorryAx` for APW4 recursion declarations. Classify this as: isolated Syracuse module compile observed; full audit failed on APW4 dependency; isolated Syracuse paranoid check still running; integrated-paranoid queued. Do not attribute the APW4 failure to the Syracuse modulo lemma, and do not claim PR #107 complete.


## Exact-head CI addendum — 10 November 2026, 06:25 CET

This entry is append-only. It does not revise the mathematical status of the established APW4 results or the independently published manuscript held by the author.

### PR #101 — prefix-fibre recursion candidate

- Candidate source head recorded in the preceding entry: `31cc94993fdcb481cea919ca762a29c568948a7a`; workflow [42760198290](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42760198290).
- `integrated-paranoid` failed while compiling `BBMSTPrefixMeasureRecursion.lean`: the two residual goals are at lines 390 and 402 in that checkout. The positive branch retains an implication whose premise is the negation of the covered predicate despite the local positive membership hypothesis; the negative branch retains the covered/uncovered conditional rather than reducing it. The integrated log prints `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and dependent `PAt) declarations. This is a real failure of that exact integrated build.
- The separate `audit` job passed its staged compilation and reported the standard profile for its audited declarations. That result is a distinct audit path and does not override the integrated failure.
- The next source repair must align the update's actual `F.covered` predicate with the recursive `prefixCoveredValues) predicate before unfolding either conditional, then simplify the two branches explicitly. This is a repair target, not a verified fix. No previously established APW4 mathematical theorem is reopened by this Lean integration failure.

### Syracuse PR #107 — isolated and integrated scopes

Workflow [42759653537](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42759653537) has the following distinct outcomes:

- The targeted `SyracuseDyadicResidueFibre.lean` compilation succeeded. `explicitTailAtoms_mem_iff`, `explicitTailAtoms_card`, and `explicitCandidate_mass` report `[propext, Classical.choice, Quot.sound]`; the targeted module output contains no `sorryAx` for these declarations.
- The audit job later failed in the APW4 dependency `BBMSTPrefixMeasureRecursion.lean:386` with `dsimp made no progress` and an application type mismatch involving `y (Fin.last (a + j))`. This does not invalidate the preceding isolated Syracuse module compilation.
- The integrated-paranoid job failed at the same APW4 dependency. The isolated `syracuse-bridge-paranoid` job was still in progress at the latest job poll; its log endpoint returned `BlobNotFound`, so no completion is asserted.

### Collatz PR #48 — exact run fully green

On workflow [42759509255](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42759509255), all three jobs completed successfully: `kernel-check-lean-434`, `kernel-check-lean-435-paranoid`, and `compile-drafts`. The Lean 4.35.0 job completed `lake check --paranoid` and the named finite-path/terminal-residue module check. This is a full job-level CI success for that exact run and its source head. It proves only the declarations and scope actually built and audited there; the finite cap-tree path certificate remains a finite-depth necessary condition and does not exclude an infinite branch or prove global Collatz termination.

The existing initial-cylinder, valuation-bound, offset, strict-margin, finite valuation-word cylinder, and dyadic fibre results retain their prior independent mathematical and exact-commit verification status. Later integration outcomes do not retroactively downgrade them.

**Status:** APW4 integrated prefix recursion remains open; Syracuse isolated paranoid completion remains open; Collatz PR #48 exact run is green within its stated finite-depth scope. Mathematical proofs, historical reconstruction, isolated compilation, integrated compilation, paranoid kernel checking, and declaration-scoped axiom output remain separate evidence categories.


## Follow-up proof candidate — PR #114, 10 November 2026

A new narrow candidate is recorded at [PR #114](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/114), exact source head `d09d28935c9e026f4b8297b058c3cd4169231451`. It is based directly on the canonical PR #101 source head `31cc94993fdcb481cea919ca762a29c568948a7a` and changes only `BBMSTPrefixMeasureRecursion.lean` (12 additions, 21 deletions).

The candidate moves the case split onto the recursive geometric membership predicate `prefixCoveredValues` before unfolding `updatedWeight` and `PAt`; it then transports the positive/negative membership fact to the concrete `F.covered` field and simplifies the corresponding branch. It changes no definitions, theorem statements, hypotheses, or mathematical claims. PR #113 was closed after identifying that its comparison base was unsuitable and its diff was not narrowly scoped; no source change from that branch is retained in PR #114.

No verification result is claimed yet. The acceptance gate remains exact-head integrated-paranoid success, the separate audit, inspection of named `#print axioms`, and absence of `sorryAx` throughout the dependency closure. Established APW4 mathematical results and the published manuscript status remain untouched.
