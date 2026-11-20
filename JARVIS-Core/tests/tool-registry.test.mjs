import test from "node:test";
import assert from "node:assert/strict";
import { createToolRegistry } from "../agents/tool-registry.mjs";
test("registry requires explicit permission and bounds invocations", async () => {
  const r = createToolRegistry({ maxCalls: 1 });
  r.register({ name: "read.status", description: "Read status", handler: async () => "ok" });
  r.register({ name: "external.sms", description: "send SMS", level: "external", handler: async () => "sent" });
  assert.equal(await r.invoke("read.status", {}, { permittedLevels: ["read"] }), "ok");
  await assert.rejects(r.invoke("external.sms", {}, { permittedLevels: ["read"] }), /permission denied/);
  await assert.rejects(r.invoke("read.status", {}, { permittedLevels: ["read"] }), /limit/);
});
test("registry rejects invalid and duplicate tools", () => {
  const r = createToolRegistry();
  assert.throws(() => r.register({ name: "BAD NAME", handler: () => 1 }), /invalid/);
  r.register({ name: "valid", handler: () => 1 });
  assert.throws(() => r.register({ name: "valid", handler: () => 2 }), /already/);
});
