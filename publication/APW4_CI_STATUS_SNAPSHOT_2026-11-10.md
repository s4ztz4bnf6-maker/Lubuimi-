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


## 8. Superseding PR #69 candidate — head aa111f, run 42724405267

A further source commit advanced PR #69 from `c09495547c2120b98973065e8cb8bfae2f6b18b8` to `aa111f1969ad54155be124025523fbd529f02968` (message: “Normalize dependent base-mass proof and remove unreachable update tactic”). It makes two targeted changes in `BBMSTPrefixMeasureRecursion.lean`: it uses the already-typed nonnegativity hypothesis directly as `hbase' := hbase`, passes `hbase` directly into `prefixFibre_updatedWeight_eq_PAt`, and removes the `split_ifs <;> ring` tactic after the preceding rewrite.

The workflow `42724292554`, which had been triggered for predecessor head `c094955...`, was cancelled when the branch advanced. This cancellation is not a proof failure and does not invalidate any earlier result. New exact-head workflow `42724405267` is now running on `aa111f...`; at latest inspection, its audit job was installing Lean and the integrated-paranoid job was queued. No result is claimed until this new exact-head workflow completes.


## 9. Hyperplane cardinality repair and latest pending head

PR #69 advanced again to head `53baa35961428ed27c42fc117e5a69fa28960067` (commit message: “Keep stage-coordinate indices folded in hyperplane cardinality normalization”). This commit changes `BBMSTHyperplaneFibreIncidence.lean` only. Workflow `42724405267`, which targeted predecessor head `aa111f...`, was cancelled after the branch advanced; this is not a proof failure. The new exact-head workflow `42724495575` was pending at the latest inspection. The current candidate head and pending run are not yet verified. The earlier prefix fixes and the new hyperplane cardinality edit must pass together in one exact-head full audit.


## Addendum 1.8 — exact-head PR #69 and PR #79 audit update

### PR #69 integrated candidate: head 53baa35961428ed27c42fc117e5a69fa28960067

Workflow 42724495575 completed with failure in both the audit and integrated-paranoid jobs. This exact-head run supersedes the earlier pending description for this candidate; it does not erase the preceding run history.

The audit job reached the source-indexed prefix recursion and reported:
- BBMSTPrefixMeasureRecursion.lean:341:45: an unsolved equality goal in prefixFibre_updatedWeight_eq_PAt;
- BBMSTPrefixMeasureRecursion.lean:364:36: No goals to be solved, caused by an extra tactic after the preceding proof step had already closed its goal.

The integrated-paranoid job reported additional upstream failures in the same module:
- line 174: omega could not prove the dependent-index goal in restrictPrefix_extendPrefix;
- line 206: simp made no progress while reducing the filtered membership in prefixPointCovered_iff, with a membership-type mismatch between the stage coordinate and the last prefix coordinate;
- line 341: the updated-weight identity remained unsolved;
- line 364: an unreachable extra tactic.

The log explicitly prints sorryAx in error-recovered declarations, including prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg, and downstream PAt inequalities/sum declarations. These declarations are not accepted as verified in this snapshot. The independent geometric declarations in BBMSTHyperplaneFibreIncidence did compile and their printed profiles were [propext, Classical.choice, Quot.sound]; this does not repair or certify the dependent prefix recursion.

**Repair order:** (1) resolve the dependent index/coordinate equality in restrictPrefix_extendPrefix; (2) prove a named equality identifying the last prefix coordinate with the stage coordinate and use it to normalize membership in prefixPointCovered_iff; (3) rewrite the updated-weight identity with those named transports and eliminate the extra tactic; (4) rebuild every dependent theorem and inspect the transitive axiom profile; (5) rerun the complete integrated package and paranoid check on one immutable exact commit. Do not hide any failed branch behind simp?, weakened hypotheses, or replacement axioms.

### PR #79 documentation audit

