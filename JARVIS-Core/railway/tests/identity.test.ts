import { describe, expect, test } from "bun:test";
import { IdentityManager, type IdentityStore, type PlatformIdentity, type IdentityAuditEvent } from "../lib/IdentityManager/index";

function fixture() {
  const records = new Map<string, PlatformIdentity>();
  const audit: IdentityAuditEvent[] = [];
  const key = (id: string, platform: string) => `${id}: ${platform}`;
  const store: IdentityStore = {
    async get(id, platform) { return records.get(key(id, platform)) ?? null; },
    async put(record) { records.set(key(record.identityId, record.platform), record); },
    async remove(id, platform) { records.delete(key(id, platform)); },
    async appendAudit(event) { audit.push(event); },
  };
  return { manager: new IdentityManager(store, () => "2026-11-22T00:00:00.000Z"), records, audit };
}

describe("IdentityManager", () => {
  test("registers and retrieves a platform identity with deduplicated permissions", async () => {
    const { manager, audit } = fixture();
    const saved = await manager.registerPlatform("jarvis", "github", "agent-1", ["contents:read", "contents:read"]);
    expect(saved.permissions).toEqual(["contents:read"]);
    expect(await manager.getPlatform("jarvis", "github")).toEqual(saved);
    expect(audit).toHaveLength(1);
    expect(audit[0].action).toBe("platform.registered");
  });

  test("rejects duplicate registration", async () => {
    const { manager } = fixture();
    await manager.registerPlatform("jarvis", "github", "agent-1");
    await expect(manager.registerPlatform("jarvis", "github", "agent-2")).rejects.toThrow("already exists");
  });

  test("rejects invalid identifiers", async () => {
    const { manager } = fixture();
    await expect(manager.registerPlatform("bad id", "github", "agent-1")).rejects.toThrow("Invalid identityId");
  });

  test("removes identity and records an audit event", async () => {
    const { manager, audit } = fixture();
    await manager.registerPlatform("jarvis", "github", "agent-1");
    await manager.removePlatform("jarvis", "github");
    expect(await manager.getPlatform("jarvis", "github")).toBeNull();
    expect(audit.map(event => event.action)).toEqual(["platform.registered", "platform.removed"]);
  });
});
