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


## Addendum 1.10 — exact PR #69 and documentation audit status, 10 November 2026

### PR #69 candidate 1b1a377: completed failure

The exact-head workflow 42725559211 completed with failure in both audit and integrated-paranoid jobs. The attempted repair at head 1b1a377d7e3d0a7f4636ee6f941524a96b5dd442 did not resolve prefix recursion. The audit reported: line 174, an rfl tactic applied to a non-equality goal after simplification; line 206, a rewrite for stageCoordinate hk with no matching occurrence; line 343, an unsolved updated-weight identity; and line 357, a redundant rw after dsimp had closed the local equality. Error recovery printed sorryAx in prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and downstream PAt inequalities/sum. The integrated-paranoid job reproduced the same issues. This candidate is not verified.

The PR #69 source branch has since advanced to head d40e93763258a6f04978a87d99d1f700b577c2b0. Its current exact-head workflow 42726230371 has both audit and integrated-paranoid jobs in progress at the latest check. No outcome is claimed yet. The new source revision already changes the prefix inverse proof and removes the redundant local rewrite; the non-occurring stageCoordinate rewrite and updated-weight identity still require exact verification. The next report must be bound to d40e937 and run 42726230371, not to the earlier failed head.

### Documentation branch audit

Documentation audit 42725654168 completed successfully, but it checked only the then-current documentation head cc29c10786987d6873a3fc37df0b9fae3602c6ae. The documentation branch has subsequently advanced to 8efcad9d5aba7b457b1adc501201836ead9019e6 with the appended Addenda 1.9 and 1.10 material. Therefore 42725654168 is a valid successful audit of its exact older snapshot, not a verification of the latest documentation head. A new exact-head audit is required.

The APW4 mathematical proof record, DT, HT, global upper energy estimate, strict lower-bound implication and historical definitions remain unchanged. CI failures are confined to the stated Lean integration snapshot. No global theorem or prerequisite is weakened, and no APW4 result is silently downgraded.


## Addendum 1.11 — PR #69 exact-head diagnostic and next candidate, 10 November 2026

Workflow 42726230371 completed with failure on PR #69 source head d40e93763258a6f04978a87d99d1f700b577c2b0. The audit and integrated-paranoid jobs both failed. The new diagnostic is narrower and explicit:
- the inverse lemma restrictPrefix_extendPrefix still has a dependent Fin/cast equality goal after simplification;
- prefixPointCovered_iff still attempts an invalid rewrite across the dependent Finset membership type; the target's membership type is indexed by stageCoordinate hk, while the rewrite motive is ill-typed;
- prefixFibre_updatedWeight_eq_PAt has unresolved implicit A parameters in two prefixCoveredValues occurrences, in addition to the residual updated-weight identity goal;
- error recovery again prints sorryAx in the affected covered predicate, fibre update, nonnegativity and downstream mass inequalities.

A new source candidate has now been committed to PR #69 at exact head 4d5186564006439b48fe95b060a1cfd1c279238a. It removes the non-occurring stageCoordinate rewrite and makes the hyperplane-family parameter A explicit in both covered-value terms. Exact-head workflow 42726991713 was queued for this commit at the latest check. No result is claimed until both audit and integrated-paranoid jobs complete. The inverse lemma remains an independent open proof obligation; no hypotheses have been weakened and no placeholders are accepted.

The mathematical APW4 dossier, DT, HT, upper energy estimate and strict lower-bound implication remain unchanged. The current work is solely Lean integration.


## Addendum 1.11 — separate terminal-residue collision-energy project

A third Syracuse-side theorem project has been separated from the initial all-one cylinder and general finite-word cylinder projects: Lubuimi's Terminal-Residue Collision Energy, standalone project PR #38 in the Lubuimi repository. Its manuscript proves the terminal-residue map
\[
\tau_k(\alpha)=C_k(\alpha)2^{-A(\alpha)}\pmod{3^k},
\]
the exact moment split
\[
E_k=D_k+C_k^{\rm coll},\qquad D_k=3^{-k},
\]
and the forced collision lower bound
\[
C_k^{\rm coll}\ge\frac{1}{2\cdot3^k}.
\]
It also proves explicit finite truncation error bounds and gives a finite rational Markov transition matrix with terminal distribution \(m_k=\delta_0P_k^k\). The exact \(k=2\) distribution is \((8,16,11,4,2,22)/63\), with \(E_2=5/21\).

This is a mathematically distinct Syracuse finite-place second-moment result. It is not the historical APW4 BIB reserve. The APW4 bridge still requires the explicit index-preserving historical event/place map, preservation or domination of historical weights, separate diagonal and off-diagonal transport inequalities, and a proved BIB capacity/Hall condition. The collision-energy manuscript has not yet been Lean-compiled or axiom-audited.

The combined Syracuse research inputs now include: (i) exact finite-word cylinders and tail partitions; (ii) the local state-dependent finite cap on non-descending next valuations; and (iii) terminal-residue collision energy and the Markov representation. These are separate mathematical inputs. None alone establishes the missing APW4 transport or global Collatz descent.

**Attribution:** all APW4 and Syracuse/Collatz research and theorem authorship: Ta-Yoshua Lubuimi. AI tools are assistants only.


## Addendum 1.12 — PR #69 partial repair outcome and next exact head

### Run 42726230371 on d40e937 — both jobs failed

The exact-head retry on d40e93763258a6f04978a87d99d1f700b577c2b0 completed with failure in both audit and integrated-paranoid jobs. It nevertheless made a measurable partial improvement: extendPrefix_restrictPrefix, prefixExtensionEquiv, and sum_prefix_eq_sum_extensions printed only the standard profile [propext, Classical.choice, Quot.sound] in the audit log. These declarations no longer inherit sorryAx on this snapshot.

Remaining exact errors:
- restrictPrefix_extendPrefix still has a dependent-coordinate equality goal in the integrated build (line 171/174);
- prefixPointCovered_iff still fails because the rewrite motive is not type-correct after unfolding the filtered set; error recovery prints sorryAx;
- prefixFibre_updatedWeight_eq_PAt still has an unsolved equality goal at line 344;
- explicit A arguments were not yet supplied consistently in the covered-membership expressions;
- PAt_nonneg and downstream PAt inequalities/sum declarations still inherit sorryAx from the failed updated-weight/covered chain.

The audit job reports the rewrite-motive error in prefixPointCovered_iff, missing implicit A in the covered-membership proof, and the unsolved updated-weight identity. The integrated-paranoid job independently reports the dependent cast in restrictPrefix_extendPrefix and the same membership/updated-weight chain. The full error log is retained in workflow 42726230371.

### New candidate head 4d518656

Commit 4d5186564006439b48fe95b060a1cfd1c279238a removes the premature coordinate rewrite in prefixPointCovered_iff and makes the implicit family A explicit in both sides of hcovered. Exact-head workflow 42726991713 was queued at the latest inspection. No success is claimed yet. The next acceptance condition remains both audit and integrated-paranoid success, clean downstream transitive axiom profiles, and no sorryAx.


## Addendum 1.12 — latest exact-head workflows queued, 10 November 2026

- PR #69 source head `4d5186564006439b48fe95b060a1cfd1c279238a` has exact-head workflow [42726991713](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42726991713). At the latest status check both `audit` and `integrated-paranoid` jobs were still queued. No compile or kernel-verification result is claimed for this candidate.
- Documentation PR #79 head `f1a48b7353961177e1b6e3f34b074ac78155e424` has workflow [42727094672](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42727094672), also queued at the latest check. Earlier successful docs workflow 42725654168 remains tied only to its older head, not this current head.

This status supersedes any implication that the latest candidate has already completed. APW4 mathematical statements and manuscript results remain untouched; these are pending CI checks of source/documentation snapshots only.


## Addendum 1.13 — documentation head advanced after queued audit

The documentation branch advanced after workflow 42727094672 was queued. That workflow was triggered for the then-current documentation head `f1a48b7353961177e1b6e3f34b074ac78155e424`; the latest PR #79 head is now `579bf0b23aef2909d860abd1e0ff4c970fc433ab` after Addendum 1.12 and the PR-body chronology correction. A commit-specific workflow lookup for `579bf0b23aef2909d860abd1e0ff4c970fc433ab` returned no run at the latest check. Therefore 42727094672 is not evidence for the latest documentation head; a new exact-head run is still required.

PR #69 workflow 42726991713 has progressed since the prior check: `integrated-paranoid` is now in progress and `audit` remains queued. No outcome is claimed until both finish on exact head `4d5186564006439b48fe95b060a1cfd1c279238a`.


## Addendum 1.13 — finite-branching Syracuse cap as a bridge input

