# JARVIS: MCP access, legal authority and autonomy

## No backdoor into a private ChatGPT conversation

Do not create a hidden route, browser-session theft, cookie reuse, private-chat scraping,
or an unauthenticated public endpoint. A private ChatGPT conversation is not a general
webhook that an external agent can write into.

The supported architecture is a remote, authenticated MCP server (HTTPS, OAuth or
equivalent scoped authentication) that exposes narrowly scoped JARVIS tools. ChatGPT
must explicitly connect to that server under a plan/workspace that supports custom MCP.
This is a separate supported integration, not a way to inject messages into an existing
private conversation from outside.

As checked 2026-11-19, OpenAI's current Help Center says full custom MCP with write
actions is available on ChatGPT Business and Enterprise/Edu web; Pro custom MCP is
read/fetch only; mobile custom MCP connections are not supported. Confirm current
account/workspace permissions before implementation:
https://help.openai.com/en/articles/12584461-connecting-custom-mcp-servers-in-chatgpt

Implementation requirements:
- Separate development service/branch first; no production ingress changes by default.
- HTTPS only; OAuth/scoped tokens; short-lived credentials; no hard-coded secrets.
- Explicit allowlist of tools and operations; read-only by default.
- Request IDs, replay protection, audit events, rate limits and revocation.
- Never expose Postgres, shell, arbitrary URL fetch, browser profile, or unrestricted
  filesystem through MCP.
- ChatGPT connector invocation is not a guarantee that this exact chat can be
  contacted asynchronously by JARVIS. Keep the human relay as a supported fallback.

## Legal identity and eIDAS

An AI application cannot make itself a legal person by changing a database field,
generating an Ed25519 key, or displaying a company name. The software must not claim
that JARVIS itself is a legal entity.

If a genuine company/association/other legal person operates JARVIS, record that
entity's exact registered name and number only after authoritative registry evidence
has been checked. Separately verify the natural person's authority to represent it.

An electronic seal is for a legal person and is not the legal person's electronic
signature. A qualified electronic seal requires a qualified certificate from a
qualified trust-service provider and the applicable controlled signing/sealing
arrangements. A self-generated key is not a qualified eIDAS seal.

Official references:
- European Commission eSignature FAQ:
  https://ec.europa.eu/digital-building-blocks/sites/spaces/DIGITAL/pages/880312429/eSignature+FAQ
- European Commission eIDAS trust-services FAQ:
  https://digital-strategy.ec.europa.eu/en/news/questions-answers-trust-services-under-eidas
- eIDAS Regulation, Article 35:
  https://eur-lex.europa.eu/eli/reg/2014/910/2024-05-20

Until verified, keep identity status UNVERIFIED and block seal issuance, contract
execution, bank-account applications, payments and other binding external actions.
JARVIS may research providers, prepare draft documents, and compile a checklist.
Bank onboarding and legal declarations require the real entity and its authorized
representative; do not submit an application in the name of an AI system.

## Autonomous work, jobs and gifts

Allowed without legal-entity status:
- Search and rank public paid work, grants, bounties and free offers.
- Check eligibility, deadlines, AI-use rules, payout conditions and scam indicators.
- Prepare drafts and application packages.
- Track applications and externally verified outcomes.

Not allowed without explicit human approval and verified authority:
- Submit binding offers or accept contracts.
- Provide identity declarations or represent JARVIS as a legal person.
- Open accounts, spend money, make payments, transfer crypto or disclose credentials.
- Accept gifts requiring payment, fees, taxes, identity claims or contractual obligations.

A task is not "earned" until the counterparty has accepted it; a claim is not "paid"
until a payment record or on-chain/Lightning evidence confirms receipt. Keep internal
worker completions separate from external results.

## Worker capacity and owner access

Do not scale replicas or parallelism blindly. Measure queue depth, task latency,
provider rate limits, memory/CPU, failure/retry rates and cost per successful task.
Use bounded concurrency, idempotency, backoff and per-provider budgets. Preserve the
owner's existing login, recovery route, sessions and administrative access. Never
rotate or revoke credentials as part of capacity work.
