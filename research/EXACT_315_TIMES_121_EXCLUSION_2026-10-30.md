# Exact exclusion of the 315*11^2 divisor-LCM family

Date: 30 October 2026

## Theorem

There is no covering system with pairwise distinct moduli greater than one, all of whose moduli divide

  315 * 11^2 = 38,115.

This extends the exact 315*q exclusion at q=11 from exponent one to exponent two.

## Proof

Write

  D = {3,5,7,9,15,21,35,45,63,105,315}
and
  E = {1} union D.

The possible moduli dividing 315*11^2 split into three layers:
- old layer: d, with d in D;
- first 11-layer: 11*d, with d in E;
- second 11-layer: 121*d, with d in E.

Pairwise distinctness allows at most one congruence class for each listed modulus.

### Step 1: at least six old-uncovered residues

The old classes have distinct moduli in D. Their union occupies at most the sum of their reciprocal moduli, so the set U of residues modulo 315 missed by all old classes satisfies

  |U|/315 >= 1 - sum_{d in D} 1/d
          = 1 - 103/105
          = 6/315.

Thus |U| >= 6.

### Step 2: each x in U has a dense projection layer

Fix x in U. Consider the eleven first-coordinate branches modulo 11 in the CRT fibre above x, namely the eleven residue classes modulo 121 that reduce to a specified residue modulo 11.

There are two cases.

**Case A: every one of the eleven branches is met by a class of modulus 11*d.**

Each such class fixes exactly one residue modulo 11. To meet all eleven branches requires at least eleven distinct first-layer classes. Since there is at most one class for each d in E, x belongs to at least eleven of the twelve projected classes modulo d indexed by E.

**Case B: some first-coordinate branch is not met by any class of modulus 11*d.**

All eleven residues modulo 121 lying above that missing branch must then be covered by second-layer classes of moduli 121*d. Each such class fixes exactly one residue modulo 121. Covering those eleven residues requires eleven distinct second-layer classes. There are at most twelve possible second-layer moduli 121*d, d in E. Hence x belongs to at least eleven of the twelve projected classes modulo d indexed by E in the second layer.

Therefore every x in U belongs to at least eleven projected classes in one of the two fixed layers b=1 or b=2.

### Step 3: a ten-class intersection determines the base residue

Every ten-element subset S of E has lcm 315. Indeed, the elements of E divisible by 9 are exactly

  {9,45,63,315},

so deleting only two elements cannot remove every multiple of 9. The elements divisible by 5 form a six-element set, and the elements divisible by 7 also form a six-element set. Deleting two elements cannot remove all multiples of either 5 or 7. Thus lcm(S) is divisible by 9*5*7=315; since every element of E divides 315, lcm(S)=315.

Now assign each x in U one layer b in {1,2} supplied by Step 2. Since |U|>=6, at least three distinct residues of U are assigned the same layer. Choose two distinct such residues x,y.

At that fixed layer, x and y each belong to at least eleven of the twelve projected classes indexed by E. Their two index sets therefore share at least ten indices. For each common d, pairwise distinctness means there is only one class with modulus 11^b*d, so x and y lie in the same residue class modulo d. Choose ten common indices. Their moduli have lcm 315 by Step 3, so their simultaneous intersection modulo 315 contains at most one residue. Hence x=y modulo 315, a contradiction.

Thus no such covering system exists. QED.

## Scope

- This excludes every pairwise-distinct covering whose moduli divide 315*121.
- Together with the previous exact 315*q theorem, it excludes the divisor-LCM families 315*q for every prime q>=11 and now the additional exact family 315*11^2.
- It does not prove the analogous statement for 315*11^A when A>=3, nor for arbitrary odd LCMs.
- This is an ordinary finite mathematical proof. It has not been formalized in Lean, compiled, or kernel-checked; no CI success is claimed.

## Five-source discipline

The five standing sources remain methodology/context rather than premises:
1. Quanta (3 Aug 2026): AI-assisted progress on other Erdős problems.
2. Tao/Hales (9 Oct 2026): kernel reliability and statement-fidelity review.
3. ProofAtlas: its visible route map is a research aid, not proof evidence.
4. MAA (1 Jun 2026): concerns the unit-distance Erdős problem, not this covering conjecture.
5. OpenAI (6 Oct 2026): general mathematical research-release context.

The September 2026 rank-nine preprint is a separate external necessary-condition result and is not used in this proof.
