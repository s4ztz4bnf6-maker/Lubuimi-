# APW4 / BBMST mathematical research and Lean formalization

**Research author and formalization lead: Ta-Yoshua Lubuimi.** AI systems are assistants only, not authors or independent mathematical verifiers.

## Current status — 10 November 2026

The established APW4 mathematical results are preserved. The current work is a focused formal-integration repair, not a restart of the mathematics and not a reason to downgrade results already proved at their stated scope.

- PR [#115](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/115), exact source `278c0c6c192e34728bace660199e1c431e96846d`, run [42762540736](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762540736): separate audit PASS; integrated Lean 4.35.0 paranoid build FAIL at `prefixFibre_updatedWeight_eq_PAt` lines 393–394. The integrated error-recovery output contains `sorryAx` for that declaration and dependent recursion results.
- PR [#116](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/116), exact source `056de39c12ce417b6c7578277bf0fe9023af145f`, run [42805862280](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42805862280): new explicit covered/uncovered membership proof candidate; audit and integrated jobs were in progress at the latest poll. No PASS is claimed.
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