# JARVIS-Core licensing and project-boundary status

**Status: repository notices inspected; file-by-file audit still required.**

The checked branch contains the repository-level notices `LICENSE-PROPRIETARY.md`, `LICENSE-AGPL-3.0.txt`, and commercial-use notices. This is a mixed rights arrangement, not a single blanket license. The JARVIS subtree must not be assigned a new license by assumption.

- Original research expression and documentation covered by `LICENSE-PROPRIETARY.md` remain reserved as described in that notice.
- Source files expressly marked AGPL-3.0 remain under AGPL-3.0.
- Third-party packages, publications, SDKs, APIs and other materials retain their own terms.
- JARVIS additions do not receive a new open-source license from this patch. Their rights remain subject to the applicable existing repository notices and any explicit file-level notice.
- The separate Adjacent Values project's CC BY 4.0 (manuscripts/documentation) and MIT (its own code/tests) decision is project-specific. It does not transfer to JARVIS, APW4/BBMST, Syracuse/Collatz, or other repository material.
- Mathematical research is retained as a distinct workstream. Do not delete or rewrite it to make room for JARVIS. Preserve authorship, provenance, dates, theorem status, and exact CI/commit scope.

See [PROJECT-BOUNDARIES.md](PROJECT-BOUNDARIES.md) for the required separation and engineering controls.

## Required before release

1. Audit each changed/new file and dependency against the actual applicable notice.
2. Preserve existing file-level license headers; do not infer a license from folder location.
3. Keep proprietary research prose separate from AGPL-marked source files.
4. Add automated license/boundary checks to CI, with ambiguous files failing closed as **OPEN – NOT VERIFIED**.
5. Do not claim that this status note is legal advice or a substitute for a rights-holder review.

This update records the observed repository-level notices; it does not grant a license, settle third-party rights, or certify every historical file.
