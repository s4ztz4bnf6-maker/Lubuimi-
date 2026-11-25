# Research update — 2026-10-26: finite proof obligations and audit gates

## Scope

This note advances the audit plan, not the conjecture itself. No claim is made that the unrestricted Erdős–Selfridge odd covering conjecture is proved. A finite Lean check establishes only the encoded statement under its actual definitions, hypotheses, imports, and axioms.

## Concrete current blocker

The current `AuditCheck.lean` exhibits a degenerate witness: `δs = []), `ca1 = ca3 = 1` makes the encoded sieve sum zero, because the product over an empty parameter list is one and rational division by zero is totalized. The existing axiom `sieve_criterion` accepts that witness. This is a genuine interface defect, not evidence for or against the mathematical conjecture.

The next repair must constrain the representation, not merely add a test:
1. Give the delta vector a type whose length is tied to the relevant prime/block index (or use a dependent vector).
2. State source-derived bounds on each parameter, including strict denominator positivity wherever a quotient is used.
3. Ensure the finite list of primes and the block-size list are aligned by a proved correspondence, not an unchecked convention.
4. Keep the actual BBMST geometric hypotheses explicit. A well-typed parameter package must not be treated as proof that the paper's moment estimates hold.

## Division-free local core

For each finite projection fiber (F_i = \{x \in S : \pi(x)=i\}\), define removed, covered, and surviving masses as finite sums over explicitly defined subsets of (F_i). First prove disjointness and exhaustive coverage; then derive the additive identity
`mass(F_i) = mass(removed_i) + mass(surviving_i)`
without division. Handle a zero-total fiber separately: if all point masses are nonnegative and their finite sum is zero, each point mass is zero. Only introduce a conditional ratio after a theorem proves its denominator is strictly positive.

This separates three proof layers:
- finite-set bookkeeping and mass conservation;
- source-specific fiber/moment inequalities;
- the global sieve implication.

Success at the first layer does not discharge either of the latter two.

## Infinite testing: correct role

An unbounded universal claim is not established by running a test for an arbitrarily large finite time. The right analogue is a proof of an invariant or a universal bound, plus finite computation used only to discover or check certificates. In this project, finite enumeration can validate rational LP certificates and small incidence configurations; the theorem that every required configuration is covered must itself be proved, including completeness of the enumeration.

## Next executable milestone

Create a typed parameter structure with explicit length/alignment and positivity fields, then prove that the degenerate empty vector cannot inhabit it for any nonempty target index. Keep the old axiom-based theorem isolated until a source-faithful replacement is available. Run the transitive `#print axioms` audit on the exact exported theorem after each interface change.

## Acceptance checklist

- [ ] Source-to-Lean mapping for each BBMST inequality and its hypotheses.
- [ ] No `getD` default or empty list can silently stand in for a missing mathematical parameter.
- [ ] No quotient is used before denominator positivity is established.
- [ ] Actual hyperplane/incidence geometry is represented, not replaced by a free coefficient function.
- [ ] CI compile result and transitive axiom output are recorded separately.
- [ ] The unrestricted conjecture is not described as solved while project-specific sieve axioms remain.
