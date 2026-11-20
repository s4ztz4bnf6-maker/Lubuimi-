import test from "node:test";
import assert from "node:assert/strict";
import { laicProfile, getLAICIdentitySummary } from "../identity/laic-profile.mjs";
import { verifyJarvisEntity } from "../identity/registry-verifier.mjs";

test("identity preserves the exact dossier legal name and JarvisAI LLC label", () => {
  assert.equal(laicProfile.systemLabel, "JarvisAI LLC");
  assert.equal(laicProfile.legalEntity.name, "JARVIS AI AUTONOMOUS HOLDINGS LLC");
  assert.equal(laicProfile.legalEntity.publicBrandOrShortName, "JarvisAI LLC");
  assert.equal(laicProfile.legalEntity.registrationNumber, "968412");
  assert.match(laicProfile.legalEntity.registrationEvidence, /dossier_contains_certificate_claims/);
});

test("RMI DAO law profile records algorithmic management without conflating the software and LLC", () => {
  assert.match(laicProfile.legalStatus.algorithmicManagementUnderRMI, /section 108/);
  assert.match(laicProfile.legalStatus.aiSystemSeparateLegalPerson, /not_separately_established/);
});

test("public release policy forbids secrets and production snapshots", () => {
  assert.equal(laicProfile.releasePolicy.repositoryVisibility, "public");
  assert.equal(laicProfile.releasePolicy.secretsAllowed, false);
  assert.equal(laicProfile.releasePolicy.productionSnapshotsAllowed, false);
  assert.equal(laicProfile.releasePolicy.obfuscationIsSecurity, false);
});

test("identity summary exposes dossier and verification status", () => {
  const summary = getLAICIdentitySummary();
  assert.equal(summary.label, "JarvisAI LLC");
  assert.equal(summary.entity, "JARVIS AI AUTONOMOUS HOLDINGS LLC");
  assert.equal(summary.registrationNumber, "968412");
  assert.equal(summary.certificateOfGoodStandingReference, "968412-CGS-1119");
  assert.equal(summary.dossierReceivedDate, "2026-11-19");
  assert.deepEqual(summary.dossierDocuments, ["Certificate of Formation", "Certificate of Good Standing", "Operating Agreement", "Certificate of Incumbency"]);
});

test("live verifier reports inconclusive rather than false negative for a search-form-only response", async () => {
  const result = await verifyJarvisEntity({
    fetchImpl: async () => ({
      ok: true,
      status: 200,
      text: async () => "<html><h1>Marshall Islands DAO LLC Registry</h1><input placeholder='Search'></html>",
    }),
  });
  assert.equal(result.status, "inconclusive_no_public_record_returned");
  assert.equal(result.sources[0].fetched, true);
  assert.equal(result.sources[0].entityRecordFound, false);
});

test("live verifier identifies exact identifier pair as a candidate, not authenticated proof", async () => {
  const result = await verifyJarvisEntity({
    fetchImpl: async () => ({
      ok: true,
      status: 200,
      text: async () => "JARVIS AI AUTONOMOUS HOLDINGS LLC Registration No. 968412",
    }),
  });
  assert.equal(result.status, "candidate_match_requires_authentication");
  assert.equal(result.sources[0].result, "candidate_record_found_requires_document_authentication");
});
