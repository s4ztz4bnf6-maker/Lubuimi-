# BBMST: source-faithful model to exact rational certificate

Date: 2026-10-26
Status: original C model inspected; exact rational certificate not extracted; no Lean build claimed.

## Objective

Turn the published finite optimization used in the square-free-moduli covering-system argument into a reproducible exact rational certificate, then formalize the bridge from that finite certificate to the analytic/geometric theorem. Do not infer a certificate from rounded decimal output.

Official supplementary page:
https://www.memphis.edu/msci/people/pbalistr/erdos-selfridge.php

Original C source, now textually accessible:
https://www.memphis.edu/msci/people/pbalistr/coverlp_c.txt

Published result output:
https://www.memphis.edu/msci/people/pbalistr/coverresults.txt

The source comments define a box [3] x [5] x [7] x [11], partially covered by nontrivial hyperplanes. The program uses Gurobi to optimize a probability distribution on the uncovered points, then recomputes hyperplane weights from the returned distribution and checks normalization/nonnegativity. This is an explicit model, not yet an exact certificate.

## Transcribed LP structure from the C source

Let U be the set of uncovered points in the finite box for a fixed hyperplane configuration. Let p_x be the probability assigned to x in U. For each fixed-coordinate set S subset {0,1,2,3}, let v_S bound the total probability of every hyperplane with fixed-coordinate set S.

The objective used by the program is
\[
\sum_{S\subseteq\{0,1,2,3\}}(3^{|S|}-3/4) v_S
=c_5(3)-(3/4)c_5(1).
\]
For each nonempty S and each hyperplane H with fixed-coordinate set S, the source adds a constraint
\[
\sum_{x\in U\cap H}p_x\le v_S.
\]
The normalization constraint is sum_{x in U} p_x=1, and the variables are nonnegative. The source applies symmetry reductions to point variables, so a faithful formalization must either encode those equivalence classes exactly or use the unreduced 3*5*7*11 point space.

Important source conventions: a zero coordinate in the program's hyperplane encoding means “unrestricted” for the nontrivial hyperplanes; codimension-one hyperplanes are separately fixed to coordinate value zero. The point encoding is mixed-radix, explicitly not Chinese-remainder encoding, because the code is intended to allow non-prime dimensions as well.

## Direction-of-inequality audit

The code minimizes the displayed objective, but then validates the returned point distribution and recomputes the objective from the actual maximum hyperplane weights. A feasible point distribution supplies an upper bound on the minimum, not a lower bound. Therefore a formal certificate must match the exact logical role played by the value in the paper's case analysis; it is not enough to say “primal feasible” without specifying the direction of the desired theorem inequality.

A dual certificate is needed if the argument requires a lower bound on the LP optimum. If the argument only requires existence of a distribution whose objective is below a threshold, a primal feasible rational distribution with that objective is sufficient. If the argument needs to certify the optimizer itself, matching primal/dual objectives is the clean route.

The source uses floating-point Gurobi values and tolerances. Its post-check is useful computational validation but is not, by itself, an exact rational certificate.

## Generic exact certificate layer

For a rational minimization problem
\[
\min c^T x\quad\text{subject to } Ax\ge b,\quad x\ge0,
\]
a dual witness y with y>=0 and A^T y<=c gives, for every primal-feasible x,
\[
b^T y\le y^T Ax=x^T A^T y\le c^T x.
\]
A primal-feasible x gives an upper bound; matching exact primal and dual objective values certify optimality. This generic weak-duality theorem still needs to be connected to the source's actual mixed-radix model and theorem inequality.

Lean representation should use finite indices (Fin m, Fin n), rational coefficients, explicit feasibility predicates, and positive-denominator representations for any rational values constructed from ratios. Avoid default-valued lookups or implicit division-by-zero behavior in the certificate path.

## Precision check from the printed output

The output reports rounded values c_5(3)=10.772621 and c_5(1)=2.721270. From those printed decimals alone,
\[
10.772621-\tfrac34(2.721270)=8.7316685,
\]
which rounds to 8.731669. This verifies only the displayed arithmetic. The same output lists 331 uncovered points, a maximum omitted-hyperplane weight of 0.042582, and adjusted bound 9.108898 for its first configuration. These decimals are not exact rational witnesses and do not certify the LP optimum or the final theorem inequality.

## Separate geometric/probabilistic layer

The finite event-incidence matrix G_ij=mu(H_i intersect H_j) is positive semidefinite because
\[
z^T G z=\sum_{\omega\in\Omega}\mu(\omega)
\left(\sum_i z_i 1_{H_i}(\omega)\right)^2\ge0.
\]
This is a general finite-probability identity. The BBMST proof still needs source-faithful definitions of the actual hyperplanes, fibers, distributions, and quantities such as R_k,N_k,B_k,alpha_k, and the exact derivation of the constraints to which the LP is applied.

The local singleton-fiber fact (a hyperplane that fixes the final coordinate has at most one compatible value in that fiber) is not a substitute for the global incidence or moment bound.

## Acceptance checklist

- [ ] Verify the source-to-paper inequality direction and threshold role.
- [ ] Extract the actual configuration enumeration and its symmetry reductions.
- [ ] Recover or construct an exact rational probability distribution for each required configuration.
- [ ] Check every hyperplane-mass constraint and normalization exactly.
- [ ] If needed, provide a dual rational certificate for a lower bound on the LP optimum.
- [ ] Prove the final inequality from the certificate in Lean.
- [ ] Formalize the bridge from the finite box to the global covering-system theorem.
- [ ] Record the transitive axiom audit and build/CI status for the exact commit.

Until the source-to-paper inequality direction and all required certificates are checked, this is an auditable formalization route, not a completed BBMST proof.
