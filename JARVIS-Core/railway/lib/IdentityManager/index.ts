/**
 * JARVIS Autonomous Identity Manager — initial, dependency-free registry.
 * No tokens, passwords, or private keys are accepted by this module.
 * Persistence and platform authentication must be implemented separately.
 */
export type PlatformIdentity = Readonly<{
  identityId: string;
  platform: string;
  accountId: string;
  permissions: readonly string[];
  createdAt: string;
}>;

export type IdentityAuditEvent = Readonly<{
  action: "platform.registered" | "platform.removed";
  identityId: string;
  platform: string;
  timestamp: string;
}>;

export interface IdentityStore {
  get(identityId: string, platform: string): Promise<PlatformIdentity | null>;
  put(record: PlatformIdentity): Promise<void>;
  remove(identityId: string, platform: string): Promise<void>;
  appendAudit(event: IdentityAuditEvent): Promise<void>;
}

const ID_PATTERN = /^[a-zA-Z0-9][a-zA-Z0-9_.:@/-]{0,127}$/;
function checked(value: string, field: string): string {
  if (typeof value !== "string" || !ID_PATTERN.test(value)) {
    throw new TypeError(`Invalid ${field}`);
  }
  return value;
}
function cleanPermissions(input: readonly string[]): string[] {
  if (!Array.isArray(input) || input.length > 64) throw new TypeError("Invalid permissions");
  return [...new Set(input.map(p => checked(p, "permission")))].sort();
}

/** This service records identities, not authorization credentials. */
export class IdentityManager {
  constructor(
    private readonly store: IdentityStore,
    private readonly now: () => string = () => new Date().toISOString(),
  ) {}

  async registerPlatform(
    identityId: string,
    platform: string,
    accountId: string,
    permissions: readonly string[] = [],
  ): Promise<PlatformIdentity> {
    identityId = checked(identityId, "identityId");
    platform = checked(platform, "platform");
    accountId = checked(accountId, "accountId");
    const record: PlatformIdentity = Object.freeze({
      identityId, platform, accountId,
      permissions: Object.freeze(cleanPermissions(permissions)),
      createdAt: this.now(),
    });
    if (await this.store.get(identityId, platform)) {
      throw new Error("Platform identity already exists");
    }
    await this.store.put(record);
    await this.store.appendAudit({
      action: "platform.registered", identityId, platform, timestamp: this.now(),
    });
    return record;
  }

  async getPlatform(identityId: string, platform: string): Promise<PlatformIdentity | null> {
    return this.store.get(checked(identityId, "identityId"), checked(platform, "platform"));
  }

  async removePlatform(identityId: string, platform: string): Promise<void> {
    identityId = checked(identityId, "identityId");
    platform = checked(platform, "platform");
    if (!(await this.store.get(identityId, platform))) return;
    await this.store.remove(identityId, platform);
    await this.store.appendAudit({
      action: "platform.removed", identityId, platform, timestamp: this.now(),
    });
  }
}
