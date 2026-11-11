# BBMST-to-Lean proof-obligation map (audit note)

Pinned Lean source:
- Repository: axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture
- Commit: fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086
- File: ErdosSelfridge_v17_fixed.lean

Audit branch: audit/strengthened-sieve-interface-v1

## Scope and epistemic status

This note records proof obligations visible from the source signatures and the BBMST paper mapping. It does not claim a disproof of the Erdős–Selfridge conjecture, nor does it establish prize eligibility. The current Lean file uses two explicit axioms for deep BBMST results; therefore the main theorem is not presently proved from Lean's kernel-checked derivations alone.

## Obligation matrix

| Lean item | Current role | Required mathematical obligation | Audit status |
|---|---|---|---|
| `sieve_criterion` | Axiom: odd covering system plus `sieveSum < 1` implies False | Formalize the applicable BBMST exclusion criterion and all hypotheses needed for the chosen moment bounds | UNPROVED AXIOM |
| `sf_sieve_lt_one` | Axiom: for any finite list of odd primes, supplies `δs, ca1, ca3` with sieve sum < 1 | Formalize the square-free case / BBMST Theorem 1.1, including existence and validity of the initial distribution/moment constants | UNPROVED AXIOM |
| `δs` in `sf_sieve_lt_one` | Only elementwise `0 ≤ δ_i < 1` is required by its result; no explicit `δs.length = primes.length` | Prove parameter alignment or prove the sieve expression is valid for mismatched lists | GAP IN INTERFACE |
| `sieveTerm` | Uses `getD k 0`; rational division is totalized at denominator zero | Ensure valid inputs keep the intended denominator positive, or define the expression to reject invalid parameters | DEGENERACY RISK |
| `M2bound` | Uses numerator `c3 - 2*c1 + 1` | Match the exact hypotheses under which the strengthened second-moment estimate is valid | SOURCE-TO-CODE CHECK REQUIRED |
| Initial constants/distribution | `ca1` and `ca3` are existential outputs of an axiom | Derive them from the relevant distribution and prove the required moment inequalities; do not treat scalar inequalities alone as provenance | UNPROVED |
| Geometric hypothesis for stronger second-moment estimate | BBMST's stronger Eq. (13) is conditional on the stated geometric condition | Identify the exact object corresponding to the BBMST hyperplane family and prove the condition, or use the weaker valid bound | NOT YET MAPPED |

## Key distinction

A structure that stores length bounds and scalar inequalities can reject malformed inputs, but those fields are not themselves a proof that BBMST's moment estimates hold. The next mathematically meaningful change is not to add more scalar fields: it is to replace the relevant axiom(s) with theorems whose proof terms establish the estimates from the source hypotheses, and to trace all uses of the stronger Eq. (13) bound.

## Required next steps

1. Pin the exact BBMST definitions and theorem statements (including the supplement's initial-distribution construction).
2. Map every Lean quantity (`ss`, `δs`, `ca1`, `ca3`, `ck`, `M1bound`, `M2bound`) to the paper's notation.
3. Decide whether to formalize the LP/distribution existence argument or import a verified certificate with a proof of its validity.
4. Prove the geometric side condition wherever the stronger second-moment estimate is used, or replace that estimate with a weaker justified one and re-evaluate whether the numerical inequality still closes.
5. Re-run the transitive axiom trace on `erdos_selfridge`; any remaining project-specific axiom must be explicitly justified or eliminated before describing the result as a complete formal proof.


## Literature update and APW4 correspondence boundary — 11 November 2026

The separate literature ledger is [publication/ODD_COVERING_LITERATURE_AND_APW4_METHOD_COMPARISON_2026-11-11.md](publication/ODD_COVERING_LITERATURE_AND_APW4_METHOD_COMPARISON_2026-11-11.md).

The Schroeder rank-seven and rank-eight preprint abstracts describe normalized fibre distortion and increasing supermodular functionals on congruence labels. The BBMST paper independently contains a published stage/fibre measure recursion and mass-conservation lemma. These similarities motivate comparison, but they do not supply a source-faithful APW4 instantiation.

The APW4 obligations remain separate and open:

1. recover the exact historical APW4 event/index family and construct an index-preserving map to the BBMST stage/fibre objects;
2. prove original APW4 weight preservation or a correctly oriented mass inequality, including exceptional fibres and normalization;
3. identify the historical BIB slots and prove the weighted Hall/capacity inequality for all required event subfamilies.

Do not identify canonical model fibres with historical APW4 events, and do not merge APW diagonal mass, APW off-diagonal mass, or BIB pair reserve without the explicit map. The rank-seven/eight/nine results are same-author sequential preprints; their claims are not independent peer-reviewed corroboration. The rank-nine claimed bound is not entered as an established theorem.

This is a documentation clarification only. It does not change the two-axiom status of the pinned upstream Lean source, any APW4 theorem, the manuscript, or the existing mathematical proof record.


## 2026-11-11 status correction: PR #154 and historical map

- PR #154 exact head: `9397d0b0cbd139e3c431a02fff21b8c9c77a4061`.
- Workflow [43086198224](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43086198224): independent audit PASS; integrated Lean 4.35.0 FAIL.
- Remaining branch goals: `prefixFibre_updatedWeight_eq_PAt`, positive case at line 405 and negative case at line 406.
- Error-recovery output contains `sorryAx` in the target and dependent PAt declarations. No integrated proof is verified.

**Next source-level obligation:** normalize the local values expression and a single canonical Covered predicate before unfolding PAt; prove the positive and negative conditional equalities separately; only then reintegrate the dependent recursion. No generic simp patch is authorized by this diagnosis.

**Historical reconstruction remains open:** locate the source definitions of `ρ_x` and `W_x`, and the exact map `(x,u) ↦ (k,I,J)`. Record source/page/definition references and prove the required index-preserving and weight/capacity transport. Do not infer these objects from the current Lean model.

See [the dated APW4 prefix-recursion and historical-map note](publication/APW4_PREFIX_RECURSION_AND_HISTORICAL_MAP_STATUS_2026-11-11.md). Mathematical proof status, historical reconstruction, and Lean/CI verification remain separate.


## 2026-11-12 — isolated coordinate lemma: module PASS, integrated recursion FAIL

PR [#156](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/156), head `1add382fec3375cb2a67822ae872c2bc5d3bb8a3`, workflow [43118336799](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/43118336799):

- Audit job 130852038555: **SUCCESS**, all 22 ordered audit steps completed, including compilation of `BBMSTPrefixMeasureRecursion.lean`.
- The new `prefixIndex_last_eq_stageCoordinate` declaration is in that successfully compiled module. It is therefore compiler-checked as part of the file. The log does not emit a separate theorem-named `#print axioms` line for this lemma; do not claim a standalone axiom report that is absent.
- Integrated-paranoid job 130852038915: **FAILURE** at `pos` and `neg`, lines 417–418. The error-recovery report still contains `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and dependent declarations.

The integrated failure is not evidence against the isolated coordinate lemma: the patch deliberately leaves the two branch goals unchanged. The module audit pass is not proof of the full dependent recursion. Membership transport, proof irrelevance, and the two branch closures remain separate obligations. PR #156 remains open/draft/unmerged. No theorem or historical APW4 obligation is promoted by this CI result.
