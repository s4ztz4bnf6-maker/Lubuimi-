/** JARVIS opportunity intake: evidence-first, no automated acceptance or payment claims. */
export type TaskOrigin = "internal_user" | "internal_system" | "internal_agent" | "external_candidate" | "external_contract" | "unknown";
export type PaymentStatus = "not_applicable" | "unverified" | "verified";
export interface OpportunityEvidence {
  sourceUrl?: string;
  requester?: string;
  contractId?: string;
  acceptanceEvidence?: string;
  deliveryEvidence?: string;
  paymentEvidence?: string;
}
export interface ClassifiedOpportunity {
  origin: TaskOrigin;
  paymentExpected: boolean;
  externalContractVerified: boolean;
  paymentStatus: PaymentStatus;
  evidence: OpportunityEvidence;
}
export function classifyOpportunity(origin: TaskOrigin, evidence: OpportunityEvidence = {}): ClassifiedOpportunity {
  const externalContractVerified = origin === "external_contract" && Boolean(
    evidence.sourceUrl && evidence.requester && evidence.contractId && evidence.acceptanceEvidence
  );
  const paymentExpected = externalContractVerified;
  const paymentStatus: PaymentStatus = origin.startsWith("internal_")
    ? "not_applicable"
    : externalContractVerified && evidence.paymentEvidence ? "verified" : "unverified";
  return { origin, paymentExpected, externalContractVerified, paymentStatus, evidence };
}
export function canReportRevenue(task: ClassifiedOpportunity): boolean {
  return task.externalContractVerified && task.paymentStatus === "verified";
}
export function isPublicHttpSource(value: string): boolean {
  try {
    const url = new URL(value);
    return url.protocol === "https:" && Boolean(url.hostname) && !url.username && !url.password;
  } catch { return false; }
}
// Important: a valid URL is NOT authorization to scrape. Enforce robots.txt,
// terms, SSRF protection, rate limits and authorization in the network layer.
