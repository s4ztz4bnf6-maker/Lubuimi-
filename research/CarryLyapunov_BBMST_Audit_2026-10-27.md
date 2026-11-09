# Research note: carry-corrected Lyapunov search and BBMST axiom elimination
Date: 2026-10-27

This note records a research direction, not a claimed solution of either open global problem.

## A. Syracuse: exact block arithmetic

For the accelerated odd Syracuse map
\[
S(x)=(3x+1)/2^{v_2(3x+1)},\qquad x\text{ odd},
\]
write a realized block as \(x_{i+1}=(3x_i+1)/2^{a_i}\), where \(a_i=v_2(3x_i+1)\ge 1\). Put \(A_k=\sum_{i<k}a_i\). Iterating the affine recurrence gives
\[
2^{A_k}x_k=3^k x_0+C_k,
\]
where \(C_0=0\) and \(C_{k+1}=3C_k+2^{A_k}\). In particular, \(C_k>0\) for \(k\ge1\).

If \(x_k<x_0\), then necessarily \(3^k<2^{A_k}\). More precisely,
\[
x_k<x_0\iff (2^{A_k}-3^k)x_0>C_k.
\]
Thus the valuation sum condition is necessary, but by itself not sufficient for descent at a given starting value; the affine correction term matters.

## B. Candidate: carry-corrected logarithmic potential

The uncorrected potential \(V_0(x)=\log x\) has exact one-step increment
\[
V_0(S(x))-V_0(x)=\log(3+1/x)-a\log 2,
\quad a=v_2(3x+1).
\]
For large \(x\), the increment is approximately \(\log 3-a\log 2\). For uniformly sampled odd residue classes, the valuation distribution is \(\Pr(a=j)=2^{-j}\) for \(j\ge1\), hence \(\mathbb E[a]=2\) and the corresponding heuristic mean increment is \(\log 3-2\log 2=\log(3/4)<0\).

This is only a residue-class average. It does **not** imply that the valuations along each deterministic orbit have that average. The missing global step is control of correlations and exceptional valuation words.

A concrete synthesis program is to search for a bounded residue/carry correction \(\phi\) and block length \(k\) such that
\[
V(x)=\log x+\phi(\text{finite carry state of }x)
\]
has a rigorously certified negative block increment for every sufficiently large admissible state, or at least a finite cover of states with a well-founded descent relation. The state must retain enough 2-adic information to determine each valuation and the next state; truncating \(v_2\) without a sound treatment of longer valuations is invalid.

A finite-state linear-programming search can propose inequalities for \(\phi\), but a successful finite search is only a conjecture until the abstraction is proved sound for all integers. If no potential exists for a chosen abstraction, that refutes the certificate in that abstraction, not the Collatz conjecture.

## C. BBMST / Erdős–Selfridge: proof obligation discipline

The priority is to remove any under-specified sieve axiom (notably a placeholder such as sieve_criterion) by deriving the criterion from the source-faithful finite probability-space and incidence definitions. Keep these obligations separate:

1. define the finite sample space and normalization;
2. prove partition/fiber mass conservation, including empty fibers;
3. handle boundary cases (including zero parameters) before any division;
4. derive the exact incidence and moment bounds used by the cited theorem;
5. derive the sieve inequality from those bounds, rather than assuming it;
6. run a transitive axiom audit on the final theorem and compare its statement to the paper.

A CI pass or an axiom list limited to Lean's foundational axioms is not sufficient if a domain-specific theorem was postulated as an axiom upstream. The final theorem must not depend on that postulate.

## Status

No global Collatz descent theorem is claimed here. No complete BBMST theorem is claimed here. The note identifies exact algebraic obligations and a falsifiable certificate-search strategy intended to turn the recurring audit failures into explicit proof obligations.
