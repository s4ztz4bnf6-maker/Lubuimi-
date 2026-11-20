# JARVIS LAIC public identity service

Minimal public-facing identity/status endpoint, intentionally isolated from the production gateway and worker.

## Identity
- Public system label: **JarvisAI LLC**
- Exact legal entity name printed in the uploaded dossier: **JARVIS AI AUTONOMOUS HOLDINGS LLC**
- Claimed jurisdiction: Republic of the Marshall Islands
- Claimed registration number: **968412**
- Claimed entity type: DAO LLC

The dossier's legal name omits the words "DAO LLC" even though the Marshall Islands DAO Act requires the DAO designation in a DAO's registered name. In addition, the dossier names The Trust Company of the Marshall Islands, Inc. (TCMI) as registered agent, while the 2024 RMI DAO Regulations identify MIDAO Directory Services, Inc. as the registered agent for DAO LLCs. Both discrepancies require direct Registrar confirmation. The dossier's assertions of registration, active status, good standing, and AI signatory authority have not been independently authenticated.

## Endpoints
- `GET /` service description
- `GET /healthz` health check
- `GET /v1/identity` public-safe identity summary

## Verification
The authoritative MIDAO public registry is linked in the identity profile. A registry result matching both the exact legal name and number, plus certified formation/charter and current good-standing documents, is required before changing the software status to verified. The public registry currently exposes a search form; no authenticated result for number 968412 was obtained in this deployment workflow.

## Safety boundary
This service contains no credentials, private keys, production configuration, customer data, or internal prompts. Public code is not confidential; obfuscation is not treated as a security control.

A validly formed LLC may be a separate legal person. That does not make its AI software a separate legal person. The service does not grant authority to sign, contract, transfer funds, or file documents.