The finite-word manuscript now states the local margin result in an exact necessary-cap form. For a prefix with total exponent \(A\), margin \(D\), and next valuation \(b\),
\[
D'=3D+(2^b-4)2^A.
\]
If the next odd iterate has not descended below the initial odd start, then \(D'\le0\) is necessary, so
\[
2^{A+b}+3D\le4\cdot2^A.
\]
Only finitely many positive \(b\) satisfy this for each fixed prefix. A least hypothetical nonterminating start would therefore determine an infinite path in a state-dependent finitely branching tree. Every larger next valuation lies in the exact tail cylinder and forces strict descent.

This is a new local arithmetic reduction and a candidate input to the APW4 incidence/energy programme. It does not provide a uniform branching bound or exclude an infinite path. It is not Lean-compiled yet. The APW4 historical transport, diagonal/off-diagonal inequalities, and BIB/Hall capacity remain separate open obligations.


## Addendum 1.14 — completed run 42726991713 and new exact-head repair

PR #69 run 42726991713 completed with failure in both audit and integrated-paranoid jobs on exact head 4d5186564006439b48fe95b060a1cfd1c279238a. The audit job reached and compiled the upstream source, focused degenerate-witness tests, zero-safe fibre/update chain, uniform-coordinate instantiation, finite-stage moments, finite-coordinate geometry, and uniform-stage source moment; it then failed in the source-indexed prefix recursion. Downstream prefix cylinder, moment bridge, hyperplane incidence, old-shadow, finite union and moment-recurrence steps were skipped because the prefix module failed.

The integrated-paranoid job reports:
- BBMSTPrefixMeasureRecursion.lean:171:55 — unresolved nested dependent-coordinate casts in restrictPrefix_extendPrefix;
- line 207 — membership type mismatch between C.S (prefixIndex hk (Fin.last k)) and Finset (C.S (stageCoordinate hk)) in prefixPointCovered_iff;
- line 342:45 — unresolved equality in prefixFibre_updatedWeight_eq_PAt.

The audit log confirms sorryAx in prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and downstream PAt inequalities/sums. The independent declaration extendPrefix_restrictPrefix and the prefix-extension sum identity print only [propext, Classical.choice, Quot.sound] on this snapshot. This is partial proof progress, not an integrated success.

A new source candidate is at head 8e7cd3ca5b3440ee25eb6241f2aa799103b56830. It adds explicit Fin-index equalities to the restriction proof, unfolds stageCoordinate in the covered-predicate reduction, and splits the covered/uncovered cases using the named membership equivalence. Two duplicate exact-head workflows, 42728164530 and 42728171781, were queued on this same commit. No pass is claimed pending both audit and integrated-paranoid completion and a clean transitive axiom audit.

The current documentation branch itself is at head fc9625629cabed0a5f009023e4626dc77a641dae, with exact-head documentation audit 42727462725 queued. Earlier successful documentation audits checked older heads only.


## Addendum 1.15 — exact-head follow-up for candidate 8e7cd3ca, 10 November 2026

PR #69 remains on exact source head `8e7cd3ca5b3440ee25eb6241f2aa799103b56830`. The duplicate integrated-paranoid jobs in runs 42728164530 and 42728171781 have now both completed with failure; the audit job in 42728171781 was still in progress at this inspection. The completed integrated-paranoid log for run 42728171781 pinpoints the remaining issues:

- `BBMSTPrefixMeasureRecursion.lean:171:55`: `restrictPrefix_extendPrefix` still leaves a nested dependent-coordinate transport goal, after the explicit Fin-index equalities. The residual target is equality after two `Eq.mp` transports, not merely equality of the underlying Fin indices.
- Lines 220–223 in `prefixPointCovered_iff`: the attempted `rcases` treats a residual `Quot.lift` membership expression as an inductive existential. The filter-membership reduction has not exposed the intended predicate; a dedicated lemma reducing membership in `prefixCoveredValues` is needed before destructuring the existential.
- Lines 396 and 398 in `prefixFibre_updatedWeight_eq_PAt`: both covered and uncovered branches leave goals after the current `simp` calls. The proof must explicitly transport the covered-membership predicate and the stage-coordinate equality, then rewrite the recursive `PAt) value; the current case split does not close the dependent update identity.

The same log prints `sorryAx` in `prefixPointCovered_iff`, `prefixExtensionEquiv`, `sum_prefix_eq_sum_extensions`, `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, and downstream PAt inequalities/sums. These declarations are not verified on this candidate. The independent hyperplane-incidence module still compiles with the standard profile, but this does not bypass the failed prefix recursion. No integrated build or paranoid pass is claimed.

The next repair should be split into three independently testable lemmas: (i) an explicit coordinate-transport lemma for the two `Eq.mp` casts in restriction-after-extension; (ii) a standalone `mem_prefixCoveredValues` theorem that reduces the Finset filter to the geometric existential without destructuring a quotient representation; and (iii) a branchwise update identity whose hypotheses are stated directly in the same stage-coordinate and restricted-prefix types as the recursive `PAt) definition. Do not weaken the geometric coverage definition or add axioms/sorries.

At this inspection, PR #69 run 42728171781 still had its audit job in progress. The earlier integrated failure is final for that job and exact head; the audit result remains pending. The separate Collatz run 42728049650 is still running, and PR #79 documentation head `b1fe62a30d1f78de4fb858b1d8a492f4b714925a` has exact-head audit run 42728550895 in progress. These states are not conflated.


## Addendum 1.16 — split result: upstream audit passes, integrated-paranoid fails, 10 November 2026

Run 42728171781 has now completed both jobs on PR #69 head `8e7cd3ca5b3440ee25eb6241f2aa799103b56830` (merge checkout `65febae`, merging that head into base `ca9d245aa1851a54b65850ddb1130d1ca12e850e`). The two jobs give different, separately scoped outcomes:

- **Audit job 129539075040: SUCCESS.** It compiled the audited upstream source, focused tests, zero-safe parameter/fibre core, finite weighted update, uniform-coordinate instantiation, finite-stage moments, geometry, the source-indexed prefix recursion, prefix cylinder identities, prefix moment bridge, hyperplane incidence bridge, old-shadow geometry, finite union/noncoverage bound, and BBMST moment recurrence. The named prefix declarations `extendPrefix_restrictPrefix`, `prefixPointCovered_iff`, `prefixExtensionEquiv`, `sum_prefix_eq_sum_extensions`, `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, `PAt_succ_le_prev_div_card_mul_one_sub_delta), and `PAt_sum_eq_one` all printed the standard transitive profile `[propext, Classical.choice, Quot.sound]`. No `sorryAx) was found in the completed audit log. This is a real, declaration-scoped success for the audited upstream package on this run.
- **Integrated-paranoid job 129539074660: FAILURE.** Its integrated package build reports the unresolved dependent-coordinate transport at line 171, the unreduced quotient/filter membership in `prefixPointCovered_iff` at lines 220–223, and the covered/uncovered update goals at lines 396 and 398. Error-recovery output contains `sorryAx` in the dependent prefix chain. No integrated package build or `lake check --paranoid) pass is claimed.

These are not to be collapsed into a single status. The audit job's clean named declarations must be preserved as a successful result for its audited upstream source; the integrated package's failure remains a separate outstanding integration defect. The discrepancy is currently localized to the different build surfaces and must be reconciled by checking the source/package inputs and generated integrated tree, rather than by discarding either log or claiming the integrated pass. The next technical task is to diff the exact audited upstream source against the integrated package copy of `BBMSTPrefixMeasureRecursion.lean` and its imports at merge checkout `65febae`.

At the same inspection, Collatz PR #9 run 42728049650 remained in progress; PR #79 documentation head `db3b2b7e3d5060a44f9b516aec686218c9b40ead` had exact-head audit 42728958465 queued. Earlier APW4 successful runs and the APW4 mathematical proof record remain unchanged.


## Addendum 1.17 — toolchain reconciliation for the split APW4 result, 10 November 2026

The difference between the two jobs in run 42728171781 is now explained by the workflow definition, not by an assumed stale source copy. The `audit` job explicitly installs Lean 4.28.0 and compiles the root source modules directly. The `integrated-paranoid` job explicitly installs Lean 4.35.0, copies the root `BBMST*.lean` and `APW4*.lean` modules into `kernel-audit/`, then runs `lake build ResearchKernelAudit` and `lake check --paranoid`. Both jobs check out the same merge commit `65febae`, but they use different Lean toolchains and package contexts.

Therefore the precise result is:

- **Lean 4.28.0 audit: PASS.** The full listed source-module chain, including prefix recursion and downstream moment/incidence modules, compiled. Named prefix declarations printed only `[propext, Classical.choice, Quot.sound]`; the complete audit log contains no `sorryAx`.
- **Lean 4.35.0 integrated package: FAIL.** The newer-toolchain build reports the dependent-coordinate transport goal at line 171, the quotient/filter membership issue at lines 220–223, and covered/uncovered update goals at lines 396 and 398. Error-recovery output contains `sorryAx`; the integrated build did not reach a successful `lake build), and `lake check --paranoid) did not pass.

This is a toolchain-compatibility gap, not a contradictory result and not evidence that the Lean 4.28.0 audit failed. Preserve both exact outcomes. The next repair should make the modules robust under Lean 4.35.0 (without weakening definitions), or explicitly pin and justify a single supported toolchain if the project scope permits. The integrated-paranoid job remains the acceptance gate for the Lean 4.35.0 package.


## Addendum 1.15 — dual-toolchain result on PR #69 head 8e7cd3

The duplicate exact-head workflows 42728164530 and 42728171781 checked the same PR merge commit 65febae (head 8e7cd3ca5b3440ee25eb6241f2aa799103b56830), but their two jobs use different Lean toolchains by design:

- The audit job uses the repository-root toolchain Lean 4.28.0 and root Mathlib v4.28.0. In run 42728171781 it completed successfully, compiled BBMSTPrefixMeasureRecursion.lean, printed standard profiles [propext, Classical.choice, Quot.sound] for prefixPointCovered_iff, prefixFibre_updatedWeight_eq_PAt and PAt_nonneg, and had no actual sorryAx occurrence in that audit log.
- The integrated-paranoid job uses kernel-audit/lean-toolchain Lean 4.35.0 and Mathlib v4.35.0. In both runs 42728164530 and 42728171781 it failed on the same merge commit. This is the target integration toolchain and remains the release blocker.

The two results are not contradictory: the source module compiles under the legacy 4.28 audit environment, but the integrated 4.35.0 environment exposes dependent-type failures. The 4.28 audit pass must not be reported as a 4.35.0 integration pass.

The 4.35.0 integrated job reports:
- line 171: unresolved nested dependent-coordinate casts in restrictPrefix_extendPrefix;
- line 220: rcases cannot destruct the remaining Quot.lift membership term in prefixPointCovered_iff;
- line 223: the resulting constructor notation is invalid for that non-inductive target;
- lines 396 and 398: the covered and uncovered branches of prefixFibre_updatedWeight_eq_PAt remain unsolved; the uncovered branch retains an unnecessary Finset.univ conditional.

Error recovery prints sorryAx in prefixPointCovered_iff, prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and downstream PAt inequalities/sums in the 4.35.0 integrated log. These declarations are not verified for the target toolchain on this commit.

**Next repair sequence:** (1) replace the opaque rcases path with an explicit Finset membership normalization (including the exact filter/set representation) before destructuring the existential; (2) prove the prefix-coordinate cast identity with named Fin.ext lemmas rather than relying on broad simp; (3) simplify the uncovered branch explicitly using Finset.mem_univ; (4) rerun both toolchains and require the 4.35.0 integrated-paranoid build and axiom audit to pass on one exact commit. The legacy 4.28 audit remains useful compatibility evidence but cannot substitute for the 4.35.0 result.


## Addendum 1.18 — Collatz state-dependent cap now Lean-audited, 10 November 2026

Syracuse PR #9 run 42728049650 completed successfully on exact head `ca48ec7fdad5e8d6f8aeb82fed8586a1b57c12bc`. The full `compile-drafts` job passed. The three new declarations in `SyracuseOffsetIdentity.lean` all printed the standard transitive profile `[propext, Classical.choice, Quot.sound]):

