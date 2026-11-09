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
