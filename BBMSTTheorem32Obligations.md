# BBMST theorem-to-Lean obligations: codimension and moments

## Exact source statement

Balister, Bollobás, Morris, Sahasrabudhe, and Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), 609–626, DOI https://doi.org/10.2140/ant.2021.15.609, defines a hyperplane in a finite product \(Q=S_1\times\cdots\times S_n\) by fixing a subset of coordinates and leaving the others free. The set \(F(A)\) is the fixed-coordinate set. Parallelism is exactly equality of these fixed-coordinate sets.

Theorem 3.2 gives the general bound
\[
M_k^{(2)}\le \frac{c_{k-1}(3)}{|S_k|^2}.
\]
Under the additional hypotheses \(|S_k|\ge3\) and that none of the newly exposed hyperplanes in \(\mathcal N_k\) has codimension one, it gives the improved bound
\[
M_k^{(2)}\le
\frac{c_{k-1}(3)-2c_{k-1}(1)+1}{|S_k|^2}.
\]

In this discrete product geometry, codimension one means exactly one fixed coordinate, i.e. \(|F(A)|=1\). This is not a theorem that every configuration automatically satisfies. It is a separate hypothesis on the stage family \(\mathcal N_k\).

## Concrete Lean mapping

The geometry sandbox now defines:
- HasCodimensionOne H as H.fixed.card = 1;
- NoCodimensionOneAt stage as every hyperplane in the given stage family having fixed-coordinate cardinality different from one;
- intersects_iff_agree_on_overlap as the exact intersection criterion for coordinate cylinders.

These definitions remove the ambiguity in the former abstract predicate. They do not prove that the arithmetic configuration satisfies NoCodimensionOneAt; that must be shown at the application site from the actual family of square-free moduli / fixed-coordinate sets.

## Proof route and failure modes

1. Define a stage family \(\mathcal N_k\) from the same finite family of hyperplanes used to define \(B_k\).
2. Prove its membership and fixed-coordinate set agree with the source's definitions, not a parallel surrogate.
3. Prove the stage-specific fact \(\forall A\in\mathcal N_k,\ |F(A)|\ne1\) from the source's arithmetic restrictions. If singleton fixed sets are possible, the improved bound is not available for that stage; use the general bound instead or split off those cases as the source does.
4. Formalize the first and second moments from the finite probability distribution and the function \(\alpha_k(x)\), then prove the general and improved bounds from the corresponding combinatorial counting statements.
5. Only after this derivation should the theorem be connected to the sieve criterion and validated numerical parameters.

The source's supplementary page provides executable C code for the finite linear-programming distributions and for optimizing the parameters \(d_k\) for \(6\le k\le21\). This is a useful independent computational cross-check, but it is not a replacement for the proof of the geometric and moment inequalities.

## Sources

- Original paper: https://arxiv.org/abs/1901.11465
- Published version: https://doi.org/10.2140/ant.2021.15.609
- Supplemental code and outputs: https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html
