# Research continuation — 2026-10-26: finite-fiber firewall and typed sieve boundary

## Status

This is a proof-design and source-audit increment, not a claim that Erdős–Selfridge or the BBMST sieve theorem has been proved. The current audited defect remains concrete: the axiom `sieve_criterion` accepts an empty delta list, and the encoded sieve sum can become zero because empty products equal one and rational division by zero is totalized.

## Three interfaces, not one

1. **Combinatorial interface:** finite fibers, a proved partition, and finite sums. No sieve constants and no division.
2. **Analytic interface:** source-derived moment estimates and denominator positivity, with exact BBMST hypotheses attached to each estimate.
3. **Global interface:** the sieve criterion and its implication for odd covering systems.

The dependency direction must be one-way. Combinatorial lemmas must not import or assume the global sieve criterion.

## Exact local theorem target

Let S be finite, w : S → ℚ, and R,U be subsets with Disjoint R U and R ∪ U = S. The division-free conservation theorem is

`∑ x ∈ S, w x = (∑ x ∈ R, w x) + (∑ x ∈ U, w x)`.

It follows from `Finset.sum_union` after proving disjointness; no positivity assumption is needed. Positivity is needed only for the separate zero-mass corollary: if every w x ≥ 0 and the total finite sum is zero, then each individual w x = 0. Keep that corollary separate from conservation.

For a projection π : S → I, define each fiber by `{x ∈ S | π x = i}`. Prove conservation fiber-by-fiber before summing over i. This local result does not depend on the later BBMST moment estimates.

## Typed parameter boundary

Replace a free `List ℚ` plus `getD` defaults with an indexed family `δ : Fin n → ℚ` whose index is the actual target block type. Require `0 < n` only when the pinned source theorem genuinely has a nonempty target family. Each denominator positivity proof must correspond to the exact denominator in the transcribed BBMST formula; do not introduce guessed constraints unless the source formula requires them.

A typed package prevents missing coordinates and index mismatch. It does not prove moment bounds or geometric hypotheses. Those remain theorem obligations with explicit provenance.

## Source-fidelity gate

- Pin the exact BBMST paper/supplement and record equation and hypothesis for every Lean inequality.
- Map `ss, δs, ca1, ca3, ck, M1bound, M2bound` to the source notation.
- Prove the actual hyperplane/incidence condition wherever the stronger second-moment estimate is used, or use the weaker source-valid estimate and recompute the numerical conclusion.
- Keep the old axiom-based path quarantined.
- Run `#print axioms` on the exact exported theorem independently of compile status.

## Acceptance tests

1. An empty parameter family cannot be supplied to a theorem requiring a nonempty indexed target.
2. No missing coordinate is silently replaced by `getD`.
3. No quotient is used before its denominator is proved positive.
4. The local mass-conservation lemma has no dependency on either sieve axiom.
5. A passing finite test is labelled as a test, not as proof of the universal conjecture.

## Next milestone

Formalize the local conservation and zero-mass lemmas in an isolated Lean file, then make the parameter structure consume the exact block index from the source-faithful model. The global theorem remains blocked until the BBMST estimates and their geometric assumptions are proved rather than axiomatized.
