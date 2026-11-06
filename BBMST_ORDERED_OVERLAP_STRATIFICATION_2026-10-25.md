# BBMST overlap sum: exact bookkeeping before global estimates

Status: research/audit note. It records the mathematically justified next bridge from the product-box intersection formula to a second-moment decomposition. It does not claim the global BBMST theorem.

## 1. Start with the ordered pair identity

For a finite family of events H in a finite probability space, let
[
X=\sum_{H\in\mathcal H}\mathbf 1_H.
]
Pointwise, and hence after taking expectations,
[
\mathbb E[X^2]=\sum_{(H,K)\in\mathcal H\times\mathcal H}\mathbb P(H\cap K).
]
The pair set is ordered: (H,K) and (K,H) are separate summands. Any regrouping must preserve this multiplicity, including diagonal pairs H=K.

## 2. Product-box intersection mass

For product-coordinate spaces S_i and fixed-coordinate sets F_H,F_K, a conflict on a shared fixed coordinate makes H∩K empty. Otherwise the intersection fixes precisely F_H∪F_K. Under the uniform product measure,
[
\mathbb P(H\cap K)=
\begin{cases}
0,&\text{if the shared assignments conflict},\\
\displaystyle\frac{\prod_{i\notin F_H\cup F_K}|S_i|}{\prod_i|S_i|},
&\text{otherwise}.
\end{cases}
]
This is the local kernel represented by `product_box_intersection_uniform_mass_compatible_or_zero` in `BBMSTProductBox.lean`.

The support identity
[
|F_H\cup F_K|=|F_H|+|F_K|-|F_H\cap F_K|
]
is exact, but cardinality of the overlap alone does not determine the mass when the coordinate spaces have unequal sizes or the supports have different sizes.

## 3. Safe stratification

Define r(H,K)=|F_H∩F_K| and let Compat(H,K) mean that the two assignments agree on every shared fixed coordinate. Then the exact second moment can be regrouped as
[
\mathbb E[X^2]
=\sum_{r\ge0}\ 
\sum_{\substack{(H,K)\text{ ordered}:\ r(H,K)=r}}
\mathbf 1_{\mathrm{Compat}(H,K)}
\frac{\prod_{i\notin F_H\cup F_K}|S_i|}{\prod_i|S_i|}.
]
This is bookkeeping, not yet a useful upper or lower bound. A Lean proof should establish the finite reindexing identity without dropping diagonal pairs or replacing compatibility by independence. If all coordinate sizes equal q and every event fixes exactly k coordinates, the compatible pair mass simplifies to q^{-(2k-r)}; that simplification must not be used in the heterogeneous case.

## 4. Next proof obligations

1. Formalize the finite regrouping by overlap size r while preserving ordered-pair multiplicity.
2. Prove any claimed combinatorial bound on the number of compatible pairs in each stratum from the actual BBMST hypotheses.
3. Reproduce the published theorem's exact assumptions and conclusion before translating its global estimates into Lean.
4. Audit all key dependencies, especially any placeholders such as `sieve_criterion` or `sf_sieve_lt_one`. They cannot be treated as proved merely because dependent files compile.

The exact product-box formula and finite second-moment identity are necessary ingredients, not the global BBMST/Erdős–Selfridge conclusion. No global theorem is claimed here.
