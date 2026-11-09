# Syracuse valuation-carry ledger: exact cylinders before any drift claim

Date: 2026-10-27

## Research question

Our repeated failure point is not the affine algebra: it is the bridge from arbitrary valuation words to *realizable* integer trajectories, and then from finite block estimates to a universal bound. This note separates those obligations and proposes an exact, falsifiable intermediate structure: a valuation-carry ledger.

## 1. Exact affine ledger

For an odd Syracuse trajectory
\[
x_{j+1}=\frac{3x_j+1}{2^{a_j}},\qquad a_j=v_2(3x_j+1)\ge1,
\]
put
\[
A_0=0,\quad A_{k+1}=A_k+a_k,
\qquad C_0=0,\quad C_{k+1}=3C_k+2^{A_k}.
\]
Induction gives the exact identity
\[
2^{A_k}x_k=3^k x_0+C_k.
\]
This identity is valid for a realized orbit; by itself it does not prove that an arbitrary word (a_j) is realizable.

## 2. Exact-cylinder target

For a finite word w=(a_0,...,a_{L-1}) of positive integers, define its cylinder as the set of odd positive x_0 whose first L accelerated valuations are exactly w.

The proposed finite-cylinder lemma is:

> For every word w of length L, its exact valuation cylinder among odd integers is either empty for positivity/domain reasons, or is one residue class modulo 2^(A_L+1), where A_L=sum a_j.

This must be proved from the inverse branches and exact valuation conditions, not assumed from the affine identity. In particular, merely imposing divisibility by 2^A_L is insufficient: exact valuation at the last stage needs the next bit as well. Once proved, the lemma gives a clean separation: the residue class is a finite, exact arithmetic object; positivity of all intermediate iterates is checked separately; growth over the block is determined by the affine identity.

The word-cylinder lemma is a proof target here, not yet a certified Lean theorem. Any implementation should test small words exhaustively against direct iteration before being used in a proof.

## 3. Block growth certificate

For a realized word of length L,
\[
x_L=\frac{3^L x_0+C_L}{2^{A_L}}.
\]
Hence a block contracts in ordinary size exactly when
\[
(3^L-2^{A_L})x_0+C_L<0.
\]
This is an exact integer inequality; it does not use floating-point logarithms. If 3^L <= 2^A_L, the affine coefficient is nonpositive, but the offset C_L remains positive, so that condition alone does not imply contraction. Conversely, a block with 3^L > 2^A_L has a positive coefficient and may still contract for sufficiently small x_0 because of the offset. The exact condition must retain both terms.

This is the useful correction to a valuation-only Lyapunov function: the total valuation A_L is not enough; the carry/offset C_L and the starting scale jointly determine the block result.

## 4. Proposed carry-aware potential

Use the state
\[
\mathcal L_L=(L,A_L,C_L,x_0),
\]
and the exact endpoint ratio
\[
\mathcal R_L=\frac{3^Lx_0+C_L}{2^{A_L}x_0}.
\]
Then x_L/x_0=R_L. A proposed block Lyapunov certificate must prove R_L<1 for some covering family of blocks or show that products of block ratios cannot support divergence. No such universal covering or bound is established in this note.

The offset obeys an exact concatenation rule. If a word u has length r, cumulative valuation A_u and offset C_u, and a following word v has length s and offset C_v (computed from its own local cumulative valuations), then the concatenated offset is
\[
C_{uv}=3^s C_u+2^{A_u}C_v,
\]
and A_uv=A_u+A_v. This identity is an algebraic invariant that lets blocks be composed without losing carry information. It is a better research object than entropy alone: it retains the exact affine effect of every carry while allowing block concatenation.

## 5. Falsification and formalization plan

1. Enumerate short valuation words and solve the exact congruence conditions for their cylinders.
2. Compare the predicted cylinder with direct iteration over complete residue systems modulo 2^(A_L+1).
3. Check the affine endpoint identity with integer arithmetic on every realized representative.
4. Search for candidate universal block inequalities; retain counterexamples, not just successful samples.
5. Formalize the cylinder lemma, concatenation identity, and endpoint criterion in Lean before claiming a drift theorem.
6. A global conclusion still requires a proof that every possible divergent orbit is excluded. Finite cylinders and successful finite searches alone cannot do this.

## Status

The affine identity is already represented in SyracuseAffineRecurrence.lean. The cylinder characterization and carry-aware universal drift bound remain unproved targets. This note claims no Collatz solution and makes no novelty claim about valuation cylinders in the literature; its proposed contribution is the explicit coupling of exact cylinders, the affine offset, and block composition into one audit interface.
