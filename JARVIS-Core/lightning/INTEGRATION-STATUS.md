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

## Bitcoin address verification — 2026-11-20

- The newer address previously placed in Railway configuration was rejected as invalid by mempool.space, Blockstream, and Blockchain.com. It must not be used.
- The prior configured mainnet address passed mempool.space validation, but its confirmed and unconfirmed transaction counts were both zero at the time of checking.
- Railway BTC_RECEIVE_ADDRESS was restored to that prior valid address on both the autonomous-worker and Companion services. The worker deployment completed successfully; the Companion's previous successful build was redeployed and its public /health endpoint returned HTTP 200, version 2.0.0.
- Address validity is not proof of wallet-key ownership. No incoming BTC transaction was observed. No outgoing transaction was made.
- The Companion API source reads jarvis_wallet_watch_addresses and jarvis_wallet_transactions but contains no INSERT/watcher implementation for those tables. The visible wallet summary is therefore not evidence of an active blockchain monitor.

## Public Companion inspection — 2026-11-20

- Public login screen currently displays a registration disclaimer ending in "nicht verifiziert".
- German text is rendered with UTF-8 mojibake (for example "zurÃ¼ck" and "persÃ¶nlichen"), indicating a charset/encoding problem.
- /health is public and returned HTTP 200. /api/lightning/status and /api/wallet returned HTTP 401 without owner login.
- The deployed Companion function source available through Railway contains API routes but no HTML/login-screen template or charset header. Do not change the live UI blindly; locate the actual frontend/template source first.
- The new UI wording and encoding defects remain open; no claim of repair is made.

## Release gates

- Confirm an existing persistent Linux host or select an existing infrastructure workspace explicitly.
- Install/start Alby Hub once, back up recovery material offline, and verify node connectivity.
- Link the Alby Lightning Address to the Hub and verify LNURL invoice creation.
- Create an Alby Hub NWC app with only make_invoice, lookup_invoice, get_balance, and list_transactions.
- Store the NWC URL only as a backend secret.
- Integrate the adapter into Gateway, persist invoices and settled incoming transactions, and expose only owner-authenticated PWA endpoints.
- Implement a genuine on-chain watcher or a supported wallet connector before claiming BTC receipt monitoring.
- Test with a small user-authorized incoming payment; never send an outgoing payment.
- Locate the actual Companion frontend/template source, add an explicit UTF-8 response charset and UTF-8 document declaration, remove the public "nicht verifiziert" phrase from the visible brand line, and verify all German strings after deployment.
- Keep production unchanged until source-safe deployment and rollback are demonstrated.

## App and licensing boundary

The existing iPad-facing JARVIS Companion is a web/PWA service, not a Java/Android application. Its production domain is the Railway Companion domain above. The iPad can connect through Safari/PWA; an Android APK would not run on the user's iPad. The app should call the Companion API, which in turn calls the Gateway. NWC credentials must never enter the client app.

The new source is saved on an isolated GitHub branch. Existing AGPL, proprietary, commercial, and third-party notices in the repository remain unchanged. The Alby JS SDK is MIT-licensed upstream. No repository-wide relicensing or third-party licence change is made here.
