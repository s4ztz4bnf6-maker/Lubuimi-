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

 
## 12.8 Steps 17–22 re-verification and theorem-scope correction — 2026-11-08

### Historical module evidence

- Step 17: successful isolated compile in run [42488903023](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903023), commit `125507564b4b6d89565d0d606ab0bd38951b158d`.
- Steps 18, 19, 21 and 22: successful isolated jobs in run [42488903065](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42488903065), same commit.
- Step 20: failed in the earlier job in run 42488903065; later successful isolated compile in run [42513785862](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42513785862), commit `9daa08aecc68ce9de0e086ca006dbc9980ab5ad0`.
- The source comparison from `9daa08a` to `3ffe65b` shows that the Lean target files for Steps 17–22 were not modified. This makes the Step 20 success relevant to the unchanged module, but it is not a fresh run on the exact `3ffe65b` tree.

### Fresh rerun branch

A separate branch `verification/steps-17-22-rerun-2026-11-08` was created from `3ffe65b`. Its only change is the workflow file `.github/workflows/rerun-steps-17-22-isolated.yml`, committed as `364a07358e1856b5a17a6963f2f223061b92fb5e`. The workflow defines six isolated jobs (17–22) and deliberately excludes Step 16. No Actions run ID or status check has yet been returned for this commit; fresh rerun status is **NOT YET CONFIRMED**. Do not report it as running or successful without the corresponding GitHub Actions evidence.

### Critical theorem-scope correction

The pinned upstream source `ErdosSelfridge_v17_fixed.lean` at `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086` defines `CS_squarefree`, but the theorem `erdos_selfridge (K) (cs) : ¬ CS_allOdd cs` has no square-free hypothesis. It is an unrestricted odd-covering statement. The same file declares `sieve_criterion` and `sf_sieve_lt_one` as axioms, and the proof of `erdos_selfridge` invokes both. Thus this declaration is not a kernel-derived proof of the unrestricted conjecture and is not the exact statement of BBMST Theorem 1.1.

BBMST Theorem 1.1 is the square-free-moduli statement: any finite collection of arithmetic progressions with distinct square-free moduli greater than one that covers the integers has at least one even modulus. The corresponding geometric statement is Theorem 1.2. A separate exact square-free target and the CRT correspondence must be formalized and audited. This issue is independent of the Step 16 compile and is a hard publication gate.

See `research/BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md` for the provisional mapping of Lemmas 2.1, 3.3, 3.4, Theorems 3.1–3.2 and equation (11) to current Lean modules.

**Current overall status remains:** Step 16 failed on `3ffe65b`; Steps 17–22 have historical isolated successes but no confirmed fresh rerun on that exact tree; the complete square-free BBMST theorem is not yet established; no complete-proof publication claim is supported.


## 12.9 Direct reruns of historical isolated jobs — latest poll 2026-11-08

The GitHub rerun endpoint accepted direct reruns of the previously successful isolated jobs. Latest observed state:

| Step | Rerun job | Workflow run | Latest result |
|---|---:|---:|---|
| 17 | `128842591881` | `42488903023` | In progress; dependency/cache setup |
| 18 | `128842605058` | `42488903065` | In progress; Lean action |
| 19 | `128842605996` | `42488903065` | **Success** |
| 20 | `128842622425` | `42513785862` | In progress; dependency/cache setup |
| 21 | `128842627032` | `42488903065` | **Success** |
| 22 | `128842642270` | `42488903065` | **Success** |

The earlier Step 20 failure job `128842606683` remains visible as the historical failed attempt in run 42488903065; the later Step 20 workflow run 42513785862 is the one being rerun. Logs for the three still-running jobs were not yet available at the last poll. Do not report them as passed until the job completes and its compile/axiom output is inspected. The three completed reruns show the standard profile `[propext, Classical.choice, Quot.sound]` in their declaration traces and no `sorryAx` in the captured output.

These jobs rerun the historical workflow commits. The relevant Lean source files are unchanged through `3ffe65b`, but there is still no single integrated run of Steps 17–22 on one common commit, and none of these jobs incorporates Step 16.


## 12.10 Completed rerun update — latest verified logs, 2026-11-08

Steps 17 and 18 have now also completed successfully in their direct reruns:

