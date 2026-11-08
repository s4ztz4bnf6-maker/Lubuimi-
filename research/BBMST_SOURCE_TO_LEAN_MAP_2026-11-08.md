# BBMST source-to-Lean correspondence map

**Research lead / formalization developer:** Ta-Yoshua Lubuimi  
**Snapshot under review:** code commit `3ffe65b933222b135d4fa27cd8e6efa358aa8089`  
**Purpose:** working correspondence ledger for publication preparation. This is not a claim that the full paper proof has been formalized.

## 1. Correct mathematical target — scope gate

The published BBMST Theorem 1.1 states: every finite collection of arithmetic progressions with distinct square-free moduli greater than one that covers the integers contains an even modulus. The paper explicitly distinguishes this square-free result from the unrestricted Erdős–Selfridge question. See the published paper, pp. 610–611.

The pinned upstream file `ErdosSelfridge_v17_fixed.lean` at commit `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086` defines `CS_squarefree`, but its declaration

`theorem erdos_selfridge (K : Nat) (cs : CoveringSystem K) : ¬ CS_allOdd cs`

has no `CS_squarefree cs` hypothesis. It therefore states the unrestricted odd-covering conclusion, not the published BBMST square-free theorem. In that same file, `sieve_criterion` and `sf_sieve_lt_one` are explicit axioms. The first axiom already turns an odd covering plus a strict sieve-sum bound into `False`; the second supplies parameters satisfying the strict bound. Thus the declaration is not a kernel-derived proof of the unrestricted conjecture.

**Publication rule:** do not describe `erdos_selfridge` as a formal proof of BBMST Theorem 1.1. The exact square-free theorem (or its geometric equivalent, Theorem 1.2) must be stated as a separate target with all square-freeness hypotheses and the Chinese-remainder correspondence made explicit. This scope correction is a hard release gate, independent of Step 16.

## 2. Working correspondence table

The rows below identify the intended mathematical role of each current Lean module. They are a research map, not yet a declaration-by-declaration proof of correspondence to every line of the published argument.

| BBMST source item | Mathematical role | Current Lean artifact / declarations | Historical CI evidence | Current status / caveat |
|---|---|---|---|---|
| Lemma 2.1, equations (4)–(6) | Preservation of earlier measurable event mass, bounded distortion, and removed-set mass monotonicity | `BBMSTFiberMeasureCore.lean`, `BBMSTFiniteFibreUpdate.lean`, `BBMSTUniformFibreInstantiation.lean`; supporting declarations are printed in the prerequisite job logs | Prerequisites compiled in runs 42488903023 and 42488903065 | Module-level compile evidence only; verify each formal definition against the paper's piecewise update rule, including zero-mass fibres |
| Lemma 3.3, equation (15) | Propagation of hyperplane mass: (mathbb P_k(A) le c(I)\nu(J)), charging only fixed suffix coordinates | `BBMSTPrefixCylinderMass.lean`; key declarations include `containsPrefix_extend_iff`, free/fixed specializations, cylinder extension equivalences, reindexing identities, and `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` | Step 16 run 42515743524 on 3ffe65b failed at lines 253 and 257 after five prerequisites passed | **OPEN — FAILED**. This is the immediate blocking stage; its source proof is not accepted on the tested commit |
| Lemma 3.4 | Bounds on moments of (alpha_k(x)) by sums over tuples of new hyperplanes and their compatible intersections | `BBMSTPrefixMomentBridge.lean` (Step 17), `BBMSTHyperplaneFibreIncidence.lean` (Step 18), `BBMSTOldShadow.lean` (Step 19), and `BBMSTPrefixIncidenceBridge.lean` (Step 20) | Step 17: run 42488903023; Steps 18/19: run 42488903065; Step 20: later successful run 42513785862 on 9daa08a | The correspondence is plausible from the declaration names and constructions, but the exact (mathcal N_k), old-shadow intersections, multiplicities, and (c(I)\nu(J)) weights must be checked term by term |
| Theorem 3.2, equations (12)–(13) | First- and second-moment bounds; improved second moment when no new hyperplane has codimension one | Step 18 declarations `actualStageFirstMoment_eq`, `actualStageSecondMoment_eq`, `actualStageFirstMoment_le_newHyperplaneRatio`, `actualStageSecondMoment_le_compatibleSquareAverage`; Step 20 prefix-to-incidence bridge | Historical isolated module runs above | The exact non-codimension-one hypothesis and the reduced coordinate sets must match the paper. Do not infer the improved estimate from a generic pair count alone |
| Theorem 3.1, equation (8) and proof (14) | Convert first/second moment bounds into a strict upper bound on removed mass and hence a nonempty uncovered set | `BBMSTFiniteUnionBound.lean` (Step 21): `eventUnion_mass_le_sum`, `eventMass_compl_add`, `complement_union_has_positive_mass`, `exists_point_outside_union` | Step 21 in run 42488903065 | This is the abstract finite union/noncoverage implication. It does not prove the strict numerical sum bound required by (8) |
| Definition (11), (c_k(x)), and its recurrence | Polynomial/moment recurrence controlling the first and second moment envelopes | `BBMSTMomentRecurrence.lean` (Step 22): `cK_succ`, `cK_initial`, `stageFactorProduct_succ`, `cK_le_initial_mul_two_over_size_product`, `cKOne_succ`, `cKThree_succ` | Step 22 in run 42488903065 | Check coefficient normalization, indexing, initial polynomial, and the factor (1/((1-\delta_j)|S_j|)) against equation (11); Lean compilation alone does not establish source fidelity |
| Theorem 1.1 / Theorem 1.2 | Square-free arithmetic-progression conclusion and its geometric hyperplane-cover equivalent | No final declaration in the present evidence has been certified as the exact theorem with the square-free hypothesis plus CRT bridge | No final integrated theorem audit | **NOT ESTABLISHED**. Sections 4–5, finite certificates, large-prime tail, and CRT equivalence must also be represented and verified |

