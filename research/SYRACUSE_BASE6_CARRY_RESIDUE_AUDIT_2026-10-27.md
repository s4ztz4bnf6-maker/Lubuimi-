# Base-6 audit and a carry-state reformulation of Syracuse (2026-10-27)

## 1. Correct arithmetic in base 6

Write n = sum_i d_i 6^i, with digits d_i in {0,1,2,3,4,5}.

For odd n, n mod 6 is 1, 3, or 5, so 3n+1 mod 6 = 4. Thus 3n+1 has final base-6 digit 4 and is even. This is a valid local residue fact.

Two common overclaims are false:

- Dividing an even base-6 numeral by 2 is not generally a one-digit shift. Since 6^i/2 = 3*6^(i-1), higher digits contribute 3d_i at the next lower position; values 3d_i can exceed 5 and generate carries.
- The fact that 3n+1 ends in 4 only guarantees an immediate factor of 2, not a fixed exact valuation and not a global descent.

Examples: n=1 gives 3n+1=4_6=4, with valuation 2; n=3 gives 10_6=6, with valuation 1; n=5 gives 14_6=10, with valuation 4. The terminal digit alone does not determine v_2(3n+1).

## 2. A more accurate new structure: the carry-residue profile

Instead of treating the base-6 numeral as if it had local division, attach to each block:
- its realized valuation word a=(a_0,...,a_{m-1});
- cumulative valuation A=sum a_i;
- affine offset C, with recurrence C_0=0 and C_{j+1}=3C_j+2^{A_j};
- exact endpoint ratio R=x_m/x_0=(3^m x_0+C)/(2^A x_0).

The block descends iff R<1, equivalently iff (2^A-3^m)x_0>C.

This is the carry-corrected block certificate supported by the affine recurrence. A digit-profile or entropy statistic is useful only if it gives a proved bound on C (or directly on R) for every realizable valuation word. Merely counting zeroes and ones cannot establish descent.

A candidate finite-state research method is to enumerate prefixes by residue classes modulo 2^r while tracking exact (A,C) and whether the valuation prefix is realizable. The state compression is valid only if its transition relation preserves all information needed for the desired bound. Any quotient by residues must prove that the omitted information cannot change the bound; otherwise it is exploratory, not a proof.

## 3. Falsification obligations

For each proposed block statistic or potential:
1. Search small realized prefixes for counterexamples to its claimed monotonicity.
2. Distinguish the raw Collatz map from the accelerated odd-to-odd Syracuse map; they have different clocks.
3. Test short cycles and exact returns separately from divergence.
4. Formalize the exact recurrence and certificate before adding a universal drift claim.
5. Audit all exported theorems transitively for sorryAx and compare the definitions against the chosen source convention.

## Status

This note is a mathematical correction and research specification. It does not prove global Collatz descent or rule out a divergent orbit.
