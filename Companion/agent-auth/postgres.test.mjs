import {test} from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
import {createHash} from 'node:crypto';
import {createCompanionAuth} from './integration.mjs';
import {createAgentStore} from './store.mjs';
test('real PostgreSQL lifecycle', {skip:!process.env.DJO2_TEST_DATABASE_URL}, async()=>{
 const {default:postgres}=await import('postgres');
 const url=new URL(process.env.DJO2_TEST_DATABASE_URL);
 assert.equal(url.hostname,'127.0.0.1');assert.equal(url.pathname,'/companion_auth_test');
 const sql=postgres(url.href,{max:1});
 try {
 await sql.begin(async tx=>{
 await tx.unsafe('CREATE SCHEMA djo2_runtime_test; SET LOCAL search_path TO djo2_runtime_test, pg_catalog; CREATE TABLE jarvis_sessions(token_hash text PRIMARY KEY, expires_at timestamptz)');
 const hash=createHash('sha256').update('test-owner').digest('hex');
 await tx.unsafe('INSERT INTO jarvis_sessions VALUES ($1,NULL)',[hash]);
 const origin='https://companion.example';
 const handle=await createCompanionAuth({sql:tx,origin,schema:await readFile(new URL('./schema.sql',import.meta.url),'utf8'),originalFetch:()=>new Response('original')});
 const issued=await handle(new Request(origin+'/api/agent-auth/issue',{method:'POST',headers:{origin,cookie:'jarvis_session=test-owner','content-type':'application/json'},body:JSON.stringify({scopes:['agent:read']})}));
 assert.equal(issued.status,201);
 const {token}=await issued.json();const header='Bearer '+token;
 const store=createAgentStore(tx);
 assert.equal((await store.authorize(header,'agent:read')).status,200);
 assert.equal((await store.authorize(header,'agent:execute')).status,403);
 assert.equal((await store.authorize(header,'agent:read',{requiresSpend:true})).status,403);
 const digest=createHash('sha256').update(token).digest('hex');
 await tx.unsafe('UPDATE djo2_agent_credentials SET expires_at=now()-interval \'1 second\' WHERE token_hash=$1',[digest]);
 assert.equal((await store.authorize(header,'agent:read')).status,401);
 await tx.unsafe('UPDATE djo2_agent_credentials SET expires_at=now()+interval \'1 hour\' WHERE token_hash=$1',[digest]);
 await store.revoke(digest);assert.equal((await store.authorize(header,'agent:read')).status,401);
 throw new Error('intentional rollback');
 }).catch(e=>{if(e.message!=='intentional rollback')throw e;});
 const [row]=await sql.unsafe("SELECT to_regnamespace('djo2_runtime_test') IS NULL AS clean");assert.equal(row.clean,true);
 }finally{await sql.end();}
});
