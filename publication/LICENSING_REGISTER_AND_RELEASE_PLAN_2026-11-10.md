# APW4 and Collatz licensing register — 10 November 2026

**Status: rights and attribution recorded; public reuse licences not yet granted.**

## Authorship and attribution

Original APW4 research, the APW4 manuscript and its original proof arguments, the Syracuse/Collatz research, original Lean declarations, research notes, and original computational certificates are attributed to **Ta-Yoshua Lubuimi**. AI systems are research and drafting assistants only; they are not authors, co-authors, or independent mathematical verifiers.

## Repository inspection

As checked on 10 November 2026, neither `s4ztz4bnf6-maker/Lubuimi` nor `s4ztz4bnf6-maker/Lubuimi-` contains a root `LICENSE`, `LICENSE.md`, or `COPYRIGHT.md` file. A copyright notice in an individual source file is not a substitute for a repository-wide licence grant. In the absence of an explicit licence, third parties should not assume permission to redistribute, modify, or commercially exploit original repository material beyond rights supplied by applicable law.

## Material categories

| Material | Attribution / treatment | Licence status |
|---|---|---|
| Original APW4 manuscript and research text | Ta-Yoshua Lubuimi | No public reuse licence selected yet |
| Original Collatz/Syracuse mathematics and notes | Ta-Yoshua Lubuimi | No public reuse licence selected yet |
| Original Lean source authored for these projects | Ta-Yoshua Lubuimi | No public reuse licence selected yet |
| Generated finite tables and original computational certificates | Ta-Yoshua Lubuimi, where original | No public reuse licence selected yet |
| Mathlib and other external dependencies | Their respective upstream authors and maintainers | Their upstream licences remain in force; this register does not relicense them |
| Quoted or reconstructed published mathematics | Original publication authors and publishers, with citations | Their rights and applicable reuse terms remain unchanged |

## Proposed licensing architecture — awaiting the author's choice

A practical split would be:

1. **Lean source:** Apache License 2.0 (or MIT if a shorter permissive licence is preferred). Apache-2.0 provides an express patent grant; MIT is simpler but has no express patent grant.
2. **Manuscripts, documentation, figures, and explanatory research notes:** Creative Commons Attribution 4.0 International (CC BY 4.0), if attribution-only reuse is intended. If commercial reuse or derivatives should be restricted, a different CC variant or an all-rights-reserved policy must be selected deliberately.
3. **Data and finite certificates:** CC BY 4.0 or CC0, depending on whether attribution is required and whether the material is eligible for a copyright licence.
4. **Third-party code and source material:** retain their original notices and licences; never apply the project licence over upstream material.

These are options, not an executed licence grant. No `LICENSE` file has been added and no public reuse permission is claimed until the author chooses the intended policy. The two repositories should use compatible notices and file-level exceptions where required.

## Release checklist after licence selection

- Add the selected full-text `LICENSE` files to both repositories.
- Add a root `COPYRIGHT.md` naming Ta-Yoshua Lubuimi and identifying third-party exclusions.
- Add SPDX identifiers to original source files where appropriate, without altering upstream files.
- Add `CITATION.cff` with the author's preferred citation and ORCID only if supplied.
- Preserve paper citations, upstream copyright notices, and Mathlib's licence.
- Record the exact release commit and verify the final tree contains the intended notices.

**Decision required:** choose (A) all-rights-reserved/proprietary for both projects, (B) Apache-2.0 for Lean code plus CC BY 4.0 for manuscripts/docs, or (C) another explicit scheme. No licence will be guessed.

Last checked: 10 November 2026.