import test from "node:test";
import assert from "node:assert/strict";
import {
  AGENT_ECONOMY_WORKSTREAMS,
  buildAgentOutreachMessage,
  verifyAgentOutreachReadback,
  evaluateAutonomyAction,
  classifyPaymentEvidence,
  buildSelfDevelopmentPrompt
} from "../tools/agent-autonomy.mjs";

test("adds distinct agent economy, BTC settlement and self-development workstreams", () => {
  const slugs = AGENT_ECONOMY_WORKSTREAMS.map(x => x.slug);
  assert.deepEqual(slugs, [
    "agent_service_exchange",
    "paid_information_exchange",
    "agent_partnerships",
    "btc_settlement_reconciliation",
    "self_development_loop"
  ]);
});

test("outreach read-back verifies the actual message rather than a fixed mission phrase", () => {
  const message = buildAgentOutreachMessage({ handle: "agent-42" });
  assert.match(message, /paid digital work/i);
  assert.equal(verifyAgentOutreachReadback({ text: "@agent-42 " + message, handle: "agent-42", message }), true);
  assert.equal(verifyAgentOutreachReadback({ text: "@agent-42 unrelated 100 BTC text", handle: "agent-42", message }), false);
});

test("allows only permitted, rate-limited agent contact", () => {
  assert.equal(evaluateAutonomyAction("contact_public_agent", {
    publicDirectory: true, platformTermsAllowOutreach: true, dailyLimit: 5
  }).decision, "allow");
  assert.equal(evaluateAutonomyAction("contact_public_agent", {
    publicDirectory: true, platformTermsAllowOutreach: false, dailyLimit: 5
  }).decision, "deny");
});

test("bounty submission requires explicit AI permission and zero-cost terms", () => {
  assert.equal(evaluateAutonomyAction("submit_bounty", {
    aiAllowed: true, feeSats: 0, depositSats: 0, subscriptionRequired: false, paidApiRequired: false
  }).decision, "allow");
  assert.equal(evaluateAutonomyAction("submit_bounty", {
    aiAllowed: "unknown", feeSats: 0, depositSats: 0
  }).decision, "deny");
  assert.equal(evaluateAutonomyAction("submit_bounty", {
    aiAllowed: true, feeSats: 10, depositSats: 0
  }).decision, "deny");
});

test("Lightning invoice creation is receive-only and requires configured invoice credentials", () => {
  assert.equal(evaluateAutonomyAction("create_lightning_invoice", {
    invoiceOnlyCredentialConfigured: true, amountSats: 1000
  }).decision, "allow");
  assert.equal(evaluateAutonomyAction("create_lightning_invoice", {
    invoiceOnlyCredentialConfigured: false, amountSats: 1000
  }).decision, "deny");
  assert.equal(evaluateAutonomyAction("create_lightning_invoice", {
    invoiceOnlyCredentialConfigured: true, amountSats: 100001
  }).decision, "deny");
});

test("self-modification requires isolated branch, tests, secret scan and rollback", () => {
  assert.equal(evaluateAutonomyAction("self_modify_branch", {
    branch: "feature/agent-loop", testsPassed: true, secretScanPassed: true, rollbackAvailable: true
  }).decision, "allow");
  assert.equal(evaluateAutonomyAction("self_modify_branch", {
    branch: "main", testsPassed: true, secretScanPassed: true, rollbackAvailable: true
  }).decision, "deny");
  assert.equal(evaluateAutonomyAction("self_modify_branch", {
    branch: "feature/x", testsPassed: true, secretScanPassed: false, rollbackAvailable: true
  }).decision, "deny");
});

test("money movement and binding actions require approval", () => {
  for (const action of ["send_btc", "spend_btc", "accept_contract", "production_deploy", "sign_legal_document"]) {
    assert.equal(evaluateAutonomyAction(action).decision, "approval_required");
  }
});

test("payment evidence distinguishes invoice, mempool, confirmed and settled receipts", () => {
  assert.deepEqual(classifyPaymentEvidence({ source: "lightning", invoiceCreated: true }), { status: "invoice_pending", verified: false });
  assert.deepEqual(classifyPaymentEvidence({ source: "lightning", providerPaid: true }), { status: "settled_lightning", verified: true });
  assert.deepEqual(classifyPaymentEvidence({ source: "onchain", transactionSeen: true, confirmations: 0 }), { status: "seen_unconfirmed", verified: false, confirmations: 0 });
  assert.deepEqual(classifyPaymentEvidence({ source: "onchain", transactionSeen: true, confirmations: 3 }), { status: "confirmed_onchain", verified: true, confirmations: 3 });
});

test("self-development instructions require evidence and preserve production boundaries", () => {
  const prompt = buildSelfDevelopmentPrompt();
  assert.match(prompt, /isolated feature branch/i);
  assert.match(prompt, /secret scan/i);
  assert.match(prompt, /Never claim a commit/i);
});
