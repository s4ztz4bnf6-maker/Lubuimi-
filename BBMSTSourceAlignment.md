# BBMST source alignment: finite-product hyperplanes

## Source identity

The relevant source for the square-free Erdős–Selfridge problem is:

Paul Balister, Béla Bollobás, Robert Morris, Julian Sahasrabudhe, and Marius Tiba,
“The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory*
15 (2021), no. 3, 609–626. DOI: https://doi.org/10.2140/ant.2021.15.609.

Do not conflate this with the same authors' separate paper “On the Erdős covering
problem: the density of the uncovered set,” *Inventiones Mathematicae* 228 (2022),
377–414, DOI https://doi.org/10.1007/s00222-021-01087-5. The papers are related,
but their theorem numbering and claims are not interchangeable.

## Mapping to the Lean coordinate model

The source's finite-product setting has a product
\[
Q=S_1\times\cdots\times S_n.
\]
A coordinate hyperplane prescribes values on a nonempty set of coordinate indices
\(F(A)\), leaving the other coordinates free. Distinct non-parallel hyperplanes
have distinct fixed-coordinate sets. This gives the following intended mapping:

- CoordinateSpace n: the finite coordinate domains S i;
- CoordinatePoint space: a point of the product, represented as a dependent function;
- CoordinateHypersurface.fixed: the fixed-coordinate set F(A);
- CoordinateHypersurface.value: the prescribed allowed value at each fixed coordinate;
- CoordinateHypersurface.IsNontrivial: fixed.Nonempty;
- CoordinateHypersurface.NotParallel: inequality of the fixed-coordinate sets;
- Contains: membership in the coordinate hyperplane.

The overlap compatibility theorem is an exact incidence fact in this model:
if two hyperplanes share a point, their prescriptions agree on every shared fixed
coordinate. Conversely, because each coordinate domain is nonempty, compatible
prescriptions can be completed to a point of the product. The resulting
intersects_iff_agree_on_overlap theorem captures the intersection criterion for
these coordinate hyperplanes.

## What remains unproved

This source alignment does **not** by itself prove noCodimOneAt or the improved
second-moment bound. The audit must still define the precise codimension condition
used by the proof, show how the actual arithmetic configuration satisfies it, and
derive the moment estimate from the stated hypotheses. No such missing condition
may be introduced as an unconstrained input merely to make the theorem compile.

The CI checks are implementation checks for the Lean statements; they do not
replace this mathematical bridge.
