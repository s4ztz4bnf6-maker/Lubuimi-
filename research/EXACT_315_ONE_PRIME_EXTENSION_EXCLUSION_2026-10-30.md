# Exact exclusion of the one-prime extension above the 315 divisor block

Date: 2026-10-30

## Theorem (specified CRT extension model)

Let D = {3, 5, 7, 9, 15, 21, 35, 45, 63, 105, 315}. Consider old congruence classes with pairwise distinct moduli in D, and new congruence classes whose actual moduli are q*d with d in D, with no repeated actual modulus. Let q be a prime at least 11. Then the old and new classes cannot cover every residue modulo 315*q.

This theorem concerns exactly this one-prime extension model. It is not a theorem about arbitrary odd distinct covering systems.

## Proof

Let U be the residues modulo 315 missed by every old class. Since the old moduli are distinct members of D, the union bound gives

  |U|/315 >= 1 - sum_{d in D} 1/d
          = 1 - 103/105
          = 2/105
          = 6/315.

Thus |U| >= 6.

Every new modulus is q*d for some d in D. Distinctness of the actual new moduli implies distinctness of their projected divisors d, so there are at most eleven new classes.

Fix x in U. For every t modulo q, the CRT residue (x,t) must be covered by a new class, since no old class covers x. A new congruence class has one fixed q-coordinate, so at least one new class is required for each of the q different values of t. Thus at least q distinct new classes project to classes containing x.

If q > 11, this is impossible because there are at most eleven new classes.

If q = 11, there must be exactly eleven new classes, and every x in U must lie in every one of their projected classes. The intersection of congruence classes with moduli in D is either empty or a single residue class modulo lcm(D) = 315. Therefore their common intersection in the base ring has size at most one. Hence |U| <= 1, contradicting |U| >= 6.

Therefore no cover exists in this model for any prime q >= 11. QED.

## Relation to the second-moment route

The generic second-moment identity records

  sum_{j<k} |U intersect C_j intersect C_k| >= binom(q,2) * |U|.

For this particular block, the cardinality argument is sharper: when q = 11, the number of available projected classes is exactly eleven, forcing every old-uncovered residue into their full intersection. That intersection has at most one point. For q > 11, the first-moment allocation already fails.

The formal identity in BBMSTMomentBridge.lean remains useful for larger blocks, where the number of projected classes can exceed q.

## Scope limitations

- The base LCM is exactly 315 and the old moduli are restricted to D.
- Every new modulus is exactly q*d with d in D, for one prime q >= 11.
- No higher q-adic exponents, mixed new prime supports, or arbitrary moduli are covered.
- This note is an elementary mathematical proof, not a Lean kernel-checked formalization. No compilation or CI success is claimed for it.

## Five-source audit

The five standing sources are methodological/contextual and do not prove this theorem:
1. Quanta's 3 August 2026 article concerns AI-assisted progress on other Erdős problems.
2. Tao/Hales (9 October 2026) motivates separate kernel and statement-fidelity verification.
3. ProofAtlas continues to mark the full odd distinct covering conjecture as a research problem; its status snapshot is dated 28 August 2026 and is stale relative to September 2026 rank-nine preprints.
4. MAA's 1 June 2026 article concerns the unit-distance Erdős problem.
5. OpenAI's 6 October 2026 mathematics release describes general research-release practice.

The external September 2026 rank-nine preprint is a separate necessary condition, not used in this proof and not a solution of the full conjecture.
