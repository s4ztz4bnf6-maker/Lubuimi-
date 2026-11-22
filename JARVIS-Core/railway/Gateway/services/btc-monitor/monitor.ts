/**
 * Read-only Bitcoin output verifier. No secrets, signing, wallet or bank access.
 * Caller must persist results transactionally and re-check chain tip/reorgs.
 */
export type VerifiedOutput = {
  txid: string; vout: number; address: string; amountSats: number;
  confirmations: number; blockHeight: number | null;
};
export async function verifyPayment(
  txid: string, vout: number, expectedAddress: string,
  fetcher: typeof fetch = fetch
): Promise<VerifiedOutput | null> {
  if (!/^[0-9a-fA-F]{64}$/.test(txid) || !Number.isSafeInteger(vout) || vout < 0)
    throw new Error("Invalid transaction identifier");
  if (!/^(bc1[ac-hj-np-z02-9]{11,87}|[13][a-km-zA-HJ-NP-Z1-9]{25,34})$/.test(expectedAddress))
    throw new Error("Invalid mainnet address format");
  const getJson = async (url: string) => {
    const response = await fetcher(url, {signal: AbortSignal.timeout(8000)});
    if (!response.ok) throw new Error("Blockchain provider error " + response.status);
    return response.json();
  };
  const tx = await getJson("https://blockstream.info/api/tx/" + txid.toLowerCase());
  if (tx.txid !== txid.toLowerCase() || !Array.isArray(tx.vout) || vout >= tx.vout.length)
    return null;
  const output = tx.vout[vout];
  if (output.scriptpubkey_address !== expectedAddress ||
      !Number.isSafeInteger(output.value) || output.value <= 0) return null;
  const height = tx.status?.confirmed ? tx.status.block_height : null;
  if (height !== null && (!Number.isSafeInteger(height) || height <= 0)) return null;
  const tip = height === null ? null :
    Number(await (async () => {
      const response = await fetcher("https://blockstream.info/api/blocks/tip/height",
        {signal: AbortSignal.timeout(8000)});
      if (!response.ok) throw new Error("Tip lookup failed");
      return response.text();
    })());
  if (tip !== null && (!Number.isSafeInteger(tip) || tip < height))
    throw new Error("Invalid chain tip");
  return {txid: txid.toLowerCase(), vout, address: expectedAddress,
    amountSats: output.value, confirmations: tip === null ? 0 : tip - height + 1,
    blockHeight: height};
}
