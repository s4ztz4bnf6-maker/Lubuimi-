# JarvisAI LLC — public identity and verification service

A read-only public identity service for the entity identified in the user's RMI dossier. It is isolated from the production gateway and worker.

## Identity from the supplied dossier
- Public/system label: **JarvisAI LLC**
- Exact entity name in the dossier: **JARVIS AI AUTONOMOUS HOLDINGS LLC**
- Claimed RMI registration number: **968412**
- Claimed formation date: **17 November 2026**
- Dossier includes a Certificate of Formation, Certificate of Good Standing, Operating Agreement and Certificate of Incumbency.
- The dossier's Certificate of Good Standing cites verification reference **968412-CGS-1119** and the IRI verification portal.

These are now represented as supplied documentary evidence, not dismissed as absent. The verifier separately checks whether public endpoints return an independently matching entity record.

## Live endpoints
- `GET /healthz` — service health
- `GET /v1/identity` — identity summary and source status
- `GET /v1/verify` — performs fresh read-only HTTP checks against the MIDAO DAO LLC public registry and the verification URL cited in the dossier

## Verification semantics
The verifier distinguishes:
- `candidate_match_requires_authentication`: exact entity name and number appeared in a fetched source response; authenticate the returned record and issuer before treating it as verified.
- `inconclusive_no_public_record_returned`: source could not return a matching entity record. This is **not** a finding that the entity does not exist.
- Network failures/timeouts are recorded separately per source.

The MIDAO registry page currently exposes a search interface. This version deliberately does not invent an undocumented API or pretend that fetching the search page constitutes a registry lookup. The dossier-cited IRI endpoint is checked read-only; the certificate reference is recorded for a later authenticated lookup. No login, access-control bypass, legal filing, signature, or payment is attempted.

## RMI legal model encoded in the profile
RMI DAO Act 2022 §108 recognizes algorithmic management vested in a smart contract, subject to the Certificate of Formation and LLC Agreement. The entity's juridical personality and the legal status/authority of its algorithmic manager are recorded as distinct legal questions. The software does not make categorical legal determinations beyond the sources it can retrieve.

## Security boundary
This public repository contains no private keys, credentials, beneficial-owner data, customer records, or production snapshots. Obfuscation is not treated as security. The verifier makes only outbound GET requests to the published sources.
