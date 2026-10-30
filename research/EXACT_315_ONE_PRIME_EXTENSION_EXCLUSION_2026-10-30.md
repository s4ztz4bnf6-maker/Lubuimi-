# Prime-extension exclusion above the 315 divisor block

Date: 2026-10-30

## Theorem (complete one-prime divisor block, with one residual case)

Let D = {3, 5, 7, 9, 15, 21, 35, 45, 63, 105, 315}. Let q be a prime with q not dividing 315. Consider a covering system whose pairwise distinct moduli all divide 315*q and are greater than one.

Then:
- If q >= 13, no such covering system exists.
- If q = 11 and the modulus 11 is absent, no such covering system exists.
- The only case not excluded by this argument is q = 11 with the modulus 11 present.

Thus every possible covering with LCM exactly 315*q is excluded except for the single residual configuration with q=11 and modulus 11 included. This is still a finite-LCM special case, not the general odd distinct covering conjecture.

## Proof

Every divisor greater than one of 315*q is either d for d in D, or q*d for d in E = {1} union D. Pairwise distinctness allows at most eleven old classes with moduli in D and at most twelve new classes with moduli q*d, including the possible modulus q itself.

Let U be the residues modulo 315 missed by all old classes. Since the old moduli are distinct members of D, the union bound gives

  |U|/315 >= 1 - sum_{d in D} 1/d
          = 1 - 103/105
          = 2/105
          = 6/315.

Thus U is nonempty (indeed |U| >= 6).

Fix x in U. For each t modulo q, the CRT residue (x,t) must be covered by a new class. Each new class has one fixed q-coordinate. Hence at least q distinct new classes are required to cover the q different fibres above x.

If q >= 13, there are at most twelve new classes, so coverage is impossible.

Now let q=11. If the modulus 11 is absent, all new classes have moduli 11*d with d in D, so there are at most eleven of them. Each x in U must lie in all eleven projected classes. Their common intersection is either empty or a single residue modulo lcm(D)=315. Hence |U| <= 1, contradicting |U| >= 6.

If q=11 and modulus 11 is present, this argument only forces at least ten of the eleven projected classes with moduli 11*d (d in D) to contain each x in U. The full-intersection argument no longer applies. This is the one residual case and is not claimed solved here.

Therefore the stated exclusions hold. QED.

## Relation to the second-moment route

For q=11 with modulus 11 present, each x in U must lie in at least ten of the eleven projected classes. The pair-counting identity gives the necessary condition

  sum_{j<k} |U intersect C_j intersect C_k| >= binom(10,2) * |U|.

This is the appropriate next finite arithmetic subproblem. A universal upper bound for the left side, taking the residue compatibility and the eleven distinct projected moduli into account, could eliminate the remaining q=11 case. The generic second-moment identity in BBMSTMomentBridge.lean supplies the algebraic counting identity, but not this arithmetic upper bound.

## Scope limitations

- The theorem covers systems whose entire LCM is 315*q, with q prime and coprime to 315.
- The only remaining case is q=11 with modulus 11 present.
- No higher prime-power exponents, additional prime factors, or arbitrary LCMs are covered.
- This is an elementary mathematical proof of the stated finite-LCM exclusions, not a Lean kernel-checked formalization. No compilation or CI success is claimed for the new note.

## Five-source audit

The five standing sources are methodological/contextual and do not prove this theorem:
1. Quanta's 3 August 2026 article concerns AI-assisted progress on other Erdős problems.
2. Tao/Hales (9 October 2026) motivates separate kernel and statement-fidelity verification.
3. ProofAtlas marks the full odd distinct covering conjecture as a research problem; its visible status snapshot is dated 28 August 2026 and predates the September 2026 rank-nine preprint.
4. MAA's 1 June 2026 article concerns the unit-distance Erdős problem.
5. OpenAI's 6 October 2026 mathematics release describes general research-release practice.

The external September 2026 rank-nine preprint is a separate necessary condition, not used in this proof and not a solution of the full conjecture.
