// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
export type Config={dbUrl:string;isolatedE2E:boolean;allowedPorts:number[]};
export function loadConfig(env=process.env):Config {
 const isolatedE2E=env.DJO2_E2E==="1";
 const dbUrl=env.DATABASE_URL??"";
 const allowedPorts=(env.DJO2_E2E_PORTS??"").split(",").filter(Boolean).map(Number);
 if(isolatedE2E){
 const u=new URL(dbUrl);
 if(env.CI!=="true"||!["postgres:","postgresql:"].includes(u.protocol)||u.hostname!=="127.0.0.1"||u.pathname!=="/djo2_e2e"||u.search||u.hash)throw Error("E2E_GUARD invalid isolated database");
 if(Object.keys(env).some(k=>env[k]&&/TOKEN|SECRET|API_KEY|PRIVATE_KEY|PASSWORD/i.test(k)))throw Error("E2E_GUARD unexpected credential");
 if(allowedPorts.some(p=>!Number.isInteger(p)||p<1||p>65535)||!allowedPorts.includes(Number(u.port||5432)))throw Error("E2E_GUARD invalid ports");
 }
 return {dbUrl,isolatedE2E,allowedPorts};
}
type Q=(text:string)=>Promise<{rows:any[]}>;
type SchemaModule={name:string;requires?:string[];tables:string[];ddl:string[]};
export function createSchemaRegistry(){
 const registry=new Map<string,SchemaModule>();
 return {
 registerSchema(m:SchemaModule){if(registry.has(m.name))throw Error("SCHEMA_DUPLICATE "+m.name);registry.set(m.name,m);},
 async ensureSchema(q:Q){
 const done=new Set<string>(),order:SchemaModule[]=[];
 function visit(n:string,stack:string[]=[]){if(done.has(n))return;if(stack.includes(n))throw Error("SCHEMA_CYCLE "+n);const m=registry.get(n);if(!m)throw Error("SCHEMA_MODULE_MISSING "+n);for(const r of m.requires??[])visit(r,[...stack,n]);done.add(n);order.push(m);}
 for(const n of registry.keys())visit(n);
 for(const m of order)for(const d of m.ddl)await q(d);
 },
 async validateSchema(q:Q){const have=new Set((await q("SELECT table_name FROM information_schema.tables WHERE table_schema=current_schema()")).rows.map(r=>r.table_name));const missing=[...new Set([...registry.values()].flatMap(m=>m.tables))].filter(t=>!have.has(t));if(missing.length)throw Error("SCHEMA_INCOMPLETE "+missing.join(", "));}
 };
}
export async function crashPoint(name:string,config:Config,env=process.env){
 if(config.isolatedE2E&&env.DJO2_CRASH_AT===name){console.log("DJO2_BOUNDARY "+name);await new Promise(()=>{setInterval(()=>{},1000);});}
}
type Deps={enforceIsolation(c:Config):Promise<void>;initializeDatabase(c:Config):Promise<void>;validateSchema(c:Config):Promise<void>;createWorker(c:Config):{run():Promise<void>};initializeBusinessServices(c:Config):Promise<void>;startBackgroundSchedulers(c:Config):Promise<void>};
export async function main(deps:Deps,env=process.env){
 const c=loadConfig(env);
 if(c.isolatedE2E)await deps.enforceIsolation(c);
 await deps.initializeDatabase(c);await deps.validateSchema(c);
 const worker=deps.createWorker(c);
 if(!c.isolatedE2E){await deps.initializeBusinessServices(c);await deps.startBackgroundSchedulers(c);}
 console.log("DJO2_READY");await worker.run();
}
