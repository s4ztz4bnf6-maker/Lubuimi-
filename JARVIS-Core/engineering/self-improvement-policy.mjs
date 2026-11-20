/** Policy gate for JARVIS self-improvement proposals.
 * Allows reproducible, sandboxed source/test work and PR creation.
 * Never authorizes secrets, production deploys, external side effects, or merging.
 */
const forbidden = [
  /secret|credential|token|private.?key|password/i,
  /production.?deploy|deploy.?prod|merge.?pull.?request/i,
  /payment|transfer|withdraw|send.?money/i,
  /delete.?data|wipe|destroy/i,
  /disable.?security|bypass.?auth/i
];

export function evaluateImprovementProposal(proposal = {}) {
  const checks = {
    hasDescription: typeof proposal.description === "string" && proposal.description.trim().length >= 12,
    hasTests: Array.isArray(proposal.tests) && proposal.tests.length > 0,
    sandboxed: proposal.sandboxed === true,
    boundedDiff: Number.isInteger(proposal.changedLines) && proposal.changedLines >= 0 && proposal.changedLines <= 500,
    noForbiddenScope: !forbidden.some((pattern) => pattern.test(
      [proposal.description, ...(proposal.files ?? [])].filter(Boolean).join(" ")
    )),
    noLiveSideEffects: proposal.liveSideEffects !== true,
  };
  const approvedForDraftPR = Object.values(checks).every(Boolean);
  return {
    approvedForDraftPR,
    checks,
    requiresHumanApproval: true,
    allowedActions: approvedForDraftPR ? ["create_branch", "commit_source", "run_tests", "open_draft_pr"] : [],
    deniedActions: ["merge", "production_deploy", "secrets_write", "external_transaction", "outbound_communications"],
  };
}
