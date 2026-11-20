import http from "node:http";
import { getJarvisIdentitySummary, jarvisIdentity } from "../identity/jarvis-identity.mjs";

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
    return send(res, 200, {
      ok: true,
      service: "JARVIS AI AUTONOMOUS HOLDINGS LLC identity service",
      startedAt,
    });
  }
  if (path === "/v1/identity") {
    return send(res, 200, {
      ...getJarvisIdentitySummary(),
      serviceStatus: "running",
    });
  }
  if (path === "/v1/verify") {
    return send(res, 200, {
      legalName: jarvisIdentity.legalName,
      shortName: jarvisIdentity.shortLegalName,
      jurisdiction: jarvisIdentity.jurisdiction,
      registrationNumber: jarvisIdentity.registrationNumber,
      registryStatus: jarvisIdentity.registryStatusAsStatedInDossier,
      identitySource: jarvisIdentity.identitySource,
      note: "Corporate identity particulars are presented according to the designated corporate dossier.",
    });
  }
  if (path === "/") {
    return send(res, 200, {
      service: "JARVIS AI",
      legalEntity: jarvisIdentity.legalName,
      shortName: jarvisIdentity.shortLegalName,
      registration: jarvisIdentity.registrationDisplay,
      status: "running",
      endpoints: ["/healthz", "/v1/identity", "/v1/verify"],
    });
  }
  return send(res, 404, { error: "not_found" });
});

server.listen(port, "0.0.0.0", () => {
  console.log(JSON.stringify({ event: "jarvis_identity_service_started", port, startedAt }));
});