- `signedOffsetMargin_nonpos_succ_iff_exponent_cap);
- `signedOffsetMargin_nonpos_of_nondecreasing_orbit);
- `nondecreasing_orbit_next_exponent_cap).

The complete log has no actual `sorryAx) occurrence; the token appears only in workflow grep/diagnostic command strings. This formally verifies the exact one-step equivalence between nonpositive next margin and the exponent-cap inequality, and the necessary cap for a nondecreasing endpoint under the exact affine-orbit hypotheses. It remains a local, state-dependent necessary condition: no uniform branching bound, exclusion of an infinite path, or global Collatz proof is claimed.

The APW4 side remains split by toolchain on PR #69 head `8e7cd3ca5b3440ee25eb6241f2aa799103b56830`: Lean 4.28.0 upstream audit passed the named source chain with standard profiles and no `sorryAx); Lean 4.35.0 integrated-paranoid failed in the dependent prefix-recursion elaboration. PR #79 documentation commits have advanced since the last exact-head audit; no current-head docs pass is claimed until a run is attached to the latest commit.


## Addendum 1.19 — scope of the Lean 4.28.0 audit axiom output

A further scope distinction is recorded for run 42728171781. The APW4/BBMST declarations named in Addendum 1.16 have the standard transitive profile and no `sorryAx). The same audit log also prints separate legacy Erdős–Selfridge declarations `degenerate_axiom_acceptance`, `erdos_selfridge`, `sieve_criterion`, and `sf_sieve_lt_one` with the explicitly named sieve axioms. Those are not part of the named APW4 prefix/moment/incidence dependency chain, but their presence means the entire mixed audit log or repository must not be described as globally free of those legacy axioms. The acceptance claim is strictly declaration-scoped to the APW4/BBMST names listed above.


## Addendum 1.16 — Lean-verified Syracuse cap core

The Syracuse programme now has a genuine Lean-verified finite non-descent cap core. Workflow 42728049650 passed on exact source commit ca48ec7fdad5e8d6f8aeb82fed8586a1b57c12bc using Lean 4.34.1. The declarations signedOffsetMargin_nonpos_succ_iff_exponent_cap, signedOffsetMargin_nonpos_of_nondecreasing_orbit, and nondecreasing_orbit_next_exponent_cap each printed [propext, Classical.choice, Quot.sound]; the complete job log contained no actual sorryAx occurrence and the build completed 8,930 jobs.

This proves in Lean the exact margin equivalence and the necessary next-exponent cap for a nondecreasing exact affine endpoint. It does not yet formalize the maximum cap B_alpha, the exact tail-cylinder partition, or the general finite-word cylinder theorem. The Syracuse cap's Lean 4.34.1 verification is separate from the APW4 integrated Lean 4.35.0 audit. The APW4 historical index-preserving transport, diagonal/off-diagonal bounds, and BIB/Hall capacity remain open.


## Addendum 1.20 — multi-project exact status and new finite bridge, 10 November 2026

### Kolaz threshold-return archive — exact finite expansion passed

Kolaz PR #39 has expanded the exact threshold tables from B=31,63,127,255 to include B=511 and B=1023. Complete row-by-row CSV tables are checked against fresh enumeration. The B=511 table has 42 escape sources, maximum excursion length 24, maximum height 13,121; B=1023 has 85, maximum length 50, maximum height 83,501. Two new cross-threshold common suffixes (lengths 10 and 7) are regression-tested. Exact-head run 42732032993 passed on source head `5a01e5e56d203c0ed987f6bb70c1519b107e9f23`, job 129552163491.

A worked finite cross-project certificate is now included: B=1023 source x=731 follows valuation word (1,2), with z0=1097 and endpoint 823; A=3, C=5, cylinder modulus 16 and unique residue 11, and exact affine identity 8·823=9·731+5=6584. The signed margins are D0=0, D1=-2, D2=-6, and both local cap inequalities hold. This is a finite consistency check, not a global result. The distinct old “1097 threshold/count” lead remains unresolved.

### Terminal-residue k=2 formalization candidate

A finite k=2 Lean module `LubuimiTerminalResidueEnergyK2.lean` was added both to the Syracuse/Collatz draft library and as a standalone Lean 4.34.1 project in PR #38. It defines the six unit residues modulo 9, exact integer row numerators, row-sum theorems, the two-step numerator vector (8,16,11,4,2,22), and rational energy 5/21. The first CI attempt 42730248268 failed because `native_decide` introduced generated native axioms and the variable-index theorem was not closed. The source was corrected: all `native_decide` uses were replaced by kernel reduction (`decide`), and the variable-index statement now uses explicit `Fin) cases. The current exact-head run 42731846956 is in progress on PR #9 head `b999241519ecd12a931d931ea4b9e850741c6457`. Until that run prints only the standard profile and no `sorryAx), the k=2 module remains an unverified candidate. The standalone PR #38 workflow is separate; no result is inferred from the root-library run.

### APW4 Lean 4.35 repair candidate

PR #69 current source head is `f843e4224e5288e107200464be5c5524de650570`, with exact-head run 42732094102 queued/in progress at the last inspection. The previous candidate on head `d8035b90a2f24aaf4f4850418d42e9b6bd3214b2`, run 42731006745, retained the Lean 4.28.0 audit PASS but the Lean 4.35.0 integrated job failed. The latest source change uses an explicit filter-membership decomposition for `prefixPointCovered_iff` and a definitional covered-set equivalence plus `split_ifs) for the updated-weight identity, following the most promising independent repair shape from PR #76. The new run must decide whether those exact proofs elaborate in the integrated Lean 4.35.0 package. No success is claimed yet.

### Documentation audit

PR #79 documentation head `e93ac41fb2c377e3b55bc959875dee0f6694c5db` passed its exact-head documentation audit in run 42729583336. This status applies only to that head; this addendum will advance the documentation branch and requires a new exact-head audit. The APW4 mathematical theorem record and earlier successful exact-commit checks remain unchanged.


## Addendum 1.21 — odd-covering third-order finite CRT statistic and current audit heads, 10 November 2026

### Odd-covering L=945: exact third-order CRT statistic