Workflow 42724557829 completed successfully on the exact PR #79 head 0593a89badb66b7fcab459344bd48d412327d333. It was the separate degenerate-witness audit job. It is not a Lean 4.35.0 integrated BBMST/APW4 build and does not verify PR #69.

Earlier successful APW4/BBMST checks remain valid for their own exact commits and declaration scopes. The APW4 mathematical proof record, published manuscript status, and established DT/HT/energy results are unchanged. No successful full integrated-paranoid result is claimed.

**Attribution:** APW4 research and authorship: Ta-Yoshua Lubuimi. AI tools are assistants only.


## 10. New dependent-prefix repair candidate — head 1b1a377, run 42725559211

PR #69 advanced from the failed head 53baa35961428ed27c42fc117e5a69fa28960067 to candidate head 1b1a377d7e3d0a7f4636ee6f941524a96b5dd442. The commit makes targeted changes in BBMSTPrefixMeasureRecursion.lean:

- removes the broad omega fallback from restrictPrefix_extendPrefix, leaving the definitional simplification/refl proof path;
- introduces an explicit hcoord equality between stageCoordinate hk and prefixIndex hk (Fin.last k) before unfolding prefixPointCovered_iff;
- transports the dependent proofs hk and hprev explicitly by Subsingleton.elim in the updated-weight identity;
- defines and rewrites the equality of the restricted previous prefix and the corresponding explicitly typed restriction;
- uses those named transports in hcovered, hstage, and the final PAt equality.

Exact-head workflow 42725559211 is running on this candidate. Both audit and integrated-paranoid jobs were in progress at the latest inspection; no success or failure is claimed. This candidate specifically addresses the previous errors at lines 174, 206, 341 and 364, but it is not verified until the full jobs complete and the downstream declarations have clean transitive axiom profiles without sorryAx.


## Addendum 1.9 — cross-project progress and latest exact heads, 10 November 2026

### Syracuse / Collatz compile milestone

The Syracuse programme's draft compile audit 42725006480 completed successfully on exact source commit b1a8599c686c37893a33453b759dee42047c7727. It compiled the library, iteration and threshold lemmas, Syracuse reference and quarter-descent modules, offset identity and strict-margin consequence, closed-form offset theorem, stronger offset lower bound, exact valuation-one block margin, and exact valuation-one-to-valuation-two transition. The job emitted 274 named axiom-profile outputs; the only profiles observed were [propext], [propext, Quot.sound], and [propext, Classical.choice, Quot.sound]. No actual sorryAx occurrence appeared in the completed job log. This exact source snapshot does not include a Lean formalization of the general finite-word cylinder theorem or the new tail-cylinder margin certificate, and it does not prove global Collatz.

The finite-word cylinder manuscript now includes a local tail-margin certificate: for a prefix with total exponent A and margin D, choose B with
\[
3D+(2^{B+1}-4)2^A>0.
\]
The exact tail cylinder \(a_k\ge B+1\), of relative parent mass \(2^{-B}\), then has positive next margin and strict descent. The remaining exact children \(b=1,\ldots,B\) are the finite unresolved branches. The cutoff is prefix-dependent; this is not a uniform global descent theorem.

### APW4 / BBMST latest source candidate

PR #69 advanced to exact head 1b1a377d7e3d0a7f4636ee6f941524a96b5dd442. Its latest patch removes the broad omega fallback in restrictPrefix_extendPrefix, makes the stage-coordinate/last-prefix-index equality explicit in prefixPointCovered_iff, and transports the dependent proof and prefix arguments explicitly in prefixFibre_updatedWeight_eq_PAt. Exact-head workflow 42725559211 has both audit and integrated-paranoid jobs in progress. No pass is claimed. The preceding head 53baa35961428ed27c42fc117e5a69fa28960067 failed both jobs and exposed sorryAx in error-recovered prefix-dependent declarations; that exact failure remains in the chronology.

### Documentation audit

The documentation branch head cc29c10786987d6873a3fc37df0b9fae3602c6ae has its own audit workflow 42725654168 in progress. This is a separate degenerate-witness audit, not the integrated PR #69 build. Its result must be recorded against its exact head only.

