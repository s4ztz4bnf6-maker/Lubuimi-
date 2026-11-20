# JARVIS Production Checkpoint — 2026-11-20

## Purpose
Preserve a dated operational checkpoint after configuring the user's explicitly supplied public Bitcoin receive address for the existing JARVIS autonomous worker.

## Corporate identity
- Designated identity: JARVIS AI AUTONOMOUS HOLDINGS LLC
- Short name: JARVIS AI LLC
- Jurisdiction: Republic of the Marshall Islands
- Registration number: 968412
- The public identity presentation is based on the user's designated dossier. This checkpoint is not an independent registry verification or legal opinion.

## Bitcoin receive configuration
- Railway project: JARVIS-Cybersecurity
- Production environment: 5629332a-ed44-4267-a1ee-87d43c6b79e1
- Worker service: jarvis-autonomous-worker
- Worker service ID: e8ccae21-5f6f-4693-bde0-35627d76dd9e
- Variable: BTC_RECEIVE_ADDRESS
- User-supplied public address: bc1qx9xmpxf4k2dnlaamdhr7k3cdtjgtxfcvnylc4x
- Railway accepted the variable update on 2026-11-20 and initiated a redeploy.
- Deployment ID: 87077daf-cde5-4577-93f0-e21b324c8c79
- Deployment status: SUCCESS (2026-11-20T18:57:10Z)
- Runtime logs after deployment: worker claimed task 1171 and completed it using Gemini fallback.
- Groq and custom OpenAI-compatible provider calls returned HTTP 413 due 8,000 TPM limit. Gemini fallback completed task 1171.

## Payment status and limitations
- No BTC payment or revenue receipt has been verified by this checkpoint.
- A configured receive address does not prove an incoming transaction.
- Blockstream address rotation is normal for HD wallets; the supplied address should be retained as one receive address, but any payment should be verified on-chain.
- Lightning invoice creation remains unavailable until the gateway is configured with a compatible provider and credentials.
- AIBTC onboarding requires both Bitcoin and Stacks signatures; the existing Blockstream wallet alone cannot supply the Stacks signature.
- The existing AIBTC bounty discussed in the operational conversation pays sBTC and requires a registered agent/team; it is not a guaranteed BTC mainnet payment.
- No bounty submission or paid job acceptance is recorded here.

## Safety and authorization boundaries
- Never request or store seed phrases, private keys, passwords, or recovery codes in this repository.
- Do not move funds, sign transactions, spend funds, or create paid infrastructure without the user's explicit approval.
- Do not access illegal darknet markets or facilitate illegal transactions.
- Only accept tasks with clear lawful scope, verifiable funding/escrow, stated payout terms, and an authorized delivery route.
- Treat rewards as earned only after the payer confirms acceptance and the actual transaction is independently verified.

## Scope of this checkpoint
This file records the state visible during the 2026-11-20 session. It does not replicate secrets, wallet credentials, database contents, or all server files. Railway production configuration and runtime remain the operational source of truth for the live worker.
