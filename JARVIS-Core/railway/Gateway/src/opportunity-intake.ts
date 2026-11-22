/**
 * JARVIS mass opportunity intake. Discovery is NOT authorization to execute,
 * contact a customer, invoice them, or collect payment.
 * Stateless validation; persistence/queueing belongs to an authenticated backend.
 */
export type Opportunity = {
  source: string;
  externalId: string;
  title: string;
  description: string;
  currency: string;
  budgetMinor: string;
  customerConsent: boolean;
  contractAccepted: boolean;
  scopeVerified: boolean;
  paymentTermsVerified: boolean;
  lawfulWorkVerified: boolean;
};
export type OpportunityDecision = {
  key: string;
  status: "rejected" | "review_required" | "eligible_for_scheduling";
  reasons: string[];
};
const currencies = new Set(["EUR","USD","GBP","BTC"]);
export function classifyOpportunity(o: Opportunity): OpportunityDecision {
  const key = [o.source,o.externalId].map(s=>String(s||"").trim().toLowerCase()).join(":");
  const reasons: string[] = [];
  if (!/^[a-z0-9._-]{2,100}:[a-z0-9._-]{2,150}$/.test(key)) reasons.push("invalid_source_or_id");
  if (!o.title?.trim() || !o.description?.trim()) reasons.push("missing_scope");
  if (!currencies.has(o.currency)) reasons.push("unsupported_currency");
  if (!/^[1-9][0-9]{0,14}$/.test(o.budgetMinor)) reasons.push("invalid_budget");
  if (reasons.length) return {key,status:"rejected",reasons};
  if (!o.customerConsent) reasons.push("customer_consent_missing");
  if (!o.contractAccepted) reasons.push("contract_not_accepted");
  if (!o.scopeVerified) reasons.push("scope_not_verified");
  if (!o.paymentTermsVerified) reasons.push("payment_terms_not_verified");
  if (!o.lawfulWorkVerified) reasons.push("lawfulness_not_verified");
  return {key,status:reasons.length?"review_required":"eligible_for_scheduling",reasons};
}
export function deduplicateOpportunities(items: Opportunity[], limit=10000): Opportunity[] {
  if (!Number.isInteger(limit) || limit<1 || limit>10000) throw new Error("invalid_batch_limit");
  const seen=new Set<string>(),result:Opportunity[]=[];
  for (const item of items.slice(0,limit)) {
    const key=String(item.source||"").trim().toLowerCase()+":"+String(item.externalId||"").trim().toLowerCase();
    if (seen.has(key)) continue;
    seen.add(key);result.push(item);
  }
  return result;
}
