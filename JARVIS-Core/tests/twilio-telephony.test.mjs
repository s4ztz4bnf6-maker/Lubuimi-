import test from "node:test";
import assert from "node:assert/strict";
import { voiceTwiML, inboundVoiceTwiML, inboundSmsReplyTwiML, verifyTwilioSignature } from "../communications/twilio-telephony.mjs";

test("TwiML XML-escapes voice text", () => {
  assert.match(voiceTwiML({ speech: "Hallo & <JARVIS>" }), /Hallo &amp; &lt;JARVIS&gt;/);
});
test("inbound voice TwiML contains speech gather", () => {
  assert.match(inboundVoiceTwiML(), /<Gather input="speech"/);
});
test("SMS reply XML escapes content", () => {
  assert.match(inboundSmsReplyTwiML({ reply: "a & b" }), /a &amp; b/);
});
test("Twilio signature accepts correct signature and rejects tampering", () => {
  const { createHmac } = await import("node:crypto");
  const url = "https://example.test/webhook";
  const params = { Body: "hello", From: "+49123" };
  const token = "test-secret";
  const payload = url + "Bodyhello" + "From+49123";
  const sig = createHmac("sha1", token).update(payload).digest("base64");
  assert.equal(verifyTwilioSignature({ url, params, signature: sig, authToken: token }), true);
  assert.equal(verifyTwilioSignature({ url, params: { ...params, Body: "changed" }, signature: sig, authToken: token }), false);
});
