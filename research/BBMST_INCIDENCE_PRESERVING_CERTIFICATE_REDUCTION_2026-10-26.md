# BBMST: incidence-preserving certificate reduction

Date: 2026-10-26

## Research objective
Avoid compressing the source argument into a scalar inequality before proving that the compression preserves all information needed for the conclusion. Keep the finite incidence structure visible through every reduction step.

## Proposed data model
For each source-defined finite configuration, record:
- the exact ground set and canonical enumeration;
- each incidence/fiber relation as a Boolean or exact integer matrix;
- the source-defined rank/level parameters and their definitions;
- the map from configurations to LP variables and constraints;
- the exact rational objective and all normalization assumptions;
- the theorem that transfers the certified bound back to the source statement.

Every derived scalar summary must carry a witness map back to the full incidence matrix and a theorem stating what information is preserved. If no such transfer theorem is available, the scalar route remains exploratory.

## Falsification gates
1. **Collision test:** search for two small configurations with the same proposed scalar summary but different relevant incidence/rank behavior. Such a pair disproves the sufficiency of that summary.
2. **Degeneracy test:** include empty fibers, singleton fibers, duplicate encodings, excluded modulus 1, and every boundary case specified by the source.
3. **Rank-transfer test:** test whether the proposed inequality still follows when incidence patterns differ but aggregate counts agree. A failed implication blocks the reduction.
4. **Certificate identity test:** freeze the exact row/column ordering and reconstruct every coefficient from the source rather than accepting a generated matrix as an oracle.
5. **Strict-margin test:** represent all values rationally and prove the final strict inequality with a positive exact margin; do not rely on decimal output.

## Why this is a plausible new route
The incidence structure is the mathematical object; an LP is a certificate mechanism for selected finite inequalities. Keeping incidence data explicit can expose missing hypotheses that scalar minimax bounds conceal, and can produce small countermodels early. This is a methodology proposal, not a new theorem about BBMST.

## Formal acceptance conditions
- The source theorem and all hypotheses are pinned.
- The incidence encoding is complete and injective up to the source's stated equivalence.
- Every reduction has a proved preservation lemma.
- Every LP certificate is exact rational and independently checked.
- The final transfer theorem is formalized and its axiom dependencies audited.

## Status
No new counterexample to BBMST is claimed. No source LP, certificate, or global theorem is claimed to have passed this gate.