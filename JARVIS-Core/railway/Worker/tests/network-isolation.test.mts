// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import { spawn } from "node:child_process";
import assert from "node:assert/strict";
import http from "node:http";
import net from "node:net";
import dns from "node:dns";
import { fileURLToPath } from "node:url";
const names = ["fetch_extern_blockiert","fetch_loopback_falscher_port_blockiert","fetch_loopback_freigegeben_erlaubt","socket_extern_blockiert","unix_socket_blockiert","http_request_extern_blockiert","dns_extern_blockiert"];
if(process.argv[2]==="--child"){
 const {enforceNetworkAllowlist}=await import("../src/network-isolation.ts");
 const port=Number(process.env.ALLOWED_PORT);
 enforceNetworkAllowlist([port]);
 const blocked=(e:unknown)=>/E2E_NETWORK_BLOCKED/.test(String(e));
 const rejects=async(f:()=>Promise<unknown>)=>{try{await f();return false;}catch(e){return blocked(e);}};
 const throws=(f:()=>unknown)=>{try{f();return false;}catch(e){return blocked(e);}};
 const results=[
 await rejects(()=>fetch("http://example.com/",{signal:AbortSignal.timeout(2000)})),
 await rejects(()=>fetch("http://127.0.0.1:"+(port===65535?port-1:port+1),{signal:AbortSignal.timeout(2000)})),
 await (await fetch("http://127.0.0.1:"+port,{signal:AbortSignal.timeout(2000)})).text()==="ok",
 throws(()=>net.connect({host:"93.184.216.34",port:80})),
 throws(()=>net.connect({path:"/var/run/postgresql/.s.PGSQL.5432"})),
 throws(()=>http.request({host:"example.com",port:80}).on("error",()=>{}).end()),
 throws(()=>dns.lookup("example.com",()=>{}))
 ];
 console.log(JSON.stringify(Object.fromEntries(names.map((n,i)=>[n,results[i]]))));process.exit(0);
}
const srv=http.createServer((_q,res)=>res.end("ok"));
await new Promise<void>((resolve,reject)=>{srv.once("error",reject);srv.listen(0,"127.0.0.1",resolve);});
try{
 const port=(srv.address() as net.AddressInfo).port;
 const child=await new Promise<{code:number|null,out:string,err:string}>((resolve,reject)=>{
 const c=spawn(process.execPath,[...(process.versions.bun?[]:["--experimental-transform-types"]),fileURLToPath(import.meta.url),"--child"],{env:{...process.env,ALLOWED_PORT:String(port)}});
 let out="",err="";
 const timer=setTimeout(()=>c.kill("SIGKILL"),15000);
 c.stdout.on("data",d=>out+=d);c.stderr.on("data",d=>err+=d);
 c.once("error",e=>{clearTimeout(timer);reject(e);});
 c.once("close",code=>{clearTimeout(timer);resolve({code,out,err});});
 });
 assert.equal(child.code,0,child.err);
 const results=JSON.parse(child.out.trim().split("\n").pop()!);
 assert.deepEqual(Object.keys(results).sort(),[...names].sort());
 for(const n of names){assert.equal(results[n],true,n);console.log("PASS "+n);}
}finally{srv.close();}
