import postgres from 'postgres';
import {createCompanionAuth} from '../../../Companion/agent-auth/integration.mjs';
const origin=Bun.env.COMPANION_PUBLIC_ORIGIN;
if(!origin||!Bun.env.DATABASE_URL)throw new Error('Agent auth requires configured origin and database');
const sql=postgres(Bun.env.DATABASE_URL,{max:2});
const schema=await Bun.file(new URL('../../../Companion/agent-auth/schema.sql',import.meta.url)).text();
const serve=Bun.serve.bind(Bun);
let originalFetch: (req:Request,server:any)=>Response|Promise<Response>;
const wrapped=await createCompanionAuth({sql,origin,schema,originalFetch:(req:Request)=>originalFetch(req,server)});
let server:any;
Bun.serve=((options:any)=>{
 if(server||typeof options.fetch!=='function')throw new Error('Unexpected Companion server configuration');
 originalFetch=options.fetch;
 server=serve({...options,fetch:(req:Request)=>wrapped(req)});
 return server;
}) as typeof Bun.serve;
try{await import(Bun.env.DJO2_WRAPPER_TEST==='1' && Bun.env.CI==='true' ? './agent-auth-fixture.ts' : './index.ts');if(!server)throw new Error('Companion did not start');}
finally{Bun.serve=serve;}