- Step 17 job `128842591881` in run `42488903023`: **success**; the `BBMSTPrefixMomentBridge` declarations were printed with `[propext, Classical.choice, Quot.sound]`.
- Step 18 job `128842605058` in run `42488903065`: **success**; the `BBMSTHyperplaneFibreIncidence` declarations were printed with `[propext, Classical.choice, Quot.sound]`.
- Step 19 job `128842605996`: **success**.
- Step 21 job `128842627032`: **success**.
- Step 22 job `128842642270`: **success**.
- Step 20 job `128842622425` in run `42513785862`: **success**; the Step 20 target `BBMSTPrefixIncidenceBridge.lean` compiled.

The complete logs for the five completed jobs were checked: the expected standard profile was printed for the relevant declarations, no `sorryAx` string occurred, and no compiler `error:` line occurred. These are five successful isolated module reruns, not a complete end-to-end theorem audit. Step 20 remains pending, Step 16 remains failed on `3ffe65b`, and the unrestricted-vs-square-free theorem-scope correction remains a separate hard gate.


## 12.11 Steps 17–22 rerun completion — 2026-11-08

All six requested isolated reruns have now completed successfully:

| Step | Rerun job | Run | Result |
|---|---:|---:|---|
| 17 | `128842591881` | `42488903023` | **Success** |
| 18 | `128842605058` | `42488903065` | **Success** |
| 19 | `128842605996` | `42488903065` | **Success** |
| 20 | `128842622425` | `42513785862` | **Success** |
| 21 | `128842627032` | `42488903065` | **Success** |
| 22 | `128842642270` | `42488903065` | **Success** |

The full logs of all six completed rerun jobs were inspected. Each relevant declaration trace showed the standard profile `[propext, Classical.choice, Quot.sound]`; none of the six logs contained `sorryAx` or a compiler `error:` line. Step 20's log additionally warns that `hP0_nonneg`, `hP0_sum`, `hδ`, and `hδhalf` are unused in `prefixPairReserve_eq_weightedPairCount`. This equality is a finite combinatorial/Fubini identity and appears not to require those analytic hypotheses; the interface should be reviewed and possibly simplified, but the warnings do not themselves indicate a failed proof.

**Scope of this success:** these are six isolated module reruns at their historical workflow commits. A source comparison confirms the Lean target files were unchanged through `3ffe65b`, but the six jobs do not constitute a single clean integrated build on one common commit. Step 16 remains failed on `3ffe65b`, and the separate exact square-free theorem target, CRT correspondence, global axiom replacement, and final transitive audit remain outstanding.


## Current verification and publication-preparation update — 2026-11-08

**Named research artifact / working title:** *Ta-Yoshua Lubuimi — A Lean 4 Research and Source-Audit Project on the BBMST Square-Free-Moduli Problem*. This is an attribution/title for this repository's research and software artifact; it does not rename the published BBMST theorem or imply sole authorship of the original mathematics.

**Code under active Step 16 repair:** branch `fix/step16-dependent-boundary-transport-2026-11-08`, head `59a55e4c5054dcebc99910cf11415646c1fef404`. Relative to base `3ffe65b933222b135d4fa27cd8e6efa358aa8089`, the branch changes one Lean source file (`BBMSTPrefixCylinderMass.lean`) and adds two focused workflow files. No other Lean module is changed by this repair branch.

**Latest Step 16 verification:** focused run [42518133266](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42518133266) on `59a55e4` completed with failure. All five actual prerequisites compiled; the target failed at lines 249 and 261 because the two `change` tactics did not match the elaborated dependent boundary expressions. The failed elaboration prints `sorryAx` for downstream declarations; these are not accepted kernel proofs and do not establish a source-level `sorry`. Step 16 remains **OPEN — FAILED on 59a55e4**.

The parallel foundation/full audit run [42518133245](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42518133245) compiled its upstream audit, aligned sieve core, fibre measure, finite update, uniform fibre instantiation, stage moment, geometry and prefix recursion steps successfully, then failed at the Step 16 prefix-cylinder module. Later modules were skipped. This is a single ordered regression chain, not a complete successful build.

