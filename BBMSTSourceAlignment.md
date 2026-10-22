# BBMST source alignment: finite-product hyperplanes

## Source identity

The relevant source for the square-free Erdős–Selfridge problem is:

Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe, and Marius Tiba,
“The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory*
15 (2021), no. 3, 609–626. DOI: https://doi.org/10.2140/ant.2021.15.609.

Do not conflate this with the same authors' separate paper “On the Erdős covering
problem: the density of the uncovered set,” *Inventiones Mathematicae* 228 (2022),
377–414, DOI https://doi.org/10.1007/s00222-021-01087-5. The papers are related,
but their theorem numbering and claims are not interchangeable.

## Mapping to the Lean coordinate model

The source's finite-product setting has a product
\[
Q=S_1\times\cdots\times S_n.
\]
A coordinate hyperplane prescribes values on a nonempty set of coordinate indices
\(F(A)\), leaving the other coordinates free. Distinct non-parallel hyperplanes
have distinct fixed-coordinate sets. This gives the following intended mapping:

- CoordinateSpace n: the finite coordinate domains S i;
- CoordinatePoint space: a point of the product, represented as a dependent function;
- CoordinateHypersurface.fixed: the fixed-coordinate set F(A);
- CoordinateHypersurface.value: the prescribed allowed value at each fixed coordinate;
- CoordinateHypersurface.IsNontrivial: fixed.Nonempty;
- CoordinateHypersurface.NotParallel: inequality of the fixed-coordinate sets;
- Contains: membership in the coordinate hyperplane.

The overlap compatibility theorem is an exact incidence fact in this model:
if two hyperplanes share a point, their prescriptions agree on every shared fixed
coordinate. Conversely, because each coordinate domain is nonempty, compatible
prescriptions can be completed to a point of the product. The resulting
intersects_iff_agree_on_overlap theorem captures the intersection criterion for
these coordinate hyperplanes.

## What remains unproved

This source alignment does **not** by itself prove noCodimOneAt or the improved
second-moment bound. The audit must still define the precise codimension condition
used by the proof, show how the actual arithmetic configuration satisfies it, and
derive the moment estimate from the stated hypotheses. No such missing condition
may be introduced as an unconstrained input merely to make the theorem compile.

The CI checks are implementation checks for the Lean statements; they do not
replace this mathematical bridge.


## Audit update: theorem-level bridge required before claiming the cover result

The source's Theorem 1.2 is the correct geometric target: for S_k=[p_{k+1}], a cover of Q=product S_k by nontrivial coordinate hyperplanes must contain a parallel pair. The arithmetic conclusion follows only after the CRT encoding is proved in both directions. This is stronger and more specific than a generic statement about means or variance.

The proof's sieve state is not just a single random variable. Section 2 defines R_k as the uncovered part after the first k coordinate levels, N_k=F_k minus F_{k-1}, and B_k as the union of newly exposed hyperplanes. The measure P_k is changed along fibres to keep earlier B_i masses unchanged while controlling P_k(B_k). The parameters delta_k in [0,1/2] are part of that controlled transition, not arbitrary values supplied by an axiom.

### Lean obligations in dependency order

1. Define the finite product and hyperplanes exactly as in the paper; prove nontriviality means a nonempty fixed-coordinate set and nonparallelism means distinct fixed-coordinate sets.
2. Define R_k, N_k, B_k and prove R_k=R_{k-1} minus B_k, with the appropriate product/fibre lifting.
3. Formalize the fibre measure transition. Prove the removed and retained mass formulas with all endpoint cases, in particular alpha=0 and alpha=1, handled without division by zero.
4. Formalize the actual hypotheses and conclusions of Lemma 2.1 and Theorems 3.1/3.2 from the source, with exact index bounds and parameter constraints.
5. Reconstruct the Section 5 optimization/parameter construction, including its finite range 6<=k<=21, rather than replacing it with a generic existence assumption.
6. Only then derive the contradiction to R_n being empty, and prove the CRT translation back to distinct square-free moduli.

### Explicit anti-shortcut tests

- The case of an empty fixed-coordinate set must be excluded as the trivial progression Z.
- No unconstrained noCodimOne, isNontrivial, isParallel, codimOne, sieve_criterion, or sf_sieve_lt_one assumption may be used as a theorem substitute.
- A passing finite-mass or incidence test is only a lemma-level result. It is not evidence that the source's arithmetic optimization has been formalized.
- Every final axiom audit must be inspected for self-reference and unproved project axioms, not merely for sorryAx.

This is a proof-obligation map, not a claim that the missing steps have been implemented or kernel-checked.