The APW4 mathematical proof record, publication status, DT/HT results, global upper energy estimate, strict lower-bound implication, and historical hypotheses remain unchanged. The APW4 diagonal mass, off-diagonal mass and BIB pair reserve remain distinct. The Syracuse tail-margin result is a candidate bridge input, not a replacement for the historical APW4 index map or BIB/Hall capacity proof.

**Attribution:** APW4 research and authorship: Ta-Yoshua Lubuimi. Syracuse/Collatz research and theorem authorship: Ta-Yoshua Lubuimi. AI tools are assistants only.


## 11. Exact-head result for PR #69 candidate 1b1a377 — run 42725559211

Both jobs completed with failure. The new candidate did not resolve the prefix recursion:
- line 174: the final rfl tactic is applied after simplification to a goal that is not a reflexive relation;
- line 206: rewriting stageCoordinate hk fails because that expression is not present in the target;
- line 343: the updated-weight identity remains unsolved after unfolding the fibre update;
- line 357: rw [hhk] is redundant because dsimp [xprev] has already closed that local equality.

The audit job prints sorryAx in the error-recovered declarations prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg, PAt_le_initial_mul_distortionProduct, PAt_succ_le_prev_div_card_mul_one_sub_delta, and PAt_sum_eq_one. The integrated-paranoid job independently reproduces the same core failure. No clean transitive axiom audit is available for those dependent declarations on this head.

This candidate is not accepted as a repair. The successful extendPrefix_restrictPrefix inverse remains a separately verified declaration on this snapshot with profile [propext, Classical.choice, Quot.sound]; it does not certify the failed recursion chain. The next repair should be split into small checkpoints: (i) prove both prefix inverse lemmas without trailing tactic fallbacks, (ii) prove prefixPointCovered_iff by unfolding its actual membership definition without the non-occurring rewrite, (iii) prove the pointwise updated-weight identity independently of the recursive normalization, and only then (iv) rebuild nonnegativity and total-mass results. Do not weaken hypotheses or introduce placeholders.


## Addendum 1.10 — PR #69 retry and exact-head repair, 10 November 2026

### Failed candidate 1b1a377 — workflow 42725559211

The candidate at head 1b1a377d7e3d0a7f4636ee6f941524a96b5dd442 completed with failure in both audit and integrated-paranoid jobs. It cleared the previous omega failure but exposed the following exact issues in BBMSTPrefixMeasureRecursion.lean:

- line 174: the final rfl failed because the lifted-prefix coordinate contains a non-definitional dependent cast;
- line 206: the explicit stageCoordinate rewrite was attempted before unfolding prefixPointCovered/prefixCoveredValues, so the pattern did not yet occur;
- line 357: an additional rewrite was attempted after dsimp had already closed the goal;
- line 343: the updated-weight identity remained unsolved.

Error recovery printed sorryAx in prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and downstream PAt inequalities/sums. Those declarations remain unverified on this head. Hyperplane and other upstream modules passing do not change this.

### New targeted retry — head d40e937

A new source commit d40e93763258a6f04978a87d99d1f700b577c2b0 makes four narrow changes:
1. supplies the explicit inequality i.val ≠ k to simplify the Function.update branch in restrictPrefix_extendPrefix and removes the unsuccessful trailing rfl;
2. unfolds prefixPointCovered and prefixCoveredValues before rewriting stageCoordinate in prefixPointCovered_iff;
3. removes the redundant rewrite after dsimp in the dependent restricted-prefix equality;
4. uses simp only with the named covered-membership, stage-coordinate and PAt transport equalities to close the updated-weight identity.

Exact-head workflow 42726230371 was queued for d40e937 at the latest inspection. No success is claimed yet. The retry is accepted only if both audit and integrated-paranoid jobs complete successfully, all downstream modules compile, and the transitive axiom output is free of sorryAx. The mathematical APW4 manuscript status remains unchanged.
