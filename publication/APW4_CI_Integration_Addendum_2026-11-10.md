# APW4 / BBMST — CI integration addendum

**Author:** Ta-Yoshua Lubuimi  
**Date:** 10 November 2026  
**Purpose:** Append-only record of the latest integrated checks. This addendum does not replace the published APW4 manuscript, the mathematical proof record, or earlier commit-bound CI evidence.

## Preservation rule

A later failed integration run does not invalidate an earlier successful run on a different commit and scope. Mathematical proof status, historical-source fidelity, Lean elaboration, transitive axiom audits and commit-bound CI status are distinct. No earlier result is silently removed or downgraded by this addendum.

## Previously successful checks retained

- Run 42599116987: APW4DiagonalAudit.lean and APW4CanonicalMajorization.lean compiled; four printed axiom profiles were [propext, Classical.choice, Quot.sound].
- Run 42522617494: the listed BBMST/APW4 fibre, prefix, geometry, hyperplane-incidence and moment-recursion modules completed on their checked revision.
- Run 42599116967: the canonical APW4 run completed successfully.

These remain successful checks for their exact commits, declarations and job scopes. They do not automatically certify later revisions.

## Latest integrated run 42718994622

The run completed with failure in both jobs.

### Integrated-paranoid job

The job checked out the source, installed Lean 4.35.0 and the integrated package, restored the Mathlib cache, and started the combined build. It failed during the integrated compilation step. It is therefore not a successful full integrated build and not a successful complete paranoid check.

### Audit job

The audit job successfully completed the following stages before the first failing stage:
- audited upstream source compilation;
- focused degenerate-witness tests;
- aligned zero-safe sieve parameter core;
- zero-safe BBMST fibre measure core;
- finite weighted fibre update;
- uniform-coordinate fibre instantiation;
- finite-stage first- and second-moment bounds;
- finite-coordinate geometry core;
- uniform-stage source moment instantiation.

It then failed in BBMSTPrefixMeasureRecursion.lean. The log records unsolved dependent-prefix goals at lines 171 and 333 and a redundant tactic at line 356. Error recovery printed sorryAx in dependent declarations including prefixExtensionEquiv, sum_prefix_eq_sum_extensions, prefixFibre_updatedWeight_eq_PAt and PAt_nonneg. Later prefix-moment targets were skipped. This is a real formalization failure in that exact revision and must not be presented as a passing audit.

The integrated-paranoid log also records failures in BBMSTHyperplaneFibreIncidence.lean at lines 347 and 454. Several downstream moment declarations showed sorryAx in error-recovery output. This blocks the integrated package result, not the independent earlier successful modules.

## Technical next steps

1. Repair BBMSTPrefixMeasureRecursion by explicitly handling the dependent equality/transport at the last prefix coordinate. Avoid relying on simplification that loses the equality witness.
2. Remove the redundant tactic at line 356 only after checking the preceding tactic's exact goal effect.
3. Repair the two unsolved dependent goals in BBMSTHyperplaneFibreIncidence at lines 347 and 454, then audit the dependent moment declarations transitively.
4. Re-run the full integrated package and the audit job on the same exact commit. Require complete success and named #print axioms output without sorryAx.
5. Keep the older successful run IDs and their exact scopes in the permanent record.

## Mathematical APW4 status

This CI failure is not a mathematical counterexample to the APW4 manuscript. The author's established APW4 mathematical result and published manuscript status remain part of the research record. The failed Lean integration is recorded as a formalization task; it is not a reason to erase or silently downgrade the mathematical result.

The historical DT/HT bridge must be represented source-faithfully. The APW4 diagonal mass, off-diagonal mass and BIB pair reserve remain distinct until the manuscript's explicit index-preserving identifications are carried through. Do not replace historical objects with canonical model objects merely to make a Lean module compile.

**Attribution:** APW4 research and authorship: Ta-Yoshua Lubuimi. AI tools are assistants only, not coauthors or independent mathematical verifiers.


## Addendum 1.7 — exact CI status as of 10 November 2026

The integrated PR #69 head `95669afac00d8913c1fc2a91b6bb3b5740ce6d92` was checked by run `42722133436`; both the audit and integrated-paranoid jobs failed. The audit compiled the upstream source, focused degenerate-witness tests, zero-safe fibre and weighted update chain, uniform-coordinate instantiation, finite-stage moment bounds, finite-coordinate geometry and uniform-stage source moment, then failed at the source-indexed prefix recursion. The integrated-paranoid job failed during the full package build. The line-level diagnostic is in `APW4_CI_RUN_42722133436_DIAGNOSTIC_2026-11-10.md`.

The documentation branch's run `42723539932` completed successfully for the earlier documentation head `2be6cec71a783eb1293d32a70df4646a5616f71a`; subsequent docs commits are not covered by that run. It was a degenerate-witness audit, not the integrated-paranoid build. The current append-only status snapshot is `APW4_CI_STATUS_SNAPSHOT_2026-11-10.md`.

Earlier successful APW4 and BBMST checks remain valid for their exact commits and declaration scopes. The mathematical APW4 proof record is unchanged. No full integrated Lean 4.35.0 paranoid success is claimed.


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


## Addendum 1.16 — Lean-verified Syracuse cap core

