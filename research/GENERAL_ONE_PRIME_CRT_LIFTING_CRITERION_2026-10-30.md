# A reusable one-prime CRT lifting criterion

Date: 2026-10-30

## Setup

Let M > 1 be odd, let tau = tau(M) be the number of positive divisors of M, and put
D(M) = {d : d divides M and d > 1}.
Thus |D(M)| = tau - 1. Let q be a prime not dividing M. Consider a family of pairwise distinct moduli, all greater than one and all dividing M*q.

The moduli split into:
- old moduli d in D(M);
- lifted moduli q*d for d in D(M);
- possibly the single modulus q.

The following criterion isolates exactly the counting mechanism used for M=315.

## Theorem (boundary one-prime exclusion criterion)

Assume:

(A) M * (1 - sum_{d in D(M)} 1/d) > 1.

(B) For every prime power p^a exactly dividing M, one has tau(M)/(a+1) >= 3.

Then no covering system with pairwise distinct moduli greater than one and all moduli dividing M*q exists in either of the following cases:
1. q = tau(M)-1;
2. q = tau(M);
3. q >= tau(M)+1.

No claim is made here for primes q <= tau(M)-2.

## Proof

Let U be the residues modulo M missed by all old classes. Since the old moduli are distinct members of D(M), the union bound gives

  |U|/M >= 1 - sum_{d in D(M)} 1/d.

Assumption (A) implies |U| > 1, hence |U| >= 2.

There are at most tau(M)-1 lifted classes q*d with d in D(M), and at most one additional class of modulus q. Thus there are at most tau(M) new classes. Fix x in U. Every one of the q CRT fibres above x must be covered by a new class, and each new class fixes exactly one q-coordinate. Therefore at least q distinct new classes are required for every x in U.

If q >= tau(M)+1, this is impossible by the total count.

If q = tau(M), all tau(M) new classes must be present. In particular the modulus q must be present, since there are only tau(M)-1 lifted classes. The other q-1 = tau(M)-1 fibres above x force x to lie in every projected class indexed by D(M). Their common intersection has at most one residue modulo M because lcm(D(M))=M. This contradicts |U|>=2.

It remains to consider q=tau(M)-1. If modulus q is absent, all q lifted classes must be present, so every x in U lies in every projected class indexed by D(M). If modulus q is present, the remaining q-1=tau(M)-2 fibres force every x in U to lie in at least tau(M)-2 of the tau(M)-1 projected classes.

Take distinct x,y in U. In either case, their two sets of containing projected classes have at least tau(M)-2 elements each among tau(M)-1 indices. Their intersection therefore has at least tau(M)-3 indices.

We show that every subset S of D(M) with tau(M)-3 elements has lcm M. For each exact prime power p^a || M, the number of divisors d in D(M) divisible by p^a is exactly tau(M)/(a+1). By (B), this number is at least three. The complement of S in D(M) has exactly two elements, so S must contain at least one divisor divisible by p^a. This holds for every prime power p^a || M, hence lcm(S)=M.

Consequently x and y lie in a collection of projected congruence classes whose moduli have lcm M. Their intersection modulo M has at most one element, contradicting x != y. Thus |U|<=1, contrary to |U|>=2. QED.

## Application: M=315

Here tau(315)=12 and D(M) is

  {3,5,7,9,15,21,35,45,63,105,315}.

The reciprocal sum is 103/105, so

  M * (1 - 103/105) = 6 > 1.

For p^a || 315, the counts tau(315)/(a+1) are:
- p^a = 3^2: 12/3 = 4;
- p^a = 5: 12/2 = 6;
- p^a = 7: 12/2 = 6.

Both hypotheses hold. The theorem excludes q=11, q=12 (irrelevant because q must be prime), and all q>=13. Thus it recovers the full exact-315q exclusion in one reusable argument.

## Research significance and limitations

This is a reusable criterion for one-prime extensions of a fixed base period. It does not handle:
- primes q <= tau(M)-2;
- two or more new prime factors;
- higher prime powers q^2;
- arbitrary odd moduli whose LCM is not of the form M*q with a controlled base M.

The next natural arithmetic target is to find base periods M satisfying (A) and (B) for which tau(M)-1 or tau(M) is prime. The more difficult global target remains controlling several new prime coordinates simultaneously.

## Verification posture

The proof above is an ordinary mathematical proof with a finite divisor-count argument. The M=315 numerical checks are exact. This note has not been formalized in Lean and no CI or kernel verification is claimed.

## Five-source discipline

The standing five sources are research-methodology references, not premises in this theorem:
1. Quanta (3 Aug 2026): AI-assisted progress on other Erdős problems.
2. Tao/Hales (9 Oct 2026): kernel checking and statement-fidelity audit.
3. ProofAtlas: the full conjecture remains open in its bounded review; its 28 Aug snapshot predates later rank-nine work.
4. MAA (1 Jun 2026): the unit-distance Erdős problem, not this covering conjecture.
5. OpenAI (6 Oct 2026): general mathematical research and formalization release practice.

The September 2026 rank-nine preprint is external necessary-condition progress and is not used as a premise here.
