# BBMST finite-cylinder mass: proof obligations and alternatives

Status: research/design note, not a theorem and not a claim that the BBMST theorem has been formalized.

## Mathematical target

For a finite product space
\[
X=\prod_{i\in I} X_i,\qquad
w(x)=\prod_{i\in I}w_i(x_i),\qquad
\sum_{t\in X_i}w_i(t)=1,
\]
and a coordinate cylinder fixing the coordinates in F to values v_i, the target is
\[
\mu(H)=\sum_{x\in X} 1_H(x)w(x)
       =\prod_{i\in F}w_i(v_i).
\]
This formula must be derived from the point-weight definition and coordinate normalization, not postulated as an axiom.

## Lean proof decomposition

1. **Incidence layer (already represented in BBMSTGeometryTest.lean).**
   A common point forces agreement on every shared fixed coordinate. Conversely, agreement on the overlap permits the free coordinates to be filled because each coordinate domain is nonempty. This gives the exact compatibility criterion for two cylinders.

2. **Pointwise factor layer (already represented).**
   On a point satisfying a cylinder, split the point-weight product into fixed-coordinate and free-coordinate factors. The current lemma factorizedPointWeight_split_on_cylinder is only this pointwise factorization; it is not the mass formula.

3. **Finite summation layer (next formal obligation).**
   Prove a finite product-summation lemma with a coordinatewise indicator/delta factor. For a fixed coordinate, the sum of the delta-weight is exactly the prescribed weight; for a free coordinate, the sum is one. Applying the finite product-sum identity then yields the cylinder mass.

4. **Intersection layer.**
   If two cylinders disagree at any shared fixed coordinate, their intersection is empty and has zero mass. If they agree on the overlap, merge their prescriptions on F₁ ∪ F₂; the same cylinder-mass theorem gives the intersection mass as the product over the union, with each shared coordinate counted once.

5. **Second-moment layer.**
   Define the cover count Z(x) = sum_j 1_{H_j}(x). Derive
   \[
   \mathbb E[Z^2]
   =\sum_j\mu(H_j)+\sum_{j\ne k}\mu(H_j\cap H_k)
   \]
   by finite-sum algebra. Do not discard intersection terms or replace them by products unless independence has separately been proved.

## Literature and limitation

Balister, Bollobás, Morris, Sahasrabudhe and Tiba's distortion method controls changes of measure quantitatively; their covering-system papers show why a crude sum-of-probabilities bound is not always enough. The formal project should keep exact finite-product identities separate from later quantitative distortion estimates. See:

- P. Balister et al., *Erdős covering systems*, Acta Mathematica Hungarica 161 (2020), 540–549, DOI: 10.1007/s10474-020-01048-z.
- P. Balister et al., *On the Erdős covering problem: the density of the uncovered set*, Inventiones Mathematicae 228 (2022), 377–414, DOI: 10.1007/s00222-021-01087-5.

## Alternative route if the direct dependent-product proof becomes brittle

First prove a reusable theorem for a finite index type and arbitrary finite coordinate types: summing a product of coordinate functions with coordinatewise predicates factors into the product of coordinate sums. Then instantiate the predicate as equality to the prescribed cylinder value. This isolates dependent-type bookkeeping from the probability argument and is likely easier to audit than proving the entire cylinder mass theorem in one tactic block.

## Verification boundary

No claim in this note establishes the source-specific BBMST hyperplane estimates, the theorem's global hypotheses, or an axiom-free end-to-end proof. The note records a concrete decomposition of the remaining formal obligations.
