import test from "node:test";
import assert from "node:assert/strict";
import {githubDelivery} from "./githubDelivery.mjs";
test.skip("historical unlocked delivery protocol (retained until migration clearance)",async t=>{
 const old=process.env.GITHUB_DELIVERY_TOKEN, original=globalThis.fetch;
 t.after(()=>{globalThis.fetch=original;if(old===undefined)delete process.env.GITHUB_DELIVERY_TOKEN;else process.env.GITHUB_DELIVERY_TOKEN=old;});
 const calls=[];let saved,started=false;
 const sql=(q,...v)=>{if(typeof q==="string")return q;const s=q.reduce((out,part,i)=>out+part+(i<v.length?String(v[i]):""),"");if(s.includes("system_flags"))return [];if(s.includes("INSERT INTO")){if(started)return [];started=true;return [{}];}if(s.includes("UPDATE")){saved=v[1];return [];}if(s.includes("SELECT status"))return [{status:"done",result:saved}];throw Error(s);};sql.json=x=>x;
 delete process.env.GITHUB_DELIVERY_TOKEN;
 globalThis.fetch=async()=>{throw Error("unexpected network");};
 await assert.rejects(githubDelivery(sql,1,"deliver",{}),/MissingDeliveryCredentials/);
 process.env.GITHUB_DELIVERY_TOKEN="mock";
 globalThis.fetch=async(url,o={})=>{
 const p=url.replace("https://api.github.com",""),m=o.method||"GET";calls.push(m+" "+p);
 const R=(status,data)=>({status,ok:status>=200&&status<300,json:async()=>data});
 if(p==="/user")return R(200,{login:"me"});
 if(p==="/repos/up/proj/issues/1")return R(200,{state:"open",number:1});
 if(p==="/repos/up/proj")return R(200,{default_branch:"main"});
 if(p==="/repos/up/proj/git/ref/heads/main")return R(200,{object:{sha:"abc"}});
 if(p==="/repos/up/proj/forks")return R(202,{full_name:"me/proj",owner:{login:"me"}});
 if(p==="/repos/me/proj/git/commits/abc")return R(200,{});
 if(p==="/repos/me/proj/git/refs")return R(201,{});
 if(p==="/repos/me/proj/contents/a.txt?ref=h")return R(200,{encoding:"base64",content:"eA=="});
 if(p.startsWith("/repos/me/proj/contents/a.txt"))return R(m==="GET"?404:201,{});
 if(p==="/repos/up/proj/pulls"&&m==="POST"){assert.equal(JSON.parse(o.body).head,"me:djo2-task-1");return R(201,{number:7,head:{sha:"h"}});}
 if(p==="/repos/up/proj/pulls/7")return R(200,{number:7,html_url:"https://github.com/up/proj/pull/7",head:{sha:"h"},state:"open",user:{login:"me"},base:{repo:{full_name:"up/proj"}},body:"B\n\nRefs #1\n<!-- djo2-task:1 -->"});
 throw Error("unexpected mock request "+m+" "+p);
 };
 const args={repo:"up/proj",issue:1,files:[{path:"a.txt",content:"x"}],title:"T",body:"B"};
 const r=await githubDelivery(sql,1,"deliver",args);assert.equal(r.status,"done");assert.equal(r.result.number,7);
 assert.ok(calls.indexOf("POST /repos/up/proj/forks")<calls.indexOf("POST /repos/me/proj/git/refs"));
 assert.ok(calls.indexOf("PUT /repos/me/proj/contents/a.txt")<calls.indexOf("POST /repos/up/proj/pulls"));
 const replay=await githubDelivery(sql,1,"deliver",args);assert.equal(replay.status,"replayed");assert.equal(calls.filter(x=>x==="POST /repos/up/proj/pulls").length,1);
});

// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {runToolOnce} from "./providerRotationDb.mjs";
test("legacy delivery fails closed before network or database access",async t=>{
 const original=globalThis.fetch;
 t.after(()=>{globalThis.fetch=original;});
 let calls=0;
 globalThis.fetch=async()=>{calls++;throw Error("unexpected network");};
 const sql=()=>{calls++;throw Error("unexpected database");};
 for(const action of ["claim","deliver"]){
  await assert.rejects(githubDelivery(sql,1,action,{migrationComplete:true}),/MIGRATION_LOCKED_INCOMPLETE_HISTORY/);
 }
 assert.equal(calls,0);
});
test("database effect replay does not repeat external callback",async()=>{
 let started=false,saved,calls=0;
 const sql=(q,...v)=>{
  if(typeof q==="string")return q;
  const query=q.join(" ");
  if(query.includes("system_flags")||v.includes("public.djo2_system_flags"))return [];
  if(query.includes("INSERT INTO")){if(started)return [];started=true;return [{}];}
  if(query.includes("UPDATE")){saved=v[1];return [];}
  if(query.includes("SELECT status"))return [{status:"done",result:saved}];
  throw Error(query);
 };
 sql.json=x=>x;
 const exec=async()=>{calls++;return {number:7};};
 const first=await runToolOnce(sql,1,"fixture",{issue:1},exec);
 const second=await runToolOnce(sql,1,"fixture",{issue:1},exec);
 assert.equal(first.status,"done");assert.equal(second.status,"replayed");assert.deepEqual(second.result,{number:7});assert.equal(calls,1);
});
