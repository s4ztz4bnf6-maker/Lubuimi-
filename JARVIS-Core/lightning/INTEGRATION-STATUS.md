# JARVIS Lightning integration — release gates

Date: 2026-11-20

## Existing assets identified

- Alby Lightning Address: gracefloral53366@getalby.com (user-provided).
- Railway production Gateway: jarvis-gateway in project JARVIS-Cybersecurity.
- Railway production Companion/PWA: jarvis-companion-app, domain jarvis-companion-app-production.up.railway.app.
- Railway PostgreSQL is the existing persistence target.
- The Gateway already has owner-authenticated LNbits invoice routes and a jarvis_lightning_invoices ledger.
- A prior public A2A bridge and static edge service exist on Render; they are not Lightning nodes and do not supply persistent Lightning storage or inbound liquidity.
- JARVIS-Core is a separate development mirror on GitHub branch jarvis-core; it is not connected to Railway auto-deploy.

## New source saved in this branch

- lightning/nwc-receive.mjs — NWC receive adapter; no outgoing payment methods.
- lightning/package.json — pinned Alby SDK dependency.
- tests/nwc-receive.test.mjs — unit tests for msat conversion, invoice creation, settlement filtering and absence of outgoing methods.

## Live blockers — not to be misreported

1. Alby address resolution was tested earlier, but invoice callback returned the recipient wallet configuration error. No BOLT-11 invoice was produced.
2. No running Alby Hub node or persistent node host is verified.
3. No NWC connection URL has been created or stored in Railway secrets.
4. No receive-only app connection has been authorized in Alby Hub.
5. The Gateway's current production routes use LNbits variables, not this NWC adapter.
6. The Railway production app has not been changed by this branch.
7. The Render A2A bridge and static edge are not substitutes for an always-on Lightning node.
8. No incoming Lightning payment has been confirmed or credited.

## Release gates

- Confirm an existing persistent Linux host or select an existing infrastructure workspace explicitly.
- Install/start Alby Hub once, back up recovery material offline, and verify node connectivity.
- Link the Alby Lightning Address to the Hub and verify LNURL invoice creation.
- Create an Alby Hub NWC app with only make_invoice, lookup_invoice, get_balance, and list_transactions.
- Store the NWC URL only as a backend secret.
- Integrate the adapter into Gateway, persist invoices and settled incoming transactions, and expose only owner-authenticated PWA endpoints.
- Test with a small user-authorized incoming payment; never send an outgoing payment.
- Keep production unchanged until source-safe deployment and rollback are demonstrated.

## App and licensing boundary

The existing iPad-facing JARVIS Companion is a web/PWA service, not a Java/Android application. Its production domain is the Railway Companion domain above. The iPad can connect through Safari/PWA; an Android APK would not run on the user's iPad. The app should call the Companion API, which in turn calls the Gateway. NWC credentials must never enter the client app.

The new source is saved on an isolated GitHub branch. Existing AGPL, proprietary, commercial, and third-party notices in the repository remain unchanged. The Alby JS SDK is MIT-licensed upstream. No repository-wide relicensing or third-party licence change is made here.
