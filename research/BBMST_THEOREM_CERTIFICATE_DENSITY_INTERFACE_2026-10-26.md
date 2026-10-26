# BBMST: theorem-to-certificate interface and quantitative density audit

Date: 2026-10-26
Status: research specification; no claim that the external rank-nine proof has been rebuilt or that a new Lean theorem has been checked.

## Why this interface matters

The rank-nine theorem and its quantitative corollaries are stronger than an individual finite-cover search. A finite checker can certify a proposed family or compute its uncovered density, but it cannot establish a universal theorem for all finite families. This note separates those roles and specifies an auditable interface between them.

## Exact finite-family object

Let m_1,...,m_r be positive moduli and L=lcm(m_1,...,m_r). A family of residue classes a_i (mod m_i) covers the integers exactly when every residue x in {0,...,L-1} satisfies x mod m_i = a_i for at least one i. Let U be the number of residues not covered. Then the uncovered natural density exists and equals

    delta = U/L.

Proof: the cover is periodic modulo L, and each block of L consecutive integers contains exactly U uncovered integers. For an interval of length qL+s, the uncovered count is qU plus a remainder between 0 and s; divide by qL+s and let q tend to infinity.

This exact periodicity proof is a clean bridge between finite certificate checking and the density language used by quantitative corollaries.

## Proposed checker output schema

A certificate checker should emit, in machine-readable form:

- the ordered list of moduli and residues;
- the pairwise-distinct and odd/>1 predicate results;
- the exact LCM L and its prime factorization, independently recomputed;
- the covered-residue count and uncovered-residue count U;
- the reduced rational U/L;
- whether U/L >= 1/1,002,375, compared by integer cross multiplication;
- the artifact hash, checker version, and deterministic execution parameters.

For the final comparison, avoid floating-point arithmetic: test `1_002_375 * U >= L` exactly.

## Theorem interface for the external result

The external theorem has two logically distinct outputs:

1. If the family is a cover and all moduli are pairwise distinct odd integers >1, then the LCM has at least nine distinct prime divisors.
2. For a finite family of pairwise distinct odd moduli >1 supported on at most eight primes, the uncovered density is at least 1/1,002,375.

The second output is not a direct consequence of the first. It requires the additional quantitative argument and must be audited as a separate theorem with its own transitive dependencies.

## Candidate exclusions already available

The three previously explored candidate LCMs factor as

- 10395 = 3^3 * 5 * 7 * 11;
- 12285 = 3^3 * 5 * 7 * 13;
- 17325 = 3^2 * 5^2 * 7 * 11.

Each has only four distinct prime factors. Once the external theorem is independently reproduced with matching hypotheses, a cover with any of these LCMs is impossible. This does not rule out covers with larger LCM and more prime support, so it is not a solution of the full Erdős–Selfridge conjecture.

## New trust gate from the 2026 Lean reliability discussion

The trust decision is layered, not binary:

- Artifact integrity: exact archive and hash.
- Build reproducibility: pinned toolchain and dependencies on a clean checkout.
- Kernel acceptance: all declarations checked by the specified kernel.
- Axiom audit: transitive assumptions explicitly enumerated; classical choice/propext/quotient soundness are distinguished from project-specific unproved axioms.
- Statement fidelity: all integers are covered, moduli are pairwise distinct, odd and >1, and prime-power exponents are unrestricted.
- Independent validation: integer certificates checked by a small separate program; ideally proof objects cross-checked by a differently implemented kernel.

No single layer substitutes for the others. In particular, a clean `#print axioms` output cannot compensate for a false or weakened theorem statement, and a source hash cannot establish mathematical correctness.

## Next executable task

Extend `bbmst_finite_cover_certificate_check.py` to emit the exact schema above and add adversarial tests for (a) duplicated moduli, (b) even moduli, (c) modulus 1, (d) incorrect residues, (e) a family with U=0, and (f) exact equality at the density threshold. Keep this finite checker logically separate from the universal rank-nine theorem.