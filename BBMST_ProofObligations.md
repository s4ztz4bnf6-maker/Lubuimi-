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

Historical status at the initial prefix-module commit: only
`extendPrefix_last` had been added at that point. This paragraph was
superseded by the later source commits documented below. The current branch
also contains restriction/extension inverse lemmas, the prefix-extension
equivalence, the concrete `UniformFibre` instantiation, and the pointwise
identity between `PAt` and `updatedWeight`. These remain source-level
until the corresponding CI compilation is observed.

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


## 7. Iterated prefix distortion and the remaining marginal issue (2026-11-07)

At commit `a2a9963dd93409e4b9bb26fbed574c252a980c33`, the source-indexed
recursion module added
`PAt_succ_le_prev_div_card_mul_one_sub_delta`. Its intended estimate is
the one-step pointwise bound
[
 P_{k+1}(y)\le
 \frac{P_k(\operatorname{restrictPrefix}(y))}
 {|S_{k+1}|(1-\delta_{k+1})}.
]
This is derived in source from the actual `PAt` recursion and the concrete
uniform-fibre update, but has not yet been compiled or kernel-checked.

At commit `c396190b595e6d04b0dfbc042653e0d364c81858`, the same module
adds `initialPrefixOf`, `distortionFactor`, `distortionProduct`,
`initialPrefixOf_restrictPrefix`, and
`PAt_le_initial_mul_distortionProduct`. The intended theorem iterates
the one-step pointwise estimate over every coordinate between the initial
prefix and the current prefix. It uses the actual initial marginal obtained
by lifting and projecting the given prefix. These are source-level proof
terms only; no Lean compiler, CI run, or kernel verification has yet
confirmed them.

**Important mathematical limitation:** the pointwise product bound over
*all* intervening coordinates is not itself Lemma 3.3. It introduces
distortion factors even at coordinates that are free in the hyperplane
shadow. Those factors cannot simply be discarded. The correct next
measure-theoretic interface is a cylinder/event-mass induction:
- when the newly exposed coordinate is free in the hyperplane, sum over
  all its values and use exact fibre mass conservation;
- when it is fixed, retain the single prescribed value and apply the
  one-step distortion bound;
- iterate only over the coordinates in the hyperplane's suffix fixed set
  (J), yielding exactly the product ν(J), not a product over every
  intervening coordinate.

The remaining initial-prefix step is to bound the mass of the initial
cylinder by the coefficient (c(I)) defined as the maximum of the actual
initial measure (P_a) over initial hyperplanes with fixed-coordinate set
(I). No arbitrary coefficient family may replace this construction.

The main theorem remains open. In particular, neither the new pointwise
product estimate nor the earlier old-shadow identities establish Lemma 3.3,
Lemma 3.4, the strict sieve inequality, or the replacement of
`sieve_criterion` and `sf_sieve_lt_one`. The required final transitive
audit remains
`#print axioms erdos_selfridge` with exactly
`[propext, Classical.choice, Quot.sound]`.


## 8. Prefix event-mass layer (2026-11-07)

At source commit `4445a988f4ffc91d9a73b3d80260a5c25fa1cfe0`,
a separate module `BBMSTPrefixCylinderMass.lean` was added. It states two
finite-prefix results for an arbitrary finite set E of old prefixes:

- `sum_extensions_eq_old_event_mass`: summing the next-stage `PAt`
  weights over every value of the newly exposed coordinate preserves the
  mass of E;
- `fixed_extension_event_mass_le`: retaining one prescribed next-coordinate
  value bounds the event mass by the old event mass divided by
  `|S_k|(1-δ_k)`.

The free-coordinate statement is stronger than global normalization:
it is an event-level identity for each finite E. The fixed-coordinate
statement is the corresponding event-level inequality. Both are written
against the actual `PAt` recursion and its concrete uniform-fibre bridge,
not an independently selected fibre law.

At source commit
`2a0cdcab038f2bc601bf2950788d6e5e79f0c34f`, the Lean audit workflow was
extended to compile `BBMSTPrefixCylinderMass.lean` immediately after
`BBMSTPrefixMeasureRecursion.lean`.

**Verification status:** these two new proof terms are source-level only.
The workflow edit merely schedules compilation; it is not evidence that
compilation has occurred. No CI result or kernel output is claimed here.
The two lemmas also do not yet prove Lemma 3.3: the remaining work is to
instantiate E as the successive sections of the actual hyperplane shadow,
prove the fixed/free classification from its assignment map, and connect
the initial section to the source-defined coefficient c(I). The main
theorem and the final axiom audit remain open.
