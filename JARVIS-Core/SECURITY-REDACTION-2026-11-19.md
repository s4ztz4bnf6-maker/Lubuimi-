# Security redaction record — 2026-11-19

## Finding

A source scan of the public `jarvis-core` branch found literal Bitcoin receive addresses in the Worker and Companion source snapshots. The Worker launch-command artifact also retained the encoded inline payload from which the addresses could be reconstructed. These were public receive addresses, not private keys, seed phrases, API tokens or credentials.

## Remediation at current branch tip

- Replaced literal receive addresses in `railway/Worker/index.ts` with redaction markers.
- Replaced literal receive addresses in `railway/Companion/index.ts` with redaction markers.
- Removed the original encoded Worker launch payload and replaced it with a non-deployable notice.
- Updated the Worker README, export manifest and top-level README to describe the privacy-scrubbed status.
- Re-scanned the current Worker and Companion source snapshots: zero literal Bitcoin address matches.

## Residual historical exposure

These updates change the current branch tip; they do not erase earlier Git objects or commits. Because the repository is public, older commits may still expose the former receive addresses. The same caveat applies to any prior public mirror commits. Do not rely on file replacement as historical deletion.

A fresh receive-address set is the practical way to prevent future activity from being linked to the old addresses. No wallet configuration was changed as part of this remediation. No private key, seed phrase or spending credential was found in the source scan.

## Scope of scan

The scan checked the current Worker and Companion source files for common Bitcoin mainnet address forms. This is a targeted pattern scan, not a full repository secret audit and not a guarantee that all sensitive information has been removed from Git history.
