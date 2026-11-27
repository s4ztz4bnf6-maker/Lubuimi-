// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import {test,expect} from "bun:test";
import {loadConfig,createSchemaRegistry,main} from "../src/bootstrap";
const env={CI:"true",DJO2_E2E:"1",DATABASE_URL:"postgres://u:p@127.0.0.1:5432/djo2_e2e",DJO2_E2E_PORTS:"5432"};
test("E2E guard fails closed",()=>{
 expect(loadConfig(env).isolatedE2E).toBe(true);
 for(const patch of [{CI:"false"},{DATABASE_URL:"postgres://u:p@remote:5432/djo2_e2e"},{GITHUB_TOKEN:"secret"},{DJO2_E2E_PORTS:"80"}])expect(()=>loadConfig({...env,...patch})).toThrow();
});
test("schema dependencies and missing tables",async()=>{
 const r=createSchemaRegistry(),calls:string[]=[];
 r.registerSchema({name:"child",requires:["parent"],tables:["b"],ddl:["b"]});
 r.registerSchema({name:"parent",tables:["a"],ddl:["a"]});
 await r.ensureSchema(async s=>{calls.push(s);return {rows:[]};});
 expect(calls).toEqual(["a","b"]);
 await expect(r.validateSchema(async()=>({rows:[{table_name:"a"}]}))).rejects.toThrow("SCHEMA_INCOMPLETE b");
});
test("E2E skips business services",async()=>{
 const calls:string[]=[];
 await main({enforceIsolation:async()=>{calls.push("isolation");},initializeDatabase:async()=>{calls.push("db");},validateSchema:async()=>{calls.push("schema");},createWorker:()=>({run:async()=>{calls.push("run");}}),initializeBusinessServices:async()=>{calls.push("business");},startBackgroundSchedulers:async()=>{calls.push("scheduler");}},env);
 expect(calls).toEqual(["isolation","db","schema","run"]);
});

test("invalid E2E configuration never invokes startup dependencies",async()=>{
 const calls:string[]=[];
 const deps={enforceIsolation:async()=>{calls.push("isolation");},initializeDatabase:async()=>{calls.push("db");},validateSchema:async()=>{calls.push("schema");},createWorker:()=>({run:async()=>{calls.push("run");}}),initializeBusinessServices:async()=>{calls.push("business");},startBackgroundSchedulers:async()=>{calls.push("scheduler");}};
 await expect(main(deps,{...env,CI:"false"})).rejects.toThrow("E2E_GUARD");
 expect(calls).toEqual([]);
});
test("schema dependency failure precedes all DDL",async()=>{
 const r=createSchemaRegistry(),calls:string[]=[];
 r.registerSchema({name:"valid",tables:["a"],ddl:["a"]});
 r.registerSchema({name:"broken",requires:["missing"],tables:["b"],ddl:["b"]});
 await expect(r.ensureSchema(async s=>{calls.push(s);return {rows:[]};})).rejects.toThrow("SCHEMA_MODULE_MISSING missing");
 expect(calls).toEqual([]);
});
