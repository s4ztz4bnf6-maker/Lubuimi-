# A monotonicity obstruction for the scalar CRT moment criterion

Date: 2026-11-09

Status: exact mathematical obstruction to the **uniform scalar moment criterion**; not a counterexample to the Erdős–Selfridge conjecture and not a covering system.

## 1. The criterion being tested

For square-free
\[
M=\prod_{p\in P}p,
\]
the arbitrary-exponent one-prime CRT moment argument uses
\[
B(M)=M-\sum_{\substack{d\mid M\\d>1}}\frac Md
     =2M-\sigma(M),
\]
\[
T_k(M)=\sum_{d_1,\ldots,d_k\mid M}
       \frac{M}{\operatorname{lcm}(d_1,\ldots,d_k)}
       =\prod_{p\in P}(p+2^k-1),
\]
and
\[
H_A(q)=\sum_{b=1}^{A}q^{-b}.
\]
A sufficient condition for excluding every distinct cover whose moduli divide \(Mq^A\) is
\[
T_k(M)H_A(q)^k < B(M)
\tag{1}
\]
for at least one integer \(k\ge1\). The project note
[ARBITRARY_EXPONENT_CRT_FOURTH_MOMENT_2026-11-02.md](ARBITRARY_EXPONENT_CRT_FOURTH_MOMENT_2026-11-02.md)
records the proof of (1).

The point here is that increasing the moment order does **not** always improve this scalar bound.

## 2. General monotonicity lemma

**Lemma.** Let \(M=\prod_{p\in P}p\) be square-free, let \(q\nmid M\) be prime, and let \(A\ge1\). Put
\[
F_k(M,q,A):=T_k(M)H_A(q)^k.
\]
If
\[
H_A(q)\prod_{p\in P}\frac{p+3}{p+1}>1,
\tag{2}
\]
then \(F_{k+1}>F_k\) for every \(k\ge1\).

If, in addition,
\[
H_A(q)\sigma(M)\ge B(M),
\tag{3}
\]
then no moment order \(k\ge1\) can satisfy (1).

**Proof.** Since \(T_k(M)=\prod_{p\in P}(p+2^k-1)\),
\[
\frac{F_{k+1}}{F_k}
=H_A(q)\prod_{p\in P}
  \frac{p+2^{k+1}-1}{p+2^k-1}.
\]
For fixed \(p>1\), the function
\[
x\longmapsto \frac{p+2x-1}{p+x-1}
=1+\frac{x}{p+x-1}
\]
is increasing for \(x>0\), because the derivative of the second term is
\((p-1)/(p+x-1)^2>0\). As \(2^k\ge2\), every factor is at least its value at \(x=2\). Hence
\[
\frac{F_{k+1}}{F_k}
\ge H_A(q)\prod_{p\in P}\frac{p+3}{p+1}>1,
\]
proving strict monotonicity. Also
\[
F_1=H_A(q)T_1(M)=H_A(q)\sigma(M).
\]
Condition (3) gives \(F_1\ge B(M)\); monotonicity then gives
\(F_k\ge B(M)\) for every \(k\). Thus the strict sufficient inequality (1)
fails at every order. \(\square\)

A convenient exponent-uniform sufficient version follows from
\[
H_A(q)\ge q^{-1}.
\]
It is enough that
\[
\frac1q\prod_{p\in P}\frac{p+3}{p+1}>1,
\qquad
\frac{\sigma(M)}q\ge B(M).
\tag{4}
\]

## 3. Exact obstruction at the smallest nine-prime support

Take
\[
q=3,\qquad
P=\{5,7,11,13,17,19,23,29\}.
\]
Then the full prime support \(P\cup\{3\}\) is the first nine odd primes, i.e. the smallest possible support left by a nine-prime lower bound.

The exact values are
\[
M=1,078,282,205,
\qquad
\sigma(M)=2,090,188,800,
\]
\[
B(M)=2M-\sigma(M)=66,375,610.
\]
Furthermore
\[
\prod_{p\in P}\frac{p+3}{p+1}
=\frac{2288}{729},
\]
so, for every \(A\ge1\),
\[
H_A(3)\prod_{p\in P}\frac{p+3}{p+1}
\ge \frac13\cdot\frac{2288}{729}
=\frac{2288}{2187}>1.
\]
Also
\[
F_1=H_A(3)\sigma(M)
\ge\frac{2,090,188,800}{3}
=696,729,600
>66,375,610=B(M).
\]
The lemma therefore gives the exact conclusion
\[
\boxed{T_k(M)H_A(3)^k>B(M)
\quad\text{for every }A\ge1\text{ and every }k\ge1.}
\]
Thus no choice of scalar moment order in criterion (1) excludes the
entire family of exponent boxes
\[
3^A\cdot5\cdot7\cdot11\cdot13\cdot17\cdot19\cdot23\cdot29,
\qquad A\ge1.
\]

This is a method obstruction only. It does **not** construct a covering system.
For \(A=1\), the square-free-moduli theorem already rules out a cover. For
\(A\ge2\), this calculation leaves the corresponding repeated-3-power
support unresolved by criterion (1).

## 4. What the obstruction says about the next step

The loss occurs at the estimate
\[
\left|C_{b_1,d_1}\cap\cdots\cap C_{b_k,d_k}\right|
\le \frac{M}{\operatorname{lcm}(d_1,\ldots,d_k)}.
\]
The scalar constant \(T_k(M)\) acts as if every ordered tuple of projected
residue classes were compatible. In the actual system, the intersection is
zero unless the residues satisfy the generalized CRT compatibility
conditions
\[
a_i\equiv a_j\pmod{\gcd(d_i,d_j)}
\qquad(1\le i,j\le k).
\]
When they are compatible, the intersection has exactly
\(M/\operatorname{lcm}(d_1,\ldots,d_k)\) elements.

Accordingly, the next viable refinement is not a larger scalar moment by
itself. It is an upper bound for the **placement-dependent compatible
intersection tensor**, retaining the compatibility indicators and the
actual residue data. Any proposed replacement must be proved from
pairwise-distinct actual moduli; it may not assume projected moduli are
distinct or that all projected classes are mutually incompatible.

## 5. Verification boundary

- The lemma and all displayed integer/rational values above are proved
  algebraically in this note; the finite products can be checked directly.
- The result is not yet formalized in Lean.
- It is not covered by the existing BBMSTMomentBridge.fiber_fourth_moment
  theorem: that theorem formalizes a finite-map fourth-moment identity, not
  the arithmetic monotonicity calculation or the CRT application.
- No Lean or CI verification is claimed for this note.
- The rank-nine lower bound is used only to identify why the first-nine-prime
  support is the relevant residual support; it is not used in the proof of
  the monotonicity lemma.

## References

- Project criterion and proof:
  [ARBITRARY_EXPONENT_CRT_FOURTH_MOMENT_2026-11-02.md](ARBITRARY_EXPONENT_CRT_FOURTH_MOMENT_2026-11-02.md).
- Michael Schroeder, *Nine Prime Divisors in Odd Distinct Covering Systems*,
  version 1.0.1 (13 September 2026), DOI
  [10.5281/zenodo.22759614](https://doi.org/10.5281/zenodo.22759614).
  The paper claims the nine-distinct-prime lower bound; its companion page
  states that v1.0.1 is a packaging/source-identity update, not a new full
  kernel replay.
- Balister–Bollobás–Morris–Sahasrabudhe–Tiba, *The Erdős–Selfridge problem
  with square-free moduli* (2021), for the square-free special case.
