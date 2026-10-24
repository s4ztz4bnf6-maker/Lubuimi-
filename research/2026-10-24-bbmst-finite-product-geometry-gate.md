# BBMST: finite product geometry and proof obligations (2026-10-24)

Status: research note, not a proof of the main theorem.

The source proof represents a finite cyclic group through products of coordinate sets and uses hyperplanes to encode arithmetic progressions. It explicitly warns that not every hyperplane corresponds to an arithmetic progression when primes repeat. A faithful Lean model must preserve this distinction rather than identify the two notions by assumption.

The geometric core should be developed in layers: finite coordinate product; coordinate projection; fiber and fiber cardinality; hyperplane predicate; parallelism/codimension derived from coefficients; removed sets; and only then the probability/moment estimate. Each division by a cardinality must be guarded by a proof that the denominator is positive. Parameter lists must be aligned by construction, so empty-list vacuity cannot imply a strict sieve inequality.

The published square-free-moduli theorem proves that a covering system with distinct odd moduli cannot exist when all moduli are square-free. It does not settle the unrestricted distinct-odd-moduli Erdős problem. The current project's sieve axioms remain unproved and must not be treated as a certified main theorem.

Source leads: Balister, Bollobás, Morris, Sahasrabudhe, Tiba, The Erdős–Selfridge Problem with Square-Free Moduli, Algebra & Number Theory 15 (2021), 609–626; Oxford University Research Archive and the publisher version. This note records the source-fidelity gate; it adds no Lean theorem.