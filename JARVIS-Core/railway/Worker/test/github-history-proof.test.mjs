import test from "node:test";
import assert from "node:assert/strict";
import {retrieveGitHubMapping} from "../github-history-proof.mjs";
const input={repositoryId:123,issueId:456,repo:"org/repo",issue:12};
const repository={id:123,full_name:"org/repo"};
const issue={id:456,number:12,repository_url:"https://api.github.com/repos/org/repo"};
test("history verifier retrieves exact GitHub repository and issue identities",async t=>{
 const calls=[];
 t.mock.method(globalThis,"fetch",async(url,options)=>{
 calls.push(url);assert.equal(options.redirect,"error");
 return {ok:true,json:async()=>calls.length===1?repository:issue};
 });
 assert.deepEqual(await retrieveGitHubMapping(input),{...input,verified:true});
 assert.deepEqual(calls,["https://api.github.com/repos/org/repo","https://api.github.com/repos/org/repo/issues/12"]);
});
test("history verifier blocks mismatched identities and unavailable evidence",async t=>{
 let responses=[];
 t.mock.method(globalThis,"fetch",async()=>{const value=responses.shift();if(value instanceof Error)throw value;return {ok:value!==null,json:async()=>value};});
 for(const pair of [[{...repository,id:124},issue],[repository,{...issue,id:457}],[repository,{...issue,number:13}],[repository,{...issue,repository_url:"https://api.github.com/repos/other/repo"}],[repository,{...issue,pull_request:{}}],[null],[new Error("network")]]){
 responses=[...pair];await assert.rejects(retrieveGitHubMapping(input));
 }
 await assert.rejects(retrieveGitHubMapping({...input,repositoryId:"123"}));
});

test("history verifier rejects missing and type-confused API fields",async t=>{
 let responses=[];
 t.mock.method(globalThis,"fetch",async()=>({ok:true,json:async()=>responses.shift()}));
 for(const pair of [[{},issue],[{...repository,id:"123"},issue],[{...repository,full_name:undefined},issue],[repository,{}],[repository,{...issue,id:"456"}],[repository,{...issue,number:"12"}],[repository,{...issue,repository_url:undefined}],[repository,null]]){
 responses=[...pair];await assert.rejects(retrieveGitHubMapping(input));
 }
});
