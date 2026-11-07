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


## 6. Prefix-recursion implementation status (2026-11-07)

The source-indexed prefix module is present as
`BBMSTPrefixMeasureRecursion.lean`. At commit
`e3e705c9566414d425cfc904cd2347e6d0c303cb`, it defines
`restrictPrefix`, `extendPrefix`, and the concrete set
`prefixCoveredValues` by filtering the next-coordinate finite type using
`newAtStage` and `ContainsPrefix`. Its proportion `prefixAlpha` is the
cardinality fraction of that exact set. The recursion `PAt` uses the same
set and the last coordinate of the extended prefix.

The commit adds `extendPrefix_last`, asserting that the appended value is
read at `Fin.last k`. This is a source-level addition only until the
workflow compiles the module on this commit. The following are still
unproved in the prefix module: restriction after extension, extension after
restriction, the fibre-indexing equivalence, a concrete `UniformFibre`
instantiation over the actual coordinate type, and a pointwise identity
between the recursion `PAt` and `updatedWeight`.

The finite-fibre lemmas do not by themselves establish these links. In
particular, `FibreData.covered_mass` requires the exact weighted sum over
the concrete covered set; a cardinality fraction is sufficient only after
the uniform weight function and the concrete set are connected by a proved
construction. Global normalization additionally requires explicit
nonnegativity and normalization hypotheses on the initial distribution
`P0`.

The workflow `.github/workflows/lean-audit.yml` explicitly compiles the
prefix module after the six upstream helper modules. A successful run on a
commit is evidence for compilation of that module, not for the full theorem:
the project-specific `sieve_criterion` and `sf_sieve_lt_one` axioms remain
unreplaced, and the source-level BBMST theorem obligations above remain open.
