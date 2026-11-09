# APW4 / BBMST — status snapshot, 10 November 2026

**Author:** Ta-Yoshua Lubuimi  
**Record type:** Append-only CI and manuscript-status update. This note supplements, and does not replace, Dossier v1.6, the review-corrected manuscript, the publication record, or earlier successful CI evidence.

## 1. Current integration PR #69

The currently inspected PR #69 head is `95669afac00d8913c1fc2a91b6bb3b5740ce6d92` on `integration/bbmst-apw4-kernel-2026-11-09`.

Exact-head workflow run `42722133436` completed with failure in both jobs:
- audit job `129518446426`: the source-indexed `BBMSTPrefixMeasureRecursion.lean` compile step failed; downstream audit steps were skipped;
- integrated-paranoid job `129518446948`: the full integrated BBMST/APW4 build and paranoid check failed.

The audit job successfully compiled the audited upstream source, degenerate-witness tests, zero-safe sieve parameter core, zero-safe fibre measure core, finite weighted fibre update, uniform-coordinate instantiation, finite-stage first/second moments, finite-coordinate geometry core, and uniform-stage source moment instantiation before reaching the prefix recursion failure.

The exact failure record is retained in `APW4_CI_RUN_42722133436_DIAGNOSTIC_2026-11-10.md`. No successful integrated `lake check --paranoid` is claimed for PR #69.

## 2. Documentation PR #79 is not the integrated source audit

PR #79 is a documentation-only update branch at head `2be6cec71a783eb1293d32a70df4646a5616f71a`. Its workflow run `42723539932` is the `Lean degenerate-witness audit` workflow, not the integrated-paranoid BBMST/APW4 source build.

At the first inspection, run `42723539932` was still `in_progress`; it subsequently completed successfully on the then-current documentation-branch commit `2be6cec71a783eb1293d32a70df4646a5616f71a`. Its audit job completed the upstream source compile and focused degenerate-witness tests. Subsequent documentation commits advanced PR #79's head, so this successful run does not verify the latest PR #79 head and does not establish an integrated APW4 Lean result. The run must be reported separately and not conflated with PR #69.

## 3. Earlier mathematical and formalization records remain unchanged

The author's APW4 mathematical proof record and independently finalized publication manuscript remain preserved as the mathematical source of record. The established APW4 energy decomposition, DT, weighted HT, global upper energy estimate and strict lower-bound implication are not changed by the current Lean integration status.

Previously successful, declaration-scoped checks remain valid for their exact commits and scopes, including runs `42599116967`, `42599116987`, `42522617494` and the separately recorded geometry/Step-16 checkpoints. A later integration failure is not a retroactive failure of those checks and is not a mathematical counterexample.

## 4. Next source-level work

The next repair target remains the dependent prefix recursion. Work must expose the exact dependent index equalities and prove the restriction/extension maps without broad casts, weakened hypotheses, or recovery axioms. Only after that module compiles should the prefix event-mass identities, concrete prefix-to-stage moment bridge, hyperplane incidence bridge and downstream moment recurrence be re-run.

The hyperplane incidence obligations from the failed integrated build remain separate and must be checked on the same final source head. A complete pass requires:
1. all intended library modules compile;
2. `lake check --paranoid` succeeds;
3. positive declaration coverage is recorded;
4. named `#print axioms` output is inspected;
5. the complete logs contain no `sorryAx` and no project-specific surrogate axioms.

## 5. Preservation and attribution

No historical APW4 definition is replaced by a convenient model object. The diagonal mass, off-diagonal mass and BIB pair reserve remain distinct until their explicit historical index-preserving maps and capacity bounds are proved in the relevant formalization.

APW4 research and authorship: **Ta-Yoshua Lubuimi**. AI tools are assistants only, not authors or independent mathematical verifiers.


## 6. Follow-up: documentation audit run completed

Run `42723539932` has now completed successfully. Its audit job completed the audited upstream source compilation and focused degenerate-witness tests. The run checked the then-current documentation-branch commit `2be6cec71a783eb1293d32a70df4646a5616f71a`; subsequent documentation commits advanced PR #79's head. Therefore this successful run is recorded only for that exact earlier snapshot and is not evidence for the latest PR #79 head, nor is it an integrated BBMST/APW4 paranoid build.


## 7. New PR #69 repair candidate — 10 November 2026

PR #69 has advanced from the previously failed head `95669afac00d8913c1fc2a91b6bb3b5740ce6d92` to candidate head `c09495547c2120b98973065e8cb8bfae2f6b18b8` (commit message: “Repair dependent prefix inverse lemmas and covered predicate rewrite”). The commit changes only `BBMSTPrefixMeasureRecursion.lean` with explicit simplification/refl closure, a direct dependent-index equality proof, a rewritten `prefixPointCovered_iff`, and explicit stage/covered-predicate transports in the updated-weight identity. It also replaces two fibre-membership simplifications with the direct fact that every point belongs to `Finset.univ`.

New exact-head workflow `42724292554` was queued and had both audit and integrated-paranoid jobs in progress at the latest inspection. No success or failure is claimed yet. The candidate repairs are not considered verified until both jobs complete, the prefix and downstream hyperplane steps are inspected, and the full paranoid/axiom requirements pass. The prior failure at head `95669...` remains part of the chronology and is not erased.
