// SPDX-License-Identifier: Apache-2.0
import {test,expect} from "bun:test";
import {optimize,type Leg} from "./global-logistics";
const leg=(from:string,to:string,minor:number,departAt=10,arriveAt=20):Leg=>({from,to,minor,departAt,arriveAt,provider:"synthetic",currency:"EUR",expiresAt:100,verified:true,eligible:true,shipmentId:"test"});
for(const [a,b] of [["US","KE"],["SA","ML-Timbuktu"],["MA","CA-Nunavut"],["JP","BR"],["AU","SN"]]){
 test(a+" to "+b,()=>{
 const result=optimize([leg(a,b,9000),leg(a,"hub",2000),leg("hub",b,3000,21,30)],a,b,"EUR","test",0,90);
 expect(result?.cost).toBe(5000);expect(result?.total).toBe(5500);expect(result?.bookable).toBe(false);
 });
}
test("reject disconnected, expired, ineligible and wrong currency",()=>{
 expect(optimize([{...leg("A","B",1),expiresAt:0},{...leg("A","B",1),eligible:false},{...leg("A","B",1),currency:"USD"},leg("A","C",1)],"A","B","EUR","test",0,90)).toBeNull();
});
test("reject impossible handoff",()=>expect(optimize([leg("A","H",1),leg("H","B",1,15,25)],"A","B","EUR","test",0,90)).toBeNull());
