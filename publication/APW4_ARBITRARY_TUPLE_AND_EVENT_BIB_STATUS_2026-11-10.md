# APW4 arbitrary-t and historical Event-to-BIB status — 10 November 2026

**Author and research lead:** Ta-Yoshua Lubuimi.

This is an append-only status memorandum. It preserves the established APW4 mathematical results and distinguishes them from remaining source reconstruction and Lean integration obligations.

## Established mathematical record

The exact two-term APW4 energy decomposition, diagonal transport (DT), weighted off-diagonal transport (HT), global upper energy estimate, and strict lower bound under the stated historical hypotheses remain established mathematical results. A later Lean integration failure does not retroactively invalidate those results.

## Lemma 3.4: pair-level versus arbitrary ordered tuples

The current declarations `OldCompatible`, `mergeOldShadows`, `fixedCoords_mergeOldShadows`, and `prefixPairReserve` implement the pair case (t=2). They do not establish the general ordered-t-tuple statement.

The documented generalization is indexed by functions `Fin t → N_k`, preserving order and repetitions. Its proof architecture is:

1. Detect a conflict at an old coordinate; the full shadow intersection is empty and its mass is zero.
2. Otherwise fold an iterated merge over the ordered tuple, maintaining compatibility, the exact intersection predicate, and the union of fixed-coordinate profiles.
3. Apply the source-facing Lemma 3.3 estimate to the merged event.
4. Expand the ordered tuple indicator sum and justify the finite weighted-sum interchange without quotienting away tuple multiplicity.

This is a proof design only. No arbitrary-t Lean declaration or exact-head CI pass is claimed.

## Historical Event-to-BIB map

The q-fibre M/Gamma results and generic preimage-map / ZMod quotient-fibre helpers are partial finite interfaces. They do not yet establish the historical APW4 event-to-BIB transport. The remaining obligations are:

- recover the exact historical event universe and source/target domains;
- define the index-preserving map from each historical event to its BIB slot/incidence data;
- prove injectivity or the required multiplicity control at the actual historical indices;
- preserve the historical event weights under the map;
- prove the BIB-slot capacity bound and weighted Hall inequality;
- identify the resulting BIB reserve with the off-diagonal mass without conflating it with the diagonal mass.

The APW diagonal mass, APW off-diagonal mass, and BIB pair reserve remain separate ledgers until these exact maps and weight/capacity statements are proved. Canonical residue models may be used as helpers, never silently substituted for the historical definitions.

## Current Lean integration boundary

PR [#138](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/138) records the latest local endpoint conditional repair, with source head `94b89a2c5bda9a494c0c42e79ad054aabacabdd8`. No exact-head workflow result was returned for that head. The dependent prefix update and downstream recursion are therefore **OFFEN – NICHT VERIFIZIERT**. Required acceptance evidence is an exact-head Lean 4.35.0 integrated build, `lake check --paranoid`, named `#print axioms`, and transitive no-`sorryAx` checks.

The successful pair-level, q-fibre, geometry, and other isolated results retain their own commit and theorem scope. They do not automatically verify the arbitrary-t theorem or the historical Event-to-BIB instantiation.

## Licensing and attribution

All original APW4 research and formalization are attributed to Ta-Yoshua Lubuimi. AI tools are assistants only, not authors or independent mathematical verifiers. The APW4 repository snapshot has no explicit project licence; this note grants no new permission and does not import the separate Collatz repository's licensing terms. Third-party source, Lean, Mathlib, and publications retain their own licences.
