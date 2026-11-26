// Internal regression tests; no production database or external calls.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
const source = readFileSync(new URL('../index.ts', import.meta.url), 'utf8');
test('execution boundary precedes model invocation', () => {
  const start = source.indexOf('async function processTask(');
  assert.ok(start >= 0);
  const body = source.slice(start);
  const boundary = body.indexOf('"execution_boundary"');
  const invocation = body.indexOf('await ask(messages, tools');
  assert.ok(boundary >= 0 && invocation > boundary);
});
test('result-ready checkpoint precedes task completion', () => {
  const body = source.slice(source.indexOf('async function processTask('));
  const ready = body.indexOf('"result_ready"');
  const complete = body.indexOf("UPDATE agent_tasks SET status='completed'");
  assert.ok(ready >= 0 && complete > ready);
});
test('existing external effect guards remain wired', () => {
  assert.match(source, /await runToolOnce\(sql,task\.id/);
  assert.match(source, /await dispatchDelivery\(\{sql,taskId:task\.id/);
});
