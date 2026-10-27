# Source-faithful BBMST bridge: fiber moments and union-of-fixed-coordinates

Date: 2026-10-27

## Primary source and exact target

Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), pp. 609–626, DOI 10.2140/ant.2021.15.609.

The relevant chain is Section 2, equations (2)–(6), then Theorem 3.1 and Theorem 3.2, with Lemmas 3.3–3.4. Theorem 3.1 alone is not the hard geometric step. The source-specific bridge is the moment estimate in Theorem 3.2.

For a finite product \(Q=S_1\times\cdots\times S_n\), let \(R_k\) be the points not covered by hyperplanes exposed by stage \(k\), and let \(B_k\) be the union of newly exposed hyperplanes at stage \(k\). For each prefix \(x\in Q_{k-1}\), define the fiber-removal fraction
\[
\alpha_k(x)=\frac{|\{y\in S_k:(x,y)\in B_k\}|}{|S_k|}.
\]
The measure \(P_k\) is reweighted fiber-by-fiber so that all earlier \(Q_i\)-measurable sets preserve their mass, while the new removed mass is controlled. The zero-fiber / zero-mass cases in the piecewise definition of \(P_k\) are part of the theorem, not optional implementation details.

Set
\[
M_k^{(1)}=\mathbb E_{k-1}[\alpha_k],\qquad
M_k^{(2)}=\mathbb E_{k-1}[\alpha_k^2].
\]
Theorem 3.1 gives the sufficient criterion
\[
\sum_{k=a+1}^{n}\min\left(M_k^{(1)},
\frac{M_k^{(2)}}{4\delta_k(1-\delta_k)}\right)<1
\]
for the hyperplanes not to cover \(Q\).

## The missing geometric bridge

Define \(c(I)\) as the maximal initial measure of a hyperplane whose fixed-coordinate set is \(I\subseteq[a]\), and
\[
\nu(J)=\prod_{j\in J}\frac{1}{(1-\delta_j)|S_j|}.
\]
The source defines
\[
c_k(x)=\sum_{I\subseteq[a]}\sum_{J\subseteq[a+1,k]}
c(I)\nu(J)x^{|I|+|J|}
=\sum_{I\subseteq[a]}c(I)x^{|I|}
\prod_{j=a+1}^{k}\left(1+\frac{x}{(1-\delta_j)|S_j|}\right).
\]
Theorem 3.2 then proves
\[
M_k^{(1)}\le\frac{c_{k-1}(1)}{|S_k|},\qquad
M_k^{(2)}\le\frac{c_{k-1}(3)}{|S_k|^2}.
\]
If no newly exposed hyperplane has codimension one, it improves the second bound to
\[
M_k^{(2)}\le
\frac{c_{k-1}(3)-2c_{k-1}(1)+1}{|S_k|^2}.
\]

The proof goes through Lemma 3.4: expand \(\alpha_k(x)^t\) using the union bound over new hyperplanes, then bound intersections by the hyperplane whose fixed-coordinate set is the **union** of the original fixed-coordinate sets. The factors \(2^{|I|+|J|}\) and \(3^{|I|+|J|}\) count the ordered tuples of sets whose union is a given set. This is the exact combinatorial source of the polynomial evaluation \(c_{k-1}(2^t-1)\).

## Lean work order

1. Define finite products and hyperplanes with explicit fixed-coordinate sets; prove that intersections are empty or have fixed set equal to the union.
2. Define \(\alpha_k\) as a rational-valued fiber cardinality. Prove \(0\le\alpha_k\le1\) and explicitly cover empty fibers.
3. Formalize the piecewise \(P_k\) reweighting and prove (4)–(6) before any global summation.
4. Prove the finite tuple-union counting identity for \(t=1,2\) first; generalize to arbitrary \(t\) only after the small cases compile.
5. Prove Theorem 3.2 from Lemma 3.4; include the codimension-one-free refinement as a separate lemma with its hypothesis explicit.
6. Only then connect Theorems 3.1 and 3.2 to the global covering contradiction.

## Audit conclusion

The generic second-moment identity is not the decisive missing lemma. The actual gap is the source-faithful derivation of the \(c_k(1)\), \(c_k(3)\), and refined \(c_k(3)-2c_k(1)+1\) bounds from hyperplane intersections and the union-of-fixed-coordinate combinatorics, while preserving the weighted measures correctly. Do not replace these steps by free predicates named isParallel, codimOne, or sieve_criterion that encode the desired result.

This note is a source-mapping and formalization plan, not a claim that the global Erdős–Selfridge theorem has been proved by the current Lean project.
