# JARVIS Exchange AI — production baseline (2026-11-23)

## Verified
- GitHub PR #193 merged into `jarvis-core`, merge commit `04f4418c21e0938631ed7ffd29eb27d277ea792c`.
- GitHub workflows **JARVIS Core tests** and **JARVIS-Core tests** succeeded on PR head `d29c0728911b73d970b062a555fe6cd6ba93928c`.
- Railway project `1e7f6bb2-d301-4b64-8bed-aaf623e0960d`, production environment `5629332a-ed44-4267-a1ee-87d43c6b79e1`.
- Gateway deployment `aa8dd166-28e9-4c34-bb71-829e87663c45` reported **SUCCESS**, gateway **online**. Other four Railway services online or cronSucceeded.
- This is deployment health confirmation, **not** a live endpoint or customer-transaction verification.

## Implemented in Gateway
- Authenticated `POST /v1/exchange/quote`: input validation and fail-closed no-provider response; currently zero connected providers.
- Authenticated `GET /v1/exchange/providers`: candidate contact directory, not a live integration.
- Authenticated `POST /v1/exchange/provider-inquiry`: generates inquiry text and returns `deliveryStatus: not_sent`.
- Authenticated `POST /v1/agent-exchange/validate`: validates agent message envelopes; no actual agent transport.
- Revenue and FreeGoods gates are decision-support only, not evidence of actual paid orders.

## Licensing / authorization registry
The following are **verification statuses**, not legal conclusions or license grants.

| Subject | Status | Next verification |
| --- | --- | --- |
| JARVIS LLC company registration | Documents reported available by owner; not independently inspected here | Verify entity documents against official registry before provider onboarding |
| JARVIS Exchange AI own crypto-fiat customer exchange authorization | NOT VERIFIED | Obtain relevant authorization or regulated partner arrangement for each target jurisdiction |
| Kraken partner onboarding | NOT APPLIED / NOT VERIFIED | Confirm third-party customer exchange support, supported jurisdictions, onboarding and costs |
| Coinbase Institutional partner onboarding | NOT APPLIED / NOT VERIFIED | Confirm third-party customer exchange support, supported jurisdictions, onboarding and costs |
| Bitpanda Technology Solutions partner onboarding | NOT APPLIED / NOT VERIFIED | Confirm embedded customer exchange support, supported jurisdictions, onboarding and costs |
| External AI providers' API access, terms and commercial-use permissions | NOT VERIFIED | Verify credentials, commercial use, pricing, limits, data handling and supported actions |
| Exchange AI customer KYC/AML workflow | NOT CONNECTED | Integrate verified provider-managed workflow |
| Fiat payout / BTC signing and settlement | NOT CONNECTED | Test authorized real settlement with custody/payment rails |
| Provider outreach transmission | NOT CONNECTED | Integrate approved mail/CRM transport and independently verify delivery |

## Change control
- Preserve existing source and deployment IDs; never place secrets or private keys in this file.
- Update statuses only with source evidence, timestamp and relevant provider/jurisdiction.
- No live customer conversion, custody or payment should be marked active until a verified provider, applicable authorizations, settlement rails and end-to-end evidence exist.
- Free or zero-upfront-cost integrations may still incur network, trade, withdrawal and bank charges.

## Commercial service quoting — code update (2026-11-23)
- `POST /v1/services/quote` added: authenticated B2C/B2B estimates for software, automation, translation, security review and data analysis, EUR/USD pricing in minor units. Estimates are **not** accepted orders, invoices or settled revenue; scope and tax treatment require confirmation.
- Test cases added to Gateway test suite. CI and production rollout **not yet verified** for this update.
- Commercial license/permission registry: software dependencies and third-party model/provider commercial terms **not independently verified**; cybersecurity services must be authorized by the client; no jurisdiction-specific professional accreditation is claimed. The exchange licensing statuses above remain unchanged.
