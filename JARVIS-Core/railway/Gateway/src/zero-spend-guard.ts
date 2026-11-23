/** Owner mandate: autonomous business operations, zero unapproved expenditure. */
export type JarvisAction =
  | "discover_leads" | "accept_order" | "execute_order" | "deliver_work"
  | "issue_invoice" | "receive_payment" | "verify_payment"
  | "read_database" | "write_database" | "run_migration"
  | "purchase" | "transfer_funds" | "withdraw" | "refund"
  | "subscribe_paid" | "place_paid_order" | "incur_fee" | "create_financial_obligation";
const EXPENDITURE = new Set<JarvisAction>([
  "purchase", "transfer_funds", "withdraw", "refund",
  "subscribe_paid", "place_paid_order", "incur_fee", "create_financial_obligation",
]);
export type SpendDecision = { allowed: boolean; reason: string };
/** Fail closed: unknown actions and all spending require explicit owner approval.
 * This pure function does NOT by itself protect external API calls: every execution
 * boundary must call it before making a commitment or transferring value.
 */
export function authorizeJarvisAction(action: string, ownerApproved = false): SpendDecision {
  const known: readonly string[] = [
    "discover_leads", "accept_order", "execute_order", "deliver_work",
    "issue_invoice", "receive_payment", "verify_payment",
    "read_database", "write_database", "run_migration",
    ...EXPENDITURE,
  ];
  if (!known.includes(action)) return { allowed: false, reason: "unknown_action" };
  if (EXPENDITURE.has(action as JarvisAction) && !ownerApproved)
    return { allowed: false, reason: "owner_approval_required_for_expenditure" };
  return { allowed: true, reason: ownerApproved ? "owner_approved" : "autonomous_business_action" };
}
