# Source map: BBMST square-free theorem to a finite hyperplane model

Date: 2026-10-26

## Correction and source scope

This file was corrected after checking the published source. The broad claim that for arbitrary finite coordinate sets of size at least two every hyperplane cover contains parallel hyperplanes is too strong without the source's hypotheses. The precise theorem must be copied from Balister–Bollobás–Morris–Sahasrabudhe–Tiba, The Erdős–Selfridge problem with square-free moduli, Algebra & Number Theory 15 (2021), 609–626, arXiv:1901.11465.

Their Theorem 1.2 uses the specific coordinate sets S_k = [p_k+1], where p_k is the k-th prime, and states that any collection of nontrivial hyperplanes covering Q = S_1 × ... × S_n contains two parallel hyperplanes. Here a hyperplane A = A_1 × ... × A_n has each A_k either S_k or a singleton. Its fixed-coordinate set is F(A) = {k : A_k ≠ S_k}; nontrivial means F(A) is nonempty; parallel means equal fixed-coordinate sets.

The arithmetic consequence is the square-free-moduli theorem: a finite cover by progressions with distinct, odd, square-free moduli greater than 1 cannot cover Z. It does not by itself prove the unrestricted Erdős–Selfridge conjecture.

Primary sources:
- https://arxiv.org/abs/1901.11465
- https://par.nsf.gov/servlets/purl/10300177
- https://ora.ox.ac.uk/objects/uuid:3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s

## Finite geometric translation

Let p_k be the k-th prime and S_k = {0, ..., p_k}. Then |S_k| = p_k + 1. Let Q be their finite product.

Represent a hyperplane by a partial assignment:
- fixed is a Finset of coordinates;
- value gives one selected coordinate value for each fixed coordinate;
- coordinates outside fixed range freely over S_k.

Its fixed-coordinate set is exactly fixed. Two hyperplanes are parallel iff their fixed-coordinate sets agree. Nontriviality means fixed is nonempty.

Formalization tasks:
1. Define the coordinate-index type and finite product Q.
2. Define a partial assignment with dependent coordinate values.
3. Define its associated hyperplane as a Finset/set of points in Q.
4. Prove membership iff all fixed coordinates equal the assigned values.
5. Prove parallelism iff fixed-coordinate sets agree.
6. State the cover condition and the exact Theorem 1.2 with |S_k| = p_k + 1; do not generalize the theorem to arbitrary coordinate cardinalities without proof.
7. Formalize the CRT bridge from square-free moduli to this product box, including the finite prime universe and smoothness/truncation assumptions.
8. Compare the resulting arithmetic statement line by line with Theorem 1.1.

## Extension toward non-square-free moduli

Repeated prime factors require a richer coordinate model. A relevant route is to replace a prime coordinate F_p with a prime-power coordinate Z/p^gamma Z, whose subsets are cosets of p^ell Z/p^gamma Z. Not every hyperplane in the resulting product corresponds to an arithmetic progression, so the arithmetic-to-geometric map must be proved rather than assumed.

Recent preprint-level work by Ege Öztürk (August 2026) proposes a level-vector version of the sieve argument and a reduction of the square-freeness threshold from 73 to 37, while explicitly leaving the full Erdős–Selfridge problem open. See the companion audit document research/BBMST_RECENT_LEVEL_VECTOR_RESULTS_AUDIT_2026-10-26.md. Treat this as a research lead requiring independent reproduction, not as an established theorem until its proof and certificate are checked.

## Acceptance criteria

- The exact source hypotheses appear in the Lean theorem.
- No arbitrary-cardinality generalization is smuggled in.
- Every arithmetic/geometric correspondence is proved.
- Degenerate hyperplanes and empty fixed-coordinate sets are handled explicitly.
- The final transitive axiom audit is recorded.
- Any claim about arbitrary odd moduli remains explicitly open unless the prime-power extension is proved.

The current generic mass/fiber lemmas are infrastructure only. They do not prove the geometric theorem or the unrestricted Erdős–Selfridge conjecture.
