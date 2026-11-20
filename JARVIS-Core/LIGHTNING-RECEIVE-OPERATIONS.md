# JARVIS Lightning Receive — live operational state

Verified: 2026-11-21

## What is already implemented in the production Gateway source

The Gateway has owner-authenticated receive-only routes:

- `GET /v1/lightning/status` reports whether `LNBITS_BASE_URL` and `LNBITS_INVOICE_KEY` are configured. It does not prove a wallet connection by itself.
- `POST /v1/lightning/invoices` creates an incoming BOLT-11 invoice through LNbits (`out: false`) and persists the payment hash, invoice, amount and memo in `jarvis_lightning_invoices`.
- `GET /v1/lightning/invoices/:paymentHash` checks the invoice with LNbits and marks it paid only after the provider reports a successful payment state.

Outgoing Lightning payments are not exposed by these routes.

## Live verification on 2026-11-21

- Gateway `/health`: HTTP 200; service healthy; database connected.
- Gateway `/v1/lightning/status` and invoice route: HTTP 403 without owner authentication. This is an access-control result, not proof of provider configuration.
- Railway production Gateway variable inventory was inspected. Neither `LNBITS_BASE_URL` nor `LNBITS_INVOICE_KEY` is present.
- The receive-only NWC adapter in PR #180 is source-only, unmerged and not wired into production. No `JARVIS_NWC_URL` is configured.
- The public Alby Lightning Address callback was previously tested and returned the recipient-wallet-configuration error; it did not produce an invoice.
- No BOLT-11 invoice was created and no Lightning payment or BTC receipt has been verified in this run.

## Exact activation requirement

To activate the existing production route, configure on the Railway **Gateway** service:

1. `LNBITS_BASE_URL`: the HTTPS base URL of a real LNbits wallet instance.
2. `LNBITS_INVOICE_KEY`: that wallet's invoice-only API key, not its admin key.

Keep both values in Railway's secret manager only. Do not commit them, expose them to the PWA, print them in logs, or paste them into chat. Do not grant an outgoing-payment/admin key.

After configuration and redeploy, verify in order:

1. Owner-authenticated `GET /v1/lightning/status` reports `configured: true`.
2. Owner-authenticated `POST /v1/lightning/invoices` creates a real BOLT-11 invoice and stores it in the ledger.
3. Pay that invoice from a separate Lightning wallet.
4. Poll `GET /v1/lightning/invoices/:paymentHash` until provider-confirmed `status: paid`.
5. Confirm the ledger row and audit event. Only then record the amount as received BTC.

An invoice in pending state is not revenue. A configured variable name, a successful deployment, a unit test, or a public Bitcoin address is not proof of receipt.

## Safety invariant

JARVIS may create and reconcile incoming invoices only. No outgoing payment, key custody, seed phrase handling, or wallet-admin permission is part of this integration.
