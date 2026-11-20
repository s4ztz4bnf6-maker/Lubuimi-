/**
 * JARVIS bounded self-development controller.
 *
 * This module is an executable policy gate, not an LLM or a production deployer.
 * It allows reversible work on isolated branches and blocks privileged actions.
 */

export const DEFAULT_LIMITS = Object.freeze({
  maxActiveTasks: 25,
  maxActiveSelfDevelopmentTasks: 1,
  maxPatchFiles: 8,
  maxPatchBytes: 40_000,
});

const PROTECTED_BRANCHES = new Set(["main", "master", "production", "release"]);
const BLOCKED_ACTIONS = new Set([
  "merge",
  "production_deploy",
  "spend",
  "transfer_funds",
  "sign_transaction",
  "create_paid_account",
  "sign_contract",
  "file_legal_document",
  "change_wallet_credentials",
]);

export function chooseNextSelfDevelopmentStep({
  activeTasks = 0,
  activeSelfDevelopmentTasks = 0,
  duplicateOpenTask = false,
  failedRuns = 0,
  limits = DEFAULT_LIMITS,
} = {}) {
  if (!Number.isInteger(activeTasks) || activeTasks < 0) {
    throw new TypeError("activeTasks must be a non-negative integer");
  }
  if (!Number.isInteger(activeSelfDevelopmentTasks) || activeSelfDevelopmentTasks < 0) {
    throw new TypeError("activeSelfDevelopmentTasks must be a non-negative integer");
  }
  if (duplicateOpenTask) return { allowed: false, reason: "duplicate_open_task" };
  if (activeSelfDevelopmentTasks >= limits.maxActiveSelfDevelopmentTasks) {
    return { allowed: false, reason: "self_development_slot_full" };
  }
  if (activeTasks >= limits.maxActiveTasks) {
    return { allowed: false, reason: "global_queue_limit_reached" };
  }
  if (failedRuns >= 3) {
    return { allowed: false, reason: "circuit_breaker_after_repeated_failures" };
  }
  return { allowed: true, reason: "queue_capacity_available" };
}

export function authorizeDevelopmentAction({
  action,
  branch,
  files = [],
  patchBytes = 0,
  testsPassed = false,
  secretScanPassed = false,
  rollbackAvailable = false,
  externalEvidence = false,
  limits = DEFAULT_LIMITS,
} = {}) {
  if (BLOCKED_ACTIONS.has(action)) {
    return { allowed: false, reason: "human_authorization_required" };
  }

  if (action === "read" || action === "research" || action === "write_learning_memory") {
    return { allowed: true, reason: "non_mutating_or_reversible_knowledge_action" };
  }

  if (action === "create_branch") {
    if (!branch || PROTECTED_BRANCHES.has(branch)) {
      return { allowed: false, reason: "isolated_non_protected_branch_required" };
    }
    return { allowed: true, reason: "isolated_branch" };
  }

  if (action === "commit_patch" || action === "open_pull_request") {
    if (!branch || PROTECTED_BRANCHES.has(branch)) {
      return { allowed: false, reason: "isolated_non_protected_branch_required" };
    }
    if (!Array.isArray(files) || files.length === 0 || files.length > limits.maxPatchFiles) {
      return { allowed: false, reason: "patch_file_limit_or_empty_patch" };
    }
    if (files.some((path) => typeof path !== "string" ||
      path.startsWith("/") || path.split("/").includes("..") ||
      /(^|\/)(\.env|secrets?)(\/|$)/i.test(path) ||
      /\.(pem|key|p12|pfx)$/i.test(path))) {
      return { allowed: false, reason: "unsafe_or_secret_path" };
    }
    if (!Number.isInteger(patchBytes) || patchBytes < 0 || patchBytes > limits.maxPatchBytes) {
      return { allowed: false, reason: "patch_size_limit" };
    }
    if (!testsPassed || !secretScanPassed || !rollbackAvailable) {
      return { allowed: false, reason: "tests_secret_scan_and_rollback_required" };
    }
    if (action === "open_pull_request" && !externalEvidence) {
      return { allowed: false, reason: "reviewable_evidence_required" };
    }
    return { allowed: true, reason: "reversible_change_ready_for_review" };
  }

  return { allowed: false, reason: "unknown_action_default_deny" };
}

export function labelLearningRecord({ sources = [], observedAt, confidence = "unverified" } = {}) {
  const validSources = sources.filter((source) =>
    typeof source === "string" && /^https:\/\//i.test(source)
  );
  const timestampValid = typeof observedAt === "string" && !Number.isNaN(Date.parse(observedAt));
  const evidenceComplete = validSources.length > 0 && timestampValid;
  return {
    confidence: confidence === "verified" && evidenceComplete ? "verified" : "unverified",
    sources: validSources,
    observedAt: timestampValid ? new Date(observedAt).toISOString() : null,
    evidenceComplete,
  };
}
