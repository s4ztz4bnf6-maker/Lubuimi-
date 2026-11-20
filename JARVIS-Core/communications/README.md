# JARVIS Communications — SMS & Voice (Twilio adapter)

This folder contains a provider adapter for outbound SMS, outbound voice calls with spoken text, basic inbound voice/SMS TwiML, and Twilio webhook-signature validation. It is **not yet wired into the production Gateway/Companion**.

## Capabilities
- Send SMS using the configured Twilio number.
- Initiate an outbound call that reads a supplied message aloud (TwiML `<Say>`).
- Return TwiML for inbound voice greetings and speech collection.
- Validate webhook signatures before accepting webhook payloads.

## Required configuration (server-side only)
- `TWILIO_ACCOUNT_SID`
- `TWILIO_AUTH_TOKEN`
- `TWILIO_PHONE_NUMBER` — Twilio-owned number with SMS and voice capability, in E.164 form.

No secrets belong in the browser, app bundle, Git, or logs. Configure the public webhook URLs in Twilio Console to point at a TLS-protected backend. The backend must validate the `X-Twilio-Signature` on each request using the exact externally visible URL and form parameters.

## Integration and release gates
1. Add authenticated Gateway routes for SMS send and call initiation. Never expose provider credentials to the client.
2. Restrict the initial allowlist of destination numbers; require explicit user approval for every outbound SMS/call until abuse protections are audited.
3. Implement Twilio webhooks (incoming SMS, inbound voice, speech-result endpoint) with signature validation, replay/rate limits, request size limits and redacted logs.
4. Use a realtime speech pipeline (speech-to-text → model → text-to-speech → streamed audio) for natural conversation. The current adapter only reads fixed text and is **not** a full live conversational telephone agent.
5. Provide identity disclosure: JARVIS is an AI assistant; callers must not be led to believe they are speaking to a human. Respect consent, do-not-call, applicable telecom law and provider policies.
6. Add monitoring, usage caps and emergency disable switch before enabling live traffic.

## Status
Source adapter only. No Twilio account/number, credentials, verified webhook, live phone call, or SMS has been configured or tested. No spending has been approved or performed.
