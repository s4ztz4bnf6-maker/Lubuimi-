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
