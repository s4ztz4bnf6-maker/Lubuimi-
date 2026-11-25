# BBMST source-fidelity correction: the finite-field overlap model is not Theorem 3.1

Date: 2026-10-27

## Audit finding

The generic finite-uniform-space hyperplane second-moment model in `BBMST_NORMALIZED_OVERLAP_PRESSURE_2026-10-27.md` is mathematically valid under its own hypotheses, but it is **not a faithful formalization of the source theorem used in the square-free Erdős–Selfridge argument**. Treat it as a side model / diagnostic only, not as the theorem's probability space or proof bridge.

The source paper is Balister, Bollobás, Morris, Sahasrabudhe and Tiba, *The Erdős–Selfridge problem with square-free moduli*, Algebra & Number Theory 15 (2021), no. 3. The available source text states Theorem 3.1 for a product space Q=S_1×···×S_n, a collection of nontrivial hyperplanes with no two parallel, reweighted measures P_k, functions α_k, moments
\[
M_k^{(1)}=\mathbb E_{k-1}[\alpha_k],\qquad M_k^{(2)}=\mathbb E_{k-1}[\alpha_k^2],
\]
and parameters δ_k∈[0,1/2]. Its criterion is
\[
\sum_{k=a+1}^{n}\min\left\{M_k^{(1)},\frac{M_k^{(2)}}{4\delta_k(1-\delta_k)}\right\}<1.
\]
Under those source hypotheses, the family does not cover Q.

Source PDF / accessible text: https://ora.ox.ac.uk/objects/uuid/3c55267c-60be-4652-89a7-db3db5f62c25/files/rdv13zt50s . A mirrored source is https://par.nsf.gov/servlets/purl/10300177 .

## Consequence for our audit

The prior finite-field formula
\[
\Pr(S>0)\ge \frac{m^2}{mq+2R_2+2qC_1}
\]
is a generic Cauchy–Schwarz estimate for a different setup. It does not directly instantiate the product-space criterion above: it has no α_k reweighting, no δ_k schedule, no M_k moment recursion, and no source-specific initial-block constants. Even a perfectly checked overlap Gram matrix would not prove the BBMST theorem without a mathematically valid equivalence or implication to the source's criterion.

Therefore the next BBMST work must be redirected to the actual source structure:

1. Define Q, the coordinate sets S_k, and the measures P_k exactly as in the paper.
2. Formalize the recursive reweighting and α_k definitions (source equations (2) and (3)); make the base cases and δ_k=0 endpoint behavior explicit.
3. Prove the moment criterion using the exact source definitions and conditions, including the `min` of first- and second-moment bounds.
4. Formalize the source-specific bounds for M_k^(1), M_k^(2) via c_k(x), ν(J), and the recurrence in source equations (9)–(12), preserving the hypotheses `nontrivial` and `no two parallel`.
5. Reproduce the published initial-block bound and δ schedule as an exact certificate, then test every numerical inequality using rational / outward-rounded arithmetic.
6. Compare the formal theorem statement against the paper, not just its proof skeleton.

## What is genuinely established here

- The finite-field overlap estimate remains a valid generic lemma if its own setup and pair-count definitions are correct.
- The source paper's Theorem 3.1 has a different, product-space/moment-recursion interface, as quoted above.
- The mismatch is an audit finding and prevents us from overstating the current project status.

## Status

This is a correction to our research route, not a proof of the Erdős–Selfridge problem. No theorem-level conclusion is claimed from the finite-field overlap model. The most promising source-faithful route is to formalize the published moment criterion and its recursive bounds first; only then search for a sharper, genuinely source-compatible inequality.
