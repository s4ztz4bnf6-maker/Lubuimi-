# Step 16 — current verification status and dossier addendum

**Snapshot time:** 2026-11-08, approximately 21:25 CET  
**Repository:** https://github.com/s4ztz4bnf6-maker/Lubuimi-  
**Repair branch:** `fix/step16-dependent-transport-v2-2026-11-08`  
**Lean-source repair commit:** `e8573b4bacc9f4b333827c7bff6e2216f821c934`  
**Current repair-branch head under CI:** `2ea5983bb8627379873edda743e6b0249116274b`  
**PR:** [#63 — Step 16 dependent boundary-coordinate transport](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/63)

## Executive status

**STEP 16: OPEN — NOT VERIFIED.**

The source repair is a candidate only. The two Lean transport proofs were changed to simplifier-driven dependent transport, and the duplicate documentation comment was corrected in `BBMSTPrefixCylinderMass.lean`. The later commits `fb1596934454589296c65637da35838966482a0a` and `2ea5983bb8627379873edda743e6b0249116274b` adjust workflow branch filters so that the focused and foundation workflows also run on the repair branch. Those two commits are CI configuration changes, not additional Lean proof repairs.

The three authoritative runs below all target the same current branch head `2ea5983bb8627379873edda743e6b0249116274b`. The latest poll recorded at this snapshot shows that none has produced a final job conclusion or compiler/axiom result.

| Gate | Workflow run | Job | Status at snapshot | What has actually completed |
|---|---:|---:|---|---|
| Focused Step 16 | [42519816145](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816145) | `128850631653` | **In progress** | Checkout and Lean/dependency installation succeeded; `leanprover/lean-action@v1` is running. Prerequisite compile, target compile and axiom inspection have not reported results. |
| Foundation regression | [42519816133](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816133) | `128850631591` | **In progress** | Checkout and Lean/dependency installation succeeded; Lean action is running. Foundation module compilation has not reported a result. |
| Full ordered audit | [42519816128](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816128) | `128850631484` | **In progress** | Checkout, Lean/Lake setup, upstream source fetch, dependency installation/cache restore, upstream compilation, and focused degenerate-witness tests succeeded. Compilation of the zero-safe BBMST fibre measure core is currently running; later stages remain pending. |

**No new Step 16 compiler result is available at this snapshot.** In particular, no successful Step 16 target compile, no complete `#print axioms` result, and no successful integrated audit may be claimed.

## Repair diff and branch separation

- Lean-source patch commit: `e8573b4bacc9f4b333827c7bff6e2216f821c934`.
- Current CI head: `2ea5983bb8627379873edda743e6b0249116274b`.
- The Lean-source repair was confined to `BBMSTPrefixCylinderMass.lean`.
- The workflow branch-filter commits changed only CI trigger configuration.
- The active audit branch was not modified by this repair.
- PR #63 is a verification vehicle; this status does not authorize merge.

## Acceptance criteria for closing Step 16

Step 16 can be marked complete only after all of the following are supported by the exact final commit and complete logs:

1. All actual Step 16 prerequisites compile.
2. `BBMSTPrefixCylinderMass.lean` compiles successfully on that same commit.
3. The relevant target declarations have explicit `#print axioms` output.
4. The target dependency closure contains no `sorryAx` and no unintended project-specific axioms; the intended standard profile is `[propext, Classical.choice, Quot.sound]`.
5. The focused result is corroborated by the foundation regression and the full ordered audit on the same source head.
6. The complete logs are inspected, not inferred from a green status badge alone.

A failed elaboration that emits `sorryAx` is not an accepted proof term. A successful compile of isolated modules is not an integrated theorem proof.

## Meaning of “only Step 16 remains”

Within the project's numbered 1–22 implementation ledger, Step 16 is the sole currently open numbered step; Steps 17–22 have their recorded isolated rerun successes, and Steps 1–15 are recorded complete in the existing ledger. This narrow bookkeeping statement must not be expanded into the claim that the full published BBMST square-free theorem is already formalized or that every global theorem obligation is closed.

The exact square-free theorem target, its source-faithful hypotheses, the CRT correspondence, replacement/justification of upstream sieve axioms, and final transitive theorem audit remain separate scope and publication gates. In particular, the upstream declaration `erdos_selfridge` is not to be substituted for BBMST Theorem 1.1: its type is unrestricted odd covering and it depends on explicit sieve axioms.

## Next action

Keep the current repair candidate unchanged while these three runs execute. Once a run completes, inspect the full job log and record the exact first compiler diagnostic or the complete successful declaration/axiom output. Do not patch, merge, or update the status to “passed” without that evidence.

## Supersession rule

This addendum is the authoritative current snapshot for the three run IDs and the current Step 16 repair head. Older Step 16 statuses in the historical dossier remain useful as history, but are superseded for current status by this dated addendum. If the runs finish after this snapshot, append a new dated result rather than silently rewriting this snapshot.


## Final result of the three authoritative runs — 2026-11-08, later poll

This section supersedes the “in progress” table above.

| Gate | Run / job | Final result | Verified detail |
|---|---|---|---|
| Focused Step 16 | [42519816145](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816145), job `128850631653` | **FAILURE** | All five actual Step 16 prerequisites compiled. The target compile failed in `BBMSTPrefixCylinderMass.lean` at lines 255 and 259. |
| Foundation regression | [42519816133](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816133), job `128850631591` | **SUCCESS** | All pre-Step 16 foundation modules compiled in dependency order. Their printed declaration traces show the standard profile `[propext, Classical.choice, Quot.sound]`; no failure was reported by this workflow. |
| Full ordered audit | [42519816128](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816128), job `128850631484` | **FAILURE** | The upstream audit, aligned sieve core, fibre measure core, finite update, uniform instantiation, stage moments, geometry, uniform-stage moment and prefix-measure recursion compiled. The audit then failed at “Compile prefix cylinder event-mass identities”; later stages 17–22 were skipped. |

### Exact Step 16 diagnostic

At line 255, Lean reports a type mismatch after simplification for `hlast`. At line 259, it reports the analogous mismatch for `hboundary`. In both cases, the printed expected and inferred types look textually identical:

```lean
match H.assignment (prefixIndex hk (Fin.last k)) with
| none => True
| some s => t = s
```

The identical pretty-printed text does not establish definitional equality: Lean is still tracking a dependent match/type transport distinction. The attempted `simpa [stageCoordinate_eq_prefixIndex, extendPrefix_last]` did not transport the dependent target. This is the concrete unresolved Step 16 defect on the current candidate; it is not a generic “simp set” issue.

The focused log prints `sorryAx` in `containsPrefix_extend_free`, `containsPrefix_extend_fixed`, `containsPrefix_extend_iff`, dependent extension equivalences/reindexing declarations, and `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor`. Because the target compile has errors, these are error-contaminated declarations from failed elaboration, not evidence that a valid kernel-accepted proof exists and not, by themselves, proof of a literal source-level `sorry`. They are nevertheless a hard rejection under the project's acceptance rule.

### Axiom and proof-quality verdict

- The five prerequisites in the focused Step 16 workflow compiled.
- The focused target did **not** compile.
- The required target axiom profile was therefore **not achieved**: the failed elaboration output explicitly contains `sorryAx` for dependent target declarations.
- The foundation regression passed, but that does not close Step 16.
- The full ordered audit reached the same failing prefix-cylinder stage and stopped; it is not an integrated success.
- No merge is authorized by these results.

**Current Step 16 status: OPEN — FAILED on current CI head `2ea5983bb8627379873edda743e6b0249116274b`.**

The Lean repair source commit remains `e8573b4bacc9f4b333827c7bff6e2216f821c934`; the tested branch head includes subsequent workflow-trigger commits. The next repair must address the dependent match's actual type transport, not merely repeat the same simplifier-based conversion. No code change is made by this documentation update.


## 13. Step 16 canonical-boundary repair variants — 2026-11-08

Four materially distinct Step 16 repair variants have now passed both their focused Step 16 workflow and the complete ordered audit. Each full-audit run compiled the entire ordered module chain, including the Step 16 prefix-cylinder module and the downstream prefix-moment, hyperplane-incidence, old-shadow, finite-union and moment-recurrence modules.

| Variant | Lean source commit | Focused Step 16 run | Full ordered audit | Result |
|---|---|---:|---:|---|
| A — canonical-index split after extracting the boundary hypothesis | `ae1f4c82e989496ce47bd1d1627028b6477415dc` | [42522236631](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522236631) | [42522236673](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522236673) | PASS |
| B — canonical-index split before extracting the boundary hypothesis | `3e14432436fb047c628efbf7a4ee1625aab2f7fa` | [42522238764](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522238764) | [42522238807](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522238807) | PASS |
| C — separate final-coordinate helper lemma | `e084f6e8534d4cb8fdfc7f579be2069bee590a96` | [42522242119](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522242119) | [42522242089](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522242089) | PASS |
| G — canonical-index split with restricted `simp only` | source `b00ac6e3e38caf9fe53588429d18b35d416a625e`, tested head `9cf319c5567523e157ce58811c00a30f8089939c` | [42522356379](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522356379) | [42522356504](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522356504) | PASS |

### Common verified result

- Every focused run compiled all five actual Step 16 prerequisites and then compiled `BBMSTPrefixCylinderMass.lean`.
- Every full ordered audit completed successfully through all 22 workflow compile stages.
- The full logs for all four successful audits were inspected: zero compiler-error lines, zero `sorryAx` occurrences, and successful job conclusions.
- The target declarations `containsPrefix_extend_iff` and `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` printed the standard axiom profile `[propext, Classical.choice, Quot.sound]` in all four audits.
- The full-audit logs also printed the downstream Step 20 and Step 22 declarations, including `prefixPairReserve_eq_weightedPairCount` and `cKThree_succ`, with the same standard profile.

### Repair mechanism established by the diagnostics

The failed candidate split the dependent assignment at `stageCoordinate hk`, while the boundary hypothesis extracted from `ContainsPrefix` was indexed by `prefixIndex hk (Fin.last k)`. Lean therefore reduced the goal's dependent match without reducing the corresponding match in the hypothesis. The successful variants perform the case split at the exact canonical index `prefixIndex hk (Fin.last k)`; they then normalize `stageCoordinate` and explicitly use `extendPrefix_last` where the reverse implication needs the value of the appended coordinate.

### Main repair branch / PR re-verification

The successful Variant A Lean source was copied to the existing repair branch `fix/step16-dependent-transport-v2-2026-11-08` in commit `ca9d245aa1851a54b65850ddb1130d1ca12e850e`. PR [#63](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/63) remains open and unmerged. On that exact repair-branch head, the focused Step 16 workflow, pre-Step 16 foundation regression and full ordered audit were triggered as runs [42522812223](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812223), [42522812092](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812092), and [42522812163](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812163). Their final outcomes must be appended when complete. The four already successful isolated variant audits are independent positive evidence and are not to be overwritten by these re-verification runs.
