# APW4 / BBMST mathematical research and Lean formalization

**Research author and formalization lead: Ta-Yoshua Lubuimi.** AI systems are assistants only, not authors or independent mathematical verifiers.

## Current status — 10 November 2026

The established APW4 mathematical results are preserved. The current work is a focused formal-integration repair, not a restart of the mathematics and not a reason to downgrade results already proved at their stated scope.

- PR [#115](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/115), exact source `278c0c6c192e34728bace660199e1c431e96846d`, run [42762540736](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762540736): separate audit PASS; integrated Lean 4.35.0 paranoid build FAIL at `prefixFibre_updatedWeight_eq_PAt` lines 393–394. The integrated error-recovery output contains `sorryAx` for that declaration and dependent recursion results.
- PR [#116](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/116), exact source `056de39c12ce417b6c7578277bf0fe9023af145f`, run [42805862280](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42805862280): new explicit covered/uncovered membership proof candidate; audit and integrated jobs were in progress at the latest poll. No PASS is claimed.
- PRs [#118](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/118) and [#119](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/119) were diagnostic candidates and failed integrated compilation. PR [#120](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/120), v6 head `cf52ab6a326c11a115c75bbf3c412f7883b31f11`, run [42807684437](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42807684437), had audit PASS but integrated FAIL due to an unresolved dependent-coordinate cast. Current PR [#121](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/121), v7 head `5631a527c289889db3e70bf0fb1644926e11d893`, adds an explicit cast; its exact-head run is pending. No integrated PASS is claimed.
- The algebraic APW4 energy conclusion remains stated relative to its explicit premises A*, B*, and the local mass bound `m_S(x) ≤ 1`; those assumptions are not silently discharged.
- APW diagonal mass, APW off-diagonal mass, and BIB pair reserve remain distinct until a concrete index-preserving map and weight/capacity transport is proved.

See [APW4 current status and verification ledger](APW4_CURRENT_STATUS_AND_VERIFICATION_LEDGER_2026-11-10.md) for the exact failure diagnostics, candidate proof repair, remaining obligations, and release criteria.

## Core source modules

- `BBMSTPrefixMeasureRecursion.lean` — source-indexed prefix recursion and the concrete prefix fibre update.
- `BBMSTFiniteFibreUpdate.lean` — finite weighted-fibre update identities.
- `BBMSTUniformFibreInstantiation.lean` — source-faithful uniform-coordinate fibre construction.
- `BBMSTPrefixCylinderMass.lean` — event-mass identities for prefix cylinders.
- `BBMSTPrefixIncidenceBridge.lean` and `BBMSTHyperplaneFibreIncidence.lean` — incidence and geometric bridge layers.
- `BBMSTMomentBridge.lean`, `BBMSTPrefixMomentBridge.lean`, `BBMSTMomentRecurrence.lean` — moment and recurrence layers.
- `APW4CanonicalMajorization.lean`, `APW4DiagonalAudit.lean`, `APW4HistoricalCRTCore.lean`, `APW4IncidenceSecondMoment.lean` — APW4 result and audit modules.

## Mathematical and verification boundaries

The source-level proof architecture, the mathematical statements established by the author, isolated Lean compilation, integrated compilation, paranoid kernel checking, and declaration-scoped `#print axioms` are separate evidence categories. No isolated module PASS substitutes for an integrated exact-head check. No error-recovery `sorryAx` is accepted.

The upstream Erdős–Selfridge source audit is a separate track: explicit upstream axioms `sieve_criterion` and `sf_sieve_lt_one` are not kernel-derived proofs of the unrestricted conjecture. Do not conflate that audit with the established APW4 results.

## Attribution and licensing

See [APW4 attribution and licensing status](APW4_ATTRIBUTION_AND_LICENSING_STATUS_2026-11-10.md). The inspected repository snapshot has no explicit project licence file; this README does not invent one or import the separate Collatz repository's licensing policy.

## Historical records

- [BBMST proof-obligation map](BBMST_ProofObligations.md)
- [BBMST audit README](README-AUDIT.md)
- [BBMST status dossier](research/BBMST_STATUS_DOSSIER_2026-11-08.md)
- [Upstream sieve axiom-interface audit](research/BBMST_SIEVE_AXIOM_INTERFACE_AUDIT_2026-11-06.md)

## Exact APW4 closure ledger — 10 November 2026, afternoon checkpoint

This addendum is append-only. It does not reopen or downgrade the established APW4 mathematical results (exact two-term energy split, DT, weighted HT, global upper bound, and strict lower bound under the historical hypotheses).

### Current formal-integration source

- Historical prefix-fibre conditional repair: [PR #138](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/138), current source head recorded by the PR as `94b89a2c5bda9a494c0c42e79ad054aabacabdd8`.
- The latest repair makes the covered/uncovered witnesses explicit at the local let-bound endpoint. No exact-head workflow result was returned for this head. Therefore the source declaration `prefixFibre_updatedWeight_eq_PAt` and downstream prefix recursion remain **OFFEN – NICHT VERIFIZIERT** pending Lean 4.35.0 integrated build, `lake check --paranoid`, named `#print axioms`, and transitive no-`sorryAx` audit.

### Lemma 3.4: ordered arbitrary-t tuples

The existing `OldCompatible`, `mergeOldShadows`, `fixedCoords_mergeOldShadows`, and `prefixPairReserve` source declarations are pair-level (t=2). They are not a general ordered-t-tuple theorem. The arbitrary-t proof architecture is documented: index by `Fin t → N_k`, retain order and repetitions, split on an old-coordinate conflict (empty intersection / zero mass) or iteratively merge compatible shadows, prove intersection predicate and fixed-coordinate union, and apply the source-facing Lemma 3.3 bound. No arbitrary-t Lean theorem or CI pass is claimed yet.

### Historical Event-to-BIB transport

The recovered q-fibre work and local M/Gamma incidence lemmas are partial interfaces only. Generic preimage-map and canonical ZMod quotient-fibre helpers do not by themselves instantiate the author's historical event sets, block labels, BIB slots, or capacities. The remaining historical obligations are: exact source-domain/event map; index-preserving incidence relation; preservation of historical weights; BIB-slot capacity accounting; weighted Hall/capacity inequality; and the final identification with the already established HT mass. APW diagonal mass, APW off-diagonal mass, and BIB pair reserve remain distinct until that map and the weight/capacity equalities or inequalities are proved.

### Licensing boundary

The APW4 repository's inspected snapshot still has no explicit project licence file. The separate Collatz/Syracuse repository's proprietary and commercial-use notices are not imported here. No licence is created or granted by this addendum. Any APW4 legal notice requires explicit rights-holder approval of its exact text; third-party materials retain their own licences.

### Acceptance rule

A full APW4 formal-integration closeout requires the arbitrary-t theorem, historical Event-to-BIB map with weight and capacity preservation, and a single exact-head Lean 4.35.0 integration run covering the intended roots, followed by named axiom profiles and a complete transitive no-`sorryAx` audit. Until then, these are open formalization/reconstruction tasks, not reasons to reopen the established mathematical proof record.
