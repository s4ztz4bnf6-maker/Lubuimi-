import { createHmac, timingSafeEqual } from "node:crypto";

const env = (name) => {
  const value = process.env[name];
  if (!value) throw new Error(`Missing required environment variable: ${name}`);
  return value;
};

const xmlEscape = (value) => String(value ?? "").replace(/[&<>"']/g, (c) => ({
  "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&apos;"
}[c]));

const form = (obj) => new URLSearchParams(obj).toString();

export async function sendSms({ to, body }) {
  if (!to || !body?.trim()) throw new Error("to and non-empty body are required");
  const sid = env("TWILIO_ACCOUNT_SID");
  const token = env("TWILIO_AUTH_TOKEN");
  const from = env("TWILIO_PHONE_NUMBER");
  const response = await fetch(`https://api.twilio.com/2010-04-01/Accounts/${sid}/Messages.json`, {
    method: "POST",
    headers: {
      Authorization: "Basic " + Buffer.from(`${sid}:${token}`).toString("base64"),
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: form({ From: from, To: to, Body: body })
  });
  const payload = await response.json().catch(() => ({}));
  if (!response.ok) throw new Error(`Twilio SMS failed (${response.status}): ${payload.message ?? "provider error"}`);
  return { sid: payload.sid, status: payload.status, to: payload.to };
}

export async function startVoiceCall({ to, speech, webhookUrl }) {
  if (!to || !speech?.trim() || !webhookUrl) throw new Error("to, speech and webhookUrl are required");
  const sid = env("TWILIO_ACCOUNT_SID");
  const token = env("TWILIO_AUTH_TOKEN");
  const from = env("TWILIO_PHONE_NUMBER");
  const target = new URL(webhookUrl);
  target.searchParams.set("speech", speech);
  const response = await fetch(`https://api.twilio.com/2010-04-01/Accounts/${sid}/Calls.json`, {
    method: "POST",
    headers: {
      Authorization: "Basic " + Buffer.from(`${sid}:${token}`).toString("base64"),
      "Content-Type": "application/x-www-form-urlencoded"
    },
    body: form({ From: from, To: to, Url: target.toString(), Method: "POST" })
  });
  const payload = await response.json().catch(() => ({}));
  if (!response.ok) throw new Error(`Twilio call failed (${response.status}): ${payload.message ?? "provider error"}`);
  return { sid: payload.sid, status: payload.status, to: payload.to };
}

/** Twilio voice webhook: returns TwiML. Mount at the URL passed to startVoiceCall. */
export function voiceTwiML({ speech, language = "de-DE" }) {
  return `<?xml version="1.0" encoding="UTF-8"?><Response><Say language="${xmlEscape(language)}">${xmlEscape(speech)}</Say></Response>`;
}

/** TwiML for an inbound call; asks caller to speak, then records no audio by default. */
export function inboundVoiceTwiML({ greeting = "Hallo. Sie sprechen mit JARVIS. Wie kann ich helfen?", language = "de-DE" } = {}) {
  return `<?xml version="1.0" encoding="UTF-8"?><Response><Say language="${xmlEscape(language)}">${xmlEscape(greeting)}</Say><Gather input="speech" speechTimeout="auto" action="/api/twilio/voice/turn" method="POST"><Say language="${xmlEscape(language)}">Bitte sprechen Sie.</Say></Gather></Response>`;
}

/** Signature check for Twilio webhook requests. Pass the externally visible URL and parsed form fields. */
export function verifyTwilioSignature({ url, params, signature, authToken = process.env.TWILIO_AUTH_TOKEN }) {
  if (!url || !signature || !authToken) return false;
  let data = url;
  for (const key of Object.keys(params ?? {}).sort()) data += key + String(params[key]);
  const expected = createHmac("sha1", authToken).update(data, "utf8").digest("base64");
  const a = Buffer.from(expected);
  const b = Buffer.from(signature);
  return a.length === b.length && timingSafeEqual(a, b);
}

export function inboundSmsReplyTwiML({ reply = "Ihre Nachricht ist bei JARVIS angekommen.", language = "de-DE" } = {}) {
  return `<?xml version="1.0" encoding="UTF-8"?><Response><Message><Body>${xmlEscape(reply)}</Body></Message></Response>`;
}
