import { test } from "node:test";
import assert from "node:assert/strict";
import { planeFortsetzung } from "../research-resume.mjs";

function fixture(checkpoint, updated = true) {
  const calls = [];
  const sql = async (strings, ...params) => {
    const query = strings.join("?");
    calls.push({ query, params });
    if (query.includes("research_context_v1")) return checkpoint === undefined ? [] : [{note: JSON.stringify({nextStep: checkpoint})}];
    assert.match(query, /WHERE id=\? AND status='running'/);
    return updated ? [{id: 1}] : [];
  };
  return {calls, sql};
}
test("restores nextStep", async () => {
  const f = fixture(7);
  const r = await planeFortsetzung(1,null,"etappe",30000,f);
  assert.equal(r.step,7);
  assert.equal(r.scheduled,true);
  assert.equal(f.calls.length,2);
});
for (const value of [-1,"abc"]) {
  test("rejects invalid nextStep: "+value, async () => {
    const f = fixture(value);
    await assert.rejects(()=>planeFortsetzung(1,null,"etappe",30000,f), /Invalid checkpoint resume step/);
    assert.equal(f.calls.some(c=>c.query.includes("UPDATE")),false);
  });
}
test("missing checkpoint never updates", async () => {
  const f = fixture(undefined);
  const r = await planeFortsetzung(1,null,"etappe",30000,f);
  assert.equal(r.scheduled,false);
  assert.equal(f.calls.some(c=>c.query.includes("UPDATE")),false);
});
test("non-running task is not scheduled", async () => {
  const f = fixture(5,false);
  const r = await planeFortsetzung(1,null,"etappe",30000,f);
  assert.equal(r.scheduled,false);
  assert.equal(f.calls.length,2);
});
