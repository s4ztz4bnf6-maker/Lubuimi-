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
