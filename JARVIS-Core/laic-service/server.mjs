import http from "node:http";
import { getLAICIdentitySummary, laicProfile } from "../identity/laic-profile.mjs";
import { verifyJarvisEntity } from "../identity/registry-verifier.mjs";

const port = Number(process.env.PORT || 10000);
const startedAt = new Date().toISOString();

function send(res, status, body) {
  const payload = JSON.stringify(body, null, 2);
  res.writeHead(status, {
    "content-type": "application/json; charset=utf-8",
    "cache-control": "no-store",
    "x-content-type-options": "nosniff",
    "referrer-policy": "no-referrer",
    "content-length": Buffer.byteLength(payload),
  });
  res.end(payload);
}

const server = http.createServer((req, res) => {
  if (req.method !== "GET") return send(res, 405, { error: "method_not_allowed" });
  const path = new URL(req.url || "/", "http://localhost").pathname;
  if (path === "/healthz") {
    return send(res, 200, { ok: true, service: "JARVIS LAIC public identity endpoint", startedAt });
  }
  if (path === "/v1/verify") {
    return verifyJarvisEntity().then((result) => send(res, 200, result)).catch((error) => send(res, 502, { error: "verification_failed", detail: String(error?.message || error) }));
  }
  if (path === "/v1/identity") {
    return send(res, 200, {
      ...getLAICIdentitySummary(),
      legalPersonhood: "The LLC may be a legal person under its governing law; the AI system itself is not thereby a separate legal person.",
      registrationEvidence: laicProfile.legalEntity.registrationEvidence,
      sourcePolicy: "Public-safe profile only; no secrets or production configuration.",
    });
  }
  if (path === "/") {
    return send(res, 200, {
      service: "JARVIS LAIC",
      status: "running",
      endpoints: ["/healthz", "/v1/identity", "/v1/verify"],
      note: "Public identity/status service. Not a legal registry or proof of incorporation.",
    });
  }
  return send(res, 404, { error: "not_found" });
});

server.listen(port, "0.0.0.0", () => {
  console.log(JSON.stringify({ event: "laic_service_started", port, startedAt }));
});