The separate odd-covering research record (PR #80) now includes the exact pairwise-coprime triple contribution for
\(D=\{3,5,7,9,15,21,27,35,45,63,105,135,189,315,945\}\):
\[
\sum_{\substack{d<e<f\in D\\\gcd(d,e)=\gcd(d,f)=\gcd(e,f)=1}}\frac1{def}=\frac{13}{945}.
\]
The only such triples are (3,5,7), (5,7,9), and (5,7,27); no pairwise-coprime quadruple exists because the family uses only primes 3,5,7. The pairwise-coprime pair contribution remains 74/315 and the total divisor density is 65/63. This is the CRT-compatible part of the third-order moment only. Triples with nontrivial gcds are placement-dependent, and no private-mass lower bound or odd-covering contradiction follows.

A standalone Lean 4.34.1 project has been added under `projects/OddCoveringDistortionSieve/lean/`; the same source module is mirrored into the unified Syracuse/Collatz audit package. The module uses kernel reduction (`decide`), not `native_decide`, and prints axioms for all five finite declarations. Unified exact-head run 42732868146 on PR #9 head `a58321e7c053b9784556c7fd702996c3557aeacb` is in progress. Until the run passes with only the standard transitive profile and no `sorryAx`, this remains a formalization candidate.

### Current APW4 and Collatz integration candidates

- APW4 PR #69 current source head: `13dce6216dba9499305b528f5f3c15fbc3dca681`. The previous candidate run 42732094102 failed both audit and integrated-paranoid. The integrated Lean 4.35.0 diagnostics included a no-progress simp after unfolding the covered filter and an unresolved equivalence between the exact covered membership predicates in the updated-weight recursion. The new candidate replaces the brittle simp-only step with simp_all, aligns both membership propositions at the same stage coordinate, and removes the no-goal ring_nf failure. The next exact-head run must decide whether this repairs both Lean 4.28.0 audit and Lean 4.35.0 integrated package; no pass is claimed yet.
- The unified Syracuse/Collatz/terminal-residue/odd-covering root audit is run 42732868146, still in progress at this snapshot. It includes the corrected kernel-only k=2 terminal-residue module and the new L945 finite CRT moment module.
- The prior documentation-head audit 42732365176 passed on PR #79 head `f92132ba85f382a6fdb3ff50f2d8eb2d5e213faf`. This new addendum advances the documentation branch and therefore requires a fresh exact-head audit.

All earlier successful exact-commit results and the established APW4 mathematical theorem record remain preserved. The L945 finite arithmetic does not identify with the historical APW4/BIB pair reserve without an explicit index-preserving map and weight correspondence.


## Addendum 1.22 — current exact-head verification snapshot, 10 November 2026

- Unified Syracuse/Collatz root audit: PR #9 head `63851fe25f8bbc19c198cf1e8ec9d59a35dd4722`, workflow 42733657952 PASS. This compiles and audits the three signed-margin cap declarations, the k=2 terminal-residue matrix/energy declarations, and the L945 finite CRT moment module. The checked declarations print the standard profile [propext, Classical.choice, Quot.sound] and no actual `sorryAx` hit.
- Standalone terminal-residue k=2 project: PR #38 head `26c7b92fd529bf03582995e1bee301b0d07c131c`, workflow 42735188229 in progress after changing both Lean and Mathlib from 4.34.1 to 4.35.0. The prior run 42733693279 compiled and axiom-audited the module but failed only because `lake check --paranoid` is not supported by Lean 4.34.1.
- Kolaz threshold-return: PR #39 head `821579ea5555a6f5e2e38fa771f8797dc4650106`, workflow 42732216205 PASS; all seven exact Python regression tests pass, including both extended CSV tables and the x=731 bridge.
- APW4 integration: PR #69 head `1f4225ce0bdf6186fd0700612e2306ed3ff44506`, workflow 42734929700 in progress. The latest repair explicitly normalizes the residual `Finset.univ` membership in the two updated-weight branches. Both Lean 4.28 audit and Lean 4.35.0 integrated-paranoid results are pending.
- Documentation: PR #79 head `799eba5a2a478b130ea780de3c53ef17d8f87e1f`, workflow 42733244916 PASS. This addendum changes the docs head and requires a new exact-head audit.

All statuses above are scoped to the exact listed commits and jobs. Earlier successes remain valid for their own commits; no current-head claim is inferred from an older run.

## Addendum 1.23 — exact finite Lean passes and current APW4/Syracuse heads, 10 November 2026

- Terminal-residue k=2 standalone project: workflow 42735716873 PASS on source snapshot 4e30c083f3e1657edd08b0945cdda4e16c8b0e14, Lean/Mathlib 4.35.0, seven declarations standard profile, lake check --paranoid pass, no actual sorryAx.
- Odd-covering L945 standalone finite CRT project: workflow 42736060742 PASS on source snapshot f81a08296c88e5ee2877dd88adaf932927ecb7a7, Lean/Mathlib 4.35.0, seven declarations standard profile, lake check --paranoid pass, no actual sorryAx.
- Kolaz threshold-return archive: exact-head workflow 42735880399 PASS on PR #39 head 012c8717e9d80025e7aa6cbb99f0b7ed5affd176; seven Python regression tests pass, including B=511/B=1023 CSV and x=731 bridge.
- Syracuse mixed word (1,2): new theorem realizesValuationWord12_iff_mod_sixteen_eleven added to SyracuseOffsetIdentity.lean; exact-head unified run 42736159935 in progress on 56c6d6d86fb5122d75f89f5e614f7f333e2d31a9. Formal status pending.
- APW4 PR #69: candidate 4edf44ce8232d0b9be9f9b9f9f69671740c0f921, run 42736373195 in progress. The new proof rewrites the covered-membership equivalence before splitting the finite-fibre update. No pass claimed.
- PR #79 previous docs head 388b788d0c5623eab8e2cdf1755e426b8f7f2100 passed workflow 42735453999. This addendum changes the docs head and requires a new audit.

All statuses are scoped to the stated source snapshots. The standalone finite modules do not prove global Collatz or the full odd-covering conjecture, and do not establish APW4/BIB identification.

## Addendum 1.24 — B=8191 finite archive and current exact formal heads, 10 November 2026

- Kolaz PR #39 head 710fb173c3006bbf622f6b7b3a67ac69907fc783, workflow 42737593864 PASS; nine Python tests cover nine thresholds through B=8191 and all five extended CSV tables. The B=4095/B=8191 suffix length 29 is verified.
- Syracuse mixed word (1,2) theorem realizesValuationWord12_iff_mod_sixteen_eleven passed in root workflow 42736159935 on code commit 56c6d6d86fb5122d75f89f5e614f7f333e2d31a9, standard profile and no actual sorryAx.
- APW4 PR #69 head 8a6f2f353d5877ccf7f10a1e91d2bf214c5f7768, workflow 42737432337 in progress. Latest candidate uses propext of the covered-membership equivalence and rewrites before splitting.
- Terminal-residue k=2 standalone Lean 4.35.0 pass 42735716873 retained; L945 standalone Lean 4.35.0 pass 42736499021 retained.
- PR #79 docs head 7be2b35eaa38a1591808b94e0bd35911565ea2d2, workflow 42737658978 in progress; this addendum advances the docs head.

All claims are commit- and scope-bound. General finite-word cylinders, tail partition, APW4 integration and global Collatz remain open as stated.


## Addendum 1.25 — finite-depth uniform fibre and newest PR #69 candidate, 10 November 2026

- A new mathematical note, LUBUIMI_SYRACUSE_FINITE_DEPTH_UNIFORM_FIBRE_BRIDGE_2026-11-10.md, constructs an explicit finite-depth APW4-style uniform fibre from the Syracuse cap and exact child/tail cylinders. At each fixed depth the cap-compatible prefix level is finite; a common B*_k gives a fibre of size 2^(B*_k), with child blocks of size 2^(B*_k-b), tail block of size 2^(B*_k-B_α), and distinguished subset proportion 1-2^-B_α. This is not yet Lean-formalized and is not identified with the historical APW4 hyperplane/BIB event set.
- APW4 PR #69 candidate 8a6f2f353d5877ccf7f10a1e91d2bf214c5f7768 failed both Lean 4.28 audit and Lean 4.35 integrated-paranoid. The attempted propext rewrite did not normalize all proof-indexed covered-membership and stage-coordinate terms; residual goals still compared coveredMultiplier and uncoveredMultiplier branches. Error-recovery sorryAx in PAt_nonneg and PAt_sum_eq_one is downstream of the failed update identity and is not a mathematical counterexample.
- A new source candidate f02f8d28f0d06735bab9ec1a591839704c6bb9ac changes the rewrite orientation. Exact-head dual-toolchain workflow 42738073791 is queued. No result is claimed until both jobs complete and all affected declarations have standard profiles and no actual sorryAx.
- Earlier Lean 4.28 audit passes on their exact commits remain preserved. The integrated Lean 4.35 release blocker remains open pending this run.


## Chronological cross-project update — 10 November 2026

The companion Syracuse repository has added a complete German parallel manuscript for Lubuimi's Initial Valuation-One Cylinder Theorem. The theorem and its formal scope are unchanged; the seven successful exact-commit Lean audit snapshots listed in the manuscript remain the verification record. The German translation itself is a documentation-only addition and does not require or imply a new Lean proof run.

New completed finite-project checks:
- Terminal-residue k=2 Lean module: run 42737167314, exact PR #38 head 50492a880f5b8a2c4bb96838e16dfed2339dd501, completed success. The audited k=2 declarations have the standard transitive profile [propext, Classical.choice, Quot.sound], with no actual sorryAx finding. This covers the finite k=2 matrix, two-step mass vector and energy identity only.
- Kolaz finite threshold-return archive: run 42737593864, exact PR #39 head 710fb173c3006bbf622f6b7b3a67ac69907fc783, completed success. This checks the extended B=511/B=1023 finite tables and regression workflow, not a uniform return theorem or global Collatz.

Latest active verification snapshot:
- Collatz offset PR #9 head 19ad4e58847508ff078c424e4ee809b9ade92f85, run 42738027956, compile-drafts in progress.
- APW4 integration PR #69 head f02f8d28f0d06735bab9ec1a591839704c6bb9ac, run 42738073791, audit and integrated-paranoid in progress. No Lean 4.35 integration success is claimed yet.
- APW4 documentation PR #79 run 42737972794 completed successfully on the prior head 96cd9f3712b15ebcc6b1c6fe1ff28760670b55c2. The current documentation head has since advanced to b7e1099e8afe585e51c6fc2547dee2cc04f3e539; the prior success does not audit this newer head.

The APW4 historical event-index map, weight-preserving transport, separate diagonal/off-diagonal estimates, and BIB/Hall capacity proof remain distinct obligations. No finite Syracuse/Collatz result is being used as a substitute for them.


## Addendum 1.26 — first Lean counting lemma for the Syracuse uniform fibre

Syracuse PR #9 source head a1becbc8e837f10abcd952a2e03832cb057fb2b8 adds dyadicUniformFibre_partition_card, the exact finite count of child blocks plus tail block at common refinement depth B*. Exact compile/axiom workflow 42738528207 is in progress. No formal verification claim is made until the full job finishes with the standard profile and no actual sorryAx. This lemma is only the finite cardinality conservation law; it does not formalize the cap maximum, finite tree, residue-atom bijection, or historical APW4/BIB transport.


## Addendum 1.27 — Lean 4.35 result on APW4 candidate f02f8d28

The integrated-paranoid job in exact-head workflow 42738073791 failed on PR #69 source commit f02f8d28f0d06735bab9ec1a591839704c6bb9ac. The failure remains localized to BBMSTPrefixMeasureRecursion.lean:
- line 355:45: unsolved equality in prefixFibre_updatedWeight_eq_PAt;
- line 378:34: an extra tactic ran after no goals remained;
- error recovery consequently reports sorryAx in prefixFibre_updatedWeight_eq_PAt, PAt_nonneg and PAt_sum_eq_one.

The residual target shows that the updatedWeight branch uses membership in prefixCoveredValues C hk (restrictPrefix C hk y), while the recursive PAt branch still contains a proof-indexed variant prefixCoveredValues C ⋯ (restrictPrefix C ⋯ y). The stage-coordinate/Fintype-card and δ arguments also retain proof-indexed variants. The propext rewrite did not normalize all of these expressions. prefixPointCovered_iff itself continues to print the standard profile in the integrated log.

The Lean 4.28 audit job for run 42738073791 is still in progress at this snapshot. Therefore no dual-toolchain conclusion is claimed yet. The integrated Lean 4.35 job is a confirmed failure for this exact candidate.

**Next exact repair:** isolate named equality lemmas for stageCoordinate across proof witnesses, restriction-prefix values across proof witnesses, and the resulting prefixCoveredValues finset/membership transport. Rewrite both the generic finite-fibre update and recursive PAt formula to one canonical set of stage/prefix terms before case splitting. Alternatively refactor PAt through a shared raw point-update expression that avoids rebuilding proof-indexed terms. Do not weaken hypotheses or accept error-recovery sorryAx.


## Addendum 1.28 — dyadic uniform-fibre cardinality Lean pass

Syracuse PR #9 exact source commit a1becbc8e837f10abcd952a2e03832cb057fb2b8 passed compile-drafts workflow 42738528207. The declaration dyadicUniformFibre_partition_card proves the exact child-block plus tail-block cardinality identity for B≤B*. Its transitive axiom profile is [propext, Classical.choice, Quot.sound], the completed log contains no actual sorryAx, and the build reports successful completion of 8,932 jobs. This verifies the finite counting identity only. The full cap/tree/interval/residue-bijection construction remains to be formalized.


## Addendum 1.29 — full prefix-fibre normalization candidate 2843f40

PR #69 has advanced to source head 2843f40fd5c04fc68014ee8fe59a87d26520b285. The latest repair no longer relies on a single membership Iff. It introduces named proof witnesses hk' and hprev', proves equality of those proof witnesses by Subsingleton.elim, transports the restricted previous prefix, stage coordinate, full prefixCoveredValues finset, and previous PAt base mass, then performs the covered/uncovered case split on the normalized expressions.

Exact-head workflow 42738923964 is in progress with both Lean 4.28 audit and Lean 4.35 integrated-paranoid jobs. This is the first candidate that explicitly normalizes the entire dependent fibre expression, including the cardinality and base-mass terms. No result is claimed until both jobs complete and the named declarations print the standard profile without actual sorryAx.


## Addendum 1.30 — exact standalone k=2 head reconfirmed

The terminal-residue collision-energy PR #38 current head 50492a880f5b8a2c4bb96838e16dfed2339dd501 has its own exact-head workflow 42737167314 completed successfully. This is the current documentation/source snapshot for that standalone finite k=2 project. The seven named finite declarations have the standard transitive profile, no actual sorryAx, and the Lean 4.35.0 paranoid check passed. Scope remains the finite k=2 matrix, two-step mass and energy only; no general k theorem or APW4/BIB transport is inferred.


## Addendum 1.31 — exact result for candidate 2843f40 and next case-split attempt

The two exact-head workflows for source commit `2843f40fd5c04fc68014ee8fe59a87d26520b285`, [42738930763](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42738930763) and [42738923964](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42738923964), have now completed with failure. Both fail while compiling `BBMSTPrefixMeasureRecursion.lean`.

The decisive diagnostic is:
- an extra tactic is executed after the preceding tactic has already closed its goal;
- rewriting the covered-membership equivalence through `rw` attempts to abstract a dependent Finset membership whose type changes with `stageCoordinate`, producing an ill-typed motive;
- error recovery reports `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and dependent recursion/mass declarations. These declarations are not accepted as verified.

The next isolated case-split candidate is commit `086ad916f48270d984ebd3e4bcf86fc58cf60f2b` on branch `fix/prefix-fibre-update-case-split-2026-11-10`, with exact-head workflow [42739175075](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739175075). It splits on the concrete source-indexed covered predicate and simplifies the recursive branch without the failed proposition rewrite. At this snapshot its Lean audit and integrated-paranoid jobs are still running. No pass is claimed.

The local Syracuse dyadic cardinality lemma remains a separate successful result: [42738528207](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42738528207), source commit `a1becbc8e837f10abcd952a2e03832cb057fb2b8`. It does not discharge the APW4 dependent prefix-fibre normalization obligation.


## Addendum 1.32 — normalized dependent-witness case split queued

The next integrated candidate is exact source commit `17eb308d106c770ab559d254bcee2bdfd2ead6c4`. It eliminates the two proof-witness equalities before case splitting on the concrete covered predicate; this avoids the ill-typed `rw` motive seen on commit `2843f40` and the still-unsolved `simp [h, hcovered]` branch on commit `086ad916`.

Exact-head workflows [42739447621](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739447621) and [42739454140](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739454140) are running the Lean audit and integrated Lean 4.35.0 paranoid build. At the latest check both were still in dependency/cache setup. No result is claimed until the compile, axiom audit, and paranoid check finish on this exact commit.


## Addendum 1.33 — 10 November exact-head recheck

At this recheck, PR #69 remained open at source head `17eb308d106c770ab559d254bcee2bdfd2ead6c4`. Workflows [42739447621](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739447621) and [42739454140](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739454140) were still in progress. The integrated-paranoid job had passed Lean 4.35.0 setup, sandbox installation, and Mathlib cache restoration and was compiling the integrated BBMST/APW4 modules including the full Theorem 1.2 reduction. This is `IN PROGRESS`, not PASS.

PR #79 documentation head `be6dfbcdc55b2603cc6901caaa32f8e4ed24a505` had exact-head workflows [42739759284](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739759284) and [42739763639](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739763639) still in progress. No success/failure inference is made from the lack of completed logs. The next audit must inspect completed exact-head logs for `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, and `PAt_sum_eq_one`, their transitive `#print axioms` profiles, and the complete `sorryAx` scan; then verify the integrated `lake check --paranoid` declaration count.


## Addendum 1.32 — conditional incidence module audit actually started

A scope correction is required for PR #67. The earlier general audit run 42603327843 did not compile APW4IncidenceSecondMoment.lean; its log printed only pre-existing canonical and degenerate-witness declarations. The APW4-specific workflows on that exact head were cancelled. Therefore the new incidence module was not formally verified by that earlier success.

A comment-only update on source commit e8b61d2961dadbae2915dd6754807fc1b13daf6d has now triggered the dedicated workflows:
- Lean 4.28 canonical audit 42739947391;
- Lean 4.35.0 integrated paranoid audit 42739947626.

Both are in progress. The declarations incidence_bound_from_second_moment, offDiagonal_exceeds_reserve and apw4_energy_contradiction require explicit output in these logs, standard transitive axiom profiles and no actual sorryAx before a formal-verification claim is made. Even if successful, they prove only the conditional algebraic checkpoint, not the historical APW4 incidence hypotheses or BIB/Hall map.


## Exact-head recheck: 10 November 2026, 02:03 UTC

- PR #69 source head `17eb308d106c770ab559d254bcee2bdfd2ead6c4` was rechecked by integrated-paranoid run `42739454140`. The audit job reached the two explicit covered/uncovered branches in `prefixFibre_updatedWeight_eq_PAt`, where `ring` failed to normalize the rational goals at lines 390 and 392. Error recovery consequently reports `sorryAx` in this theorem and dependent `PAt_nonneg` / downstream mass declarations. The integrated-paranoid job failed. The audit job was still compiling the prefix recursion at the latest check. This is a real localization, not a pass.
- A narrow candidate commit `5f8077e7e621bc4e6684bda4e561bfafc6dd2a66` changes only the two branch-closing tactics from `ring` to `ring_nf`, exactly following Lean's diagnostic. Exact-head workflow `42740031054` was queued at the time of this note. **No success is claimed for this candidate until both the audit and integrated-paranoid jobs finish, the target declarations have the standard profile, and the full log has no actual `sorryAx`.**
- The additive [historical completeness audit](APW4_HISTORICAL_COMPLETENESS_AUDIT_2026-11-10.md) states the remaining source-to-Lean obligations explicitly. The APW4 manuscript's mathematical proof status and historical hypotheses are preserved; the missing integrated historical index-map / weighted BIB-Hall construction is not represented as already formalized.
- The new APW4 README and completeness-audit documentation commits trigger separate documentation/audit workflows `42739964459` and `42739971629`; these do not substitute for PR #69's integrated kernel build.

This entry is append-only and commit-scoped. It does not overwrite earlier runs or downgrade prior declaration-scoped successes.


## Addendum 1.34 — source head 17eb308 failed; index-normalization patch queued

Exact-head runs [42739454140](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739454140) (audit and integrated-paranoid) and [42739447621](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739447621) completed with failure on `17eb308d106c770ab559d254bcee2bdfd2ead6c4`. Lean 4.35 reported unsolved goals in the positive and negative cases because the source branch condition was stated with `Fin.last k`, but the recursive target retained `Fin.last (a + j)`; the simplifier invocation did not unfold the local `k). The legacy audit run reported redundant tactics after its simplification. The axiom log confirms `sorryAx` contamination of `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, and `PAt_sum_eq_one` through error recovery. Reject this candidate as verified.

Follow-up commit `1725efe46fb2b953ae162eb46ef6ccab454d6e33` adds `k` to both branch simplifier sets and removes trailing `ring_nf`. Exact-head run [42740073283](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740073283) was pending at documentation time. Its result must be read from completed logs before any claim of repair.


## Addendum 1.33 — historical definition completeness boundary

PR #68's source-reconstruction and chronology record is reaffirmed: the original source and supplementary files have been catalogued, but the current Lean/GitHub chain does not yet provide a complete index-preserving identification of historical A_q, A_r, W_{q,r}, a_{q,t} with APW4 prefix/fibre atoms and original weights. Canonical finite-fibre and unweighted CRT results are not the historical weighted Hall transport. The available 17-page PDF copy is missing the strict comparison on page 11 and the complete intermediate arithmetic derivation. This does not downgrade the separately published APW4 mathematical theorem record, but it prevents claiming that every historical definition/bridge step is already reconstructed and formally integrated.


## Addendum 1.34 — PR #67 import-order correction and new exact audit

The first dedicated PR #67 workflows on commit e8b61d2961dadbae2915dd6754807fc1b13daf6d failed because a verification comment had been inserted before import Mathlib. Lean correctly rejected the import position. The comment has now been moved below the import on corrected source commit e71b7a5eaa433b689aaa2963d89bdd4ae55c37f4. New exact-head workflows are queued: canonical Lean 4.28 run 42740305961 and Lean 4.35.0 paranoid run 42740306351. The three conditional incidence declarations remain unverified until these runs complete with standard profiles and no actual sorryAx.


## Addendum 1.35 — APW4 incidence import correction and scalar-transport candidate

- Corrected incidence source head: `e71b7a5eaa433b689aaa2963d89bdd4ae55c37f4`; runs [42740305961](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740305961) and [42740306351](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740306351) were in progress. The prior `e8b61d2` head failed because the import was not first in the Lean file; no theorem-level conclusion was drawn from that failure.
- Integrated PR #69 current source head: `2c2ec3472ae2de9bfc7dc90198f48c52f21f04dd`; exact-head runs [42740134936](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740134936) and [42740144142](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740144142) were in progress.
- Draft PR #83 proposes replacing the dependent rewrite `rw [← hlocal]` with direct equality transport of the scalar inequality. Exact candidate `2656fe9fadac25b5c79a1f217ad40fb8472738d0`; workflows [42740315350](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740315350) and [42740323488](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740323488) were queued/running.

All three declarations in the finite-incidence module remain conditional on explicit arithmetic/energy hypotheses. Neither PR #67 nor PR #83 establishes the historical weighted Hall map or closes the APW4 source-to-Lean integration. No pass is claimed for these in-progress exact-head workflows. PR #82 is closed as superseded, not merged.


## Addendum 1.35 — final initial-cylinder manuscript source commit

Syracuse PR #35 manuscript v1.0 is now at exact documentation commit ddf366d7654a275958157daab9d3d489ad3e6fd0. A raw-LaTeX read-back and control-character scan confirms correct TeX commands and no non-whitespace control characters. No Lean source changed; the previously recorded seven successful theorem audits remain scoped to the named initial-cylinder declaration.


## Addendum 1.36 — PR #67 conditional incidence module Lean 4.28 PASS

Corrected exact source commit e71b7a5eaa433b689aaa2963d89bdd4ae55c37f4 passed canonical workflow 42740305961. The log explicitly compiles and prints incidence_bound_from_second_moment, offDiagonal_exceeds_reserve and apw4_energy_contradiction, each with [propext, Classical.choice, Quot.sound]; no actual sorryAx appears in the completed log. The separate Lean 4.35.0 paranoid workflow 42740306351 remains in progress. Thus the conditional finite-incidence module has a successful Lean 4.28 canonical compile/axiom audit, but its dual-toolchain paranoid verification is still pending. It does not prove historical incidence hypotheses or BIB/Hall transport.


## Addendum 1.37 — exact-support identity and current integrated repair candidates

- APW4 PR #67 now contains the exact CRT support-layer relation `intersectionCount_eq_sum_exactSupportCount` at head `6b69e2c91010db9e7faf5d7f3a91b3a50b88b2a1`. It states that each intersection count is the sum of exact-support layer counts over supports containing the intersection index set. The first candidate head `cbb8509` failed due to simp recursion and emitted `sorryAx` after error recovery; it is not accepted. The revised finite-indicator-sum definition is under exact-head runs [42742383010](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742383010), [42742374379](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742374379), [42742382720](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742382720), and [42742374338](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742374338). Focused audit [42742382711](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742382711) passed. The new theorem remains unverified until the canonical and paranoid runs finish; no inverse Möbius formula or weighted BIB transport is claimed.
- APW4 PR #83 was closed as superseded, not merged. Current dependent-prefix repair is PR #84, head `c776e9996e35458ab8edb43199bf51e0f531dee1`, based on the current PR #69 integration branch head `b8d98215ed2d8d401c1e27805a193666e093f067`. Exact-head runs [42742741001](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742741001) and [42742734125](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742734125) are in progress. Earlier PR #84 heads failed: the first on redundant `ring_nf` after the simplifier had closed the goal; the next still left a branch goal in `prefixFibre_updatedWeight_eq_PAt`. The current `simp_all` revision has not yet been verified. PR #84 is draft and unmerged.
- The APW4 historical definition audit was expanded after re-reading the author's 17-page project PDF and reconstruction notes. The q-profile identities are recorded, but the element-level definitions of `W_{q,r}`, `a_{q,t}`, `M_{q,r}`, `Gamma_{q,r}`, `Phi`, and the event-to-BIB-place relation remain incomplete. No candidate `B_q` formula was promoted to historical status.
- No merge or license change was made. The manuscript's mathematical proof record remains preserved separately from the unfinished repository source-to-Lean reconstruction.



## Addendum 1.38 — latest PR #69 failure and PR #84 repair candidate

- Integrated PR #69 exact head `b8d98215ed2d8d401c1e27805a193666e093f067` failed exact-head workflow [42740835775](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42740835775). The actionable Lean error is `dsimp made no progress` at `BBMSTPrefixMeasureRecursion.lean:386`; the run's error recovery also prints `sorryAx` for the affected fibre identity and `PAt_nonneg`. No result from that failed run is accepted.
- Draft PR #84 head `f681650c102d011e0bc715c93b5d4a94ffb866ca` removes that no-op simplification and replaces the dependent rewrite with scalar equality transport after proving the concrete pointwise update nonnegative. Exact-head workflow [42743406155](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42743406155) remains in progress at this snapshot. No pass or merge is claimed.
- PR #83 is closed as superseded, not merged. The old branch and commit are retained for audit history.
- PR #67's revised exact-support identity is on head `6b69e2c91010db9e7faf5d7f3a91b3a50b88b2a1`. Focused degenerate-witness workflow [42742382711](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742382711) succeeded; canonical and paranoid workflows [42742382720](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742382720) and [42742383010](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742383010) were still in progress. The earlier candidate `cbb8509` failed and is not accepted. Even a successful exact-support identity proves only the finite relation `c_T = sum_{S superset T} z_S`; it does not prove inverse Möbius reconstruction or historical weighted BIB allocation.



## Addendum 1.39 — exact-support canonical PASS and current paranoid queue

At the current exact-head check, PR #67 head `6b69e2c91010db9e7faf5d7f3a91b3a50b88b2a1` has canonical workflow [42742383010](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742383010) completed successfully. Its log prints `APW4HistoricalCRT.intersectionCount_eq_sum_exactSupportCount` with exactly `[propext, Classical.choice, Quot.sound]`; the full declaration-log scan contains no `sorryAx`. The separate Lean 4.35 paranoid workflow [42742382720](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42742382720) remains in progress. This verifies the forward exact-support counting identity only, not inverse Möbius inversion or weighted BIB/Hall transport.

PR #84 exact-head workflow [42743406155](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42743406155) is currently pending in the Actions queue. Earlier status showed its integrated-paranoid job still in progress and audit job cancelled; GitHub would not rerun the cancelled job while the workflow remained active. No pass is claimed. The source head remains `f681650c102d011e0bc715c93b5d4a94ffb866ca` and the PR remains draft/unmerged.


## Addendum 1.38 — recovered historical q-fibre interface

A later source artifact was located: Dossier v1.6 §48, together with the 6 November BIB incidence note §5. It explicitly records
`B_q=N/q^{a_q}`, the lifted uncovered set `V_q`, the fibre pieces `P_{q,x,h}=F_q(x)∩C_h), and the exact counts
`M_{q,r}((x,h),(y,g))=|P_{q,x,h}∩P_{r,y,g}|`,
`Gamma_{q,r}(g)=|C_g∩V_q∩V_r|`.
The recovered 31 October record also gives the raw compatibility indicator `I_q), selected minimal cover `A_q), redundancy `Z_q), and cross-profile indicator `W_{q,r}).

This supersedes the earlier statement that `B_q` and `I_q` were not corroborated. They are now treated as recovered q-fibre working definitions. Remaining source-to-Lean work: recover the full domains/projection definitions of `U_q,F_q(x),C_h`; prove the fibre-containment and block-disjointness properties from those definitions; then formalize the local `sum_h M ≤ Gamma` inequality. That local count is not yet the full weighted Hall condition or APW4 HT.


## Historical APW4 event-to-BIB reconstruction ledger — 10 November 2026

A new source-reconstruction ledger was added at publication/APW4_HISTORICAL_EVENT_BIB_RECONSTRUCTION_LEDGER_2026-11-10.md. It preserves the fixed algebraic identities
\[
A_qW_{q,r}A_r^{\mathsf T}=\sum_{t\bmod D_{q,r}}a_{q,t}a_{r,t}^{\mathsf T},
\qquad
\sum_h M_{q,r}(h,g)\leq\Gamma_{q,r}(g),
\]
while explicitly requiring the complete index context, matrix entries, residue modulus, and fixed/suppressed indices to be recovered before formal instantiation. The ledger separates recovered q-fibre working definitions from still incomplete source domains and maps. It records the remaining exact obligations for elementary events, the original diagonal map (x,u) ↦ (k,I_{x,u},J_{x,u}), BIB-slot universe/capacities, pointwise event-slot incidence, original-weight preservation, and weighted Hall demand/capacity. No canonical finite-fibre substitute is identified with the historical objects.

The ledger also preserves the residual decomposition I_q W I_r^T into selected-cover and three residual terms, explicitly noting that the residual terms require separate quantitative control; nonnegativity or minimality alone does not supply the required upper bounds.

## Exact APW4 integration diagnostic — workflow 42739454140

The latest PR #69 exact-head workflow 42739454140 completed with both audit and integrated-paranoid jobs failing on source head 17eb308d106c770ab559d254bcee2bdfd2ead6c4. In BBMSTPrefixMeasureRecursion.lean, the two covered/uncovered branches of prefixFibre_updatedWeight_eq_PAt use simp followed by ring. Under the Lean 4.28 audit, simp already closes both goals and ring causes “No goals to be solved”. Under the Lean 4.35 integrated job, algebraic residual goals remain and ring does not normalize them; the log recommends ring_nf. Error recovery consequently reports sorryAx in PAt_nonneg and PAt_sum_eq_one. These declarations are not verified on this head. The next minimal proof-script experiment is to use goal-sensitive sequencing (simp ... <;> ring_nf) in both branches, then rerun both toolchains and inspect the complete declaration-level axiom output. This is a candidate repair strategy, not yet a source change or a pass.

PR #84's workflow 42743406155 also remains unsuccessful as a complete verification: integrated-paranoid failed and the audit job was cancelled. No exact-head dual-toolchain pass is claimed for that repair branch.

These failures do not alter the earlier successful APW4 module audits or the established mathematical theorem record. The historical event-to-BIB transport remains an independent open source-reconstruction/proof obligation.


## Cross-project finite-fibre and terminal-energy synchronization — 10 November 2026

The Syracuse side now has two separate exact finite checkpoints relevant as candidate APW4 index-set technology: (i) the mixed valuation word (1,2) residue cylinder, formally checked on exact source commit 56c6d6d86fb5122d75f89f5e614f7f333e2d31a9 in run 42736159935; and (ii) the dyadic common-fibre cardinality conservation identity, formally checked on exact source commit a1becbc8e837f10abcd952a2e03832cb057fb2b8 in run 42738528207. The latter proves only the finite child-block plus tail-block count, not the dependent prefix fibre, its historical event interpretation, or the APW4 BIB map.

The terminal-residue collision-energy project has its standalone k=2 finite Markov/energy module verified on Lean 4.35.0 in run 42735716873: all seven named declarations have [propext, Classical.choice, Quot.sound], the log has no actual sorryAx, and lake check --paranoid passed. This is a Syracuse-side finite-state result only. Its collision reserve is not identified with the historical APW4 BIB reserve.

The Kolaz archive's exact finite threshold tables through B=8191 and the stated confluence checks passed reproducibility workflow 42737593864. These finite computations are independent of Lean kernel verification and do not provide a uniform bound or universal Collatz descent theorem.

Integration rule: these results may supply finite candidate coordinate sets and exact counting lemmas to APW4 or Collatz only after an explicit map preserving the original indices, weights, and incidence relations is proved. The new APW4 event-to-BIB reconstruction ledger is the checklist for that transport. No theorem is transferred solely because the same dyadic cardinality or second-moment expression appears in both projects.

## Documentation update chronology

The event-to-BIB reconstruction ledger was added in commit 9a3aec51cd7d4696d6220a548c8f711c45ca9d20. The bridge programme and APW4 CI snapshot were then appended with its exact identities, missing definitions, and current run 42739454140 diagnostic. The subsequent cross-project synchronization is appended here; all earlier CI snapshots remain preserved with their exact commit scopes.


## Addendum 1.39 — q-fibre M/Gamma Lean helper under exact-head CI

Draft PR #85, head `33aa4f395fd6b8e66bd683da08fe4c98df1e2fc8`, adds the source-derived finite-set definitions Pq, Pr, M_qr and Gamma_qr from Dossier v1.6 §48. The theorem `APW4HistoricalQFibre.sum_M_qr_le_Gamma_qr` proves the local sum_h M ≤ Gamma inequality from the explicit hypotheses Fq ⊆ Vq, Fr ⊆ Vr, and pairwise disjoint C_h. This is a conditional local count, not the weighted Hall condition or full HT.

Exact-head CI: [42744626707](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744626707) (canonical/paranoid) and [42744626561](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744626561) (audit) are in progress. No pass or axiom-profile claim yet. The source-derived instantiation of the hypotheses and the connection to the actual HT event/BIB slot system remain open.


## Addendum 1.40 — current dependent-prefix and Syracuse exact-head runs

- APW4 PR #84 is now at head `729ef87f7491543efeac2643640e9e95edc45225`. The repair aligns the dependent `hk/hprev` proof witnesses before unfolding the recursive `PAt) and covered-value finsets. Exact-head runs [42744534006](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744534006) and [42744527754](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744527754) are in progress. The previous head `b6bc9e` failed because an `intro` was applied to an equality goal. The current repair remains unverified.
- Collatz PR #9 root head `7a1c174e1c5e70e1b601760db57692009dc1f552` adds the canonical offset nondivisibility/unit lemmas and canonical terminal-residue unit theorem. Exact-head run [42744418555](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42744418555) is in progress. The previous exact-head root run [42743672688](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42743672688) passed the explicit inverse formula with profiles `[propext, Classical.choice, Quot.sound]` and `[propext, Quot.sound]), and its no-`sorryAx` guard passed.
- PR #85's q-fibre M/Gamma helper remains in exact-head CI: [42744626707](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744626707) and [42744626561](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744626561). No final pass is claimed.


