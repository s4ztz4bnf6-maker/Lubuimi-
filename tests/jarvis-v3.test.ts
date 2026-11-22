import { test, expect } from "bun:test";
import { IndependentAgentRegistry } from "../JARVIS-Core/agents/independent-agent-registry";
import { assessAgentPayload } from "../JARVIS-Core/security/defensive-monitor";
import { reconcilePayment } from "../JARVIS-Core/revenue/payment-reconciliation";

test("agents are disabled by default and require human approval", () => {
  const registry = new IndependentAgentRegistry();
  const agent = registry.register("reviewer", ["read:status"]);
  expect(registry.can(agent.id, "read:status")).toBe(false);
  expect(() => registry.enable(agent.id, false)).toThrow();
  expect(registry.enable(agent.id, true)).toBe(true);
  expect(registry.can(agent.id, "read:status")).toBe(true);
  expect(registry.can(agent.id, "write:reports")).toBe(false);
  registry.revoke(agent.id);
  expect(registry.can(agent.id, "read:status")).toBe(false);
});
test("payload rejects invalid shape and oversized data", () => {
  expect(assessAgentPayload(null).accepted).toBe(false);
  expect(assessAgentPayload({ agentId: "bad", type: "ping" }).accepted).toBe(false);
  expect(assessAgentPayload({ agentId: "12345678-1234-1234-1234-123456789abc", type: "ping", data: "x".repeat(100) }, 30).accepted).toBe(false);
});
test("settlement needs provider verification and confirmed evidence", () => {
  const base = { orderId: "order1", provider: "btc" as const, externalPaymentId: "tx1" };
  expect(reconcilePayment(base)).toBe("unverified");
  expect(reconcilePayment({ ...base, providerVerified: true })).toBe("pending");
  expect(reconcilePayment({ ...base, providerVerified: true, settlementConfirmed: true })).toBe("settled");
});
