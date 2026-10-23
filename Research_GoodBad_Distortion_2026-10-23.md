# Research continuation: good/bad-state distortion for BBMST
Date: 2026-10-23

## Scope and status

This is a research design note, not a proof of the Erdős–Selfridge conjecture. Current work isolates finite product normalization, cylinder-coordinate sums, event-mass inequalities, and pointwise distortion-transfer interfaces. The latest CI for the current head was still running when checked; a prior run failed in the free-coordinate branch of cylinderCoordinateSum_eq. The current source has since been changed to use simp only [dif_neg hfix] followed by exact w.coordinate_sum_one i; that change is not treated as verified until CI succeeds.

## Literature and its methodological lesson

Balister, Bollobás, Morris, Sahasrabudhe and Tiba, *On the Erdős covering problem: the density of the uncovered set*, Inventiones Mathematicae 228 (2022), 377–414, develops a distortion method and proves major results about covering systems, including progress on Erdős–Selfridge. Their earlier exposition *Erdős covering systems*, Acta Mathematica Hungarica 161 (2020), 540–549, describes the distortion/hyperplane framework.

References:
- https://doi.org/10.1007/s00222-021-01087-5
- https://doi.org/10.1007/s10474-020-01048-z

The methodological bottleneck for our formalization is quantitative, not merely algebraic. A product factorization or a generic pointwise transfer lemma does not produce the stagewise distortion constants required by the source argument. A global pointwise likelihood-ratio bound may also be too strong for a useful abstraction.

## Exact finite algebraic layer

For a product weight W(x) = product_i w_i(x_i) and a coordinate cylinder fixing coordinates F to values v_i, the target identity is
mass(H) = product_{i in F} w_i(v_i),
provided each coordinate weight is normalized and the point space is the full finite product. The proof obligations are:
1. bridge the filtered event sum to a product of coordinate sums;
2. factor the finite dependent product sum;
3. show fixed coordinates contribute their prescribed weight and free coordinates contribute 1.

For overlapping cylinders, compatible prescriptions combine on the union of fixed coordinates; incompatible prescriptions have empty intersection. One must not multiply arbitrary cylinder masses when fixed-coordinate sets overlap.

## Proposed alternative: good/bad-state distortion

Instead of demanding a uniform pointwise comparison on every state, split the finite state space into Good and Bad:
- on Good, prove μ.weight x ≤ C * ν.weight x;
- on Bad, do not impose a ratio bound, but prove an independent absolute estimate eventMass μ (fun x => not Good x) ≤ η.

Then for every event E, the intended transfer is
eventMass μ E ≤ C * eventMass ν E + η.
This follows by splitting the finite sum over E into E intersect Good and E intersect Bad, applying pointwise domination on the first part and bounding the second by the total bad-state mass. It is a generic finite inequality; the mathematical challenge is to choose Good so that C remains controlled and η is summable across stages.

The dual lower-bound form can be pursued when a lower pointwise comparison holds on Good, together with a bound on the bad mass under the reference distribution. Keep the upper and lower transfer statements separate until their measure assumptions are explicit.

## Stagewise budget rather than informal multiplication

For stage j, seek constants C_j and bad mass η_j. Iterating the proposed upper transfer yields a bound of the schematic form
μ_0(E) ≤ (product_{j<m} C_j) μ_m(E) + sum_{j<m} η_j (product_{i<j} C_i),
with the exact indexing/order to be proved for the chosen direction of transfer. This shows the two budgets that matter: multiplicative distortion and accumulated exceptional mass. A proof that controls only one of them is incomplete.

## Immediate Lean target

Add and kernel-check a generic lemma proving the good/bad upper-transfer inequality for finite CoordinatePoint spaces, then a composition lemma that carries the explicit weighted sum of bad-mass errors. Keep it independent of the particular BBMST parameters. Only after this interface compiles should the source-specific geometry be used to derive C_j and η_j.

## Audit requirements

- The generic lemma must not assume independence.
- All weights and constants must have the sign hypotheses needed for multiplication inequalities.
- No arbitrary isNontrivial, isParallel, or codimension assumptions may substitute for the source's actual geometry.
- An axiom printout containing only the standard classical/propositional quotient axioms is not evidence that the original theorem's substantive hypotheses have been correctly formalized.
