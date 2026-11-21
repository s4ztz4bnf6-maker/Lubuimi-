import { test, expect } from "bun:test";
import { createHash } from "node:crypto";
import { readMailbox, writeReply } from "../src/mailbox-client";

const blob = (b: Buffer) => createHash("sha1").update(`blob ${b.length}\0`).update(b).digest("hex");
function harness(bytes: Buffer, overrides: Record<string, unknown> = {}) {
  const sha = blob(bytes);
  const fetchImpl = (async (url: string, init?: RequestInit) => {
    if (init?.method === "PUT") return Response.json({ commit: { sha: "commit123" } });
    if (url.endsWith("/JARVIS-REPLY.md?ref=jarvis-core")) return new Response("", { status: 404 });
    if (url.includes("/CHATGPT-test.md?")) return Response.json({
      type: "file", encoding: "base64", content: bytes.toString("base64"),
      sha, size: bytes.length, ...overrides,
    });
    return Response.json([{ type: "file", name: "CHATGPT-test.md", sha, size: bytes.length }]);
  }) as typeof fetch;
  return { token: "test-token", repository: "owner/repo", fetchImpl };
}
test("reads and verifies actual git blob and UTF-8", async () => {
  const messages = await readMailbox(harness(Buffer.from("Ping")));
  expect(messages).toHaveLength(1);
  expect(messages[0].text).toBe("Ping");
});
test("rejects tampered metadata", async () => {
  await expect(readMailbox(harness(Buffer.from("Ping"), { sha: "0".repeat(40) }))).rejects.toThrow();
});
test("rejects invalid UTF-8", async () => {
  await expect(readMailbox(harness(Buffer.from([0xff])))).rejects.toThrow();
});
test("rejects files exceeding limit", async () => {
  expect(await readMailbox(harness(Buffer.alloc(65_537)))).toHaveLength(0);
});
test("reads public mailbox without token", async () => {
  const messages = await readMailbox({ ...harness(Buffer.from("x")), token: "" });
  expect(messages[0].text).toBe("x");
});
test("rejects writes without token", async () => {
  await expect(writeReply({ ...harness(Buffer.from("x")), token: "" }, "ACK")).rejects.toThrow("Write requires");
});
test("writes reply using contents API", async () => {
  expect(await writeReply(harness(Buffer.from("x")), "ACK")).toBe("commit123");
});
