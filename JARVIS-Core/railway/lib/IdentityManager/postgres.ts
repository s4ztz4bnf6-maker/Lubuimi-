import type { IdentityStore, PlatformIdentity, IdentityAuditEvent } from "./index";

/**
 * Accepts the existing postgres.js SQL client from Companion.
 * Does not open another connection pool or read environment secrets.
 * Apply schema.sql before using this adapter.
 */
export function postgresIdentityStore(sql: any): IdentityStore {
  return {
    async get(identityId, platform) {
      const rows = await sql`
        SELECT identity_id, platform, account_id, permissions, created_at
        FROM jarvis_platform_identities
        WHERE identity_id = ${identityId} AND platform = ${platform}
        LIMIT 1
      `;
      if (!rows.length) return null;
      const row = rows[0];
      return {
        identityId: row.identity_id,
        platform: row.platform,
        accountId: row.account_id,
        permissions: row.permissions,
        createdAt: new Date(row.created_at).toISOString(),
      } satisfies PlatformIdentity;
    },
    async put(record) {
      await sql`
        INSERT INTO jarvis_platform_identities
          (identity_id, platform, account_id, permissions, created_at)
        VALUES (
          ${record.identityId}, ${record.platform}, ${record.accountId},
          ${sql.json([...record.permissions])}, ${record.createdAt}
        )
      `;
    },
    async remove(identityId, platform) {
      await sql`
        DELETE FROM jarvis_platform_identities
        WHERE identity_id = ${identityId} AND platform = ${platform}
      `;
    },
    async appendAudit(event) {
      await sql`
        INSERT INTO jarvis_identity_audit
          (action, identity_id, platform, occurred_at)
        VALUES (
          ${event.action}, ${event.identityId}, ${event.platform},
          ${event.timestamp}
        )
      `;
    },
  };
}
