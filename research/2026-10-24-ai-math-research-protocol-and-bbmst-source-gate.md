# AI-assisted mathematics protocol and BBMST source-fidelity gate (2026-10-24)

## Motivation
Quanta's 2026 reporting on Erdős problems describes successful AI-assisted proof discovery, but also highlights rediscovered results, flawed proofs, and the need for expert checking. The practical lesson is a pipeline: literature triage -> exact statement -> proof sketch -> adversarial review -> formalization -> transitive axiom audit.

This is a research-process note, not evidence that our target theorem has been proved.

## Required source-fidelity checklist
For every imported claim:
1. Locate the original paper or authoritative author version.
2. Record exact theorem number, hypotheses, quantifiers, and conclusion.
3. Check whether the claim is new, rediscovered, conditional, or computationally supported.
4. Compare every hypothesis to the Lean definition; prohibit silently stronger assumptions.
5. Identify all imported lemmas and axioms in the transitive dependency trace.
6. Preserve counterexamples to weakened interfaces as regression tests.

## BBMST application
Our present project has useful finite probability identities, but the source-specific burden is geometric: define the finite coordinate sets, actual hyperplanes/fibers, event intersections, and the relevant weights. Do not assume independence or a geometric nondegeneracy predicate for free. Prove nonemptiness before normalizing or dividing by cardinalities.

The degenerate empty-delta interface previously identified is a formal defect in the axiom interface, not a counterexample to the published square-free-moduli theorem. A length condition is a necessary guard but does not replace proof of the sieve inequality.

## First concrete lemma after source pinning
Define a finite index type I and events E : I -> Set Ω in a finite probability space. Prove the exact indicator identity
(sum_i 1_{E_i})^2 = sum_{i,j} 1_{E_i ∩ E_j}
pointwise, then derive the expectation identity from finite-sum rearrangement. Keep this abstract algebra lemma independent of the BBMST geometry. In a separate file, define the source-faithful geometric model and prove the intersection bound needed by the paper.

## Acceptance gate
A purported improvement is accepted only if:
- its mathematical statement is explicit;
- its proof compiles under pinned Lean/Mathlib;
- its transitive axiom trace is inspected;
- no theorem is smuggled in as a structure field or premise;
- source assumptions match the published result;
- CI success and mathematical theorem correctness are reported separately.

## Limits
AI-generated natural-language proofs are candidates, not certificates. Lean checks the formalized proposition under its kernel and imported axioms; it cannot detect a mistranscribed theorem statement or an incorrect formalization of the intended mathematics.
