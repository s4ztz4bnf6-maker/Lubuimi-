# JARVIS Lightning receive adapter

Copyright © 2026 Ta-Yoshua Lubuimi. All rights reserved. This is a new JARVIS integration component; no third-party source is copied into it. The Alby SDK remains under its own MIT licence. No additional licence grant is made by this file.

## Purpose

This module connects the JARVIS backend to an existing Alby Hub wallet through Nostr Wallet Connect (NWC). It is a receive-focused adapter for invoice creation and settlement reconciliation.

It exposes only:
- status() — wallet information and balance;
- createInvoice() — create a BOLT-11 invoice;
- lookupInvoice() — inspect a known invoice;
- listIncomingSettlements() — list confirmed incoming Lightning settlements;
- close() — close the NWC client.

It deliberately does not expose payInvoice, payKeysend, or any other outgoing-payment operation. JARVIS code must never treat invoice creation as revenue. Only provider-confirmed settled transactions count as received Lightning payments.

## Runtime

- Node.js 22+ (or a compatible Bun runtime with native WebSocket support).
- Install this package's dependency with npm install or bun install.
- Set JARVIS_NWC_URL in the backend's secret/environment manager. Never commit the NWC connection string, print it, or place it in browser code.
- Connect an Alby Hub app with the smallest required permission set: make_invoice, lookup_invoice, get_balance, and list_transactions. Do not grant pay_invoice, pay_keysend, or broad wallet-management permissions.

The adapter passes invoice amounts in millisatoshis as required by NIP-47 (1 sat = 1000 msat). The public API should accept integer satoshis and enforce the 1–100,000 sat limit.

## Integration status

This is a source component only. It is not yet imported by the production Railway Gateway or Companion. A live Alby Hub node, a user-authorized NWC connection, secure secret configuration, database migration, UI integration, and end-to-end payment verification are still required. The existing @getalby/sdk package is an external dependency; see its upstream MIT licence and current API documentation.

## Security

- Never expose JARVIS_NWC_URL to the PWA, mobile client, logs, GitHub Actions output, or third-party agents.
- No private keys, recovery phrases, or wallet secrets belong in the repository.
- Treat pending, accepted, and unknown states as unpaid.
- A paid invoice must be independently reconciled with the payment hash and persisted in the existing JARVIS ledger.