The Syracuse programme now has a genuine Lean-verified finite non-descent cap core. Workflow 42728049650 passed on exact source commit ca48ec7fdad5e8d6f8aeb82fed8586a1b57c12bc using Lean 4.34.1. The declarations signedOffsetMargin_nonpos_succ_iff_exponent_cap, signedOffsetMargin_nonpos_of_nondecreasing_orbit, and nondecreasing_orbit_next_exponent_cap each printed [propext, Classical.choice, Quot.sound]; the complete job log contained no actual sorryAx occurrence and the build completed 8,930 jobs.

This proves in Lean the exact margin equivalence and the necessary next-exponent cap for a nondecreasing exact affine endpoint. It does not yet formalize the maximum cap B_alpha, the exact tail-cylinder partition, or the general finite-word cylinder theorem. The Syracuse cap's Lean 4.34.1 verification is separate from the APW4 integrated Lean 4.35.0 audit. The APW4 historical index-preserving transport, diagonal/off-diagonal bounds, and BIB/Hall capacity remain open.


## Addendum 1.17 — residual universe-membership repair and current exact-head run

The Lean 4.35.0 log for PR #69 head `4c30eca56d188d144630d27b94c506c6eac0a4d0` showed that `prefixPointCovered_iff` had become axiom-clean, but `prefixFibre_updatedWeight_eq_PAt` still left two goals. Both goals had the same source: after unfolding `updatedWeight`, the finite fibre's point-membership conditional had reduced to a residual test `x ∈ Finset.univ`. The proof now explicitly includes `Finset.mem_univ` in both branch simplifications and uses the nondeprecated `ite_true` lemma in the initial reduction.

The exact source head is now `1f4225ce0bdf6186fd0700612e2306ed3ff44506`. Workflow 42734929700 has both the Lean 4.28 audit and Lean 4.35.0 integrated-paranoid jobs in progress. The prior 4.28 audit pass remains preserved for its own commit. The new candidate is not yet accepted: both jobs must complete, the declarations `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, and `PAt_sum_eq_one` must print the standard profile, and the integrated log must contain no actual `sorryAx` occurrence.

## Addendum 1.18 — proof-indexed covered predicate normalized with propext

On PR #69 head fc2b5f501c4efb478d1c61af2dcb1ae529026cbc, run 42736917706 still failed in Lean 4.35.0. The exact target showed that the updatedWeight conditional and the recursively unfolded PAt conditional referred to distinct proof-indexed prefixCoveredValues terms. The source also reported a no-goal tactic after simplification. The new candidate 8a6f2f353d5877ccf7f10a1e91d2bf214c5f7768 defines hcovered, converts it to an equality of propositions using propext, and rewrites the target before splitting the conditional. Exact-head run 42737432337 is in progress. The Lean 4.28 audit and Lean 4.35.0 integrated-paranoid outcomes remain pending; no success is claimed.


## Addendum 1.19 — exact finite-depth Syracuse uniform fibre and current candidate

A separate mathematical note now proves a finite-depth uniformization of the Syracuse child/tail cylinders. At a fixed depth, the set of prefixes that are not excluded by their local cap is finite. Taking the maximum cap B*_k over that finite level yields a common fibre of size 2^(B*_k). Each exact child b occupies 2^(B*_k-b) equal micro-atoms and the tail occupies 2^(B*_k-B_α); the distinguished cap-compatible subset therefore has proportion 1-2^-B_α. The tail complement has exact mass 2^-B_α and is forced to descend below the initial start. This is an APW4-style uniform-fibre model, not a proof of the historical hyperplane/BIB event identification. It remains to be Lean-formalized.

The APW4 candidate 8a6f2f353d5877ccf7f10a1e91d2bf214c5f7768 failed both toolchains. The attempted propext rewrite left the covered/uncovered update branches misaligned, with downstream sorryAx in error recovery. A new candidate f02f8d28f0d06735bab9ec1a591839704c6bb9ac changes the rewrite orientation. Exact-head dual-toolchain run 42738073791 is queued; no pass is claimed.


## Addendum 1.20 — f02f membership rewrite did not close Lean 4.35 integration

Exact-head workflow 42738073791 on source commit f02f8d28f0d06735bab9ec1a591839704c6bb9ac has a confirmed Lean 4.35.0 integrated-paranoid failure in prefixFibre_updatedWeight_eq_PAt. The attempted rewrite orientation rw [hcoveredEq] still leaves the updatedWeight membership term based on prefixCoveredValues C hk (restrictPrefix C hk y), while the PAt recursion contains proof-indexed prefixCoveredValues/restrictPrefix terms. The stageCoordinate, Fintype.card and δ arguments likewise remain proof-indexed. The log reports an unsolved goal at line 355 and a no-goal tactic at line 378. Error-recovery sorryAx propagates to PAt_nonneg and PAt_sum_eq_one.

The source-level diagnosis is now specific: a single membership Iff is insufficient. The next repair must first prove and use named equalities for stageCoordinate, restrictPrefix and prefixCoveredValues under alternate proof witnesses, then normalize the complete multiplier/cardinality expression. A shared raw update function used by PAt and the concrete fibre is an alternative architecture. The Lean 4.28 audit job is still running; no dual-toolchain status is claimed until it finishes.
