import { readMailbox, writeReply, type MailboxConfig } from "./mailbox-client";

type Sql = (strings: TemplateStringsArray, ...values: unknown[]) => Promise<any[]>;
type Options = { config: MailboxConfig; sql: Sql; intervalMs?: number; log?: Pick<Console, "info" | "warn" | "error"> };
export async function pollMailboxOnce({ config, sql, log = console }: Options) {
  const messages = await readMailbox(config);
  let accepted = 0;
  for (const message of messages) {
    // The database enforces idempotency across processes and restarts.
    const inserted = await sql`
      INSERT INTO jarvis_mailbox_receipts (file_sha, file_name, status)
      VALUES (${message.sha}, ${message.name}, 'received')
      ON CONFLICT (file_sha) DO NOTHING RETURNING file_sha
    `;
    if (!inserted.length) continue;
    try {
      // Untrusted external content is queued for review, not executed as commands.
      await sql`
        INSERT INTO agent_messages (channel, recipient, subject, body, status)
        VALUES ('github_mailbox', 'jarvis', ${message.name}, ${message.text}, 'pending_approval')
      `;
      await sql`
        UPDATE jarvis_mailbox_receipts SET status = 'queued', updated_at = NOW()
        WHERE file_sha = ${message.sha}
      `;
      accepted++;
    } catch (error) {
      // Do not leave a permanent false dedupe entry after queue insertion fails.
      await sql`DELETE FROM jarvis_mailbox_receipts WHERE file_sha = ${message.sha} AND status = 'received'`;
      throw error;
    }
  }
  if (accepted) {
    log.info(`[Mailbox] Queued ${accepted} message(s) for review`);
    // An ACK is not a generated agent answer.
    if (config.token) await writeReply(config, `# JARVIS mailbox receipt\n\nQueued ${accepted} new message(s) at ${new Date().toISOString()}.\n\nStatus: RECEIVED / PENDING APPROVAL. This is an automated receipt, not an agent response.\n`);
  }
  return accepted;
}
export async function initMailboxSchema(sql: Sql) {
  await sql`
    CREATE TABLE IF NOT EXISTS jarvis_mailbox_receipts (
      file_sha TEXT PRIMARY KEY,
      file_name TEXT NOT NULL,
      status TEXT NOT NULL CHECK (status IN ('received','queued')),
      updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    )
  `;
}
export function startMailboxPolling(options: Options) {
  const log = options.log ?? console;
  if (!options.config.repository) {
    log.warn("[Mailbox] Disabled: missing bridge configuration");
    return () => {};
  }
  let stopped = false;
  let busy = false;
  let retryAfter = 0;
  const run = async () => {
    if (stopped || busy || Date.now() < retryAfter) return;
    busy = true;
    try {
      await pollMailboxOnce(options);
      retryAfter = 0;
    } catch (error) {
      const message = String(error instanceof Error ? error.message : error);
      // GitHub authorization failures need credential repair, not rapid retries.
      retryAfter = Date.now() + (/GitHub HTTP (401|403)\\b/.test(message) ? 15 * 60_000 : 60_000);
      log.warn("[Mailbox] Poll unavailable; retry scheduled", {
        reason: /GitHub HTTP (401|403)\\b/.test(message) ? "github_auth" : "temporary_error",
        retryMinutes: Math.ceil((retryAfter - Date.now()) / 60_000)
      });
    } finally { busy = false; }
  };
  const timer = setInterval(() => { void run(); }, Math.max(options.intervalMs ?? 60_000, 10_000));
  void run();
  log.info(options.config.token ? "[Mailbox] Polling initialized (read/write)" : "[Mailbox] Polling initialized (public read-only)");
  return () => { stopped = true; clearInterval(timer); };
}
