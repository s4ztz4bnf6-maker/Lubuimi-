/** Read Bitcoin receive addresses from runtime variables without embedding them in source. */
const BITCOIN_MAINNET_ADDRESS_PATTERN = /^(bc1[ac-hj-np-z02-9]{11,87}|[13][a-km-zA-HJ-NP-Z1-9]{25,34})$/;

export function parseBitcoinReceiveAddresses({ primary, additional } = {}) {
  const values = [
    primary,
    ...String(additional || "").split(/[,;\\s]+/)
  ].map(value => String(value || "").trim()).filter(Boolean);

  const unique = [...new Set(values)];
  const invalidCount = unique.filter(value => !BITCOIN_MAINNET_ADDRESS_PATTERN.test(value)).length;
  if (invalidCount) {
    throw new Error(`Invalid Bitcoin Mainnet receive-address configuration (${invalidCount} invalid value(s)); values omitted.`);
  }
  return unique;
}