## Addendum 1.41 — latest exact-head repairs

- APW4 PR #85 q-fibre helper is now at head `d4c61399918c03715197cbe2de6356fd170463d3`. The first canonical/paranoid attempt failed because the element argument was supplied explicitly to `Finset.disjoint_left.mp); the redundant element argument was removed. Current exact-head runs [42744980622](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744980622) (canonical/paranoid) and [42744980640](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744980640) (audit) are in progress.
- APW4 PR #84 is now at head `3f7c4a02c6420d6405e8a805d738b56769fec6bd`. The helper now explicitly rewrites the recursive PAt value and covered-value finset across the proof-witness equalities before the covered/uncovered split. Exact-head run [42745244942](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42745244942) is pending. Previous run [42744534006](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744534006) failed with residual dependent proof-index mismatches; the current change is not yet verified.
- Collatz PR #9 is now at head `daa2fd1cf945b15abc7e8fc11b2f67104f8c0fa8`. The canonical-offset unit proof's first attempt failed because the inverse-unit closure had an ambiguous typeclass instance. The new proof names the casted unit and its inverse explicitly. Exact-head run [42745303364](https://github.com/s4ztz4bnf6-maker/Lubuimi/actions/runs/42745303364) is in progress. No canonical terminal-unit claim is made yet.


