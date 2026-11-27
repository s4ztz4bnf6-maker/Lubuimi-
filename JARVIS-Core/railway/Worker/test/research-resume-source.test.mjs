import test from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync } from 'node:fs';
const source = readFileSync(new URL('../index.ts', import.meta.url), 'utf8');
test('bounded slice resumes at persisted step', () => {
  assert.match(source, /for \(let step = startStep; step < startStep \+ 12; step\+\+\)/);
  assert.match(source, /startStep=state.nextStep/);
  assert.ok(source.includes('persistiereFortsetzungAtomar(task.id, taskHash, state.nextStep, state.history, 30000, {sql})'));
});
test('slice exhaustion queues rather than fails', () => {
  assert.match(source, /if \(!finalText.trim\(\) && resumable\) \{[\s\S]*?await persistiereFortsetzungAtomar\(/);
  assert.ok(source.includes('if (!continuation.scheduled) throw'));
  const helper = readFileSync(new URL('../research-resume.mjs', import.meta.url), 'utf8');
  assert.match(helper, /sql\.begin\(async tx =>/);
  assert.match(helper, /status='retry_wait'/);
});
test('structured history excludes legacy notes', () => {
  assert.ok(source.includes("phase<>'research_context_v1'"));
  assert.ok(source.includes('selectResearchHistory(saved?.note, taskHash)'));
  assert.ok(source.includes('if(!restoredHistory && priorCheckpoints.length)'));
  assert.ok(source.includes('if(restoredHistory) messages.push(...restoredHistory)'));
});
test('legacy fallback remains available', () => {
  assert.match(source, /if\(!restoredHistory && priorCheckpoints.length\) messages.push/);
});
test('context checkpoint uses non-null serialized history', () => {
  assert.ok(source.includes('persistiereNeuenCheckpoint(task.id, taskHash, step+1, messages.slice(historyOffset)'));
  assert.ok(source.includes('delayMs: step === startStep+11 ? 30000 : null'));
  assert.match(source, /if \(!saved\.saved\) \{ console\.warn\("DJO2_CHECKPOINT_REJECTED", String\(task\.id\), saved\.grund\); return; \}/);
  assert.ok(source.includes('if (saved.scheduled) return'));
});
test('successful answer bypasses slice requeue', () => {
  assert.ok(source.includes('if (!finalText.trim() && resumable)'));
  assert.match(source, /status='completed'/);
});
test('resumable mode guards tool execution', () => {
  assert.ok(source.includes('if(resumable && !safeNames.has(String(name))) throw'));
});
