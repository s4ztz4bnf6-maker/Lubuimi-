import { createHash } from "node:crypto";

const ROOT = "JARVIS-Core/agent-mailbox";
const BRANCH = "jarvis-core";
const NAME = /^CHATGPT-[A-Za-z0-9._-]+\.md$/;
const MAX_BYTES = 65_536;
export type MailboxMessage = { name: string; sha: string; text: string };
export type MailboxConfig = {
  token?: string;
  repository: string;
  fetchImpl?: typeof fetch;
};

function configuration(c: MailboxConfig) {
  if (!/^[A-Za-z0-9_.-]+\/[A-Za-z0-9_.-]+$/.test(c.repository)) throw new Error("Invalid repository");
}
function blobSha(bytes: Uint8Array) {
  return createHash("sha1").update(`blob ${bytes.byteLength}\0`).update(bytes).digest("hex");
}
async function github(c: MailboxConfig, path: string, init: RequestInit = {}) {
  configuration(c);
  if (init.method && init.method !== "GET" && !c.token) throw new Error("Write requires JARVIS_BRIDGE_TOKEN");
  const url = `https://api.github.com/repos/${c.repository}/contents/${path}${init.method === "PUT" ? "" : `?ref=${BRANCH}`}`;
  const response = await (c.fetchImpl ?? fetch)(url, {
    ...init,
    headers: {
      ...(c.token ? { Authorization: `Bearer ${c.token}` } : {}),
      Accept: "application/vnd.github+json",
      "X-GitHub-Api-Version": "2022-11-28",
      ...(init.headers ?? {}),
    },
    signal: AbortSignal.timeout(15_000),
  });
  if (!response.ok) throw new Error(`GitHub HTTP ${response.status}`);
  return response;
}
export async function readMailbox(c: MailboxConfig): Promise<MailboxMessage[]> {
  const listing = await (await github(c, ROOT)).json();
  if (!Array.isArray(listing)) throw new Error("Mailbox is not a directory");
  const messages: MailboxMessage[] = [];
  for (const entry of listing) {
    if (typeof entry?.name !== "string" || !NAME.test(entry.name) ||
        entry.type !== "file" || !/^[a-f0-9]{40}$/.test(entry.sha ?? "") ||
        entry.size > MAX_BYTES || entry.size < 0) continue;
    const response = await github(c, `${ROOT}/${encodeURIComponent(entry.name)}`);
    const item = await response.json();
    if (item.type !== "file" || item.encoding !== "base64" ||
        typeof item.content !== "string" || item.sha !== entry.sha ||
        item.size > MAX_BYTES || item.size < 0) throw new Error("Invalid file metadata");
    const encoded = item.content.replace(/\s/g, "");
    if (!/^(?:[A-Za-z0-9+/]{4})*(?:[A-Za-z0-9+/]{2}==|[A-Za-z0-9+/]{3}=)?$/.test(encoded))
      throw new Error("Invalid base64");
    const bytes = Buffer.from(encoded, "base64");
    if (bytes.length > MAX_BYTES || bytes.length !== item.size || blobSha(bytes) !== entry.sha)
      throw new Error("Blob verification failed");
    const text = new TextDecoder("utf-8", { fatal: true }).decode(bytes);
    messages.push({ name: entry.name, sha: entry.sha, text });
  }
  return messages;
}

export async function writeReply(c: MailboxConfig, markdown: string): Promise<string> {
  if (!markdown || Buffer.byteLength(markdown, "utf8") > MAX_BYTES) throw new Error("Invalid reply size");
  const path = `${ROOT}/JARVIS-REPLY.md`;
  let sha: string | undefined;
  try {
    const previous = await (await github(c, path)).json();
    if (typeof previous.sha !== "string" || !/^[a-f0-9]{40}$/.test(previous.sha))
      throw new Error("Invalid previous SHA");
    sha = previous.sha;
  } catch (error) {
    if (!(error instanceof Error) || error.message !== "GitHub HTTP 404") throw error;
  }
  const response = await github(c, path, {
    method: "PUT",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({
      message: "chore(jarvis): acknowledge agent mailbox",
      content: Buffer.from(markdown, "utf8").toString("base64"),
      branch: BRANCH,
      ...(sha ? { sha } : {}),
    }),
  });
  const result = await response.json();
  if (typeof result?.commit?.sha !== "string") throw new Error("Missing write commit SHA");
  return result.commit.sha;
}