## Addendum 1.42 — PR #85 canonical q-fibre proof passes

At exact head `d4c61399918c03715197cbe2de6356fd170463d3), canonical run [42744980622](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744980622) passed. The named declaration `APW4HistoricalQFibre.sum_M_qr_le_Gamma_qr` has profile `[propext, Classical.choice, Quot.sound]`; the full canonical log has no `sorryAx). Separate audit run [42744980640](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42744980640) passed. The Lean 4.35 paranoid job remains in progress. This verifies the local conditional M/Gamma inequality, not the source-derived hypotheses or full weighted HT/BIB transport.


## Addendum 1.43 — parallel stage-coordinate repair candidate

A second, more direct repair candidate is open as PR #86, head `4e4b378887cc76382d9cd2e17807f96a2c277e23`. It explicitly proves the dependent coordinate equality
`stageCoordinate hk = prefixIndex hj (Fin.last (a+j))`
using `Fin.ext`, then eliminates that equality before the covered/uncovered split. Exact-head runs [42745081023](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42745081023) and [42745062463](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42745062463) are in progress. PR #84 remains a parallel alternative using explicit recursive PAt/covered-finset rewrites; its latest run [42745244942](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42745244942) is pending. Do not merge either until one exact-head repair passes the full integrated and paranoid checks.


