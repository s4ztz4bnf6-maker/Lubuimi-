// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export function capOutputTokens(computed, requested) {
  if (!Number.isFinite(computed) || computed < 1) return 0;
  if (requested === undefined) return Math.floor(computed);
  if (typeof requested !== "number" || !Number.isFinite(requested) || requested < 1) return 0;
  return Math.min(Math.floor(computed), Math.floor(requested));
}
