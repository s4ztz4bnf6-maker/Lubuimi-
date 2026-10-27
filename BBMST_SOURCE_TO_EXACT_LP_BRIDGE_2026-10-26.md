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


## Update 2026-10-26: an external exact-certificate reconstruction already exists

A fresh search found a substantially more advanced independent source:
https://github.com/plasma-ai/erdos/tree/05a6a79d5c64985d0e8a73697fd63a2731d6acc4/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli

Its accompanying problem page reports:
https://erdosproblems.ai/wiki/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli

The page describes the published BBMST proof chain, 9,283 primal certificates for the exhaustive configuration tree in Lemma 5.4, exact integer/rational checking on all 480 points, a strict bound 9.018071, a rational vector for Lemma 5.3, and exact integer recurrence checks for Corollary 5.2. The checker is:
https://github.com/plasma-ai/erdos/blob/05a6a79d5c64985d0e8a73697fd63a2731d6acc4/library/covering_systems/balister_2021_erdos_selfridge_problem_square_free_moduli/evidence/verify_bbmst_squarefree.py

The checker source was fetched and inspected. Its header explicitly says that the retained integer primal weights were proposed by an independent SciPy/HiGHS replay, while the checker itself uses exact arithmetic and does not trust an optimizer. The page explicitly labels this an ordinary computational proof certificate, not a Lean build.

This changes the optimal next step. We should NOT spend effort rebuilding all 9,283 primal certificates from the rounded Oxford Gurobi output. Instead:
1. Independently retrieve and run the pinned exact checker and preserve its output, if the source/certificate can be materialized.
2. Audit the exact certificate's mathematical correspondence to the published Lemma 5.4, including the 480-point box Q5=[2]x[4]x[6]x[10], the 9.018071 bound, and the zero-mass/survival conventions.
3. Formalize the checker-level finite arithmetic and the generic rational feasibility/measure lemmas in Lean, with a source-to-paper statement map.
4. Only then connect Lemma 5.4 to Lemma 5.3, Corollary 5.2, Theorem 1.2, and the Chinese-remainder equivalence in Theorem 1.1.

Important boundary: this external reconstruction is strong computational evidence and a finite-certificate proof chain, but it is not Lean-verified. It is not our repository's code and has not been run in this environment. Do not claim an independent replay, Lean build, or completed formalization.

The external page also identifies a source-text nuance: the published prose after equation (21) appears to say the normalization factor is (1-p), while the displayed formula and reconstruction use 1/(1-p). The reconstruction explicitly records this as a discrepancy in the source presentation, not as an author-issued erratum. This is a key statement-fidelity check for our audit.
