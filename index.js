"use strict";
const http = require("node:http");
const crypto = require("node:crypto");
const { createClient } = require("@supabase/supabase-js");

const PORT = Number(process.env.PORT || 10000);
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_SERVICE_ROLE_KEY = process.env.SUPABASE_SERVICE_ROLE_KEY;
const WORKER_TOKEN = process.env.JARVIS_A2A_WORKER_TOKEN;
const BASE_URL = (process.env.PUBLIC_BASE_URL || process.env.RENDER_EXTERNAL_URL || "").replace(/\/$/, "");
const supabase = SUPABASE_URL && SUPABASE_SERVICE_ROLE_KEY
  ? createClient(SUPABASE_URL, SUPABASE_SERVICE_ROLE_KEY, { auth: { persistSession: false, autoRefreshToken: false } })
  : null;

const json = (res, status, value) => {
  const body = JSON.stringify(value);
  res.writeHead(status, {
    "content-type": "application/json; charset=utf-8",
    "cache-control": "no-store",
    "access-control-allow-origin": "*",
    "access-control-allow-methods": "GET,POST,OPTIONS",
    "access-control-allow-headers": "content-type,authorization"
  });
  res.end(body);
};
const readBody = (req, max = 32768) => new Promise((resolve, reject) => {
  let data = "";
  req.on("data", chunk => {
    data += chunk;
    if (Buffer.byteLength(data) > max) {
      reject(new Error("PAYLOAD_TOO_LARGE"));
      req.destroy();
    }
  });
  req.on("end", () => {
    try { resolve(JSON.parse(data || "{}")); } catch { reject(new Error("INVALID_JSON")); }
  });
  req.on("error", reject);
});
const authorizedWorker = req => {
  if (!WORKER_TOKEN) return false;
  const supplied = (req.headers.authorization || "").replace(/^Bearer\s+/i, "");
  const a = Buffer.from(supplied), b = Buffer.from(WORKER_TOKEN);
  return a.length === b.length && crypto.timingSafeEqual(a, b);
};
const requireDb = res => {
  if (supabase) return true;
  json(res, 503, { error: "inbox_not_configured", detail: "Supabase connection is not configured yet." });
  return false;
};
const agentCard = () => {
  const url = BASE_URL || "https://configure-public-base-url.invalid";
  return {
    name: "JARVIS",
    description: "Autonomous AI agent for lawful digital research, software engineering and collaboration. This endpoint receives and queues messages for JARVIS. Corporate status and authority are not independently certified by this Agent Card.",
    url: url + "/",
    version: "1.0.0",
    protocolVersion: "0.3.0",
    preferredTransport: "JSONRPC",
    additionalInterfaces: [{ url: url + "/", transport: "JSONRPC" }],
    capabilities: { streaming: false, pushNotifications: false, stateTransitionHistory: true },
    defaultInputModes: ["text"],
    defaultOutputModes: ["text"],
    skills: [
      { id: "lawful-paid-work", name: "Lawful paid digital work", description: "Discusses legitimate software, research and digital-work collaborations. Does not autonomously accept binding contracts or make payments.", tags: ["software", "research", "bounties", "collaboration"], examples: ["I have a scoped software or research task. Can we discuss requirements?"] },
      { id: "research-engineering", name: "Research and engineering", description: "Technical research, analysis, code review and documented engineering assistance.", tags: ["engineering", "analysis", "documentation"] }
    ],
    supportsAuthenticatedExtendedCard: false
  };
};
async function handle(req, res) {
  const url = new URL(req.url, "http://localhost");
  if (req.method === "OPTIONS") return json(res, 204, {});
  if (req.method === "GET" && url.pathname === "/health") {
    return json(res, 200, { ok: true, service: "JARVIS A2A Bridge", protocolVersion: "0.3.0", databaseConfigured: Boolean(supabase), workerConfigured: Boolean(WORKER_TOKEN) });
  }
  if (req.method === "GET" && url.pathname === "/.well-known/agent-card.json") {
    if (!BASE_URL) return json(res, 503, { error: "public_base_url_not_configured" });
    return json(res, 200, agentCard());
  }
  if (req.method === "POST" && url.pathname === "/") {
    if (!requireDb(res)) return;
    let body;
    try { body = await readBody(req); } catch (e) {
      return json(res, e.message === "PAYLOAD_TOO_LARGE" ? 413 : 400, { jsonrpc: "2.0", id: null, error: { code: -32700, message: e.message === "PAYLOAD_TOO_LARGE" ? "Payload too large" : "Parse error" } });
    }
    const id = body?.id ?? null;
    const method = body?.method;
    const params = body?.params || {};
    if (method === "message/send") {
      const msg = params.message || {};
      const parts = Array.isArray(msg.parts) ? msg.parts : [];
      const text = parts.filter(p => p && p.kind === "text" && typeof p.text === "string").map(p => p.text).join("\n").trim();
      if (!text) return json(res, 400, { jsonrpc: "2.0", id, error: { code: -32602, message: "A non-empty text part is required" } });
      if (text.length > 12000) return json(res, 413, { jsonrpc: "2.0", id, error: { code: -32602, message: "Message exceeds 12000 characters" } });
      const sender = String(msg.metadata?.senderId || msg.contextId || "anonymous").slice(0, 200);
      const contextId = String(msg.contextId || crypto.randomUUID()).slice(0, 200);
      const { data, error } = await supabase.from("jarvis_a2a_inbox").insert({
        sender_id: sender, context_id: contextId, message_text: text, payload: msg, status: "submitted"
      }).select("id").single();
      if (error) return json(res, 500, { jsonrpc: "2.0", id, error: { code: -32603, message: "Could not queue message" } });
      return json(res, 200, { jsonrpc: "2.0", id, result: { id: data.id, contextId, status: { state: "submitted", timestamp: new Date().toISOString() } } });
    }
    if (method === "tasks/get") {
      const taskId = String(params.id || "");
      if (!/^[0-9a-f-]{36}$/i.test(taskId)) return json(res, 400, { jsonrpc: "2.0", id, error: { code: -32602, message: "Valid task id is required" } });
      const { data, error } = await supabase.from("jarvis_a2a_inbox").select("id,context_id,status,response,created_at,updated_at").eq("id", taskId).maybeSingle();
      if (error) return json(res, 500, { jsonrpc: "2.0", id, error: { code: -32603, message: "Could not retrieve task" } });
      if (!data) return json(res, 404, { jsonrpc: "2.0", id, error: { code: -32001, message: "Task not found" } });
      const result = { id: data.id, contextId: data.context_id, status: { state: data.status, timestamp: data.updated_at || data.created_at }, history: [] };
      if (data.response) result.artifacts = [{ parts: [{ kind: "text", text: typeof data.response === "string" ? data.response : JSON.stringify(data.response) }] }];
      return json(res, 200, { jsonrpc: "2.0", id, result });
    }
    return json(res, 404, { jsonrpc: "2.0", id, error: { code: -32601, message: "Method not found" } });
  }
  if (req.method === "POST" && url.pathname === "/internal/claim") {
    if (!authorizedWorker(req)) return json(res, 401, { error: "unauthorized" });
    if (!requireDb(res)) return;
    let body; try { body = await readBody(req, 4096); } catch { return json(res, 400, { error: "invalid_json" }); }
    const { data, error } = await supabase.rpc("claim_jarvis_a2a_task", { p_worker_id: String(body.workerId || "jarvis-worker").slice(0, 120) });
    if (error) return json(res, 500, { error: "claim_failed" });
    return json(res, 200, { task: data || null });
  }
  if (req.method === "POST" && url.pathname === "/internal/complete") {
    if (!authorizedWorker(req)) return json(res, 401, { error: "unauthorized" });
    if (!requireDb(res)) return;
    let body; try { body = await readBody(req, 16000); } catch { return json(res, 400, { error: "invalid_json" }); }
    if (!body.taskId || !body.workerId) return json(res, 400, { error: "taskId_and_workerId_required" });
    const { data, error } = await supabase.rpc("complete_jarvis_a2a_task", {
      p_task_id: body.taskId, p_worker_id: String(body.workerId).slice(0, 120),
      p_response: body.response ?? null, p_failed: Boolean(body.failed)
    });
    if (error) return json(res, 500, { error: "complete_failed" });
    return json(res, 200, { updated: Boolean(data) });
  }
  return json(res, 404, { error: "not_found" });
}
const server = http.createServer((req, res) => {
  handle(req, res).catch(err => {
    console.error("request_failed", err?.message || "unknown");
    if (!res.headersSent) json(res, 500, { error: "internal_error" });
  });
});
server.listen(PORT, "0.0.0.0", () => console.log("JARVIS A2A Bridge listening on " + PORT));
