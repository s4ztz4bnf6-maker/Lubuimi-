# Human contribution and provenance ledger

**Research lead / formalization developer:** Ta-Yoshua Lubuimi  
**Project:** BBMST Lean Formalization and Source-Audit Project  
**Status:** living evidence ledger; entries are intentionally conservative.

## Attribution rules

- Attribute the published 2021 BBMST theorem and its original proof to Balister, Bollobás, Morris, Sahasrabudhe, and Tiba.
- Attribute this repository's research direction, project decisions, Lean implementation, and documentation to Ta-Yoshua Lubuimi only to the extent supported by the repository history and contemporaneous research records.
- Describe ChatGPT as an AI-assisted tool, not an author or independent verifier.
- Separate idea origin, mathematical proof, code implementation, and machine verification. A commit or green CI run is evidence for the latter two, not automatically for novelty or sole intellectual origin.
- Never label a contribution “new,” “first,” or a “breakthrough” until the literature comparison and independent review support that description.

## Milestone ledger

| Milestone | Evidence currently recorded | Attribution / limitation | Verification status |
|---|---|---|---|
| Research programme and staged Lean architecture | Repository history and project documentation | Research direction and implementation led by Ta-Yoshua Lubuimi; precise idea-by-idea origin should be cross-checked against dated notes and commits | Documented, provenance review pending |
| Finite fibre-mass and event-mass developments | Lean modules and isolated CI records cited in the status dossier | Distinguish formalization of known BBMST ingredients from any genuinely new strengthening | Declaration-level review pending |
| Prefix-cylinder extension and multi-stage estimate | `BBMSTPrefixCylinderMass.lean`; Step 16 run 42515743524 | The current target did not compile; no accepted result or breakthrough claim | **OPEN — FAILED on 3ffe65b** |
| Upstream sieve-interface degeneracy audit | `AuditCheck.lean`, pinned upstream commit `fe530b2cedd3a71c2cdb47cc36ed0c3cb047b086`, successful historical audit run 38395315555 | A formalization/interface finding only; not a counterexample to the published theorem | Reproduction documented; independent review required |
| Complete square-free-moduli theorem formalization | Intended final theorem and complete dependency chain | Do not claim completion until integrated build, source fidelity, and final transitive audit pass | **NOT ESTABLISHED** |

## Required fields for every future entry

| Field | Record |
|---|---|
| Date and first evidence | YYYY-MM-DD; commit, issue, dated note, or draft |
| Contribution statement | One precise mathematical or engineering claim |
| Origin evidence | What shows when and by whom the idea was developed |
| Formal definition | Exact source definition and hypotheses |
| Mathematical proof | Complete proof reference, separate from Lean status |
| Prior-art comparison | Exact BBMST lemma/equation or other literature; explain what is identical or different |
| Lean artifact | File, declaration, source commit |
| Verification | Workflow/run, job, successful compile, exact axiom output |
| Review | Independent reviewer, date, comments, resolution |
| Claim status | Proved / formalized / source-reconstructed / conditional / open / refuted |

## AI-use record (to be completed from history)

| Tool/model | Dates or sessions | Concrete assistance | Human review and accepted outcome |
|---|---|---|---|
| ChatGPT / OpenAI | To be reconstructed from project history; do not assume GPT-6 was the only model | Proof-strategy exploration, Lean diagnostics, candidate repair suggestions, source navigation, documentation | Every accepted mathematical statement and proof obligation remains subject to human review and Lean verification |

Do not describe a subjective sense that AI “corrupted” the process in this technical contribution ledger. If relevant, preserve it for a separate reflective account with concrete examples, corrections, and impact analysis. The publication declaration should stay factual: tools used, tasks performed, human oversight, and responsibility.

## Current decision

No claim of a complete proof, a new theorem, patentable invention, or publication-ready formalization is supported by the current evidence. The strongest present claims are the staged Lean results at their individually cited commits and the narrowly scoped upstream interface audit, each with the limitations recorded above.


## 2026-11-08 scope and verification update

A source-level review of the pinned upstream file confirms that the declaration named `erdos_selfridge` is unrestricted (its signature has no `CS_squarefree` premise) and invokes the explicit axioms `sieve_criterion` and `sf_sieve_lt_one`. Do not attribute a completed proof of the BBMST square-free theorem to this declaration. The exact theorem-scope correction and provisional source correspondence are recorded in `BBMST_SOURCE_TO_LEAN_MAP_2026-11-08.md`.

Fresh reruns of historical CI jobs have been initiated for Steps 17–22. At the latest documented poll, Steps 19, 21 and 22 had rerun successfully; Steps 17, 18 and 20 were still running. Record each completed result only with its job ID, workflow run, source commit, actual log and printed axiom profile. These isolated module reruns do not establish a full theorem proof.


### Completed rerun record — 2026-11-08

All six direct isolated reruns of Steps 17–22 completed successfully. Job IDs: Step 17 `128842591881`; Step 18 `128842605058`; Step 19 `128842605996`; Step 20 `128842622425`; Step 21 `128842627032`; Step 22 `128842642270`. Each log was checked for the standard axiom profile and for `sorryAx`/compiler errors. Step 20 additionally reports unused assumptions `hP0_nonneg`, `hP0_sum`, `hδ`, and `hδhalf` in a finite Fubini identity; record this as a theorem-interface review item, not as a compile failure. These are isolated historical workflow commits and do not amount to a single integrated build or final theorem audit.


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
