# Research note: carry-corrected valuation margin (2026-10-27)

## Scope and status

This is a candidate invariant for the Syracuse project, not a proof of Collatz convergence and not a claim of global novelty. It refines the exact affine-word identity already used in the project by making the additive carry/offset term visible in the descent criterion.

## Exact finite-word identity

Let an odd Syracuse orbit have valuations a_0,...,a_{k-1}, with
\[
 n_{j+1}=(3n_j+1)/2^{a_j},\qquad A_j=\sum_{i<j}a_i,
\]
and define C_0=0, C_{j+1}=3C_j+2^{A_j}. Then induction gives
\[
 2^{A_j}n_j=3^j n_0+C_j.
\]
Write D_k=2^{A_k}-3^k. If D_k>0, then
\[
 n_k<n_0 \iff C_k<D_kn_0.
\]
Dividing the exact identity by 3^k n_0 gives the equivalent logarithmic form
\[
 n_k<n_0
 \iff
 A_k-k\log_2 3 >
 \log_2\!\left(1+\frac{C_k}{3^k n_0}\right).
\]
The right-hand side is the offset/carry tax. Thus positive valuation surplus A_k-k log_2(3) alone is not the exact descent criterion; it must dominate this positive correction.

## Candidate certificate

Define
\[
 \mathcal L_k(n_0; a_0,\ldots,a_{k-1})
 = A_k-k\log_2 3
 -\log_2\!\left(1+\frac{C_k}{3^k n_0}\right).
\]
For a realized word, L_k>0 is exactly equivalent to n_k<n_0. This is a certificate for a finite block, not yet a one-step Lyapunov function: the correction depends on the starting value and the full word.

## Research question / falsifiable next step

Can the correction be bounded by a word-local quantity that composes under concatenation? More precisely, seek a computable bound B(w) for each valuation word w such that
\[
 \log_2(1+C_w/(3^{|w|}n_0))\le B(w)
\]
uniformly over all positive odd starts realizing w, and prove a concatenation law for the bound. If such a bound is too weak, produce explicit realized words showing why. The first Lean milestone should prove the exact equivalence above over integers/rationals and powers where possible, keeping logarithms out of the kernel theorem until the algebraic identity is established.

## Important non-implications

- Average valuation heuristics or negative expected logarithmic drift do not exclude exceptional positive-integer trajectories.
- A 2-adic limit point need not be a positive integer; compactness of Z_2 does not imply integer-orbit descent.
- The base-6 fact 3n+1 = 4 mod 6 for odd n proves immediate evenness, already known from parity. Division by 2 is not universally digitwise carry-free in base 6: higher digits contribute coefficients 3d_i, which may require carries.
- This note does not establish that any infinite orbit diverges or converges.

## Formal audit gates

1. Prove the affine identity by induction for every realized finite valuation word.
2. Prove the descent equivalence with explicit hypotheses D_k>0, n_0>0, and C_k>=0.
3. Audit the exact theorem with Lean's transitive axiom report; no sorry, admitted theorem, or project-specific axiom.
4. Test candidate word bounds by exact enumeration, treating computation as counterexample search rather than proof of the universal bound.
