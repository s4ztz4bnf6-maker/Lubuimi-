# Syracuse valuation cylinders and affine-offset audit (2026-10-27)

## Goal

Connect finite prescribed valuation words to exact residue classes of the initial odd integer, then combine that local congruence information with the affine descent threshold. This is a finite-orbit milestone, not a proof of the global Collatz conjecture.

## Affine recurrence

For the accelerated odd map
`T(n)=(3n+1)/2^{a}`, where `a=v₂(3n+1)`, fix a valuation word `a₀,…,a_{k-1}`. Put `A₀=0`, `A_j=∑_{i<j}a_i`, and define `C₀=0`, `C_{j+1}=3C_j+2^{A_j}`. For any orbit segment realizing the word,
`2^{A_j} n_j = 3^j n₀ + C_j`.
The identity follows by induction from `2^{a_j}n_{j+1}=3n_j+1`.

## Exact local valuation constraint

For a positive integer `n`, the equality `v₂(3n+1)=a` is equivalent to
`3n+1 ≡ 2^a (mod 2^{a+1})`.
Because 3 is invertible modulo every power of 2, this selects one residue class modulo `2^{a+1}`. Examples:
- `a=1`: `n ≡ 3 (mod 4)`;
- `a=2`: `n ≡ 1 (mod 8)`;
- `a=3`: `n ≡ 13 (mod 16)`.

For a whole valuation word, later constraints must be pulled back through the preceding affine recurrences. The formal theorem must establish necessity *and* sufficiency for the resulting initial residue class; divisibility of the final numerator alone is not sufficient to establish the exact valuation word.

## Descent threshold

Let `D_k=2^{A_k}-3^k). From the affine identity,
`n_k<n₀ ↔ C_k < D_k n₀`
provided the segment realizes the word and `D_k>0`. This is a conditional threshold for a fixed word. Neither `D_k>0` for every word nor a uniform descent bound has been proved here.

## Formal obligations

1. Define the accelerated map and valuation convention with explicit positivity/oddness hypotheses.
2. Prove the affine identity by induction.
3. Derive the initial residue cylinder for a fixed finite valuation word, proving both directions.
4. Prove the descent-threshold equivalence under `D_k>0`.
5. Search finite words and initial residues for counterexamples to any proposed uniform bound; report the search range and exact certificate.
6. Compile under the pinned Lean toolchain and audit transitive axioms. No `sorryAx`, no unproved global premise, and no inference from finite search to an infinite theorem.

The p-adic viewpoint is useful for encoding nested residue cylinders, but continuity on `ℤ₂` alone does not imply convergence of positive-integer orbits to a global sink. Any such conclusion requires an additional theorem connecting the 2-adic dynamics to the ordinary positive-integer orbit and ruling out nontrivial infinite valuation paths.
