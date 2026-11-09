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


## Source-fidelity finding (2026-10-28)

A fresh check against the pinned upstream file and the published BBMST paper exposes a second, independent issue beyond malformed parameter lists:

1. The upstream Lean comments label `sieve_criterion` as “BBMST Thm 3.1 + 3.2”, but the actual published geometric criterion is stated for a finite product space and a family of nontrivial, pairwise nonparallel hyperplanes, together with the source's fixed-coordinate / moment hypotheses. The axiom's signature receives only an integer covering system, oddness, scalar sieve parameters, `ca1 ≥ 1`, and `sieveSum < 1`. Those data do not themselves encode or prove the geometric hypotheses or the construction linking the integer system to that hyperplane family. The axiom is therefore not source-faithful as an interface.

2. The upstream Lean comment labels `sf_sieve_lt_one` as “BBMST Thm 1.1 (computation)”. In the published paper, Theorem 1.1 is the square-free-moduli obstruction, not merely an existential parameter-computation lemma. The numerical/distribution certificate and the large-prime argument must be mapped to their actual source lemmas, the supplemental computation, and the exact theorem scope. A theorem label is not a proof of that mapping.

3. The published paper's headline theorem concerns distinct square-free moduli. Any use for the unrestricted odd-modulus conjecture must explicitly identify and prove the additional prime-power extension and its exact restrictions; the square-free theorem alone cannot discharge the unrestricted goal.

These findings are source/interface audits, not a counterexample to the mathematical conjecture. They strengthen the release gate: before replacing either axiom, first write the precise source theorem in Lean-shaped form, include its geometric and parameter-provenance hypotheses, and prove the integer-to-hyperplane translation and every extension hypothesis. Do not fix this by adding unproved geometric predicates as assumptions to the final theorem.