## Addendum 1.44 — combined APW4 dependent-index repair

PR #86's coordinate-only candidate (head `4e4b378887cc76382d9cd2e17807f96a2c277e23`) proved the Fin-index equality but both integrated-paranoid runs [42745081023](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42745081023) and [42745062463](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42745062463) failed at the remaining covered/uncovered goals. PR #84 now has a combined candidate at head `1980351a3002bef610107b810c8e726cc685b7b4): it explicitly rewrites the recursive PAt value and covered-value finset across proof witnesses and also eliminates the stage-coordinate equality by Fin.ext. Exact-head run [42745642769](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42745642769) is pending. Neither candidate is merged or verified.


## Addendum 1.45 — exact historical BIB obstruction retained

The 6 November BIB note §§5–6 explicitly gives the raw compatibility indicator (I_q(x,h)=1iff b_hequiv xpmod{gcd(m_h,B_q)}), the selected cover (A_qle I_q), redundancy (Z_q=I_q-A_q), the cross-profile indicator (W_{q,r}), and the exact four-term expansion (I_qW_{q,r}I_r^{mathsf T}=AA+AZ+ZA+ZZ). It explicitly states that the three Z-containing terms have no quantitative bound yet, minimality alone does not yield the required weighted estimate, and the depth-one extraction map to divisor labels is unspecified. The claims (|U|geDelta(B)), depth-one label counts and proper-lcm consequences remain unverified and are not used.

