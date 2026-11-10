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
