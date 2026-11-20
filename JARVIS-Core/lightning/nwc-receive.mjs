// Copyright © 2026 Ta-Yoshua Lubuimi. All rights reserved.
// JARVIS receive-only integration module. No third-party source is embedded.
// No outgoing-payment method is exposed by this adapter.

const PAYMENT_HASH = /^[0-9a-f]{64}$/i;
const NWC_SCHEME = "nostr+walletconnect://";

function validConnectionString(value) {
  return typeof value === "string" && value.startsWith(NWC_SCHEME) && value.length > NWC_SCHEME.length;
}

function normalizeTransaction(tx) {
  return {
    paymentHash: String(tx?.payment_hash || "").toLowerCase(),
    invoice: String(tx?.invoice || ""),
    amountMsat: Number(tx?.amount || 0),
    state: String(tx?.state || "unknown"),
    createdAt: Number(tx?.created_at || 0),
    settledAt: Number(tx?.settled_at || 0),
    expiresAt: Number(tx?.expires_at || 0),
    description: String(tx?.description || "")
  };
}

export function satsToMsat(sats) {
  if (!Number.isSafeInteger(sats) || sats < 1 || sats > 100_000) {
    throw new RangeError("amountSats must be an integer from 1 to 100000");
  }
  return sats * 1000;
}

export function createNwcReceiveAdapter({
  connectionString = process.env.JARVIS_NWC_URL,
  clientFactory
} = {}) {
  if (!validConnectionString(connectionString)) {
    throw new Error("JARVIS_NWC_URL is missing or is not a Nostr Wallet Connect URL");
  }

  let clientPromise;
  const getClient = async () => {
    if (!clientPromise) {
      clientPromise = (async () => {
        if (clientFactory) return clientFactory(connectionString);
        const { NWCClient } = await import("@getalby/sdk/nwc");
        return new NWCClient({ nostrWalletConnectUrl: connectionString });
      })();
    }
    return clientPromise;
  };

  return Object.freeze({
    async status() {
      const client = await getClient();
      const [info, balance] = await Promise.all([client.getInfo(), client.getBalance()]);
      return {
        provider: "Alby Hub via NWC",
        connected: true,
        network: String(info?.network || "unknown"),
        alias: String(info?.alias || ""),
        balanceMsat: Number(balance?.balance || 0),
        balanceSats: Math.floor(Number(balance?.balance || 0) / 1000),
        supportedMethods: Array.isArray(info?.methods) ? info.methods : [],
        outgoingPaymentsEnabledByJARVIS: false
      };
    },

    async createInvoice({ amountSats, memo = "JARVIS invoice", expirySeconds = 3600 } = {}) {
      if (!Number.isSafeInteger(expirySeconds) || expirySeconds < 60 || expirySeconds > 604800) {
        throw new RangeError("expirySeconds must be between 60 and 604800");
      }
      const amountMsat = satsToMsat(amountSats);
      const description = String(memo).trim().slice(0, 240) || "JARVIS invoice";
      const client = await getClient();
      const tx = await client.makeInvoice({
        amount: amountMsat,
        description,
        expiry: expirySeconds
      });
      const normalized = normalizeTransaction(tx);
      if (!PAYMENT_HASH.test(normalized.paymentHash) || !normalized.invoice) {
        throw new Error("NWC returned an incomplete invoice");
      }
      return {
        paymentHash: normalized.paymentHash,
        invoice: normalized.invoice,
        amountSats,
        amountMsat,
        state: normalized.state,
        createdAt: normalized.createdAt,
        expiresAt: normalized.expiresAt,
        memo: description
      };
    },

    async lookupInvoice(paymentHash) {
      const hash = String(paymentHash || "").toLowerCase();
      if (!PAYMENT_HASH.test(hash)) throw new TypeError("paymentHash must be 64 hexadecimal characters");
      const client = await getClient();
      return normalizeTransaction(await client.lookupInvoice({ payment_hash: hash }));
    },

    async listIncomingSettlements({ from = 0, limit = 50 } = {}) {
      if (!Number.isSafeInteger(from) || from < 0) throw new RangeError("from must be a non-negative Unix timestamp");
      if (!Number.isSafeInteger(limit) || limit < 1 || limit > 100) throw new RangeError("limit must be from 1 to 100");
      const client = await getClient();
      const response = await client.listTransactions({ type: "incoming", from, limit });
      return (Array.isArray(response?.transactions) ? response.transactions : [])
        .map(normalizeTransaction)
        .filter(tx => tx.state === "settled" && PAYMENT_HASH.test(tx.paymentHash));
    },

    close() {
      if (clientPromise) {
        void clientPromise.then(client => client.close?.()).catch(() => {});
      }
    }
  });
}
