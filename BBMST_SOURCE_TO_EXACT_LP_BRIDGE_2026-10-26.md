# BBMST: source-faithful model to exact rational certificate

Date: 2026-10-26
Status: formalization plan with explicit verification boundary; no BBMST-specific LP certificate extracted and no Lean build claimed.

## Objective

Turn the published finite optimization used in the square-free-moduli covering-system argument into a reproducible exact rational certificate, then formalize the bridge from that finite certificate to the analytic/geometric theorem. Do not infer a certificate from rounded decimal output.

Official supplementary page:
https://people.maths.ox.ac.uk/balister/Erdos-Selfridge.html

Published result output:
https://people.maths.ox.ac.uk/balister/es/coverresults.txt

The supplementary description says that the initial distribution on [3] × [5] × [7] × [11] is checked with C code and Gurobi solving multiple linear programs, and provides outputs/configurations and a portable C program. The numerical output is not itself an exact primal/dual witness.

## Certificate layer

For a rational minimization problem
\[
\min c^T x\quad\text{subject to } Ax\ge b,\quad x\ge0,
\]
a dual witness y with y>=0 and A^T y<=c gives, for every primal-feasible x,
\[
b^T y\le y^T Ax=x^T A^T y\le c^T x.
\]
A primal-feasible x gives an upper bound; matching exact primal and dual objective values certify optimality. This is a generic weak-duality argument, not yet the BBMST theorem.

Lean representation should use finite indices (Fin m, Fin n), rational coefficients, explicit feasibility predicates, and positive-denominator representations for any rational values constructed from ratios. Avoid default-valued lookups or implicit division-by-zero behavior in the certificate path.

## Required source-to-model bridge

Before entering a solver witness, extract and document:

1. The exact decision variables and their indexing from the published C source.
2. Every primal constraint and objective, including normalization and symmetry reductions.
3. The dual convention and coefficient signs.
4. The exact correspondence between the source's finite probability/hyperplane model and the matrix A, vector b, and cost c.
5. The exact rational primal and dual witnesses, or a rational reconstruction plus a check of every constraint.
6. The final inequality that turns the finite optimization bound into the theorem's claimed global bound.

The C source link may not be textually retrievable through the current search interface. If source code cannot be inspected, the model must remain marked unreconstructed; do not fabricate A, b, c, or a dual vector from the printed decimals.

## Precision check already established

The accessible output reports rounded values
\[
c_5(3)=10.772621,\qquad c_5(1)=2.721270.
\]
Using only those printed decimals,
\[
10.772621-\tfrac34(2.721270)=8.7316685,
\]
which rounds to 8.731669. This checks the displayed arithmetic only. It does not verify the underlying LP optimum, the omitted-hyperplane adjustment, or the theorem's final bound.

## Separate geometric/probabilistic layer

The finite event-incidence matrix G_ij=mu(H_i intersect H_j) is positive semidefinite because
\[
z^T G z=\sum_{\omega\in\Omega}\mu(\omega)
\left(\sum_i z_i 1_{H_i}(\omega)\right)^2\ge0.
\]
This is a general finite-probability identity. The BBMST proof still needs source-faithful definitions of the actual hyperplanes, fibers, distributions, and quantities such as R_k,N_k,B_k,alpha_k, and the exact derivation of the constraints to which the LP is applied.

The local singleton-fiber fact (a hyperplane that fixes the final coordinate has at most one compatible value in that fiber) is not a substitute for the global incidence or moment bound.

## Acceptance checklist

- [ ] Source model transcribed and independently reviewed.
- [ ] Exact rational primal witness satisfies every constraint.
- [ ] Exact rational dual witness satisfies every constraint.
- [ ] Objectives match exactly, not merely after decimal rounding.
- [ ] Lean theorem proves weak duality and checks the concrete witnesses.
- [ ] Transitive axiom audit recorded.
- [ ] Separate proof establishes that the LP bound implies the published covering-system theorem.
- [ ] Compiler/CI status recorded for the exact commit.

Until all relevant boxes are checked, this is an auditable route toward a certificate, not a completed BBMST proof.
