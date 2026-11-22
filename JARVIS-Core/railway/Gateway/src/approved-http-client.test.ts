import {test,expect} from "bun:test";
import {fetchApprovedPublicApi} from "./approved-http-client";
test("rejects unknown HTTP providers before any request",async()=>{
 await expect(fetchApprovedPublicApi("private_network" as any,"/v1")).rejects.toThrow("provider_not_approved");
});
test("rejects traversal and URL injection before any request",async()=>{
 for(const path of ["/../admin","//example.com","/%2e%2e/admin","/x#fragment"]){
   await expect(fetchApprovedPublicApi("github_public",path)).rejects.toThrow("unsafe_path");
 }
});
