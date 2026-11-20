/**
 * Independent public-source verification for the JarvisAI DAO LLC dossier.
 *
 * This module performs live, read-only HTTP checks. It never upgrades status
 * merely because a dossier says "registered". The MIDAO portal is currently
 * a search UI; absent a documented query API or returned entity record, the
 * correct result is "inconclusive", not "not registered".
 */
import { laicProfile } from "./laic-profile.mjs";

const timeoutMs = 12_000;
const targets = [
  { key: "midao_public_registry", url: laicProfile.verificationPlan.authoritativeRegistry },
  { key: "dossier_cited_iri_verification", url: laicProfile.legalEntity.dossierVerificationUrl },
];

function normalize(value) {
  return String(value || "").replace(/\\s+/g, " ").trim().toLowerCase();
}

export async function verifyJarvisEntity({ fetchImpl = fetch } = {}) {
  const expectedName = normalize(laicProfile.legalEntity.name);
  const expectedNumber = laicProfile.legalEntity.registrationNumber;
  const checks = [];

  for (const target of targets) {
    const check = {
      source: target.key,
      url: target.url,
      fetched: false,
      httpStatus: null,
      exactNameFound: false,
      exactRegistrationNumberFound: false,
      entityRecordFound: false,
      result: "inconclusive",
      checkedAt: new Date().toISOString(),
      detail: "",
    };
    try {
      const response = await fetchImpl(target.url, {
        method: "GET",
        redirect: "follow",
        headers: { accept: "text/html,application/json;q=0.9,*/*;q=0.5", "user-agent": "JarvisAI-EntityVerifier/1.0" },
        signal: AbortSignal.timeout(timeoutMs),
      });
      check.fetched = true;
      check.httpStatus = response.status;
      const body = await response.text();
      const normalizedBody = normalize(body);
      check.exactNameFound = normalizedBody.includes(expectedName);
      check.exactRegistrationNumberFound = normalizedBody.includes(expectedNumber);
      check.entityRecordFound = check.exactNameFound && check.exactRegistrationNumberFound;
      if (response.ok && check.entityRecordFound) {
        check.result = "candidate_record_found_requires_document_authentication";
        check.detail = "The source response contains both exact identifiers. Confirm the result is an official current entity record, not page text or user-supplied content.";
      } else if (response.ok) {
        check.detail = "Source reachable, but no response record containing both exact identifiers was returned. A search form alone is not a registry match.";
      } else {
        check.detail = "Source returned a non-success HTTP status.";
      }
    } catch (error) {
      check.detail = error?.name === "TimeoutError" ? "Source request timed out." : String(error?.message || error);
    }
    checks.push(check);
  }

  const matched = checks.some((c) => c.result === "candidate_record_found_requires_document_authentication");
  return {
    verifier: "JarvisAI independent public-source verifier",
    entityName: laicProfile.legalEntity.name,
    registrationNumber: expectedNumber,
    jurisdiction: laicProfile.legalEntity.jurisdiction,
    checkedAt: new Date().toISOString(),
    status: matched ? "candidate_match_requires_authentication" : "inconclusive_no_public_record_returned",
    legalInterpretation: "RMI DAO Act §108 permits algorithmic management vested in a smart contract, subject to the certificate and LLC agreement. The legal person is the DAO LLC; the software's separate legal personality is a distinct question.",
    sources: checks,
    limitations: [
      "A reachable registry search page is not proof of registration.",
      "A text match is only a candidate and must be authenticated against a certified Registrar record.",
      "This verifier does not sign in, bypass access controls, submit filings, or use private keys.",
    ],
  };
}
