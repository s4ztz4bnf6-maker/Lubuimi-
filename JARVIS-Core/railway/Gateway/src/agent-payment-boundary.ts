/**
 * Least-privilege work distribution. Agents never receive IBANs, bank credentials,
 * wallet secrets, or payment-provider tokens. Payment instructions are generated
 * centrally after customer authorization.
 */
export type AgentWorkItem = {
  jobId: string;
  sourceId: string;
  title: string;
  scope: string;
  currency: "BTC" | "EUR" | "USD" | "GBP";
  budgetMinor: string;
  contractAccepted: boolean;
  customerConsent: boolean;
  lawfulWorkVerified: boolean;
  paymentReference: string;
};
export type AgentAssignment = {
  jobId: string;
  task: { title: string; scope: string };
  compensation: { currency: AgentWorkItem["currency"]; budgetMinor: string };
  payment: { reference: string; settlementManagedBy: "central_gateway" };
  permissions: { canReadBankAccount: false; canTransferFunds: false; canInvoice: false; canAccessWalletKeys: false };
};
export function assignToAgent(item: AgentWorkItem): AgentAssignment {
  if (!item.contractAccepted || !item.customerConsent || !item.lawfulWorkVerified) throw new Error("job_not_authorized");
  if (!/^[A-Za-z0-9_-]{6,100}$/.test(item.jobId) || !/^[A-Za-z0-9_-]{6,100}$/.test(item.paymentReference)) throw new Error("invalid_reference");
  if (!["BTC","EUR","USD","GBP"].includes(item.currency) || !/^[1-9][0-9]{0,14}$/.test(item.budgetMinor)) throw new Error("invalid_compensation");
  if (!item.title.trim() || !item.scope.trim()) throw new Error("missing_scope");
  return {
    jobId:item.jobId,
    task:{title:item.title,scope:item.scope},
    compensation:{currency:item.currency,budgetMinor:item.budgetMinor},
    payment:{reference:item.paymentReference,settlementManagedBy:"central_gateway"},
    permissions:{canReadBankAccount:false,canTransferFunds:false,canInvoice:false,canAccessWalletKeys:false},
  };
}
export type NetworkLimits = { maxConcurrentAgents:number; maxCandidatesPerBatch:number; maxDailyExternalCostMinor:number };
export function validateNetworkLimits(limits:NetworkLimits):NetworkLimits {
  if (!Number.isSafeInteger(limits.maxConcurrentAgents) || limits.maxConcurrentAgents<1 || limits.maxConcurrentAgents>1000000) throw new Error("invalid_agent_limit");
  if (!Number.isSafeInteger(limits.maxCandidatesPerBatch) || limits.maxCandidatesPerBatch<1 || limits.maxCandidatesPerBatch>10000) throw new Error("invalid_batch_limit");
  if (limits.maxDailyExternalCostMinor !== 0) throw new Error("external_spending_disabled");
  return limits;
}