**Steps 1–5 regression request:** the current documentation and inspected root-level Lean source inventory do not provide an authoritative mapping from numbered Steps 1–5 to five exact Lean files/declarations or dedicated workflow jobs. The five Step 16 prerequisites must not be silently relabelled as Steps 1–5. A fresh 1–5 run is therefore **NOT YET STARTED / TARGET MAPPING REQUIRED**. Once the original step ledger or exact targets are identified, run them independently and record each source commit, job, compile result and axiom output.

**Steps 17–22:** six direct isolated reruns were previously confirmed successful (job IDs 128842591881, 128842605058, 128842605996, 128842622425, 128842627032 and 128842642270). They were historical-workflow isolated reruns, not one integrated build on the Step 16 repair head.

**Publication status:** the documentation branch remains separate from all proof and repair branches. This update changes documentation only. The project has not yet passed Step 16, a single integrated build, a final transitive axiom audit, or the exact square-free theorem/CRT source-correspondence gate. The upstream unrestricted `erdos_selfridge` declaration and its explicit sieve axioms remain unsuitable as a substitute for BBMST Theorem 1.1.

**Reproducibility:** Lean 4.28.0 is pinned by `lean-toolchain`; Mathlib is requested by tag `v4.28.0`. The reviewed proof snapshot still lacks a committed `lake-manifest.json`; exact dependency locking and clean-checkout verification remain release tasks.

**AI and authorship:** Ta-Yoshua Lubuimi is named as research lead and formalization developer. ChatGPT is disclosed as an AI-assisted tool, not an author or independent verifier. The precise historical model list must be reconstructed from actual project records before submission. The original BBMST theorem remains attributed to its five published authors.


## 2026-11-08 addendum: dependent boundary-match diagnosis

The Step 16 repair head remains `59a55e4c5054dcebc99910cf11415646c1fef404`. Focused run [42518133266](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42518133266), job `128845536627`, confirms: all five actual prerequisites compiled; the Step 16 target failed at lines 249 and 261 on `change` tactics attempting to replace a dependent match at `prefixIndex hk (Fin.last k)` with one at `stageCoordinate hk`.

Interpretation is deliberately narrow: this is a failure to identify the *whole dependent match expressions* definitionally. It is not evidence that the coordinate definition itself is wrong. Since the assignment fibre is `C.S i`, the proof must handle transport of the branch value across the coordinate equality, rather than rewriting the complete match wholesale.

The next planned proof step is to isolate the assignment case split at a single boundary index, establish the coordinate equality, and explicitly transport the dependent `C.S i` value before applying `extendPrefix_last`. This remains a design plan; no candidate patch has been compiled or accepted. The repair branch and all Lean source files remain unchanged by this dossier update.

**Status:** Step 16 **OPEN — FAILED on 59a55e4**. Steps 1–5 remain unmapped to authoritative targets and have not been relabelled or rerun. The documentation-only update is on the publication-readiness branch; no integrated build, final transitive axiom audit, or theorem-scope gate is passed by this update.


## Candidate transport repair — CI pending (2026-11-08)

