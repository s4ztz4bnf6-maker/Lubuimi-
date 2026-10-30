# General prime-power one-prime CRT incidence exclusion

Date: 30 October 2026

## Theorem

Let M>1 be odd, let tau = tau(M), and let q be a prime such that q does not divide M and q = tau-1. Write

  E(M) = {d : d divides M}.

Assume:

1. (Old-layer deficit) M * (1 - sum_{d|M, d>1} 1/d) > A.
2. For every exact prime power p^a || M, tau/(a+1) >= 3.

Then, for every integer A >= 1, there is no covering system with pairwise distinct moduli greater than one all dividing M*q^A.

This is a uniform arbitrary-exponent extension of the finite-level argument used for M=315 and q=11. The parameter A is not bounded in the theorem statement; the deficit condition imposes the effective bound A < M(1-sum 1/d).

## Proof

Suppose such a covering exists. The classes whose moduli divide M form the old layer. By the union bound, their union occupies at most

  M * sum_{d|M, d>1} 1/d

residues modulo M. Let U be the set of residues modulo M missed by all old classes. Then

  |U| >= M * (1 - sum_{d|M, d>1} 1/d) > A.

Put tau=tau(M). Since q=tau-1, the set E(M) has q+1 elements.

Fix x in U. The CRT fibre above x modulo M has q^A points, identified with Z/q^A Z. Every new modulus has a unique form d*q^b with d|M and 1<=b<=A. For each level b, let I_b(x) be the set of d|M for which the system contains a class modulo d*q^b whose projection modulo M contains x. Pairwise distinctness gives |I_b(x)|<=tau.

A class at level b covers at most q^(A-b) points in the fibre above x. If |I_b(x)|<=q-1 at every level, the total number of fibre points covered by all new classes is at most

  sum_{b=1}^A (q-1) q^(A-b) = q^A-1,

which is less than q^A. This contradicts coverage. Therefore, for every x in U, there is a level b(x) such that |I_{b(x)}(x)|>=q.

Because |U|>A and there are only A levels, two distinct residues x,y in U have the same selected level b. Both I_b(x) and I_b(y) are subsets of E(M), which has tau=q+1 elements, and each has at least q elements. Hence

  |I_b(x) intersect I_b(y)| >= 2q-(q+1)=q-1=tau-2.

We claim every subset S of E(M) of size tau-2 has lcm M. For each exact prime power p^a || M, the number of divisors d|M divisible by p^a is tau/(a+1), which is at least 3 by assumption. Deleting two elements of E(M) therefore leaves at least one divisor divisible by p^a. This holds for every prime-power factor p^a || M, so lcm(S) contains every exact prime power dividing M. Since every element of S divides M, lcm(S)=M.

Apply this claim to any tau-2 common indices in I_b(x) intersect I_b(y). For each such d, the same unique congruence class modulo d*q^b projects to a class modulo d containing both x and y. Thus x and y agree modulo every d in S, and hence modulo lcm(S)=M. This contradicts x!=y in Z/MZ.

Therefore no such covering exists. QED.

## Corollary: the 315*11^A family

For M=315=3^2*5*7, tau(M)=12 and q=11=tau-1. Also

  sum_{d|315, d>1} 1/d = 103/105,
  315 * (1-103/105) = 6,

and the exact-prime-power multiplicities are 4 for 9, 6 for 5, and 6 for 7, all at least 3. The theorem therefore excludes every A with 1<=A<6, namely A=1,2,3,4,5, recovering the previous exact result.

## Relation to the general incidence problem

The key incidence threshold is not an arbitrary numerical coincidence. In a q-adic fibre, fewer than q projected classes at every level have total capacity at most q^A-1. Thus some level has incidence at least q. Since the divisor index set has q+1 elements, two such incidence sets overlap in at least q-1 indices. A divisor-family lcm condition converts that overlap into equality of the old CRT coordinates.

This gives a reusable template:

- fibre-capacity lower bound: force high incidence at one level;
- pigeonhole over levels: find two old residues at the same level;
- set-intersection bound: force a large common divisor-index set;
- lcm rigidity: turn common incidence into equality of the old residues.

The global Erdős–Selfridge problem requires a way to obtain an analogous high-incidence/lcm-rigidity mechanism for arbitrary prime support and arbitrary prime-power profiles, not merely a fixed one-prime lift.

## Relation to established methods

The proof is a finite CRT incidence argument. It is structurally compatible with the general covering-system toolkit, but it is not a reproduction of the BBMST distortion method or of the recent conditional-reweighting/supermodular method in the rank-nine preprint. Those methods preserve correlations between prime-coordinate fibres instead of replacing them by a single unweighted capacity sum. A plausible next step is to define a weighted incidence functional on the full CRT product and prove a conditional lower bound on its second and higher moments; any proposed inequality must be checked against actual residue configurations before being used globally.

## Verification status and scope

- The argument above is a paper-level elementary proof, subject to ordinary mathematical peer scrutiny.
- It is not yet formalized in Lean in this repository.
- No local Lean compilation, kernel check, or CI success is claimed.
- The theorem excludes only LCMs of the special form M*q^A under its hypotheses. It does not prove the global odd distinct covering conjecture.
