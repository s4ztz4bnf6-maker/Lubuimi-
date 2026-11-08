# BBMST / Erdős–Selfridge — Research Status Dossier

**Research lead and formalization:** Ta-Yoshua Lubuimi  
**AI assistance:** ChatGPT (OpenAI), transparently disclosed below  
**Snapshot:** 2026-11-08  
**Repository:** https://github.com/s4ztz4bnf6-maker/Lubuimi-  
**Branch:** `audit/step20-isolated-2026-11-08`  
**Previous failed code head:** `e230c4508b17fccfd006392b92d39b70d7f23ca6`  
**Latest code snapshot under test:** `3ffe65b933222b135d4fa27cd8e6efa358aa8089`

## Executive status

The current staged implementation plan has 22 numbered steps. The project records steps 1–15 and 17–22 as completed; Step 16 is the sole open stage. This is a statement about the status of the staged Lean workstream. It is not a claim that all 22 steps were compiled in one uninterrupted run, nor that the complete BBMST theorem or the unrestricted Erdős–Selfridge conjecture has already been proved.

## Verification ledger

| Step | Latest cited evidence available in this snapshot | Status |
|---|---|---|
| 1–15 | Prior project verification history | Recorded complete; individual historical evidence remains controlling |
| 16 | [Focused CI run 42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215), head `e230c4508b17fccfd006392b92d39b70d7f23ca6` | OPEN — FAILED on the current head; the five prerequisites passed, but the target failed at three dependent-index/type errors and its axiom output still contains `sorryAx`. |
| 17 | [Run 42488903023](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903023), commit `125507564b4b6d89565d0d606ab0bd38951b158d` | Isolated Lean compile successful |
| 18 | [Run 42488903065](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903065), same commit | Isolated Lean compile successful |
| 19 | Same run and commit | Isolated Lean compile successful |
| 20 | [Later isolated run 42513785862](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42513785862), commit `9daa08aecc68ce9de0e086ca006dbc9980ab5ad0` | Later isolated Lean compile successful; an earlier attempt in run 42488903065 failed |
| 21 | [Run 42488903065](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903065), commit `125507564b4b6d89565d0d606ab0bd38951b158d` | Isolated Lean compile successful |
| 22 | Same run and commit | Isolated Lean compile successful |

For Steps 17–22, the relevant job logs show the standard Lean axiom profile `[propext, Classical.choice, Quot.sound]` for the declarations printed in those jobs. These are module-level traces, not a final transitive audit of a single target theorem. The workflow for Steps 18–22 explicitly states that some prerequisite modules are assumed rather than recompiled by each isolated job. Step 20's later successful log also contains unused-variable warnings for `hP0_nonneg`, `hP0_sum`, `hδ`, and `hδhalf`; these require mathematical interface review even though Lean accepts the declaration.

## Step 16: current open obligation

The current source revision tested is commit `e230c4508b17fccfd006392b92d39b70d7f23ca6`. It changes only `BBMSTPrefixCylinderMass.lean` to address the dependent boundary index using the explicit `prefixIndex hk (Fin.last k)` expression. The focused CI run [42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215) has now completed with failure.

Focused workflow: [42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215).

The run has now completed with failure:
- checkout, Lean installation, Lake manifest generation and the Lean action succeeded;
- all five actual Step 16 prerequisite modules compiled successfully;
- the Step 16 target compile failed at lines 251, 255 and 259 of `BBMSTPrefixCylinderMass.lean`;
- the axiom trace still contains `sorryAx` in `containsPrefix_extend_iff`, its free/fixed specializations, the dependent cylinder extension equivalences and reindexing results, and `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor`. The next acceptance criteria are: compile all actual prerequisites, compile Step 16, inspect all relevant `#print axioms` output, and confirm absence of `sorryAx` in the target declarations. A successful compile alone is not the final mathematical audit.

## Mathematical scope and remaining global obligations

The statement “only Step 16 remains” applies only to the numbered implementation sequence as recorded above. The existing upstream interface audit in this repository separately documents explicit project axioms `sieve_criterion` and `sf_sieve_lt_one`, the empty-parameter degeneracy, and source-to-code obligations. Those are not erased by successful compilation of Steps 17–22. A complete theorem claim requires a named final theorem, source-faithful hypotheses, a proof of all required BBMST estimates, and a transitive axiom audit showing the intended project-specific assumptions are absent.

The published BBMST result concerns square-free moduli. It must not be conflated with the unrestricted Erdős–Selfridge conjecture. The exact theorem target and its hypotheses must be stated before any claim of completion.

## Research process and AI-use disclosure

The research lead, mathematical direction, selection of proof obligations, evaluation of candidate arguments, and final responsibility are attributed to **Ta-Yoshua Lubuimi**.

ChatGPT (OpenAI) was used as an AI-assisted research and formalization tool. The assistance included exploring and comparing alternative proof strategies, interpreting Lean diagnostics, suggesting candidate proof repairs, navigating source material, and helping maintain the research dossier. Iterative alternative approaches supported the development and testing of the current proof architecture. AI suggestions were treated as hypotheses or candidate derivations requiring independent mathematical scrutiny and formal checking. This dossier does not attribute an independent proof of the conjecture to the AI, nor does it claim novelty solely from AI-assisted exploration.

