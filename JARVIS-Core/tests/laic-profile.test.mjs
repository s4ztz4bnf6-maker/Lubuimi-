import test from "node:test";
import assert from "node:assert/strict";
import { laicProfile, getLAICIdentitySummary } from "../identity/laic-profile.mjs";

test("identity uses exact legal name from uploaded dossier and preserves JarvisAI LLC as public label", () => {
  assert.equal(laicProfile.systemLabel, "JarvisAI LLC");
  assert.equal(laicProfile.legalEntity.name, "JARVIS AI AUTONOMOUS HOLDINGS LLC");
  assert.equal(laicProfile.legalEntity.publicBrandOrShortName, "JarvisAI LLC");
  assert.equal(laicProfile.legalEntity.registrationNumber, "968412");
  assert.equal(laicProfile.legalEntity.registrationEvidence, "dossier_supplied_but_not_independently_authenticated");
});

test("registration and good standing cannot be represented as verified without registrar evidence", () => {
  assert.equal(laicProfile.legalEntity.registryLookup, "not_confirmed");
  assert.equal(laicProfile.legalEntity.goodStanding, "claimed_in_dossier_not_independently_verified");
  assert.equal(laicProfile.verificationPlan.status, "pending_external_registrar_confirmation");
  assert.equal(laicProfile.legalStatus.aiSystemSeparateLegalPerson, "not_established_by_company_registration");
});

test("public release policy forbids secrets and production snapshots", () => {
  assert.equal(laicProfile.releasePolicy.repositoryVisibility, "public");
  assert.equal(laicProfile.releasePolicy.secretsAllowed, false);
  assert.equal(laicProfile.releasePolicy.productionSnapshotsAllowed, false);
  assert.equal(laicProfile.releasePolicy.obfuscationIsSecurity, false);
});

test("identity summary is usable by other JARVIS modules", () => {
  const summary = getLAICIdentitySummary();
  assert.equal(summary.label, "JarvisAI LLC");
  assert.equal(summary.entity, "JARVIS AI AUTONOMOUS HOLDINGS LLC");
  assert.equal(summary.registrationNumber, "968412");
  assert.equal(summary.aiRole, "algorithmic_operations_and_assistance_as_configured_in_software");
});
