# Exact valuation cylinders: derivation and falsification protocol

Date: 2026-10-27  
Status: mathematical research specification; not Lean-checked and not a Collatz proof.

## 1. Fix the exact convention

Use the accelerated odd Syracuse map
\[
T(n)=\frac{3n+1}{2^{v_2(3n+1)}}\qquad(n>0\text{ odd}).
\]
A finite valuation word is \(w=(a_0,\ldots,a_{k-1})\), with every \(a_j\ge1\). Define
\[
A_0=C_0=0,\quad A_{j+1}=A_j+a_j,\quad
C_{j+1}=3C_j+2^{A_j}.
\]
For an initial integer \(n\), put \(N_j(n)=3^j n+C_j\). The recurrence gives
\[
N_{j+1}(n)=3N_j(n)+2^{A_j}.
\]

## 2. Exact congruence test

The affine identity is
\[
2^{A_j}n_j=N_j(n)=3^j n+C_j
\]
whenever the word is realized. At step \(j\), exact valuation \(a_j\) is equivalent to
\[
v_2(3n_j+1)=a_j
\iff
N_{j+1}(n)\equiv 2^{A_{j+1}}\pmod{2^{A_{j+1}+1}}.
\]
The right side is the exact-valuation condition, not merely divisibility by \(2^{A_{j+1}}\). Because \(3^{j+1}\) is invertible modulo every power of two, this condition determines one residue class of \(n\) modulo \(2^{A_{j+1}+1}\):
\[
n\equiv (3^{j+1})^{-1}
(2^{A_{j+1}}-C_{j+1})
\pmod{2^{A_{j+1}+1}}.
\]

Since each \(a_j\ge1\), the exponents \(A_{j+1}+1\) strictly increase. The nested conditions determine at most one residue class modulo \\(2^{A_k+1}\\). For the standard accelerated Syracuse map, every finite word with all \\(a_j\\ge1\\) is realizable: the conditions are automatically compatible, by induction using \\(N_{j+1}=3N_j+2^{A_j}\\) and the fact that 3 is invertible modulo powers of two. Thus the cylinder is never empty for a valid positive valuation word. It is a canonical encoding of the word, not a pruning mechanism that eliminates arbitrary words. An implementation that reports an empty cylinder for such a word has a bug in its recurrence, modulus, or residue calculation.

For a positive odd \(n\), satisfaction of all these congruences implies the word is realized: inductively \(N_j(n)/2^{A_j}\) is a positive odd integer and the recurrence gives the prescribed Syracuse step. Conversely, every realized word satisfies every congruence. Positivity must be stated when converting the congruences into an orbit of positive integers.

## 3. Important implementation correction

Do not encode the condition only as
\[
N_{j+1}(n)\equiv0\pmod{2^{A_{j+1}}}.
\]
That proves divisibility, but it does not prove the valuation is exactly \(A_{j+1}\). The extra residue bit
\[
N_{j+1}(n)\not\equiv0\pmod{2^{A_{j+1}+1}}
\]
is essential; the compact equivalent is congruence to \(2^{A_{j+1}}\) modulo \(2^{A_{j+1}+1}\).

## 4. Concrete falsification protocol

For every word length \(k\) in a bounded test range:

1. Enumerate words with \(1\le a_j\le L\).
2. Compute \(A_j,C_j\) using exact integers.
3. Compute each residue condition modulo \(2^{A_{j+1}+1}\).
4. Intersect conditions from the largest modulus downward; reject immediately if the top residue fails any lower congruence.
5. Compare all positive odd starts below a chosen bound against direct exact iteration.
6. Preserve the smallest mismatch as a regression test.

A finite search can falsify a faulty characterization, but it cannot prove the universal theorem. The finite-word cylinders are all nonempty for valid words, so enumeration of arbitrary words does not shrink the set of possible valuation patterns. The useful value is instead an exact arithmetic encoding of every word and a way to study how the affine offset (C_k) behaves on that residue class.

## 5. Next Lean obligations

Formalize these as separate lemmas, in this order:

1. offset_recurrence: \(N_{j+1}=3N_j+2^{A_j}\).
2. exact_v2_iff_mod: for positive \(N\), \(v_2(N)=A\) iff \(N\equiv2^A\pmod{2^{A+1}}\).
3. word_condition_residue: multiplication by \(3^j\) gives one residue class modulo \(2^{A_j+1}\).
4. cylinder_compatibility: prove that the nested congruences are automatically compatible for every word with (a_j\ge1), and that the largest-modulus residue implies every earlier condition.
5. word_realization_iff: exact congruences are equivalent to realization of the prescribed finite word.

Keep the exact affine identity independent of the congruence theorem. Run a transitive axiom audit on the final theorem and compile with the repository's pinned Lean/Mathlib toolchain before calling it verified.

## 6. Exact descent threshold on a valuation cylinder

For a word of length \(k\), put
\[
D_w=2^{A_k}-3^k.
\]
For every start \(n\) in its cylinder, the affine identity gives
\[
n_k<n\iff C_k<D_w n.
\]
Consequently:

- If \(D_w\le0\), no positive start realizing this word descends at its endpoint, because \(C_k>0\).
- If \(D_w>0\), descent holds exactly when \(n>C_k/D_w\).
- If the cylinder is represented by its least positive odd residue \(r_w\) modulo \(M_w=2^{A_k+1}\), all its positive starts are \(r_w+qM_w\), \(q\ge0\). Hence every sufficiently large member of this cylinder descends for this fixed word; the exact exceptional candidates are the finitely many \(q\) satisfying \(r_w+qM_w\le C_k/D_w\).

This is a sharper finite certificate than an average-drift heuristic. It also identifies the actual global bottleneck: one must show that for every odd \(n>1\), some prefix of its own realized valuation word has \(D_w>0\) and crosses the exact threshold \(C_w<D_w n\). Once a lower iterate is proved, strong induction would reduce the starting value repeatedly until 1. Establishing that universal prefix property is still the hard Collatz problem; the cylinder identity does not establish it by itself.

## 7. What this does not solve

This makes finite-word realization exact, but also removes a hoped-for shortcut: no valid positive valuation word can be discarded as unrealizable. The substantive global problem remains to prove a useful uniform bound on the affine offset/descent margin across realized words, or to use the residue-class structure to classify return words. It does not rule out nontrivial cycles or prove that every orbit reaches 1. The global Collatz step remains open.
