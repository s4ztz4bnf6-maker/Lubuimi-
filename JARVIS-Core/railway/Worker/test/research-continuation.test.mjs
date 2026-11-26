import { test } from "node:test";
import assert from "node:assert/strict";
import { planeFortsetzung } from "../research-resume.mjs";

function fixture(checkpoint, updated = true, hash = 'abc') {
  const calls = [];
  const sql = async (strings, ...params) => {
    const query = strings.join("?");
    calls.push({ query, params });
    if (query.includes("research_context_v1")) return checkpoint === undefined ? [] : [{note: JSON.stringify({nextStep: checkpoint, taskHash: hash})}];
    assert.match(query, /WHERE id=\? AND status='running'/);
    return updated ? [{id: 1}] : [];
  };
  return {calls, sql, taskHash: 'abc'};
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

for (const [label, hash, step] of [["mismatch","other",7],["missing",null,7],["hash before step","other",-1]]) {
  test("ignores checkpoint: "+label, async () => {
    const f = fixture(step,true,hash);
    const r = await planeFortsetzung(1,null,"etappe",30000,f);
    assert.equal(r.scheduled,false);
    assert.equal(r.step,null);
    assert.equal(f.calls.some(c=>c.query.includes("UPDATE")),false);
  });
}
test("missing current hash fails closed", async () => {
  const f = fixture(7);
  const r = await planeFortsetzung(1,null,"etappe",30000,{sql:f.sql});
  assert.equal(r.scheduled,false);
  assert.equal(f.calls.length,1);
});
