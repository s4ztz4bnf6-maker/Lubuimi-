# BBMST Theorem 3.2: source-faithful formalization plan

Date: 2026-10-26

## Pinned source
Balister, Bollobás, Morris, Sahasrabudhe, Tiba, “The Erdős–Selfridge problem with square-free moduli,” Algebra & Number Theory 15 (2021), 609–626, DOI 10.2140/ant.2021.15.609. The publisher-version PDF is preserved at https://par.nsf.gov/servlets/purl/10300177.

Theorem 1.1 states the square-free-moduli result. The general geometric statement is Theorem 1.2: for finite coordinate sets S_i with at least two elements, every cover of the product box by nontrivial hyperplanes contains two parallel hyperplanes. “Nontrivial” means at least one fixed coordinate; “parallel” means having the same set of fixed coordinate indices. The source excludes the trivial progression Z and excludes modulus 1 in Theorem 1.1.

## Exact finite definitions
Let Q_k=S_1×...×S_k. A hyperplane is encoded by a vector whose i-th coordinate is either a singleton value in S_i (fixed) or a star (free). For each hyperplane H, F(H) is its set of fixed coordinates. Nontriviality is F(H)≠∅; nonparallelity of a family means distinct hyperplanes have distinct F(H).

For the exposed family at level k, let N_k be the new fixed-coordinate sets whose maximum index is k, let B_k be the union of the corresponding hyperplanes, and let R_k be the uncovered remainder after level k. These definitions should be represented directly in Lean; do not replace them with free predicates such as `isNontrivial`, `isParallel`, or `codimOne` without defining and proving their equivalence to the source definitions.

For each x in Q_{k-1}, the source defines the removed fiber proportion

α_k(x) = |{y∈S_k : (x,y)∈B_k}| / |S_k|.

The first and second moments are M_k^(1)=E_{k-1}[α_k] and M_k^(2)=E_{k-1}[α_k^2]. Theorem 3.2 gives M_k^(1) ≤ c_{k-1}(1)/|S_k| and M_k^(2) ≤ c_{k-1}(3)/|S_k|². If none of the new hyperplanes has codimension one, it gives the sharper bound

M_k^(2) ≤ (c_{k-1}(3)-2c_{k-1}(1)+1)/|S_k|².

The proof explicitly handles codimension-one hyperplanes by removing them and deleting their fixed value from the relevant coordinate set before applying the sharper estimate. This is a semantic step, not an optional optimization.

## Lean decomposition
1. Define finite products, hyperplanes, fixed-coordinate sets, and source predicates.
2. Define B_k and the fiber incidence count exactly.
3. Prove α_k is rational and lies in [0,1]; define expectation over the finite probability measure.
4. Prove the first-moment bound from incidence counting.
5. Prove the second-moment bound by expanding α² as a pair count, retaining diagonal and off-diagonal terms explicitly.
6. Prove the no-codimension-one refinement, including the source's coordinate-deletion construction.
7. Only then formalize Theorem 3.1's mass bound and the sum-<1 uncovered-point conclusion.
8. Finally connect the geometric theorem to square-free arithmetic progressions via a source-faithful CRT equivalence.

## Audit traps
- Empty products and the case a=0 are explicitly permitted in the source's probability construction; handle them intentionally.
- Every coordinate set has cardinality at least two before the codimension-one deletion step. After deletion, a coordinate may shrink; the exact lower-bound hypotheses must be checked.
- `ℚ` division is totalized in Lean; prove nonzero denominators before using field identities.
- A sum bound `<1` proves a nonempty remainder only after the probability normalization and the levelwise measure-preservation identities are established.
- Theorem 1.2 is not the unrestricted Erdős–Selfridge conjecture; preserve the square-free scope when translating back to moduli.

## Status
This file records a source-faithful proof plan extracted from the published theorem and definitions. It is not a Lean implementation, compilation result, or proof of Theorem 1.1.