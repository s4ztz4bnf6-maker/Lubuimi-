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
