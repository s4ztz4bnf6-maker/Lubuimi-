import { expect, test } from "bun:test";
import { authorizeJarvisAction } from "./zero-spend-guard";
test("ordinary business operations are permitted", () => {
  for (const action of ["discover_leads","accept_order","execute_order","deliver_work","issue_invoice","receive_payment","verify_payment","read_database","write_database","run_migration"])
    expect(authorizeJarvisAction(action).allowed).toBe(true);
});
test("money out and financial obligations are blocked without owner approval", () => {
  for (const action of ["purchase","transfer_funds","withdraw","refund","subscribe_paid","place_paid_order","incur_fee","create_financial_obligation"])
    expect(authorizeJarvisAction(action)).toEqual({allowed:false,reason:"owner_approval_required_for_expenditure"});
});
test("unknown actions fail closed", () => {
  expect(authorizeJarvisAction("secret_spend").allowed).toBe(false);
});
test("explicit owner approval can authorize spending", () => {
  expect(authorizeJarvisAction("refund", true).allowed).toBe(true);
});
