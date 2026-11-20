import { describe, expect, test } from "bun:test";
import {
  evaluateContractAction,
  evaluateSelfDevelopment,
  type DelegatedContractAuthority,
} from "./self-development-contract-execution";

describe("JARVIS bounded self-development", () => {
  const safe = {
    isolatedWorkspace: true,
    pathsWithinAllowlist: true,
    touchesSecrets: false,
    validationEvidenceRef: "ci://run/123",
    explicitOwnerApproval: false,
  };

  test("allows isolated code work and PR creation", () => {
    expect(evaluateSelfDevelopment("edit_sandbox", safe).allowed).toBe(true);
    expect(evaluateSelfDevelopment("run_tests", safe).allowed).toBe(true);
    expect(evaluateSelfDevelopment("open_pull_request", safe).allowed).toBe(true);
  });

  test("blocks secrets, credentials and production changes without approval", () => {
    expect(evaluateSelfDevelopment("read_or_export_secrets", safe).allowed).toBe(false);
    expect(evaluateSelfDevelopment("change_access_or_credentials", safe).allowed).toBe(false);
    expect(evaluateSelfDevelopment("deploy_production", safe).allowed).toBe(false);
  });

  test("blocks code changes outside the isolated allowlist", () => {
    expect(evaluateSelfDevelopment("edit_sandbox", { ...safe, isolatedWorkspace: false }).allowed).toBe(false);
  });
});

describe("delegated contract authority", () => {
  const verified: DelegatedContractAuthority = {
    legalEntityStatus: "verified",
    legalEntityName: "Example Legal Person Ltd",
    registryEvidenceRef: "registry://verified/entity/123",
    representativeAuthority: "verified",
    representativeEvidenceRef: "registry://verified/representative/456",
    agentDelegation: "verified",
    delegationEvidenceRef: "document://verified/mandate/789",
    permittedActions: ["send_binding_offer", "accept_binding_offer", "sign_contract"],
    permittedCounterpartyTypes: ["business"],
    maxCommitmentMinorUnits: 500000,
    currency: "EUR",
    mandateExpiresAt: "2027-12-31T23:59:59.000Z",
    legalValidityReview: "verified",
    executionCredential: "authorized_representative_approved_esign",
    credentialVerification: "verified",
    qualifiedEntitySeal: "unverified",
    counterpartyChecks: "verified",
    perTransactionApprovalRequired: false,
  };

  const proposal = {
    action: "sign_contract" as const,
    counterpartyType: "business",
    currency: "EUR",
    commitmentMinorUnits: 250000,
    counterpartyVerified: true,
    termsWithinMandate: true,
    now: "2027-01-01T00:00:00.000Z",
    transactionApproval: false,
  };

  test("permits only a transaction covered by verified delegation", () => {
    expect(evaluateContractAction(verified, proposal).allowed).toBe(true);
  });

  test("blocks when legal entity or representative evidence is missing", () => {
    expect(evaluateContractAction({ ...verified, legalEntityStatus: "unverified" }, proposal).allowed).toBe(false);
    expect(evaluateContractAction({ ...verified, representativeAuthority: "unverified" }, proposal).allowed).toBe(false);
  });

  test("blocks expired mandates and amounts above the cap", () => {
    expect(evaluateContractAction(verified, { ...proposal, now: "2028-01-01T00:00:00.000Z" }).allowed).toBe(false);
    expect(evaluateContractAction(verified, { ...proposal, commitmentMinorUnits: 500001 }).allowed).toBe(false);
  });

  test("requires transaction approval when the mandate says so", () => {
    const authority = { ...verified, perTransactionApprovalRequired: true };
    expect(evaluateContractAction(authority, proposal).allowed).toBe(false);
    expect(evaluateContractAction(authority, { ...proposal, transactionApproval: true }).allowed).toBe(true);
  });

  test("does not mistake an electronic seal for contract acceptance", () => {
    const authority = { ...verified, executionCredential: "entity_seal_with_separate_valid_acceptance" as const, qualifiedEntitySeal: "verified" as const };
    expect(evaluateContractAction(authority, proposal).allowed).toBe(false);
    const withAcceptance = { ...authority, separateAcceptanceEvidenceRef: "acceptance://approved/123" };
    expect(evaluateContractAction(withAcceptance, proposal).allowed).toBe(true);
    expect(evaluateContractAction({ ...withAcceptance, qualifiedEntitySeal: "unverified" }, proposal).allowed).toBe(false);
  });

  test("always permits non-binding drafts without granting signing power", () => {
    const unverified = { ...verified, legalEntityStatus: "unverified" as const, agentDelegation: "unverified" as const };
    expect(evaluateContractAction(unverified, { ...proposal, action: "prepare_draft" }).allowed).toBe(true);
    expect(evaluateContractAction(unverified, proposal).allowed).toBe(false);
  });
});
