# BBMST frontier update and route selection — 2026-10-26

## Scope and statement

The Erdős–Selfridge odd covering problem asks whether finitely many residue classes with pairwise distinct odd moduli greater than 1 can cover all integers. It remains open. The square-free-moduli case is known to be impossible (Balister–Bollobás–Morris–Sahasrabudhe–Tiba, 2021); this does not settle arbitrary odd moduli.

## Literature sweep: relevant recent frontier

Public sources inspected on 2026-10-26 report the following developments, which are external claims and have not been independently reproduced in this repository:

1. A July 2026 Lean formalization excludes odd distinct coverings with lcm <= 10,000. Its stated ingredients include the density/abundancy reduction, classification of odd abundant candidates below 10,000, and CRT-capacity certificates. The authors explicitly characterize the result as a finite exclusion, not a resolution.
2. A public August 2026 preprint by Ege Öztürk describes a symmetry-reduced fixed-lcm decision procedure and recursive “peeling” certificates; its abstract reports exclusion up to lcm 405,404. Treat the numerical scope as a paper claim until the artifact is independently checked.
3. A September 2026 public project by Michael Schroeder reports a lower bound of eight distinct prime divisors for any hypothetical odd distinct covering, with a Lean formalization, and says a specified scalar method cannot reach a nine-prime bound. Again, this is a literature claim, not a result proved by this repository.

## Consequence for this project

Do not spend further effort merely pushing the existing scalar route if its own exact constraints already conflict. A promising alternative architecture is:

- **Outer arithmetic filter:** only odd abundant candidate LCMs survive the density condition.
- **Symmetry quotient:** act on residue classes using affine automorphisms of Z/NZ and canonicalize equivalent instances before search.
- **Exact finite decision:** encode the remaining candidate moduli and residue classes as a finite covering problem; use SAT/ILP only to discover candidates or unsat cores, never as the trusted proof by itself.
- **Proof-carrying exclusion:** export a compact rational/integer certificate (e.g. recursive peeling plus local capacity inequalities), then check every arithmetic step with a small independent checker and formalize the certificate verifier in Lean.
- **Statement-fidelity gate:** formally bridge finite periodic covering modulo N to covering of Z, and ensure the moduli are distinct, odd, and >1.

## Immediate audit task

Compare our bbmst_rational_dual_check.py against the proof-carrying certificate format actually used by the recent covering-system work. It currently checks only a generic LP dual vector for one LP instance. It does not parse covering systems, prove the finite-to-infinite periodicity bridge, certify a complete candidate enumeration, or establish unsatisfiability of a covering instance. It must not be presented as a BBMST proof checker.

## Sources

- Erdős Problems, Problem 7: https://www.erdosproblems.com/7
- Lean-checked lcm > 10000 exclusions: https://arxiv.org/abs/2607.25628
- Öztürk, “A symmetry-reduced decision procedure and computational results for odd covering systems” (August 2026 preprint; public ResearchGate record): https://www.researchgate.net/publication/412316619_A_symmetry-reduced_decision_procedure_and_computational_results_for_odd_covering_systems_the_Erdos-Selfridge_problem_Erdos_Problem_7
- Michael Schroeder's project notes on 7-/8-prime lower bounds: https://michaelschroeder.ai/
- BBMST square-free case: https://doi.org/10.2140/ant.2021.15.609


## Implementation update — 2026-10-26

The exact finite-cover checker now has a bitset implementation. For period L and modulus m dividing L, the integer
`(2^L - 1) / (2^m - 1)`
has precisely the bits at positions 0,m,2m,...,L-m set. Shifting this mask by a normalized residue r encodes the full class r (mod m) inside [0,L). Bitwise OR therefore computes the union of the finite classes exactly, without floating-point arithmetic. The period cap remains important because bit-mask size grows with L.

A differential test file was added. In a separate local check, the bitset decision agreed with the definition-level scan on 1,049 small systems (moduli selected with repetition from {2,3,4,5}, up to three classes, all residue choices). This tests the implementation equivalence on that finite test family; it is not a universal proof of the implementation or a global exclusion result. The GitHub workflow associated with the regression-test commit was still running at the time of this update.

The new checker is deliberately scoped to verifying a proposed cover. The next proof-bearing extension should be a finite exclusion certificate format: canonical candidate LCM, symmetry representatives, exhaustive branch/peeling trace, and local capacity inequalities, each checked independently. Merely failing to find a cover in a search remains insufficient.
