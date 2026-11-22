import { describe, expect, test } from "bun:test";
import { classifyEvidence } from "../src/revenue/revenue-evidence";
describe("revenue evidence", () => {
  test("internal work is not a payable claim", () => {
    expect(classifyEvidence({ taskId: "1475", agentId: "worker" })).toBe("internal_completed");
  });
  test("a payout needs acceptance, compensation and amount", () => {
    expect(classifyEvidence({ taskId: "1", agentId: "a", acceptanceEvidenceUrl: "https://example.org/accept", compensationEvidenceUrl: "https://example.org/contract", amount: "10", currency: "USD" })).toBe("payout_pending");
  });
  test("paid requires payment evidence", () => {
    expect(classifyEvidence({ taskId: "1", agentId: "a", paymentEvidenceId: "bank:tx-1" })).toBe("paid");
  });
});
