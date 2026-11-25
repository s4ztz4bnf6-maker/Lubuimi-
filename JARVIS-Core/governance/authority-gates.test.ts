import { describe, expect, test } from "bun:test";
import { evaluateAction, type AuthorityEvidence } from "./authority-gates";

const unverified: AuthorityEvidence = {
  aiLegalPersonhood: "not_established",
  legalEntityStatus: "unverified",
  representativeAuthority: "unverified",
  trustServiceProvider: "unverified",
  qualifiedSealCertificate: "unverified",
  approvedActionScopes: [],
  humanApproval: false,
};

describe("JARVIS authority gates", () => {
  test("allows public research and job/gift discovery", () => {
    expect(evaluateAction("job_search", unverified).allowed).toBe(true);
    expect(evaluateAction("gift_search", unverified).allowed).toBe(true);
    expect(evaluateAction("research", unverified).allowed).toBe(true);
  });

  test("allows contract drafting but not execution", () => {
    expect(evaluateAction("prepare_contract_draft", unverified).allowed).toBe(true);
    expect(evaluateAction("send_contract", unverified).allowed).toBe(false);
  });

  test("blocks bank, payment and seal actions without verified authority", () => {
    expect(evaluateAction("apply_for_bank_account", unverified).allowed).toBe(false);
    expect(evaluateAction("make_payment", unverified).allowed).toBe(false);
    expect(evaluateAction("create_electronic_seal", unverified).allowed).toBe(false);
  });
});
