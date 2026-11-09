# Research frontier — BBMST product-box moment bridge (2026-10-24)

## Objective
Replace the project-specific global sieve axioms only after the published product-space geometry and moment bounds have been formalized. This note is a proof plan, not a proof of Erdős–Selfridge.

## Source-faithful model
Use the 2021 BBMST paper as the source of truth. The sample space is
`Q = S₁ × ⋯ × Sₙ`. A hyperplane fixes selected coordinates to singleton values. Its event consists of product points matching all those fixed values. Two events intersect exactly when their fixed assignments agree on every shared fixed coordinate. The current `BBMSTProductBox.lean` formalizes this exact intersection/disjointness criterion.

## New quantitative bridge to implement
Assume each coordinate type `S i` is finite and nonempty, and equip `Q` with the uniform product measure. For a hyperplane H with support F(H), the intended exact formulas are:
- `P(E_H) = ∏_{i∈F(H)} 1 / |S_i|`;
- if H and K conflict on a shared fixed coordinate, `P(E_H ∩ E_K)=0`;
- otherwise, `P(E_H ∩ E_K) = ∏_{i∈F(H)∪F(K)} 1 / |S_i|`.

These formulas reduce the second moment to a weighted sum grouped by the union/overlap of fixed-coordinate supports. They do **not** imply independence: if supports overlap compatibly, the intersection probability is generally not the product of marginal probabilities.

### Formalization sequence
1. Define the finite product sample type and its uniform rational mass; prove total mass is one and every point has nonnegative mass.
2. Prove the single-event cardinality/mass formula by counting free coordinates.
3. Prove the pair-intersection formula, splitting the incompatible and compatible cases.
4. Express `M_k^(1)` and `M_k^(2)` from the paper's conditional distribution `P_k` and `α_k`; do not silently substitute uniform measure if the paper's reweighted `P_k` is in use.
5. Formalize Theorem 3.2's first- and second-moment bounds with every geometric hypothesis explicit.
6. Apply the corrected Theorem 3.1 union-bound argument to obtain positive uncovered mass.
7. Only then revisit `sieve_criterion` and `sf_sieve_lt_one`; neither axiom is discharged by indicator expansions or scalar fiber normalization.

## Important edge cases
- Empty coordinate supports produce the whole space and probability one.
- Empty coordinate types make the product space empty; exclude them by nonemptiness assumptions rather than hiding them in totalized division.
- Rational division by zero is totalized in Lean, so every probability formula must carry a positive-cardinality denominator proof.
- A nonempty uncovered set alone gives only a point-count bound; it does not automatically yield the uniform positive mass required by the theorem.
- A rank-defect identity from linear algebra is not a substitute for the paper's product-box support geometry.

## Reliability protocol
Every theorem must be checked against the exact pinned paper statement, compiled on the target commit, and included in the transitive axiom trace. Record the Lean version and dependency commit. Kernel checking establishes the formal statement only; human statement-fidelity review remains necessary, especially given the documented 2026 Lean soundness incidents.

## Non-claims
The global Erdős–Selfridge result is not yet derived from the current Lean files. The two project-specific sieve axioms remain open obligations until replaced by proof terms establishing the source-specific moment estimates and existence of valid parameters.
