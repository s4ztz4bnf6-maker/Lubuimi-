# Parameter-integrity audit and repair plan

Status date: 2026-10-22. This note records a reproducible interface defect and a proof plan. It is not a proof of the Erdős–Selfridge conjecture.

## Confirmed in the Lean audit branch

`AuditCheck.lean` proves that the current `sieve_criterion` interface accepts the empty parameter list with `ca1 = ca3 = 1`: the computed sieve sum is zero, hence below one. It also records the zero-delta denominator collapse and list-length mismatch examples. These are defects in the formal interface, not counterexamples to the number-theoretic conjecture.

`MeasureTransition.lean` now uses `Fin N` for a parameter family and proves an algebraic normalization identity under `0 ≤ δ ≤ 1/2`. That module does not construct the geometric/probabilistic objects or prove the source moment estimates.

## Repair obligations (in order)

1. Replace partial list lookup (`getD`) with a parameter object indexed by `Fin N`, with the stage count tied definitionally to the block-size family.
2. Require `0 < delta i` for every stage where the second-moment denominator `4 * delta i * (1 - delta i)` is used. The weaker condition `0 ≤ delta i` is not enough.
3. Define the finite probability space and the relevant events/measures explicitly; prove normalization and removed/retained mass identities from those definitions.
4. Formalize the hyperplane geometry. A predicate such as `noCodimOneAt` must be derived from the actual configuration, not introduced as an unproved field that makes the improved bound conditional on itself.
5. Prove the first- and second-moment estimates from the source lemmas, with exact hypotheses and constants.
6. Formalize the finite parameter construction/optimization from the relevant source section. A generic existence axiom for a suitable delta family is not an acceptable replacement.
7. Only then prove the strict sieve-sum bound and connect it to the odd-covering conclusion.

## Source anchors

- Balister, Bollobás, Morris, Sahasrabudhe, Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626: https://doi.org/10.2140/ant.2021.15.609
- Balister et al., *On the Erdős covering problem: the density of the uncovered set*, Inventiones Mathematicae 228 (2022), 377–414: https://doi.org/10.1007/s00222-021-01087-5
- Balister et al., *Erdős covering systems*, Acta Mathematica Hungarica 161 (2020), 540–549: https://doi.org/10.1007/s10474-020-01048-z

The papers above are source anchors for covering-system and hyperplane methods. They must not be assumed to contain the exact BBMST notation or parameter construction needed by the local Lean development without checking the precise target paper and section. In particular, the current local axioms remain unproved until a source-faithful derivation is formalized.
