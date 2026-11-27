import test from "node:test";
import assert from "node:assert/strict";
import {readFile} from "node:fs/promises";
import {executeAuthorizedGitHubDelivery} from "../github-commercial-delivery.mjs";
test("worker GitHub dispatch uses mandatory migration guard rather than direct dispatcher",async()=>{
 const source=await readFile(new URL("../index.ts",import.meta.url),"utf8");
 assert.match(source,/import \{ executeAuthorizedGitHubDelivery \} from "\.\/github-commercial-delivery\.mjs";/);
 const branches=[...source.matchAll(/else if\(name==="github_delivery"\)\{([\s\S]*?)else if\(name==="github_delivery_readiness"\)/g)];
 assert.equal(branches.length,1);
 assert.match(branches[0][1],/result=await executeAuthorizedGitHubDelivery\(\)/);
 assert.doesNotMatch(branches[0][1],/dispatchDelivery\(|githubDelivery\(/);
 await assert.rejects(executeAuthorizedGitHubDelivery(),/MIGRATION_LOCKED_INCOMPLETE_HISTORY/);
});
