# APW4 / BBMST mathematical research and Lean formalization

**Research author and formalization lead: Ta-Yoshua Lubuimi.** AI systems are assistants only, not authors or independent mathematical verifiers.

## Current status — 10 November 2026

The established APW4 mathematical results are preserved. The current work is a focused formal-integration repair, not a restart of the mathematics and not a reason to downgrade results already proved at their stated scope.

- PR [#115](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/115), exact source `278c0c6c192e34728bace660199e1c431e96846d`, run [42762540736](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762540736): separate audit PASS; integrated Lean 4.35.0 paranoid build FAIL at `prefixFibre_updatedWeight_eq_PAt` lines 393–394. The integrated error-recovery output contains `sorryAx` for that declaration and dependent recursion results.
- PR [#116](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/116), exact source `056de39c12ce417b6c7578277bf0fe9023af145f`, run [42805862280](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42805862280): new explicit covered/uncovered membership proof candidate; audit and integrated jobs were in progress at the latest poll. No PASS is claimed.
- PRs [#118](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/118) and [#119](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/119) were diagnostic candidates and failed integrated compilation. PR [#120](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/120), v6 head `cf52ab6a326c11a115c75bbf3c412f7883b31f11`, run [42807684437](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42807684437), had audit PASS but integrated FAIL due to an unresolved dependent-coordinate cast. Current PR [#121](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/121), v7 head `5631a527c289889db3e70bf0fb1644926e11d893`, adds an explicit dependent cast `hstage.symm ▸ y (Fin.last k)`. Exact-head workflow [42808470265](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42808470265) completed with `audit` PASS and `integrated-paranoid` FAIL; the integrated proof leaves two endpoint-multiplier implications and reports error-recovery `sorryAx`. Current PR [#123](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/123), v8 head `135f76d26c3c2392039e53c135e871f09ce2e256`, adds explicit endpoint membership/nonmembership transport. Workflow [42809116463](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42809116463) has integrated-paranoid in progress and audit queued at the latest poll. No integrated PASS is claimed.
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

## Update after the v7 exact-head poll — 10 November 2026

PR #120 / v6 workflow 42807701621 completed with `audit` PASS and `integrated-paranoid` FAIL. The integrated log shows rewrite failures at lines 392 and 406, followed by error-recovery `sorryAx` in `prefixFibre_updatedWeight_eq_PAt` and dependent recursion declarations. PR #121 / v7 completed with audit PASS and integrated FAIL. The exact residual goals show that the cast point membership must be explicitly transported back to the endpoint membership used by `PAt`. PR #123 / v8 adds those endpoint facts; workflow 42809116463 remains in progress. The earlier mathematical results and their stated hypotheses are preserved; integrated formal verification remains OFFEN – NICHT VERIFIZIERT.


## Update after v7 integrated result — 10 November 2026

The v7 audit printed `[propext, Classical.choice, Quot.sound]` for `prefixFibre_updatedWeight_eq_PAt` and `PAt_nonneg`, with no `sorryAx` in that separate job. The v7 integrated-paranoid job failed: after the explicit cast, the remaining goals still compared the covered/uncovered predicate at the original endpoint with the case split at the transported endpoint. Error recovery printed `sorryAx` for the target and dependent recursion declarations. PR #123 / v8 adds explicit membership and nonmembership equivalences; its exact-head jobs were queued at the latest poll. This is still an integration gap, not a mathematical counterexample.


### Latest v8 poll — 10 November 2026

PR #123 / v8 head `135f76d26c3c2392039e53c135e871f09ce2e256`, workflow [42809132672](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42809132672): audit job `129805804074` and integrated-paranoid job `129805804376` are now both **in progress**. Logs were not yet available at this poll. No PASS or failure is inferred from an unavailable log.


## v8 integrated failure and v9 cast-endpoint candidate — 10 November 2026

The v8 integrated log confirms that the two endpoint facts were stated at `y (Fin.last k)` without the dependent cast required by the fibre element type `C.S (stageCoordinate hk)`. Both branches failed with type mismatches after simplification (lines 393 and 407); the target and downstream recursion declarations then carried error-recovery `sorryAx`. PR #125 / v9 fixes the type mismatch by stating both facts using `(hstage.symm ▸ y (Fin.last k))` and deriving them directly from the already transported point `x` with `simpa [x] using hcov`. The theorem statement, mathematical assumptions, and fibre definitions are unchanged. Workflow 42810241207 is queued; status remains **OFFEN – NICHT VERIFIZIERT**.


### Latest v9 poll — 10 November 2026

PR #125 / v9 head `c72345ef32776ce9548b236f4b47e2b3688b5ddc`, workflow [42810241207](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42810241207): audit job `129809542278` and integrated-paranoid job `129809542736` are now both **in progress**. Logs were not yet retrievable at this poll. No success or failure is inferred from unavailable logs.


## v9 conditional mismatch and v10 coordinate-substitution candidate — 10 November 2026

The v9 casted endpoint facts are well-typed, but the integrated goal still contains conditional membership tests at the original prefix index, while the case split is on the transported fibre point. The two branches remain unsolved at lines 387 and 402; integrated error recovery includes `sorryAx` in the target and dependent `PAt` recursion. PR #127 / v10 removes the equality `stageCoordinate hk = prefixIndex hj (Fin.last k)` by `cases hstage` before the fibre is constructed. This is intended to make the dependent indices definitionally identical, allowing a single point and membership hypothesis to drive both the fibre update and the `PAt` multiplier. The exact-head run was not yet visible at the latest poll. Status: **OFFEN – NICHT VERIFIZIERT**.


### Latest v10 CI poll — 10 November 2026

PR #127 / v10 exact head `3afd9de4e05b75af08579f9961f8cc28cada72af`, workflow [42810911393](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42810911393): audit job `129811792964` is in progress; integrated-paranoid job `129811793388` is queued. No conclusion is inferred yet.
