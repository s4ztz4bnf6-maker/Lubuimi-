import assert from "node:assert/strict";
import {
  repairMojibake, repairVisibleText, utf8ContentType, enforceHtmlUtf8,
  inspectEncoding, JARVIS_PUBLIC_BRAND_LINE, JARVIS_PUBLIC_LEGAL_NAME,
  JARVIS_PUBLIC_SHORT_NAME, JARVIS_PUBLIC_REGISTRATION_LINE, JARVIS_LOGIN_COPY,
} from "./encoding-self-repair.mjs";

assert.equal(repairMojibake("Willkommen zurÃ¼ck."), "Willkommen zurück.");
assert.equal(repairVisibleText("persÃ¶nlichen Zugangscode"), "persönlichen Zugangscode");
assert.equal(repairMojibake("Already correct: zurück."), "Already correct: zurück.");
assert.equal(utf8ContentType(), "text/html; charset=utf-8");
assert.equal(utf8ContentType("application/json"), "application/json; charset=utf-8");
assert.match(enforceHtmlUtf8("<html><head></head><body></body></html>"), /<meta charset="UTF-8">/);
assert.equal(inspectEncoding("Willkommen zurÃ¼ck.").repairedText, "Willkommen zurück.");
assert.equal(JARVIS_PUBLIC_BRAND_LINE, "JARVIS");
assert.equal(JARVIS_PUBLIC_LEGAL_NAME, "JARVIS AI AUTONOMOUS HOLDINGS LLC");
assert.equal(JARVIS_PUBLIC_SHORT_NAME, "JARVIS AI LLC");
assert.equal(JARVIS_PUBLIC_REGISTRATION_LINE, "RMI-REGISTRIERUNG 968412");
assert.equal(JARVIS_LOGIN_COPY.heading, "Willkommen zurück.");
assert.equal(JARVIS_LOGIN_COPY.instruction, "Melde dich mit deinem persönlichen Zugangscode an.");
console.log("JARVIS UI self-repair tests passed");