Lean's kernel checks accepted proof terms relative to their actual dependencies. That fact is reported only for the modules and commits covered by the cited CI runs. Mathematical adequacy, fidelity to the published source, correct use of hypotheses, and final theorem scope remain the responsibility of the researcher and must be reviewed separately.

## Reproducibility and sources

1. P. Balister, B. Bollobás, R. Morris, J. Sahasrabudhe and M. Tiba, “The Erdős–Selfridge problem with square-free moduli,” *Algebra & Number Theory* 15 (2021), 609–626. [DOI: 10.2140/ant.2021.15.609](https://doi.org/10.2140/ant.2021.15.609).
2. Upstream formalization: [axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture](https://github.com/axxen95/Lean-4-formalization-of-the-Erd-s-Selfridge-odd-covering-system-conjecture), pinned commit `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`.
3. Lean toolchain: `leanprover/lean4:v4.28.0`; Mathlib dependencies are resolved by Lake in CI.
4. Step 17 CI: [42488903023](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903023).
5. Steps 18, 19, 21 and 22 CI: [42488903065](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903065).
6. Later Step 20 CI: [42513785862](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42513785862).
7. Current Step 16 diagnostic: [42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215).
8. Workflow definitions: `.github/workflows/diagnostic-prefix-incidence-18-22.yml`, `.github/workflows/step20-isolated.yml`, and `.github/workflows/diagnostic-prefix-cylinder-mass-step16.yml`.

## Release rule

Do not announce the overall proof as complete until Step 16 has passed on the final documented commit, the complete intended theorem has been checked transitively, the target axiom profile is explicitly recorded, and all project-specific assumptions and any `sorryAx` dependencies have been ruled out.


## Latest Step 16 result — 2026-11-08

Run [42515001215](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515001215) completed with failure on `e230c4508b17fccfd006392b92d39b70d7f23ca6`. The five prerequisites succeeded; the target did not. The remaining issue is dependent-index transport between `stageCoordinate hk` and `prefixIndex hk (Fin.last k)`. The compiler diagnostics and `sorryAx` declarations are recorded in Section 12.5 of `BBMST_ProofObligations.md`.

**No third patch is authorized by this status update.** The next code change must follow from inspection of the exact definitions and a derived equality/transport lemma, and must be limited to the demonstrated failing target.


## Latest Step 16 rerun — commit 3ffe65b (status snapshot)

A follow-up source repair was committed as [`3ffe65b`](https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/3ffe65b933222b135d4fa27cd8e6efa358aa8089). The change is confined to `BBMSTPrefixCylinderMass.lean`: it performs the boundary assignment case split at `stageCoordinate hk` and unfolds that definition while simplifying the last-coordinate condition.

The focused run [42515743524](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515743524) was still in progress at the last poll: checkout and Lean/Lake setup succeeded; the Lean action was active; the five prerequisites and Step 16 target compile were pending. The full audit runs [42515744015](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515744015) and [42515750547](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515750547) were also active on the same source commit. These overlapping runs are not independent confirmations.

Accordingly, the new repair remains **OPEN — NOT YET VERIFIED**. The previous failure at `e230c450` is historical evidence for that earlier revision, not a verdict on `3ffe65b`. A final update must record the actual result and axiom output of run 42515743524.


## 12.7 Latest Step 16 CI result — 2026-11-08 (supersedes 12.6 pending status)

The focused run [42515743524](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515743524), on commit `3ffe65b933222b135d4fa27cd8e6efa358aa8089`, is now complete with **failure**. The five actual prerequisite modules succeeded. The target compile failed in `BBMSTPrefixCylinderMass.lean` at:

- Line 253: after simplifying the boundary case, `hlast` still has a dependent match over `H.assignment (prefixIndex hk (Fin.last k))`, while the goal has reduced to `t = s`.
- Line 257: the reverse boundary branch reports a type mismatch between the dependent boundary-match expression and the goal, despite their superficially identical pretty-printed forms.

The job's axiom output reports `sorryAx` in `containsPrefix_extend_iff`, its specializations, the extension equivalences/reindexing results, and the multi-stage cylinder estimate. Since the target compilation itself failed, these traces must be interpreted as error-contaminated declarations generated during failed elaboration, not as proof that an explicit `sorry` exists in the source. The target is nevertheless not accepted; the relevant declarations have not passed kernel verification on this revision.

The full-audit runs [42515744015](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515744015) and [42515750547](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42515750547) both failed at the prefix-cylinder step; subsequent stages 17–22 were skipped in those runs. These are overlapping CI runs on the same commit, not independent proof replications.

**Current status: Step 16 OPEN — FAILED on commit 3ffe65b.** The next repair must be derived from the dependent match and coordinate types at the exact source definitions. Do not patch by guessing a simp set. The documentation branch remains separate from the active proof branch.
