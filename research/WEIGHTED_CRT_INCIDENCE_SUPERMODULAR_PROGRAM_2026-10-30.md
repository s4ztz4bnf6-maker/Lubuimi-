# Weighted CRT incidence programme: product base measure, supermodular correction, and exact moments

Date: 30 October 2026

## Status

Research design and definitions only. This document states no new global theorem and makes no Lean, compilation, or CI claim. Its purpose is to fix a mathematically testable next experiment and prevent a premature jump from a Gram matrix to a global inequality.

## 1. Exact finite CRT model

Let a hypothetical finite odd covering system have moduli m_1,...,m_n and let

  L = lcm(m_1,...,m_n) = product_{p in P} p^{e_p}.

The CRT space is

  Omega_L = product_{p in P} Z/(p^{e_p})Z.

For each congruence class C_i = {x : x = a_i mod m_i}, define

  X_i(x) = 1_{x in C_i},    S(x) = sum_i X_i(x).

A covering is exactly the pointwise condition S(x)>=1 on Omega_L.

The uniform first moment is

  E_unif[S] = sum_i 1/m_i.

It is only a necessary condition and does not encode the residue compatibility structure.

## 2. The weighted-measure certificate

For any probability measure mu on Omega_L,

  E_mu[S] = sum_i mu(C_i).

Since a covering has S(x)>=1 everywhere, every probability measure obeys

  sum_i mu(C_i) >= 1.                                      (W)

Consequently, a structurally constructed measure mu with

  sum_i mu(C_i) < 1                                         (WC)

would certify noncoverage.

Important limitation: optimizing over all probability measures is tautological, since the minimum of E_mu[S] is min_x S(x). The research target is therefore a restricted, explicit family of measures whose parameters and inequalities can be controlled from the modulus/residue data without already knowing an uncovered point.

## 3. Hierarchical weight family

Start with local probability distributions mu_p on Z/p^{e_p}Z and the product measure

  mu_0(x) = product_p mu_p(x_p).

Then allow bounded-order interactions:

  w(x) = Z^{-1}
         product_p w_p(x_p)
         product_{p<r} w_{pr}(x_p,x_r)
         product_{p<r<s} w_{prs}(x_p,x_r,x_s),

where all factors are nonnegative and Z is the exact normalizing sum.

This is a finite log-linear / Gibbs family on CRT coordinates. The pair and triple potentials must be derived from actual congruence compatibility data, not selected after inspecting a desired conclusion. A first experiment should compare:
- order 0: product measures only;
- order 2: pair interactions;
- order 3: pair and triple interactions.

The desired certificate is (WC). If no measure in a given family achieves (WC), that is a limitation of the ansatz, not evidence for a covering.

## 4. Divisor-exponent lattice and supermodularity

The modulus exponents form the finite product lattice

  E_L = product_{p in P} {0,1,...,e_p}.

For exponent vectors u,v, define coordinatewise meet and join. A potential Phi:E_L->R is supermodular when

  Phi(u)+Phi(v) <= Phi(u meet v)+Phi(u join v).

This is the appropriate exponent-lattice formulation; the squarefree support lattice 2^P is only the special case e_p=1.

A candidate weight on modulus profiles may take the form exp(Phi(u)), but this must not be confused with the residue-space Gibbs weight above. The former weights modulus types; the latter weights CRT points. A valid proof must specify the map between them and show that the resulting induced point measure has the claimed class probabilities.

## 5. Exact incidence matrices and moment tensors

Enumerate Omega_L only for small test instances. Let B be the |Omega_L| by n incidence matrix

  B[x,i] = X_i(x).

For a probability vector w on Omega_L, set W=diag(w) and

  G = B^T W B.

Then G_ij = mu(C_i intersect C_j), and G is positive semidefinite. The first-moment vector is

  c = B^T w,    c_i = mu(C_i).

The certificate objective is 1^T c = sum_i mu(C_i), which must be <1 to contradict coverage.

For k>=2 define exact intersection tensors

  T^(k)_{i_1,...,i_k} = mu(C_{i_1} intersect ... intersect C_{i_k}).

They give

  E_mu[binom(S,k)] = sum_{i_1<...<i_k} T^(k)_{i_1,...,i_k}.

The tensors are needed to diagnose whether pairwise correlations conceal higher-order clustering. They do not, by themselves, prove (WC); a proposed inequality must connect them to a constructible measure or to a strict lower/upper bound on the first moment.

## 6. Compatibility structure

For each subset I of class indices, the intersection is empty unless the residue congruences are pairwise compatible on every shared prime-power coordinate. If compatible, its density under the uniform measure is 1/lcm(m_i : i in I).

This gives an exact compatibility hypergraph:
- vertices: congruence classes;
- an edge I: the classes in I have a nonempty common intersection;
- edge label: the exact lcm and, for weighted measures, the exact weighted intersection mass.

Pairwise compatibility is not enough in arbitrary constraint systems unless the relevant congruence conditions satisfy the generalized CRT compatibility criterion prime-power coordinate by prime-power coordinate. The implementation must check the full coordinate conditions, not infer a higher intersection from a graph clique without proof.

## 7. First experimental protocol

Use small, exact rational instances before any large search.

1. Generate or import a finite odd-modulus family and its residue classes.
2. Compute L, the CRT coordinate space, and the exact incidence matrix B.
3. Compute the exact compatibility hypergraph and all pair intersections; add triple intersections.
4. Solve the restricted rational optimization problem over product measures. Record whether the best objective reaches below 1.
5. Add pair potentials and then triple potentials, with normalization exact or rigorously interval-certified.
6. Compare the objective and identify which compatibility patterns change it.
7. For each successful candidate, extract a symbolic inequality in terms of prime-power exponents and residue compatibility. Only that symbolic inequality can become a proof lemma.

Do not use floating-point optimization as proof evidence. Use rational LP where the parametrization is linear; otherwise use certified interval bounds and independently verify every resulting rational certificate.

## 8. The next lemma to target

A useful nontrivial target is not simply “the Gram matrix is PSD” (which is automatic). It is a **conditional incidence inequality** of the following form:

For a specified structured measure family M_struct, derive an explicit lower bound on

  sum_i mu(C_i)

in terms of:
- the prime-power exponent profile (e_p);
- the number and distribution of distinct prime supports;
- the exact compatibility hypergraph;
- a bounded collection of pair/triple conditional moments.

Then show that for every hypothetical odd distinct covering satisfying the currently known rank/support constraints, there is a member mu in M_struct for which the same quantity is strictly less than 1.

The second clause is the real global gap. The rank-nine support statement alone does not imply it.

## 9. Falsification tests and guardrails

Any proposed inequality must survive:
- arbitrary residue shifts for fixed moduli;
- non-squarefree moduli and uneven exponent vectors;
- repeated prime support patterns;
- systems with strong pairwise compatibility but empty triple intersections;
- examples where pairwise intersection sums are large but the actual uncovered density is positive.

A small-instance counterexample to a candidate inequality invalidates that inequality, not the Erdős–Selfridge conjecture.

No global theorem is claimed here. The note is a concrete research specification for the weighted-incidence phase.
