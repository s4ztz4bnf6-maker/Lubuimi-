# Exact exclusion of every divisor-LCM 315*11^A with 1 <= A <= 5

Date: 30 October 2026

## Theorem

For each integer A with 1 <= A <= 5, there is no covering system with pairwise distinct moduli greater than one, all of whose moduli divide 315*11^A.

The cases A=1 and A=2 were already established in separate notes. This argument gives a uniform proof for all five exponents and, in particular, adds A=3,4,5.

## Proof

Let

  D = {3,5,7,9,15,21,35,45,63,105,315}
and
  E = {1} union D.

There are twelve elements of E, all dividing 315. Every divisor greater than one of 315*11^A has a unique form 11^b*d, where 0 <= b <= A and d | 315; when b=0, d>1.

### Step 1: at least six base residues are missed by the old layer

The old moduli are distinct elements of D. Their residue classes modulo 315 have total size at most

  315 * sum_{d in D} 1/d
  = 315 * 103/105
  = 309.

Consequently the set U of residues modulo 315 missed by every old class has cardinality at least six.

### Step 2: every x in U has a level with at least eleven projected classes

Fix x in U. For each b=1,...,A, let n_b(x) be the number of d in E for which the system contains a class with modulus 11^b*d whose projection to Z/315 contains x.

There is at most one class for each modulus 11^b*d, so 0 <= n_b(x) <= 12.

Above x, the CRT fibre has 11^A points. A class at level b that projects over x fixes one residue modulo 11^b and therefore covers exactly 11^(A-b) points of this fibre. Hence, by the union bound, if n_b(x) <= 10 for every b, the total number of fibre points covered by all new classes is at most

  sum_{b=1}^A 10 * 11^(A-b)
    = 10 * (11^A - 1)/10
    = 11^A - 1,

which is strictly less than 11^A. This contradicts the assumed covering.

Thus for every x in U there exists at least one level b(x) in {1,...,A} with

  n_{b(x)}(x) >= 11.

Choose one such level for each x.

### Step 3: two base residues share a level

Since |U| >= 6 and A <= 5, the pigeonhole principle gives distinct x,y in U with b(x)=b(y)=b.

At this common level, each of x and y belongs to at least eleven of the twelve projected classes indexed by E. Their two index sets therefore have at least

  11 + 11 - 12 = 10

common indices.

For every common d, the system contains a class with modulus 11^b*d whose base projection contains both x and y. Pairwise distinctness ensures that there is only one class with this modulus, so x and y satisfy the same residue modulo d.

### Step 4: ten common divisors determine the residue modulo 315

Every ten-element subset S of E has lcm 315. Indeed:
- exactly four elements of E are divisible by 9, so deleting at most two cannot remove all factors 9;
- exactly six elements are divisible by 5, so deleting at most two cannot remove all factors 5;
- exactly six elements are divisible by 7, so deleting at most two cannot remove all factors 7.

All elements of E divide 315. Thus lcm(S)=315.

Applying this to ten common indices shows x=y modulo 315, contradicting the choice of distinct elements of U.

Therefore no such covering system exists. QED.

## Exact scope

- Excluded: every divisor-LCM family with LCM dividing 315*11^A for A=1,2,3,4,5.
- The new cases beyond the previous notes are A=3,4,5.
- This argument alone does not settle A>=6: the pigeonhole step only gives two of the at least six old-uncovered residues at the same one of A levels.
- It does not settle arbitrary odd LCMs. In particular, it does not bridge the global gap to Erdős–Selfridge.
- This is a mathematical proof note, not a Lean formalization. No compilation, kernel verification, or CI success is claimed.

## Relation to the external rank-nine result

The September 2026 rank-nine preprint of Michael Schroeder claims that every odd distinct covering must have at least nine prime divisors in its LCM, uniformly over prime-power exponents. If that package's proof is accepted/reproduced, it already excludes every LCM supported only on {3,5,7,11}; the present result is therefore a self-contained finite CRT proof of a much narrower family, not a competitive global bound. It is retained as a transparent test case for the fibre-allocation method.
