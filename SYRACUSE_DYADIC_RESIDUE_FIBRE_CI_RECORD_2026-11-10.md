# Syracuse dyadic residue-fibre CI record — 10 November 2026

**Research author:** Ta-Yoshua Lubuimi. AI tools are research assistants only, not authors or independent mathematical verifiers.

## Exact workflow separation

Workflow [42759653537](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42759653537) on the Syracuse bridge PR produced three distinct job outcomes:

- The targeted compilation of `SyracuseDyadicResidueFibre.lean` succeeded. The declarations `explicitTailAtoms_mem_iff`, `explicitTailAtoms_card`, and `explicitCandidate_mass` each report `[propext, Classical.choice, Quot.sound]`. The focused Syracuse output has no `sorryAx` for these declarations.
- The full audit failed later while compiling the APW4 dependency `BBMSTPrefixMeasureRecursion.lean:386`, with `dsimp made no progress` and a dependent application type mismatch involving `y (Fin.last (a + j))`.
- The integrated-paranoid job failed at that same APW4 dependency.
- The dedicated `syracuse-bridge-paranoid` job remains in progress at the latest poll; its log artifact was not retrievable at that moment (`BlobNotFound`). No isolated paranoid PASS is claimed.

The APW4 failure does not retroactively invalidate the successful isolated Syracuse module compilation. The isolated paranoid check, integrated APW4 build, and separate declaration-scoped axiom output are distinct evidence categories.

## Upstream repair under test

The APW4 dependency repair is tracked separately in [PR #114](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/114), exact source head `d09d28935c9e026f4b8297b058c3cd4169231451`. It moves the recursive covered-value case split before unfolding the fibre update. At the time of this record, the exact-head audit and integrated jobs were running; no result is asserted.

**Status: isolated Syracuse module compilation PASS; isolated paranoid check PENDING; integrated/audit failure attributable to APW4 dependency.**


## Isolated paranoid retry — 10 November 2026

The first `syracuse-bridge-paranoid` attempt in run 42759653537 reached “Running Lean paranoid kernel on solution” after the minimal Syracuse dependency closure built successfully, but GitHub cancelled the operation before it returned a kernel result. It is therefore a cancelled attempt, not a paranoid PASS and not a mathematical failure. A single-job rerun was successfully requested; the replacement job id is `129651118137` and was queued/in progress at the latest poll. The audit and integrated jobs remain failed at the APW4 dependency as documented above.


At the latest poll, the rerun job `129651118137` for `syracuse-bridge-paranoid` is `in_progress`. It has not yet produced a PASS. The earlier attempt was cancelled during the paranoid kernel step after successful dependency-closure compilation; the audit and integrated jobs still fail at the APW4 recursion dependency.
