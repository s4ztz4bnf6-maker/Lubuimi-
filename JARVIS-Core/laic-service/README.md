# JARVIS LAIC public identity service

Minimal public-facing identity/status endpoint, intentionally isolated from the production gateway and worker.

## Endpoints
- `GET /` service description
- `GET /healthz` health check
- `GET /v1/identity` public-safe identity summary

## Safety boundary
This service contains no credentials, private keys, production configuration, customer data, or internal prompts. Public code is not confidential; obfuscation is not treated as a security control.

The legal entity details are recorded as user-supplied assertions and are not independent proof of registration. The service does not represent that the AI system itself is a separate legal person, and it does not provide legal authority to sign, contract, transfer funds, or file documents.
