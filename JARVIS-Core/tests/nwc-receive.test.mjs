import test from "node:test";
import assert from "node:assert/strict";
import { createNwcReceiveAdapter, satsToMsat } from "../lightning/nwc-receive.mjs";

const HASH = "a".repeat(64);
const INVOICE = "lnbc210n1p-test-invoice";

test("satsToMsat uses exact millisatoshi conversion and bounds", () => {
  assert.equal(satsToMsat(1), 1000);
  assert.equal(satsToMsat(21), 21000);
  assert.throws(() => satsToMsat(0), RangeError);
  assert.throws(() => satsToMsat(100001), RangeError);
  assert.throws(() => satsToMsat(1.5), RangeError);
});

test("adapter creates an incoming invoice in msat", async () => {
  const calls = [];
  const adapter = createNwcReceiveAdapter({
    connectionString: "nostr+walletconnect://test",
    clientFactory: async () => ({
      async makeInvoice(args) {
        calls.push(["makeInvoice", args]);
        return { payment_hash: HASH, invoice: INVOICE, amount: args.amount, state: "pending", created_at: 10, expires_at: 3610 };
      },
      close() {}
    })
  });
  const result = await adapter.createInvoice({ amountSats: 21, memo: "JARVIS work" });
  assert.equal(calls[0][0], "makeInvoice");
  assert.equal(calls[0][1].amount, 21000);
  assert.equal(result.amountSats, 21);
  assert.equal(result.paymentHash, HASH);
  assert.equal(result.invoice, INVOICE);
});

test("adapter returns only settled incoming transactions", async () => {
  const adapter = createNwcReceiveAdapter({
    connectionString: "nostr+walletconnect://test",
    clientFactory: async () => ({
      async listTransactions(args) {
        assert.equal(args.type, "incoming");
        return { transactions: [
          { type: "incoming", payment_hash: HASH, invoice: INVOICE, amount: 21000, state: "settled" },
          { type: "incoming", payment_hash: "b".repeat(64), invoice: "pending", amount: 1000, state: "pending" },
          { type: "outgoing", payment_hash: "c".repeat(64), invoice: "outgoing", amount: 1000, state: "settled" }
        ] };
      },
      close() {}
    })
  });
  const result = await adapter.listIncomingSettlements();
  assert.equal(result.length, 1);
  assert.equal(result[0].paymentHash, HASH);
  assert.equal(result[0].state, "settled");
});

test("adapter exposes no outgoing payment operation", () => {
  const adapter = createNwcReceiveAdapter({
    connectionString: "nostr+walletconnect://test",
    clientFactory: async () => ({})
  });
  assert.equal("payInvoice" in adapter, false);
  assert.equal("payKeysend" in adapter, false);
});

test("invalid NWC connection strings are rejected", () => {
  assert.throws(() => createNwcReceiveAdapter({ connectionString: "https://example.invalid" }), /Nostr Wallet Connect URL/);
});
