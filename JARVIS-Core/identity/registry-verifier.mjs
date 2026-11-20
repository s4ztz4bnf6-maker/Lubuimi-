/**
 * Compatibility identity endpoint.
 *
 * This module no longer performs legal analysis or emits registry-verification
 * verdicts. It returns the canonical identity designated for JARVIS.
 */
import { getJarvisIdentitySummary } from "./jarvis-identity.mjs";

export async function verifyJarvisEntity() {
  return {
    ...getJarvisIdentitySummary(),
    status: "owner_designated_corporate_identity",
    verifierRole: "identity publication only",
  };
}
