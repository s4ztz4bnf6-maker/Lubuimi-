# Finite valuation words as exact 2-adic cylinders: Syracuse audit note

Date: 2026-10-27

## Scope

This note records an exact finite-window structure for the accelerated odd Syracuse map
\[
T(n)=\frac{3n+1}{2^{v_2(3n+1)}}.
\]
It is a reduction tool, not a proof of global descent and not a novelty claim about 2-adic parity vectors.

## Affine carry recurrence

For a prescribed finite valuation word \(a_0,\ldots,a_{N-1}\), define
\[
A_0=0,\quad A_{t+1}=A_t+a_t,
\qquad R_0=0,\quad R_{t+1}=3R_t+2^{A_t}.
\]
Any integer trajectory realizing that word satisfies
\[
2^{A_t}n_t=3^t n_0+R_t\quad(0\le t\le N).
\]
The normalized correction
\[
c_t=R_t/2^{A_t}
\]
satisfies the rational recurrence
\[
c_0=0,\qquad c_{t+1}=\frac{3c_t+1}{2^{a_t}},
\]
and the exact decomposition
\[
n_t=\frac{3^t}{2^{A_t}}n_0+c_t.
\]
Consequently
\[
n_N<n_0\iff \left(1-\frac{3^N}{2^{A_N}}\right)n_0>c_N.
\]
This isolates multiplicative drift from the additive correction. The identity itself is not a descent theorem.

## Exact finite-window admissibility test

For a word to be realized by an odd integer start \(n_0\), every prefix must satisfy the exact valuation condition
\[
v_2(3^t n_0+R_t)=A_t\qquad(1\le t\le N).
\]
Equivalently, for each prefix,
\[
3^t n_0+R_t\equiv 2^{A_t}\pmod {2^{A_t+1}}.
\]
This prefixwise condition matters: a final divisibility condition alone does not certify all intermediate valuations.

Since \(3^t\) is invertible modulo every power of two, each exact prefix condition determines a single residue class modulo \(2^{A_t+1}\), when compatible with earlier prefixes. Thus the finite valuation word can be treated as a nested sequence of 2-adic cylinders. This is the right formal interface between an abstract valuation word and an actual orbit.

## Candidate new object: the realizable carry envelope

For each length \(N\) and start-size cutoff \(B\), define the finite admissible set
\[
\mathcal W_N(B)=\{(a_0,\ldots,a_{N-1}):\text{the exact prefix congruences hold for some odd }1\le n_0\le B\}.
\]
Define
\[
\mathcal C_N(B)=\max_{w\in\mathcal W_N(B)} c_N(w)
\]
when this set is nonempty. This is a finite, computable envelope, not yet a useful uniform theorem. Its research value is diagnostic: compare the unrestricted envelope over all words with the envelope over realizable words, then seek a symbolic upper bound that survives as \(B\to\infty\).

A useful proof would need a bound on the realizable correction that combines with
\[
\left(1-3^N/2^{A_N}\right)n_0>c_N
\]
to force descent for every sufficiently large positive start, or to rule out a divergent orbit. Numerical experiments can falsify candidate bounds, but cannot establish the required uniform result.

## Formalization tasks

1. Prove the affine identity and repeated-state lemma in Lean without project-specific axioms.
2. Formalize the prefixwise valuation characterization using integer divisibility and \(v_2\).
3. Prove the uniqueness of the residue class modulo \(2^{A_t+1}\) for each exact prefix.
4. Test small words and starts exhaustively; distinguish infeasible words from counterexamples to a conjectured bound.
5. Do not state a global Collatz result unless the carry-envelope bound is proved uniformly.

## Base-6 correction

For odd \(n\), \(n\equiv1,3,5\pmod6\), so \(3n+1\equiv4\pmod6\). This merely certifies evenness of the next ordinary Collatz value. Division by two in base six can still propagate carries through higher digits; the base change does not by itself provide a global Lyapunov function.
