# JARVIS FreeGoods Commerce — integration contract
This feature is a **scaffold**, not a live trading system. No partner, buyer, supplier, or payment provider is connected.

## Pipeline
1. GiftDiscovery searches permitted public sources (not automated signups, no CAPTCHA bypass).
2. BuyerDiscovery searches public expressions of demand; public posts do **not** authorize unsolicited contact.
3. Normalize exact product identity, location, terms, availability, identity eligibility, and buyer permission.
4. FulfillmentPartner provides verified inbound, handling, shipping, insurance and customs quotes.
5. evaluateMatch blocks insufficient margin or missing evidence; all matches remain review_required.
6. BuyerCommunications sends a truthful conditional proposal only with configured provider and explicit authorization.
7. Buyer acceptance is independently verified; GiftSupplier claims only where the specific recipient is eligible, terms permit commercial transfer and the hub address is allowed.
8. Logistics partner receives goods and supplies proof; forwarding is separately authorized and funded.
9. Billing issues accurate invoice and verifies payment via actual provider records.
10. Reconcile delivery, refunds, returns, fees, taxes and exceptions.

## Missing to operate
- Real discovery integrations, source permissions, demand APIs, deduplication and durable job scheduler
- Verified supplier permission and ownership/transfer documentation
- Contracted 3PL with inbound reference numbers, pricing, API, insurance, return handling
- Approved buyer communications and enforceable order/contract acceptance flow
- Payment processor, invoice reconciliation, tax and customer-support configuration
- Migration applied to production, worker integration, end-to-end tests and deployment
- Budget and spending approval before logistics or supplier charges

Agent IDs do not confer independent legal identities or gift eligibility. No self-dealing, fabricated buyer demand, unsolicited bulk outreach, or multiple-identity circumvention.
