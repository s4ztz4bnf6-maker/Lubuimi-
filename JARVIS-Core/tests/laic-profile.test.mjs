import test from "node:test";
import assert from "node:assert/strict";
import { laicProfile, getLAICIdentitySummary } from "../identity/laic-profile.mjs";
import { verifyJarvisEntity, assessRegistryRecord } from "../identity/registry-verifier.mjs";

test("identity preserves the exact dossier legal name and JarvisAI LLC label", () => {
  assert.equal(laicProfile.systemLabel, "JarvisAI LLC");
  assert.equal(laicProfile.legalEntity.name, "JARVIS AI AUTONOMOUS HOLDINGS LLC");
  assert.equal(laicProfile.legalEntity.publicBrandOrShortName, "JarvisAI LLC");
  assert.match(laicProfile.legalEntity.publicBrandOrShortNameStatus, /not proof of legal registration/);
  assert.equal(laicProfile.legalEntity.registrationNumber, "968412");
  assert.equal(laicProfile.legalEntity.statutoryRegisteredNameCandidate, "JARVIS AI AUTONOMOUS HOLDINGS DAO LLC");
  assert.equal(laicProfile.legalEntity.goodStanding, "NOT_VERIFIED_current_certified_evidence_required");
  assert.match(laicProfile.legalEntity.registrationEvidence, /dossier_contains_certificate_of_formation_and_certificate_of_good_standing_reference/);
});

test("RMI DAO law profile records algorithmic management without conflating the software and LLC", () => {
  assert.match(laicProfile.legalStatus.algorithmicManagementUnderRMI, /§708/);
  assert.match(laicProfile.legalStatus.naturalPersonControlRequirement, /§714/);
  assert.match(laicProfile.legalStatus.governingDocumentPrecedence, /§715/);
  assert.match(laicProfile.dossierReview.nameConflict, /§704\(4\)/);
  assert.match(laicProfile.dossierReview.registeredAgentConflict, /MIDAO Directory Services/);
  assert.match(laicProfile.dossierReview.humanControlEvidence, /§714\(1\)\(d\)/);
  assert.equal(laicProfile.dossierReview.authenticationStatus, "NOT_AUTHENTICATED_against_MIDAO_or_Registrar");
  assert.match(laicProfile.legalStatus.aiSystemSeparateLegalPerson, /No express separate AI legal-personhood route/);
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
      text: async () => "<html><h1>Marshall Islands DAO LLC Registry</h1><p>Search for public DAO LLC entity information by entering a company name or full registration number.</p><input placeholder='Search'></html>",
    }),
  });
  assert.equal(result.status, "NOT_VERIFIED_manual_MIDAO_registry_lookup_required");
  assert.equal(result.registrationStatus, "NOT_VERIFIED");
  assert.equal(result.goodStandingStatus, "NOT_VERIFIED");
  assert.equal(result.sources[0].fetched, true);
  assert.equal(result.sources[0].entityRecordReturned, false);
  assert.equal(result.sources[0].searchInterfaceDetected, true);
  assert.equal(result.sources[0].result, "search_ui_reachable_manual_record_lookup_required");
  assert.equal(result.nonAuthoritativeDossierPortal.queried, false);
  assert.equal(result.dossierDiscrepancies.length, 6);
  assert.match(result.dossierDiscrepancies[3], /natural-person/);
});

test("official MIDAO record identifiers are only a candidate until certified documents are authenticated", () => {
  const result = assessRegistryRecord({
    sourceUrl: "https://registry.midao.org/public-registry/",
    legalName: "JARVIS AI AUTONOMOUS HOLDINGS DAO LLC",
    registrationNumber: "968412",
  });
  assert.equal(result.officialMidaoSource, true);
  assert.equal(result.exactNameFound, true);
  assert.equal(result.exactRegistrationNumberFound, true);
  assert.equal(result.candidateMatch, true);
  assert.equal(result.result, "candidate_match_requires_certified_document_authentication");
});

test("IRI is not accepted as the DAO LLC registry source", () => {
  const result = assessRegistryRecord({
    sourceUrl: "https://resources.register-iri.com/verify",
    legalName: "JARVIS AI AUTONOMOUS HOLDINGS DAO LLC",
    registrationNumber: "968412",
  });
  assert.equal(result.officialMidaoSource, false);
  assert.equal(result.candidateMatch, false);
});
