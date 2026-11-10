# APW4 exact-head status and open obligations — 10 November 2026

Author and research lead: Ta-Yoshua Lubuimi.

## Exact-head APW4 dependent-fibre repair ledger — 10 November 2026

This entry is append-only. It does not replace the mathematical proof record above and does not downgrade any previously established APW4 result.

### Verified mathematical scope retained

The recorded APW4 mathematical architecture remains the author's established result at its stated hypotheses and proof scope: diagonal transport (DT), off-diagonal/weighted-Hall transport (HT), exact diagonal/off-diagonal decomposition, CRT fibre balance, and the conditional global energy conclusion. The algebraic energy conclusion remains conditional on the explicitly stated A*, B*, and local mass bound (m_S(x)\leq 1). These hypotheses are not silently promoted to unconditional theorems.

APW diagonal mass, APW off-diagonal mass, and BIB pair reserve remain distinct quantities until an explicit index-preserving map and corresponding weight/capacity transport are proved. The upstream sieve criterion audit remains separate.

### Exact-head Lean status

- PR [#127](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/127), v10: integrated-paranoid failed at the dependent coordinate / conditional reduction; its separate audit success does not certify the integrated dependency closure.
- PR [#129](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/129), v11: changing equality elimination orientation did not transport the already-constructed dependent endpoint. Not verified.
- PR [#131](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/131) and [#132](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/132): alternative coordinate rewrite / explicit endpoint cast candidates. Not promoted to verified results without exact-head logs.
- PR [#133](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/133): cast-then-coordinate-elimination candidate. Its exact-head CI status must be read from its own run; no inherited audit is accepted.
- v12 rewrite head `514fc368357c60e70ba163ba8c8db51caf62a742`, workflow [42812200610](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42812200610): separate audit PASS, integrated-paranoid FAIL. The integrated log reports that `rw [if_pos hcovF]` and `rw [if_neg hnotF, if_pos hpointF]` did not find the conditional pattern at lines 394 and 407; dependent downstream declarations include `sorryAx`. This is a Lean proof-script failure, not a mathematical counterexample to DT, HT, or the conditional energy result.
- PR [#135](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/135), head `452d19f7edd1629fba115fb67ee0ae219f908e1c`: new candidate changes only those conditional rewrites to proof-directed `simp only`. At this ledger cut-off, no associated workflow result was returned. Status: **PENDING / NOT VERIFIED**.

### Acceptance gate for the recursion bridge

Do not mark `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, or `PAt_sum_eq_one` as integrated verified until:
1. the exact candidate head completes integrated Lean 4.35.0 paranoid CI;
2. named `#print axioms` output is inspected for the target and downstream declarations;
3. the integrated dependency closure contains no `sorryAx`;
4. the separate audit and integrated build refer to the same exact source head.

A successful standalone audit is not a substitute for the integrated gate. No mathematical theorem statement or established result is changed by these repair candidates.

### Attribution and licence boundary

Original APW4 research, manuscript material, and formalization authored by Ta-Yoshua Lubuimi remain attributed to him. AI tools are assistants only and are not authors or independent mathematical verifiers. The existing `LICENSE-PROPRIETARY.md` and commercial-use policy remain unchanged; no new licence, assignment, waiver, or reuse permission is created by this status entry. Third-party sources, Lean, Mathlib, and dependencies remain subject to their own terms.


## 10 November 2026 — v14 coordinate-normalization result and next gate (13:43 CET)

### Exact source diagnostics

PR #133, exact head `dada662cc35b42d760bec7b1848ec85c8111ee7c`, workflow 42812910651:
- separate audit: PASS;
- integrated-paranoid: FAIL;
- exact failure: the endpoint term `y (Fin.last k)` remains indexed by `prefixIndex hj (Fin.last k)`, whereas `F.covered` is a finset over `C.S (stageCoordinate hk)`;
- the integrated error-recovery output reports `sorryAx` in `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, `PAt_succ_le_prev_div_card_mul_one_sub_delta`, and `PAt_sum_eq_one`.

This exact diagnostic supersedes any vague description of the remaining issue as merely an `if` simplification failure: the decisive obstruction at this source head is dependent-coordinate transport.

### Current v14 candidate

PR #137, branch `repair/apw4-explicit-endpoint-membership-v14-2026-11-10`, exact head `f2df9ab28a64ce6a5528f02c52a325766d7a54c4`:

1. derive `hstage : stageCoordinate hk = prefixIndex hj (Fin.last k)` by `Fin.ext`;
2. rewrite `[hstage] at *` before defining the endpoint and constructing `F`;
3. perform the covered/uncovered split only after the coordinate family has been normalized throughout the local context.

This is a materially different proof-script order from the failed post-construction casts: it attempts to make the fibre's coordinate type and the recursive endpoint type definitionally coincide before either is used. It has **no exact-head CI result yet** and remains **OFFEN – NICHT VERIFIZIERT**. Do not transfer audit results from v12/v13 or PR #133.

### Preserved mathematical record

No APW4 mathematical result is reopened. DT, HT, the exact two-term energy decomposition, the upper estimate, the strict lower-bound implication, and the contradiction remain recorded at their original scope. Keep A*, B*, and `m_S(x) ≤ 1` explicit wherever required. Keep APW diagonal mass, APW off-diagonal mass, and BIB pair reserve as separate ledgers absent a proved index-preserving map with weight/capacity transport.

### Acceptance gate

Run the exact v14 head through the integrated Lean 4.35.0 package and `lake check --paranoid`. Inspect named axiom output for the local update identity, nonnegativity, normalization, distortion-product bound, and the intended theorem. Require the standard profile `[propext, Classical.choice, Quot.sound]` where appropriate and no transitive `sorryAx`. A standalone audit PASS is not sufficient.


## Exact-head update — v14 diagnosis and v15 repair (10 November 2026, 13:50 CET)

This is an append-only Lean-integration status update. It does not replace, reopen, or downgrade the established APW4 mathematical proof record. The mathematical energy decomposition, DT, HT, the upper energy estimate, the strict lower-bound implication, and the resulting contradiction remain retained at their stated hypotheses and exact definitions. The historical APW4 quantities and the separate CRT/BIB reconstruction remain distinct where the required index-preserving identifications have not yet been formalized. The published manuscript/PDF is not silently rewritten by a CI repair.

### Exact v14 finding

- PR [#137](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/137), source head `175c50c75d537ef32687c63cb1219e8ff1ace257`, uses the equality `stageCoordinate hk = prefixIndex hj (Fin.last k)` and rewrites the dependent context before constructing the fibre. This removes the earlier coordinate-type mismatch.
- The exact integrated and standalone logs for this candidate now isolate a narrower proof-script defect at `BBMSTPrefixMeasureRecursion.lean:397` and `:410`: `simp only [if_pos hcovF]` / `simp only [if_neg hnotF, if_pos hpointF]` make no progress.
- The reason is syntactic but type-relevant: the witnesses `hcovF`, `hnotF`, and `hpointF` are stated at the unfolded endpoint `y (Fin.last k)`, while `updatedWeight` is still applied to the local let-bound argument `x := y (Fin.last k)`. The conditional matcher sees `x ∈ F.covered` and `x ∉ F.covered`; it is not supplied those exact propositions. The compiler's error recovery consequently reports `sorryAx` in `prefixFibre_updatedWeight_eq_PAt` and downstream recursion declarations. Those declarations are not integrated-verified at this source head.

### v15 exact repair candidate

- PR [#138](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/138), source head `800d752e626951505d9dbcb312dfe09555ee6f2f`, transports the already-proved endpoint witnesses to the actual local argument before reducing the conditionals:
  - `hcovFx : x ∈ F.covered` from `hcovF`;
  - `hnotFx : x ∉ F.covered` from `hnotF`;
  - `hpointFx : x ∈ F.points` from `hpointF`.
  It then rewrites the exact conditional branches using those local-argument witnesses. This is a focused elaboration repair: theorem statements, assumptions, fibre definitions, and mathematical content are unchanged.
- PR #138 is **PENDING exact-head verification**. It must pass the integrated paranoid build and separate audit on the same head, print the named axiom profiles for `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, `PAt_le_initial_mul_distortionProduct`, and `PAt_sum_eq_one`, and show no transitive `sorryAx`. No verification is claimed yet.

### Remaining APW4 formalization after this local repair

Once the recursion bridge passes the exact-head gate, continue with the historical identifications already tracked in the proof-obligation map: `prefixFixedCoords`, `initialProfileFamily`, the historical `c(I)) profile including the empty profile, the exact suffix-factor identification with `ν(J)), the full Lemma 3.3 cylinder inequality, and the Lemma 3.4 moment step. Then connect the resulting source-indexed prefix statements to the historical DT indices and actual BIB-place weighted-Hall transport without replacing those objects by arbitrary abstract maps. Preserve the two-term energy decomposition and ordered off-diagonal convention.

### Preservation and attribution

All established APW4 results and all earlier exact-head Lean passes remain valid for their stated scope; later integration failures do not retroactively invalidate them. Do not claim that the complete historical APW4 theorem is already fully Lean-verified until its own exact release-head build, paranoid check, named axiom output, and transitive no-`sorryAx` audit pass. Original APW4 research and formalization remain attributed to Ta-Yoshua Lubuimi; AI tools are assistants only.


### Earlier exact APW4 audit distinction — Lean 4.28 versus integrated Lean 4.35

- Run [42728171781](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42728171781): the separate Lean 4.28.0 audit job passed for the checked source chain and printed the standard profile `[propext, Classical.choice, Quot.sound]` without `sorryAx` for `prefixPointCovered_iff`, `prefixFibre_updatedWeight_eq_PAt`, `PAt_nonneg`, and `PAt_sum_eq_one`. The integrated-paranoid job in that same run failed. These are two distinct outcomes; the successful 4.28 audit remains a valid result for its checked declarations and source/toolchain, and does not certify the separate 4.35 integrated build.
- Run [42739454140](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42739454140): both jobs failed on a later exact source candidate. The proof had progressed through the covered/uncovered branches, but a subsequent `ring` tactic was reached after `simp` had already closed the goal ("No goals to be solved"); the algebraic remainder in the 4.35 path also required a separately normalized proof. The downstream `PAt_nonneg` and `PAt_sum_eq_one` declarations on that failing source are not certified. The subsequent v14 diagnosis narrowed the remaining failure to the exact local-let membership mismatch documented above.

Do not erase the successful Lean 4.28 audit because the later integrated 4.35 path fails. Preserve both exact outcomes and their distinct verification scopes.


### Historical event-to-BIB reconstruction — new 10 November source ledger

The detailed source reconstruction is now recorded in [APW4 Historical Event-to-BIB Reconstruction Ledger](publication/APW4_HISTORICAL_EVENT_BIB_RECONSTRUCTION_LEDGER_2026-11-10.md). The recovered q-fibre working definitions are \(B_q=N/q^{a_q}\), \(V_q=\{z:z\bmod B_q\in U_q\}\), \(F_q(x)=\{z:z\equiv x\pmod{B_q}\}\), \(P_{q,x,h}=F_q(x)\cap C_h\), with \(M_{q,r}((x,h),(y,g))=|P_{q,x,h}\cap P_{r,y,g}|\) and \(\Gamma_{q,r}(g)=|C_g\cap V_q\cap V_r|\). The ledger preserves the exact block identity \(A_qW_{q,r}A_r^{\mathsf T}=\sum_{t\bmod D_{q,r}}a_{q,t}a_{r,t}^{\mathsf T}\) and local fibre-count bound \(\sum_hM_{q,r}(h,g)\leq\Gamma_{q,r}(g)\).

It also records \(I_q=A_q+Z_q\) and the full four-term expansion of \(I_qW_{q,r}I_r^{\mathsf T}\), with three Z-residual terms. This is matrix accounting only, not a third term in the APW4 energy identity, which remains exactly \(D_{\rm APW4}+C_{\rm APW4}\). The event universe, full index map, source domains, actual BIB slots, incidence predicate, and weight-preserving Hall proof remain explicit formalization obligations; no arbitrary replacement map or residual estimate is introduced.
