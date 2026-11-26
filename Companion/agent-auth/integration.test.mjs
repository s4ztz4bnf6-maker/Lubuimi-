import {test} from 'node:test';
import assert from 'node:assert/strict';
import {createHash} from 'node:crypto';
import {createCompanionAuth} from './integration.mjs';
const origin='https://companion.example';
test('isolated request lifecycle',async()=>{
 const rows=new Map();
 const sessionHash=createHash('sha256').update('owner-session').digest('hex');
 const sql={unsafe:async(q,p)=>{
  if(q==='test schema')return [];
  if(q.startsWith('SELECT 1 FROM jarvis_sessions'))return p[0]===sessionHash?[{ok:1}]:[];
  if(q.startsWith('INSERT INTO djo2_agent_credentials')){rows.set(p[0],{token_hash:p[0],scopes:p[1],expires_at:p[2],revoked:false});return [];}
  if(q.startsWith('SELECT token_hash'))return rows.has(p[0])?[rows.get(p[0])]:[];
  throw Error('unexpected SQL');
 }};
 const handle=await createCompanionAuth({sql,origin,schema:'test schema',originalFetch:()=>new Response('original')});
 const issue=(o=origin,c='owner-session',scopes=['agent:read'])=>handle(new Request(origin+'/api/agent-auth/issue',{method:'POST',headers:{origin:o,cookie:'jarvis_session='+c,'content-type':'application/json'},body:JSON.stringify({scopes})}));
 assert.equal((await issue('https://evil.example')).status,403);
 assert.equal((await issue(origin,'invalid')).status,403);
 assert.equal((await issue(origin,'owner-session',['agent:execute'])).status,403);
 const issued=await issue();assert.equal(issued.status,201);
 const {token}=await issued.json();
 const header={authorization:'Bearer '+token};
 const request=(path,headers=header)=>handle(new Request(origin+path,{headers}));
 assert.equal((await request('/api/agent-auth/status',{})).status,401);
 assert.equal((await request('/api/agent-auth/status',{authorization:'Bearer '+'0'.repeat(64)})).status,401);
 const valid=await request('/api/agent-auth/status');assert.equal(valid.status,200);assert.equal((await valid.json()).spendAllowed,false);
 assert.equal((await request('/api/approvals/pending')).status,403);
 assert.equal((await request('/api/agent-auth/spend')).status,403);
 assert.equal(await (await request('/',{})).text(),'original');
 const row=[...rows.values()][0];assert.ok(!JSON.stringify(row).includes(token));
 row.revoked=true;assert.equal((await request('/api/agent-auth/status')).status,401);
 row.revoked=false;row.expires_at=new Date(0);assert.equal((await request('/api/agent-auth/status')).status,401);
});
