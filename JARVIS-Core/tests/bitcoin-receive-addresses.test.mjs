import test from "node:test";
import assert from "node:assert/strict";
import { parseBitcoinReceiveAddresses } from "../tools/bitcoin-receive-addresses.mjs";

const legacy = "1" + "A".repeat(25);
const segwit = "bc1q" + "a".repeat(30);

test("reads the primary receive address from the runtime environment", () => {
  assert.deepEqual(parseBitcoinReceiveAddresses({ primary: legacy }), [legacy]);
});

test("supports multiple addresses and removes duplicates", () => {
  assert.deepEqual(
    parseBitcoinReceiveAddresses({ primary: legacy, additional: `${segwit}, ${legacy};` }),
    [legacy, segwit]
  );
});

test("rejects invalid configured addresses without echoing values", () => {
  assert.throws(
    () => parseBitcoinReceiveAddresses({ primary: "not-a-wallet-address" }),
    error => error.message.includes("1 invalid value") && !error.message.includes("not-a-wallet-address")
  );
});

test("returns an empty list when no receive address is configured", () => {
  assert.deepEqual(parseBitcoinReceiveAddresses({}), []);
});
