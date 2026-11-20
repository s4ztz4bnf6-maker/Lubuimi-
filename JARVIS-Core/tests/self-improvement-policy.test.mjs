import test from "node:test";
import assert from "node:assert/strict";
import { evaluateImprovementProposal } from "../engineering/self-improvement-policy.mjs";

test("accepts bounded sandbox proposal with tests for draft PR only", () => {
  const result = evaluateImprovementProposal({
    description: "Improve error handling for a parser with structured fallback",
    files: ["src/parser.mjs", "tests/parser.test.mjs"],
    tests: ["parser handles malformed input"],
    sandboxed: true,
    changedLines: 80,
    liveSideEffects: false
  });
  assert.equal(result.approvedForDraftPR, true);
  assert.deepEqual(result.allowedActions, ["create_branch", "commit_source", "run_tests", "open_draft_pr"]);
  assert.equal(result.requiresHumanApproval, true);
  assert.ok(result.deniedActions.includes("production_deploy"));
});

test("rejects proposal with no tests or unbounded diff", () => {
  const result = evaluateImprovementProposal({ description: "change parser", sandboxed: true, changedLines: 900 });
  assert.equal(result.approvedForDraftPR, false);
});

test("rejects secret/payment scope", () => {
  const result = evaluateImprovementProposal({
    description: "add wallet payment transfer",
    files: ["wallet.mjs"],
    tests: ["test"],
    sandboxed: true,
    changedLines: 12,
    liveSideEffects: false
  });
  assert.equal(result.approvedForDraftPR, false);
});
