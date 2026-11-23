import assert from "node:assert/strict";
import {readFileSync} from "node:fs";
const companion=readFileSync(new URL("../../../JARVIS-Core/railway/Companion/index.ts",import.meta.url),"utf8");
const marker=/const quota=failures.length&&failures.every\(x=>\/(.*?)\/i.test\(x\)\)/;
const m=companion.match(marker);
assert.ok(m,"fallback classification must exist");
const classify=new RegExp(m[1],"i");
for(const error of ["Groq HTTP 429: rate limit","Gemini HTTP 503: UNAVAILABLE","Groq fallback: empty response","Provider: timeout"]){
 assert.ok(classify.test(error),error);
}
assert.equal(classify.test("HTTP 401 invalid API key"),false);
const cooldown=/const cooldownMinutes=Math.max\(3,Math.min\(60,/;
assert.match(companion,cooldown);
console.log(JSON.stringify({event:"fallback_classifier_smoke_passed",cases:5,cooldownMinimumMinutes:3}));
