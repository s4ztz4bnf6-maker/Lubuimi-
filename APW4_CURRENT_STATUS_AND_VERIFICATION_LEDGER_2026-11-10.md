# APW4 / BBMST current status and verification ledger — 10 November 2026

**Research author and formalization lead:** Ta-Yoshua Lubuimi. AI tools are assistants only, not authors or independent mathematical verifiers.

## 1. Mathematical results: preserve, do not reopen

This record is append-only with respect to established mathematical results. The APW4/BBMST work already established by the author remains part of the project's mathematical record. Later Lean integration errors do not retroactively invalidate those results.

The current APW4 energy conclusion is recorded relative to its explicit mathematical premises A*, B*, and the local mass bound `m_S(x) ≤ 1`. Those premises must remain visible wherever the conditional conclusion is stated; they must not be silently dropped or represented as independently discharged unless the relevant proofs are present.

The previously established components remain separately identified: DT and HT; historical atom identification where proved; BIBW domination and weighted Hall conditions; exact diagonal/off-diagonal decomposition; CRT fibre balance; and the algebraic energy conclusion under the recorded premises. APW diagonal mass, APW off-diagonal mass, and BIB pair reserve remain distinct until an explicit index-preserving map and weight/capacity transport is proved.

## 2. Exact PR #115 result

