# Next proof milestone: exact finite certificates for BBMST

Date: 2026-10-25

Status: research design and source map; not a proof of the unrestricted Erdős–Selfridge conjecture and not a claim that the existing sieve axioms have been discharged.

## New concrete direction

Separate the computation that discovers a useful finite configuration from the mathematical certificate that verifies it.

The 2021 paper's supplemental material provides source code and outputs for the finite configuration search and the rational parameter bounds. Reuse that material as a *certificate generator*, but make the Lean development consume only exact finite data and rational inequalities. A floating-point optimizer result is not itself a proof.

Primary references:
- Published paper: Balister, Bollobás, Morris, Sahasrabudhe, Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), 609–626. https://doi.org/10.2140/ant.2021.15.609
- Oxford record and version of record: https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25
- Authors' supplemental programs and outputs: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html

## Certificate pipeline

1. **Freeze the source instance.** Record the exact upstream source revision, input configuration, and generated output. Treat any optimizer as untrusted.
2. **Normalize all data to integers/rationals.** Every claimed coefficient and bound entering Lean must be an exact rational number. If an LP solver returns decimals, recover a rational candidate and independently verify every constraint exactly.
3. **Verify the certificate, not the optimizer.** For each finite LP witness, check all constraints and the objective bound by exact rational arithmetic. The checker must not import the optimizer or trust its status flag.
4. **Connect certificate to the paper's combinatorial object.** Prove that the indexed finite configuration is exhaustive for the specified parameter range, and that its entries encode the intended hyperplane incidences and moment bounds.
5. **Prove the local probability statement.** Keep zero-mass fibers separate. Define fiber masses as finite sums over explicit subsets, prove disjointness/coverage, and only divide after a positivity proof.
6. **Assemble the arithmetic conclusion.** The finite certificate is only one dependency. The exact recurrence, prime-range split, and hypotheses of Theorems 3.1/3.2 and Section 5 must still be formalized and linked to the target statement.

## Why this is a real improvement

It reduces the trusted computing base: search and optimization may be heuristic, but the final finite witness is checked using exact arithmetic. It also makes failures diagnosable: an incorrect LP result fails at a specific constraint rather than being hidden inside a theorem-level axiom.

## Required failure conditions

- No missing list entry may silently become zero.
- No quotient may be used without proving its denominator positive.
- The improved moment estimate must carry the source's geometric hypotheses; it cannot be inferred from arbitrary numeric arrays.
- The target theorem's transitive dependencies must be inspected with `#print axioms`; any remaining sieve axiom must be reported explicitly.
- A successful build is evidence only for the exact Lean proposition that compiled. Statement fidelity to the published theorem is a separate review gate.

## Immediate deliverable

Implement a small rational-certificate checker for one published finite configuration before attempting the full theorem. Record the exact input/output and prove each constraint. Do not claim a new result until the verified certificate is connected to the source theorem.
