# BBMST overlap covariance as a signed sparse operator (2026-10-25)

## Status
This is a general finite-dimensional identity and a proposed proof route. It is not a derivation of the paper's source-specific sieve estimate and does not prove the BBMST theorem.

## Covariance operator
Let E_H be the finite family of product-box events from the exact covariance note, and let X_H=1_{E_H}. Define the real symmetric matrix C by C_{HK}=Cov(X_H,X_K). Then C is positive semidefinite: for every real vector z, z^T C z = Var(sum_H z_H X_H) >= 0. The desired variance is Var(sum_H X_H)=1^T C 1.

## Exact sparsity and sign
If the coordinate supports F_H and F_K are disjoint, C_HK=0. If they overlap, C_HK is positive when the coordinate prescriptions agree on all shared coordinates, with value p_H p_K (Q(H,K)-1), and negative when any shared coordinate conflicts, with value -p_H p_K. Thus the covariance operator is sparse on the support-overlap graph but signed on its edges.

## A rigorous coarse bound
By the spectral theorem and the maximum absolute row-sum bound for a real symmetric matrix,
Var(sum_H X_H) = 1^T C 1 <= |V| * lambda_max(C) <= |V| * max_H sum_K |C_HK|.
The final inequality follows from the standard induced infinity norm bound for eigenvalues of a symmetric matrix. Substituting the exact pair formula gives a fully explicit, though potentially weak, upper bound:
Var(sum_H X_H) <= |V| * max_H [p_H(1-p_H) + sum_{K != H, compatible} p_H p_K (Q(H,K)-1) + sum_{K != H, incompatible} p_H p_K].

## What this does and does not buy us
This turns the positive-overlap problem into a weighted local-degree estimate. It is useful only if the original BBMST geometry bounds the displayed row sums sharply enough. A mere finite bound proves no strict probability inequality; one must derive the row-sum estimate from the paper's actual hypotheses and constants. Negative incompatible covariances are discarded in the absolute-row-sum bound, so this method can be weaker than exploiting cancellation in the original argument.

## Lean proof plan
(1) Define the finite indicator covariance matrix; (2) prove positive semidefiniteness by expanding variance; (3) prove zero covariance for disjoint coordinate supports; (4) prove the signed pair formula from the intersection-cardinality lemma; (5) import or prove the finite-dimensional spectral/row-sum inequality; (6) instantiate the bound with the actual BBMST hyperplane family. Keep each stage independent of any assumed sieve conclusion and run the transitive axiom audit.

## Audit warning
Do not replace the source's geometric estimate by an unconstrained overlapBound, and do not infer Var(X)<(E X)^2 from sparsity alone. The decisive missing work remains the paper-faithful bound on the weighted overlap row sums (or a stronger cancellation argument).