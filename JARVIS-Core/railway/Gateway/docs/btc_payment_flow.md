# JARVIS BTC payment workflow — draft, not deployed

## Scope
Read-only mainnet observation. No signing keys, bank API access, payouts or fiat conversion.
Only invoices attached to real, accepted orders may be issued.

## Address assignment
Use one unique watch-only receive address per invoice. The same static BTC address
must not be used to infer a unique payer. Do not place wallet xpubs in logs or agent tasks.

## Observation
The monitor checks transaction outputs by txid + vout against an expected address.
Query a trusted chain source and independently re-check confirmation state.
One confirmation is the minimum policy, not a guarantee against reorganization.
Never trust an unauthenticated webhook as proof of payment.

## Persistence
Apply database/migrations/init_finance.sql only after schema review.
UPSERT outputs on (txid,vout), preserve satoshi integer amounts, and update
confirmations when blocks change. Handle chain reorganizations by rolling back
settlement status. A paid invoice requires sufficient confirmed output totals
and an unambiguous invoice-to-address mapping. Do not mark paid on mere receipt
of an HTTP event or on an unconfirmed transaction.

## Testing and release
Unit-test malformed txid, output mismatch, zero confirmations, duplicated outputs,
partial payments, overpayments, provider outages, and reorganizations.
Use mock blockchain data or isolated regtest; no real BTC transfers required.
No production merge or deployment without review and passing CI.

## Financial and AML controls
Distinguish received funds from receivables and unaccepted leads.
Fiat deposits require independent owner-supplied evidence; agents have no bank access.
Risk-based compliance review must be designed separately; no blanket KYC threshold.
No automated outgoing BTC or fiat transactions.
