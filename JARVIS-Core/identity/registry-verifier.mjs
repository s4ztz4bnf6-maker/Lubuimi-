/**
 * Read-only verifier for the claimed JARVIS RMI DAO LLC.
 *
 * A public registry search page is not an entity record. The MIDAO registry
 * is the relevant public lookup for DAO LLCs; IRI's traditional-company
 * verification page is deliberately not treated as DAO LLC evidence.
 *
 * This module never reports "verified" from a page fetch or text substring.
 * A record match remains a candidate until certified Registrar documents
 * and current good-standing evidence are authenticated.
 */
import { laicProfile } from "./laic-profile.mjs";

const timeoutMs = 12_000;
const registryUrl = laicProfile.verificationPlan.authoritativeRegistry;
const registryHost = new URL(registryUrl).host;

function normalize(value) {
  return String(value || "").replace(/\s+/g, " ").trim().toLowerCase();
}

export function assessRegistryRecord(record) {
  const sourceUrl = String(record?.sourceUrl || "");
  let officialMidaoSource = false;
  try {
    const parsed = new URL(sourceUrl);
    officialMidaoSource = parsed.protocol === "https:" &&
      parsed.host === registryHost &&
      parsed.pathname.startsWith("/public-registry");
  } catch {}

  const suppliedName = normalize(record?.legalName);
  const suppliedNumber = String(record?.registrationNumber || "").trim();
  const acceptedNames = [
    normalize(laicProfile.legalEntity.name),
    normalize(laicProfile.legalEntity.statutoryRegisteredNameCandidate),
  ];
  const exactNameFound = acceptedNames.includes(suppliedName);
  const exactRegistrationNumberFound = suppliedNumber === laicProfile.legalEntity.registrationNumber;
  const candidateMatch = officialMidaoSource && exactNameFound && exactRegistrationNumberFound;

  return {
    sourceUrl,
    officialMidaoSource,
    suppliedName: record?.legalName || null,
    suppliedRegistrationNumber: suppliedNumber || null,
    exactNameFound,
    exactRegistrationNumberFound,
    candidateMatch,
    result: candidateMatch
      ? "candidate_match_requires_certified_document_authentication"
      : "no_authenticated_exact_match",
    limitation: "A copied search result is not certified proof. Authenticate the current Certificate of Formation/Charter and current Certificate of Good Standing with MIDAO/Registrar.",
  };
}

export async function verifyJarvisEntity({ fetchImpl = fetch, registryRecord = null } = {}) {
  const checkedAt = new Date().toISOString();
  const check = {
    source: "midao_public_dao_llc_registry",
    url: registryUrl,
    fetched: false,
    httpStatus: null,
    searchInterfaceDetected: false,
    entityRecordReturned: false,
    result: "inconclusive",
    checkedAt,
    detail: "",
  };

  try {
    const response = await fetchImpl(registryUrl, {
      method: "GET",
      redirect: "follow",
      headers: {
        accept: "text/html,application/json;q=0.9,*/*;q=0.5",
        "user-agent": "JarvisAI-EntityVerifier/1.1",
      },
      signal: AbortSignal.timeout(timeoutMs),
    });
    check.fetched = true;
    check.httpStatus = response.status;
    const body = await response.text();
    check.searchInterfaceDetected = /search for public dao llc entity information|public-registry/i.test(body);
    if (response.ok && check.searchInterfaceDetected) {
      check.result = "search_ui_reachable_manual_record_lookup_required";
      check.detail = "The official MIDAO search interface is reachable. This HTTP response did not return a searched entity record; no registration match is inferred.";
    } else if (response.ok) {
      check.result = "registry_source_reachable_record_not_returned";
      check.detail = "The source responded, but no authenticated entity record was returned.";
    } else {
      check.result = "registry_source_unavailable";
      check.detail = "The MIDAO registry returned a non-success HTTP status.";
    }
  } catch (error) {
    check.detail = error?.name === "TimeoutError"
      ? "MIDAO registry request timed out."
      : String(error?.message || error);
  }

  const recordAssessment = registryRecord ? assessRegistryRecord(registryRecord) : null;
  const candidate = Boolean(recordAssessment?.candidateMatch);

  return {
    verifier: "JARVIS independent public-source verifier",
    entityNameInDossier: laicProfile.legalEntity.name,
    statutoryNameCandidate: laicProfile.legalEntity.statutoryRegisteredNameCandidate,
    registrationNumberClaimed: laicProfile.legalEntity.registrationNumber,
    jurisdiction: laicProfile.legalEntity.jurisdiction,
    checkedAt,
    status: candidate
      ? "candidate_match_requires_certified_documents"
      : "NOT_VERIFIED_manual_MIDAO_registry_lookup_required",
    registrationStatus: "NOT_VERIFIED",
    goodStandingStatus: "NOT_VERIFIED",
    statutoryNameCompliance: "UNRESOLVED",
    registeredAgentCompliance: "UNRESOLVED",
    sources: [check],
    recordAssessment,
    nonAuthoritativeDossierPortal: {
      url: laicProfile.legalEntity.dossierVerificationUrl,
      queried: false,
      reason: "IRI is not used as the DAO LLC registry; MIDAO documentation identifies a separate DAO LLC registry.",
    },
    legalInterpretation: "52 MIRC §702 defines the DAO LLC legal form; §704(4) addresses the DAO LLC name; §708 permits algorithmic management subject to filed instruments; §714(1)(d) requires control by at least one natural person; §715(1) gives the filed Certificate/LLC Agreement precedence over conflicting smart-contract terms.",
    dossierDiscrepancies: [
      laicProfile.dossierReview.nameConflict,
      laicProfile.dossierReview.registeredAgentConflict,
      laicProfile.dossierReview.goodStandingPortalConflict,
      laicProfile.dossierReview.humanControlEvidence,
      laicProfile.dossierReview.managementAuthorityConflict,
      laicProfile.dossierReview.signatureAndSealAuthentication,
      laicProfile.dossierReview.registeredOfficeConflict,
      laicProfile.dossierReview.beneficialOwnerReportStatus,
    ],
    requiredNextEvidence: [
      "Exact public MIDAO registry record for registration number 968412 and the registered legal name.",
      "Certified Certificate of Formation and Charter from the Registrar.",
      "Current Certificate of Good Standing.",
      "Filed/current LLC Agreement confirming member-managed or algorithmically managed status.",
      "Current Registered Agent and Representative Agent records, including written consent and authority documents.",
      "Current Beneficial Ownership Information Report filed with the Registrar under §712, with official filing receipt and confirmation of the natural person who retains control under §714(1)(d).",
      "Confirmation that the registered office address matches the statutory Registered Agent address under §705(3).",
      "MIDAO/Registrar confirmation resolving the TCMI versus MIDAO Registered Agent discrepancy and the exact DAO LLC registered name.",
    ],
    limitations: [
      "A reachable search form is not proof of registration.",
      "A matching name and number are only a candidate until authenticated against certified Registrar documents.",
      "This verifier does not log in, bypass access controls, submit filings, or use private keys.",
      "No conclusion of non-registration is drawn from an inconclusive public search.",
    ],
  };
}
