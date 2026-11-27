import test from "node:test";
import assert from "node:assert/strict";
import {executeAuthorizedGitHubDelivery} from "../github-commercial-delivery.mjs";
test("migration lock rejects both actions before any database or transport operation",async()=>{
 let calls=0;
 const forbidden=()=>{calls++;throw Error("unexpected operation");};
 for(const action of ["claim","deliver"]){
 await assert.rejects(executeAuthorizedGitHubDelivery({sql:forbidden,execute:forbidden,isKilled:forbidden,verifyZeroSpend:forbidden,args:{repo:"org/repo",issue:2115,action},repositoryId:1001,issueId:2002,approved:true,overrideMigrationLock:true,completeHistoryVerified:true}),/MIGRATION_LOCKED_INCOMPLETE_HISTORY/);
 }
 assert.equal(calls,0);
});
