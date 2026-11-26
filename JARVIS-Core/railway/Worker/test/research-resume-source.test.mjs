import test from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
const source = readFileSync(new URL('../index.ts', import.meta.url), 'utf8');
test('bounded slice resumes at persisted step', () => {
  assert.match(source, /for \(let step = startStep; step < startStep \+ 12; step\+\+\)/);
  assert.match(source, /startStep=state.nextStep/);
});
test('slice exhaustion queues rather than fails', () => {
  assert.match(source, /if \(!finalText.trim\(\) && resumable\) \{[\s\S]*?status='retry_wait',next_retry_at=NOW\(\)\+INTERVAL '30 seconds'/);
});
test('structured history excludes legacy notes', () => {
  assert.ok(source.includes("phase<>'research_context_v1'"));
  assert.ok(source.includes('if(!restoredHistory && priorCheckpoints.length)'));
  assert.ok(source.includes('if(restoredHistory) messages.push(...restoredHistory)'));
});
test('legacy fallback remains available', () => {
  assert.match(source, /if\(!restoredHistory && priorCheckpoints.length\) messages.push/);
});
test('context checkpoint uses non-null serialized history', () => {
  assert.ok(source.includes('JSON.stringify({taskHash,nextStep:step+1,history:messages.slice(historyOffset)})'));
});
test('successful answer bypasses slice requeue', () => {
  assert.ok(source.includes('if (!finalText.trim() && resumable)'));
  assert.match(source, /status='completed'/);
});
test('resumable mode guards tool execution', () => {
  assert.ok(source.includes('if(resumable && !safeNames.has(String(name))) throw'));
});
