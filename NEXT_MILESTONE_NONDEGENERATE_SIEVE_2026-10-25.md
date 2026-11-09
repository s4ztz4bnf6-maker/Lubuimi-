# Next audit milestone: non-degenerate sieve parameters (2026-10-25)

Status: research specification only. No change to the upstream Lean file is made here, and no theorem is claimed solved.

## Confirmed interface risk

The current audit witness shows that the pinned `sieve_criterion` axiom can be invoked with an empty delta list. Because the product over an empty list is 1, the fallback delta is 0, and the rational quotient is totalized at denominator 0, the constructed sieve sum is 0 and hence less than 1. The resulting `False` is conditional on the assumed odd-covering-system input and exposes an axiom-interface flaw; it is not a counterexample to the mathematical conjecture.

## Safer specification shape

Before replacing the axiom with a theorem, introduce a parameter object whose fields express the source-supported conditions, not merely convenient scalar bounds. At minimum, investigate and prove the following obligations against the published theorem:

1. The parameter list is aligned with the exact block-size list (or the paper's construction gives an equivalent explicit index map).
2. Every used delta is strictly between 0 and 1, so each denominator 4δᵢ(1−δᵢ) is strictly positive.
3. The initial-distribution and moment constants are witnessed by the source-defined finite probability distribution, rather than arbitrary rationals satisfying scalar inequalities.
4. The stronger second-moment inequality is used only when the paper's geometric side condition is proved; otherwise use the weaker justified bound and test whether the final numerical inequality still closes.
5. The parameter-existence result supplies exactly the same validity conditions required by the criterion.

Do not blindly add hypotheses to one axiom while leaving `sf_sieve_lt_one` unable to provide them. That would repair the counterexample but leave the main theorem unprovable, or could silently strengthen the source theorem.

## Implementation sequence

- Keep `AuditCheck.lean` as a regression test for the degenerate witness.
- Add a separate source-mapped parameter structure and prove denominator positivity from its fields.
- Formalize the finite distribution and moment sums before the criterion.
- Replace each project-specific axiom only after a proof term exists.
- Run the pinned Lean 4.28.0 workflow and archive exact commit, CI run, and transitive `#print axioms` output.

## Acceptance boundary

A passing CI run establishes that the audit code compiles. It does not establish source fidelity, does not discharge the sieve axioms, and does not solve the unrestricted odd covering conjecture. The published 2021 result is scoped to square-free moduli; do not generalize it to arbitrary odd moduli without a separate proof.
