// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import { spawn } from "node:child_process";
export function startWorker(cmd,args,env={},cwd) {
 const child=spawn(cmd,args,{cwd,env:{...env},stdio:["ignore","pipe","pipe"]});
 let out="",err="",exit=null;
 const watchers=new Set();
 const notify=()=>{for(const w of watchers)w();};
 const exited=new Promise(resolve=>{
  const finish=(result)=>{if(exit)return;exit=result;resolve(result);notify();};
  child.once("error",error=>finish({code:null,signal:null,error:String(error)}));
  child.once("close",(code,signal)=>finish({code,signal}));
 });
 child.stdout.on("data",d=>{out+=d;notify();});
 child.stderr.on("data",d=>{err+=d;});
 return {child,exited,output:()=>out,stderr:()=>err,
 waitFor(marker,timeoutMs=30000){return new Promise((resolve,reject)=>{
  const finish=(error)=>{clearTimeout(timer);watchers.delete(check);error?reject(error):resolve();};
  const check=()=>{if(out.includes(marker))finish();else if(exit)finish(new Error("WORKER_EXITED_EARLY "+JSON.stringify(exit)+" before "+marker+"\nstderr: "+err.slice(-800)));};
  const timer=setTimeout(()=>finish(new Error("TIMEOUT waiting for "+marker+"\nstdout: "+out.slice(-500)+"\nstderr: "+err.slice(-800))),timeoutMs);
  watchers.add(check);check();
 });},
 async kill9(){if(!exit)child.kill("SIGKILL");return exited;}
 };
}
