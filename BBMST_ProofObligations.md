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


## 2026-10-23: second-moment bridge, made explicit

The current module `BBMSTOverlapConditioning.lean` now contains the purely
finite rational identities

- `finite_weighted_fiber_expansion`: expansion after splitting a shared
  coordinate from two residual blocks;
- `finite_square_sum_expansion` and
  `finite_weighted_square_sum_expansion`: ordered-pair expansion of a square;
- `finite_pairwise_square_difference` and
  `finite_sum_sq_le_card_mul_sum_sq`: the finite variance identity and its
  Cauchy--Schwarz consequence;
- `finite_event_indicator_square` and
  `finite_event_indicator_product`: pointwise indicator rules.

These identities are necessary algebraic infrastructure, not a substitute
for the BBMST estimates. The next proof layer must instantiate them with the
published paper's actual finite probability space and hyperplane indicators.
In particular, for events E_i, the square expansion gives
`(sum_i 1_{E_i})^2 = sum_{i,j} 1_{E_i ∩ E_j}` pointwise; after taking the
specified probability measure, the right side becomes
`sum_{i,j} P(E_i ∩ E_j)`. The hard step is bounding these intersections
using the paper's geometry and moment hypotheses, not proving the formal
expansion again.

### Guardrails for the next implementation

1. Do not replace the intersection estimate with independence: hyperplane
   events can be dependent.
2. Do not infer a uniform positive uncovered mass from nonemptiness alone;
   a single uncovered point gives only a bound of order inverse sample size.
3. Keep the published 2021 version as source of truth. In particular, retain
   its corrected union-bound argument in Theorem 3.1 and the corrected
   inequality direction in Lemma 5.3.
4. The project's own `sf_sieve_lt_one` and `sieve_criterion` remain open
   obligations; the moment identities do not discharge either axiom.

This note records the exact bridge still missing between the verified
finite-sum algebra and the source-specific geometric probability estimates.
It does not claim a completed BBMST proof.