## 3. Historical CI evidence for Steps 17–22

- Step 17: run [42488903023](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903023), commit `125507564b4b6d89565d0d606ab0bd38951b158d`, successful isolated compile.
- Steps 18, 19, 21 and 22: run [42488903065](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903065), same commit. Jobs 18, 19, 21 and 22 succeeded; Step 20 failed in that earlier attempt.
- Step 20: later run [42513785862](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42513785862), commit `9daa08aecc68ce9de0e086ca006dbc9980ab5ad0`, successful isolated compile. Its declaration traces showed the standard profile `[propext, Classical.choice, Quot.sound]`.
- Commit comparison confirms that the Lean source files for Steps 17–22 were not modified between `9daa08a` and the Step 16 repair commit `3ffe65b`. This means the later Step 20 success remains relevant to the unchanged Step 20 source file, but it is not a fresh run on the exact `3ffe65b` tree.

The isolated workflows do not compile the entire chain in one end-to-end run. Some jobs explicitly assume earlier modules and Step 16 is deliberately excluded. Their green status must not be described as an integrated proof.

## 4. Fresh verification attempt

A separate branch `verification/steps-17-22-rerun-2026-11-08` was created from `3ffe65b`. It contains only a new CI workflow file, `.github/workflows/rerun-steps-17-22-isolated.yml`, with six isolated jobs for Steps 17–22. It does not modify Lean source files or the active proof branch.

The workflow file commit is `364a07358e1856b5a17a6963f2f223061b92fb5e`. As of this documentation update, no CI run ID or status check has been returned for that commit. **Fresh rerun status: NOT YET CONFIRMED — do not call it running or successful until a GitHub Actions run and its job logs are visible.**

## 5. Mandatory proof-fidelity checks before publication

1. Compare the finite fibre update to BBMST Lemma 2.1, including the exact treatment of (alpha_k=0), (alpha_k=delta_k), and zero-mass fibres.
2. Compare the prefix-cylinder induction to Lemma 3.3, including the source-defined (c(I)), exact fixed-coordinate set (J), and no distortion factor for free coordinates.
3. Compare the moment bridge and old-shadow construction to Lemma 3.4, preserving the ordered tuple multiplicities and exact union of fixed-coordinate sets.
4. Compare first/second moment bounds and the no-codimension-one strengthening to Theorem 3.2 (12)–(13), including the deletion of codimension-one hyperplanes and the resulting coordinate sets.
5. Compare the removed-mass estimate to Theorem 3.1 (8) and (14).
6. Compare the (c_k(x)) recurrence to equation (11), with exact base case and factors.
7. Formalize the remaining Section 4–5 inputs, the finite certificates, large-prime tail, and CRT equivalence to Theorem 1.1.
8. Audit the exact final square-free theorem transitively. No project-specific axiom or `sorryAx` may remain.

## 6. References

- P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe and M. Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), no. 3, 609–626, DOI: 10.2140/ant.2021.15.609. Published PDF: https://par.nsf.gov/servlets/purl/10300177.
- Pinned upstream Lean source: `axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture`, commit `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`, file `ErdosSelfridge_v17_fixed.lean`.
