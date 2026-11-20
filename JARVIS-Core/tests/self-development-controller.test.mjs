import test from "node:test";
import assert from "node:assert/strict";
import {
  authorizeDevelopmentAction,
  chooseNextSelfDevelopmentStep,
  labelLearningRecord,
} from "../tools/self-development-controller.mjs";

test("self-development pauses rather than growing an overloaded queue", () => {
  assert.deepEqual(chooseNextSelfDevelopmentStep({ activeTasks: 25 }), {
    allowed: false, reason: "global_queue_limit_reached",
  });
});

test("only one self-development task may be active", () => {
  assert.equal(chooseNextSelfDevelopmentStep({ activeSelfDevelopmentTasks: 1 }).allowed, false);
});

test("duplicate tasks and repeated failures stop scheduling", () => {
  assert.equal(chooseNextSelfDevelopmentStep({ duplicateOpenTask: true }).reason, "duplicate_open_task");
  assert.equal(chooseNextSelfDevelopmentStep({ failedRuns: 3 }).reason, "circuit_breaker_after_repeated_failures");
});

test("isolated feature branches are allowed; protected branches are not", () => {
  assert.equal(authorizeDevelopmentAction({ action: "create_branch", branch: "jarvis/patch-1" }).allowed, true);
  assert.equal(authorizeDevelopmentAction({ action: "create_branch", branch: "main" }).allowed, false);
});

test("patch requires tests, secret scan, rollback and bounded safe paths", () => {
  const base = {
    action: "commit_patch", branch: "jarvis/patch-1",
    files: ["JARVIS-Core/tools/example.mjs"], patchBytes: 100,
    testsPassed: true, secretScanPassed: true, rollbackAvailable: true,
  };
  assert.equal(authorizeDevelopmentAction(base).allowed, true);
  assert.equal(authorizeDevelopmentAction({ ...base, testsPassed: false }).allowed, false);
  assert.equal(authorizeDevelopmentAction({ ...base, files: [".env"] }).allowed, false);
  assert.equal(authorizeDevelopmentAction({ ...base, files: ["../../outside"] }).allowed, false);
});

test("pull request requires reviewable external evidence", () => {
  const base = {
    action: "open_pull_request", branch: "jarvis/patch-1",
    files: ["JARVIS-Core/tools/example.mjs"], patchBytes: 100,
    testsPassed: true, secretScanPassed: true, rollbackAvailable: true,
  };
  assert.equal(authorizeDevelopmentAction(base).reason, "reviewable_evidence_required");
  assert.equal(authorizeDevelopmentAction({ ...base, externalEvidence: true }).allowed, true);
});

test("merge, deployment, money and legal acts are never autonomous", () => {
  for (const action of ["merge", "production_deploy", "spend", "transfer_funds", "sign_contract", "file_legal_document"]) {
    assert.equal(authorizeDevelopmentAction({ action }).allowed, false);
  }
});

test("learning cannot be marked verified without dated source evidence", () => {
  assert.equal(labelLearningRecord({ confidence: "verified" }).confidence, "unverified");
  assert.equal(labelLearningRecord({
    confidence: "verified", observedAt: "2026-11-20T12:00:00Z",
    sources: ["https://example.org/primary-source"],
  }).confidence, "verified");
});
