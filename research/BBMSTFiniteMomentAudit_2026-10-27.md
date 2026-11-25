# BBMST finite moment audit: variance identity and source-data boundary (2026-10-27)

Status: proof plan with elementary inequalities; not Lean-compiled and not the BBMST theorem.

## 1. Finite probability model

Let Q be a nonempty finite set, p:Q→R with p(x)>=0 and sum_x p(x)=1, and α:Q→R with 0<=α(x)<=1. Define

m = sum_x p(x) α(x),
s = sum_x p(x) α(x)^2.

Then

s-m^2 = sum_x p(x)(α(x)-m)^2 >= 0,
m-s = sum_x p(x)α(x)(1-α(x)) >= 0.

Hence m²<=s<=m. These are exact finite-sum identities, and they are more audit-friendly than accepting m and s as independent fields. The proof must use normalization sum p=1; without it the displayed variance identity changes.

## 2. Ratio-free criterion

For d>0 and any real T,

min(m,s/d)>T iff (m>T and s>dT).

This equivalence is immediate from d>0 and is the preferred formal interface because it avoids Lean's totalized division at d=0. Combining s>=m², the stronger sufficient condition m>T and m²>dT implies the target.

Do not silently assume T>=0: the equivalence itself needs only d>0. If the source theorem uses a restricted range for δ, prove d=4δ(1-δ)>0 from that exact range.

## 3. The actual BBMST gap

The generic finite probability lemma does not prove that the source's recursively constructed P_k is normalized, that α_k has the required range, or that the hyperplane incidences used to define them match the paper. Those are separate obligations. In particular, the generic inequality m²<=s is usually not enough to establish a useful positive lower bound on m.

The next source-faithful formalization should have a structure with data derived from p and α, not unconstrained moment parameters. Suggested interfaces:

- probabilityMass : sum_x p x = 1
- weight_nonneg : for all x, 0 <= p x
- alpha_range : for all x, 0 <= α x and α x <= 1
- firstMoment := sum_x p x * α x
- secondMoment := sum_x p x * α x^2

The theorem should then derive the moment inequalities from these definitions. It should not accept a field named sieve_criterion or an unconstrained “moment lower bound” that simply assumes the difficult conclusion.

## 4. Source-fidelity gate

Before claiming a formal BBMST result, document the exact source definition of each Q_k, P_k, α_k, hyperplane and parameter. Keep the result restricted to the published square-free-moduli theorem. Computational checks of finite parameter cases are useful diagnostics but cannot replace the analytic moment estimates.

## Acceptance test

A valid milestone is a kernel-checked finite weighted-sum lemma plus its #print axioms output and a source mapping. The BBMST theorem remains unproved until the actual recursive probability and geometric lemmas are derived and the final implication is proved.
