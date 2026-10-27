# BBMST: exact rational LP certificate boundary

Date: 2026-10-26
Status: proof architecture; no BBMST-specific certificate extracted and no Lean build claimed.

## Verified source facts and current blocker

The official supplementary page for “The Erdős–Selfridge problem with square-free moduli” by Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe, and Marius Tiba states that its initial distribution on [3]×[5]×[7]×[11] is checked by C code using Gurobi to solve multiple linear programs. It separately links output listing configurations with bounds greater than 9.018 and a portable C program for optimizing d_k, k=6,…,21.

Official source: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html

The linked C source endpoint is https://people.maths.ox.ac.uk/balister/es/coverlp.c. The web retrieval interface rejects it because the server returns content type text/x-csrc. Therefore no LP matrix, objective vector, feasible point, dual vector, or numerical certificate has yet been extracted here. None should be invented.

## Exact weak-duality certificate

Use a rational LP in standard form: minimize cᵀx subject to Ax ≥ b and x ≥ 0, with A,b,c rational. A proposed dual vector y is a valid lower-bound certificate if y ≥ 0 and Aᵀy ≤ c. For every primal-feasible x,

bᵀy ≤ (Ax)ᵀy = xᵀAᵀy ≤ cᵀx.

Thus bᵀy is a certified lower bound on every feasible primal objective. The proof requires only finite sums, rational order, and multiplication by nonnegative rationals; it does not require trusting the optimizer.

Conversely, a primal feasible x provides an upper bound on the minimum. Matching exact primal and dual objectives proves optimality, provided both vectors satisfy their respective constraints and the LP itself faithfully encodes the intended finite problem.

## Lean checker design (not yet implemented)

1. Represent dimensions by finite index types, for example Fin m and Fin n; represent A as Fin m → Fin n → ℚ, b as Fin m → ℚ, c as Fin n → ℚ.
2. Define primal feasibility explicitly: each component x_j ≥ 0 and for each i, b_i ≤ Σ_j A_ij x_j.
3. Define dual feasibility explicitly: each y_i ≥ 0 and for each j, Σ_i A_ij y_i ≤ c_j.
4. Prove a generic weak-duality theorem by multiplying each primal inequality by y_i ≥ 0, summing, rearranging finite sums, then applying the dual inequalities multiplied by x_j ≥ 0.
5. Import source coefficients as exact rational literals or numerator/positive-denominator pairs. Never parse rounded decimal output as if it were exact.
6. Audit every denominator as positive and nonzero before any normalization. Do not allow ℚ division by zero, getD defaults, or unconstrained parameters to turn an invalid LP into a vacuous result.
7. Separately prove statement fidelity: the finite variables, constraints, objective and strict numerical threshold must match the source's geometric/probabilistic argument.

## Boundary of what this proves

The generic weak-duality lemma is not the BBMST theorem. It becomes a project-specific result only after the published model and exact data have been recovered, independently transcribed, and checked. Even a perfect LP certificate proves only the finite optimization subclaim; the bridge from that subclaim to the covering-system theorem must also be formalized from the paper.

## Immediate next step

Retrieve the supplemental C source from a client that accepts text/x-csrc or clone the public supplemental repository if available; preserve a checksum and version. Extract the exact LP constraints, solve or recover rational primal/dual witnesses, then verify them independently before Lean formalization. No BBMST-specific LP certificate, Lean compilation, axiom audit, or CI run is claimed by this note.

## New retrieval result (2026-10-26)

Although the C source itself is rejected by the web retrieval layer, the linked output file is accessible as plain text:
https://people.maths.ox.ac.uk/balister/es/coverresults.txt

It contains 2,624 lines. The opening lines say it lists configurations satisfying a displayed bound condition greater than 9.018. For example, its first configuration has 11 hyperplanes over the 4-coordinate product, 331 uncovered points, and reports
c_5(3) − 0.75 c_5(1) = 8.731669, with an adjusted bound of 9.108898 after accounting for omitted hyperplanes (output lines 0–24).

This is a concrete new source artifact for reconstructing the finite geometry and checking output arithmetic. However, these displayed decimal values are outputs, not exact rational certificates; the output alone does not expose all LP constraints or prove the optimizer's result. The next safe step is to recover the corresponding source model and reconstruct exact rational values independently. Source output reference: https://people.maths.ox.ac.uk/balister/es/coverresults.txt

No exact LP certificate or theorem proof is claimed.


## Arithmetic consistency check on the first displayed row

The first row reports c_5(3) = 10.772621 and c_5(1) = 2.721270, followed by
c_5(3) − 0.75 c_5(1) = 8.731669. Direct arithmetic on the displayed rounded decimals gives

10.772621 − 0.75 × 2.721270 = 8.7316685,

which rounds to 8.731669 at six decimal places. This confirms internal rounding consistency for that expression only. It does not validate the omitted-hyperplane adjustment (9.108898), the LP optimization, or the theorem's deduction. All values in the output are displayed decimals and must not be treated as exact rationals.
