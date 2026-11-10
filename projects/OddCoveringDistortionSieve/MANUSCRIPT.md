# Odd Covering Systems: CRT Fibres, Private Mass and Distortion-Sieve Research

**Author:** Ta-Yoshua Lubuimi  
**Date:** 10 November 2026  
**Status:** Research manuscript and proof ledger. It is not a completed proof of the odd distinct covering-system conjecture.

## 1. Basic finite CRT model

Let \(\Omega=\mathbb Z/N\mathbb Z\) be a finite cyclic group and let
\[
A_i=a_i+H_i\subseteq\Omega
\]
be residue classes/subgroups in the CRT model. Define the multiplicity
\[
r(x)=\sum_i{\bf1}_{A_i}(x).
\]
The total incidence count is
\[
\sum_{x\in\Omega}r(x)=\sum_i|A_i|.
\]
The pair-collision energy is
\[
E_2=\sum_{i<j}|A_i\cap A_j|
=\sum_{x\in\Omega}\binom{r(x)}2.
\]
This identity is exact: each point x contributes one for every unordered pair of covering classes containing x.

If the family covers \(\Omega\), then \(r(x)\ge1\) for all x and
\[
\binom{r(x)}2\ge r(x)-1.
\]
Consequently
\[
E_2\ge\sum_i|A_i|-|\Omega|.
\]
The inequality is strict if at least one point has multiplicity at least three. This lower bound is useful but does not determine the union or the private mass, because higher-order intersections remain relevant.

## 2. Two-prime CRT compatibility structure

For moduli supported on two fixed primes p and q, represent each residue class by its p-adic and q-adic coordinates. Compatibility is coordinatewise: two global classes intersect exactly when their local p- and q-adic classes are both compatible.

The project’s structural route records the global compatibility complex as a flag complex arising from the intersection of the two local compatibility graphs. In each prime-power coordinate, residue balls form a laminar family: two balls are disjoint or one contains the other. The flag conclusion must always be used with the exact two-coordinate compatibility hypotheses; it is not a claim about arbitrary congruence systems.

The original detailed definitions of the compatibility graphs, their indexing, and the precise cross-fibre inequality must be retained from the underlying research notes before this structural route is used as a publication-ready theorem. This manuscript does not replace those missing source definitions with new notation.

## 3. Exact LCM-chain arithmetic

For a finite set T of indices, let
\[
L_T=\operatorname{lcm}(m_j:j\in T).
\]
Adding a new modulus m_i changes the LCM by the exact factor
\[
R(i\mid T)=\frac{m_i}{\gcd(m_i,L_T)},
\qquad
L_{T\cup\{i\}}=L_T\,R(i\mid T).
\]
If every modulus is odd and the LCM strictly grows, then \(R(i\mid T)>1\) is odd, hence
\[
R(i\mid T)\ge3.
\]
Thus every strict step in a chain of divisors of a fixed odd L multiplies the current LCM by at least three. Since the chain consists of distinct divisors of L, it has at most \(\tau(L)-1\) strict growth steps, where \(\tau(L)\) is the divisor-count function.

This is a genuine arithmetic saturation bound. It must not be confused with a bound on the number of covering classes or with a bound on private mass.

## 4. Exact test case L=15

The reciprocal-density sum is
\[
\frac13+\frac15+\frac1{15}=\frac35<1.
\]
On \(\Omega=\mathbb Z/30\mathbb Z\), take
\[
A_1=\{x:x\equiv0\pmod3\},\quad
A_2=\{x:x\equiv0\pmod5\},\quad
A_3=\{x:x\equiv1\pmod{15}\}.
\]
The two points of A3 are 1 and 16. Neither lies in A1 or A2, so the private set of A3 is exactly
\[
P_3=A_3\setminus(A_1\cup A_2)=\{1,16\},
\qquad |P_3|=2.
\]
This is an exact finite example, not a covering system.

## 5. Exact test case L=945

Let
\[
L=945=3^3\cdot5\cdot7,\quad \Omega=\mathbb Z/1890\mathbb Z,
\]
and
\[
D=\{3,5,7,9,15,21,27,35,45,63,105,135,189,315,945\}.
\]
The divisor-density sum is exactly
\[
\sum_{d\in D}\frac1d=\frac{65}{63}>1.
\]
The unordered coprime-pair contribution is
\[
Q=\sum_{\substack{d,e\in D\\d<e,\ \gcd(d,e)=1}}\frac1{de}
=\frac{74}{315}.
\]
The value Q is the exact sum of pairwise intersection densities for coprime modulus pairs. It is not the total pair-collision energy, and it does not rule out a covering: pairwise information alone does not control all triple and higher intersections.

## 6. Private mass and distortion-sieve targets

For a class A_i, its private set is
\[
P_i=A_i\setminus\bigcup_{j\ne i}A_j.
\]
The research target is a positive quantitative lower bound for an appropriately normalized private mass, denoted g(L) in the project notes, together with a global bound on the associated distortion/overlap functional Ψ.

The exact definitions of g(L), Ψ, and their index sets must be carried forward from the original research notebook. They are not redefined here by analogy. The following are open:
- prove a uniform positive lower bound g(L)>0 in the required irredundant odd-modulus setting;
- derive a universal Ψ bound from the CRT fibre and incidence structure;
- obtain a valid bound in terms of the number of distinct prime factors \(\omega(L)\);
- transfer the finite-fibre discrepancy to the global covering contradiction.

The proposed prime-factor damping route is not established. Homological information about the compatibility complex alone does not supply the required quantitative bound on Ψ.

## 7. Conditional spectral and cross-fibre leads

Prior research notes record a conditional spectral inequality of the form
\[
\frac{q\,\lambda_{\max}(M)}2+\sum_{j<\ell}\delta_{j\ell}
\ge\binom q2.
\]
The exact definitions of q, M, the \(\delta_{j\ell}\), the normalization, and the hypotheses must be recovered from the source derivation before this expression is promoted to a theorem. Likewise, the previously derived cross-fibre inequality must be restored with its original indices and assumptions.

Accordingly, this section records a proof lead, not a fully stated theorem. No conclusion is drawn from the displayed shape alone.

## 8. Proof ledger and next obligations

### Exact
- The finite CRT pair-count identity for E2.
- The cover lower bound E2 >= sum_i |A_i| - |Ω|.
- The LCM growth ratio and its odd-factor lower bound.
- The L=15 private-set example.
- The L=945 divisor density 65/63 and coprime-pair sum 74/315.

### Previously derived but requiring source-complete reconstruction
- The flag-complex compatibility statement with exact two-prime hypotheses.
- The cross-fibre inequality.
- The conditional spectral inequality.

### Open
- Quantitative g(L)>0.
- Universal Ψ/discrepancy bound and valid \(\omega(L)\) dependence.
- A complete transfer from local CRT fibres to the global odd covering contradiction.

No Lean verification is claimed for this project record. No global theorem is claimed.
