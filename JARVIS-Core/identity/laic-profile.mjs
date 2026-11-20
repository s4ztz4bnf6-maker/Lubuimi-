/**
 * Compatibility exports for earlier internal imports.
 * Canonical identity now lives in jarvis-identity.mjs.
 */
import { jarvisIdentity, getJarvisIdentitySummary } from "./jarvis-identity.mjs";

export const laicProfile = Object.freeze({
  systemLabel: jarvisIdentity.systemName,
  legalEntity: Object.freeze({
    name: jarvisIdentity.legalName,
    publicBrandOrShortName: jarvisIdentity.shortLegalName,
    jurisdiction: jarvisIdentity.jurisdiction,
    registrationNumber: jarvisIdentity.registrationNumber,
    entityType: jarvisIdentity.entityType,
    formationDate: jarvisIdentity.formationDate,
    registryStatus: jarvisIdentity.registryStatusAsStatedInDossier,
  }),
});

export function getLAICIdentitySummary() {
  return getJarvisIdentitySummary();
}
