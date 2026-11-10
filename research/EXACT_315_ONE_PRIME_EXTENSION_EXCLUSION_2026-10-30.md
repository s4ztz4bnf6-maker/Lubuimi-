# Exact exclusion of every one-prime extension of the 315 divisor block

Date: 2026-10-30

## Theorem

Let D = {3, 5, 7, 9, 15, 21, 35, 45, 63, 105, 315}. Let q be a prime not dividing 315. There is no covering system with pairwise distinct moduli greater than one whose moduli all divide 315*q.

Equivalently, no odd distinct covering system can have least common multiple exactly 315*q for any prime q >= 11.

This closes the entire one-new-prime extension of the exact-315 block, including the possible modulus q itself.

## Proof

Every divisor greater than one of 315*q is either d for d in D, or q*d for d in E = {1} union D. Pairwise distinctness allows at most eleven old classes with moduli in D and at most twelve new classes with moduli q*d, including the possible modulus q itself.

Let U be the residues modulo 315 missed by all old classes. Since the old moduli are distinct members of D, the union bound gives

  |U|/315 >= 1 - sum_{d in D} 1/d
          = 1 - 103/105
          = 2/105
          = 6/315.

Thus |U| >= 6.

Fix x in U. For each t modulo q, the CRT residue (x,t) must be covered by a new class. Each new class has one fixed q-coordinate. Hence at least q distinct new classes are required to cover the q different fibres above x.

If q >= 13, there are at most twelve new classes, so coverage is impossible.

It remains to consider q=11. If the modulus 11 is absent, all new classes have moduli 11*d with d in D. There are at most eleven such classes, and each x in U must lie in all eleven projected classes.

If the modulus 11 is present, it covers one fixed q-fibre for every base residue. The other ten q-fibres must be covered by classes with moduli 11*d, d in D. Thus each x in U must lie in at least ten of the at most eleven projected classes with d in D.

In either case, every x in U lies in at least ten of the eleven possible projected classes indexed by D. Suppose x and y are two distinct elements of U. Their sets of containing projected classes each have size at least ten among eleven indices, so they have at least nine common indices. Choose nine of these common classes. Their nine moduli are distinct members of D.

A direct finite divisor check gives

  lcm(S) = 315 for every 9-element subset S of D.

Therefore the intersection of those nine congruence classes modulo 315 contains at most one residue. But both x and y lie in that intersection, contradicting x != y.

Hence |U| <= 1, contradicting |U| >= 6. No cover exists. QED.

## Exact finite arithmetic certificate

The two finite facts used above are:
- sum_{d in D} 1/d = 103/105;
- for each of the binomial(11,9)=55 subsets S of D, lcm(S)=315.

Both can be checked by exact integer arithmetic. The lcm assertion is a finite exhaustive check over 55 subsets, not a Lean kernel theorem in this note.

## Why the pair-moment route remains useful

For this 315 block, the fact that every 9-element subset of D has full lcm 315 makes a direct two-point intersection argument stronger and simpler than the second-moment bound. For larger base divisor blocks, the analogous minimum-lcm property may fail; the general pair-moment identity in BBMSTMomentBridge.lean remains a possible route, provided one proves a suitable arithmetic upper bound.

## Scope limitations

- This proves impossibility only when the full LCM is exactly 315*q for one prime q coprime to 315.
- It does not cover LCMs with two or more new prime factors, higher powers q^2, or arbitrary prime support.
- This is an elementary mathematical proof of the stated finite-LCM theorem, not a Lean kernel-checked formalization. No compilation or CI success is claimed for the new note.

## Five-source audit

The five standing sources are methodological/contextual and do not prove this theorem:
1. Quanta's 3 August 2026 article concerns AI-assisted progress on other Erdős problems.
2. Tao/Hales (9 October 2026) motivates separate kernel and statement-fidelity verification.
3. ProofAtlas marks the full odd distinct covering conjecture as a research problem; its visible status snapshot is dated 28 August 2026 and predates the September 2026 rank-nine preprint.
4. MAA's 1 June 2026 article concerns the unit-distance Erdős problem.
5. OpenAI's 6 October 2026 mathematics release describes general research-release practice.

The external September 2026 rank-nine preprint is a separate necessary condition, not used in this proof and not a solution of the full conjecture.
