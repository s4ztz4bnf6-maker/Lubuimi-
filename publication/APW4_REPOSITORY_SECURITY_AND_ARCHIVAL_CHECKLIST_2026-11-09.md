# APW4 repository security and archival checklist

**Owner:** Ta-Yoshua Lubuimi  
**Repository:** s4ztz4bnf6-maker/Lubuimi-  
**Record date:** 9 November 2026

This checklist records the controls that can and cannot be applied through the connected GitHub integration. It deliberately distinguishes completed repository changes from settings that require the repository owner's GitHub web interface or an external archive account.

## Confirmed repository state

- Repository is public and its default branch is main.
- The connected GitHub account reports admin, maintain, and push permissions.
- The APW4 main manuscript and the licensing documents are committed on main and release/apw4-publication-2026-11-09.
- The proprietary rights notice and separate paid commercial licensing policy are present.
- The Erdős–Selfridge Lean audit note is separately recorded and is not part of APW4.
- A public repository commit history is available, but it is not an independent backup.

## Branch protection: action required in GitHub settings

The branches main and release/apw4-publication-2026-11-09 were reported as unprotected when checked. The available GitHub integration can read repository state and commit files, but it exposes no branch-protection mutation action. Therefore branch protection has not been enabled by this update.

Using an account with repository administrator access, open:

Settings → Rules → Rulesets → New ruleset → New branch ruleset

Create a ruleset targeting main and release/apw4-publication-2026-11-09. Recommended controls, subject to the owner's workflow:

- require a pull request before merging;
- require at least one approval if another trusted reviewer is available (otherwise use an owner-controlled review policy rather than a meaningless self-approval);
- require status checks for the relevant Lean audit and publication checks;
- require branches to be up to date before merging, where appropriate;
- block force pushes and branch deletion;
- restrict bypass permissions to the owner and explicitly trusted administrators;
- consider requiring signed commits if the owner's signing workflow is configured.

Do not enable required status checks until the exact check names have been confirmed from successful runs. A misconfigured ruleset can block legitimate publication updates.

## Immutable publication release: action required

The GitHub Releases endpoint returned no releases when checked. The available integration has no release-creation or tag-signing action. Consequently, this update has not created an immutable GitHub Release or signed tag.

After final review, create an annotated, preferably signed tag for the exact publication commit, then create a GitHub Release from that tag. Do not move or reuse the tag after publication. Keep the source manuscript, rendered PDF, citation metadata, license files, and SHA-256 manifest together in the release assets.

## Independent archival copy: action required

The final PDF binary was not available to this update, and no external archive account was connected. The PDF has therefore not been uploaded to Zenodo or another independent repository.

For preservation, deposit the final PDF and source bundle in an archival repository that issues a persistent identifier (for example, a DOI), preserves version records, and exposes file checksums. Keep a second independent backup outside GitHub. Retain the DOI landing page, deposit receipt, and exact archived files.

## PDF and checksum: action required

Once the final PDF is available locally, calculate a SHA-256 checksum and include it in a manifest alongside:

- the exact manuscript filename and version/date;
- source Markdown/TeX files, if applicable;
- the canonical Git commit SHA;
- the Lean toolchain and dependency manifest relevant to the cited verification;
- the applicable rights and license files.

Do not publish a guessed checksum or claim that the PDF is mirrored until the actual binary has been uploaded and fetched back for verification.

## Commercial rights

The repository's LICENSE-PROPRIETARY.md and LICENSE-COMMERCIAL-USE-AND-REMUNERATION.md reserve the author's rights in original materials and state that commercial use requires prior express written permission under a separately negotiated agreement. For monetization, the author should use a signed license contract defining scope, fees or royalties, reporting, audit rights, duration, territory, sublicensing, and remedies. A public rights notice is useful evidence of intent, but it is not a substitute for an individually negotiated agreement or jurisdiction-specific legal advice.

---

**Copyright © 2026 Ta-Yoshua Lubuimi. All rights reserved.**