Repair commit: [`27090476ac778d1e512a2939920749770026e27a`](https://github.com/s4ztz4bnf6-maker/Lubuimi-/commit/27090476ac778d1e512a2939920749770026e27a). The only Lean source changed is `BBMSTPrefixCylinderMass.lean`. It adds the definitional coordinate equality `stageCoordinate_eq_prefixIndex` and rewrites the two boundary hypotheses in opposite directions to expose the dependent transport explicitly.

Three workflows were started on this exact commit:
- focused Step 16: [42519176511](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519176511);
- pre-Step-16 foundation regression: [42519176485](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519176485);
- ordered full audit: [42519176465](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519176465).

At the latest poll, all three remained in dependency installation / Lake manifest generation. **No Lean compile result is available yet.** Step 16 remains **OPEN — CANDIDATE PATCH, CI PENDING**. The candidate must not be called a successful repair until the focused target compile succeeds and its successful declaration axiom output is inspected. The active audit branch remains untouched; this update is documentation-only.


## Current Step 16 snapshot — 2026-11-08

The authoritative current CI state is recorded in [the Step 16 current-status addendum](research/STEP16_CURRENT_STATUS_AND_DOSSIER_ADDENDUM_2026-11-08.md). It supersedes earlier “latest” or “pending” status statements in this document for the repair branch head `2ea5983bb8627379873edda743e6b0249116274b`. At the recorded poll, focused Step 16 run `42519816145`, foundation run `42519816133`, and full audit run `42519816128` were still in progress; no new Step 16 compiler result or axiom audit was available. Step 16 remains **OPEN — NOT VERIFIED**. Do not infer success or merge from an in-progress run.


## Latest Step 16 CI outcome — 2026-11-08

The later poll completed all three runs. Focused Step 16 [42519816145](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816145), job `128850631653`, **failed**: all five prerequisites compiled, but `BBMSTPrefixCylinderMass.lean` failed at lines 255 and 259. Both errors are dependent-match type mismatches for the same pretty-printed match on `H.assignment (prefixIndex hk (Fin.last k))`; the simplifier-based transport did not resolve the dependent type distinction. Its failed-elaboration axiom trace contains `sorryAx` for dependent target declarations, so the target is not accepted. Foundation regression [42519816133](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816133), job `128850631591`, **succeeded**. Full ordered audit [42519816128](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42519816128), job `128850631484`, **failed at the prefix-cylinder event-mass module** after all earlier stages in that workflow succeeded; subsequent stages 17–22 were skipped. Current Step 16 status: **OPEN — FAILED** on head `2ea5983bb8627379873edda743e6b0249116274b`. No merge. Full evidence and interpretation: [current Step 16 status addendum](research/STEP16_CURRENT_STATUS_AND_DOSSIER_ADDENDUM_2026-11-08.md).


## Final integrated Step 16 verification — 2026-11-08

This section supersedes the earlier Step 16 failure/pending snapshots above for the current repair branch. Those earlier failures remain preserved as historical diagnostics and are not erased.

**Verified repair head:** `ca9d245aa1851a54b65850ddb1130d1ca12e850e`  
**Lean source blob:** `2d9587ffceb7fac729a3219b6b5114f1512936ad`  
**PR:** [#63](https://github.com/s4ztz4bnf6-maker/Lubuimi-/pull/63), open and unmerged.

| Audit gate on the repair head | Run | Job | Result |
|---|---:|---:|---|
| Focused Step 16 compile and axiom print | [42522812223](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812223) | 128859824694 | PASS |
| PR-focused Step 16 verification | [42522812150](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812150) | 128859824529 | PASS |
| Pre-Step 16 foundation regression | [42522812092](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812092) | 128859824287 | PASS |
| Full ordered 22-module audit | [42522812163](https://github.com/s4ztz4bnf6-maker/Lubuimi-/actions/runs/42522812163) | 128859824547 | PASS |

The full ordered job completed all 23 job steps (setup/checkout plus all 22 module stages). It compiled the upstream audit source, aligned sieve core, fibre measure core, finite weighted fibre update, uniform-coordinate instantiation, stage-moment core, geometry core, uniform-stage source moments, prefix-measure recursion, **Step 16 prefix-cylinder event-mass identities**, prefix-to-stage moment bridge, hyperplane-fibre incidence bridge, old-shadow intersection geometry, prefix-to-hyperplane bridge, finite weighted union/noncoverage bound, and final `BBMSTMomentRecurrence` module.

The complete logs for the focused Step 16 run and full ordered audit were inspected:
- no compiler-error lines;
- no `sorryAx` occurrences;
- Step 16 declarations `containsPrefix_extend_free`, `containsPrefix_extend_fixed`, `containsPrefix_extend_iff`, `prefixCylinder_free_mass_eq`, `prefixCylinder_fixed_mass_le`, and `prefixCylinderMass_le_initial_mul_hyperplaneSuffixFactor` print the standard project profile `[propext, Classical.choice, Quot.sound]`;
- the full audit's downstream modules, including `BBMSTMomentRecurrence.cKThree_succ`, also compile successfully and print the standard profile.

The full log additionally preserves the pre-existing explicit upstream axiom dependencies `sieve_criterion` and `sf_sieve_lt_one` on the imported `erdos_selfridge` declaration. These do not occur in the Step 16 declarations.

**Current Step 16 status: VERIFIED — PASS on repair commit `ca9d245`.** The successful full ordered audit is integrated evidence, not merely an isolated module compile. PR #63 remains open and unmerged; no merge was performed.
