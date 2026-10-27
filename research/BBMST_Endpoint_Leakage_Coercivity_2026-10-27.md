# BBMST gap coercivity: endpoint leakage as the exact missing quantity
Date: 2026-10-27
Status: exact finite-probability identities and reduction; original geometric estimate remains open here

## 1. Abstract interface

Let (p_i) be a finite probability vector, p_i >= 0 and sum_i p_i = 1, and let 0 <= alpha_i <= 1. Define
Gamma = sum_i p_i alpha_i(1-alpha_i).
The previous interface counterexample p_i=alpha_i=1/n has Gamma=(1/n)(1-1/n)->0. Thus normalization and alpha bounds alone cannot produce a uniform positive gap.

## 2. A sharper exact quantity: endpoint leakage

Define ell_i=min(alpha_i,1-alpha_i), and L=sum_i p_i ell_i.
Since max(alpha_i,1-alpha_i) lies in [1/2,1],
alpha_i(1-alpha_i)=ell_i(1-ell_i) >= ell_i/2.
Also alpha_i(1-alpha_i) <= ell_i. Summing gives the exact two-sided comparison
1/2 L <= Gamma <= L.
Hence a uniform lower bound Gamma >= delta is equivalent, up to factor 2, to a uniform lower bound on the weighted endpoint leakage L. This reframes the missing geometric statement: the source geometry must force a definite amount of weighted alpha-mass away from both 0 and 1. Merely proving that some alpha_i is non-endpoint is insufficient; its p_i-weight could tend to zero.

A threshold version is equally exact. For 0 < epsilon <= 1/2, let
M_epsilon=sum_{epsilon<=alpha_i<=1-epsilon} p_i.
Then Gamma >= epsilon(1-epsilon) M_epsilon.
Thus it is enough to establish both a fixed epsilon and a uniform lower bound M_epsilon >= m > 0 from the original hyperplane/probability construction. Conversely, a direct Gamma >= delta estimate avoids choosing epsilon and is logically the shorter route if the geometry supplies it.

## 3. Why a mean-only or variance-only shortcut cannot close the gap

Writing mu=sum p_i alpha_i and Var(alpha)=sum p_i(alpha_i-mu)^2 gives
Gamma = mu(1-mu)-Var(alpha).
A bound on mu away from 0 and 1 is not sufficient: mass concentrated at alpha=0 and alpha=1 can have mu=1/2 but Gamma=0. A variance bound is also not sufficient in isolation unless combined with a bound on mu. The robust target is endpoint leakage or the direct gap Gamma, derived from the actual BBMST hyperplane arrangement and not postulated as a free parameter.

## 4. Formalization gate

The Lean development should keep three claims separate:
(A) finite algebra: Gamma = sum p_i alpha_i(1-alpha_i), endpoint-leakage inequalities, and the epsilon-threshold inequality;
(B) geometric theorem: the original BBMST hypotheses force L >= c or Gamma >= delta with a source-derived constant;
(C) sieve conclusion: the exact source theorem follows from (B) and the original cited lemmas.

Only (A) is an abstract finite-probability calculation. (B) is the substantive bottleneck. The project-local assumptions sf_sieve_lt_one and sieve_criterion cannot be treated as proved facts; the target theorem is not unconditional while they remain axioms. An axiom audit and exact source-statement match are release gates, not optional documentation.

## 5. Exact source-fidelity warning

The intended theorem is the specific square-free odd-covering result of Balister, Burger, Meijer, Sole and Tijdeman, with its original finite probability spaces, hyperplane data and alpha parameters. Do not replace those constraints by arbitrary abstract alpha_i, or add freely chosen predicates that encode the desired conclusion. The family alpha_i=1/n disproves only the abstract interface, not the source theorem: no claim is made that this family comes from the required BBMST geometry.

## 6. Next falsifiable milestone

The next valid milestone is to derive, from the source-defined hyperplanes and R_k/N_k/B_k data, one of:
1. an explicit epsilon,m > 0 with M_epsilon >= m uniformly over the relevant admissible instances;
2. a direct positive lower bound Gamma >= delta; or
3. a source-valid sequence of admissible configurations with Gamma -> 0, which would falsify the proposed uniform-gap route and force a different proof of the sieve theorem.

No such geometric bound or source-valid counterexample is claimed here. No Lean build or CI run is claimed.