PR [#115](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/115), exact source head `278c0c6c192e34728bace660199e1c431e96846d`, workflow [42762540736](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42762540736):

- Separate `audit` job: **PASS**. It compiled `BBMSTPrefixMeasureRecursion.lean` and printed `BBMSTPrefixMeasure.prefixFibre_updatedWeight_eq_PAt` with `[propext, Classical.choice, Quot.sound]`; no `sorryAx` appears for that declaration in that separate job.
- Integrated Lean 4.35.0 `integrated-paranoid` job: **FAIL**. The compiler reported errors at `BBMSTPrefixMeasureRecursion.lean:393` and `:394`.
- In the positive branch, the tactic `(intro hnot; exact hnot hcov)` was applied to a residual equality between the uncovered and covered multipliers, not to a contradiction.
- In the negative branch, the nested `if x ∈ Finset.univ then ... else 0` was not reduced.
- The integrated error-recovery output then printed `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and dependent declarations such as `PAt_nonneg`. This is a failed integrated proof attempt, not a mathematical counterexample.

The separate audit PASS and integrated FAIL are not contradictory: they are different jobs with different compilation contexts. Only the integrated result can certify the full dependency package requested by the integration workflow.

## 3. Current repair candidate PR #116

PR [#116](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/116) is a stacked draft over PR #115. Its exact code head is `056de39c12ce417b6c7578277bf0fe9023af145f`. It changes only the proof body of `prefixFibre_updatedWeight_eq_PAt`.

The new proof explicitly establishes membership/nonmembership in `F.covered` and membership in `F.points`, then rewrites the two nested conditionals in `updatedWeight` separately. This targets the exact two failures in run 42762540736. It does not change theorem statements, definitions, hypotheses, or the established mathematical architecture.

Exact-head workflow [42805862280](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42805862280) was in progress at the latest poll:

- audit job `129794679789`: in progress;
- integrated-paranoid job `129794680288`: in progress.

**Status: OFFEN – NICHT VERIFIZIERT.** Do not merge or describe the repair as successful until both jobs finish, the integrated package compiles, named `#print axioms` outputs are inspected, and the integrated dependency scan has no `sorryAx`.

## 4. Next APW4 proof obligations

1. Close `prefixFibre_updatedWeight_eq_PAt` in the integrated package with the exact concrete covered/uncovered branch correspondence.
2. Re-run the integrated Lean 4.35.0 paranoid build and inspect the transitive dependencies of `PAt_nonneg`, the pointwise distortion bound, and all later recursion declarations.
3. Verify the prefix event-mass identities at the exact source indices and ensure free coordinates are summed by exact fibre mass conservation while fixed coordinates incur only the corresponding distortion factor.
4. Complete the dependent prefix-cylinder / hyperplane-shadow interface without substituting arbitrary coefficient families for the source-defined `c(I)`.
5. Reconcile the source-defined geometric and measure-theoretic quantities with the published BBMST definitions. Historical `A_q`, `A_r`, `W_{q,r}`, and `a_{q,t}` must not be guessed or replaced by canonical block sums.
6. Keep the three mass ledgers distinct: APW diagonal mass, APW off-diagonal mass, and BIB pair reserve. Prove an index-preserving map before any equality or domination transfer.
7. Re-run the exact theorem-level axiom audit and no-`sorryAx` scan on the final integrated target.

## 5. Separate upstream Erdős–Selfridge interface audit

The audit workflow also compiles a pinned upstream source that contains explicit project-specific axioms `sieve_criterion` and `sf_sieve_lt_one`. The recorded degenerate-parameter witness shows that those axiom interfaces cannot be treated as kernel-derived proofs of the unrestricted Erdős–Selfridge conjecture. This upstream axiom audit is a separate track; it must not be conflated with the established APW4 mathematical results or the APW4 prefix-recursion repair.

## 6. Attribution and licensing boundary

All original APW4 mathematical research, source-specific derivations, and formalization work in this repository are attributed to Ta-Yoshua Lubuimi. AI tools are assistants only.

No root `LICENSE`, `LICENSE.md`, `LICENSE-PROPRIETARY.md`, or commercial licence file was present in the inspected APW4 repository tree at the recorded source snapshot. Therefore this project status record does not invent or import a licence choice from the separate Collatz repository. No open-source or commercial reuse permission is asserted here; third-party code and Mathlib retain their own licences. Any explicit APW4 licensing notice requires a separate author-approved legal text.

---

**Release rule:** no claim that the complete integrated Lean proof is verified until the final exact source passes the integrated build, the named target declarations have the accepted transitive axiom profile, and no `sorryAx` remains in the intended dependency closure.
## Further APW4 exact-head diagnostics — 10 November 2026

### PR #118 / v4 candidate

Source head `0523bfce7a5daed0802f2ffb7141547301337b17`, workflow [42806636524](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42806636524): the integrated build failed. Unfolding `updatedWeight` fixed the earlier equation-theorem rewrite failure, and the full-fibre membership witness was made explicit, but Lean exposed a dependent-index mismatch between `y (Fin.last k)` at `prefixIndex hj (Fin.last k)` and the expected fibre index `stageCoordinate hk`. This candidate is superseded; no result is accepted from it.

### PR #119 / v5 candidate

Source head `5800a53c8c7fd9a59023cddf84d63ccc8cd920e3`, workflow [42807200407](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42807200407): the integrated build still failed on the same dependent-index transport. Changing only the point term in the local `change` target was insufficient because Lean normalized the local let-bound index back to `k` in the dependent type. This candidate is superseded.

### PR #120 / v6 candidate

Current candidate: [PR #120](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/120), exact head `cf52ab6a326c11a115c75bbf3c412f7883b31f11`, workflow [42807684437](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42807684437). It states the transport equality directly as `stageCoordinate hk = prefixIndex hj (Fin.last k)` and uses the same `y (Fin.last k)` term in the target and membership cases. At the latest poll, the separate audit and integrated-paranoid jobs were in progress. **OFFEN – NICHT VERIFIZIERT.**

Do not infer success from the improved diagnostics. Acceptance still requires integrated compilation, exact named axiom output, and no `sorryAx` in the integrated dependency closure.
## Dependent-coordinate correction: v6 failure and v7 candidate — 10 November 2026

PR #120 / v6 source head `cf52ab6a326c11a115c75bbf3c412f7883b31f11`, workflow [42807684437](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42807684437): the separate `audit` job **PASS**; the integrated-paranoid job **FAIL**. The failure confirms that `cases hstage` did not transport the dependent point. Lean still sees `y (Fin.last k)` at `C.S (prefixIndex hj (Fin.last k))`, while `F.covered` expects `C.S (stageCoordinate hk)`. Error recovery therefore emits `sorryAx` for the target and dependent recursion results. No integrated verification is claimed.

Current PR [#121](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/121), v7 exact source head `5631a527c289889db3e70bf0fb1644926e11d893`, uses an explicit dependent cast `hstage.symm ▸ y (Fin.last k)` into `C.S (stageCoordinate hk)` and uses that transported point consistently in the update and membership cases. Workflow status was pending at the latest poll. This is a new candidate, not a verified repair.

Acceptance still requires the v7 exact-head separate audit and integrated-paranoid jobs to complete, successful integrated compilation, named `#print axioms` inspection, and a no-`sorryAx` scan of the integrated dependency closure.

## 7. Latest exact-head poll: PR #120 failure and PR #121 pending — 10 November 2026

The current repair chain is stacked and must be read chronologically:

- PR #120 / v6, exact head `cf52ab6a326c11a115c75bbf3c412f7883b31f11`, workflow [42807701621](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42807701621): separate `audit` PASS; integrated-paranoid FAIL. The integrated log shows `rw` could not find the requested update pattern at `BBMSTPrefixMeasureRecursion.lean:392` and `:406`. Error-recovery output then reports `sorryAx` for `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, `PAt_succ_le_prev_div_card_mul_one_sub_delta`, and `PAt_sum_eq_one`. This is a failed Lean integration candidate, not a mathematical counterexample.
- PR #121 / v7, exact head `5631a527c289889db3e70bf0fb1644926e11d893`, workflow [42808470265](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42808470265): introduces the explicit dependent cast `hstage.symm ▸ y (Fin.last k)` to transport the endpoint into `C.S (stageCoordinate hk)`. At the 10 November 2026 11:35 UTC poll, `integrated-paranoid` job `129803572804` and `audit` job `129803573281` were both in progress. The log endpoint had not yet returned job logs. Therefore the result is OFFEN – NICHT VERIFIZIERT; neither success nor failure is inferred.

### Current APW4 acceptance gate

1. Both v7 jobs must complete on the exact head above.
2. The integrated build must compile without tactic errors.
3. Inspect `#print axioms` for `prefixFibre_updatedWeight_eq_PAt` and dependent targets, including `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, `PAt_succ_le_prev_div_card_mul_one_sub_delta`, and `PAt_sum_eq_one`.
4. The integrated dependency closure must contain no `sorryAx`.
5. Only after that can the prefix recursion be described as Lean-integrated; later APW4 interfaces remain separate obligations and must not be silently declared complete.

This update changes no mathematical statement, definition, assumption, or previously established APW4 result. The distinction between the established mathematical proof record and this specific Lean integration candidate remains explicit.

## v7 integrated failure and v8 endpoint-membership candidate — 10 November 2026

PR #121 / v7 source `5631a527c289889db3e70bf0fb1644926e11d893`, workflow [42808470265](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42808470265): separate audit **PASS**, integrated-paranoid **FAIL**. The integrated log has two residual goals at lines 387 and 397. In the covered branch, the residual implication assumes the endpoint is not covered but the multiplier equality still needs to be reduced; in the uncovered branch, the residual implication assumes the endpoint is covered but the multiplier equality still needs to be reduced. The explicit dependent cast itself is present, but the endpoint membership fact has not been propagated to the recursive `PAt` expression. Error recovery reports `sorryAx` for the target and dependent recursion declarations.

Current PR [#123](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/123) / v8 exact source `135f76d26c3c2392039e53c135e871f09ce2e256` adds explicit `hcovEndpoint` and `hnotEndpoint` facts, transporting membership and nonmembership from the cast point `x` back to `y (Fin.last k)`, so the `PAt` simplification receives the exact endpoint condition it needs. Workflow [42809116463](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42809116463): integrated-paranoid was in progress and the separate audit job was queued at the latest poll. This remains **OFFEN – NICHT VERIFIZIERT**.

Acceptance requires both v8 jobs to pass, the integrated dependency closure to compile without error-recovery `sorryAx`, and named `#print axioms` output for the target and dependent recursion declarations.

## 8. v7 exact-head result and v8 endpoint-membership candidate — 10 November 2026

### PR #121 / v7 — audit PASS, integrated FAIL

Exact source head `5631a527c289889db3e70bf0fb1644926e11d893`, workflow [42808470265](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42808470265):

- Separate `audit` job `129803573281`: **PASS**. It printed `[propext, Classical.choice, Quot.sound]` for `prefixFibre_updatedWeight_eq_PAt` and `PAt_nonneg`.
- Integrated-paranoid job `129803572804`: **FAIL**. The explicit cast made the point inhabit the fibre coordinate type, but the covered branch still left an implication whose premise was expressed at the original endpoint; the uncovered branch had the dual mismatch. The unsolved goals were reported at lines 387 and 397. Error-recovery output contained `sorryAx` for the target and dependent recursion declarations.

This is a failed Lean proof script, not a mathematical counterexample. The separate audit does not certify the integrated dependency package.

### PR #123 / v8 — current candidate

Exact source head `135f76d26c3c2392039e53c135e871f09ce2e256`, workflow [42809132672](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42809132672). The proof now derives explicit `hcovEndpoint` and `hnotEndpoint` facts by simplifying the branch hypotheses through the dependent cast `hstage` and local point `x`. This addresses the exact residual mismatch in v7 without changing the theorem statement, assumptions, definitions, or underlying mathematical point. At the latest poll, audit job `129805804074` and integrated-paranoid job `129805804376` were queued. Status: **OFFEN – NICHT VERIFIZIERT**.

### Acceptance gate

The v8 candidate is accepted only if both jobs finish successfully, the integrated build compiles without tactic errors, the named `#print axioms` outputs for `prefixFibre_updatedWeight_eq_PAt` and dependent `PAt` declarations contain only the accepted standard axioms, and the integrated dependency closure contains no `sorryAx`. Later event-mass, historical-definition, and APW4 bridge obligations remain separately tracked.


## 9. Latest v8 poll — 10 November 2026

At the latest poll, PR #123 workflow 42809132672 had both audit job `129805804074` and integrated-paranoid job `129805804376` in progress. Their log artifacts were not yet retrievable. The result remains OFFEN – NICHT VERIFIZIERT. The earlier v7 integrated failure remains recorded; no result is inferred for v8 until both jobs complete and the logs are inspected.


## 10. v8 failure and v9 type-correct endpoint transport — 10 November 2026

PR #123 / v8 exact head `135f76d26c3c2392039e53c135e871f09ce2e256`, workflow [42809132672](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42809132672): audit PASS; integrated-paranoid FAIL. The integrated errors at `BBMSTPrefixMeasureRecursion.lean:393` and `:407` are type mismatches: the endpoint facts were expressed at the uncast prefix coordinate, while the finite fibre expects an element of `C.S (stageCoordinate hk)`. Error recovery reports `sorryAx` in the target and dependent recursion declarations.

PR #125 / v9 exact head `c72345ef32776ce9548b236f4b47e2b3688b5ddc`, workflow [42810241207](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42810241207), uses the transported endpoint `(hstage.symm ▸ y (Fin.last k))` in both covered and uncovered membership facts and proves each by `simpa [x] using hcov`. At the latest poll both jobs were queued. This is a focused type-correction candidate; no v9 verification is claimed.

Acceptance remains: exact-head integrated build PASS, named axiom profiles for `prefixFibre_updatedWeight_eq_PAt` and dependent declarations, and no `sorryAx` in the integrated dependency closure.


## 11. Latest v9 poll — 10 November 2026

PR #125 workflow 42810241207 has audit job `129809542278` and integrated-paranoid job `129809542736` in progress. Job logs were not yet retrievable. The result remains OFFEN – NICHT VERIFIZIERT until both jobs finish and the exact outputs are inspected.


## 12. v9 integrated failure and v10 coordinate-substitution candidate — 10 November 2026

PR #125 / v9 exact head `c72345ef32776ce9548b236f4b47e2b3688b5ddc`, workflow [42810241207](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42810241207): integrated-paranoid FAIL at lines 387 and 402. The endpoint facts themselves were now well-typed, but the residual `PAt` conditionals still tested the original prefix endpoint while the case split was on the transported point. Integrated error recovery reported `sorryAx` for `prefixFibre_updatedWeight_eq_PAt` and dependent declarations. The separate audit was still in progress at the latest poll.

PR #127 / v10 exact head `3afd9de4e05b75af08579f9961f8cc28cada72af` removes the equality `stageCoordinate hk = prefixIndex hj (Fin.last k)` with `cases hstage` before constructing the fibre, then uses `y (Fin.last k)` as the common endpoint. This is a new candidate only; no exact-head workflow was visible at the latest poll. Status: OFFEN – NICHT VERIFIZIERT.

The v10 acceptance gate remains integrated compilation without errors, named axiom outputs for `prefixFibre_updatedWeight_eq_PAt` and dependent `PAt` declarations, and a no-`sorryAx` integrated dependency scan.


## 13. Latest v10 exact-head poll — 10 November 2026

Workflow 42810911393 is attached to exact head `3afd9de4e05b75af08579f9961f8cc28cada72af`: audit job `129811792964` in progress; integrated-paranoid job `129811793388` queued. The proof remains OFFEN – NICHT VERIFIZIERT.


## 14. Completed v9 audit result — 10 November 2026

PR #125 workflow 42810241207 completed: audit `129809542278` PASS; integrated-paranoid `129809542736` FAIL. The integrated failure and `sorryAx` findings are unchanged. This is a clean separate audit but not an integrated verification.
