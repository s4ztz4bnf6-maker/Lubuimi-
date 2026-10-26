# BBMST: audit gate for the external nine-prime-support theorem (2026-10-26)

## Objective

Determine whether the external claim that every odd distinct covering has at least nine distinct prime divisors in its LCM can be used as a dependency for the current candidate-LCM reductions. This note is an audit protocol, not an assertion that the theorem has been reproduced.

Reference companion: https://michaelschroeder.ai/research/NinePrimeSupport/companion
Reference candidate factorizations and conditional reduction: `BBMST_NINE_PRIME_SUPPORT_REDUCTION_2026-10-26.md`.

## Statement-fidelity checklist

Before formal reuse, record the exact statement and verify each item against the source and Lean declaration:

1. **Object quantified over:** finite family of residue classes, finite family of moduli, or a specific encoding? Do not conflate them.
2. **Cover condition:** all integers Z, all residues modulo the LCM, or a bounded interval?
3. **Distinctness:** pairwise distinct moduli, not merely distinct residue classes.
4. **Parity and lower bound:** every modulus odd and strictly greater than 1.
5. **LCM conclusion:** at least nine *distinct prime divisors* of the LCM, i.e. ω(lcm(...)) >= 9, not nine prime factors counted with multiplicity.
6. **Prime-power exponents:** unrestricted, unless the formal theorem explicitly states otherwise.
7. **Finiteness / nonemptiness:** no empty-family or vacuous-quantifier loophole; the cover hypothesis must force a nonempty family.
8. **Dependencies:** pinned Lean and Mathlib versions, exact commit, all imports, and transitive `#print axioms` for the final theorem.
9. **Kernel reliability:** after the 2026 Lean kernel incident, rerun the artifact on a patched toolchain and, where practical, compare with an independent checker/kernel.
10. **Human-readable proof correspondence:** inspect the formal definitions rather than relying on a language model's description of the theorem.

## Conditional consequence for three candidate LCMs

The exact factorizations are:
- 10395 = 3^3 * 5 * 7 * 11,
- 12285 = 3^3 * 5 * 7 * 13,
- 17325 = 3^2 * 5^2 * 7 * 11.

Thus each has ω(N)=4. If (and only if) the external theorem's hypotheses match the candidate covering system, none of these N can be the LCM of such a cover. This is a finite candidate exclusion, not a general solution of Erdős–Selfridge.

A local formal bridge should prove the three factorization/support facts independently and then apply the imported theorem. Do not bake the external theorem's conclusion into the local definition of a “covering system.”

## Avoiding a false novelty claim

A verified finite exclusion is useful engineering but is not a new resolution if the same bound is already present in the literature. Report separately:
- external theorem reproduced;
- local candidate exclusion proved from it;
- any genuinely stronger candidate range or new theorem;
- whether the complete general conjecture remains open.

## Next deliverable

Produce a pinned artifact manifest with source URL, repository commit, Lean/Mathlib versions, theorem identifier, statement text, transitive axioms, and clean-build log. Until all fields are populated, label the result “external claim under audit,” not “verified dependency.”
