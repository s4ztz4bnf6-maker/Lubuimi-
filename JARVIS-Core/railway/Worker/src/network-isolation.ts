// SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
import net from "node:net";
import dns from "node:dns";
export function enforceNetworkAllowlist(ports:number[]){
 const allowed=new Set(ports);
 const loop=new Set(["127.0.0.1","::1","[::1]"]);
 const deny=(what:string):never=>{throw Error("E2E_NETWORK_BLOCKED "+what);};
 const check=(host:string,port:number)=>{if(!loop.has(host)||!allowed.has(Number(port)))deny(host+":"+port);};
 const originalFetch=globalThis.fetch;
 const originalConnect=net.Socket.prototype.connect;
 const originalLookup=dns.lookup;
 globalThis.fetch=(async(input:any,init?:any)=>{
 const u=new URL(typeof input==="string"||input instanceof URL?String(input):input.url);
 if(!["http:","https:"].includes(u.protocol))deny(u.protocol);
 check(u.hostname,Number(u.port||(u.protocol==="https:"?443:80)));
 return originalFetch(input,{...init,redirect:"error"});
 }) as typeof fetch;
 (net.Socket.prototype as any).connect=function(...args:any[]){
 const a=Array.isArray(args[0])?args[0][0]:args[0];
 if(a&&typeof a==="object"){if(a.path)deny("unix");check(a.host??"127.0.0.1",a.port);}
 else if(typeof a==="number")check(typeof args[1]==="string"?args[1]:"127.0.0.1",a);
 else deny("unix or unsupported socket");
 return originalConnect.apply(this,args as any);
 };
 (dns as any).lookup=function(host:string,...args:any[]){if(!loop.has(host))deny("dns:"+host);return (originalLookup as any).call(dns,host,...args);};
 return ()=>{globalThis.fetch=originalFetch;net.Socket.prototype.connect=originalConnect;dns.lookup=originalLookup;};
}
// Defense in depth only: native Bun, subprocesses and other transports require OS isolation.
