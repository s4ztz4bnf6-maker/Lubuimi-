# BBMST closure protocol informed by AI-era proof audits
Date: 2026-10-26

## Research inputs and boundaries

The October 2026 OpenAI mathematics release is useful as a workflow precedent, not as a reliability shortcut. The official openai/math repository explicitly states that manuscripts have different verification stages; its history documents three withdrawals after a sign error and revisions to fourteen other manuscripts. The lesson is to pin sources, record exact theorem fidelity, and treat every dependency as an auditable claim.

Thomas Hales's October 2026 essay on Lean reliability highlights two independent requirements:
1. the proof term is accepted by a trusted kernel (preferably cross-checked independently);
2. the formal statement and definitions match the intended mathematical theorem.
A clean #print axioms list does not by itself establish statement fidelity, and a successful Python replay does not establish the mathematical correctness of the algorithm.

## Evidence already available

The independent component workflow passed at run 40412287064:
- finite measure/configuration certificate;
- rational parameter recurrence;
- prime-tail recurrence and logarithmic termination enclosure.

The tail checker is an independent arithmetic implementation, not a formal proof of prime-sieve completeness or the recurrence's analytical specification.

## Dependency graph to close

### Node P: prime enumeration
Prove soundness and completeness of base and segmented sieves. For each segment, prove every composite is marked by a prime divisor <= sqrt(x), and every marked candidate is composite. Prove segment coverage and no duplication.

### Node R: recurrence enclosure
Write the exact rational recurrence corresponding to the paper. For every fixed-point update, prove the rounding direction, radicand enclosure, integer square-root bound, ceiling division, and denominator positivity. Avoid using sampled checkpoint agreement as an induction proof.

### Node L: logarithmic lower bounds
Prove the finite atanh-series identity and nonnegative remainder for t in [0,1). Prove power-of-two reduction and rational rounding preserve a lower bound for log. For log-log, establish positivity of the lower bound before applying monotonicity.

### Node T: terminal implication
Prove that the exact rational terminal comparison implies the published analytical inequality, with strictness preserved and the prime index matched exactly.

### Nodes M and Q: measure and parameter certificates
For the finite space, prove exhaustive/sound enumeration, leaf uniqueness, coverage, and the exact strict integer inequality. For the parameter recurrence, prove positivity, denominator conditions, and the endpoint inequalities from exact rational arithmetic.

### Node S: source-to-theorem correspondence
Pin the final published paper and map every used hypothesis, recurrence constant, prime-index convention, and lemma number to the exact statement. Reconcile published corrections to preprint versions. Show that P,R,L,T,M,Q imply the intended theorem and no weaker or stronger unrelated statement.

### Node A: theorem-level formal audit
Compile with pinned Lean/mathlib versions; inspect custom axioms, sorryAx, Classical.choice, and other dependencies in context. Classical.choice is not itself an illicit axiom in ordinary Lean mathematics, but custom assumptions and unproved conjectures must be explicitly disallowed. If using independent kernels, record their exact versions and whether they check the same artifact from scratch.

## Acceptance matrix
Each node must be marked separately:
- proved in Lean;
- independently machine-checked;
- tested computationally;
- reviewed for source fidelity;
- open.

No node may inherit the status of another. The overall theorem is accepted only after all required nodes are closed and the source-to-theorem map is reviewed.

## Current conclusion
The arithmetic replay passed; the full mathematical closure remains open. This protocol narrows the work to proof obligations instead of adding more numerical reruns.
