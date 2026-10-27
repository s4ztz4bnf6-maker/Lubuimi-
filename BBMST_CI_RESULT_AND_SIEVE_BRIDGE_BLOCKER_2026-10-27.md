# BBMST CI result and the remaining theorem-level defect
Date: 2026-10-27

Status: CI-compiled scalar lemmas and reproducible interface audit; not a proof of the Erdős–Selfridge theorem.

## 1. Verified CI result

Workflow run 40448578038 on the typed-parameter audit branch completed successfully:
https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/40448578038

The run compiled:
- `BBMSTParameterData.lean`;
- `BBMSTParameterDataAudit.lean`;
- the audited upstream source `ErdosSelfridge_v17_fixed.lean`;
- `AuditCheck.lean`, including the scalar inequalities below and the focused degenerate-witness tests.

The transitive axiom output for the typed parameter interface was `[propext, Classical.choice, Quot.sound]`. This is the expected ordinary Lean/Mathlib foundation for those declarations, but it is not an axiom-free proof of the global theorem.

The same run explicitly prints that `degenerate_axiom_acceptance` depends on `sieve_criterion`, and that `erdos_selfridge` depends on `sf_sieve_lt_one` and `sieve_criterion`. Therefore the workflow's success means the audit witness compiles and the defect is reproducible; it does not mean the global theorem is proved.

## 2. Scalar inequalities now compile

For rational parameters 0 <= α <= 1 and 0 < δ < 1, define
`normalizedRemovedMass α δ = max 0 ((α - δ)/(1 - δ))`.

The CI-compiled declarations establish:
1. `normalizedRemovedMass α δ <= α`;
2. `normalizedRemovedMass α δ <= α^2 / (4*δ*(1-δ))`.

The second bound follows from the elementary inequality
`4*δ*(α-δ) <= α^2`, equivalent to `(α-2δ)^2 >= 0), in the nontrivial case α>δ. These are useful pointwise algebraic bounds. They do not establish that the BBMST geometric fiber-removal mass is represented by this scalar, nor do they prove the paper's incidence/moment estimate.

## 3. Exact blocker

The current interface permits an empty `δ)-parameter list. Under its existing premises, the computed sieve sum becomes zero; hence it is less than one. The current axiom `sieve_criterion` accepts this degenerate case and returns the intended contradiction. This is a counterexample to the sufficiency of the formal interface, not a counterexample to the mathematical Erdős–Selfridge theorem.

A sound repair cannot merely add a nonempty-list condition and stop. It must:
- encode the paper's exact parameter indexing and admissible range;
- state the nonempty/positivity/normalization assumptions required by the source;
- define the finite probability space and the actual events/fibers;
- prove the source-specific overlap/distortion and moment bounds;
- derive the sieve criterion from those facts, removing the axiom rather than strengthening its assumptions around the same axiom;
- run the transitive axiom audit from the final theorem and compare the formal statement against the source.

## 4. Ratio-free proof architecture

Keep the following steps separate:
1. finite fiber partition and mass conservation (pure finite combinatorics);
2. exact identification of removed fibers and nonnegative weights;
3. positivity of every denominator before any division;
4. source-specific geometric inequality;
5. global sieve estimate and the final theorem.

This separation prevents a valid finite-sum identity or scalar inequality from being mistaken for the missing BBMST theorem-specific estimate.

## 5. Acceptance gates

Do not mark the result complete until all are true:
- fresh CI passes on the actual head commit;
- the degenerate witness is rejected by the repaired interface, rather than proving `False` through the sieve axiom;
- no `sorry`, `sorryAx`, or unproved theorem axiom remains in the transitive dependencies of the claimed result;
- the formal statement matches the source assumptions and conclusion;
- the geometric moment/overlap lemma is proved rather than postulated.

The present status is: successful compilation of the audit and scalar layer; the theorem-level sieve bridge remains open.
