import test from "node:test";
import assert from "node:assert/strict";
import { laicProfile, getLAICIdentitySummary } from "../identity/laic-profile.mjs";

test("LAIC profile records the declared entity without overstating verification", () => {
  assert.equal(laicProfile.legalEntity.name, "JARVIS AI AUTONOMOUS HOLDINGS DAO LLC");
  assert.equal(laicProfile.legalEntity.registrationNumber, "968412");
  assert.equal(laicProfile.legalEntity.registrationEvidence, "user_asserted_not_independently_verified");
});

test("public release policy forbids secrets and production snapshots", () => {
  assert.equal(laicProfile.releasePolicy.repositoryVisibility, "public");
  assert.equal(laicProfile.releasePolicy.secretsAllowed, false);
  assert.equal(laicProfile.releasePolicy.productionSnapshotsAllowed, false);
  assert.equal(laicProfile.releasePolicy.obfuscationIsSecurity, false);
});

test("identity summary is usable by other JARVIS modules", () => {
  const summary = getLAICIdentitySummary();
  assert.equal(summary.label, "JARVIS LAIC");
  assert.equal(summary.aiRole, "algorithmic_operations_and_assistance");
});
