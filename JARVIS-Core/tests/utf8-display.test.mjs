import test from "node:test";
import assert from "node:assert/strict";
import { readFile } from "node:fs/promises";

const root = new URL("../", import.meta.url);

test("German Companion prompt contains no replacement characters and preserves umlauts", async () => {
  const source = await readFile(new URL("railway/Companion/index.ts", root), "utf8");
  assert.equal(source.includes("\uFFFD"), false, "Companion source must not contain U+FFFD replacement characters");
  assert.match(source, /Geschäftsführungsbefugnis/);
  assert.match(source, /Zeichnungsberechtigter/);
  assert.match(source, /MIDAO/);
  assert.match(source, /verifyJarvisLegalIdentity/);
  assert.match(source, /NOT_VERIFIED/);
});

test("Companion and LAIC HTTP responses explicitly declare UTF-8", async () => {
  const companion = await readFile(new URL("railway/Companion/index.ts", root), "utf8");
  const laic = await readFile(new URL("laic-service/server.mjs", root), "utf8");
  assert.match(companion, /<meta charset='utf-8'>/i);
  assert.match(companion, /text\/html; charset=utf-8/i);
  assert.match(companion, /application\/json; charset=utf-8/i);
  assert.match(laic, /application\/json; charset=utf-8/i);
});
