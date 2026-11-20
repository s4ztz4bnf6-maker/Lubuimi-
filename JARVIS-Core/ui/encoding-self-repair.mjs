/**
 * JARVIS UI self-repair helpers.
 * Repairs common UTF-8-as-Latin-1 mojibake without changing ordinary Unicode.
 * Public chrome uses the canonical JARVIS legal identity and UTF-8 text.
 */
const MOJIBAKE_MARKERS = /(?:Ã[\u0080-\u00BF]|Â[\u0080-\u00BF]|â€|ðŸ|Ãƒ|Ã‚)/u;

function mojibakeScore(value) {
  return (value.match(/(?:Ã|Â|â€|ðŸ|Ãƒ|Ã‚|�)/gu) || []).length;
}

function latin1RoundTrip(value) {
  for (const character of value) {
    if (character.codePointAt(0) > 0xff) return null;
  }
  const bytes = Uint8Array.from([...value], (character) => character.codePointAt(0));
  return new TextDecoder("utf-8").decode(bytes);
}

export function repairMojibake(value) {
  if (typeof value !== "string" || !MOJIBAKE_MARKERS.test(value)) return value;
  let current = value;
  for (let pass = 0; pass < 2; pass += 1) {
    const candidate = latin1RoundTrip(current);
    if (candidate === null || mojibakeScore(candidate) >= mojibakeScore(current)) break;
    current = candidate;
    if (!MOJIBAKE_MARKERS.test(current)) break;
  }
  return current;
}

export function repairVisibleText(value) {
  return repairMojibake(value);
}

export const JARVIS_PUBLIC_BRAND_LINE = "JARVIS";
export const JARVIS_PUBLIC_LEGAL_NAME = "JARVIS AI AUTONOMOUS HOLDINGS LLC";
export const JARVIS_PUBLIC_SHORT_NAME = "JARVIS AI LLC";
export const JARVIS_PUBLIC_REGISTRATION_LINE = "RMI-REGISTRIERUNG 968412";
export const JARVIS_PUBLIC_STATUS_LINE = "● CONNECTING";
export const JARVIS_LOGIN_COPY = Object.freeze({
  heading: "Willkommen zurück.",
  instruction: "Melde dich mit deinem persönlichen Zugangscode an.",
});

export function utf8ContentType(mediaType = "text/html") {
  const allowed = new Set(["text/html", "application/json", "text/plain", "application/javascript"]);
  if (!allowed.has(mediaType)) throw new TypeError("Unsupported media type");
  return `${mediaType}; charset=utf-8`;
}

export function enforceHtmlUtf8(html) {
  if (typeof html !== "string") throw new TypeError("html must be a string");
  const charset = /<meta\s+[^>]*charset\s*=\s*["']?[^\s"'/>]+[^>]*>/i;
  if (charset.test(html)) return html.replace(charset, '<meta charset="UTF-8">');
  return html.replace(/<head\b[^>]*>/i, (head) => `${head}\n  <meta charset="UTF-8">`);
}

export function inspectEncoding(value) {
  const repaired = repairMojibake(value);
  return Object.freeze({
    ok: repaired === value,
    detectedMojibake: repaired !== value,
    repairedText: repaired,
  });
}
