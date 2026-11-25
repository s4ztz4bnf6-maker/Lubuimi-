// DJO² IA — binding owner commercial policy, 2026-11-25.
export const COMMERCIAL_POLICY = Object.freeze({
 objective: "maximize verified payout likelihood and expected hourly return",
 aiRule: "AI-assisted work need not be expressly permitted; applicable reviewed rules must not prohibit the intended work",
 requireRulesReview: true,
 honorDisclosureAndHumanReview: true,
 unknownRulesBlockExecution: true,
 preferPrepaidThenFundedEscrowThenAssigned: true,
 requireVerifiedPayerAndPayoutRoute: true,
 requireAcceptanceCriteriaAndLicenseCompatibility: true,
 noUnapprovedSpending: true,
 countIncomeOnlyAfterReconciledReceipt: true,
 selectionModule: "./commercial-selection.ts"
} as const);
// Policy declaration; runtime enforcement must be integrated and tested separately.
