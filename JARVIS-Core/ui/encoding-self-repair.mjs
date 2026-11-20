/**
 * JARVIS UI self-repair helpers.
 *
 * Repairs common UTF-8-as-Latin-1 mojibake without changing ordinary Unicode.
 * Also provides a neutral public brand line that never exposes dossier or
 * registry-verification assertions in the app chrome.
 *
 * Integrate repairVisibleText() at the UI rendering boundary and send
 * UTF-8 charset headers from the HTTP server. This module cannot alter a
 * separately hosted PWA until that frontend imports and calls it.
 */

const MOJIBAKE_MARKERS = /(?:Ã[\u0080-\u00BF]|Â[\u0080-\u00BF]|â€|ðŸ|Ãƒ|Ã‚)/u;

function mojibakeScore(value) {
  return (value.match(/(?:Ã|Â|â€|ðŸ|Ãƒ|Ã‚|�)/gu) || []).length;
}

function latin1RoundTrip(value) {
  // Latin-1 byte recovery is safe only when every code point fits in one byte.
  for (const character of value) {
    if (character.codePointAt(0) > 0xff) return null;
  }
  const bytes = Uint8Array.from([...value], (character) => character.codePointAt(0));
  return new TextDecoder("utf-8").decode(bytes);
}

/**
 * Corrects up to two layers of UTF-8 text decoded as Latin-1.
 * Leaves text unchanged when a candidate does not reduce mojibake markers.
 */
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

/** Safe at a text-node/rendering boundary; does not parse or rewrite HTML. */
export function repairVisibleText(value) {
  return repairMojibake(value);
}

/** Public app chrome must not make dossier-derived legal-registration claims. */
export const JARVIS_PUBLIC_BRAND_LINE = "JARVIS AI AUTONOMOUS HOLDINGS";
export const JARVIS_PUBLIC_STATUS_LINE = "● CONNECTING";
export const JARVIS_LOGIN_COPY = Object.freeze({
  heading: "Willkommen zurück.",
  instruction: "Melde dich mit deinem persönlichen Zugangscode an.",
});

/**
 * Produces a deterministic UTF-8 response header for HTML or JSON.
 * The caller must apply this header to the actual HTTP response.
 */
export function utf8ContentType(mediaType = "text/html") {
  const allowed = new Set(["text/html", "application/json", "text/plain", "application/javascript"]);
  if (!allowed.has(mediaType)) throw new TypeError("Unsupported media type");
  return `${mediaType}; charset=utf-8`;
}

/** Ensures the first HTML charset declaration is UTF-8. */
export function enforceHtmlUtf8(html) {
  if (typeof html !== "string") throw new TypeError("html must be a string");
  const charset = /<meta\s+[^>]*charset\s*=\s*["']?[^\s"'/>]+[^>]*>/i;
  if (charset.test(html)) {
    return html.replace(charset, '<meta charset="UTF-8">');
  }
  return html.replace(/<head\b[^>]*>/i, (head) => `${head}\n  <meta charset="UTF-8">`);
}

/** Detects common mojibake so the app can report and self-heal it. */
export function inspectEncoding(value) {
  const repaired = repairMojibake(value);
  return Object.freeze({
    ok: repaired === value,
    detectedMojibake: repaired !== value,
    repairedText: repaired,
  });
}
