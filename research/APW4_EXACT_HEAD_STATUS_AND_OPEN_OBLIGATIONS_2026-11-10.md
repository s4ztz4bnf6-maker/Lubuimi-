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
