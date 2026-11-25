# BBMST geometric-to-moment bridge: exact remaining obligation

Date: 2026-10-27

Status: research specification derived from the compiled finite-sum certificate in
`BBMSTInteriorMass.lean`. This note is not a proof of the BBMST geometric
claim and does not discharge `sieve_criterion` or `sf_sieve_lt_one`.

## The exact moment gap

For finite nonnegative weights (p_i) and shares (0\le \alpha_i\le1),
the existing formal identity is

\[
\sum_i p_i\alpha_i-\sum_i p_i\alpha_i^2
=\sum_i p_i\alpha_i(1-\alpha_i).
\]

The right side is the exact slack. It vanishes on fibres with share 0 or 1,
so the qualitative inequality \(\alpha_i^2\le\alpha_i\) alone cannot give
a uniform positive lower bound.

For a subset (S_N) of source-defined fibres, if
\(\varepsilon_N\le\alpha_i\le1-\varepsilon_N\) for every (i\in S_N\),
the compiled certificate gives

\[
\Gamma_N:=\sum_i p_{N,i}\alpha_{N,i}(1-\alpha_{N,i})
\ge \varepsilon_N(1-\varepsilon_N)
\sum_{i\in S_N}p_{N,i}.
\]

## The missing asymptotic quantifiers

A finite instance can have some positive interior mass while the quantitative
gap tends to zero along a sequence of instances. Thus the useful theorem is
not merely “there exists an interior fibre for each (N).” The source-faithful
geometric bridge must establish constants independent of (N), for example

- (0<\varepsilon_*<1/2);
- (m_*>0);
- for every admissible stage (N), a subset (S_N) of fibres defined from
  the actual BBMST geometry, with all shares in
  \([\varepsilon_*,1-\varepsilon_*]\);
- \(\sum_{i\in S_N}p_{N,i}\ge m_*\).

Then \(\Gamma_N\ge \varepsilon_*(1-\varepsilon_*)m_*>0\) uniformly.

## Audit guardrails

1. Do not manufacture (S_N), its weights, or the interior-share condition
   as free assumptions in the theorem intended to prove the source result.
2. Trace the set and weights back to the paper's finite probability space,
   hyperplanes, and stage-indexed objects.
3. Keep the current project axioms visible: CI compilation of the helper
   lemmas does not remove the custom dependencies `sieve_criterion` and
   `sf_sieve_lt_one`.
4. Test degenerate cases explicitly, including zero stage count and rational
   division by zero; the existing audit has already exposed why these cases
   must not be hidden by totalized division.

## Next theorem to attempt

From the actual BBMST definitions, construct the candidate (S_N) and prove
either the uniform bounds above or a counterexample to them. If no such
uniform interior mass follows from the source hypotheses, this particular
moment-gap route is insufficient and the proof must use a different source
inequality. This is a falsifiable branch point, not an assumption to be
promoted into an axiom.