The generator/index domains of F_q,F_r,C_h remain unavailable in the recovered source record. The earlier projection-fibre completion F_q(x)=pi_q^{-1}({x}) was explicitly marked canonical but non-historical and is prohibited as a substitute. PR #85's M/Gamma theorem is only a conditional local count; it does not close the mixed-Z or weighted HT/BIB transport problem.


## Late 10 November 2026 — q-fibre quotient specialization and exact CI chronology

### Historical source boundary

The complete 17-page APW4 source PDF was checked page by page. It records the DT assignment, the aggregate M/Gamma inequality, the HT demand, BIB places/capacities, incidence notation, and the weighted Hall condition. It does **not** supply elementwise definitions of the historical elementary-event universe, the BIB-place set, or the incidence relation. Therefore the historical event-to-BIB map remains open; no canonical substitute is accepted as historical.

The two fixed statements remain:
\[
A_qW_{q,r}A_r^{\mathsf T}
=\sum_{t\bmod D_{q,r}}a_{q,t}a_{r,t}^{\mathsf T},
\qquad
\sum_hM_{q,r}(h,g)\leq\Gamma_{q,r}(g).
\]
The first matrix identity still needs the full source-defined index and entry reconstruction. The second has the following declaration-scoped formal status.

### PR #85 — local finite-set M/Gamma inequality

- Exact head: d4c61399918c03715197cbe2de6356fd170463d3.
- Canonical workflow: 42744980622; canonical job succeeded.
- Degenerate-witness/upstream audit: 42744980640; audit job succeeded.
- The declaration APW4HistoricalQFibre.sum_M_qr_le_Gamma_qr has profile [propext, Classical.choice, Quot.sound].
- The full canonical job log contains zero sorryAx occurrences for this run.
- The separate Lean 4.35 paranoid job was still running at the last status check; no paranoid PASS is claimed.

Its exact hypotheses are Fq ⊆ Vq, Fr ⊆ Vr, and pairwise disjointness of the blocks C_h. This is a local counting theorem, not the historical weighted Hall condition.

### PR #89 — deriving the fibre hypotheses from arithmetic quotient maps

- Parent exact head 97263bace7959337f0e923c3b602b37c34bbfb14: canonical job 42753107890 succeeded; audit job 42753107930 succeeded; canonical log has zero sorryAx occurrences.
- The declaration APW4HistoricalQFibre.ZModQuotientProjectionModel.sum_M_qr_le_Gamma_qr_of_quotient_homs has profile [propext, Classical.choice, Quot.sound].
- The separate Lean 4.35 paranoid job 129621200380 was still running at the last status check.
- The subsequent source-only clarification commit is 16fd73829093e185855e48e24ad62a3d1acb2721; it labels the Fin-valued map as a coordinate model and keeps the actual ZMod quotient homomorphism separate.
- A further q-power specialization was added at commit 0a41d35377dffb85f234ca7f0b33e57ac4348bcd. It defines B_q=N/q^a, proves B_q | N when q^a | N, and instantiates ZMod N → ZMod B_q. This newest q-power declaration is pending its own CI run.

The selected supports Uq,Ur and the block-label map c remain explicit. They have not been identified with the missing historical APW4 source objects.

### Canonical collision-slot candidate — isolated, not accepted

A dependent-sigma candidate for canonical ordered collision slots failed to obtain a Fintype instance and its cardinality theorem left an unsolved subtype-cardinality goal. The declarations carried sorryAx and have been removed from APW4HistoricalCRTCore.lean. The candidate is archived separately in APW4_CANONICAL_COLLISION_SLOT_MODEL_CANDIDATE_2026-11-10.md. It is a possible new canonical construction, not the historical BIB-place set and not part of the proof chain.

### Syracuse finite-fibre interface

The former initial-interval construction is explicitly reclassified as a cardinality-only model; it does not construct an actual dyadic residue cylinder. A separate module SyracuseDyadicResidueFibre.lean now defines the tail as the lift of a specified residue class modulo 2^B into the common ambient modulus 2^Bstar, and the candidate region as its complement. It includes a membership/congruence characterization and the intended cardinality and mass identities, subject to B ≤ Bstar.

At the previous exact head 7fc256607a5b94f5c2b36d147585caeee8d1ef74, the isolated Lean 4.35 build found errors in the embedding injectivity and residue-membership proofs; these were corrected in commit 5d6e50e401f86719db54ca885caac29d98a23418. Workflow 42753674029 is running on that corrected head. Until it completes, the residue-cylinder declarations remain unverified. Even after that run, the parameter r must still be instantiated by the exact tail residue of a Syracuse prefix, and the individual child-valuation cylinders must be identified before claiming the full Syracuse partition. The new residue module is not yet a FibreData object.

### Cross-project transfer rule

No finite dyadic count, residue-cylinder cardinality, or quotient-map result becomes a historical BIB place merely because the cardinalities agree. A transfer requires the explicit prefix-to-residue map, exact child-cylinder correspondence, preservation of indices and weights, and then a concrete event-to-slot incidence proof.
